Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D631DF261
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750405; cv=none; b=sYBABIRDbm/VBQxAq9dGAJZ3idz4U0i6nOkjDiPosVb7YevMRCNNriYBZWJL4QZTAdq4uHDVmRzEA7YDg076l8BYw4SqEaiaKpRr8rQUA/Pe//w6xZrB16cabGJSkmjA72i/Yt/xAuI4qO4TZTfPc5lhxUZIVlqHujWI3mQVejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750405; c=relaxed/simple;
	bh=/9lKqHBhFb4p0Ucj2ys10zg54LDaYLBV4l2ZDIVpZmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOLMez58EqwoeVO0WlUyODEUqpGvYvz54s3jQXuY+Mf4jbGncaYf3/wy452XYy1HIufjhMPhszWXZVfYrywayjF8XYzFJWBKVoxWHdFWDPJtvw46KCIbN0daTYBzGDwXt+GlhqPoSo8QRTmH5vAd65YqwHC/bVRfPoqEb+QLtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRb3Rp2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iQw9RUT4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRb3Rp2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQw9RUT4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U2POrq1522937
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8OWABlvWmQD
	eWp98OxpVQtoQURxY/W2DmFEPy2By3PM=; b=lRb3Rp2wgIxmPSVMCNFwHXkXpTX
	HZB6EToy7MxH8sWWVGqsHe2yReb3X6wNA3AqacT94Zb7juXIWo391RyeG41UeA+f
	XArqXMRx5Xh5T7ae092ODNQzmPaPjtfY1KrYC/Uldq66O529gz39z65KzydmFzws
	bKsD8OcEnsNMvV3sEK0wgs3FSva/QKf77UgDlAEX42pFAMBPnYknhuFVMu0rLnrQ
	2u2RY6lQHBpmqx19Fn+VdFbU9RQiTbYjVozJYUBaxWyQEVfULIh1nQRh4pFMoqra
	UwdqdLXBcFrKGNFnpwjCRZHpLJh/SHp/ZN8C6yXYB8iCD+8pW25B2NT/Low==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjgy3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:40:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so9892031eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790750402; x=1791355202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OWABlvWmQDeWp98OxpVQtoQURxY/W2DmFEPy2By3PM=;
        b=iQw9RUT4c08meQ7kUX0pqZH/DzfSw7PpZkjEeMxjmWdCwPK+md37+5/YCvXCZuf5xs
         +oXRdj+0SNoaj/J2AHMfcg7h1nizj6+bBhrP6JaJz4I9dDmTLU0URhW7KiD8yIiY31KH
         xUW3H50QlfnrHelVIXwSDnCEmZxubEWZ3AePRNaqyTvIyd6f+gw6hRfb8ePl6hjZu8wa
         Xyb8KgbEshd0BB2mLTmWZLiI55F5rLW3kMQ4ZET9xQku8l003CWtUm4fRSg7v6VzB3L3
         fyDt//6RyjG+fqqzCkNpM791zMZ4wetWHlYswiHreF+ymg+5P3o2wJpcTF6i0+qdz6Q4
         pAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790750402; x=1791355202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OWABlvWmQDeWp98OxpVQtoQURxY/W2DmFEPy2By3PM=;
        b=l9S+im+Lq3K8z8vYqfY71WWgCYr7T8x6A8NDdSHb9MPxOFiwxx/r2BfOZLoc9BUez+
         zquqkbRv8YxWY81XiHcGfTZOsQbN465/ZdvAl8uLGg1aGSQeQhKnRh+5fV2i+Nst7NG1
         bcerm5kX3MidaIPhPkHZcmyq9vcbfOR0PmbT3lydbXRgArZEmHd4SUhJ/qbh7+U7qNZb
         iFy7rAASxQtVeFfgNUu8jwrNdfliZVHY76wm7NEsr4PPFO1ooZhkBnoeG5MoxCVX78fC
         IHEj3HkJza9a98utG4kZ/SSPMxM/+BgAcdLsBaLnWkqDw8SMyeb+ZMltBES73YUbwFUJ
         1VDg==
