From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/18] perf build: Clarify header version warning message
Date: Tue,  1 Aug 2017 16:56:28 -0300
Message-ID: <20170801195645.16986-2-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Change this:

  Warning: arch/x86/include/asm/disabled-features.h differs from kernel
  Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
  Warning: arch/powerpc/include/uapi/asm/kvm.h differs from kernel
  Warning: arch/s390/include/uapi/asm/kvm.h differs from kernel

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
  Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'

... to make it clearer what the warning is about, and to make it easier
to diff the two versions when syncing up the files.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Geneviève Bastien <gbastien@versatic.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Julien Desfossez <jdesfossez@efficios.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170730093747.qogjn3lp7ntwcgwg@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
 
-- 
2.9.4
