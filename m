Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70113F412E;
	Wed, 13 May 2026 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687426; cv=none; b=E4PveUM+Xm3UQoP2Qp8z8oxpYkXTiP6y2zmaGbLSrbrY9Hsticx+vV5WZxnj+P4neGG96uasqnbB74ecRTZUOT5IbSPpFY8xk/z9lQtd9GaJQhWC1P9jDcpewTkYZ8qPAF9xbVS3gWS+8Lx+qK2sxJ2Wp1w7RaFmv46vs+6byNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687426; c=relaxed/simple;
	bh=ziH4xLtifV0/DQOr7pUtbkcleeUszvi4D9h06AQrwuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oALgbd+IdPHTb4b745Glgl7gyEiFKl1Hm9+HnLwiiLHdMoLELewFaRGs7ZGu2Kd1c8moz6kb8PDQM8S37NFZPaqIAe1twXq4e70VHuWLeUzMmz2a8EO+IEqWpN7WIxfXtvUp74UJ8sfI8Lw3OFCplE3v+3C8tCaFoG0Ya+VCxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Lee.localdomain (unknown [39.152.152.253])
	by APP-01 (Coremail) with SMTP id qwCowACHMm6MnQRqEXQgEA--.35827S3;
	Wed, 13 May 2026 23:50:08 +0800 (CST)
From: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	adrian.hunter@intel.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Subject: [PATCH 1/3] perf build: Fix cross-arch build failures by isolating auxtrace objects
Date: Wed, 13 May 2026 23:48:49 +0800
Message-ID: <20260513154851.1085334-2-guanli.oerv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHMm6MnQRqEXQgEA--.35827S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4Duw4ktF4UXr45Gr4rKrg_yoWxZFWkpw
	4kur15Zw1rGa1ay3sxZFn0gFy3twn5KFWF9F1fKw15Zr4xArWFqF4xtr1qgry7Jw1kt3yY
	9F4jgrWDur4FvFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbn2-7UUUUU==
X-CM-SenderInfo: hjxd0znlorv2ny6l223fol2u1dvotugofq/

Currently, tools/perf/util/Build hardcodes architecture-specific hardware
tracing objects (e.g., intel-pt.o, arm-spe.o, cs-etm-base.o) into the
generic perf-util-y list. When compiling on architectures that lack
these features (such as RISC-V), the compiler skips generating these
objects, causing the linker to fail with "No such file or directory"
or undefined references.

Fix this by decoupling the architecture-specific hardware tracing drivers
from the generic build process:
1. In Makefile.config, explicitly export CONFIG_PERF_XYZ feature flags
   only for their corresponding target architectures.
2. In util/Build, conditionally link these hardware tracing objects
   based on the newly exported feature flags.
3. In util/auxtrace.c, provide __weak stub functions returning -ENOSYS
   for the arch-specific processing routines. This ensures successful
   linking and graceful degradation when specific drivers are omitted.

Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
---
 tools/perf/Makefile.config | 21 ++++++++++++
 tools/perf/util/Build      | 20 +++++------
 tools/perf/util/auxtrace.c | 70 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  6 ++++
 4 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 06d7a3f999..13f4b98b2e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -107,6 +107,27 @@ ifeq ($(SRCARCH),loongarch)
   endif
 endif
 
+ifndef NO_AUXTRACE
+  ifeq ($(SRCARCH),x86)
+    $(call detected,CONFIG_PERF_INTEL_PT)
+    $(call detected,CONFIG_PERF_AMD_PT)
+  endif
+
+  ifeq ($(SRCARCH),arm64)
+    $(call detected,CONFIG_PERF_ARM_SPE)
+    $(call detected,CONFIG_PERF_HISI_PTT)
+    $(call detected,CONFIG_PERF_CS_ETM)
+  endif
+
+  ifeq ($(SRCARCH),s390)
+    $(call detected,CONFIG_PERF_S390_CPUMSF)
+  endif
+endif
+
+ifeq ($(SRCARCH),arm64)
+  $(call detected,CONFIG_PERF_ARM64_UNWIND_SUPPORT)
+endif
+
 ifeq ($(ARCH),s390)
   CFLAGS += -fPIC
 endif
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d008..79ade6066d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -132,21 +132,21 @@ perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += kvm-stat-arch/
 perf-util-y += lock-contention.o
 perf-util-y += auxtrace.o
