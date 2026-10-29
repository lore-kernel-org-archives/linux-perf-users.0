Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260165;
	b=IPZ9kDSjG+zFG4cvDLhsc2dZp2js5yBGcAS/Vin4QLS/XUQr5bpmr1E2VTY9W1grg4uS
	 zcagICxJ3XQm/xGvwWJWlP3Z5McVHjU/vdvnWwNb1fvCqOULbOBw8sb3yoqhOi2fvkqQ2
	 KCLzmKqhuvdnLeTK6IioEZnrscydm62Ih8W2JdsaBkf+zR/Y+WF0O8vQNb7pRo6AQCA88
	 unC585LpOe06m1GgvYT7NHhyBCNGYJwu4D2CfolMYIr/KekulPzXOOcf+fipkEybwmH4w
	 BNC5f0pBRa31zOTHKelqVEfzPulQg3U8NXK+HrY2SPN3rbyCNvtU0HVTfRvb+pOxfPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A3A4KroQ7g5mtKyNwDKv1PbMO1uQ0igFufvmY/wg4ak=;
	b=XwLu1kEJRPO6zd+A3mGnb2Vuqh+SRHE8vBoDVnmdevfzdEAaQlDvxHHUyERNdGLUQ+B9
	 QQq8sBKaRpFYGFN6qnCo899tKKh71N6seqNfDELIV0O+52k/YLXDvPl2UkFzlitoqC2oH
	 kORxHfuQgI5GCCISAMivbu5Is+UhWwANJk9jQyAhk++Q64ruFPkKPfEd54T2wB/BMqWJ4
	 Mw9qWGPaRAYfjfRMluX9EANlnn/5JOc519+4tliknBFPTPxpYEEN9tc3kRmVqQAqP8Qlp
	 9x84b7iwjDjUfALEx55JxqjFoYtTbv55KYZ/QWLNysEuzKNRDeL5D4cm3uOf5b+b/uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i5Y8broD;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46561606A327
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 07:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46561606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=i5Y8broD
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e609985789so5413085ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793260164; x=1793864964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3A4KroQ7g5mtKyNwDKv1PbMO1uQ0igFufvmY/wg4ak=;
        b=i5Y8broDdhc1sWt/yv6W4AyfzrqfJ2Nz3oXdHTbPrfTIxqWTzUZHOv2wS/HznzWbme
         Q7/8uIcYVg37o+BKniiJJb1oBTTOv3BXcDwTLYiPeVmahx10mWj/Glod8sTyWfq5GU9t
         CMhsM/I8c7kPpFTduGXTmkwfBXhRFaNdIy0kQrOnPY+rruz5O7QX2rqvqe+uvseLYsMC
         gpg8zf2Vz5wvIbqMR0zOG9s9BWnitSdXtuRi+ujR7CMzTqmsuct91+u7Kpl5fjczVYNT
         o3+71983zabWkzFRefGgxzsfoXjE+Tp9KtivRk+3ikEv5CZDpA1+NVsu86ZBuBpweYfy
         nKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260164; x=1793864964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3A4KroQ7g5mtKyNwDKv1PbMO1uQ0igFufvmY/wg4ak=;
        b=rKsR30GEtGpvBliVSioJPsZQAK8x4Rto7tNoXGSleccK6zw5o6Z3XmEojurvfYOVnc
         EX7vteH+kd+Zws4wixHTFO4OZu38lll77ynJFrbTztZwQjyq1lK79bkJ5UXlfD6p3S9Y
         AEt/7EGxcwmodXdnxPpiQAuhZwDiZu1oYsZPnF7MOgCPtLRtkTSl1wnOnaG+lhGJ4fkv
         TQCFro2vBS7scn7XUkvt5zWTUj+u6pcgkR3Z0kUUyxPnsqZMXyNc794H+q6vK9jdgw5j
         62S1mTLT8YBllwSD3kMt8C3aoygil83atZNWL3PUaq/IKVCy4vSn0dg1nFo3b3YzL9N9
         vy0w==
X-Forwarded-Encrypted: i=1; AKwUvByWreuIMhQJuQdPTxUurYKK4Ov3F1qIcWtAc5S7jY2BUDx7FmlMTW0zV4STJRKf52vUGNSk0Mp+lr/7ouH9eqv6@vger.kernel.org
X-Gm-Message-State: AFq9FYJC4H3Gz2QqsYSVZO9pmwH40J1g4I0uQpfJ7wwqXwTw5PM46xFn
	ehsxovuxK6qz9gM6e5Wdm0FXC84pD3pb2cvmDxXkZbrIQCE7dxlHOSgjYm44yXKGj1g=
X-Gm-Gg: AYBFou3ca+vQfwjLd3uGVz0tJVYecEORaYoqalBWCVJHuY9DhEVcWvNQ/J3S0wIfk6q
	HjH2CEKKcViaiCi9saP/ZSElMeg+O4HzMz6tKVUsfKAOz/i06J49WbD3cLMo3TLA4QTcL9kv8NY
	nFdM5EBzDqfy9bV6Nx7AJ/xGJsbbSPaKNyz9K9HjhvJDlUct3qsx2u0q6zmcoxBv8p3/DpgY2NN
	KvPWvS14cBbjo6YxtK5LqGynKHfhyrLLV+0gisrJgKbEPTcAdanM5PaL+sOL12JIMgBmICg4ect
	qyIpVR2DNFz6DnkPjDCQUsd17opfl5dOSqFeygNdgDGUf6AqEnt52kkXtNJ14ECFZcRlwtNmXnt
	Z025kAkzQNshckXx5VDgfHGyYrwV/xdPVLzLpo5yhbQ6R9zsc9zOTkOfVpmO3Ll3jofvLz9QYDo
	O4/K+orBU3T5339L4la2NqqnI2BR3Y5MOV6DTAp3a/iJy7ekwe6be6n9eNs+dQb6UpRneiLdQUQ
	60TasYM+JYz2XiuS7VpMtBVA7FMHcCKKLUfSTmh+lvNQCS2HXpXFSzW6roTv4Q4+KEe1uAjYeDZ
	ZTfaR53D1BlHwv8umA4wx8piqLbJ1mJY770FqhV+DCek062bH/UPXNZCx2kVXh1R27jlR5OT1Fi
	pOxL8L7palhMH9dpHNeXwp+9FuGv9
X-Received: by 2002:a17:903:46c7:b0:2e5:e1de:9c3c with SMTP id d9443c01a7336-2eb00590642mr37850705ad.47.1793260163496;
        Thu, 29 Oct 2026 00:49:23 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bd60desm30598915ad.29.2026.10.29.00.49.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 00:49:22 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup.patel@oss.qualcomm.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	yuanzhu@bytedance.com,
	yang.yicong@picoheart.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v12 01/11] riscv: add SBI SSE extension definitions
Date: Thu, 29 Oct 2026 15:48:43 +0800
Message-ID: <20261029074853.35467-2-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
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
index fd6266a7b33..eb22d79cea6 100644
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

