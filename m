Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622206;
	b=dWLxk9l5bVVWwrwLtXgADJZRUcOrAPy5WYCCMseYnMYqrbr7Mtu9aH2tnuWE/97QQSX5
	 wuFMdkfqj8GBr0LbF7etYSQVRhBkediOpyN4Qk971gvSOqrK42tXLCGhFObglFXK4DHeA
	 ipTpCSQtBAiaOOXh8u0tJafF0xD6DMjadr9gNAhCDO1rgMaJICCKdeLl/OcB/m4fCw7wQ
	 HV9IFl4aG9g0/S0u1zeJp1dfFtI99r2VkJmqbuIOWrzd8iBCPp1JmSEhwtlXmfNjtenVj
	 LoefHl2QEXeysaPuCtU39j9n/BvHqxqapGecX+RTl7zOVILnr6NlGe18s7N+PCOnfdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ppPX1D211whwYwW6bORVrBkEgUW9Yj2zFZiUSzrAYEI=;
	b=4uNuNiIbOBPJ5EPWKF15bW4DsHYrf3j3K8bYOsyZ5wlV7Lt1vrHOESEDl9/3cLRBNiaA
	 wLzaz9lI8nbAvHDsGUJI+J04KTTJl8WmreT6ZFdDyO02Ap8V3kdPhHRbXosf8XWL0x7ji
	 L/Y06PfPVd8fCO+mdmMfH2iax0I50QWdMWtfV0Vx6IfAYwyZMnXXYKjg6Yl1+aqGBWa9G
	 Lrz8zwzrjA+w6pYH7t/1Kg3ffJZUn6JPiiTnnEGdUW2dwTDQo71v+gRJKHvjdeybVR7jj
	 78mbFvnWMULEz615XqEnNX4HLKxG7cgV/ksJk0YhDEDCGaShy80oOT0wWO04XJLtDFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uew7lNRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3435606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uew7lNRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A491F000C1;
	Wed, 21 Oct 2026 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622205;
	bh=ppPX1D211whwYwW6bORVrBkEgUW9Yj2zFZiUSzrAYEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uew7lNRVPM56WJsimT/vWy4jBq711bm0baZmH/Y6a+Tp1pajK7MI+LU4l2ChrE/W8
	 HMyK9rBbg4LCx2szgUon/LuJfFnWAN99tJ2TjyBNdozdop7VlrFR458EEFbjikFsqI
	 OQ7aOKDhy4mADULtIt1qaBJydtzIDkMjcVUh0322PQ+qIFXN+8CyGITQUh2JyHTaBs
	 q9h6Id3y0WUBhmxHJqfzvgfpD+Rq+nDR5q1/coBgCo/xm4mwc7TnJ8BkJ0CI+N6O2p
	 SyWPYaFAl1cAncSfusikvbC0SMnw7TYihGQdNCquNFOL6bvgWnCfPwGmlomy0nxscY
	 n8pK+CnlPxdQA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Congkai Tan <congkai@amazon.com>
Subject: [PATCH v2 12/12] tools headers: Sync KVM headers with the kernel sources
Date: Wed, 21 Oct 2026 19:35:51 -0300
Message-ID: <20261021223555.28372-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  ac3e65ddddf3 ("KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl")
  ad220e275c39 ("KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_STRICT vCPU feature")
  b76fb087efcd ("KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM")
  453f6ff04b8d ("KVM: arm64: Expose PMMIR_EL1.SLOTS under strict PMUv3 UAPI")

That don't result in changes to the string tables generated from these headers.

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
    diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
    diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Congkai Tan <congkai@amazon.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h   |  1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h | 18 ++++++++++++++++++
 tools/include/uapi/linux/kvm.h            |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 1c13bfa2d38aada4..019e5e3d892e6dc5 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -106,6 +106,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
 #define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
+#define KVM_ARM_VCPU_PMU_V3_STRICT	9 /* No default PMU creation */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 077c5437f5219b05..913a64b901a3d702 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -437,6 +437,24 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
+
+/*
+ * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
+ * These bits indicate which processor compatibility modes are supported.
+ */
+#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
+#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
+#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
+#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
+					 KVM_PPC_COMPAT_CAP_POWER10 | \
+					 KVM_PPC_COMPAT_CAP_POWER11)
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 419011097fa8e2c6..ac2d77d14963560d 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -997,6 +997,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
+#define KVM_CAP_ARM_PMU_V3_STRICT 251
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1341,6 +1343,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.56.0

