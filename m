From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/11] tools headers kvm: Sync kvm headers with the kernel sources
Date: Thu, 17 Oct 2019 13:02:58 -0300
Message-ID: <20191017160301.20888-9-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in:

    0cb8410b90e7 ("kvm: svm: Intercept RDPRU")

That trigger a rebuild in too in tooling:

    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o

But this time around no changes in tooling results, as SVM_EXIT_RDPRU
wasn't added to SVM_EXIT_REASONS, that is used in kvm-stat.c.

And addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs from latest version at 'arch/x86/include/uapi/asm/svm.h'
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-pqzkt1hmfpqph3ts8i6zzmim@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/svm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index a9731f8a480f..2e8a30f06c74 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -75,6 +75,7 @@
 #define SVM_EXIT_MWAIT         0x08b
 #define SVM_EXIT_MWAIT_COND    0x08c
 #define SVM_EXIT_XSETBV        0x08d
+#define SVM_EXIT_RDPRU         0x08e
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
-- 
2.21.0
