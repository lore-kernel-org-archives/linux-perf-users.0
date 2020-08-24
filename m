From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] Fix s390x compile error on F32 utils/stat-display.c
Date: Mon, 24 Aug 2020 16:44:35 +0200
Message-ID: <0f9ef383-0d1c-1b19-83e5-5f946f1b301d@linux.ibm.com>
References: <20200722092053.22345-1-tmricht@linux.ibm.com>
 <20200812112708.GA13995@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200812112708.GA13995@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo, Jin, Jiri

any update on this issue?

Thanks.

On 8/12/20 1:27 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 22, 2020 at 11:20:53AM +0200, Thomas Richter escreveu:
>> Fix a compile error on F32 and gcc version 10.1 on s390 in file
>> utils/stat-display.c.  The error does not show up with make DEBUG=y.
>> In fact the issue shows up when using both compiler options
>> -O6 and -D_FORTIFY_SOURCE=2 (which are omitted with DEBUG=Y).
>>
>> This is the offending call chain:
>> print_counter_aggr()
>>   printout(config, -1, 0, ...)  with 2nd parm id set to -1
>>     aggr_printout(config, x, id --> -1, ...) which leads to this code:
>> 		case AGGR_NONE:
>>                 if (evsel->percore && !config->percore_show_thread) {
>>                         ....
>>                 } else {
>>                         fprintf(config->output, "CPU%*d%s",
>>                                 config->csv_output ? 0 : -7,
>>                                 evsel__cpus(evsel)->map[id],
>> 				                        ^^ id is -1 !!!!
>>                                 config->csv_sep);
>>                 }
>>
>> This is a compiler inlining issue which is detected on s390 but not on
>> other plattforms.
> 
> What is the sequence of events that gets to this? I.e. is it valid to
> get a config->aggr_mode == AGGR_NONE, then have evsel not be percore and
> config->percore_show_thread to be false?
> 
> I wonder if this won't be papering over some bug :-\
> 
> Jin?
> 
> This is where this came from:
> commit 4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c (tag: perf-core-for-mingo-5.2-20190517)
> Author: Jin Yao <yao.jin@linux.intel.com>
> Date:   Fri Apr 12 21:59:49 2019 +0800
> 
>     perf stat: Support 'percore' event qualifier
> 
>     With this patch, we can use the 'percore' event qualifier in perf-stat.
> 
> ---
> 
> Also please add at least Jiri and Namhyung on the CC list, having the
> person that added that array usage also helps.
> 
> [acme@quaco perf]$ scripts/get_maintainer.pl tools/perf | grep reviewer
> Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
> Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
> Jiri Olsa <jolsa@redhat.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
> Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
> [acme@quaco perf]$
> 
> Thanks,
> 
> - Arnaldo
>  
>> Output before:
>>  # make util/stat-display.o
>>     .....
>>
>>   util/stat-display.c: In function ‘perf_evlist__print_counters’:
>>   util/stat-display.c:121:4: error: array subscript -1 is below array
>>       bounds of ‘int[]’ [-Werror=array-bounds]
>>   121 |    fprintf(config->output, "CPU%*d%s",
>>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   122 |     config->csv_output ? 0 : -7,
>>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   123 |     evsel__cpus(evsel)->map[id],
>>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   124 |     config->csv_sep);
>>       |     ~~~~~~~~~~~~~~~~
>>   In file included from util/evsel.h:13,
>>                  from util/evlist.h:13,
>>                  from util/stat-display.c:9:
>>   /root/linux/tools/lib/perf/include/internal/cpumap.h:10:7:
>>   note: while referencing ‘map’
>>    10 |  int  map[];
>>       |       ^~~
>>   cc1: all warnings being treated as errors
>>   mv: cannot stat 'util/.stat-display.o.tmp': No such file or directory
>>   make[3]: *** [/root/linux/tools/build/Makefile.build:97: util/stat-display.o]
>>   Error 1
>>   make[2]: *** [Makefile.perf:716: util/stat-display.o] Error 2
>>   make[1]: *** [Makefile.perf:231: sub-make] Error 2
>>   make: *** [Makefile:110: util/stat-display.o] Error 2
>>   [root@t35lp46 perf]#
>>
>> Output after:
>>   # make util/stat-display.o
>>     .....
>>   CC       util/stat-display.o
>>   [root@t35lp46 perf]#
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/util/stat-display.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 57d0706e1330..e49e544188e4 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -118,10 +118,11 @@ static void aggr_printout(struct perf_stat_config *config,
>>  				config->csv_output ? 0 : -3,
>>  				cpu_map__id_to_cpu(id), config->csv_sep);
>>  		} else {
>> -			fprintf(config->output, "CPU%*d%s",
>> -				config->csv_output ? 0 : -7,
>> -				evsel__cpus(evsel)->map[id],
>> -				config->csv_sep);
>> +			if (id > -1)
>> +				fprintf(config->output, "CPU%*d%s",
>> +					config->csv_output ? 0 : -7,
>> +					evsel__cpus(evsel)->map[id],
>> +					config->csv_sep);
>>  		}
>>  		break;
>>  	case AGGR_THREAD:
>> -- 
>> 2.26.2
>>
> 


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
