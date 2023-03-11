Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1379C678D5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 07:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCKHAn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 02:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCKHAT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 02:00:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E224144971
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 206-20020a2504d7000000b00b3511d10748so1664893ybe.20
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517988;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDZRiNR1kad/WxpM67261adKoiNeiwCkEjVOswz/Du8=;
        b=Qar2HPMwoJnDCU1nMENaqbKWaIzPwEhzKCXuGu6xIXt7R10Hny8ebMx5xJuCo+0AaZ
         5MxuFuGKLr5jurHhGyIOkCrTplilQ/NZC1Bfds0gFdQ8zg81J/w8nVud4/mZEnP37JlT
         wFLa0XGYGh6wQX6gpN7fmSkrID8hxSCPRDWU/ZjiB97czpaFt+waeyO3tpLEcICsHNvU
         Zn8J/FgSlcr/3/r8OvxY8B4MRvBl7PUjj25q1WfgLnZkKihw7Jb7qpcL3L0SilfdmFao
         bQBB1c6SAivx9uEiJMkIk1rmHCOGEvavdUtFb/6PdevU9zZSgI3GJfm8ViMxA6K+KksY
         cpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517988;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDZRiNR1kad/WxpM67261adKoiNeiwCkEjVOswz/Du8=;
        b=P+uLY50BMkcmPBKzzzkL/e8Npl0eaepl6ntoXXdI9lIpkhjyIUmELEPVO2u1djiNyN
         J4t9xIHL40e9mrLo0epW8ATbTGTf6zfREzODj3ByniBiaeJLvCZVu1nLeDiMxGFo9mOC
         G68/DC0dWR3dSYu3YJwDUJJDCiypuvwZkWN15r5GsIuGUW8QsyimLS29JztdQKnQhPPG
         xbELdhH+/jF/9z3Y1aa1rz4VyivaMzNM/liwqmzHi2fAQhIJzYLvnTGEo5o+pIvD3bcP
         YLJUoB/AIl8tJ38YSbVA5gjgoJyEp/LnUoRmqaYb3D8fluhw9khqeiLV7qore7DGfwLy
         Jy7g==
X-Gm-Message-State: AO0yUKVxz/8hwVQ3xzVy4e2VYQQvVTnIrGwK5MEmR6urK+Ffx/s+HG9e
        wpmC/1RXx1orwOdSKfOmYrOf6TG78yvZ
X-Google-Smtp-Source: AK7set8KKtJzMrDa/KnaM5s2BCn70inzmhuSkD1+nv8GOxneFhveneuG+MuzGLlpwnYa/S52Gml26DPS8UJV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:b70c:0:b0:541:6881:be0b with SMTP id
 v12-20020a81b70c000000b005416881be0bmr0ywh.188.1678517988166; Fri, 10 Mar
 2023 22:59:48 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:52 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-13-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 12/13] tools headers: Make the difference output easier to read
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add failures to an array and display it before exiting. Before:

```
Warning: Kernel ABI header at 'tools/include/uapi/linux/fcntl.h' differs from latest version at 'include/uapi/linux/fcntl.h'
diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
...
```

