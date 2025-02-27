import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/core.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/features/home_page/presentation/bloc/sample_drugs/sample_drugs_cubit.dart';
import 'package:pharma_connect/features/home_page/presentation/product_details_view.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/gridview_loading.dart';

class GridListWidget extends StatelessWidget {
  const GridListWidget({super.key, this.id});

  final String? id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SampleDrugsCubit, SampleDrugsState>(
      builder: (_, state) {
        return state.maybeWhen(
          orElse: () => Center(child: CircularProgressIndicator()),
          loading: () => GridViewLoading(),
          success: (list) {
            final data = [...list];
            if (id != null) {
              data.removeWhere((e) => e.name == id);
            }
            return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 12.0),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .9,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: id != null ? 2 : data.length,
              itemBuilder: (_, index) {
                final drug = data.elementAt(index);
                return _SampleDrugWidget(
                  onTap:
                      () => context.goToPage(
                        ProductDetailsView.fetchDetails(context, drug),
                      ),
                  drug: drug,
                  index: index,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _SampleDrugWidget extends StatelessWidget {
  const _SampleDrugWidget({
    required this.drug,
    required this.index,
    this.onTap,
  });

  final SampleDrug drug;
  final VoidCallback? onTap;
  final int index;

  Color get bgColor {
    const colors = [
      AppColors.mistyRose,
      AppColors.butterCream,
      AppColors.babyBlue,
      AppColors.paleMint,
    ];
    return colors[index % colors.length];
  }

  Color get textBgColor {
    const colors = [
      AppColors.lightPink,
      AppColors.lightButter,
      AppColors.skyBlue,
      AppColors.mintGreen,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              padding: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(39),
                  bottomLeft: Radius.circular(39),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [_buildUnits(context), _buildImage()],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: onTap,
                child: Hero(tag: drug.id, child: _navIcon()),
              ),
            ),
          ],
        ),
        _drugNameWidget(),
      ],
    );
  }

  Text _drugNameWidget() {
    return Text(
      drug.name,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
    );
  }

  Widget _buildImage() {
    return Center(
      child: Image.network(
        drug.image,
        height: 80,
        fit: BoxFit.fill,
        alignment: Alignment.bottomCenter,
        loadingBuilder: imageLoadingBuilder,
      ),
    );
  }

  Widget _buildUnits(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textBgColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      padding: EdgeInsets.only(right: 8.0, left: 4),
      child: Text(
        'Alloted: ${drug.units} units',
        style: context.textTheme.labelSmall?.copyWith(
          color: AppColors.charcoalGrey,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _navIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF10676E),
        border: Border.all(width: 0, color: Color(0xFF10676E)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(4.0),
      child: Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 12),
    );
  }
}
