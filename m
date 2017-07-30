From: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] perf build: Clarify header version warning message
Date: Sun, 30 Jul 2017 11:37:47 +0200
Message-ID: <20170730093747.qogjn3lp7ntwcgwg@gmail.com>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36348 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdG3Jhw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 30 Jul 2017 05:37:52 -0400
Content-Disposition: inline
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eran>

Change this:

  Warning: arch/x86/include/asm/disabled-features.h differs from kernel
  Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
  Warning: arch/powerpc/include/uapi/asm/kvm.h differs from kernel
  Warning: arch/s390/include/uapi/asm/kvm.h differs from kernel

to:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
  Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'

... to make it clearer what the warning is about, and to make it easier to diff 
the two versions when syncing up the files.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/perf/check-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 9b6295809a3b..d87bc6af0ac2 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -47,7 +47,7 @@ check () {
   cmd="diff $opts ../$file ../../$file > /dev/null"
 
   test -f ../../$file &&
-  eval $cmd || echo "Warning: $file differs from kernel" >&2
+  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
 }
 
 