X-Forwarded-Encrypted: i=1; AKwUvBy5YX6KzFN4jVUsT/oRzM50bLzRMrLv5goJdwZ6v+p4UjiIErZ5HKoTo4zIm18+3DxIFBJDDblsYJYncXnpc5zB@vger.kernel.org
X-Gm-Message-State: AFuF++m6aIv7bjiziTMM6Iq6Yh9X3l6y04WEX0LCWGg2EpIP/SNlY4eA
	mqM2DkVuApG7fKlUHz8QBWs1mP+bVpDAnQHCEcOLCEkgYTlu6ykAVntODjZ1LGbIytv7fpnoOLd
	QnlHVbRnheq+HjPJDm8pLACmyzVplELs0uYwToWJo9c1Zxd7MV5Z+IT6e7oq9PkKu2j21bZPE
X-Gm-Gg: AYBFou2bnHTAKI1nMN9r18iQ5VWZqbtXxEATJO8z3YwrKc4+GaR37YRjToS14JCDkrN
	F1JNrXjp6lBG//jh3bCQFtmdjJLCHj5KcCt8ANHic1N5XCTWLPtc9epTW0ZmrxrJnqRJHVpWkaQ
	F7s114wDa/7cmI6p5mcWP/K+6weVi/Uax5NFvSZ0bLwif13Jyb+wcUof7JrNtoV3aOiGWi2WSdB
	c2zp+8DCz2s0n6ZMg5BiMfOdoBYsDxRel0MlrDetKy9vyJFkvtyHroAbdZ+h8+utGU5KPkbYpUm
	fPvPVNYs8XqOHIbmWhtLVgupABUFN9BrgWRvyUoSXWBi6/nFdrboC53/wLJTNc7m5lJoTOqnWu8
	xeeiTe3QYbhY0cMWLRms35bSMNjh7i/AlusYOoGWQ/AwY3+ihP7/Uct68qvOoDtguE5AyBVuA/M
	RhtAir5WHEHvRNR99A9/DwC0DX
X-Received: by 2002:a05:7022:ea9c:b0:14b:2397:d8f1 with SMTP id a92af1059eb24-14d3204deb9mr213391c88.9.1790750401339;
        Tue, 29 Sep 2026 23:40:01 -0700 (PDT)
X-Received: by 2002:a05:7022:ea9c:b0:14b:2397:d8f1 with SMTP id a92af1059eb24-14d3204deb9mr213360c88.9.1790750400667;
        Tue, 29 Sep 2026 23:40:00 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d08fb50f1sm2711531c88.13.2026.09.29.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:40:00 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alex@ghiti.fr,
        aou@eecs.berkeley.edu, jtaubepe@redhat.com, palmer@dabbelt.com,
        pjw@kernel.org, qingfang.deng@linux.dev, shuah@kernel.org,
        thecharlesjenkins@gmail.com, cp0613@linux.alibaba.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v7 6/8] riscv: Add software supported single stepping with mc/mc6 triggers
Date: Wed, 30 Sep 2026 12:09:17 +0530
Message-ID: <20260930063919.608911-7-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX7Ebixe1Oa25E
 f0eeISEZ+5gQvcSiDNqUjd0EOFGCSomBkvYDG8RJNavMyBiJ5LVM5MsYIkLV16QAai0xnaDckut
 dSUZm5JHCjhlGChs1nmp0vdRE9Vy0MQ=
X-Proofpoint-GUID: pPUsZbjgwQjG6oP6j2yo68EklIYvkK-A
X-Proofpoint-ORIG-GUID: pPUsZbjgwQjG6oP6j2yo68EklIYvkK-A
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcaec2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=YfvAyfKA-KDybrY5ebIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX1XYx6/dXzWG0
 xR0QIAhwZV3E4yIwsb1i5EWb8F2flGmkzILL5+Es1mt/whI2yDt9uJcHP/Lfni4GLvoPLxuKOVP
 /39ZajM90bfskUe7B1VCsdlr2v6dN40aZaytdjQFcFpVBFUjJkv+brRAUaTklA7hpZyMtECNfoY
 VRjL7GvRYbv5y6CToHmynnW/b9ul0ooSHyodqE1JnslhVHdB/+zj33RXrCGYmTgDRfMYS1NUbKM
 Nbi4kP9vOdBaH/C2J61lLuS1Rhwd/CXsrDtoTjwEEJvE5pCcD2U4Z8KsqM8t3fT+P6WYWZtVGxu
 eYgFzvDMW7WtoDPXfyNPTyW5hcHnItq5J25J7SmfCyrcE5eNL6H0fvdUO1BGPfor16dgR93cAJg
 dHjGfk3LZwHVlyu1kfMhFnOWJmTRxlrxE41OzxuvFCzlkRfDr0AiMro21fkBGGP5HNb2xx2K4Ho
 gO/xV6MhoXzw/eKuJOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026

