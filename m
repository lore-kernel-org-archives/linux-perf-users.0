Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7161EC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Jun 2021 03:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C47F61954
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Jun 2021 03:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFZDWr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 23:22:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11099 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFZDWr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 23:22:47 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBfDq4qCKzZjrY;
        Sat, 26 Jun 2021 11:17:15 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 11:20:18 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 11:20:18 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <james.clark@arm.com>,
        <andre.przywara@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf arm-spe: Fix incorrect sample timestamp in perf script
Date:   Sat, 26 Jun 2021 11:21:15 +0800
Message-ID: <20210626032115.16742-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When use perf script to parse ARM SPE data, sample timestamp does not match
the timestamp stored in the AUX buffer, arm_spe_prep_sample function set
"samlpe->time = speq->timestamp", "speq->timestamp" is the timestamp of first
packet in auxtrace buffer. As a result, the time of all samples in a auxtrace
buffer uses the same timestamp.

Before:

  # perf record -e arm_spe_0/ts_enable=1,branch_filter=1/ ls
  perf.data
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.029 MB perf.data ]
  [ perf record: Captured and wrote 1.429 MB perf.data ]
  # perf script -D
  [...]
  0 0 0x31b0 [0x30]: PERF_RECORD_AUXTRACE size: 0x44f0  offset: 0  ref: 0x3a50d  idx: 5  tid: 107690  cpu: 5
  .
  [...]
  .  00000108:  b0 00 82 f3 29 ee b7 ff c0                      PC 0xffb7ee29f38200 el2 ns=1
  .  00000111:  99 02 00                                        LAT 2 ISSUE
  .  00000114:  98 03 00                                        LAT 3 TOT
  .  00000117:  52 82 00                                        EV RETIRED MISPRED
  .  0000011a:  4a 01                                           B COND
  .  0000011c:  b1 24 82 f3 29 ee b7 ff c0                      TGT 0xffb7ee29f38224 el2 ns=1
  .  00000125:  00 00 00 00 00 00                               PAD
  .  0000012b:  71 32 a0 d6 78 3f 07 00 00                      TS 7969191665714
  [...]
  .  0000018c:  b0 0c e1 20 2a ee b7 ff c0                      PC 0xffb7ee2a20e10c el2 ns=1
  .  00000195:  99 02 00                                        LAT 2 ISSUE
  .  00000198:  98 03 00                                        LAT 3 TOT
  .  0000019b:  52 c2 00                                        EV RETIRED NOT-TAKEN MISPRED
  .  0000019e:  4a 01                                           B COND
  .  000001a0:  b1 10 e1 20 2a ee b7 ff c0                      TGT 0xffb7ee2a20e110 el2 ns=1
  .  000001a9:  00 00 00 00 00 00                               PAD
  .  000001af:  71 bc a4 d6 78 3f 07 00 00                      TS 7969191666876
  [...]
  .  00000ef4:  b0 44 3a fe 29 ee b7 ff c0                      PC 0xffb7ee29fe3a44 el2 ns=1
  .  00000efd:  99 07 00                                        LAT 7 ISSUE
  .  00000f00:  98 08 00                                        LAT 8 TOT
  .  00000f03:  52 82 00                                        EV RETIRED MISPRED
  .  00000f06:  4a 01                                           B COND
  .  00000f08:  b1 20 3a fe 29 ee b7 ff c0                      TGT 0xffb7ee29fe3a20 el2 ns=1
  .  00000f11:  00 00 00 00 00 00                               PAD
  .  00000f17:  71 1e 06 d7 78 3f 07 00 00                      TS 7969191691806
  [...]
  .  00000f20:  b0 fc 87 fc 29 ee b7 ff c0                      PC 0xffb7ee29fc87fc el2 ns=1
  .  00000f29:  99 06 00                                        LAT 6 ISSUE
  .  00000f2c:  98 07 00                                        LAT 7 TOT
  .  00000f2f:  52 82 00                                        EV RETIRED MISPRED
  .  00000f32:  4a 01                                           B COND
  .  00000f34:  b1 08 88 fc 29 ee b7 ff c0                      TGT 0xffb7ee29fc8808 el2 ns=1
  .  00000f3d:  00 00 00 00 00 00                               PAD
  .  00000f43:  71 e1 07 d7 78 3f 07 00 00                      TS 7969191692257
  [...]
  .  00000ffc:  b0 18 24 fd 29 ee b7 ff c0                      PC 0xffb7ee29fd2418 el2 ns=1
  .  00001005:  99 02 00                                        LAT 2 ISSUE
  .  00001008:  98 03 00                                        LAT 3 TOT
  .  0000100b:  52 c2 00                                        EV RETIRED NOT-TAKEN MISPRED
  .  0000100e:  4a 01                                           B COND
  .  00001010:  b1 1c 24 fd 29 ee b7 ff c0                      TGT 0xffb7ee29fd241c el2 ns=1
  .  00001019:  00 00 00 00 00 00                               PAD
  .  0000101f:  71 e9 11 d7 78 3f 07 00 00                      TS 7969191694825
  [...]
  .  00001188:  b0 c0 e0 20 2a ee b7 ff c0                      PC 0xffb7ee2a20e0c0 el2 ns=1
  .  00001191:  99 02 00                                        LAT 2 ISSUE
  .  00001194:  98 03 00                                        LAT 3 TOT
  .  00001197:  52 c2 00                                        EV RETIRED NOT-TAKEN MISPRED
  .  0000119a:  4a 01                                           B COND
  .  0000119c:  b1 c4 e0 20 2a ee b7 ff c0                      TGT 0xffb7ee2a20e0c4 el2 ns=1
  .  000011a5:  00 00 00 00 00 00                               PAD
  .  000011ab:  71 40 1e d7 78 3f 07 00 00                      TS 7969191697984
  [...]
  .  00001c5c:  b0 2c 8c fd 6c fd ff 00 80                      PC 0xfffd6cfd8c2c el0 ns=1
  .  00001c65:  99 02 00                                        LAT 2 ISSUE
  .  00001c68:  98 03 00                                        LAT 3 TOT
  .  00001c6b:  52 c2 00                                        EV RETIRED NOT-TAKEN MISPRED
  .  00001c6e:  4a 01                                           B COND
  .  00001c70:  b1 30 8c fd 6c fd ff 00 80                      TGT 0xfffd6cfd8c30 el0 ns=1
  .  00001c79:  00 00 00 00 00 00                               PAD
  .  00001c7f:  71 36 03 d8 78 3f 07 00 00                      TS 7969191756598
  [...]
  .  00001e40:  b0 00 0b de 6c fd ff 00 80                      PC 0xfffd6cde0b00 el0 ns=1
  .  00001e49:  99 02 00                                        LAT 2 ISSUE
  .  00001e4c:  98 03 00                                        LAT 3 TOT
  .  00001e4f:  52 82 00                                        EV RETIRED MISPRED
  .  00001e52:  4a 01                                           B COND
  .  00001e54:  b1 50 0b de 6c fd ff 00 80                      TGT 0xfffd6cde0b50 el0 ns=1
  .  00001e5d:  00 00 00 00 00 00                               PAD
  .  00001e63:  71 0f 1d d8 78 3f 07 00 00                      TS 7969191763215
  [...]
  .  00002234:  b0 e0 60 f3 29 ee b7 ff c0                      PC 0xffb7ee29f360e0 el2 ns=1
  .  0000223d:  99 02 00                                        LAT 2 ISSUE
  .  00002240:  98 03 00                                        LAT 3 TOT
  .  00002243:  52 82 00                                        EV RETIRED MISPRED
  .  00002246:  4a 01                                           B COND
  .  00002248:  b1 68 61 f3 29 ee b7 ff c0                      TGT 0xffb7ee29f36168 el2 ns=1
  .  00002251:  00 00 00 00 00 00                               PAD
  .  00002257:  71 7d 27 d8 78 3f 07 00 00                      TS 7969191765885
  [...]
  .  0000228c:  b0 60 b0 fd 6c fd ff 00 80                      PC 0xfffd6cfdb060 el0 ns=1
  .  00002295:  99 0e 00                                        LAT 14 ISSUE
  .  00002298:  98 0f 00                                        LAT 15 TOT
  .  0000229b:  52 c2 00                                        EV RETIRED NOT-TAKEN MISPRED
  .  0000229e:  4a 01                                           B COND
  .  000022a0:  b1 64 b0 fd 6c fd ff 00 80                      TGT 0xfffd6cfdb064 el0 ns=1
  .  000022a9:  00 00 00 00 00 00                               PAD
  .  000022af:  71 af 2b d8 78 3f 07 00 00                      TS 7969191766959
  [...]
  .  00002af8:  b0 28 7a fe 6c fd ff 00 80                      PC 0xfffd6cfe7a28 el0 ns=1
  .  00002b01:  99 03 00                                        LAT 3 ISSUE
  .  00002b04:  98 04 00                                        LAT 4 TOT
  .  00002b07:  52 c2 00                                        EV RETIRED NOT-TAKEN MISPRED
  .  00002b0a:  4a 01                                           B COND
  .  00002b0c:  b1 2c 7a fe 6c fd ff 00 80                      TGT 0xfffd6cfe7a2c el0 ns=1
  .  00002b15:  00 00 00 00 00 00                               PAD
  .  00002b1b:  71 95 50 d8 78 3f 07 00 00                      TS 7969191776405
  [...]
  .  00002b50:  b0 28 7a fe 6c fd ff 00 80                      PC 0xfffd6cfe7a28 el0 ns=1
  .  00002b59:  99 05 00                                        LAT 5 ISSUE
  .  00002b5c:  98 06 00                                        LAT 6 TOT
  .  00002b5f:  52 02 00                                        EV RETIRED
  .  00002b62:  4a 01                                           B COND
  .  00002b64:  b1 10 7a fe 6c fd ff 00 80                      TGT 0xfffd6cfe7a10 el0 ns=1
  .  00002b6d:  00 00 00 00 00 00                               PAD
  .  00002b73:  71 f3 51 d8 78 3f 07 00 00                      TS 7969191776755
  [...]
  .  00003498:  b0 30 29 e7 6c fd ff 00 80                      PC 0xfffd6ce72930 el0 ns=1
  .  000034a1:  99 0b 00                                        LAT 11 ISSUE
  .  000034a4:  98 0c 00                                        LAT 12 TOT
  .  000034a7:  52 42 00                                        EV RETIRED NOT-TAKEN
  .  000034aa:  4a 01                                           B COND
  .  000034ac:  b1 34 29 e7 6c fd ff 00 80                      TGT 0xfffd6ce72934 el0 ns=1
  .  000034b5:  00 00 00 00 00 00                               PAD
  .  000034bb:  71 ea 86 d8 78 3f 07 00 00                      TS 7969191790314
  [...]
  .  00003ba4:  b0 78 95 fe 29 ee b7 ff c0                      PC 0xffb7ee29fe9578 el2 ns=1
  .  00003bad:  99 02 00                                        LAT 2 ISSUE
  .  00003bb0:  98 03 00                                        LAT 3 TOT
  .  00003bb3:  52 82 00                                        EV RETIRED MISPRED
  .  00003bb6:  4a 01                                           B COND
  .  00003bb8:  b1 2c 95 fe 29 ee b7 ff c0                      TGT 0xffb7ee29fe952c el2 ns=1
  .  00003bc1:  00 00 00 00 00 00                               PAD
  .  00003bc7:  71 3a b0 d8 78 3f 07 00 00                      TS 7969191800890
  [...]
  .  00003d04:  b0 14 c0 d8 6c fd ff 00 80                      PC 0xfffd6cd8c014 el0 ns=1
  .  00003d0d:  99 02 00                                        LAT 2 ISSUE
  .  00003d10:  98 03 00                                        LAT 3 TOT
  .  00003d13:  52 82 00                                        EV RETIRED MISPRED
  .  00003d16:  4a 01                                           B COND
  .  00003d18:  b1 e8 c0 d8 6c fd ff 00 80                      TGT 0xfffd6cd8c0e8 el0 ns=1
  .  00003d21:  00 00 00 00 00 00                               PAD
  .  00003d27:  71 51 ba d8 78 3f 07 00 00                      TS 7969191803473
  [...]
  .  00003ff0:  b0 60 0e dd 6c fd ff 00 80                      PC 0xfffd6cdd0e60 el0 ns=1
  .  00003ff9:  99 03 00                                        LAT 3 ISSUE
  .  00003ffc:  98 04 00                                        LAT 4 TOT
  .  00003fff:  52 82 00                                        EV RETIRED MISPRED
  .  00004002:  4a 01                                           B COND
  .  00004004:  b1 d8 0e dd 6c fd ff 00 80                      TGT 0xfffd6cdd0ed8 el0 ns=1
  .  0000400d:  00 00 00 00 00 00                               PAD
  .  00004013:  71 e0 d2 d8 78 3f 07 00 00                      TS 7969191809760
  [...]
  # perf script
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee29f38200 do_mmap+0x60 ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee2a20e10c __pi_memcpy+0x8c ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee29fe3a44 __d_lookup_rcu+0xe4 ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee29fc87fc cp_new_stat+0x11c ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee29fd2418 link_path_walk.part.35+0x198 ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee2a20e0c0 __pi_memcpy+0x40 ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cfd8c2c [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cde0b00 memset+0x18 (/usr/lib64/libc-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee29f360e0 __split_vma+0x110 ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cfdb060 [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cfe7a28 [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cfe7a28 [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6ce72930 _dl_addr+0x110 (/usr/lib64/libc-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:  ffffb7ee29fe9578 atime_needs_update+0x120 ([kernel.kallsyms])
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cd8c014 [unknown] (/usr/lib64/libc-2.28.so)
              ls 107690 [005]  7969.191661:          1                            branch-miss:      fffd6cdd0e60 [unknown] (/usr/lib64/libc-2.28.so)

Solution:
  Set "sample->time" to the timestamp corresponding to each packet in auxtrace.

After:

  # perf script
              ls 107690 [005]  7969.191665:          1                            branch-miss:  ffffb7ee29f38200 do_mmap+0x60 ([kernel.kallsyms])
              ls 107690 [005]  7969.191666:          1                            branch-miss:  ffffb7ee2a20e10c __pi_memcpy+0x8c ([kernel.kallsyms])
              ls 107690 [005]  7969.191691:          1                            branch-miss:  ffffb7ee29fe3a44 __d_lookup_rcu+0xe4 ([kernel.kallsyms])
              ls 107690 [005]  7969.191692:          1                            branch-miss:  ffffb7ee29fc87fc cp_new_stat+0x11c ([kernel.kallsyms])
              ls 107690 [005]  7969.191694:          1                            branch-miss:  ffffb7ee29fd2418 link_path_walk.part.35+0x198 ([kernel.kallsyms])
              ls 107690 [005]  7969.191697:          1                            branch-miss:  ffffb7ee2a20e0c0 __pi_memcpy+0x40 ([kernel.kallsyms])
              ls 107690 [005]  7969.191756:          1                            branch-miss:      fffd6cfd8c2c [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191763:          1                            branch-miss:      fffd6cde0b00 memset+0x18 (/usr/lib64/libc-2.28.so)
              ls 107690 [005]  7969.191765:          1                            branch-miss:  ffffb7ee29f360e0 __split_vma+0x110 ([kernel.kallsyms])
              ls 107690 [005]  7969.191766:          1                            branch-miss:      fffd6cfdb060 [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191776:          1                            branch-miss:      fffd6cfe7a28 [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191782:          1                            branch-miss:      fffd6cfe7a28 [unknown] (/usr/lib64/ld-2.28.so)
              ls 107690 [005]  7969.191791:          1                            branch-miss:      fffd6ce72930 _dl_addr+0x110 (/usr/lib64/libc-2.28.so)
              ls 107690 [005]  7969.191800:          1                            branch-miss:  ffffb7ee29fe9578 atime_needs_update+0x120 ([kernel.kallsyms])
              ls 107690 [005]  7969.191803:          1                            branch-miss:      fffd6cd8c014 [unknown] (/usr/lib64/libc-2.28.so)
              ls 107690 [005]  7969.191809:          1                            branch-miss:      fffd6cdd0e60 [unknown] (/usr/lib64/libc-2.28.so)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2539d4baec44..c4550cc1b248 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -231,7 +231,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	struct arm_spe_record *record = &speq->decoder->record;
 
 	if (!spe->timeless_decoding)
-		sample->time = speq->timestamp;
+		sample->time = record->timestamp;
 
 	sample->ip = record->from_ip;
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
-- 
2.30.GIT

