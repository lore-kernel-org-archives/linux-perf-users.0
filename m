From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/10] tooling headers: Synchronize updated s390 kvm UAPI headers
Date: Mon,  5 Feb 2018 16:56:12 -0300
Message-ID: <20180205195620.9010-3-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 35b3fde6203b ("KVM: s390: wire up bpb feature") was noticed by the
perf build process:

  Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'

The changes in this cset don't cause or require changes in tools/perf/,
so just update the copy to silence the build warning.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kif2fdkcaewj8iqw6lwyil8s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/s390/include/uapi/asm/kvm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 38535a57fef8..4cdaa55fabfe 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -224,6 +224,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_RICCB  (1UL << 7)
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
+#define KVM_SYNC_BPBC   (1UL << 10)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -247,7 +248,9 @@ struct kvm_sync_regs {
 	};
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
-	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
+	__u8 bpbc : 1;		/* bp mode */
+	__u8 reserved2 : 7;
+	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
 	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
 	union {
-- 
2.14.3
