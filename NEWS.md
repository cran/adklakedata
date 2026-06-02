# adklakedata 0.7.1

- The package now presents data for only the 28 original AEAP+ALTM lakes, matching the scope of Farrell et al. 2018. The figshare archive (doi:10.6084/m9.figshare.32305479) still contains records for 25 additional ALTM-only lakes; those rows are filtered out by `adk_data()` for consistency with the published dataset. No changes to the archive itself.

# adklakedata 0.7.0

## Data updates

- **Water chemistry through October 2024.** Records 2013-present sourced from the USGS AQ Samples database (https://waterdata.usgs.gov/download-samples/). The Adirondack Long-Term Monitoring (ALTM) program continues to be processed by the ALSC laboratory; the data pipeline now goes through USGS rather than the original ALSC archive. Mapping validated against 2012 overlap with the published dataset (correlation >= 0.989 for all 20 analytes, mean difference < 1.6%).
- **25 additional ALTM-only lakes** added: Arbutus, Avalanche, Barnes, Black (Paul Smiths), Bubb, Clear (N Hudson), East Copperas, Grass (St Regis), Heart, Hope, Lake Colden, Little Clear, Little Echo, Little Hope, Little Simon, Lost, Marcy, Middle (Floodwood), Muskrat, Nate, Otter, Otter (unnamed), Owen, Sochia, Sunday. These lakes have chem and nutrient records 1992-2024 but no biological, Secchi, or profile data.
- **Nutrients table extended** with USGS-ALTM records 1992-2024. The values in nutrients.csv now come from two different sampling protocols; use the new `program` column to filter.
- **DOI for the new data archive:** https://doi.org/10.6084/m9.figshare.32305479

## Schema changes

- `waterchem.csv`: new column `surface.temp.C` (water temperature at time of sample, °C; available for ~10% of rows, all post-2006).
- `nutrients.csv`: new columns `UV254.AU.cm` (UV absorbance at 254 nm, AU/cm; ALTM only) and `program` (`AEAP` or `ALTM`).
- `lake_characteristics.csv`: new column `data.availability` (`AEAP+ALTM` for the original 28 lakes with full coverage; `ALTM` for the 25 lakes added in v0.7.0 with chem and nutrients only).
- The 25 new lakes have lat/lon in lake_characteristics.csv but other morphology fields are NA.
- AEAP-era rows in nutrients.csv have `UV254.AU.cm = NA` and `program = "AEAP"`.

## Not updated in v0.7.0

The following tables still cover only the original 28 lakes through 2012:

- `temp_do_profiles.csv` (AEAP profiles)
- `secchi.csv`
- `phyto.csv`, `rotifer.csv`, `crustacean.csv`
- `nldas_drivers_1979_2016.csv` (meteorology, NLDAS-2 through 2016)

## Methods notes

- Nitrate is reported as NO3- (matching the original published dataset), filtered from the USGS `as N` parallel records.
- Ammonia is reported as NH4+, filtered from the USGS `as N` parallel records.
- pH uses the ALSC air-equilibrated method (USGS analytical method id EL021), reproducing the values in the original published dataset to within rounding error. The ALSC Ross-electrode pH (EL019) typically reads ~0.13 units lower and is not used.

## Citation

If you use this data, please cite both the original paper and the v0.7.0 archive:

- Farrell, J. M., Winslow, L. A., Leach, T. H., Hahn, T., & Rose, K. C. (2018). Long-term dataset on aquatic responses to concurrent climate change and recovery from acidification. *Scientific Data*, 5, 180059. https://doi.org/10.1038/sdata.2018.59
- Farrell, J. (2025). Adirondack Long-Term Lake Data - chemistry update through 2024 (v0.7.0). figshare. https://doi.org/10.6084/m9.figshare.32305479