-perf-util-y += intel-pt-decoder/
-perf-util-y += intel-pt.o
-perf-util-y += intel-bts.o
-perf-util-y += arm-spe.o
-perf-util-y += arm-spe-decoder/
-perf-util-y += hisi-ptt.o
-perf-util-y += hisi-ptt-decoder/
-perf-util-y += s390-cpumsf.o
+perf-util-$(CONFIG_PERF_INTEL_PT) += intel-pt-decoder/
+perf-util-$(CONFIG_PERF_INTEL_PT) += intel-pt.o
+perf-util-$(CONFIG_PERF_INTEL_PT) += intel-bts.o
+perf-util-$(CONFIG_PERF_ARM_SPE) += arm-spe.o
+perf-util-$(CONFIG_PERF_ARM_SPE) += arm-spe-decoder/
+perf-util-$(CONFIG_PERF_HISI_PTT) += hisi-ptt.o
+perf-util-$(CONFIG_PERF_HISI_PTT) += hisi-ptt-decoder/
+perf-util-$(CONFIG_PERF_S390_CPUMSF) += s390-cpumsf.o
 perf-util-y += powerpc-vpadtl.o
 
 ifdef CONFIG_LIBOPENCSD
 perf-util-y += cs-etm.o
 perf-util-y += cs-etm-decoder/
 endif
-perf-util-y += cs-etm-base.o
+perf-util-$(CONFIG_PERF_CS_ETM) += cs-etm-base.o
 
 perf-util-y += parse-branch-options.o
 perf-util-y += parse-regs-options.o
@@ -168,7 +168,7 @@ perf-util-y += clockid.o
 perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
-perf-util-y += intel-tpebs.o
+perf-util-$(CONFIG_PERF_INTEL_PT) += intel-tpebs.o
 
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a224687ffb..f6e426c3c5 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -51,6 +51,7 @@
 #include "cs-etm.h"
 #include "intel-pt.h"
 #include "intel-bts.h"
+#include "intel-tpebs.h"
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "s390-cpumsf.h"
@@ -2960,3 +2961,72 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 
 	return session->auxtrace->evsel_is_auxtrace(session, evsel);
 }
+
+/*
+ * Stub functions for architecture-specific features to support cross-platform building.
+ * These weak symbols are overridden by strong symbols when the corresponding
+ * architecture-specific code is compiled in.
+ */
+#ifndef HAVE_ARCH_X86_64_SUPPORT
+int __weak intel_pt_process_auxtrace_info(union perf_event *event __maybe_unused,
+					  struct perf_session *session __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak intel_bts_process_auxtrace_info(union perf_event *event __maybe_unused,
+					   struct perf_session *session __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak evsel__tpebs_open(struct evsel *evsel __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+void __weak evsel__tpebs_close(struct evsel *evsel __maybe_unused)
+{
+}
+
+int __weak evsel__tpebs_read(struct evsel *evsel __maybe_unused,
+			     int cpu_map_idx __maybe_unused,
+			     int thread __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak insn_decode(void *insn __maybe_unused, const void *kaddr __maybe_unused,
+		       int len __maybe_unused, int mode __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#ifndef HAVE_ARCH_ARM64_SUPPORT
+int __weak arm_spe_process_auxtrace_info(union perf_event *event __maybe_unused,
+					 struct perf_session *session __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak hisi_ptt_process_auxtrace_info(union perf_event *event __maybe_unused,
+					  struct perf_session *session __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
+					 struct perf_session *session __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#ifndef HAVE_ARCH_S390_SUPPORT
+int __weak s390_cpumsf_process_auxtrace_info(union perf_event *event __maybe_unused,
+					     struct perf_session *session __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+#endif
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6947f3f284..474e9445b4 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -699,4 +699,10 @@ void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
 	opts->range_num = 0;
 }
 
+/*
+ * Prototypes for architecture-specific functions that require weak stubs
+ * to support cross-platform builds on non-x86 architectures.
+ */
+int insn_decode(void *insn, const void *kaddr, int len, int mode);
+
 #endif
-- 
2.54.0

