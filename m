From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Fri, 3 Nov 2017 15:41:55 -0300
Message-ID: <20171103184155.GH3531@kernel.org>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org>
 <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
 <20171031191411.GB3531@kernel.org>
 <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
 <20171102062052.GB23303@sejong>
 <CABYXEksfK4CwgrogBZ=EZWQubOWb8UDxzw22o_pH3TQmmk6Htg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754277AbdKCSl6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Nov 2017 14:41:58 -0400
Content-Disposition: inline
In-Reply-To: <CABYXEksfK4CwgrogBZ=EZWQubOWb8UDxzw22o_pH3TQmmk6Htg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bram Stolk <b.stolk@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Em Thu, Nov 02, 2017 at 12:01:24AM -0700, Bram Stolk escreveu:
> Thanks Namhyung,
> 
> I tried the patch, but still no app symbols:
> 
> perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench

Can you try this one instead:

commit 81b5911db9f587ebe30af81a667ff8de2c43eaf0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Nov 3 15:34:34 2017 -0300

    perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC} with --delay
    
    When we use an initial delay, e.g.: 'perf record --delay 1000', we do not
    enable the events until that delay has passed after we started the workload,
    including the tracking event, i.e. the one for which we have attr.mmap, etc,
    enabled to ask the kernel to generate the PERF_RECORD_{MMAP,COMM,EXEC} metadata
    events that will then allow us to resolve addresses in samples to the map, dso
    and symbol. There will be a shadow that even synthesizing samples won't cover,
    i.e. the workload that we start and others that fork while we wait for that delay.
    
    So use a dummy event to be the tracking one and make it be enabled on exec.
    
    Before:
    
      # perf record --delay 1000 stress --cpu 1 --timeout 5
      stress: info: [9029] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
      stress: info: [9029] successful run completed in 5s
      [ perf record: Woken up 3 times to write data ]
      [ perf record: Captured and wrote 0.624 MB perf.data (15908 samples) ]
      # perf script | head
          :9031 9031 32001.826888:       1 cycles:ppp: ffffffff831aa30d event_function (/lib/modules/4.14.0-rc6+/build/vmlinux)
          :9031 9031 32001.826893:       1 cycles:ppp: ffffffff8300d1a0 intel_bts_enable_local (/lib/modules/4.14.0-rc6+/build/vmlinux)
          :9031 9031 32001.826895:       7 cycles:ppp: ffffffff83023870 sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
          :9031 9031 32001.826897:     103 cycles:ppp: ffffffff8300c331 intel_pmu_handle_irq (/lib/modules/4.14.0-rc6+/build/vmlinux)
          :9031 9031 32001.826899:    1615 cycles:ppp: ffffffff830231f8 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
          :9031 9031 32001.826902:   26724 cycles:ppp: ffffffff8384c6a7 native_irq_return_iret (/lib/modules/4.14.0-rc6+/build/vmlinux)
          :9031 9031 32001.826913:  329739 cycles:ppp:     7fb2a5410932 [unknown] ([unknown])
          :9031 9031 32001.827033: 1225451 cycles:ppp:     7fb2a5410930 [unknown] ([unknown])
          :9031 9031 32001.827474: 1391725 cycles:ppp:     7fb2a5410930 [unknown] ([unknown])
          :9031 9031 32001.827978: 1233697 cycles:ppp:     7fb2a5410928 [unknown] ([unknown])
      #
    
    After:
    
      # perf record --delay 1000 stress --cpu 1 --timeout 5
      stress: info: [9741] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
      stress: info: [9741] successful run completed in 5s
      [ perf record: Woken up 3 times to write data ]
      [ perf record: Captured and wrote 0.751 MB perf.data (15976 samples) ]
      # perf script | head
         stress  9742 32110.959106:          1 cycles:ppp:  ffffffff831b26f6 __perf_event_task_sched_in (/lib/modules/4.14.0-rc6+/build/vmlinux)
         stress 9742 32110.959110:       1 cycles:ppp: ffffffff8300c2e9 intel_pmu_handle_irq (/lib/modules/4.14.0-rc6+/build/vmlinux)
         stress 9742 32110.959112:       7 cycles:ppp: ffffffff830231e0 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
         stress 9742 32110.959115:     101 cycles:ppp: ffffffff83023870 sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
         stress 9742 32110.959117:    1533 cycles:ppp: ffffffff830231f8 native_sched_clock (/lib/modules/4.14.0-rc6+/build/vmlinux)
         stress 9742 32110.959119:   23992 cycles:ppp: ffffffff831b0900 ctx_sched_in (/lib/modules/4.14.0-rc6+/build/vmlinux)
         stress 9742 32110.959129:  329406 cycles:ppp:     7f4b1b661930 __random_r (/usr/lib64/libc-2.25.so)
         stress 9742 32110.959249: 1288322 cycles:ppp:     5566e1e7cbc9 hogcpu (/usr/bin/stress)
         stress 9742 32110.959712: 1464046 cycles:ppp:     7f4b1b66179e __random (/usr/lib64/libc-2.25.so)
         stress 9742 32110.960241: 1266918 cycles:ppp:     7f4b1b66195b __random_r (/usr/lib64/libc-2.25.so)
      #
    
    Reported-by: Bram Stolk <b.stolk@gmail.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: http://lkml.kernel.org/n/tip-nrdfchshqxf7diszhxcecqb9@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f4d9fc54b382..3c74bfae1aeb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -338,6 +338,22 @@ static int record__open(struct record *rec)
 	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
+	/*
+	 * For initial_delay we need to add a dummy event so that we can track
+	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
+	 * real events, the ones asked by the user.
+	 */
+	if (opts->initial_delay) {
+		if (perf_evlist__add_dummy(evlist))
+			return -ENOMEM;
+
+		pos = perf_evlist__first(evlist);
+		pos->tracking = 0;
+		pos = perf_evlist__last(evlist);
+		pos->tracking = 1;
+		pos->attr.enable_on_exec = 1;
+	}
+
 	perf_evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, pos) {
