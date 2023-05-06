Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A0EC77B73
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEFLFq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEFLFp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:05:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 563B361AE
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:05:44 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8AxHuuHNFZkXL0FAA--.9457S3;
        Sat, 06 May 2023 19:05:43 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxDbOFNFZkSmxNAA--.10164S3;
        Sat, 06 May 2023 19:05:42 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 10/18] tools headers UAPI: Sync the unistd with the kernel sources
Date:   Sat,  6 May 2023 19:05:14 +0800
Message-Id: <d708dad1d9811f3fe847a02a52f73ca1fa477181.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxDbOFNFZkSmxNAA--.10164S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr4rArWDKr4kJr1kuFW3ZFb_yoW5Kw1rpF
        n7CrykAF1rZr18A34fuF1kXrW093s7WF47Jr4IkrZ5uFnay340kry7WFZ8tF17X3yUGrW8
        ZF10grW5W3W8XFDanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bhAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E
        87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
        0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
        I7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIzBTUUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 7608f70adcb1ea69 ("s390: wire up memfd_secret system call")
  commit 5c289a59b1d08fd8 ("cachestat: implement cachestat syscall")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls
   /syscall.tbl' differs from latest version at 'arch/s390/kernel
    /syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390
   /kernel/syscalls/syscall.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls
   /syscall_64.tbl' differs from latest version at 'arch/x86/entry
   /syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86
  /entry/syscalls/syscall_64.tbl
  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h'
   differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi
   /asm-generic/unistd.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/uapi/asm-generic/unistd.h           | 5 ++++-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl   | 2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..cd639fae9086 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_cachestat 451
+__SYSCALL(__NR_cachestat, sys_cachestat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 799147658dee..b68f47541169 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -449,7 +449,7 @@
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
-# 447 reserved for memfd_secret
+447  common	memfd_secret		sys_memfd_secret		sys_memfd_secret
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..38db4b1c291a 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	cachestat		sys_cachestat
+452	64	map_shadow_stack	sys_map_shadow_stack
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.31.4

