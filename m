From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/9] tools headers kvm: Sync linux/kvm.h with the kernel sources
Date: Mon, 16 Dec 2019 17:47:30 -0300
Message-ID: <20191216204738.12107-2-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Bharata B Rao <bharata@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  22945688acd4 ("KVM: PPC: Book3S HV: Support reset of secure guest")

No tools changes are caused by this, as the only defines so far used
from these files are for syscall arg pretty printing are:

  $ grep KVM tools/perf/trace/beauty/*.sh
  tools/perf/trace/beauty/kvm_ioctl.sh:regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
  $

This addresses these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Bharata B Rao <bharata@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Link: https://lkml.kernel.org/n/tip-bdbe4x02johhul05a03o27zj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index e6f17c8e2dba..f0a16b4adbbd 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1348,6 +1348,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
 /* Available with KVM_CAP_PMU_EVENT_FILTER */
 #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
+#define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.21.0
