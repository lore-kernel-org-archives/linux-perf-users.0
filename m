From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/11] tools headers kvm: Sync kvm headers with the kernel sources
Date: Thu, 17 Oct 2019 13:02:57 -0300
Message-ID: <20191017160301.20888-8-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Tao Xu <tao3.xu@intel.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in:

  bf653b78f960 ("KVM: vmx: Introduce handle_unexpected_vmexit and handle WAITPKG vmexit")

That trigger these changes in tooling:

    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
    INSTALL  GTK UI
    DESCEND  plugins
  make[3]: Nothing to be done for '/tmp/build/perf/plugins/libtraceevent-dynamic-list'.
    INSTALL  trace_plugins
    LD       /tmp/build/perf/arch/x86/util/perf-in.o
    LD       /tmp/build/perf/arch/x86/perf-in.o
    LD       /tmp/build/perf/arch/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf

And this is not just because that header is included, kvm-stat.c
uses the VMX_EXIT_REASONS define and it got changed by the above cset.

And addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
  diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tao Xu <tao3.xu@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-gr1eel0hckmi5l3p2ewdpfxh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f01950aa7fae..3eb8411ab60e 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -86,6 +86,8 @@
 #define EXIT_REASON_PML_FULL            62
 #define EXIT_REASON_XSAVES              63
 #define EXIT_REASON_XRSTORS             64
+#define EXIT_REASON_UMWAIT              67
+#define EXIT_REASON_TPAUSE              68
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -144,7 +146,9 @@
 	{ EXIT_REASON_RDSEED,                "RDSEED" }, \
 	{ EXIT_REASON_PML_FULL,              "PML_FULL" }, \
 	{ EXIT_REASON_XSAVES,                "XSAVES" }, \
-	{ EXIT_REASON_XRSTORS,               "XRSTORS" }
+	{ EXIT_REASON_XRSTORS,               "XRSTORS" }, \
+	{ EXIT_REASON_UMWAIT,                "UMWAIT" }, \
+	{ EXIT_REASON_TPAUSE,                "TPAUSE" }
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
-- 
2.21.0
