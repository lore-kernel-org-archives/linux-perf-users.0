From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCHv2 2/3] perf report: Display names in s390 diagnostic
 counter sets
Date: Thu, 17 Jan 2019 11:02:28 -0300
Message-ID: <20190117140228.GK11922@kernel.org>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-3-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117093003.96287-3-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jan 17, 2019 at 10:30:02AM +0100, Thomas Richter escreveu:
> On s390 the CPU Measurement Facility diagnostic counter sets are
> displayed by counter number and value. Add the logical counter name
> in the output (if it is available). Otherwise "unknown" is shown.

Thanks, applied.
 
> Output before:
>  [root@s35lp76 perf]# ./perf report -D --stdio
>  [00000000] Counterset:0 Counters:6
>    Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
>    Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
>    Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
>  [0x000038] Counterset:1 Counters:2
>    Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
>  [0x000050] Counterset:2 Counters:16
>    Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000
> 
> Output after:
>     [root@s35lp76 perf]# ./perf report -D --stdio
> 
>  [00000000] Counterset:0 Counters:6
>      Counter:000 cpu_cycles Value:0x000000000085ec36
>      Counter:001 instructions Value:0x0000000000796c94
>      Counter:002 l1i_dir_writes Value:0x0000000000005ada
>      Counter:003 l1i_penalty_cycles Value:0x0000000000092460
>      Counter:004 l1d_dir_writes Value:0x0000000000006073
>      Counter:005 l1d_penalty_cycles Value:0x00000000001a9a73
>  [0x000038] Counterset:1 Counters:2
>      Counter:000 problem_state_cpu_cycles Value:0x000000000007c59f
>      Counter:001 problem_state_instructions Value:0x000000000002fad6
>  [0x000050] Counterset:2 Counters:16
>      Counter:000 prng_functions Value:000000000000000000
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/util/s390-sample-raw.c | 59 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index ae16c38ce296..73797bda919d 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -28,6 +28,7 @@
>  #include "config.h"
>  #include "color.h"
>  #include "s390-cpumcf-kernel.h"
> +#include "pmu-events/pmu-events.h"
>  
>  static size_t ctrset_size(struct cf_ctrset_entry *set)
>  {
> @@ -111,14 +112,61 @@ static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
>  		      te.tod_base, te.mach_type);
>  }
>  
> +/* Return starting number of a counter set */
> +static int get_counterset_start(int setnr)
> +{
> +	switch (setnr) {
> +	case CPUMF_CTR_SET_BASIC:		/* Basic counter set */
> +		return 0;
> +	case CPUMF_CTR_SET_USER:		/* Problem state counter set */
> +		return 32;
> +	case CPUMF_CTR_SET_CRYPTO:		/* Crypto counter set */
> +		return 64;
> +	case CPUMF_CTR_SET_EXT:			/* Extended counter set */
> +		return 128;
> +	case CPUMF_CTR_SET_MT_DIAG:		/* Diagnostic counter set */
> +		return 448;
> +	default:
> +		return -1;
> +	}
> +}
> +
> +/* Scan the PMU table and extract the logical name of a counter from the
> + * PMU events table. Input is the counter set and counter number with in the
> + * set. Construct the event number and use this as key. If they match return
> + * the name of this counter.
> + * If no match is found a NULL pointer is returned.
> + */
> +static const char *get_counter_name(int set, int nr, struct pmu_events_map *map)
> +{
> +	int rc, event_nr, wanted = get_counterset_start(set) + nr;
> +
> +	if (map) {
> +		struct pmu_event *evp = map->table;
> +
> +		for (; evp->name || evp->event || evp->desc; ++evp) {
> +			if (evp->name == NULL || evp->event == NULL)
> +				continue;
> +			rc = sscanf(evp->event, "event=%x", &event_nr);
> +			if (rc == 1 && event_nr == wanted)
> +				return evp->name;
> +		}
> +	}
> +	return NULL;
> +}
> +
>  static void s390_cpumcfdg_dump(struct perf_sample *sample)
>  {
>  	size_t i, len = sample->raw_size, offset = 0;
>  	unsigned char *buf = sample->raw_data;
>  	const char *color = PERF_COLOR_BLUE;
>  	struct cf_ctrset_entry *cep, ce;
> +	struct pmu_events_map *map;
> +	struct perf_pmu pmu;
>  	u64 *p;
>  
> +	memset(&pmu, 0, sizeof(pmu));
> +	map = perf_pmu__find_map(&pmu);
>  	while (offset < len) {
>  		cep = (struct cf_ctrset_entry *)(buf + offset);
>  
> @@ -135,12 +183,13 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
>  
>  		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
>  			      " Counters:%d\n", offset, ce.set, ce.ctr);
> -		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; i += 2, p += 2)
> +		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
> +			const char *ev_name = get_counter_name(ce.set, i, map);
> +
>  			color_fprintf(stdout, color,
> -				      "\tCounter:%03d Value:%#018lx"
> -				      " Counter:%03d Value:%#018lx\n",
> -				      i, be64_to_cpu(*p),
> -				      i + 1, be64_to_cpu(*(p + 1)));
> +				      "\tCounter:%03d %s Value:%#018lx\n", i,
> +				      ev_name ?: "<unknown>", be64_to_cpu(*p));
> +		}
>  		offset += ctrset_size(&ce);
>  	}
>  }
> -- 
> 2.14.3

-- 

- Arnaldo
