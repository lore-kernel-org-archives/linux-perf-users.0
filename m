Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738273;
	b=32ntrhtD91+wvfAByG/NlbSKM1k5VtRknKvuqT/KHnmRRgycPL625kyS4dpnqtSwy9n0
	 o0sHKJAe8Ism5dNQq6JnvbPMPm9ojsPwLWzp2XbQ1CzDeuETi2MG8QiPnKCZ8ubXVS5Gw
	 mK+AK84pQKtI2Lrm4Hd5VRkctDJ8E1J9cr2RxlUcGD9OK64ApBmO7ChHhtUbKWEZsEOqg
	 TYlP6EyXur6FTPLji3KFsXRDQV0w7LmaB6iaNJRfMWj6Walj9Crl57FuXZ6jLKAfA+Kk2
	 ZY1stXm+EyO2BbHcTpYmapkAQE4t6M58vSte3TkL3kVihrmaqmJHNQcEBSa5Zgb+g5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+7f/U9bbjwoOVmJVDcG5X7lMyLUMSgLL+Ij4BWsRihI=;
	b=RqG8WMycU2RTt3SJdITF2Lv/W3iOxMwgqEFRMbH4UUFUAGT/NTTsjqJ/ca03iDKjyCDb
	 E2FIsAk0xVUMgNkuVPELx+FUnw1ro9W2eghry34uLdHu9Qxh3c5KNjOuOwwUfID9qj4Z5
	 2rAszRf8q+VFqGYby5bczkxUXTGffRyJ0zM8jTDgBTaxQCSIA9mTRAQ5hVWhJjMMff4BR
	 7NdYei9o+oT8+MOg9xwsAtsV9dRgabElGLrTfElkl9etrENuGkUEMmg+pjZqarSOUlX1z
	 tAhxS0vPeMVoUf4l6dh0DCFpAsw0NozxEZs316/M07K1Ur05m2FznIkmrRYEClwAX5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EVyTUZuv;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE0606EE9C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52EE0606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EVyTUZuv
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67bec5dc8d4so83560d50.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738272; x=1794343072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7f/U9bbjwoOVmJVDcG5X7lMyLUMSgLL+Ij4BWsRihI=;
        b=EVyTUZuv6YkiiZ+uIbijHQq2io6l6U4ec+XZ4dsDdcwYqxkqO6TdawujTUdtjivS/o
         0Oi88XBRzYjEeBgJrrmmHu1kzgvZXIV0FFfmsQX1WRkgmDH7QjlS1+Cr1+/1XGectDcC
         XjSs4P9S1NJfNu5j49VxegGAp7XWSo9yRVyw4wePRxnHHARbHSDn/ctb9yRE2QiBIp7x
         p5OI58mDNbEXswpUnM6Xs6CZeXRDTINAouAT/+DfH0PuJEcA7iz7orlTTvfgQaGqqHwp
         0dE5RX2h8B9coN7ylqlCij5z/GklSkdVBMMDTKfMOvIim4WJlWoIhoqAT6Q+SbQksvAJ
         TGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738272; x=1794343072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7f/U9bbjwoOVmJVDcG5X7lMyLUMSgLL+Ij4BWsRihI=;
        b=wX+gRQJ+F0zc6ss6jtITV4NhquKutD38V581Yfb4ucDt+7Z/lUyyePSTVISzpfI2YE
         vRXvhCA07USbDCt6TZkkrdaSOmjxbdQt6dFdsYJ+LQL/UsJipM9/Wx0/hCICp/lD5ONS
         RgsdgmBrCQQR/DIrfCgJTSS/n4QTVWWEYtWvBYqDBoe8HHSJzDP2sq8wrpHN6V30C8e4
         6DBqSAv2MAQ/HpupRLRHmwLDP2OVPjmrWQDt45BztTCrkUhOCR5UPL6ExYWBpVf0rI/3
         mA8ml4Y9XA5D/N9/ssZIUgh8d4bKxfASpY5fTd9yRUtePx7zVdC84FbnIWK9vgTA6bah
         ZuyA==
X-Forwarded-Encrypted: i=1; AKwUvByE1shcma89e5joIOt66Rz5z1dG29N78cqzb4/RdNsaVyw47u0xV0m9Ncr0SxWX49NNS5zCtgzKLwI5iReXQ+4O@vger.kernel.org
X-Gm-Message-State: APuU4Z/3qMWGNFKpHjkbNxMz8z43sGH671fzhlqA0v0vxmiuSBsfsEqg
	xMTbCsO03QnaJPYFeKh7/pbTT45JiAm7wdLjTT0WNiAfhD4t+knaOiYm
X-Gm-Gg: AYBFou2uo31V1iduHr/mfcWzUM1t7ks587hasSfO8OIlsZPlHK+KWE/pUlZnRon77gQ
	JYNddA/ry8i025ylkOHMO8TBfCdGVLjWyqsP82T/qBBp+mfNSMaMlIXCik5hjmqUgMnsWS2aOFx
	sF5A00VU7K3ksGaYF5/2cbQT4INu1NqMbBrSKFR8iN+GAy6gvilErYgpTy0sQ7XL5ArBgQznvnq
	2xKlwanqoKP3Wu6vKcUViK+6GGPiOx2Dj2XyhcPKEPCuk1TFQOc+gjOSLr+sfCy/agNzccM1pb6
	0Hofr2a9Cw6sgBgdvS+Zxt/4WaL4AAsVbHrdN0a4HwZZhgbpVF7vLNCZTu5z8zF8dj1plth1cHZ
	Uyg/Zqsg/8NFuzMSt9jdT2QWn8UppkKZ1fUxNz4nzSy+jE4JB8N8st8DuOz5BFJDIzXOLQzbdlt
	c2GFTQnmybqf3g6IALWsPA+N0Q00BawC2Syqi1IdoxQOHauPAt5TUpFtk7D0Ggax7oKnGfibMXe
	5hFfiwsGxoKDi6zVDodcRqrBkhM7C6IJt3ly7pleBlF5JkTVSFugtpgkc766fWKpOpXhTZ8F/l2
	s+9fP2azO/3EOFj4KU0BFwV1drI/j0KI1xOjrLVzPfXV7Zx4r/kN0IZ1Zf+BJ5bjjZhcwXacrd9
	jcBfp/4bvFcg=
