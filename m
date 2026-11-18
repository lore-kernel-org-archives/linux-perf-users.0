Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989638;
	b=FMKgVdm1vQLJbC2pTTXSgqNxs6Noex8r5xJLcryhBqDVet3nezP+Cz+rM2poqYopRScN
	 9LO0b4xmVS4AMNyCh92YhZeB8zEDgXEmlXUJ9S02rSvOWQt03ikgHbGbHbLrFhFd5mp0H
	 +HMp2xICL4cWzvy/T+867Dq1PcZc+xHolvusC321dFAAxpvF3O6fr78PCE+B2JVC5/4Nz
	 8uMA7sbOqeImRX/ig1KIdRKLgOU+Xl07LxqdwUdFLT2WaSCB2JegmETg6dNsxrzlICsJI
	 hegANsr+2F7ijOFHepiDdC1eHTRn871/PUa4BIugsIq29DZ43TSfsnCAewVfffWwZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XJZ+Hdtk3ZgO4GcY5jYam6jCeDolIL+Wbgosemj6TVw=;
	b=XrNHDM0Dbm0bzSAcmdC9WimtHDzI+nDy0X+RM8kBi4e9lufnXcllQr0OFAiP2TePHXz5
	 rdSSNGjgDNqICojNAHcZ3Pv3Wv57prydadWiw87fgNv1mMoJ5uIJZJRbvcDsRlwOtqRm4
	 FuBbOjUIwh+vaJU21mCVnWzo8s6qkBcpRCaJOXh91ES1Dw55feMClcwcdXnoWsPkR6vlX
	 bIUXbjB5zE9lphTevE1M1Cpb77ZBQIt0wLSaYdHLTiL3YNX4wogNWX1UBxlPkuVKcjkbv
	 dN43KtjHCtJuJhLDkluTmS7Vj4H6bzNGBLF03IW3NC3UrufK5dXNaNuChjS1/fnhLUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CIunQBLg;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41F606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F41F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CIunQBLg
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso539021a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 00:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794989638; x=1795594438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJZ+Hdtk3ZgO4GcY5jYam6jCeDolIL+Wbgosemj6TVw=;
        b=CIunQBLgc0sEPmk5ppffRBSZDZbkW76BiQOaZUO8soHExpBHJnYv8WDK4meLo+agIy
         vzIkRO+obk6Ot1fmhUYUiuYvABmbRemfhQuQUOV2jdimXfCnYvtX0z/+0uFTcD5uBq6v
         Zm/G0xUvKa7xXb3P6PtdF3bbeTMmH5XitnUspTjYLOWzUXJXsyh5ma7+MYGvcq/mCPES
         6GlWX5i55NsE+df9rb6hhDEQKBzvirUY7tAzV1kj7U3hn/59uBGkFtUYz8Xe95QrQqhT
         WySkCR11s4NpK6cZiPLtRM5nQIr9L0rcKuKwYdEvVTutvsF8xk7vB4ParRr9xy+5ClKp
         dt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989638; x=1795594438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJZ+Hdtk3ZgO4GcY5jYam6jCeDolIL+Wbgosemj6TVw=;
        b=c+Fqx1obAVFjtR7jwg63KVG5JeZBmOHPH4pAqzvc7fP4pDpnqvI+l6wxXG4XQH+ABH
         griMrVnk7JkELB3spqC5SKqxNX5ze19APC0BzcWIRO/+wO5vOvnYteoLjQuipI7SiiXu
         1Q3d2NFCmoarNC2aLXAp9zfVKpss6yVtdi6UG3LXW5KaZjXBhOtQKkYVGdeJU/zdU+Kn
         Ym9jnwfyL7/OVDWyZ/mlljy1rnBamkbTaXZ4fX4/tVMK3wL6lzXiWq9vQ1xWjRrcg2Mo
         glV08X5UmLrYOSJDAQdPhypW6YLAxAn8UDB4aJuXpyjIzllCdnTx2KOjoq8fygr9+lfD
         KM0Q==
