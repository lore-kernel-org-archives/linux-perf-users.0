From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/77] perf bpf: Give precedence to bpf header dir
Date: Wed,  5 Sep 2018 19:03:35 -0300
Message-ID: <20180905220440.20256-13-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I need to check the need for $KERNEL_INC_OPTIONS when building eBPF
restricted C programs, for now just give precedence to
$PERF_BPF_INC_OPTIONS so that we can get a linux/socket.h usable
in eBPF programs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5z7qw529sdebrn9y1xxqw9hf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 19262f98cd4e..5b0b60f00275 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -19,7 +19,7 @@
 #define CLANG_BPF_CMD_DEFAULT_TEMPLATE				\
 		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
 		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
-		"$CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS " \
+		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
 		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
-- 
2.14.4
