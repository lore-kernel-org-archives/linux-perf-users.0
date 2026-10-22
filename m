Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693515;
	b=qweTxEBMlXOaPxEyvMVaOo/02jKRJtoZJgz094EirvdJGbSJRHjRu+pKhzrBPs/d35zh
	 zOm5MaNSDtAsvdlzsrRnB+oEJe9TTSAsXjqTuNjqmHj0AcRE6bJmlJnwKpYbT/CA5f4RJ
	 abi3PURGARnrLuW3xswGTt9zuEctkFbvyYsElIcJr1iBrssyLY0M0Nei+ZB5eIeX5x7da
	 CjIKw6U3SkGnj8RE3M4J5Com/BKIRZehgtyJ4J/QNXLcD8Ds3rxty52YfSY5wyV3U/wq1
	 oSXiJ5OKCGnu3+GCIuw43atpB4r0O5j+lEltO7rpUF8SVfcDh6UuZGuLhe3JiU+B6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a+BT1fTgoHjc4jMhc5cKAvQPGh7BOmTrmmD9FIb2ghU=;
	b=YIm8WNoBaAJ293ns9BqtxAWNYkVTW38JDfsmP63im+3HG8N4Uh9QFY1Zp1wmTDFEfdM7
	 Jmv69n7lYMjefM0sn6M/jUzAFL0AlTytTJrpYSWFOmo4JhR1fFmZtpJp+b1l1vZxURLu2
	 SSqtx7bm5B/ekybgkXuJmYpRCyMoIbVg/cGbVrSAnNFQXQHG8xcUCmjZ/0u7tNrTE7rEO
	 /BdzU5DAKIpfr+zPMUjLQVxuE8WT81jkMr9bihgsFfDZsIwko+GVOHLYIV3T9hcChTavI
	 DWOB6df+q9michzyy5bDAc5Kx8j7swyWExP436/d/uoo4WlDzOAkqKSo53m+uMIKgzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESMPqDpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE6606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESMPqDpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037E41F01828;
	Thu, 22 Oct 2026 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693515;
	bh=a+BT1fTgoHjc4jMhc5cKAvQPGh7BOmTrmmD9FIb2ghU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESMPqDpz4s6lOdQH9xuMz3F66o3yL6G7y10eh03zJekM4AuoNRHDWEripJ4R0OF7P
	 L+yPBXKvWxO3I5SpDZkNnn8SbGQ/3Q61R472quWC8A2+UR1NCNSVkruI240q75VN83
	 Ost1sRdPbUjs1E2q8HE86g+ZoocQQBwSdE/Zp2TXD3Fg8xoysnHUAkMvA+IFbyj7QA
	 p4b6qBpGy3paek8clBZ0AHzJSXdYrQPwtcQJnNFC8deIR/cy5bpua9438jbXWsoXEU
	 zbbsfD0CYkicwqbXZpZMLcN03EOLT++URpsas040iHK5qZIOHmk55tsmkoEnjkVgMx
	 x+v/I+dsT3h4Q==
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
Subject: [PATCH v3 10/10] tools headers: Sync KVM headers with the kernel sources
Date: Thu, 22 Oct 2026 15:24:29 -0300
Message-ID: <20261022182431.25673-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
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
  7bb6284aa7b3 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")
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

