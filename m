Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818169;
	b=txpOV33ADsCxI/4w63cwgwxNr3m7QbRbFJLHW/GU46qtaL++QWpnHtsN5XJkYnQHGbxp
	 aSoO1KSmDsG4FF8F902hcucddlB1+dt/u6wd6qKkVrKjNxv6pKB/GvJPSaxlYyOyGJJlU
	 4j8EpKRGN3AYSaYyiv3H2RPTj/DZpxdJZAXrLdcYa5sjY/8XNFgcOSQgrgFlFb50BAI/i
	 Qjj2emUFWQ7p9hS8nomw/GeAgYI3Btwtr33ty7DaX/ZLenDmoXBmeQ7e3CYKIhZDd2iCi
	 ZgtstsBnMa2kgbMGDn66XtvKFNUCxjy/bELk+WU+IH58IM/Ykf5rf4xVkY+EIQQq5Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=w3DDS5VxfGrOk4pk1sx0ix9DF6R6TCLK6co5C/H8U0g=;
	b=YGuA5HD1d1lZ4kPAa4bWNvvpvpiZFycC5kWJTsovh7nQ8RQClv2D3I/p2mMoE9PkS6en
	 5KwFP2LGXh0lg8K8tT4twH7qSJMI5jMIfBjWhdbzP1Q4hbIUSu296vU2s94W/BxzcNZNB
	 XS4VuyCBhNNFes8lfCaaHAJMjjIBtf83Xbb2I2m2NRrI7jZ4CMO5LGmvGoeV2+Nv1W5ID
	 afs8Xpl9cFLxdpg2TzL4QxLpyuIdroJto9nUGhdCBDfCoJipeePSW73aSJvqCLJ9PhUJZ
	 Y4992UQnlOFDZxO3Iy6Fy0EdPeqA/Tbm4gkyaE46WtbA5Fyvc2QhhS3oSaemUXw9igA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W8MRFYf0;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65196082BF0
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65196082BF0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W8MRFYf0
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b118bea471so9061737b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818168; x=1794422968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3DDS5VxfGrOk4pk1sx0ix9DF6R6TCLK6co5C/H8U0g=;
        b=W8MRFYf0VWsmAa88+3a65HtE3Hh6Ufrv3XV+IZjOWPRNRjwrAN0TK5PtCCWy0EeBWf
         msMYhFbYXnuFsCe4G6pSqt9P7H0sQgVHL0aJnRcQ9tzeOP9RFkkErjh/wg0chudt0Vc+
         xcly1vFE2QI8NfI7Smifq4mGU10b57+LPVyclIdZNjqpVqX+eVXK8Jb3QgXuNpLASWQL
         m23pZR9gbxMWRHZCQXm9Pc+BWdPuhll19PedOH9Rf5jEfGFibJ3CgszKolbgkYJqI4O5
         Ye9ZRQECvHMjw/aSnmwrtVK8C/TRExgkHp0n9P09K45L3evRP3hzrPAXXMflp8b46UuV
         8dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818168; x=1794422968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3DDS5VxfGrOk4pk1sx0ix9DF6R6TCLK6co5C/H8U0g=;
        b=YdSpFBUF/t/AnxFpXMq9qrJ1msfUjvtkgqUBiEE4coNmM9e+qs2u9uXld7vL41VuJO
         xRNKsknjNK/6z7EF205xrxYi+Ln45Nvg1Wa3tzdeCAGqcK0fFEd0oC4F9CEQBArOz1cj
         q8SEYSdUKgvthXLF3Ixbt3rISN0F2CcsWOrV9OScA33nKWoqG/5GgFhVlXsrpcXjt74v
         oRqiljLcD7LKaQpYJY7nStFeZNOIYUPw7LlpaqLvgJ4bQfbaz62DSPg2SwI9A5UhidHa
         ++n3Jida+uEG8MsOiP5XtjrjjDXqrcWt787NNGcIAA5Zp2SdBSVGi+QYHbhCIy0aKdDz
         ATcg==
