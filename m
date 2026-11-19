Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090133;
	b=ciOEHSoiq35+fB24Wpi/Vp+/bRbUxN/N0bOPLnmfDnB/cHp09Op5OBqXBCtKoYdNrX2k
	 lN6GtyP4z9FH1aWoKVhhr/fEYG2aFX7DjoKmCGID5OB1Jr0eW6pkhx/3n5ZXqpuOenuM7
	 Z6ZVf67KIlNBgF1pgjtXl5fkkmLE6PqGBr4uU6lDIvcOqMCWHSpjWolHBqgt9fr6phufK
	 2XRstsHxNKXFeRnSJcwAGmB/2oQ25kpvjrBXmw/otEXTFSGXZ4+uwgxd2ONyQX/CgY1r4
	 5RM6eBPYnkfheRmFft4j7cDHz+e/ZP3A9zo15WlQ2YICEK3W+/nz5VfNwUgtEaWB09Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mw3u54M9upMKnOTAPQin/ZVJiGtWbtiuAdgAa3Btsi4=;
	b=bMByv/ns+BU53kzJPRZRJNelDfI4No5CSZs8XDr5hog1AV+CRZVs2GnqhOWpEZt8cPdP
	 rEV/JYNUsBC2+g7FoYfcYv9rtuMNzJVE6J9zYCj3dIKBWMjocWNXgfr5Vq2jpeUVC+/6G
	 VCvnSQfWe3wu/BIAtN5rF7q9K0CktQMSJbhCzXCudLTK0tw3jzKjUV2kfqLa8uMBiTzS2
	 E+aXZ67P9ZwFFKgY9KjJIKxybCsZYueDkcc9ZZOtREqbtT9tsc2chv404kj37zWUlRyAI
	 UrFSxmwiKoXql5QRow0oE7e8upb5wetOzxFZx5boRkqH1J3AALyVxgFrwhMOL8YzJWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=egI8yLps;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7E606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E7E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=egI8yLps
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-382c3c9671fso2707808eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795090132; x=1795694932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mw3u54M9upMKnOTAPQin/ZVJiGtWbtiuAdgAa3Btsi4=;
        b=egI8yLpsT1TcpXG7FWrPnSNvnTSiGqrZZE3a8agI1o/D4JSq9/E4tsAuuNUQVrcm9y
         fgzY5Yf3sR7gyV6QT9Ac0oR8pVGVa5yIuGuXPWCEt67HAIsEqn3D9V4U3HAPDROxx4wA
         3suRFZZJ0enq0M7EZq/65yUhXyDX3qbVGrPlHsf1oqnj2LrzX9ZC2aGyeNxXW0A9dbJe
         zK6xPotoMWQMRt2qsjXoLivkEVX05nWFOwscMyTwFXTlHehvDfo152gnjxg1foVLp0Wo
         KowrxL5kS58u3sbYF4yHZkx6LDStoLh3+jfIdBOwYvWDOJKrFTYTYpXB/ii+SFXmm0dn
         gvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090132; x=1795694932;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw3u54M9upMKnOTAPQin/ZVJiGtWbtiuAdgAa3Btsi4=;
        b=IvTytQLUJV9z0t1mdtg6W4H7UEP//fCYOj88lmuN+7UCL+i6L25a49tW000+h67Onv
         d/yFSkVeEuh/Z8EonPpPN/Io3dXRGJqAKrOuqBfYE5HaJ7xQ+7dzxRK96+KVOdqKjTRg
         JqDXuwDmRwu8FtE5d7bomXsWK1qcbtJdNCtkFHV8ZfGNivR9MboXtv1GNxAo5ZVbeB55
         Sed1b0Kuec3VDlXjLYFGicEYhTx5IBtfOJp73KEJ4nA7SFKgOcKxj8PIv9MV33zAfQsH
         CwL1o3CoHbd4jdZ4szIOkZfTRhucb8R1ZUbZLX0gN0375kF2nEIsXVM9efbf4VxQiq0u
         P4TQ==
X-Forwarded-Encrypted: i=1; AL+hErGWb92iH1PS+FC0LC4uyQPmN6Tyquf9IZVcz7crUDJkDAmLaDx6loSdJyQSbGg8haWGXJwivAqEOoUGiuoSnKmj@vger.kernel.org
X-Gm-Message-State: APuU4Z8UHU7KqHcE6yj0srOS9Jo2FX9QiKOSMNF7rS/g1iFPHxkgbIQc
	Pai4On/zX4K9gxorGippqEI001gQIidGvws1i1itV30ihQgdeTio7ixiaxd95Qwad7w=
