From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/15] tools headers UAPI: Update tools's copy of kvm.h headers
Date: Fri, 28 Feb 2020 11:00:01 -0300
Message-ID: <20200228140014.1236-3-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oupton@google.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

No change in tooling ensues, just the x86 kvm tooling gets rebuilt as
those headers are included in its build:

  $ cp arch/x86/include/uapi/asm/kvm.h tools/arch/x86/include/uapi/asm/kvm.h
  $ make -C tools/perf
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j12' parallel build

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  <SNIP>
  ...        disassembler-four-args: [ on  ]

    DESCEND  plugins
    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  <SNIP>
    LD       /tmp/build/perf/arch/x86/util/perf-in.o
    LD       /tmp/build/perf/arch/x86/perf-in.o
    LD       /tmp/build/perf/arch/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf
  <SNIP>
  $

As it doesn't seem to be used there:

  $ grep STATE tools/perf/arch/x86/util/kvm-stat.c
  $

And the 'perf trace' beautifier table generator isn't interested in
these things:

  $ grep regex= tools/perf/trace/beauty/kvm_ioctl.sh
  regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Upton <oupton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 503d3f42da16..3f3f780c8c65 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -390,6 +390,7 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
+#define KVM_STATE_NESTED_MTF_PENDING	0x00000008
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
-- 
2.21.1
