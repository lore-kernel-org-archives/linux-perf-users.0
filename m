Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939453;
	b=n9ZJflYQJrGNV+IxROT6/4QXnNDxJTr6gjZ3+OVRmtOa4Nth5Ev/9v+wXxx84kjRqPlj
	 m5wf21xkyRTrt/iT5cw74uE3Fgqh5YWRWX0c0p2o3E6AB2Pcm1oIgJbHnq3GylP0k0VdZ
	 uA7uffAXAAWwKpVl1dWJiOrK3RIvmdg1xHannSy0LlmqEQF0qeYc5kbvViMIxvE6aHKWT
	 xC/HxOSbUOaQGEmMF1jBkvYlAOjXat26lWOzixzJuofpszn4CaY1Li+mNzGsHmq6FfzRE
	 z7aSvBIVxZ7fyFGGM7oD/NZmcus5GsO0FjH3HiXnHL0zSd1nL22IZbu+wT/wVZ39b0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=efJIevtmWbzBz0eL/0yvclaJn4m3ipFrnt8V+2kunhs=;
	b=CZ1QoKKeSAwZPRRAlklBFjtFsNiuNqrleAGzh8z55A3TWoYZCbP8B3o1dQvlnHCUSivz
	 utVGBc6v6u1w2DNo7qXp1VT5mNpazMCdt5WBRz24oiSrC8FnaWSIkQrUN3du2ChxCkdkh
	 05hfeQeUN68Ru9RvGXLCbEOT7Gpz8n3SxE2SBQaEZgANheM4JUPldU8IRKrN6powq/e/L
	 6AF04DY8L35GRze6DZ/I5rJ5qKKihF6fRIUB9w/IFyb+hOP5Lt0a8CjcmAB0Oa6cUsK1M
	 j0GR7KAFjxx+oCAwOMy6VjNNVBSRlCY+0mnlN9eIdpK+shpAWZylxQdRkLkTI8tYRHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g4Vte6+c;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AC606A32D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C24AC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g4Vte6+c
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b31fc13124so1052247b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939452; x=1794544252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=efJIevtmWbzBz0eL/0yvclaJn4m3ipFrnt8V+2kunhs=;
        b=g4Vte6+c9K2gc+wTdFcBZzMSwuu07pva66q0cmBPuqml/09qwgrwUr3oteTG1CfT6j
         DYcfNjEa54c9EY98tMudjTTYJFW7+S7+4ikzk/lqZbs8qYq2igkZ+/rHfG9T4qhfEB6x
         FqakXqnHOii/DMivdDjjosTf6zPAFkhgn29wx2R5W0NhqZP8ADXBfAPPmyxcQLRUpiDj
         zCPsYmVJjbijSDPFVLbQqWgxh9oFdZrszfSJwdXU8qLGl28ZkuP7XeXeXdq5epb6AROh
         SI0PgAJx3/uNMbEXhr2BtPEgQCkkmvVB/LWAosruCxMla7BjLpCVRczqpSmxz4Z2KOFH
         7VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939452; x=1794544252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efJIevtmWbzBz0eL/0yvclaJn4m3ipFrnt8V+2kunhs=;
        b=e+XxRCQJnuqZJxrHO/gQfHUemMv6zWzyobSBQltqRyZ5JpY4rn2n4CL0sunBt3Zazu
         +Jp04HbxxdeE3IWbLDsnmBRk/KWxeDTh5uE3sTv4V6yC4dRgPogXkCVJuL7tPvVnserF
         F4ABJzZO2OYBqn8wpyBGz8C89hZ6MchUUAuBAyQdJ+QkDK3echQmOYxWua1Q691K4guC
         0WJ+00aoV/8Va3cHmOlUHWxpiRDYmn7zm+IR+3e/XWqhgg32rXy6jAgTNjfe36lFsXJj
         iIwxVFAm676qAL2nMuDzzTSi0wsgsdsQv6BshPxxUaWEKnUw+36542zOAEJHVfS/yVF6
         3kSg==
X-Forwarded-Encrypted: i=1; AL+hErE5hXlDGlCTcIAVgykP/UqjWBF70vsm/Ca+hk0ILfi62OsyZzkGlI2BGfL3Wl724yQsrnYe6SxWVJR62iuoderi@vger.kernel.org
X-Gm-Message-State: APuU4Z9ihBjbYaeRyJ6LDMvXnhTvmi3bA1zH4nz6eLFCFPOFEUuFssOt
	X0zMt0OScgsmIFjPqERmwc9msVzdKHEAjpsZCL7mKuBkfeK0mRuW1VA/
