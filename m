From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf stat: Fix s390x compile error on F32
 utils/stat-display.c
Date: Tue, 25 Aug 2020 09:14:42 +0200
Message-ID: <20200825071442.GB631468@krava>
References: <20200825063304.77733-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200825063304.77733-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 25, 2020 at 08:33:04AM +0200, Thomas Richter wrote:

SNIP

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 57d0706e1330..cbe836649f84 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
>  				cpu_map__id_to_die(id),
>  				config->csv_output ? 0 : -3,
>  				cpu_map__id_to_cpu(id), config->csv_sep);
> -		} else {
> +		} else if (id > -1)
>  			fprintf(config->output, "CPU%*d%s",
>  				config->csv_output ? 0 : -7,
>  				evsel__cpus(evsel)->map[id],
>  				config->csv_sep);
> -		}

I think we want multiple if lines within  { } but
scripts/checkpatch.pl does not scream about this,
so leaving this to Arnaldo ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  		break;
>  	case AGGR_THREAD:
>  		fprintf(config->output, "%*s-%*d%s",
> -- 
> 2.26.2
> 
