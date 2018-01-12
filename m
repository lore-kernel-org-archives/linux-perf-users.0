From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Fri, 12 Jan 2018 11:20:32 -0300
Message-ID: <20180112142032.GB9655@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeALOUf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Jan 2018 09:20:35 -0500
Content-Disposition: inline
In-Reply-To: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Fri, Jan 12, 2018 at 11:03:55AM +0100, Thomas Richter escreveu:
> On Intel platform when I execute test case
>    probe libc's inet_pton & backtrace it with ping
> I get this output which is correct:
> 
> [root@f27 perf]# ./perf trace --no-syscalls
> 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.064 ms
> 
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.064/0.064/0.064/0.000 ms
>      0.000 probe_libc:inet_pton:(7f26a88498a0))
> 	   __GI___inet_pton (/usr/lib64/libc-2.26.so)
> 	   getaddrinfo (/usr/lib64/libc-2.26.so)
> 	   main (/usr/bin/ping)
> [root@f27 perf]#
> 
> However when I add the global --call-graph dwarf to the command
> line I get the exactly same result which is wrong:
> 
> [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> 		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> 
> My understanding is that the '--call-graph dwarf' option should be global
> and applies to all events. However it is ignored.

It is global, but then, per-event settings can override it.

So if you say that the following call (without that /max-stack=3/, which
implies DWARF, which is the safest bet for userspace callchains):
[root@jouet ~]# perf trace --no-syscalls --call-graph dwarf -e probe_libc:inet_pton ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.086 ms

--- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.086/0.086/0.086/0.000 ms
     0.000 probe_libc:inet_pton:(7fafee7ce350))
[root@jouet ~]#

And it doesn't work, right, that is a bug. I'll check if your patch
fixes that and then will correct the cset log, i.e. this part:

[root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
		-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1

Should read:

[root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
		-e probe_libc:inet_pton ping -6 -c 1 ::1

And _should_ produce a call-graph, without a stack limit, ok?

I'll reply to this message after testing your patch.

Thanks,

- Arnaldo

> The issue is buried in function apply_config_terms() called from
> trace__run()
>  --> perf_evlist__config()
>      --> perf_evsel__config()
>            --> apply_config_terms()
> 
> This function iterates over all additional terms and handles the
> /max-stack=<xx>/ case. However if there is no additional call-graph=dwarf
> setting as in -e probe_libc:inet_pton/max-stack=3,call-graph=dwarf/
> the function defaults to "fp" regardless of the value of --call-graph
> global command line flag.
> 
> So when I add ,call-graph=dwarf to the event I get a good result:
> 
> [root@f27 perf]# ./perf trace --no-syscalls
> 	-e probe_libc:inet_pton/max-stack=3,call-graph=dwarf/
> 	ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.084 ms
> 
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.084/0.084/0.084/0.000 ms
>      0.000 probe_libc:inet_pton:(7f9372a988a0))
> 	   __inet_pton (inlined)
> 	   gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
> 	   __GI_getaddrinfo (inlined)
> 	   main (/usr/bin/ping)
> 	   __libc_start_main (/usr/lib64/libc-2.26.so)
> 	   _start (/usr/bin/ping)
> [root@f27 perf]#
> 
> In fact the looks pretty similar to the output on s390x which only has
> dwarf support.
> Ok the max-stack is not observed, but this time the global --max-stack <x>
> comes to rescue and limits the output:
> 
> [root@f27 perf]# ./perf trace --no-syscalls --max-stack 4
> 	-e probe_libc:inet_pton/max-stack=3,call-graph=dwarf/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.061 ms
> 
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.061/0.061/0.061/0.000 ms
>      0.000 probe_libc:inet_pton:(7fc9f6c188a0))
> 	   __inet_pton (inlined)
> 	   gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
> 	   __GI_getaddrinfo (inlined)
> 	   main (/usr/bin/ping)
> [root@f27 perf]#
> 
> This patch applies the global --call-graph <xxx> setting to the individual
> events.
> 
> With this patch applied:
> [root@f27 perf]# ./perf trace --no-syscalls --call-graph dwarf
> 	-e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.066 ms
> 
>  --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.066/0.066/0.066/0.000 ms
>      0.000 probe_libc:inet_pton:(7fe74f8358a0))
> 	   __inet_pton (inlined)
> 	   gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
> 	   __GI_getaddrinfo (inlined)
> 	   main (/usr/bin/ping)
> 	   __libc_start_main (/usr/lib64/libc-2.26.so)
> 	   _start (/usr/bin/ping)
> [root@f27 perf]#
> 
> When using dwarf the /max-stack=<x>/ is not observed.
> The reason is that for call-graph=fp the kernel stack unwinder
> is used and it stops after unwinding x entries.
> For dwarf the complete stack data is returned and the unwinding
> is done by perf itself and it uses --max-stack <x>
> command line flag.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Reviewed-by: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/util/evsel.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d5fbcf8c7aa7..d1c25aafb821 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -788,8 +788,24 @@ static void apply_config_terms(struct perf_evsel *evsel,
>  	if ((callgraph_buf != NULL) || (dump_size > 0) || max_stack) {
>  		if (max_stack) {
>  			param.max_stack = max_stack;
> -			if (callgraph_buf == NULL)
> -				callgraph_buf = "fp";
> +			if (callgraph_buf == NULL) {
> +				switch (callchain_param.record_mode) {
> +				case CALLCHAIN_DWARF:
> +					callgraph_buf = "dwarf";
> +					break;
> +				case CALLCHAIN_NONE:
> +				case CALLCHAIN_FP:
> +					callgraph_buf = "fp";
> +					break;
> +				case CALLCHAIN_LBR:
> +					callgraph_buf = "lbr";
> +					break;
> +				default:
> +				case CALLCHAIN_MAX:
> +					callgraph_buf = "no";
> +					break;
> +				}
> +			}
>  		}
>  
>  		/* parse callgraph parameters */
> -- 
> 2.14.3