X-Gm-Gg: AYBFou1+B+nRJ5Am1K6KT1hJoTPqAcwXEvNObVVRrVD9KH2zLvlKVSkuhGSy8IXhBwD
	itpttCmiTP1bLLrsW1Bvl3jcOWJDj2zr5NN0LwxHfwPVMI0wUlnSHsGO9UDAbhfj5ITAWMrxix6
	lyGZov6BvR8zQgL7JL16ESoFJvzpHpGg7UiG8J2myQNVfVQGbc9IVl5ik1ZcCSbbr8bjpqGuoQW
	5lGAzKkfEIuXEWDQEFOlQFGDQPskLDpDphiePrB4ZQQETsk+8SJMtYPcXuIO+ebc7eRHB0ZQTmI
	6Gqxvh6NKxQFHWg4AqE4KYVC32y7RkaAcopIjE2QXhiv6ElLcYepPj/7UwU6ERtSs57vD2RkpUe
	xxGzOnbWqkSPLRf/PnPyBYAdYsvXMsynASeckzcn15DzJ4BcgZnX8KtQxt6YJ24ol/6Jro/GrSj
	WRFiS/FGi9/2txL8Ze20UaGm+rZl0Y7NqwTkJp4YajKuvCfQmGVUjUCcg2vazX9/fDkT7TML3Jt
	P3TQiwtruNUIogk1uwIewKtnOy7WdJ/FWc9cdrwsWcBjMvvb8jvuK/hWPzr/5jSlC/9MK7lX45x
	i3/aW7P5y31xhyVXDBZ9D90YpjlJcKY75hnGxA+k6bWw68z21hNZ30Q/NogefgS0mLZfwWzDEon
	CX11MPR29kQ==
X-Received: by 2002:a05:690c:e3e5:b0:8b3:141c:b6a1 with SMTP id 00721157ae682-8b341907805mr8559537b3.9.1793939451840;
        Thu, 05 Nov 2026 20:30:51 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8221absm11083687b3.27.2026.11.05.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:50 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:30 -0500
Subject: [PATCH v7 11/14] alpha/perf: report the data source of ProfileMe
 memory accesses
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-alpha-profileme-v7-11-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5887; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=RXbXjkvuN6GKQzTUONd1iASZ3Os1NJ2tcOOToftbhFY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht996vkzYP0sr0eTNi08YTzrQsqr72ZdG7ZpnJwYE
 Gm54t9Gh46PLAxiXAwzxRRZ4tYrssxq27HU57T0L5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 zxDI0DGKh8jpMWhkFheXphbpphUUOeTllySWZObnFevlF6TmFaQX6KVlppVkZOQXFacCjdDLSy0
 xdXV0MzI0MLF0tDBzsnA0NXF2djJ0cnN0dHZ1MrI0NzFwtnQ0cbU0Z+DiFIC55k0Hw39HnrcPjo
 c7iR3/86ev+WLOGfcNIhIM1Wt61tUedHsqfD+IkeGf1ttlwl3FB0K6nrsefWPUMUvhhd/y2QVR0
 3zVlxQcy+YEAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Whether a ProfileMe sample's memory access missed the DTB is only in the
PERF_SAMPLE_RAW data, as a DTB miss trap.

Set PERF_SAMPLE_DATA_SRC for the samples of memory instructions, so that
the memory sort keys see them. One that trapped on a DTB miss gets an L1
miss in mem_dtlb. PALcode fills the DTB, so one that retired without
that trap hit it, and gets an L1 hit. mem_op comes from the opcode, as
I_STAT does not say whether the access was a load or a store. A load
into $31 or $f31 is a prefetch, except for ldq_u, a UNOP that is left
out. Samples that fall back to the interrupted PC get none.

On an EV7, a loop that loads one word from each page of 64 MB in random
order had as many DTB hit samples on the load as misses: the miss trap
aborts the load, and its refetch hits. A prefetch into $31 takes the
same trap, and its samples are reported as PFETCH misses and hits.

I_STAT[TRP] is ignored for an instruction killed before it was mapped. On
an EV7, TRP and MIS were seen set for killed instructions that are not
even branches.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/wrperfmon.h | 12 ++++++
 arch/alpha/kernel/perf_event.c     | 86 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/wrperfmon.h
index 7fbbfd74926a..dc24c7cb45db 100644
--- a/arch/alpha/include/asm/wrperfmon.h
+++ b/arch/alpha/include/asm/wrperfmon.h
@@ -100,6 +100,18 @@
 /* ProfileMe status, from the EV67/EV68 Hardware Reference Manuals. */
 #define EV67_I_STAT_OVR_SHIFT 30
 #define EV67_I_STAT_OVR_MASK 0x7UL
