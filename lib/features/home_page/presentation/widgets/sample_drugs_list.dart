import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect/core/context_ext.dart';
import 'package:pharma_connect/core/styles/app_colors.dart';
import 'package:pharma_connect/features/home_page/model/sample_drug.dart';
import 'package:pharma_connect/features/home_page/presentation/bloc/sample_drugs/sample_drugs_cubit.dart';

class SampleDrugsList extends StatelessWidget {
  const SampleDrugsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sample Drugs',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          'List of drugs assigned to you',
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.slateGrey,
          ),
        ),
        BlocBuilder<SampleDrugsCubit, SampleDrugsState>(
          builder: (_, state) {
            return state.maybeWhen(
              orElse: () => Center(child: CircularProgressIndicator()),
              success:
                  (data) => GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 12.0),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .9,
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: data.length,
                    itemBuilder:
                        (_, index) => _SampleDrugWidget(
                          drug: data.elementAt(index),
                          index: index,
                        ),
                  ),
            );
          },
        ),
      ],
    );
  }
}

class _SampleDrugWidget extends StatelessWidget {
  const _SampleDrugWidget({required this.drug, required this.index});

  final SampleDrug drug;
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
            children: [
              Container(
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
              ),
              Center(
                child: Image.network(
                  drug.image,
                  height: 80,
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        ),
        Text(
          drug.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ],
    );
  }
}
