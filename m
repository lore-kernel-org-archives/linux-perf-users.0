From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Mon, 15 Jan 2018 12:02:27 -0300
Message-ID: <20180115150227.GE3542@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org>
 <20180112200229.GI9655@kernel.org>
 <8d20a732-25af-968c-f3a9-1a1336854851@linux.vnet.ibm.com>
 <20180115135752.GC3542@kernel.org>
 <20180115141620.GD3542@kernel.org>
 <4ead78ee-398b-c782-330f-61359ad40fe2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755672AbeAOPCc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Jan 2018 10:02:32 -0500
Content-Disposition: inline
In-Reply-To: <4ead78ee-398b-c782-330f-61359ad40fe2@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Mon, Jan 15, 2018 at 03:50:15PM +0100, Thomas-Mich Richter escreveu:
> On 01/15/2018 03:16 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 15, 2018 at 10:57:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> [root@f27 perf]# ./perf trace --no-syscalls --max-stack 4
> >>>         -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
> >>> PING ::1(::1) 56 data bytes
> >>> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.020 ms
> >>>
> >>> --- ::1 ping statistics ---
> >>> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> >>> rtt min/avg/max/mdev = 0.020/0.020/0.020/0.000 ms
> >>>      0.000 probe_libc:inet_pton:(7ffbc5f768a0))
> >>>             __inet_pton (inlined)
> >>>             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
> >>>             __GI_getaddrinfo (inlined)
> >>>             main (/usr/bin/ping)
> >>> [root@f27 perf]#
> >>>
> >>>
> >>> --> Dwarf call graph and --max-stack 4 is also honoured.
> >>
> >> [root@jouet ~]# perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf,max-stack=4/
> >> perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
> >> Value too large for defined data type
> >> [root@jouet ~]# 
> >>
> >> Grrr.
> > 
> > 
> > Got this one fixed with the following patch:
> > 
> > commit b78278e11f6992ca348a4b96aad3b2c0a9ecf0f0
> 
> [...]
> 
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index efa2e629a669..8f971a2301d1 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -731,14 +731,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
> >  	struct perf_evsel_config_term *term;
> >  	struct list_head *config_terms = &evsel->config_terms;
> >  	struct perf_event_attr *attr = &evsel->attr;
> > -	struct callchain_param param;
> > +	/* callgraph default */
> > +	struct callchain_param param = {
> > +		.record_mode = callchain_param.record_mode,
> > +	};
> >  	u32 dump_size = 0;
> >  	int max_stack = 0;
> >  	const char *callgraph_buf = NULL;
> > 
> > -	/* callgraph default */
> > -	param.record_mode = callchain_param.record_mode;
> > -
> >  	list_for_each_entry(term, config_terms, list) {
> >  		switch (term->type) {
> >  		case PERF_EVSEL__CONFIG_TERM_PERIOD:
> 
> This patch works for me.
> Here is the output on my s390x:
> 
> [root@s8360047 perf]# ./perf trace --no-syscalls --max-stack 4 
> 	-e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.070 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.070/0.070/0.070/0.000 ms
>      0.000 probe_libc:inet_pton:(3ffa70c2060))
>            __GI___inet_pton (/usr/lib64/libc-2.26.so)
>            gaih_inet (inlined)
>            __GI_getaddrinfo (inlined)
>            main (/usr/bin/ping)
> [root@s8360047 perf]# ./perf trace --no-syscalls --call-graph dwarf 
> 	-e probe_libc:inet_pton -- ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.086 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.086/0.086/0.086/0.000 ms
>      0.000 probe_libc:inet_pton:(3ff93fc2060))
>            __GI___inet_pton (/usr/lib64/libc-2.26.so)
>            gaih_inet (inlined)
>            __GI_getaddrinfo (inlined)
>            main (/usr/bin/ping)
>            __libc_start_main (/usr/lib64/libc-2.26.so)
>            _start (/usr/bin/ping)
> [root@s8360047 perf]#
> 
> [root@s8360047 perf]# ./perf trace --no-syscalls 
> 	-e probe_libc:inet_pton/call-graph=dwarf,max-stack=3/ ping -6 -c 1 ::1
> PING ::1(::1) 56 data bytes
> 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.066 ms
> 
> --- ::1 ping statistics ---
> 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> rtt min/avg/max/mdev = 0.066/0.066/0.066/0.000 ms
>      0.000 probe_libc:inet_pton:(3ffb82c2060))
>            __GI___inet_pton (/usr/lib64/libc-2.26.so)
>            gaih_inet (inlined)
>            __GI_getaddrinfo (inlined)
>            main (/usr/bin/ping)
>            __libc_start_main (/usr/lib64/libc-2.26.so)
>            _start (/usr/bin/ping)
> [root@s8360047 perf]# 
> 
> Not sure if this can work at all. Since dwarf stack unwinding is done in user space
> the attr.sample_max_stack set to 3 is useless in this case.

right, I'm working on this case now, this has to be honoured in
trace__resolve_callchain, that has to use evsel->attr.sample_max_stack
if it is set, otherwise fallback to trace->max_stack.

- Arnaldo