After:
```
Warning: Kernel ABI header differences:
  tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
  tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/check-headers.sh | 229 ++++++++++++++++++++----------------
 1 file changed, 125 insertions(+), 104 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index eacca9a874e2..f848b425d936 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -1,113 +1,121 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-FILES='
-include/uapi/linux/const.h
-include/uapi/drm/drm.h
-include/uapi/drm/i915_drm.h
-include/uapi/linux/fadvise.h
-include/uapi/linux/fcntl.h
-include/uapi/linux/fs.h
-include/uapi/linux/fscrypt.h
-include/uapi/linux/kcmp.h
-include/uapi/linux/kvm.h
-include/uapi/linux/in.h
-include/uapi/linux/mount.h
-include/uapi/linux/openat2.h
-include/uapi/linux/perf_event.h
-include/uapi/linux/prctl.h
-include/uapi/linux/sched.h
-include/uapi/linux/stat.h
-include/uapi/linux/usbdevice_fs.h
-include/uapi/linux/vhost.h
-include/uapi/sound/asound.h
-include/linux/bits.h
-include/vdso/bits.h
-include/linux/const.h
-include/vdso/const.h
-include/linux/hash.h
-include/linux/list-sort.h
-include/uapi/linux/hw_breakpoint.h
-arch/x86/include/asm/disabled-features.h
-arch/x86/include/asm/required-features.h
-arch/x86/include/asm/cpufeatures.h
-arch/x86/include/asm/inat_types.h
-arch/x86/include/asm/emulate_prefix.h
-arch/x86/include/asm/irq_vectors.h
-arch/x86/include/asm/msr-index.h
-arch/x86/include/uapi/asm/prctl.h
-arch/x86/lib/x86-opcode-map.txt
-arch/x86/tools/gen-insn-attr-x86.awk
-arch/arm/include/uapi/asm/perf_regs.h
-arch/arm64/include/uapi/asm/perf_regs.h
-arch/mips/include/uapi/asm/perf_regs.h
-arch/powerpc/include/uapi/asm/perf_regs.h
-arch/s390/include/uapi/asm/perf_regs.h
-arch/x86/include/uapi/asm/perf_regs.h
-arch/x86/include/uapi/asm/kvm.h
-arch/x86/include/uapi/asm/kvm_perf.h
-arch/x86/include/uapi/asm/svm.h
-arch/x86/include/uapi/asm/unistd.h
-arch/x86/include/uapi/asm/vmx.h
-arch/powerpc/include/uapi/asm/kvm.h
-arch/s390/include/uapi/asm/kvm.h
-arch/s390/include/uapi/asm/kvm_perf.h
-arch/s390/include/uapi/asm/ptrace.h
-arch/s390/include/uapi/asm/sie.h
-arch/arm/include/uapi/asm/kvm.h
-arch/arm64/include/uapi/asm/kvm.h
-arch/arm64/include/uapi/asm/unistd.h
-arch/alpha/include/uapi/asm/errno.h
-arch/mips/include/asm/errno.h
-arch/mips/include/uapi/asm/errno.h
-arch/parisc/include/uapi/asm/errno.h
-arch/powerpc/include/uapi/asm/errno.h
-arch/sparc/include/uapi/asm/errno.h
-arch/x86/include/uapi/asm/errno.h
-include/asm-generic/bitops/arch_hweight.h
-include/asm-generic/bitops/const_hweight.h
-include/asm-generic/bitops/__fls.h
-include/asm-generic/bitops/fls.h
-include/asm-generic/bitops/fls64.h
-include/linux/coresight-pmu.h
-include/uapi/asm-generic/errno.h
-include/uapi/asm-generic/errno-base.h
-include/uapi/asm-generic/ioctls.h
-include/uapi/asm-generic/mman-common.h
-include/uapi/asm-generic/unistd.h
-'
-
-SYNC_CHECK_FILES='
-arch/x86/include/asm/inat.h
-arch/x86/include/asm/insn.h
-arch/x86/lib/inat.c
-arch/x86/lib/insn.c
-'
+YELLOW='\033[0;33m'
+NC='\033[0m' # No Color
+
+declare -a FILES
+FILES=(
+  "include/uapi/linux/const.h"
+  "include/uapi/drm/drm.h"
+  "include/uapi/drm/i915_drm.h"
+  "include/uapi/linux/fadvise.h"
+  "include/uapi/linux/fcntl.h"
+  "include/uapi/linux/fs.h"
+  "include/uapi/linux/fscrypt.h"
+  "include/uapi/linux/kcmp.h"
+  "include/uapi/linux/kvm.h"
+  "include/uapi/linux/in.h"
+  "include/uapi/linux/mount.h"
+  "include/uapi/linux/openat2.h"
+  "include/uapi/linux/perf_event.h"
+  "include/uapi/linux/prctl.h"
+  "include/uapi/linux/sched.h"
+  "include/uapi/linux/stat.h"
+  "include/uapi/linux/usbdevice_fs.h"
+  "include/uapi/linux/vhost.h"
+  "include/uapi/sound/asound.h"
+  "include/linux/bits.h"
+  "include/vdso/bits.h"
+  "include/linux/const.h"
+  "include/vdso/const.h"
+  "include/linux/hash.h"
+  "include/linux/list-sort.h"
+  "include/uapi/linux/hw_breakpoint.h"
+  "arch/x86/include/asm/disabled-features.h"
+  "arch/x86/include/asm/required-features.h"
+  "arch/x86/include/asm/cpufeatures.h"
+  "arch/x86/include/asm/inat_types.h"
+  "arch/x86/include/asm/emulate_prefix.h"
+  "arch/x86/include/asm/irq_vectors.h"
+  "arch/x86/include/asm/msr-index.h"
+  "arch/x86/include/uapi/asm/prctl.h"
+  "arch/x86/lib/x86-opcode-map.txt"
+  "arch/x86/tools/gen-insn-attr-x86.awk"
+  "arch/arm/include/uapi/asm/perf_regs.h"
+  "arch/arm64/include/uapi/asm/perf_regs.h"
+  "arch/mips/include/uapi/asm/perf_regs.h"
+  "arch/powerpc/include/uapi/asm/perf_regs.h"
+  "arch/s390/include/uapi/asm/perf_regs.h"
+  "arch/x86/include/uapi/asm/perf_regs.h"
+  "arch/x86/include/uapi/asm/kvm.h"
+  "arch/x86/include/uapi/asm/kvm_perf.h"
+  "arch/x86/include/uapi/asm/svm.h"
+  "arch/x86/include/uapi/asm/unistd.h"
+  "arch/x86/include/uapi/asm/vmx.h"
+  "arch/powerpc/include/uapi/asm/kvm.h"
+  "arch/s390/include/uapi/asm/kvm.h"
+  "arch/s390/include/uapi/asm/kvm_perf.h"
+  "arch/s390/include/uapi/asm/ptrace.h"
+  "arch/s390/include/uapi/asm/sie.h"
+  "arch/arm/include/uapi/asm/kvm.h"
+  "arch/arm64/include/uapi/asm/kvm.h"
+  "arch/arm64/include/uapi/asm/unistd.h"
+  "arch/alpha/include/uapi/asm/errno.h"
+  "arch/mips/include/asm/errno.h"
+  "arch/mips/include/uapi/asm/errno.h"
+  "arch/parisc/include/uapi/asm/errno.h"
+  "arch/powerpc/include/uapi/asm/errno.h"
+  "arch/sparc/include/uapi/asm/errno.h"
+  "arch/x86/include/uapi/asm/errno.h"
+  "include/asm-generic/bitops/arch_hweight.h"
+  "include/asm-generic/bitops/const_hweight.h"
+  "include/asm-generic/bitops/__fls.h"
+  "include/asm-generic/bitops/fls.h"
+  "include/asm-generic/bitops/fls64.h"
+  "include/linux/coresight-pmu.h"
+  "include/uapi/asm-generic/errno.h"
+  "include/uapi/asm-generic/errno-base.h"
+  "include/uapi/asm-generic/ioctls.h"
+  "include/uapi/asm-generic/mman-common.h"
+  "include/uapi/asm-generic/unistd.h"
+)
+
+declare -a SYNC_CHECK_FILES
+SYNC_CHECK_FILES=(
+  "arch/x86/include/asm/inat.h"
+  "arch/x86/include/asm/insn.h"
+  "arch/x86/lib/inat.c"
+  "arch/x86/lib/insn.c"
+)
 
 # These copies are under tools/perf/trace/beauty/ as they are not used to in
 # building object files only by scripts in tools/perf/trace/beauty/ to generate
 # tables that then gets included in .c files for things like id->string syscall
 # tables (and the reverse lookup as well: string -> id)
 
-BEAUTY_FILES='
-include/linux/socket.h
-'
+declare -a BEAUTY_FILES
+BEAUTY_FILES=(
+  "include/linux/socket.h"
+)
+
+declare -a FAILURES
 
 check_2 () {
-  file1=$1
-  file2=$2
+  tools_file=$1
+  orig_file=$2
 
   shift
   shift
 
-  cmd="diff $* $file1 $file2 > /dev/null"
+  cmd="diff $* $tools_file $orig_file > /dev/null"
 
-  test -f $file2 && {
-    eval $cmd || {
-      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
-      echo diff -u $file1 $file2
-    }
-  }
+  if [ -f "$orig_file" ] && ! eval "$cmd"
+  then
+    FAILURES+=(
+      "$tools_file $orig_file"
+    )
+  fi
 }
 
 check () {
@@ -115,7 +123,7 @@ check () {
 
   shift
 
-  check_2 tools/$file $file $*
+  check_2 "tools/$file" "$file" $*
 }
 
 beauty_check () {
@@ -123,23 +131,29 @@ beauty_check () {
 
   shift
 
-  check_2 tools/perf/trace/beauty/$file $file $*
+  check_2 "tools/perf/trace/beauty/$file" "$file" $*
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
 # we're probably on a detached tarball, so no point in trying to check
 # differences.
-test -d ../../include || exit 0
+if ! [ -d ../../include ]
+then
+  echo -e "${YELLOW}Warning${NC}: Skipped check-headers due to missing ../../include"
+  exit 0
+fi
 
 cd ../..
 
 # simple diff check
-for i in $FILES; do
-  check $i -B
+for i in "${FILES[@]}"
+do
+  check "$i" -B
 done
 
-for i in $SYNC_CHECK_FILES; do
-  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+for i in "${SYNC_CHECK_FILES[@]}"
+do
+  check "$i" '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
 done
 
 # diff with extra ignore lines
@@ -160,8 +174,9 @@ check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/s
 check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
 
-for i in $BEAUTY_FILES; do
-  beauty_check $i -B
+for i in "${BEAUTY_FILES[@]}"
+do
+  beauty_check "$i" -B
 done
 
 # check duplicated library files
@@ -169,3 +184,9 @@ check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
 check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
 
 cd tools/perf
+
+echo -e "${YELLOW}Warning${NC}: Kernel ABI header differences:"
+for i in "${FAILURES[@]}"
+do
+  echo "  $i"
+done
-- 
2.40.0.rc1.284.g88254d51c5-goog

