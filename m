From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/19] perf/urgent fixes for 4.18
Date: Tue, 26 Jun 2018 08:46:33 +0200
Message-ID: <20180626064633.GA25879@gmail.com>
References: <20180625174045.25765-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@fb.com>, Andi Kleen <ak@linux.intel.com>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Boqun Feng <boqun.feng@gmail.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Leblond <eric@regit.org>, Hangbin Liu <liuhangbin@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.co>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 57d6a7938a8fc6cee8420b40ca244220b41721f5:
> 
>   perf/core: Move the inline keyword at the beginning of the function declaration (2018-06-22 11:07:47 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180625
> 
> for you to fetch changes up to 92ead7ee30c80f8852d28735cbcb9d79bc85f715:
> 
>   perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE] (2018-06-25 11:59:37 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf bench: (Jiri Olsa):
> 
> . Fix NUMA report output code handling of less than 1s runtimes.
> 
> perf script: (Ravi Bangoria)
> 
> . Add missing output fields in a 'perf script -h' hint.
> 
> . Fix crash because of missing evsel->priv.
> 
> . Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE], which
>   is just a end of features header marker.
> 
> perf stat: (Thomas Richter)
> 
> . Remove duplicate event counting
> 
> perf test:
> 
> . Wire parsing error handling in 'parse events' test (Jiri Olsa)
> 
> . Fix 'session topology' test on s/390 (Thomas Richter)
> 
> eBPF: (Yonghong Song)
> 
> . Fix a clang 7.0 compilation error when building perf linking
>   with libclang
> 
> intel-pt: (Adrian Hunter)
> 
> . Fix packet decoding of CYC packets.
> 
> Copies of kernel files: (Arnaldo Carvalho de Melo)
> 
> . Synchronize drm/drm.h UAPI
> 
> . Update x86's syscall_64.tbl, adding support for 'io_pgetevents' and 'rseq'
>   in 'perf trace'.
> 
> . Update powerpc uapi/asm/unistd.h, adding support for the 'rseq' syscall.
> 
> . Update if_link.h and bpf.h, no effect on tool features.
> 
> PowerPC: (Sandipan Das)
> 
> . Fix crash if callchain is empty.
> 
> s/390: (Thomas Richter)
> 
> . Support random socked_id assignment in the perf header.
> 
> . Support s390 random socket_id assignment in perf.data file.
> 
> . Make PMU alias definitions taken from sysfs and JSON files comparable
>   by normalizing them wrt spaces and newlines.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf intel-pt: Fix packet decoding of CYC packets
> 
> Arnaldo Carvalho de Melo (5):
>       tools headers uapi: Synchronize drm/drm.h
>       perf tools: Update x86's syscall_64.tbl, adding 'io_pgetevents' and 'rseq'
>       tools include powerpc: Update arch/powerpc/include/uapi/asm/unistd.h copy to get 'rseq' syscall
>       tools include uapi: Update if_link.h to pick IFLA_{BRPORT_ISOLATED,VXLAN_TTL_INHERIT}
>       tools include uapi: Synchronize bpf.h with the kernel
> 
> Jiri Olsa (3):
>       perf tests: Add event parsing error handling to parse events test
>       perf tests: Add valid callback for parse-events test
>       perf bench: Fix numa report output code
> 
> Ravi Bangoria (3):
>       perf script: Add missing output fields in a hint
>       perf script: Fix crash because of missing evsel->priv
>       perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATURE]
> 
> Sandipan Das (1):
>       perf report powerpc: Fix crash if callchain is empty
> 
> Thomas Richter (5):
>       perf record: Support s390 random socket_id assignment
>       perf test session topology: Fix test on s390
>       perf alias: Remove trailing newline when reading sysfs files
>       perf alias: Rebuild alias expression string to make it comparable
>       perf stat: Remove duplicate event counting
> 
> Yonghong Song (1):
>       perf tools: Fix a clang 7.0 compilation error
> 
>  tools/arch/powerpc/include/uapi/asm/unistd.h       |  1 +
>  tools/include/uapi/drm/drm.h                       |  7 ++
>  tools/include/uapi/linux/bpf.h                     |  2 +-
>  tools/include/uapi/linux/if_link.h                 |  2 +
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c  |  2 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  2 +
>  tools/perf/bench/numa.c                            |  5 +-
>  tools/perf/builtin-annotate.c                      | 11 ++-
>  tools/perf/builtin-report.c                        |  3 +-
>  tools/perf/builtin-script.c                        | 30 ++++++-
>  tools/perf/tests/parse-events.c                    | 25 ++++--
>  tools/perf/tests/topology.c                        |  1 +
>  tools/perf/util/c++/clang.cpp                      | 11 ++-
>  tools/perf/util/header.c                           | 12 ++-
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  2 +-
>  tools/perf/util/pmu.c                              | 99 +++++++++++++++++++++-
>  16 files changed, 194 insertions(+), 21 deletions(-)

Pulled, thanks a lot Arnaldo!

Note that I've applied the trivial header sync patch below on top of it to reduce 
the number of build time warnings.

There's one warning left:

 Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'

Which is a bit more involved as it requires the introduction of x86/asm/mcsafe_test.h
on the tooling side.

Thanks,

	Ingo

======================>
From 32fdbd90cc03f01d452138bab4d8a120873d6acf Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 26 Jun 2018 08:43:14 +0200
Subject: [PATCH] tools/headers: Pick up latest kernel ABIs

Sync KVM ABI additions and x86 CPU features additions - neither of which
has any impact on the tooling build.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/arch/arm/include/uapi/asm/kvm.h     | 1 +
 tools/arch/arm64/include/uapi/asm/kvm.h   | 1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h | 1 +
 tools/arch/x86/include/asm/cpufeatures.h  | 2 ++
 tools/include/uapi/linux/kvm.h            | 1 +
 5 files changed, 6 insertions(+)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index caae4843cb70..16e006f708ca 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 04b3256f8e6d..4e76630dd655 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -91,6 +91,7 @@ struct kvm_regs {
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
 #define KVM_VGIC_ITS_ADDR_TYPE		4
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 833ed9a16adf..1b32b56a03d3 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -633,6 +633,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+#define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index fb00a2fca990..5701f5cecd31 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -282,7 +282,9 @@
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
+#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 39e364c70caf..b6270a3b38e9 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_HYPERV_TLBFLUSH 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
