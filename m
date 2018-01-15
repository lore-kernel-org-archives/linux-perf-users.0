From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf trace: Fix missing handling of --call-graph dwarf
Date: Mon, 15 Jan 2018 11:16:20 -0300
Message-ID: <20180115141620.GD3542@kernel.org>
References: <20180112100355.6456-1-tmricht@linux.vnet.ibm.com>
 <20180112142032.GB9655@kernel.org>
 <20180112150142.GC9655@kernel.org>
 <20180112164706.GE9655@kernel.org>
 <20180112200229.GI9655@kernel.org>
 <8d20a732-25af-968c-f3a9-1a1336854851@linux.vnet.ibm.com>
 <20180115135752.GC3542@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115135752.GC3542@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Jan 15, 2018 at 10:57:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> > [root@f27 perf]# ./perf trace --no-syscalls --max-stack 4
> >         -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
> > PING ::1(::1) 56 data bytes
> > 64 bytes from ::1: icmp_seq=1 ttl=64 time=0.020 ms
> > 
> > --- ::1 ping statistics ---
> > 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> > rtt min/avg/max/mdev = 0.020/0.020/0.020/0.000 ms
> >      0.000 probe_libc:inet_pton:(7ffbc5f768a0))
> >             __inet_pton (inlined)
> >             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
> >             __GI_getaddrinfo (inlined)
> >             main (/usr/bin/ping)
> > [root@f27 perf]#
> > 
> > 
> > --> Dwarf call graph and --max-stack 4 is also honoured.
> 
> [root@jouet ~]# perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf,max-stack=4/
> perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
> Value too large for defined data type
> [root@jouet ~]# 
> 
> Grrr.


Got this one fixed with the following patch:

commit b78278e11f6992ca348a4b96aad3b2c0a9ecf0f0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jan 15 11:07:58 2018 -0300

    perf callchain: Fix attr.sample_max_stack setting
    
    When setting the "dwarf" unwinder for a specific event and not
    specifying the max-stack, the attr.sample_max_stack ended up using an
    uninitialized callchain_param.max_stack, fix it by using designated
    initializers for that callchain_param variable, zeroing all non
    explicitely initialized struct members.
    
    Here is what happened:
    
      # perf trace -vv --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      callchain: type DWARF
      callchain: stack dump size 8192
      perf_event_attr:
        type                             2
        size                             112
        config                           0x730
        { sample_period, sample_freq }   1
        sample_type                      IP|TID|TIME|ADDR|CALLCHAIN|CPU|PERIOD|RAW|REGS_USER|STACK_USER|DATA_SRC
        exclude_callchain_user           1
        { wakeup_events, wakeup_watermark } 1
        sample_regs_user                 0xff0fff
        sample_stack_user                8192
        sample_max_stack                 50656
      sys_perf_event_open failed, error -75
      Value too large for defined data type
      # perf trace -vv --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      callchain: type DWARF
      callchain: stack dump size 8192
      perf_event_attr:
        type                             2
        size                             112
        config                           0x730
        sample_type                      IP|TID|TIME|ADDR|CALLCHAIN|CPU|PERIOD|RAW|REGS_USER|STACK_USER|DATA_SRC
        exclude_callchain_user           1
        sample_regs_user                 0xff0fff
        sample_stack_user                8192
        sample_max_stack                 30448
      sys_perf_event_open failed, error -75
      Value too large for defined data type
      #
    
    Now the attr.sample_max_stack is set to zero and the above works as
    expected:
    
      # perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
      PING ::1(::1) 56 data bytes
      64 bytes from ::1: icmp_seq=1 ttl=64 time=0.072 ms
    
      --- ::1 ping statistics ---
      1 packets transmitted, 1 received, 0% packet loss, time 0ms
      rtt min/avg/max/mdev = 0.072/0.072/0.072/0.000 ms
           0.000 probe_libc:inet_pton:(7feb7a998350))
                                             __inet_pton (inlined)
                                             gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                                             __GI_getaddrinfo (inlined)
                                             [0xffffaa39b6108f3f] (/usr/bin/ping)
      #
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: https://lkml.kernel.org/n/tip-qmqnot8y3zff5wh8kb7rkl4d@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index efa2e629a669..8f971a2301d1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -731,14 +731,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
 	struct perf_evsel_config_term *term;
 	struct list_head *config_terms = &evsel->config_terms;
 	struct perf_event_attr *attr = &evsel->attr;
-	struct callchain_param param;
+	/* callgraph default */
+	struct callchain_param param = {
+		.record_mode = callchain_param.record_mode,
+	};
 	u32 dump_size = 0;
 	int max_stack = 0;
 	const char *callgraph_buf = NULL;
 
-	/* callgraph default */
-	param.record_mode = callchain_param.record_mode;
-
 	list_for_each_entry(term, config_terms, list) {
 		switch (term->type) {
 		case PERF_EVSEL__CONFIG_TERM_PERIOD:
