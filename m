From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 62/85] perf config: Update default value for llvm.clang-bpf-cmd-template
Date: Tue, 11 Jun 2019 15:58:48 -0300
Message-ID: <20190611185911.11645-63-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@redhat.com>, Mark Drayton <mbd@fb.com>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The clang bpf cmdline template has defined default value in the file
tools/perf/util/llvm-utils.c, which has been changed for several times.

This patch updates the documentation to reflect the latest default value
for the configuration llvm.clang-bpf-cmd-template.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: d35b168c3dcd ("perf bpf: Give precedence to bpf header dir")
Fixes: cb76371441d0 ("perf llvm: Allow passing options to llc in addition to clang")
Fixes: 1b16fffa389d ("perf llvm-utils: Add bpf include path to clang command line")
Link: http://lkml.kernel.org/r/20190607143508.18141-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 462b3cde0675..e4aa268d2e38 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -564,9 +564,12 @@ llvm.*::
 	llvm.clang-bpf-cmd-template::
 		Cmdline template. Below lines show its default value. Environment
 		variable is used to pass options.
-		"$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS $KERNEL_INC_OPTIONS \
-		-Wno-unused-value -Wno-pointer-sign -working-directory \
-		$WORKING_DIR  -c $CLANG_SOURCE -target bpf -O2 -o -"
+		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
+		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
+		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
+		"-Wno-unused-value -Wno-pointer-sign "		\
+		"-working-directory $WORKING_DIR "		\
+		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 	llvm.clang-opt::
 		Options passed to clang.
-- 
2.20.1