With mc/mc6 triggers, after handling breakpoint at current pc, there
is no way to tell trigger to skip same breakpoint after the handler
returns. This can cause loop of breakpoints at the same address until
the trigger is disabled or uninstalled. Debugger may keep the breakpoints
enabled and if kernel disables it, there is a loss of state coherency.

To avoid the loop, software disables the current breakpoint, finds the
next instruction that would be executed after pc and puts a breakpoint
at that address. When this breakpoint hits, old breakpoint is reinstalled.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/hw_breakpoint.h |   9 +
 arch/riscv/kernel/hw_breakpoint.c      | 256 +++++++++++++++++++------
 2 files changed, 202 insertions(+), 63 deletions(-)

diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
index ca2ef93c020c..93cbf39f4b4a 100644
--- a/arch/riscv/include/asm/hw_breakpoint.h
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -280,6 +280,10 @@ struct arch_hw_breakpoint {
 	unsigned long address;
 	unsigned long len;
 	unsigned int type;
+
+	/* Single-step callback info */
+	unsigned long next_addr;
+	bool in_callback;
 	unsigned int match;
 	unsigned int chain;
 	unsigned int select;
@@ -289,6 +293,11 @@ struct arch_hw_breakpoint {
 	unsigned long tdata1;
 	unsigned long tdata2;
 	unsigned long tdata3;
+
+	/* Saved trigger config for single-step restore */
+	unsigned long saved_tdata1;
+	unsigned long saved_tdata2;
+	unsigned long saved_tdata3;
 };
 
 struct perf_event_attr;
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
index dd6f63953969..9597ed362537 100644
--- a/arch/riscv/kernel/hw_breakpoint.c
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -11,9 +11,12 @@
 #include <linux/percpu.h>
 #include <linux/kdebug.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/math.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 
+#include <asm/insn.h>
 #include <asm/sbi.h>
 
 /* Registered per-cpu bp/wp */
@@ -328,8 +331,11 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 
 	/* Breakpoint address */
 	hw->address = attr->bp_addr;
+	hw->tdata1 = 0;
 	hw->tdata2 = attr->bp_addr;
 	hw->tdata3 = 0x0;
+	hw->next_addr = 0x0;
+	hw->in_callback = false;
 
 	switch (dbtr_type) {
 	case RISCV_DBTR_TRIG_MCONTROL:
@@ -347,6 +353,93 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	return ret;
 }
 
+static ulong get_step_address(struct pt_regs *regs, ulong insn)
+{
+	return get_next_insn_address(regs, insn, regs->epc);
+}
+
+/*
+ * setup_singlestep - Set the breakpoint to next instruction after current breakpoint.
+ */
+static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	unsigned long insn, next_addr = 0;
+	int ret;
+	struct arch_hw_breakpoint tmp = {};
+
+	/*
+	 * Save the original trigger configuration so we can restore it
+	 * after the single-step fires.
+	 */
+	bp->saved_tdata1 = bp->tdata1;
+	bp->saved_tdata2 = bp->tdata2;
+	bp->saved_tdata3 = bp->tdata3;
+
+	ret = get_insn_safe(regs, regs->epc, &insn);
+	if (ret < 0)
+		return ret;
+
+	next_addr = get_step_address(regs, insn);
+
+	/*
+	 * Software path: update the trigger in-place to an execute
+	 * breakpoint at next_addr.  Build the tdata directly without
+	 * calling hw_breakpoint_arch_parse() so that bp->len, bp->type
+	 * and bp->address are not overwritten and remain valid for the
+	 * handler's matching logic after restore.
+	 */
+	tmp.tdata1 = 0;
+	tmp.tdata2 = next_addr;
+	tmp.tdata3 = 0;
+	switch (dbtr_type) {
+	case RISCV_DBTR_TRIG_MCONTROL6:
+		RISCV_DBTR_SET_MC6_EXEC_BIT(tmp.tdata1);
+		tmp.tdata1 = RISCV_DBTR_SET_MC6_SIZE(tmp.tdata1, 0);
+		tmp.tdata1 = RISCV_DBTR_SET_MC6_TYPE(tmp.tdata1,
+						     RISCV_DBTR_TRIG_MCONTROL6);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_DMODE_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_TIMING_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_SELECT_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_ACTION_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_CHAIN_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_MATCH_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_M_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_VS_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_VU_BIT);
+		SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_S_BIT);
+		SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_U_BIT);
+		break;
+	case RISCV_DBTR_TRIG_MCONTROL:
+		RISCV_DBTR_SET_MC_EXEC_BIT(tmp.tdata1);
+		tmp.tdata1 = RISCV_DBTR_SET_MC_SIZELO(tmp.tdata1, 0);
+		tmp.tdata1 = RISCV_DBTR_SET_MC_SIZEHI(tmp.tdata1, 0);
+		tmp.tdata1 = RISCV_DBTR_SET_MC_TYPE(tmp.tdata1,
+						    RISCV_DBTR_TRIG_MCONTROL);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_DMODE_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_TIMING_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_SELECT_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_ACTION_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_CHAIN_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_MATCH_BIT);
+		CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_M_BIT);
+		SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_S_BIT);
+		SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_U_BIT);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	bp->tdata1 = tmp.tdata1;
+	bp->tdata2 = next_addr;
+	bp->tdata3 = 0;
+	arch_update_hw_breakpoint(event);
+
+	bp->in_callback = true;
+	bp->next_addr = next_addr;
+	return 0;
+}
+
 /*
  * Read mcontrol6's hit1:hit0 field for trigger @idx. If either bit is set,
  * clear it in hardware (the Debug spec requires the trigger user to do
@@ -401,10 +494,10 @@ static unsigned int mc6_read_and_clear_hit(int idx)
  */
 static int hw_breakpoint_handler(struct die_args *args)
 {
-	int ret = NOTIFY_DONE;
+	int i, ret = 0, bp_ret = NOTIFY_DONE;
+	bool expecting_callback = false;
 	struct arch_hw_breakpoint *bp;
 	struct perf_event *event;
-	int i;
 
 	for (i = 0; i < dbtr_total_num; i++) {
 		event = this_cpu_read(pcpu_hw_bp_events[i]);
@@ -412,85 +505,122 @@ static int hw_breakpoint_handler(struct die_args *args)
 			continue;
 
 		bp = counter_arch_bp(event);
-		switch (bp->type) {
-		/* Breakpoint */
-		case HW_BREAKPOINT_X:
-		{
-			bool hit = bp->address == args->regs->epc;
 
-			if (!hit && dbtr_type == RISCV_DBTR_TRIG_MCONTROL6)
-				hit = mc6_read_and_clear_hit(i) != RISCV_DBTR_MC6_HIT_FALSE;
+		if (bp->in_callback) {
+			expecting_callback = true;
+			if (args->regs->epc != bp->next_addr)
+				continue;
+
+			arch_uninstall_hw_breakpoint(event);
 
-			if (hit) {
-				perf_bp_event(event, args->regs);
-				ret = NOTIFY_STOP;
+			/* Restore original breakpoint */
+			if (hw_breakpoint_arch_parse(NULL, &event->attr, bp))
+				goto exit;
+
+			if (arch_install_hw_breakpoint(event))
+				goto exit;
+
+			bp->in_callback = false;
+			bp_ret = NOTIFY_STOP;
+			goto exit;
+		}
+
+		switch (event->attr.bp_type) {
+		/* Breakpoint */
+		case HW_BREAKPOINT_X:
+			{
+				bool hit = bp->address == args->regs->epc;
+
+				if (!hit && dbtr_type == RISCV_DBTR_TRIG_MCONTROL6)
+					hit = mc6_read_and_clear_hit(i) != RISCV_DBTR_MC6_HIT_FALSE;
+
+				if (hit) {
+					perf_bp_event(event, args->regs);
+					ret = setup_singlestep(event, args->regs);
+					if (ret < 0) {
+						pr_err("Single step setup failed: %d.\n", ret);
+						goto exit;
+					}
+					bp_ret = NOTIFY_STOP;
+					goto exit;
+				}
 			}
 			break;
-		}
 
 		/* Watchpoint */
 		case HW_BREAKPOINT_W:
 		case HW_BREAKPOINT_R:
 		case HW_BREAKPOINT_RW:
-		{
-			unsigned long stval = args->regs->badaddr;
-			unsigned long bp_start = bp->address;
-			unsigned long bp_len = bp->len ?: 1;
-			unsigned long bp_end = bp_start + bp_len - 1;
-			unsigned long stval_end = stval + sizeof(long) - 1;
-			bool hit = false;
-
-			if (bp_end < bp_start)
-				bp_end = ~0UL;
-			if (stval_end < stval)
-				stval_end = ~0UL;
-
-			/*
-			 * Prefer tdata1.hit from SBI trigger readout whenever
-			 * possible. Fall back to address-based matching if HIT
-			 * isn't observed/supported.
-			 */
-			if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL) {
-				unsigned long tdata1;
-				struct sbiret sret;
-				union sbi_dbtr_shmem_entry *shmem;
-
-				raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
-						      *this_cpu_ptr(&ecall_lock_flags));
-				shmem = this_cpu_ptr(sbi_dbtr_shmem);
-				sret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
-						 i, 1, 0, 0, 0, 0);
-				if (!sret.error) {
-					tdata1 = le_to_cpu(shmem->data.tdata1);
-					hit = !!(tdata1 & RISCV_DBTR_MC_HIT_BIT_MASK);
+			{
+				unsigned long stval = args->regs->badaddr;
+				unsigned long bp_start = bp->address;
+				unsigned long bp_len = bp->len ?: 1;
+				unsigned long bp_end = bp_start + bp_len - 1;
+				unsigned long stval_end = stval + sizeof(long) - 1;
+				bool hit = false;
+
+				if (bp_end < bp_start)
+					bp_end = ~0UL;
+				if (stval_end < stval)
+					stval_end = ~0UL;
+
+				/*
+				 * Prefer tdata1.hit from SBI trigger readout whenever
+				 * possible. Fall back to address-based matching if HIT
+				 * isn't observed/supported.
+				 */
+				if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL) {
+					unsigned long tdata1;
+					struct sbiret sret;
+					union sbi_dbtr_shmem_entry *shmem;
+
+					raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+							      *this_cpu_ptr(&ecall_lock_flags));
+					shmem = this_cpu_ptr(sbi_dbtr_shmem);
+					sret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
+							 i, 1, 0, 0, 0, 0);
+					if (!sret.error) {
+						tdata1 = le_to_cpu(shmem->data.tdata1);
+						hit = !!(tdata1 & RISCV_DBTR_MC_HIT_BIT_MASK);
+					}
+					raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+								   *this_cpu_ptr(&ecall_lock_flags));
+				} else if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL6) {
+					hit = mc6_read_and_clear_hit(i) != RISCV_DBTR_MC6_HIT_FALSE;
 				}
-				raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
-							   *this_cpu_ptr(&ecall_lock_flags));
-			} else if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL6) {
-				hit = mc6_read_and_clear_hit(i) != RISCV_DBTR_MC6_HIT_FALSE;
-			}
 
