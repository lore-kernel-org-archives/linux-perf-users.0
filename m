Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BDC48BCD
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754F1613B6
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 13:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhFINGa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:06:30 -0400
Received: from foss.arm.com ([217.140.110.172]:60032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234733AbhFING1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 09:06:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594A06D;
        Wed,  9 Jun 2021 06:04:32 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.3.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 795353F73D;
        Wed,  9 Jun 2021 06:04:29 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf cs-etm: Delay decode of non-timeless data until cs_etm__flush_events()
Date:   Wed,  9 Jun 2021 16:04:20 +0300
Message-Id: <20210609130421.13934-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently, timeless mode starts the decode on PERF_RECORD_EXIT, and
non-timeless mode starts decoding on the fist PERF_RECORD_AUX record.

This can cause the "data has no samples!" error if the first
PERF_RECORD_AUX record comes before the first (or any relevant)
PERF_RECORD_MMAP2 record because the mmaps are required by the decoder
to access the binary data.

This change pushes the start of non-timeless decoding to the very end of
parsing the file. The PERF_RECORD_EXIT event can't be used because it
might not exist in system-wide or snapshot modes.

I have not been able to find the exact cause for the events to be
intermittently in the wrong order in the basic scenario:

	perf record -e cs_etm/@tmc_etr0/u top

But it can be made to happen every time with the --delay option. This is
because "enable_on_exec" is disabled, which causes tracing to start
before the process to be launched is exec'd. For example:

	perf record -e cs_etm/@tmc_etr0/u --delay=1 top
	perf report -D | grep 'AUX\|MAP'

	0 16714475632740 0x520 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x30 flags: 0 []
	0 16714476494960 0x5d0 [0x40]: PERF_RECORD_AUX offset: 0x30 size: 0x30 flags: 0 []
	0 16714478208900 0x660 [0x40]: PERF_RECORD_AUX offset: 0x60 size: 0x30 flags: 0 []
	4294967295 16714478293340 0x700 [0x70]: PERF_RECORD_MMAP2 8712/8712: [0x557a460000(0x54000) @ 0 00:17 5329258 0]: r-xp /usr/bin/top
	4294967295 16714478353020 0x770 [0x88]: PERF_RECORD_MMAP2 8712/8712: [0x7f86f72000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so

Another scenario in which decoding from the first aux record fails is a
workload that forks. Although the aux record comes after 'bash', it
comes before 'top', which is what we are interested in. For example:

	perf record -e cs_etm/@tmc_etr0/u -- bash -c top
	perf report -D | grep 'AUX\|MAP'

	4294967295 16853946421300 0x510 [0x70]: PERF_RECORD_MMAP2 8723/8723: [0x558f280000(0x142000) @ 0 00:17 5213953 0]: r-xp /usr/bin/bash
	4294967295 16853946543560 0x580 [0x88]: PERF_RECORD_MMAP2 8723/8723: [0x7fbba6e000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
	4294967295 16853946628420 0x608 [0x68]: PERF_RECORD_MMAP2 8723/8723: [0x7fbba9e000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
	0 16853947067300 0x690 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x3a60 flags: 0 []
	...
	0 16853966602580 0x1758 [0x40]: PERF_RECORD_AUX offset: 0xc2470 size: 0x30 flags: 0 []
	4294967295 16853967119860 0x1818 [0x70]: PERF_RECORD_MMAP2 8723/8723: [0x5559e70000(0x54000) @ 0 00:17 5329258 0]: r-xp /usr/bin/top
	4294967295 16853967181620 0x1888 [0x88]: PERF_RECORD_MMAP2 8723/8723: [0x7f9ed06000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
	4294967295 16853967237180 0x1910 [0x68]: PERF_RECORD_MMAP2 8723/8723: [0x7f9ed36000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]

A third scenario is when the majority of time is spent in a shared
library that is not loaded at startup. For example a dynamically loaded
plugin.

Testing
=======

Testing was done by checking if any samples that are present in the
old output are missing from the new output. Timestamps must be
stripped out with awk because now they are set to the last AUX sample,
rather than the first:

	./perf script $4 | awk '!($4="")' > new.script
	./perf-default script $4 | awk '!($4="")' > default.script
	comm -13 <(sort -u new.script) <(sort -u default.script)

Testing showed that the new output is a superset of the old. When lines
appear in the comm output, it is not because they are missing but
because [unknown] is now resolved to sensible locations. For example
last putp branch here now resolves to libtinfo, so it's not missing
from the output, but is actually improved:

Old:
	top 305 [001]  1 branches:uH: 402830 _init+0x30 (/usr/bin/top.procps) => 404a1c [unknown] (/usr/bin/top.procps)
	top 305 [001]  1 branches:uH: 404a20 [unknown] (/usr/bin/top.procps) => 402970 putp@plt+0x0 (/usr/bin/top.procps)
	top 305 [001]  1 branches:uH: 40297c putp@plt+0xc (/usr/bin/top.procps) => 0 [unknown] ([unknown])
New:
	top 305 [001]  1 branches:uH: 402830 _init+0x30 (/usr/bin/top.procps) => 404a1c [unknown] (/usr/bin/top.procps)
	top 305 [001]  1 branches:uH: 404a20 [unknown] (/usr/bin/top.procps) => 402970 putp@plt+0x0 (/usr/bin/top.procps)
	top 305 [001]  1 branches:uH: 40297c putp@plt+0xc (/usr/bin/top.procps) => 7f8ab39208 putp+0x0 (/lib/libtinfo.so.5.9)

In the following two modes, decoding now works and the "data has no
samples!" error is not displayed any more:

	perf record -e cs_etm/@tmc_etr0/u -- bash -c top
	perf record -e cs_etm/@tmc_etr0/u --delay=1 top

In snapshot mode, there is also an improvement to decoding. Previously
samples for the 'kill' process that was used to send SIGUSR2 were
completely missing, because the process hadn't started yet. But now
there are additional samples present:

	perf record -e cs_etm/@tmc_etr0/u --snapshot -a
	perf script

		stress 19380 [003] 161627.938153:    1000000    instructions:uH:      aaaabb612fb4 [unknown] (/usr/bin/stress)
		  kill 19644 [000] 161627.938153:    1000000    instructions:uH:      ffffae0ef210 [unknown] (/lib/aarch64-linux-gnu/ld-2.27.so)
		stress 19380 [003] 161627.938153:    1000000    instructions:uH:      ffff9e754d40 random_r+0x20 (/lib/aarch64-linux-gnu/libc-2.27.so)

Also tested was the round trip of 'perf inject' followed by 'perf
report' which has the same differences and improvements.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 57aea2c7fc77..ceed0b038796 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2407,6 +2407,11 @@ static int cs_etm__process_event(struct perf_session *session,
 			return err;
 	}
 
+	/*
+	 * Don't wait for cs_etm__flush_events() in per-thread/timeless mode to start the decode. We
+	 * need the tid of the PERF_RECORD_EXIT event to assign to the synthesised samples because
+	 * ETM_OPT_CTXTID is not enabled.
+	 */
 	if (etm->timeless_decoding &&
 	    event->header.type == PERF_RECORD_EXIT)
 		return cs_etm__process_timeless_queues(etm,
@@ -2424,7 +2429,6 @@ static int cs_etm__process_event(struct perf_session *session,
 		 * onwards.
 		 */
 		etm->latest_kernel_timestamp = sample_kernel_timestamp;
-		return cs_etm__process_queues(etm);
 	}
 
 	return 0;
-- 
2.28.0

