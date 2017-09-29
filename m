From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/7] perf tools: Get all of tools/{arch,include}/ in the MANIFEST
Date: Fri, 29 Sep 2017 13:00:11 -0300
Message-ID: <20170929160017.29335-2-acme@kernel.org>
References: <20170929160017.29335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929160017.29335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that I'm switching the container builds from using a local volume
pointing to the kernel repository with the perf sources, instead getting
a detached tarball to be able to use a container cluster, some places
broke because I forgot to put some of the required files in
tools/perf/MANIFEST, namely some bitsperlong.h files.

So, to fix it do the same as for tools/build/ and pack the whole
tools/arch/ directory.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-wmenpjfjsobwdnfde30qqncj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/MANIFEST | 87 ++---------------------------------------------------
 1 file changed, 2 insertions(+), 85 deletions(-)

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 62072822dc85..627b7cada144 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -1,34 +1,8 @@
 tools/perf
-tools/arch/alpha/include/asm/barrier.h
-tools/arch/arm/include/asm/barrier.h
-tools/arch/arm64/include/asm/barrier.h
-tools/arch/ia64/include/asm/barrier.h
-tools/arch/mips/include/asm/barrier.h
-tools/arch/powerpc/include/asm/barrier.h
-tools/arch/s390/include/asm/barrier.h
-tools/arch/sh/include/asm/barrier.h
-tools/arch/sparc/include/asm/barrier.h
-tools/arch/sparc/include/asm/barrier_32.h
-tools/arch/sparc/include/asm/barrier_64.h
-tools/arch/tile/include/asm/barrier.h
-tools/arch/x86/include/asm/barrier.h
-tools/arch/x86/include/asm/cmpxchg.h
-tools/arch/x86/include/asm/cpufeatures.h
-tools/arch/x86/include/asm/disabled-features.h
-tools/arch/x86/include/asm/required-features.h
-tools/arch/x86/include/uapi/asm/svm.h
-tools/arch/x86/include/uapi/asm/vmx.h
-tools/arch/x86/include/uapi/asm/kvm.h
-tools/arch/x86/include/uapi/asm/kvm_perf.h
-tools/arch/x86/lib/memcpy_64.S
-tools/arch/x86/lib/memset_64.S
-tools/arch/s390/include/uapi/asm/kvm_perf.h
-tools/arch/s390/include/uapi/asm/sie.h
-tools/arch/xtensa/include/asm/barrier.h
+tools/arch
 tools/scripts
 tools/build
-tools/arch/x86/include/asm/atomic.h
-tools/arch/x86/include/asm/rmwcc.h
+tools/include
 tools/lib/traceevent
 tools/lib/api
 tools/lib/bpf
@@ -42,60 +16,3 @@ tools/lib/find_bit.c
 tools/lib/bitmap.c
 tools/lib/str_error_r.c
 tools/lib/vsprintf.c
-tools/include/asm/alternative-asm.h
-tools/include/asm/atomic.h
-tools/include/asm/barrier.h
-tools/include/asm/bug.h
-tools/include/asm-generic/atomic-gcc.h
-tools/include/asm-generic/barrier.h
-tools/include/asm-generic/bitops/arch_hweight.h
-tools/include/asm-generic/bitops/atomic.h
-tools/include/asm-generic/bitops/const_hweight.h
-tools/include/asm-generic/bitops/__ffs.h
-tools/include/asm-generic/bitops/__ffz.h
-tools/include/asm-generic/bitops/__fls.h
-tools/include/asm-generic/bitops/find.h
-tools/include/asm-generic/bitops/fls64.h
-tools/include/asm-generic/bitops/fls.h
-tools/include/asm-generic/bitops/hweight.h
-tools/include/asm-generic/bitops.h
-tools/include/linux/atomic.h
-tools/include/linux/bitops.h
-tools/include/linux/compiler.h
-tools/include/linux/compiler-gcc.h
-tools/include/linux/coresight-pmu.h
-tools/include/linux/bug.h
-tools/include/linux/filter.h
-tools/include/linux/hash.h
-tools/include/linux/kernel.h
-tools/include/linux/list.h
-tools/include/linux/log2.h
-tools/include/uapi/asm-generic/fcntl.h
-tools/include/uapi/asm-generic/ioctls.h
-tools/include/uapi/asm-generic/mman-common.h
-tools/include/uapi/asm-generic/mman.h
-tools/include/uapi/drm/drm.h
-tools/include/uapi/drm/i915_drm.h
-tools/include/uapi/linux/bpf.h
-tools/include/uapi/linux/bpf_common.h
-tools/include/uapi/linux/fcntl.h
-tools/include/uapi/linux/hw_breakpoint.h
-tools/include/uapi/linux/kvm.h
-tools/include/uapi/linux/mman.h
-tools/include/uapi/linux/perf_event.h
-tools/include/uapi/linux/sched.h
-tools/include/uapi/linux/stat.h
-tools/include/uapi/linux/vhost.h
-tools/include/uapi/sound/asound.h
-tools/include/linux/poison.h
-tools/include/linux/rbtree.h
-tools/include/linux/rbtree_augmented.h
-tools/include/linux/refcount.h
-tools/include/linux/string.h
-tools/include/linux/stringify.h
-tools/include/linux/types.h
-tools/include/linux/err.h
-tools/include/linux/bitmap.h
-tools/include/linux/time64.h
-tools/arch/*/include/uapi/asm/mman.h
-tools/arch/*/include/uapi/asm/perf_regs.h
-- 
2.13.5
