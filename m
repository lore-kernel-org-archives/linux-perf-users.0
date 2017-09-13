From: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tools/include: Sync kernel ABI headers with tooling headers
Date: Wed, 13 Sep 2017 09:38:23 +0200
Message-ID: <20170913073823.lxmi4c7ejqlfabjx@gmail.com>
References: <20170912192438.1334-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38736 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdIMHi1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2017 03:38:27 -0400
Content-Disposition: inline
In-Reply-To: <20170912192438.1334-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

Time for a sync with ABI/uapi headers with the upcoming v4.14 kernel.

None of the ABI changes require any source code level changes to our
existing in-kernel tooling code:

  - tools/arch/s390/include/uapi/asm/kvm.h:

      New KVM_S390_VM_TOD_EXT ABI, not used by in-kernel tooling.

  - tools/arch/x86/include/asm/cpufeatures.h:
    tools/arch/x86/include/asm/disabled-features.h:

      New PCID, SME and VGIF x86 CPU feature bits defined.

  - tools/include/asm-generic/hugetlb_encode.h:
    tools/include/uapi/asm-generic/mman-common.h:
    tools/include/uapi/linux/mman.h:

      Two new madvise() flags, plus a hugetlb system call mmap flags
      restructuring/extension changes.

  - tools/include/uapi/drm/drm.h:
    tools/include/uapi/drm/i915_drm.h:

      New drm_syncobj_create flags definitions, new drm_syncobj_wait
      and drm_syncobj_array ABIs. DRM_I915_PERF_* calls and a new
      I915_PARAM_HAS_EXEC_FENCE_ARRAY ABI for the Intel driver.

  - tools/include/uapi/linux/bpf.h:

      New bpf_sock fields (::mark and ::priority), new XDP_REDIRECT
      action, new kvm_ppc_smmu_info fields (::data_keys, instr_keys)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/arch/s390/include/uapi/asm/kvm.h         |  6 +++
 tools/arch/x86/include/asm/cpufeatures.h       |  2 +
 tools/arch/x86/include/asm/disabled-features.h |  4 +-
 tools/include/asm-generic/hugetlb_encode.h     | 34 +++++++++++++++++
 tools/include/uapi/asm-generic/mman-common.h   | 14 ++-----
 tools/include/uapi/drm/drm.h                   | 22 +++++++++++
 tools/include/uapi/drm/i915_drm.h              | 51 +++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                 | 32 ++++++++++------
 tools/include/uapi/linux/kvm.h                 |  3 +-
 tools/include/uapi/linux/mman.h                | 24 +++++++++++-
 10 files changed, 164 insertions(+), 28 deletions(-)

diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 69d09c39bbcd..cd7359e23d86 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -88,6 +88,12 @@ struct kvm_s390_io_adapter_req {
 /* kvm attributes for KVM_S390_VM_TOD */
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
+#define KVM_S390_VM_TOD_EXT		2
+
+struct kvm_s390_vm_tod_clock {
+	__u8  epoch_idx;
+	__u64 tod;
+};
 
 /* kvm attributes for KVM_S390_VM_CPU_MODEL */
 /* processor related attributes are r/w */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 8ea315a11fe0..2519c6c801c9 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -196,6 +196,7 @@
 
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
+#define X86_FEATURE_SME		( 7*32+10) /* AMD Secure Memory Encryption */
 
 #define X86_FEATURE_INTEL_PPIN	( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
@@ -287,6 +288,7 @@
 #define X86_FEATURE_PFTHRESHOLD (15*32+12) /* pause filter threshold */
 #define X86_FEATURE_AVIC	(15*32+13) /* Virtual Interrupt Controller */
 #define X86_FEATURE_V_VMSAVE_VMLOAD (15*32+15) /* Virtual VMSAVE VMLOAD */
+#define X86_FEATURE_VGIF	(15*32+16) /* Virtual GIF */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx), word 16 */
 #define X86_FEATURE_AVX512VBMI  (16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 5dff775af7cd..c10c9128f54e 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -21,11 +21,13 @@
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
 # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
 # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
+# define DISABLE_PCID		0
 #else
 # define DISABLE_VME		0
 # define DISABLE_K6_MTRR	0
 # define DISABLE_CYRIX_ARR	0
 # define DISABLE_CENTAUR_MCR	0
+# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
@@ -49,7 +51,7 @@
 #define DISABLED_MASK1	0
 #define DISABLED_MASK2	0
 #define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	0
+#define DISABLED_MASK4	(DISABLE_PCID)
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	0
diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
new file mode 100644
index 000000000000..e4732d3c2998
--- /dev/null
+++ b/tools/include/asm-generic/hugetlb_encode.h
@@ -0,0 +1,34 @@
+#ifndef _ASM_GENERIC_HUGETLB_ENCODE_H_
+#define _ASM_GENERIC_HUGETLB_ENCODE_H_
+
+/*
+ * Several system calls take a flag to request "hugetlb" huge pages.
+ * Without further specification, these system calls will use the
+ * system's default huge page size.  If a system supports multiple
+ * huge page sizes, the desired huge page size can be specified in
+ * bits [26:31] of the flag arguments.  The value in these 6 bits
+ * will encode the log2 of the huge page size.
+ *
+ * The following definitions are associated with this huge page size
+ * encoding in flag arguments.  System call specific header files
+ * that use this encoding should include this file.  They can then
+ * provide definitions based on these with their own specific prefix.
+ * for example:
+ * #define MAP_HUGE_SHIFT HUGETLB_FLAG_ENCODE_SHIFT
+ */
+
+#define HUGETLB_FLAG_ENCODE_SHIFT	26
+#define HUGETLB_FLAG_ENCODE_MASK	0x3f
+
+#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+
+#endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 8c27db0c5c08..203268f9231e 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -58,20 +58,12 @@
 					   overrides the coredump filter bits */
 #define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
 
+#define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
+#define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
-/*
- * When MAP_HUGETLB is set bits [26:31] encode the log2 of the huge page size.
- * This gives us 6 bits, which is enough until someone invents 128 bit address
- * spaces.
- *
- * Assume these are all power of twos.
- * When 0 use the default page size.
- */
-#define MAP_HUGE_SHIFT	26
-#define MAP_HUGE_MASK	0x3f
-
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 101593ab10ac..97677cd6964d 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -700,6 +700,7 @@ struct drm_prime_handle {
 
 struct drm_syncobj_create {
 	__u32 handle;
+#define DRM_SYNCOBJ_CREATE_SIGNALED (1 << 0)
 	__u32 flags;
 };
 
@@ -718,6 +719,24 @@ struct drm_syncobj_handle {
 	__u32 pad;
 };
 
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
+struct drm_syncobj_wait {
+	__u64 handles;
+	/* absolute timeout */
+	__s64 timeout_nsec;
+	__u32 count_handles;
+	__u32 flags;
+	__u32 first_signaled; /* only valid when not waiting all */
+	__u32 pad;
+};
+
+struct drm_syncobj_array {
+	__u64 handles;
+	__u32 count_handles;
+	__u32 pad;
+};
+
 #if defined(__cplusplus)
 }
 #endif
@@ -840,6 +859,9 @@ extern "C" {
 #define DRM_IOCTL_SYNCOBJ_DESTROY	DRM_IOWR(0xC0, struct drm_syncobj_destroy)
 #define DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD	DRM_IOWR(0xC1, struct drm_syncobj_handle)
 #define DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE	DRM_IOWR(0xC2, struct drm_syncobj_handle)
+#define DRM_IOCTL_SYNCOBJ_WAIT		DRM_IOWR(0xC3, struct drm_syncobj_wait)
+#define DRM_IOCTL_SYNCOBJ_RESET		DRM_IOWR(0xC4, struct drm_syncobj_array)
+#define DRM_IOCTL_SYNCOBJ_SIGNAL	DRM_IOWR(0xC5, struct drm_syncobj_array)
 
 /**
  * Device specific ioctls should only be in their respective headers
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 7ccbd6a2bbe0..6598fb76d2c2 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -260,6 +260,8 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_GEM_CONTEXT_GETPARAM	0x34
 #define DRM_I915_GEM_CONTEXT_SETPARAM	0x35
 #define DRM_I915_PERF_OPEN		0x36
+#define DRM_I915_PERF_ADD_CONFIG	0x37
+#define DRM_I915_PERF_REMOVE_CONFIG	0x38
 
 #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
 #define DRM_IOCTL_I915_FLUSH		DRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
@@ -315,6 +317,8 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_GEM_CONTEXT_GETPARAM	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_GETPARAM, struct drm_i915_gem_context_param)
 #define DRM_IOCTL_I915_GEM_CONTEXT_SETPARAM	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_SETPARAM, struct drm_i915_gem_context_param)
 #define DRM_IOCTL_I915_PERF_OPEN	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_OPEN, struct drm_i915_perf_open_param)
+#define DRM_IOCTL_I915_PERF_ADD_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_ADD_CONFIG, struct drm_i915_perf_oa_config)
+#define DRM_IOCTL_I915_PERF_REMOVE_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_REMOVE_CONFIG, __u64)
 
 /* Allow drivers to submit batchbuffers directly to hardware, relying
  * on the security mechanisms provided by hardware.
@@ -431,6 +435,11 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_HAS_EXEC_BATCH_FIRST	 48
 
+/* Query whether DRM_I915_GEM_EXECBUFFER2 supports supplying an array of
+ * drm_i915_gem_exec_fence structures.  See I915_EXEC_FENCE_ARRAY.
+ */
+#define I915_PARAM_HAS_EXEC_FENCE_ARRAY  49
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
@@ -812,6 +821,17 @@ struct drm_i915_gem_exec_object2 {
 	__u64 rsvd2;
 };
 
+struct drm_i915_gem_exec_fence {
+	/**
+	 * User's handle for a drm_syncobj to wait on or signal.
+	 */
+	__u32 handle;
+
+#define I915_EXEC_FENCE_WAIT            (1<<0)
+#define I915_EXEC_FENCE_SIGNAL          (1<<1)
+	__u32 flags;
+};
+
 struct drm_i915_gem_execbuffer2 {
 	/**
 	 * List of gem_exec_object2 structs
@@ -826,7 +846,11 @@ struct drm_i915_gem_execbuffer2 {
 	__u32 DR1;
 	__u32 DR4;
 	__u32 num_cliprects;
-	/** This is a struct drm_clip_rect *cliprects */
+	/**
+	 * This is a struct drm_clip_rect *cliprects if I915_EXEC_FENCE_ARRAY
+	 * is not set.  If I915_EXEC_FENCE_ARRAY is set, then this is a
+	 * struct drm_i915_gem_exec_fence *fences.
+	 */
 	__u64 cliprects_ptr;
 #define I915_EXEC_RING_MASK              (7<<0)
 #define I915_EXEC_DEFAULT                (0<<0)
@@ -927,7 +951,14 @@ struct drm_i915_gem_execbuffer2 {
  * element).
  */
 #define I915_EXEC_BATCH_FIRST		(1<<18)
-#define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_BATCH_FIRST<<1))
+
+/* Setting I915_FENCE_ARRAY implies that num_cliprects and cliprects_ptr
+ * define an array of i915_gem_exec_fence structures which specify a set of
+ * dma fences to wait upon or signal.
+ */
+#define I915_EXEC_FENCE_ARRAY   (1<<19)
+
+#define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_FENCE_ARRAY<<1))
 
 #define I915_EXEC_CONTEXT_ID_MASK	(0xffffffff)
 #define i915_execbuffer2_set_context_id(eb2, context) \
@@ -1467,6 +1498,22 @@ enum drm_i915_perf_record_type {
 	DRM_I915_PERF_RECORD_MAX /* non-ABI */
 };
 
+/**
+ * Structure to upload perf dynamic configuration into the kernel.
+ */
+struct drm_i915_perf_oa_config {
+	/** String formatted like "%08x-%04x-%04x-%04x-%012x" */
+	char uuid[36];
+
+	__u32 n_mux_regs;
+	__u32 n_boolean_regs;
+	__u32 n_flex_regs;
+
+	__u64 __user mux_regs_ptr;
+	__u64 __user boolean_regs_ptr;
+	__u64 __user flex_regs_ptr;
+};
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 461811e57140..43ab5c402f98 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -143,12 +143,6 @@ enum bpf_attach_type {
 
 #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
 
-enum bpf_sockmap_flags {
-	BPF_SOCKMAP_UNSPEC,
-	BPF_SOCKMAP_STRPARSER,
-	__MAX_BPF_SOCKMAP_FLAG
-};
-
 /* If BPF_F_ALLOW_OVERRIDE flag is used in BPF_PROG_ATTACH command
  * to the given target_fd cgroup the descendent cgroup will be able to
  * override effective bpf program that was inherited from this cgroup
@@ -368,9 +362,20 @@ union bpf_attr {
  * int bpf_redirect(ifindex, flags)
  *     redirect to another netdev
  *     @ifindex: ifindex of the net device
- *     @flags: bit 0 - if set, redirect to ingress instead of egress
- *             other bits - reserved
- *     Return: TC_ACT_REDIRECT
+ *     @flags:
+ *	  cls_bpf:
+ *          bit 0 - if set, redirect to ingress instead of egress
+ *          other bits - reserved
+ *	  xdp_bpf:
+ *	    all bits - reserved
+ *     Return: cls_bpf: TC_ACT_REDIRECT on success or TC_ACT_SHOT on error
+ *	       xdp_bfp: XDP_REDIRECT on success or XDP_ABORT on error
+ * int bpf_redirect_map(map, key, flags)
+ *     redirect to endpoint in map
+ *     @map: pointer to dev map
+ *     @key: index in map to lookup
+ *     @flags: --
+ *     Return: XDP_REDIRECT on success or XDP_ABORT on error
  *
  * u32 bpf_get_route_realm(skb)
  *     retrieve a dst's tclassid
@@ -632,7 +637,7 @@ union bpf_attr {
 	FN(skb_adjust_room),		\
 	FN(redirect_map),		\
 	FN(sk_redirect_map),		\
-	FN(sock_map_update),
+	FN(sock_map_update),		\
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -753,20 +758,23 @@ struct bpf_sock {
 	__u32 family;
 	__u32 type;
 	__u32 protocol;
+	__u32 mark;
+	__u32 priority;
 };
 
 #define XDP_PACKET_HEADROOM 256
 
 /* User return codes for XDP prog type.
  * A valid XDP program must return one of these defined values. All other
- * return codes are reserved for future use. Unknown return codes will result
- * in packet drop.
+ * return codes are reserved for future use. Unknown return codes will
+ * result in packet drops and a warning via bpf_warn_invalid_xdp_action().
  */
 enum xdp_action {
 	XDP_ABORTED = 0,
 	XDP_DROP,
 	XDP_PASS,
 	XDP_TX,
+	XDP_REDIRECT,
 };
 
 /* user accessible metadata for XDP packet hook
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 6cd63c18708a..838887587411 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -711,7 +711,8 @@ struct kvm_ppc_one_seg_page_size {
 struct kvm_ppc_smmu_info {
 	__u64 flags;
 	__u32 slb_size;
-	__u32 pad;
+	__u16 data_keys;	/* # storage keys supported for data */
+	__u16 instr_keys;	/* # storage keys supported for instructions */
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index 81d8edf11789..a937480d7cd3 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -1,7 +1,8 @@
 #ifndef _UAPI_LINUX_MMAN_H
 #define _UAPI_LINUX_MMAN_H
 
-#include <uapi/asm/mman.h>
+#include <asm/mman.h>
+#include <asm-generic/hugetlb_encode.h>
 
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
@@ -10,4 +11,25 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
 
+/*
+ * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
+ * size other than the default is desired.  See hugetlb_encode.h.
+ * All known huge page size encodings are provided here.  It is the
+ * responsibility of the application to know which sizes are supported on
+ * the running system.  See mmap(2) man page for details.
+ */
+#define MAP_HUGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
+#define MAP_HUGE_MASK	HUGETLB_FLAG_ENCODE_MASK
+
+#define MAP_HUGE_64KB	HUGETLB_FLAG_ENCODE_64KB
+#define MAP_HUGE_512KB	HUGETLB_FLAG_ENCODE_512KB
+#define MAP_HUGE_1MB	HUGETLB_FLAG_ENCODE_1MB
+#define MAP_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
+#define MAP_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
+#define MAP_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define MAP_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define MAP_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
+#define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
+#define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
+
 #endif /* _UAPI_LINUX_MMAN_H */