X-Gm-Gg: AZFdTZdsgbt+Z1725VWMUmr4plXaN5yglofQYfR0XOp6/RnYsa97nPJo3DbXqbM4nI6
	K9QacUpzD9vQtvBVjq9aqSFBeafydyF1A5AM6VXZ1owMFPyMvMbBwKfNE5gzX3NMEhmTJUenIp4
	qiaUelQRCZzbafiA+62nNuNVy3Lg88jaoXfJfgQGVRz+yfeT0mTVIIzY++K2F0cheoUKFe8XAGg
	XajFaMSaBRgdz2lwtun1Mg2Shz3hLFGXRpN+GC9qs+XFnemFXCmy2dsV59KLMz/90gW61/cNg8j
	s32UyX7bOp1wJAhIr2NhwzT573BdAwKZcbouVH/W3FBhFZMjc5+WmAwHwZeZP85Hp1wKLZ/yXMv
	+djAz+9sU/mYzeBRFRTnPMqsCSr6W0HTbTGO2Mgc3uzdDeRA1LVeEuWx4vlbjV4z+qROZpJlruK
	v2eR0n0XGgH9saTFyWpNs8kcqzV2OVuDc6BcB0M+cSE1rucjbSeOYm0ZLnQWYyvM6ckAj6tXo1/
	MVLJCKaWVra/iwYQG7H0lb5pqjuMs8LHVXQgtm0Uf+E4qeVedSZZhXEvsJCOmfTJaONzS5jXlFN
	BYIL+GtHknOyGyEekSyt9gmxUVyAH4Oya4X3gjY54BLpd+1guv6PEE4p9C43SNZN3g23FxYdUmj
	faE3TGMY=
X-Received: by 2002:a05:7300:b092:b0:374:ba43:ae2e with SMTP id 5a478bee46e88-38280078014mr5600153eec.14.1795090132300;
        Thu, 19 Nov 2026 04:08:52 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17604650eec.26.2026.11.19.04.08.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 04:08:51 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	himanshu.chauhan@oss.qualcomm.com,
	conor@kernel.org,
	anup.patel@oss.qualcomm.com
Cc: clement.leger@linux.dev,
	cuiyunhui@bytedance.com,
	atish.patra@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	will@kernel.org,
	tglx@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	shuah@kernel.org,
	yuanzhu@bytedance.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangzhanpeng.jasper@bytedance.com
Subject: [PATCH v13 01/11] riscv: add SBI SSE extension definitions
Date: Thu, 19 Nov 2026 20:08:25 +0800
Message-ID: <20261119120824.13969-14-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

Add definitions for the SBI Supervisor Software Events extension [1].
This extension enables the SBI to inject events into supervisor software
much like ARM SDEI.

[1] https://lists.riscv.org/g/tech-prs/message/515

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/sbi.h | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index fd6266a7b339..eb22d79cea61 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -40,6 +40,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_MPXY = 0x4D505859,
 	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -508,6 +509,68 @@ enum sbi_mpxy_rpmi_attribute_id {
 #define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP	BIT(4)
 #define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS	BIT(5)
 
+enum sbi_ext_sse_fid {
+	SBI_SSE_EVENT_ATTR_READ = 0,
+	SBI_SSE_EVENT_ATTR_WRITE,
+	SBI_SSE_EVENT_REGISTER,
+	SBI_SSE_EVENT_UNREGISTER,
+	SBI_SSE_EVENT_ENABLE,
+	SBI_SSE_EVENT_DISABLE,
+	SBI_SSE_EVENT_COMPLETE,
+	SBI_SSE_EVENT_INJECT,
+	SBI_SSE_HART_UNMASK,
+	SBI_SSE_HART_MASK,
+};
+
+enum sbi_sse_state {
+	SBI_SSE_STATE_UNUSED     = 0,
+	SBI_SSE_STATE_REGISTERED = 1,
+	SBI_SSE_STATE_ENABLED    = 2,
+	SBI_SSE_STATE_RUNNING    = 3,
+};
+
+/* SBI SSE Event Attributes. */
+enum sbi_sse_attr_id {
+	SBI_SSE_ATTR_STATUS		= 0x00000000,
+	SBI_SSE_ATTR_PRIO		= 0x00000001,
+	SBI_SSE_ATTR_CONFIG		= 0x00000002,
+	SBI_SSE_ATTR_PREFERRED_HART	= 0x00000003,
+	SBI_SSE_ATTR_ENTRY_PC		= 0x00000004,
+	SBI_SSE_ATTR_ENTRY_ARG		= 0x00000005,
+	SBI_SSE_ATTR_INTERRUPTED_SEPC	= 0x00000006,
+	SBI_SSE_ATTR_INTERRUPTED_FLAGS	= 0x00000007,
+	SBI_SSE_ATTR_INTERRUPTED_A6	= 0x00000008,
+	SBI_SSE_ATTR_INTERRUPTED_A7	= 0x00000009,
+
+	SBI_SSE_ATTR_MAX		= 0x0000000A
+};
+
+#define SBI_SSE_ATTR_STATUS_STATE_OFFSET	0
+#define SBI_SSE_ATTR_STATUS_STATE_MASK		0x3
+#define SBI_SSE_ATTR_STATUS_PENDING_OFFSET	2
+#define SBI_SSE_ATTR_STATUS_INJECT_OFFSET	3
+
+#define SBI_SSE_ATTR_CONFIG_ONESHOT	BIT(0)
+
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPP	BIT(0)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPIE	BIT(1)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPV	BIT(2)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPVP	BIT(3)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPELP	BIT(4)
+#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SDT	BIT(5)
+
+#define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS	0x00000000
+#define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP		0x00000001
+#define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS	0x00008000
+#define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW	0x00010000
+#define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS	0x00100000
+#define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
+#define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
+#define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED	0xffff8000
+
+#define SBI_SSE_EVENT_PLATFORM		BIT(14)
+#define SBI_SSE_EVENT_GLOBAL		BIT(15)
+
 /* SBI debug triggers function IDs */
 enum sbi_ext_dbtr_fid {
 	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
-- 
2.50.1 (Apple Git-155)