X-Received: by 2002:a05:690e:43d4:b0:679:c86f:cf6b with SMTP id 956f58d0204a3-67ba506edcfmr7459500d50.72.1793738272335;
        Tue, 03 Nov 2026 12:37:52 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee285be7sm143757d50.16.2026.11.03.12.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:37:51 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 03 Nov 2026 15:37:42 -0500
Subject: [PATCH v5 09/11] alpha/perf: report the data source of ProfileMe
 DTB misses
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
Message-Id: <20261103-alpha-profileme-v5-9-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
In-Reply-To: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4260; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=ThdyPtCDGcliaCjOAS0KHbzlPZhBU/4z3/FVVxSxIz4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeufFZ3HF8uKFXOPbU6aAJYtv+xfUr318VUznpfEuiy
 o143vKjHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNA0+G/4FfFGplYt
 /GbxfdfbFXcfmstgtGC1quzpSdzLW3TdBY0Ijhf3TubYM3RjJphlOLlv+7X339b7DMbK6F35+He
 udsWjb9BCMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

A ProfileMe sample whose instruction trapped on a DTB miss identifies a
memory access that missed the DTB, but only in the PERF_SAMPLE_RAW data.

Set PERF_SAMPLE_DATA_SRC for those samples, so that the memory sort keys
see them: mem_dtlb is an L1 miss, and mem_op comes from the opcode, as
I_STAT does not say whether the access was a load or a store. Samples
that fall back to the interrupted PC get none.

I_STAT[TRP] is ignored for an instruction killed before it was mapped. On
an EV7, TRP and MIS were seen set for killed instructions that are not
even branches.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/wrperfmon.h | 11 ++++++++
 arch/alpha/kernel/perf_event.c     | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/wrperfmon.h
index 7fbbfd74926a..489b3e073a32 100644
--- a/arch/alpha/include/asm/wrperfmon.h
+++ b/arch/alpha/include/asm/wrperfmon.h
@@ -100,6 +100,17 @@
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
+#define EV67_PCTR_PM_KILLED_BM (1UL<<26)
 
 /* PMPC bits 63:2 hold the profiled PC. Bit 0 set means a PALmode address. */
 #define EV67_PMPC_PAL (1UL<<0)
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index c2c367b51617..7f53aea261b0 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -20,6 +20,7 @@
 #include <linux/overflow.h>
 #include <linux/prandom.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uaccess.h>
 
 #include <asm/hwrpb.h>
 #include <linux/atomic.h>
@@ -1015,6 +1016,39 @@ static void alpha_profileme_set_regs_user(struct perf_event *event,
 				  sizeof(u64);
 }
 
+/* TRP, and MIS with it, are stale for an insn killed before it was mapped. */
+static bool alpha_profileme_trp(unsigned long i_stat, unsigned long pctr_ctl)
+{
+	return !(pctr_ctl & EV67_PCTR_PM_KILLED_BM) && (i_stat & EV67_I_STAT_TRP);
+}
+
+static u64 alpha_profileme_mem_op(unsigned long pc)
+{
+	u32 insn;
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
+	switch (insn >> 26) {
+	case 0x0a: case 0x0b: case 0x0c:		/* ldbu, ldq_u, ldwu */
+	case 0x20: case 0x21: case 0x22: case 0x23:	/* ldf, ldg, lds, ldt */
+	case 0x28: case 0x29: case 0x2a: case 0x2b:	/* ldl, ldq, ldl_l, ldq_l */
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
 /*
  * Handle the close of a ProfileMe window on PCTR0.
  *
@@ -1130,6 +1164,23 @@ static void alpha_perf_event_profileme(struct perf_event *event,
 		data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 	}
 
+	if (exact && (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
+	    alpha_profileme_trp(i_stat, pctr_ctl) &&
+	    !(i_stat & EV67_I_STAT_MIS)) {
+		switch ((i_stat >> EV67_I_STAT_TRAP_TYPE_SHIFT) &
+			EV67_I_STAT_TRAP_TYPE_MASK) {
+		case EV67_TRAP_DTB_SINGLE:
+		case EV67_TRAP_DTB_DOUBLE_3:
+		case EV67_TRAP_DTB_DOUBLE_4:
+			data.data_src.val = PERF_MEM_NA;
+			data.data_src.mem_op = alpha_profileme_mem_op(pc);
+			data.data_src.mem_dtlb = PERF_MEM_TLB_L1 |
+						 PERF_MEM_TLB_MISS;
+			data.sample_flags |= PERF_SAMPLE_DATA_SRC;
+			break;
+		}
+	}
+
 	if (!alpha_perf_event_set_period(event, hwc, 0))
 		return;
 

-- 
2.55.0