X-Forwarded-Encrypted: i=1; AKwUvBzKk5HvMwYyeM9D/2kFKwQ0izu/hSEMgzeQugibTC2jkNTX+5190I96N/Vz9pOTLau4XihjkuAmSk7z616cVXvK@vger.kernel.org
X-Gm-Message-State: APuU4Z9uatGMTfZxzzt33uZvZNcYP7UYV4z/xnckKL2rwKPHUOKghnHt
	5hk2LLJe2XV2HNg+r1uEbdGx5h07DeDOVOdoGgdXrA18i9euSSErWzsF
X-Gm-Gg: AYBFou2RXUGkfmoy+mTUmW8VigMxGn1amrUleeaeyCj69o1dSdH9HGZpv4t8PXaf5GJ
	ciXfB600UAYrIs23rNJHAtYUTgJa6QQcyK09kx1ITIsCdGImguOIa2nYsyGclJajBy37T8E5qFQ
	DOkQDsAVcT/l7APG+L5eJzNn1s2o6i9asdHo2cqWSIlmQV9QktcqOMT6F2uYncBXoKqsS6fQheg
	gpu+fBfomOvzetEa62tncCMvJ0hEFljRtDonpeRMKktB2MKb461XEAYtm48PqoKMHNKz2tpS8XF
	4CG3DcDx8JBoCIGri3gyZ032taZL46bhempDyjbCra2/48kv2k9ew7L3JesHzzqoFF91GZ3VlPf
	yCvVfmEISJQX8EaOejXPd/mb/0CsKm6D9ORByupIolgrQsHQcalwCZgpG0nCu/xV+bMTpLFX4GA
	Y+3DP04DyU1CEcyu8EHZPXQdUdkY+pNl+rqWmqxmUagvz72vvvhDfIoWB0ibVBguAC/yd1DILoL
	/fuf7EEBnaZgU0v1v5SgvJ/9Hdi8Ql7OD6+vo5AuV7BW+Raih+lKr9dEn6sUSp0FZd3AdehTxcS
	OInmIQ6WHTKY2GWMcSbAe5tZGgG3+XdoFYWPsikSGP3SYOId4Nto5dv8qhZ0DE6sKe9VhitYeEI
	V3Fpq0rwJgbzR4jxguCHFbiGxPXna0B8=
X-Received: by 2002:a05:690c:c513:b0:8b1:e7c:cdf1 with SMTP id 00721157ae682-8b2b67224fdmr113642617b3.30.1793818167397;
        Wed, 04 Nov 2026 10:49:27 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3099ae415sm24128967b3.35.2026.11.04.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:26 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:49:17 -0500
Subject: [PATCH v6 10/13] alpha/perf: report the data source of ProfileMe
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
Message-Id: <20261104-alpha-profileme-v6-10-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5788; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=pyzx6//j2OdqKwRssVgKvGUx0hM35DoDJu9pQTTqBO4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe16l+84t1KFV4o8R41loz//zpjPj8reWKr1Ou/rocM
 i3+J3t2x0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFxj1crIsHZJkuAJ/Q
 t5hT/fvja05j8hznZNd+kznyczW3/6rV7ldIyRof1V1PvYT/5rTxcGqQU9eNmRdoqzjPv7a84gQ
 56eO1+PcgIA
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
index c9ab40ff76ad..0723e1042145 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -20,6 +20,7 @@
 #include <linux/overflow.h>
 #include <linux/prandom.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uaccess.h>
 
 #include <asm/hwrpb.h>
 #include <linux/atomic.h>
@@ -1053,6 +1054,88 @@ static void alpha_profileme_set_regs_user(struct perf_event *event,
 				  sizeof(u64);
 }
 
+/* TRP, and MIS with it, are stale for an insn killed before it was mapped. */
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
@@ -1168,6 +1251,9 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 		data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 	}
 
+	if (exact && (event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
+		alpha_profileme_data_src(&data, pc, i_stat, pctr_ctl);
+
 	if (!alpha_perf_event_set_period(event, hwc, 0))
 		return;
 

-- 
2.55.0

