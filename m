Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3531BD9D8;
	Fri,  8 Nov 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061103; cv=none; b=Hv71MC0GBCp0CEMSobW4vQfMYP+5OQnWbC8Gkd3sOsiUhbeSbBYfSgJVdUh0kjeIUv2Xqt7MFIfCu0mjii1rQOOrpKPNGslfrqVLtvwEsr/jr20IPv7jdBLl6hBBKQRxBsjRUjikZWlFlQDpr3krlLkvHYWv7Na7lgalVXW/N4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061103; c=relaxed/simple;
	bh=zDle9w2TZYT7v7dFRYfk4WEUd1oC/L1660lvsQ5FWs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmbxtaiZb44zt+UlZ26xa04anZmIuS0kbxEtBCDF36z6fN22EsSmmTEST7msg+RKDBTTr6OY4tKIKI7lMSt+26yI1yRM7aZKQzs2kobmXuN+dAJuAHe3TynJqWQ6lWxpiM9ey4eGkJ9bufBWjtyOpkh81m0wB46hftAZehh/5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XlFGG68f3z10V94;
	Fri,  8 Nov 2024 18:16:22 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id ACBE01800D9;
	Fri,  8 Nov 2024 18:18:11 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 18:18:10 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <mhiramat@kernel.org>, <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <dima@secretsauce.net>,
	<aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 2/2] perf probe: Fix the incorrect line number display in 'perf probe -l'
Date: Sat, 9 Nov 2024 02:19:09 +0800
Message-ID: <20241108181909.3515716-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108181909.3515716-1-lihuafei1@huawei.com>
References: <20241108181909.3515716-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)

I found an issue with the line number display in perf probe -l:

  # perf probe -l
    probe:schedule       (on schedule:-6751@kernel/sched/core.c)

I founded that in debuginfo__find_probe_point(), the fname obtained by
cu_find_lineinfo() is different from the result returned by
die_get_decl_file(). The 'baseline' and 'lineno' do not correspond to
the same file, resulting in an incorrect calculation of the line number
(lineno - baseline).

The DWARF dump information shows that the probed address
0xffff800080e55bc4 (i.e., schedule+20) has two source file information:

  # readelf --debug-dump=decodedline vmlinux | grep ffff800080e55bc4 -C 2
  ./arch/arm64/include/asm/current.h:
  current.h                                     19  0xffff800080e55bc0
  current.h                                     21  0xffff800080e55bc4               x
  current.h                                     21  0xffff800080e55bc4       1

  kernel/sched/core.c:
  core.c                                      6777  0xffff800080e55bc4       2       x
  core.c                                      6777  0xffff800080e55bc4       3       x
  core.c                                      6777  0xffff800080e55bc4       4       x
  core.c                                      6780  0xffff800080e55bc4       5       x

The first location corresponds to the inline function get_current(), and
cu_find_lineinfo() should have found this entry. However, the probed
instruction is actually in the schedule() function, which is
disassembled as follows:

  crash> disassemble/s schedule
  Dump of assembler code for function schedule:
  ./arch/arm64/include/asm/current.h:
  15      static __always_inline struct task_struct *get_current(void)
  16      {
  17              unsigned long sp_el0;
  18
  19              asm ("mrs %0, sp_el0" : "=r" (sp_el0));
     0xffff800080e55bb0 <+0>:     paciasp
  Dump of assembler code for function schedule:
  ./arch/arm64/include/asm/current.h:
  15      static __always_inline struct task_struct *get_current(void)
  16      {
  17              unsigned long sp_el0;
  18
  19              asm ("mrs %0, sp_el0" : "=r" (sp_el0));
     0xffff800080e55bb0 <+0>:     paciasp
     0xffff800080e55bb4 <+4>:     stp     x29, x30, [sp, #-32]!
     0xffff800080e55bb8 <+8>:     mov     x29, sp
     0xffff800080e55bbc <+12>:    stp     x19, x20, [sp, #16]
     0xffff800080e55bc0 <+16>:    mrs     x19, sp_el0

  kernel/sched/core.c:
  6780            if (!task_is_running(tsk))
     0xffff800080e55bc4 <+20>:    ldr     w0, [x19, #24]
     0xffff800080e55bc8 <+24>:    cbnz    w0, 0xffff800080e55bf8 <schedule+72>

And the DWARF function dump information:

  <1><11eae66>: Abbrev Number: 88 (DW_TAG_subprogram)
     <11eae67>   DW_AT_external    : 1
     <11eae67>   DW_AT_name        : (indirect string, offset: 0x233efb): schedule
     <11eae6b>   DW_AT_decl_file   : 18
     <11eae6c>   DW_AT_decl_line   : 6772
     <11eae6e>   DW_AT_decl_column : 35
     <11eae6f>   DW_AT_prototyped  : 1
     <11eae6f>   DW_AT_low_pc      : 0xffff800080e55bb0
     <11eae77>   DW_AT_high_pc     : 0xb8
     <11eae7f>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
     <11eae81>   DW_AT_GNU_all_call_sites: 1
     <11eae81>   DW_AT_sibling     : <0x11eb12d>
  <2><11eae85>: Abbrev Number: 50 (DW_TAG_variable)
     <11eae86>   DW_AT_name        : tsk
     <11eae8a>   DW_AT_decl_file   : 18
     <11eae8b>   DW_AT_decl_line   : 6774
     <11eae8d>   DW_AT_decl_column : 22
     <11eae8e>   DW_AT_type        : <0x11b2b34>
     <11eae92>   DW_AT_location    : 0x5be6f0 (location list)
     <11eae96>   DW_AT_GNU_locviews: 0x5be6ec
  <2><11eae9a>: Abbrev Number: 78 (DW_TAG_lexical_block)
     <11eae9b>   DW_AT_low_pc      : 0xffff800080e55bc4
     <11eaea3>   DW_AT_high_pc     : 0x0
     <11eaeab>   DW_AT_sibling     : <0x11eaeb9>

Therefore, here we should use the result of die_find_realfunc() +
die_get_decl_file(). However, regardless, we should verify if the fname
obtained from both is the same. If they are different, we should use the
latter to avoid inconsistencies between lineno, fname, and basefunc.

After the modification, the output is as follows:

  # perf probe -l
    probe:schedule       (on schedule+20@kernel/sched/core.c)

Fixes: 57f95bf5f882 ("perf probe: Show correct statement line number by perf probe -l")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/probe-finder.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 630e16c54ed5..106c9d6bd728 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1592,7 +1592,16 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 			goto post;
 		}
 
-		fname = die_get_decl_file(&spdie);
+		tmp = die_get_decl_file(&spdie);
+		/*
+		 * cu_find_lineinfo() uses cu_getsrc_die() to get fname, which
+		 * may differ from the result of die_get_decl_file(). Add a check
+		 * to ensure that lineno and baseline are in the same file.
+		 */
+		if (!tmp || (fname && strcmp(tmp, fname) != 0))
+			lineno = 0;
+		fname = tmp;
+
 		if (addr == baseaddr) {
 			/* Function entry - Relative line number is 0 */
 			lineno = baseline;
-- 
2.25.1

