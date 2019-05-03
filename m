From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/11] tools uapi x86: Sync vmx.h with the kernel
Date: Thu,  2 May 2019 20:25:24 -0400
Message-ID: <20190503002533.29359-3-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  2b27924bb1d4 ("KVM: nVMX: always use early vmcs check when EPT is disabled")

That causes this object in the tools/perf build process to be rebuilt:

  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o

But it isn't using VMX_ABORT_ prefixed constants, so no change in
behaviour.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
  diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-bjbo3zc0r8i8oa0udpvftya6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f0b0c90dd398..d213ec5c3766 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -146,6 +146,7 @@
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
+#define VMX_ABORT_VMCS_CORRUPTED             3
 #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
 
 #endif /* _UAPIVMX_H */
-- 
2.20.1
