From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH] perf inject: Make it possible to merge raw_syscalls:sys_enter/exit
Date: Mon, 09 May 2016 19:56:05 +0200
Message-ID: <1620913.Ds3A27bHTf@milian-kdab2>
References: <1459554637-22126-1-git-send-email-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1694036.n27UpqDuvx"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:49377 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbcEIR4M (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2016 13:56:12 -0400
In-Reply-To: <1459554637-22126-1-git-send-email-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org

--nextPart1694036.n27UpqDuvx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Arnaldo,

I think the patch below got lost, as it is not yet applied upstream and I 
never got any feedback on it. Could you please have a look at it?

Thanks

On Saturday, April 2, 2016 1:50:37 AM CEST Milian Wolff wrote:
> This makes it much more useful to report data recorded with
> `perf trace record`. E.g.:
> 
>     #include <unistd.h>
> 
>     int main()
>     {
>         sleep(1);
>         usleep(1000);
>         usleep(1);
>         return 0;
>     }
> 
>     Compile and trace it:
> 
> # gcc -g sleep.c -o ex_sleep
> # perf trace record --call-graph dwarf ex_sleep
> 
> Previously, the report is not so useful as it aggregates by the number
> of syscalls:
> 
> # perf report --stdio --show-nr-samples --show-total-period \
>               --no-children --sort sym --max-stack 1
> 
>     #
>     # Samples: 46  of event 'raw_syscalls:sys_enter'
>     # Event count (approx.): 46
>     #
>     # Overhead       Samples        Period  Symbol
>     # ........  ............  ............  ..............................
>     #
>     100.00%            46            46  [k] syscall_trace_enter_phase2
> 
>                 |--30.43%--open64
>                 |
>                 |--17.39%--_xstat
>                 |
>                 |--15.22%--mmap64
>                 |
>                 |--8.70%--mprotect
>                 |
>                 |--6.52%--__nanosleep
>                 |
>                 |--4.35%--close
>                 |
>                 |--4.35%--_fxstat
>                 |
>                 |--2.17%--_exit
>                 |
>                 |--2.17%--munmap
>                 |
>                 |--2.17%--access
>                 |
>                 |--2.17%--read
>                 |
>                 |--2.17%--brk
>                 |
>                 |--2.17%--init_tls
> 
> And then the same for sys_exit. Note how the period count equals the
> sample count. Yes, open, stat and mmap are called often, but are
> these syscalls really expensive? Hard to tell.
> 
> This patch adds a new inject command to aggregate the
> sys_enter and sys_exit events and sets the period to the elapsed time:
> 
> # perf inject -t -i perf.data -o perf.data.merged
> 
> This makes the report much nicer:
> 
> # perf report --stdio --show-total-period --no-children --sort sym \
>               --max-stack 1  -i perf.data.merged
> 
>     #
>     # Total Lost Samples: 0
>     #
>     # Samples: 45  of event 'raw_syscalls:sys_enter'
>     # Event count (approx.): 1001520568
>     #
>     # Overhead        Period  Symbol
>     # ........  ............  ..............................
>     #
>     100.00%    1001520568  [k] syscall_trace_enter_phase2
> 
>                 |--99.99%--__nanosleep
> 
> Note that the other syscalls in this example are so cheap they are
> filtered out of the report by default. You can bring them back via
> e.g. `--call-graph graph,0`, or by omitting `--no-children` or
> via --percent-limit 0.
> 
> The report of the merged data can also again use the raw number
> of syscalls for merging, with a pretty unwieldy command:
> 
> # perf report -i perf.data.merged --sort sym --show-nr-samples \
>               -g graph,0,caller,function,count --stdio --max-stack 1
> 
>     #
>     # Samples: 45  of event 'raw_syscalls:sys_enter'
>     # Event count (approx.): 1001520568
>     #
>     # Children      Self       Samples  Symbol
>     # ........  ........  ............  ..............................
>     #
>     100.00%   100.00%            45  [k] syscall_trace_enter_phase2
> 
>                 |--3--__nanosleep
>                 |
>                 |--14--open64
>                 |
>                 |--7--mmap64
>                 |
>                 |--8--_xstat
>                 |
>                 |--4--mprotect
>                 |
>                 |--1--munmap
>                 |
>                 |--2--_fxstat
>                 |
>                 |--1--access
>                 |
>                 |--2--close
>                 |
>                 |--1--read
>                 |
>                 |--1--init_tls
>                 |
>                 |--1--brk
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/builtin-inject.c | 141
> +++++++++++++++++++++++++++++++++++--------- 1 file changed, 113
> insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index e5afa8f..3bad330 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -31,6 +31,7 @@ struct perf_inject {
>  	bool			have_auxtrace;
>  	bool			strip;
>  	bool			jit_mode;
> +	bool			trace;
>  	const char		*input_name;
>  	struct perf_data_file	output;
>  	u64			bytes_written;
> @@ -451,17 +452,14 @@ repipe:
>  	return 0;
>  }
> 
> -static int perf_inject__sched_process_exit(struct perf_tool *tool,
> -					   union perf_event *event __maybe_unused,
> -					   struct perf_sample *sample,
> -					   struct perf_evsel *evsel __maybe_unused,
> -					   struct machine *machine __maybe_unused)
> +static int perf_inject__free_cloned_event(struct perf_tool *tool,
> +					  u32 tid)
>  {
>  	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> struct event_entry *ent;
> 
>  	list_for_each_entry(ent, &inject->samples, node) {
> -		if (sample->tid == ent->tid) {
> +		if (tid == ent->tid) {
>  			list_del_init(&ent->node);
>  			free(ent);
>  			break;
> @@ -471,21 +469,18 @@ static int perf_inject__sched_process_exit(struct
> perf_tool *tool, return 0;
>  }
> 
> -static int perf_inject__sched_switch(struct perf_tool *tool,
> -				     union perf_event *event,
> -				     struct perf_sample *sample,
> -				     struct perf_evsel *evsel,
> -				     struct machine *machine)
> +static int perf_inject__clone_event(struct perf_tool *tool,
> +				    union perf_event *event,
> +				    struct perf_sample *sample)
>  {
>  	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> struct event_entry *ent;
> 
> -	perf_inject__sched_process_exit(tool, event, sample, evsel, machine);
> -
> +	perf_inject__free_cloned_event(tool, sample->tid);
>  	ent = malloc(event->header.size + sizeof(struct event_entry));
>  	if (ent == NULL) {
>  		color_fprintf(stderr, PERF_COLOR_RED,
> -			     "Not enough memory to process sched switch event!");
> +			     "Not enough memory to clone event!");
>  		return -1;
>  	}
> 
> @@ -495,35 +490,104 @@ static int perf_inject__sched_switch(struct perf_tool
> *tool, return 0;
>  }
> 
> +static struct event_entry *perf_inject__find_cloned_event(struct perf_tool
> *tool, +							  u32 tid)
> +{
> +	struct event_entry *ent;
> +	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> +
> +	list_for_each_entry(ent, &inject->samples, node) {
> +		if (tid == ent->tid)
> +			return ent;
> +	}
> +	return NULL;
> +}
> +
> +static int perf_inject__repipe_cloned_event_sample(struct perf_tool *tool,
> +						   struct perf_evsel *evsel,
> +						   struct machine *machine,
> +						   union perf_event *event_sw,
> +						   struct perf_sample sample_sw)
> +{
> +	perf_event__synthesize_sample(event_sw, evsel->attr.sample_type,
> +				      evsel->attr.read_format, &sample_sw,
> +				      false);
> +	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
> +	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
> +}
> +
> +static int perf_inject__sched_process_exit(struct perf_tool *tool,
> +					   union perf_event *event __maybe_unused,
> +					   struct perf_sample *sample,
> +					   struct perf_evsel *evsel __maybe_unused,
> +					   struct machine *machine __maybe_unused)
> +{
> +	perf_inject__free_cloned_event(tool, sample->tid);
> +	return 0;
> +}
> +
> +static int perf_inject__sched_switch(struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct perf_evsel *evsel __maybe_unused,
> +				     struct machine *machine __maybe_unused)
> +{
> +	return perf_inject__clone_event(tool, event, sample);
> +}
> +
>  static int perf_inject__sched_stat(struct perf_tool *tool,
>  				   union perf_event *event __maybe_unused,
>  				   struct perf_sample *sample,
>  				   struct perf_evsel *evsel,
>  				   struct machine *machine)
>  {
> -	struct event_entry *ent;
>  	union perf_event *event_sw;
>  	struct perf_sample sample_sw;
> -	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> u32 pid = perf_evsel__intval(evsel, sample, "pid");
> +	struct event_entry *ent = perf_inject__find_cloned_event(tool, pid);
> 
> -	list_for_each_entry(ent, &inject->samples, node) {
> -		if (pid == ent->tid)
> -			goto found;
> -	}
> +	if (ent == NULL)
> +		return 0;
> 
> -	return 0;
> -found:
>  	event_sw = &ent->event[0];
>  	perf_evsel__parse_sample(evsel, event_sw, &sample_sw);
> 
>  	sample_sw.period = sample->period;
>  	sample_sw.time	 = sample->time;
> -	perf_event__synthesize_sample(event_sw, evsel->attr.sample_type,
> -				      evsel->attr.read_format, &sample_sw,
> -				      false);
> -	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
> -	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
> +
> +	return perf_inject__repipe_cloned_event_sample(tool, evsel, machine,
> +						       event_sw, sample_sw);
> +}
> +
> +static int perf_inject__raw_syscalls_sys_enter(struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct perf_evsel *evsel __maybe_unused,
> +				     struct machine *machine __maybe_unused)
> +{
> +	return perf_inject__clone_event(tool, event, sample);
> +}
> +
> +static int perf_inject__raw_syscalls_sys_exit(struct perf_tool *tool,
> +				   union perf_event *event __maybe_unused,
> +				   struct perf_sample *sample,
> +				   struct perf_evsel *evsel,
> +				   struct machine *machine)
> +{
> +	union perf_event *event_sw;
> +	struct perf_sample sample_sw;
> +	struct event_entry *ent = perf_inject__find_cloned_event(tool,
> sample->tid); +
> +	if (ent == NULL)
> +		return 0;
> +
> +	event_sw = &ent->event[0];
> +	perf_evsel__parse_sample(evsel, event_sw, &sample_sw);
> +
> +	sample_sw.period = sample->time - sample_sw.time;
> +
> +	return perf_inject__repipe_cloned_event_sample(tool, evsel, machine,
> +						       event_sw, sample_sw);
>  }
> 
>  static void sig_handler(int sig __maybe_unused)
> @@ -656,6 +720,24 @@ static int __cmd_inject(struct perf_inject *inject)
>  			else if (!strncmp(name, "sched:sched_stat_", 17))
>  				evsel->handler = perf_inject__sched_stat;
>  		}
> +	} else if (inject->trace) {
> +		struct perf_evsel *evsel;
> +
> +		evlist__for_each(session->evlist, evsel) {
> +			const char *name = perf_evsel__name(evsel);
> +
> +			if (!strcmp(name, "raw_syscalls:sys_exit")) {
> +				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
> +					return -EINVAL;
> +
> +				evsel->handler = perf_inject__raw_syscalls_sys_exit;
> +			} else if (!strcmp(name, "raw_syscalls:sys_enter")) {
> +				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
> +					return -EINVAL;
> +
> +				evsel->handler = perf_inject__raw_syscalls_sys_enter;
> +			}
> +		}
>  	} else if (inject->itrace_synth_opts.set) {
>  		session->itrace_synth_opts = &inject->itrace_synth_opts;
>  		inject->itrace_synth_opts.inject = true;
> @@ -775,6 +857,9 @@ int cmd_inject(int argc, const char **argv, const char
> *prefix __maybe_unused) OPT_BOOLEAN('s', "sched-stat", &inject.sched_stat,
>  			    "Merge sched-stat and sched-switch for getting events "
>  			    "where and how long tasks slept"),
> +		OPT_BOOLEAN('t', "trace", &inject.trace,
> +			    "Merge raw_syscalls:sys_enter and raw_syscalls:sys_exit trace 
"
> +			    "events to measure how long the individual syscalls took"),
>  #ifdef HAVE_JITDUMP
>  		OPT_BOOLEAN('j', "jit", &inject.jit_mode, "merge jitdump files into
> perf.data file"), #endif
> @@ -815,7 +900,7 @@ int cmd_inject(int argc, const char **argv, const char
> *prefix __maybe_unused) return -1;
>  	}
> 
> -	inject.tool.ordered_events = inject.sched_stat;
> +	inject.tool.ordered_events = inject.sched_stat || inject.trace;
> 
>  	file.path = inject.input_name;
>  	inject.session = perf_session__new(&file, true, &inject.tool);


-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart1694036.n27UpqDuvx
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUdzCCBGYw
ggNOoAMCAQICEFEmCpMc4n+cw6VfeeByroIwDQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMRswGQYDVQQD
ExJVVE4gLSBEQVRBQ29ycCBTR0MwHhcNMDUwNjA3MDgwOTEwWhcNMTkwNjI0MTkwNjMwWjBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVy
bmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt/caM+byAAQtOeBOW+0fvGwPzbX6I7bO3psRM5ek
KUx9k5+9SryT7QMa44/P5W1QWtaXKZRagLBJetsulf24yr83OC0ePpFBrXBWx/BPP+gynnTKyJBU
6cZfD3idmkA8Dqxhql4Uj56HoWpQ3NeaTq8Fs6ZxlJxxs1BgCscTnTgHhgKo6ahpJhiQq0ywTyOr
Ok+E2N/On+Fpb7vXQtdrROTHre5tQV9yWnEIN7N5ZaRZoJQ39wAvDcKSctrQOHLbFKhFxF0qfbe0
1sTurM0TRLfJK91DACX6YblpalgjEbenM49WdVn1zSnXRrcKK2W200JvFbK4e/vv6V1T1TRaJwID
AQABo4HYMIHVMB8GA1UdIwQYMBaAFFMy0bPPf/rg8aBdhU6S0p5FHbRPMB0GA1UdDgQWBBStvZh6
NLQm9/rEJlTvA73gJMtUGjAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zARBglghkgB
hvhCAQEEBAMCAQIwIAYDVR0lBBkwFwYKKwYBBAGCNwoDAwYJYIZIAYb4QgQBMD0GA1UdHwQ2MDQw
MqAwoC6GLGh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4tREFUQUNvcnBTR0MuY3JsMA0GCSqG
SIb3DQEBBQUAA4IBAQDG7lMXaBSyUSIekFgNlP298XDlhi3DNjGPVEhG5y0IN7xsCmDhDq1RNOAS
k+m+uKu4JrTplj0oj65kB/7gAezF45HrGKDxdX7bCuafkduvrnXfI5Fo3RcAWkv/ZGxw6wEa0JDZ
x6bWbfYT5P+1ydIeKsuxJUMmeNkwm04NHr5p79/q/i2zzPmw3bUUypHUsrWl+wEZo0d5n52MlYc0
+B84kto2phH6a+tr6dxFeBU5BtdNQeQhyNwvh9G3v0hgdaViyyTeO2GgKSCmvsVsnMTpCmki75E6
+iav0VtBpzri+DgHQqvBW/jObboPBD8yNKzcBCjXcDAUJgbE5JuY1c94MIIEnTCCA4WgAwIBAgIQ
ND3pK6wnNP+PyzSU+8xwVDANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChML
QWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYD
VQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTA1MDYwNzA4MDkxMFoXDTIwMDUzMDEw
NDgzOFowga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENp
dHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51
c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgRW1haWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyOYWk8n2rQTtiRjeu
zcFgdbw5ZflKGkeiucxIzGqY1U01GbmkQuXOSeKKLx580jEHx060g2SdLinVomTEhb2FUTV5pE5o
kHsceqSSqBfymBXyk8zJpDKVuwxPML2YoAuL5W4bokb6eLyib6tZXqUvz8rabaov66yhs2qqty5n
NYt54R5piOLmRs2gpeq+C852OnoOm+r82idbPXMfIuZIYcZM82mxqC4bttQxICy8goqOpA6l14lD
/BZarx1x1xFZ2rqHDa/68+HC8KTFZ4zW1lQ63gqkugN3s2XI/R7TdGKqGMpokx6hhX71R2XL+E1X
KHTSNP8wtu72YjAUjCzrAgMBAAGjgfQwgfEwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTL
VBowHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGA1UdIAQKMAgwBgYEVR0gADBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RFeHRlcm5hbENBUm9vdC5jcmwwNQYIKwYBBQUHAQEEKTAn
MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IB
AQABvJzjYyiw8zEBwt973WKgAZ0jMQ+cknNTUeofTPrWn8TKL2d+eDMPdBa5kYeR9Yom+mRwANge
+QsEYlCHk4HU2vUj2zS7hVa0cDRueIM3HoUcxREVkl+HF72sav3xwtHMiV+xfPA+UfI183zsYJhr
Oivg79+zfYbrtRv1W+yifJgT1wBQudEtc94DeHThBYUxXsuauZ2UxrmUN3Vy3ET7Z+jw+iUeUqfa
JelH4KDHPKBOsQo2+3dIn++Xivu0/uOUFKiDvFwtP9JgcWDuwnGCDOmINuPaILSjoGyqlku4gI51
ykkH9jsUut/cBdmf2+Cy5k2geCbn5y1uf1/GHogVMIIFGjCCBAKgAwIBAgIQbRnqpxlPajMi5iIy
eqpx3jANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQH
Ew5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQL
ExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0xMTA0MjgwMDAwMDBaFw0yMDA1MzAxMDQ4Mzha
MIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09NT0RPIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAkoSEW0tXmNReL4uk4UDIo1NYX2Zl8TJO958yfVXQeExVt0KU4PkncQfFxmmk
uTLE8UAakMwnVmJ/F7Vxaa7lIBvky2NeYMqiQfZq4aP/uN8fSG1lQ4wqLitjOHffsReswtqCAtbU
MmrUZ28gE49cNfrlVICv2HEKHTcKAlBTbJUdqRAUtJmVWRIx/wmi0kzcUtve4kABW0ho3cVKtODt
JB86r3FfB+OsvxQ7sCVxaD30D9YXWEYVgTxoi4uDD216IVfmNLDbMn7jSuGlUnJkJpFOpZIP/+Cx
YP0ab2hRmWONGoulzEKbm30iY9OpoPzOnpDfRBn0XFs1uhbzp5v/wQIDAQABo4IBSzCCAUcwHwYD
VR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFHoTTgB0W8Z4Y2QnwS/ioFu8
ecV7MA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0g
ADBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJz
dC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDB0BggrBgEFBQcBAQRoMGYwPQYIKwYB
BQUHMAKGMWh0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VVE5BZGRUcnVzdENsaWVudF9DQS5jcnQw
JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEB
AIXWvnhXVW0zf0RS/kLVBqgBA4CK+w2y/Uq/9q9BSfUbWsXSrRtzbj7pJnzmTJjBMCjfy/tCPKEl
Pgp11tA9OYZm0aGbtU2bb68obB2v5ep0WqjascDxdXovnrqTecr+4pEeVnSy+I3T4ENyG+2P/WA5
IEf7i686ZUg8mD2lJb+972DgSeUWyOs/Q4Pw4O4NwdPNM1+b0L1garM7/vrUyTo8H+2b/5tJM75C
KTmD7jNpLoKdRU2oadqAGx490hpdfEeZpZsIbRKZhtZdVwcbpzC+S0lEuJB+ytF5OOu0M/qgOl0m
WJ5hVRi0IdWZ1eBDQEIwvuql55TSsP7zdfl/bucwggZKMIIFMqADAgECAhByCOhbkTwXiJtaa0d5
K5u0MA0GCSqGSIb3DQEBBQUAMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcG
A1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4X
DTE0MDYwMjAwMDAwMFoXDTE3MDYwMTIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0GA1UEERMG
NjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNVBAkTD05v
cnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRhbGVucyBE
YXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNVBAsMOklz
c3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1hbmFnZXIx
HzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBXb2xmZjEk
MCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAwirYPAOcWQk9jaCoEAn84PwINg/NDs3PxsEd34f27AfCqJepwIF+ikMuBBxt
mm1pieQwU9fcFrE4CXPCdYxfFOdcbJJ58Xzog5aFrJHnYGEFIL8KVvdBvAFeP/AJPaY2lg1JWnVI
1jwO74VmUGMyvMG286wpwW3hWO3sepZZQN3tvXyd9EgD72AiImkvw43+BW4xy8ptOd3TvEwCJ+uN
x8v+uILsRLvKcmSrUsLpo7No2HoifWX1doKHKSwYVVqmOT/rjJWxF98j4w2kTKRsWdQ4ENlqNpjW
zlbtB6TM2mrnInefzALbIoLLQ2E2NFCaMVsczf7RFsMxUepM9KQQ5QIDAQABo4IBzzCCAcswHwYD
VR0jBBgwFoAUehNOAHRbxnhjZCfBL+KgW7x5xXswHQYDVR0OBBYEFGSjHixs9BD9OyGskYjMX7mi
P+fiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggr
BgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1odHRwczov
L3NlY3VyZS5jb21vZG8ubmV0L0NQUzBXBgNVHR8EUDBOMEygSqBIhkZodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9DbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGI
BggrBgEFBQcBAQR8MHowUgYIKwYBBQUHMAKGRmh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T0NsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0
dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29sZmZAa2RhYi5jb20w
DQYJKoZIhvcNAQEFBQADggEBAFvi067uXCOkiUH/D6rv4gV0/e+e8DzcvbbsUxAC5nwDXBv+47ds
l7j8NrZstZraVz35WEWgksNmnyghcuBKzKcN3kY1KNn/ERc9wvns/0dI+yj39L0eSMzchUZoV6GY
MtPfmLofPvUBbDesl97JQXF9vpk8FIVsI1UKKrLzfoKhue5abQHXurSFa0ts1UPmSh2Y8/QCQlFN
lCv8ISyEwVCAkhdIqxRc3hslooBhcRVUrYhRdCLlNN6Od8yuLE9sKWH/K4wg/BpnjCJmGp4GQhU8
DUG2r0CbOa+iZQKTWUgwdGU3Jr+WcOan/JaNzBuKk1GM3D+WcljoU7ZWtoqXPzgxggJaMIICVgIB
ATCBqDCBkzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQcgjoW5E8F4ibWmtHeSub
tDAJBgUrDgMCGgUAoIGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTE2MDUwOTE3NTYwNVowIwYJKoZIhvcNAQkEMRYEFI4jV0GbqbvQc5vPqpzTi2HUxOg1MCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAH9K
eX9YzEzsTPJ9Ky4hPJTPEC0+Riz53sTG91qSDGBsHdgjgRxc7Gg8+3vql/huGQzFShZhBfFf2VEi
qkVdUHw1rH8zQnwAK/W624oDtu3ButJxLbrZijmNyiCIWlszz9ktVCzY0ML69zdV36QaGJGZAZeW
UbcIKAYcmIvKaGMgHmgcGCsDcrxUksIYGXNdRDiVa4AG99nhy24F6t+L00ixbS+qmQNjipWIKH0c
mZyRP2EHYCqid8YvuIIuwZ+U1P5O0j6YWh7Tfl49kKot27jdnj/NsZPVsOg+xylCltsjXO4u6prm
vGjz1E7+TO4p1mUXnjQwt2KBowf4nPfpSmwAAAAAAAA=


--nextPart1694036.n27UpqDuvx--