+#define EV67_I_STAT_TRAP_TYPE_SHIFT 34
+#define EV67_I_STAT_TRAP_TYPE_MASK 0xfUL
+#define EV67_I_STAT_TRP (1UL<<39)
+#define EV67_I_STAT_MIS (1UL<<40)
+
+/* I_STAT[TRAP_TYPE] values */
+#define EV67_TRAP_DTB_DOUBLE_3 2
+#define EV67_TRAP_DTB_DOUBLE_4 3
+#define EV67_TRAP_DTB_SINGLE 6
+
+#define EV67_PCTR_VAL (1UL<<1)
+#define EV67_PCTR_PM_KILLED_BM (1UL<<26)
 
 /* PMPC bits 63:2 hold the profiled PC. Bit 0 set means a PALmode address. */
 #define EV67_PMPC_PAL (1UL<<0)
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 529186ea8873..803ec99cb9ae 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -20,6 +20,7 @@
 #include <linux/overflow.h>
 #include <linux/prandom.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uaccess.h>
 
 #include <asm/hwrpb.h>
 #include <linux/atomic.h>
@@ -1064,6 +1065,88 @@ static void alpha_profileme_set_regs_user(struct perf_event *event,
 				  sizeof(u64);
 }
 
+/* TRP, and MIS with it, are stale for an instruction killed before mapping. */
+static bool alpha_profileme_trp(unsigned long i_stat, unsigned long pctr_ctl)
+{
+	return !(pctr_ctl & EV67_PCTR_PM_KILLED_BM) && (i_stat & EV67_I_STAT_TRP);
+}
+
+/* What the memory instruction at pc does, or PERF_MEM_OP_NA. */
+static u64 alpha_profileme_mem_op(unsigned long pc)
+{
+	u32 insn;
+	bool r31;
+
+	if (pc < TASK_SIZE) {
+		if (copy_from_user_nofault(&insn, (const void __user *)pc,
+					   sizeof(insn)))
+			return PERF_MEM_OP_NA;
+	} else if (copy_from_kernel_nofault(&insn, (const void *)pc,
+					    sizeof(insn))) {
+		return PERF_MEM_OP_NA;
+	}
+
+	/* A load into $31 or $f31 is a prefetch, except for ldq_u: a UNOP. */
+	r31 = ((insn >> 21) & 0x1f) == 31;
+
+	switch (insn >> 26) {
+	case 0x0b:					/* ldq_u */
+		return r31 ? PERF_MEM_OP_NA : PERF_MEM_OP_LOAD;
+	case 0x0a: case 0x0c:				/* ldbu, ldwu */
+	case 0x20: case 0x21: case 0x22: case 0x23:	/* ldf, ldg, lds, ldt */
+	case 0x28: case 0x29:				/* ldl, ldq */
+		return r31 ? PERF_MEM_OP_PFETCH : PERF_MEM_OP_LOAD;
+	case 0x2a: case 0x2b:				/* ldl_l, ldq_l */
+		return PERF_MEM_OP_LOAD;
+	case 0x0d: case 0x0e: case 0x0f:		/* stw, stb, stq_u */
+	case 0x24: case 0x25: case 0x26: case 0x27:	/* stf, stg, sts, stt */
+	case 0x2c: case 0x2d: case 0x2e: case 0x2f:	/* stl, stq, stl_c, stq_c */
+		return PERF_MEM_OP_STORE;
+	default:
+		return PERF_MEM_OP_NA;
+	}
+}
+
+/*
+ * Report the DTB access of a memory instruction. PALcode fills the DTB, so
+ * one that retired without a DTB miss trap hit it.
+ */
+static void alpha_profileme_data_src(struct perf_sample_data *data,
+				     unsigned long pc, unsigned long i_stat,
+				     unsigned long pctr_ctl)
+{
+	u64 op, dtlb;
+
+	if (alpha_profileme_trp(i_stat, pctr_ctl)) {
+		if (i_stat & EV67_I_STAT_MIS)
+			return;
+		switch ((i_stat >> EV67_I_STAT_TRAP_TYPE_SHIFT) &
+			EV67_I_STAT_TRAP_TYPE_MASK) {
+		case EV67_TRAP_DTB_SINGLE:
+		case EV67_TRAP_DTB_DOUBLE_3:
+		case EV67_TRAP_DTB_DOUBLE_4:
+			dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_MISS;
+			break;
+		default:
+			return;
+		}
+		op = alpha_profileme_mem_op(pc);
+	} else if (!(pctr_ctl & EV67_PCTR_PM_KILLED_BM) &&
+		   (pctr_ctl & EV67_PCTR_VAL)) {
+		dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
+		op = alpha_profileme_mem_op(pc);
+		if (op == PERF_MEM_OP_NA)
+			return;
+	} else {
+		return;
+	}
+
+	data->data_src.val = PERF_MEM_NA;
+	data->data_src.mem_op = op;
+	data->data_src.mem_dtlb = dtlb;
+	data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+}
+
 /*
  * Handle the close of a ProfileMe window on PCTR0.
  *
@@ -1178,6 +1261,9 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 		data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 	}
 
+	if (exact && (event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
+		alpha_profileme_data_src(&data, pc, i_stat, pctr_ctl);
+
 	if (!alpha_perf_event_set_period(event, hwc, 0))
 		return;
 

-- 
2.55.0

