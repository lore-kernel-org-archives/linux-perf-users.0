Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88C263F44
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332225; cv=none; b=bRHkpUP6oyo5b2iL4hfLfg8E8Rw4ByPZxfuhS1vBFkIJywnlhdK2ovbPGBH25FY9Tk7Ypfhw5HqcbJNX0RLUOVx4cbeqAw8Q6xOezGy0fd6I3TvRlaZcuhwt9EnTPBAkMvSP8WnDHhENPiOwl+jp5G2dnz60/Q2qUpqT5hTltv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332225; c=relaxed/simple;
	bh=uZrd32wUvX5SDEU1PWqvgQ3qjQJm8e+VexqImi1d9vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTPF6fe0BUlfPhxQlfisJm79XM+CJzLh6YI/t3aekAhDOMgseINCuWaQq0J8ptmca4bqbXNQW04Vm/n/GwNLKVyzi3Z5PTtV/2tZhPbXWZdW72tMNEAZzcnR/AR3nogqZJXP5z9sBuXgmAqY9Ul9hZ0wLhsEUEGF/yeTvVxvPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BBL6CInP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BBL6CInP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-836ebdeb969so1322635b3a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 09 May 2026 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778332223; x=1778937023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAkSYkxsqqTOgdXkwd1wAt3CxX5zO5z0PreuHh3BJZA=;
        b=BBL6CInPOQv5BnrbcLeRqeSq1XBZF5dcFz4z1kbOPcBoPOFpXgcw4KkwlTGH4evp9U
         8VHWC7E0v+gzq1YHAU1YpEMNV+kBkrvq0K2g30MuHFakzc1RRJufgp5RgvvlocIJMwoP
         VEq/JW0SKNY6acywbRlZZ0mhtQdpxbSW/XhXFfqiMnIyVEDcyhAqczgGJxn8GAZqTtfR
         4tm8dgNapGqYKWY7esRqHf34K9NPMvuP2389Kd+u3Qu2OtcZno+j4P1MMS537n+nwPy2
         ZPaoRaSXdGVvU6jtkq9vMqvjZa4FqM1YYYTRS7D6zGrLwmIEjalkWPhgVbxC93ccg8gw
         wvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778332223; x=1778937023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAkSYkxsqqTOgdXkwd1wAt3CxX5zO5z0PreuHh3BJZA=;
        b=Rnuhs0N5vNfxCHwnsgdI8JLCykq5HwDRMD//TZfQRQAXXVhONwmu4qGiYvjQwabMxc
         WSN5bgfruNVzWzsZqln5r4ROWHLePzhdQB3FZIKlZZoxeeQG/A9pbUhsOPc9lK9UOVIx
         uKW2Tx5P6FQ44+F7wsvKclPchHWDGn16SGo5/1sZyvBTM/dYA2f8NwN1Jmfnf975CTC+
         +fEzQa8bmlThJTlIx6LGY33y+JzUIGm2qqKV7Rfpm5qs7V0eBklNc6hMVekwGM7tFfn7
         SBNyBV6eJZgDuA8ou46w+IZ/Uudx87BPb9v1wyZVb97Dd/QmlvDAUuCAG6LIsJRKiMr9
         XutA==
X-Forwarded-Encrypted: i=1; AFNElJ/X7I8C+PEnea4x3cwIk1TIAh3JOLtzkvRDT13ll+BGg1L1i/f/RG+W9DRYhkgmcHxUAyAPJCS1Q3mBK1mU4QZp@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/lFAIG+sC3N5RItOiK5A4QJ+LHixcAMeT/NE5ZznV+0qxSw1
	2Hvelp8qITMczZjDC0Za0wRON9RPP9F6Skhtseu3gAig9aiwVeZvIjTr1lc6uUGOIqg=
X-Gm-Gg: Acq92OFpsnWL8o84cH09qGonufZlMWY6QT14ss0B1cLMZMst6tu1EdZRCTm6VSQO3aK
	pE8yyyaFm4gOSW2Aqm2VbfWp+PRJT7F+BPT68cf+HaQSuxfYgmSU84pMt5RSyUhM/SEU5CEc+cr
	EAYjkHg3BB+D/PVcyrMy8FJmy1TIWcj8qogBZGZxA/kIpNk4hv5jGEm3HknznS9KsexEtDG5Yzw
	yzvOnE/WiwC48IrhTvNrwCQbE1pzjEFjE+i2cxRMB0uJPCBntFL9tmVNsE1n+sTgXhScZRc/O0g
	dvUMsnXLbnVvOWbIu9Smr+cDvcAelWRyc7HaCY3Oqb8F7jE8OOLImGaLmuaPtfZxU+ummcac+P+
	mGGx3COChKQcmC5fqc+B0RC/jYCoxkWKM91o9vxgzq4kNN+jh68osEuB4FBwUfujWKUk2Aenuru
	AEh7oTC6FI7SC1bFgBPNbc+iYsfZhr0ZGyQppUA1xgtCCwKyWV78c6V16oWYARlBRfrJMLGJkDI
	AYYbw==
X-Received: by 2002:a05:6a00:8018:b0:82c:249e:a85b with SMTP id d2e1a72fcca58-83a5b7cd0famr17299719b3a.13.1778332222817;
        Sat, 09 May 2026 06:10:22 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([155.117.34.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c86b3sm18552855b3a.28.2026.05.09.06.10.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 06:10:22 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <himanshu@thechauhan.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Zhu Yuan <yuanzhu@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v9 1/5] riscv: add SBI SSE extension definitions
Date: Sat,  9 May 2026 21:09:58 +0800
Message-ID: <2a8913d680ccf162d5d697fde1a125c48b2f1d0a.1778331862.1.git.zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

Add needed definitions for SBI Supervisor Software Events extension [1].
This extension enables the SBI to inject events into supervisor software
much like ARM SDEI.

[1] https://lists.riscv.org/g/tech-prs/message/515

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/sbi.h | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5725e0ca4dda..3403b0f706b4 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -38,6 +38,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_MPXY = 0x4D505859,
 	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_SSE = 0x535345,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -506,6 +507,66 @@ enum sbi_mpxy_rpmi_attribute_id {
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