-			/*
-			 * Sdtrig may report STVAL as the lowest accessed
-			 * address while the watchpoint can match a higher byte
-			 * in the same access.
-			 */
-			if (hit ||
-			    (stval >= bp_start && stval <= bp_end) ||
-			    (bp_start >= stval && bp_start <= stval_end)) {
-				perf_bp_event(event, args->regs);
-				ret = NOTIFY_STOP;
+				/*
+				 * Sdtrig may report STVAL as the lowest accessed
+				 * address while the watchpoint can match a higher byte
+				 * in the same access.
+				 */
+				if (hit ||
+				    (stval >= bp_start && stval <= bp_end) ||
+				    (bp_start >= stval && bp_start <= stval_end)) {
+					perf_bp_event(event, args->regs);
+					ret = setup_singlestep(event, args->regs);
+					if (ret < 0) {
+						pr_err("setup_singlestep failed %d.\n", ret);
+						goto exit;
+					}
+					bp_ret = NOTIFY_STOP;
+					goto exit;
+				}
 			}
 			break;
-		}
 
 		default:
-			pr_warn("Unknown type: %u\n", bp->type);
-			break;
+			pr_warn("Unknown type: %u\n", event->attr.bp_type);
+			goto exit;
 		}
 	}
 
-	return ret;
+	if (expecting_callback) {
+		pr_err("in_callback set but epc (%lx) not at next_addr (%lx).\n",
+		       args->regs->epc, bp->next_addr);
+	}
+exit:
+	return bp_ret;
 }
 
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
-- 
2.43.0