X-Forwarded-Encrypted: i=1; AL+hErFjHSW+PiS6q75HeFCfLo7ZKqhYn2ES6ldn4M1mKYdfarWjlcR46rMfKL+WnOo7rAiZc2+X7gwgkdY6kJXaStvm@vger.kernel.org
X-Gm-Message-State: APuU4Z+OGPYG/kwXEbpmHgc9pM+B/k4jSBDB783HmyhnxPNyl2B+bBcy
	RrMJ40giOpS+JRvSsNwXUmduttIK+HirF1QqswBrEOLG6yiLVYNhdhuLuUeQDQ3ZEUY=
X-Gm-Gg: AZFdTZf1CZ8gbCdjGnRUXVzvahDykTmBTyVOMGRUksT2do1mK1h3xicgF2NGG5sESLm
	nHvTFUbod1qbVi7JpKmt363qaJ4k/iM3HibMkinv/hXfDeEuOH2nPaCT2nDcGYvisZ+5LhW1Eoe
	3QK8ZaGDDGD+qamiQFHwqqqwnp12mqM9xYnxFksxu8obdQfExBzX50eDlyJd+7v8NRs9QQZJb3i
	V6t31AZfzCLdy5OMJemn0EY7J6rf3s9ZRAlnBtl/1pt/K2FSohh8JQdM877qnq6pJxZqWR0i1Gp
	frBeas3/OwUriddvFRR3bn75LuBcdDRA9MnOCMRpwKtzQQGA5ONreISoon8LOMGOvD+H+/0Mn7d
	nGHSpKz/GSFNtghAOhhZp1lgTsXoZOzPX/DvxiY7SgQB1O7CkK2emNN8Wvk8AxL+u+7ke8l4t8H
	v2h1w9swxUor1KTtE9AAEoTPXi2irCZAC2GFoFnIoVDH0lMW/upPl0BU8b/6morSE/PksbUH8jb
	sQGB2HjYd9jjTEt25Hf34Rs3fXQWn/c0ejlrdqtZXKBDwuwrVFVJdkJSPy/d/bluW6S2yBofvvW
	0F0K3zRhVE+On20Eu7TEIZceF83ppRiCufT3142+xXfgVySbL8tDzmW+3g3ZfWpf0UtyXxOIXck
	Z3OGm1jk=
X-Received: by 2002:a17:90b:1e48:b0:3ac:9e76:aa97 with SMTP id 98e67ed59e1d1-3b3d0640e52mr1931726a91.6.1794989637815;
        Wed, 18 Nov 2026 00:13:57 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acde50sm3254680a91.14.2026.11.18.00.13.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 00:13:57 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	andrew.jones@linux.dev,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	atish.patra@linux.dev,
	anup@brainfault.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	yuanzhu@bytedance.com,
	cuiyunhui@bytedance.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	will@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [RFC PATCH v1 2/5] riscv: Detect Smpdis and Sspdis ISA extensions
Date: Wed, 18 Nov 2026 16:13:30 +0800
Message-ID: <20261118081327.10684-9-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
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

Register separate machine and supervisor PDIS extension bits with the
existing ISA parser. Reuse the DT extension-list and legacy/RHCT parsing
paths without adding userspace hwprobe bits or inferring S-mode access
from an M-mode declaration.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b5952db9259f..0eea8158b4af 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -126,6 +126,8 @@
 #define RISCV_ISA_EXT_ZIC64B		116
 #define RISCV_ISA_EXT_SV48		117
 #define RISCV_ISA_EXT_SV57		118
+#define RISCV_ISA_EXT_SMPDIS		119
+#define RISCV_ISA_EXT_SSPDIS		120
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 72bce616491f..982231fa290a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -651,12 +651,14 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(smpdis, RISCV_ISA_EXT_SMPDIS),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA_VALIDATE(ssccfg, RISCV_ISA_EXT_SSCCFG, riscv_ext_ssccfg_validate),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(sspdis, RISCV_ISA_EXT_SSPDIS),
 	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
-- 
2.50.1 (Apple Git-155)

