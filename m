Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019205;
	b=ttwDZ6AkfS45uPYi8dL7PAW9lMWfIhWHr7F65qWcKFNQCmFOCiYmNUwHB542H+o2A0BV
	 PlGnWzCchvRl9fZfJyIY6EM+DLl9QjYZx2dLWAsQ0XogOdrNLiLTlpCs5Y2XGTy8AimyR
	 jfJmX1bHeGpivOwMnEI/S7/Y0Mg2VVJWU3dKEGFtWrJqtdAwvj6Pj6YnBOIzkQPu+QRhO
	 JEPkr2rNgDYU2Ax5alX7/56KV5CJ6RzBTSucFbyygH2EvgcHUpTHZjQCefOo2DEbemlHj
	 hqyPkbQAQBa7BDXKSj4Y1fYWRwOpeSTdA7Epg8EqN0ZHG/EhLJjdQkG2NHf6969QIag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019205;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0vRJrxBmWVbIvLRhEapzyE2zsMF2/4hAuNHs6uFZtVk=;
	b=aaKXeaarZbTNoZldgU10ksto4Zxq8MZsshUFj3+7c71knIFjowpCn1GtSrvlPqiqbS89
	 lgS/LI6OpM25wgWMOdnuaYs4HyZjTkWZRwKzuQ0aNVpbZKrPWKN8BwYozxdVYHCHaltSt
	 /bYcZ4nSNMV3VdlWVU2608DMe8j5BzB6h4dIuDbnzwSejItkXXI2McynbMzPekcO2/8hv
	 jyrdNoOsxllJYy0fHee91gN7sjERX7gAwE1gLXrqbis7AL1xbKdiROkPJZ4qaJ4ka/u8h
	 9+c9r78JsNEK079mg2U6tST6uO/C6jm6fdAm4tpz1C6LufdkG9o3SnWLPgH+sRzPeiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6newvIu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RVXKiCuI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD155606A32C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD155606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6newvIu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RVXKiCuI
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A72B29B1537624
	for <linux-perf-users@vger.kernel.org>; Sat, 7 Nov 2026 02:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0vRJrxBmWVb
	IvLRhEapzyE2zsMF2/4hAuNHs6uFZtVk=; b=H6newvIujGT75ZuPxlanKkixR4o
	KpXY2uYE3AXKRnk/Weuqslh3dJ6BxfNUHPlcB4ZINj7kawdD7VXICZQgozUT8dyE
	ZbppYmYxyA0dXy+0DjIMp0IoDzjWuMwV8qJRY0kJIDOGDLDHt5riVRATFHS5eK0C
	vnub+JfVZSsScIbIVB/w+flY5x10bJezHjhQZ9h6YcB/TXq9zgIoOCA7IUhuZTK9
	PgVDOF3PMvlq+y6uIosog8SObIsLgCUBo3EWWGFyYlCHTEHmXO4W1rzgsYhY8SBQ
	IH26MNinKoz20PMUXmrvOCBtqq6rmT8PoD7iEb0oJDt/zdNBVsBIsnGOTjA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsn03s6ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 02:40:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a3451ea93so1846970eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794019203; x=1794624003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vRJrxBmWVbIvLRhEapzyE2zsMF2/4hAuNHs6uFZtVk=;
        b=RVXKiCuILf4i16cepLPh/n/QImcUTY0aTOb7LioYfiVti37piu+FSwKJ+eF+tMIMrd
         qQbogOuEE9G0wu89zNn/OSjeYcqxvaGcWPihyGzsBIoQizV9KtKrjGwC4301Jt/aOjV1
         AX47chqBY/YeC2ZXpa7QZLftcarUAYNg2sXfITZZAIgibffYcs+QuQCl4z1uGZizW3dV
         U/46qDQqk8aTGJXero5uUFuNqgRFSwffb82wl7fy9NTttnxAtBr/+mcPsVQ8OnoW7Q4s
         bWn0Br3WWB8EVy5k2VuqFMMLiMfx/sMDmFmJGK/e626asW/pbp1GLng5+TzI+OrllSFJ
         ahaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794019203; x=1794624003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0vRJrxBmWVbIvLRhEapzyE2zsMF2/4hAuNHs6uFZtVk=;
        b=EMibmQmRfoAOgsKmiJ6ylW0/7JybkS7who20uf80PKab2TP2MGaowtBK0ELj4iNRg0
         tZYzEMIGOKJ3Z41G/oMGocaR/fD1YLlDJFhTZjYPJgPHobrV8iDl5Mev03bqIpG88UG+
         ZjiHW8pnWGC5LmXZXp0ubIBubG3XsTDJBayZ0n5hcFCaK7sr5TNYL5xM/XD72+0knEir
         UDtQedkeyeANLaU2lO/e3Pn996ckDAxSglzfl/ejW9WC44yBmMI8dN86EdS/THyiH74M
         A4Z4dANOGCjtYuASuLRQnrNYVegm2o5PTNUHeftQZy8FE1h9kFs6Pqm2H1OIZ0/oSqUG
         d5QA==
X-Forwarded-Encrypted: i=1; AL+hErG+sKJg0Komj+k2Mq+bL2W1g9vL7D8stQLtL7p+P9Fo+xre4M17GuSQV3hSLlyPyUOqzDtbrikegsjrmRMJidsy@vger.kernel.org
X-Gm-Message-State: APuU4Z86qIs8+dhzqMQ2Bwbu45T/SI74Np9W0Vy3jcW3pZPaU3FZxuTE
	VBMIzUUsz6rLUgdnWQvmnxA8CAo5wjMQAMnY5pUbT8MlKm4ctsKKrkYOPcR4KQB3Yb84CN6TLSl
	JZ8Q5GHgbpVl0+I098hJvKlvl3f+9gMje0iQw++zSQLDIT5jt2xpzWGxto7g3xo+VieLiylkp
X-Gm-Gg: AYBFou3E4H3ah6AMDDaDXsL7shBFDlfYE61pCYCVlCihFQ2WlFUwv+cWtekTHXYqhHb
	/M7y8Y/bCOpWHLGvcNOwFuzkpcy4smZChUI/9fjVd0MwcpyuxS3wlH6k6uW3fAHjb+j3fn/seP9
	DUaSwO3vPLumTPgfIJT+BXzjrNyaivPWhWlb7yyv7d4Kt3TeGMG5xHfO3ck/HmPe3JP/ewhh0FM
	98vtFRN6QCNT5q7+SgM+1cxq5HG0btVvev2fUYZhFjiO8y/l+UFVCOiiOfpph4gulYAhdLsig+T
	2iLLgnvhMu26BjO2446vwAza4RcaMUHDZpu3LCII4zjvE+r/+QBq/SfDUrFGj3XmdMPqq2Vzr8b
	mqeiPEJtQSeKI2Dytn1zd+HLu08JyjOIh9Hs9ciPLLoAegCO2Uz1KHn5/DbrpP7NZJCSvhCEHxJ
	QKX7ERY9Z/tOu7CqTgQWx+g6NMCpYZhjb2lu2Dkxrl/4KreQCndeh58xeDkrSdBLp/5Oa5WwoDp
	Q==
X-Received: by 2002:a05:7301:190b:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-36f75441608mr5918554eec.8.1794019202543;
        Fri, 06 Nov 2026 18:40:02 -0800 (PST)
X-Received: by 2002:a05:7301:190b:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-36f75441608mr5918516eec.8.1794019201699;
        Fri, 06 Nov 2026 18:40:01 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm11069040eec.29.2026.11.06.18.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:40:01 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jtaubepe@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v8 4/8] riscv: add regset access for hardware breakpoints
Date: Sat,  7 Nov 2026 08:09:13 +0530
Message-ID: <20261107023917.40606-5-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JMSuIMKb c=1 sm=1 tr=0 ts=6aee8f83 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=JzL-O2mrLglAivqIvYYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX8o1U/k/coTZb
 x169FP5nrPOFnc5kBrL8ChfzFvvbzHk3o1yappjWtzxVFuiDH+1bCfyKsHDkxMj9bO+FaKWq21/
 P91yWsLcQPUcYxAro7q7mBARJak3FHc=
X-Proofpoint-ORIG-GUID: KXfZH9f93BwBVOdgX3p_0t6qIMLgsvkZ
X-Proofpoint-GUID: KXfZH9f93BwBVOdgX3p_0t6qIMLgsvkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfXwcBKmtp6Wp6n
 U1ATGEGyC0W9zQmrTOR+yIl6Wjv3t+yAhDUGsYMk87qAcz0p6Ls+JcxmR9bafnYvFF6EEQiLhEH
 TYE2raNF4PnpM9iUKfIDtrWmPU1ktLJjVUp+UCdGPxpcH/UMWuM1/B5fUK8OCE/sPmQ7Rz4+TlB
 EvjQE8j3v2ZpiqJAS/mZOswuonCwBQHcRr1H9sGguPIpLnGjz34m6eal/Sv/Csu1NUsEjSesLm+
 AYqMj7JDZ9OqE6NbogYP0EWOH8g1/LpVMlQorJyJk4XOq50O9EYuaWd0iB4CJgXTPEZ0qmcKAB+
 Gd+zz2bwY5Mqcz4Jhm0mjtZtrxM+WbljpWZsGVkS7vctrOkSasWJ5/eSiVrlyCWYNecQqXlrKfz
 rh85xkNgS2TZGs0E2KdchKhzweE2gW4IfLc3m6IvJt+q2UnkPUqYwFaXUMDNxRADCzAoglwcAOy
 pHTSX6e1g+8dHX7uwGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070010

Add NT_RISCV_HW_BREAK and NT_RISCV_HW_WATCH. A tracer can use
PTRACE_GETREGSET and PTRACE_SETREGSET to read or program the RISC-V
hardware breakpoint and watchpoint slots.

The regset layout uses fixed-width address and control fields. This
keeps the native and compat layouts the same, because the UAPI fields do
not depend on the task word size. Reuse the ptrace-owned perf event
backend from the previous patch.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/uapi/asm/ptrace.h |  41 ++++
 arch/riscv/kernel/ptrace.c           | 340 +++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |   4 +
 tools/include/uapi/linux/elf.h       |   2 +
 4 files changed, 387 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 373a1c14f207..c6beb7b287fe 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/const.h>
+#include <linux/bits.h>
 
 #define PTRACE_GETFDPIC		33
 
@@ -166,6 +167,46 @@ struct user_cfi_state {
 	__u64 shstk_ptr;
 };
 
+/*
+ * bit[3:0]        Match
+ * bit[8:4]        Size
+ * bit[11:9]       When
+ * bit[12]         Select
+ * bit[13]         Chain
+ * bit[16:14]      Type
+ * bit[XLEN-1:17]  Reserved
+ */
+#define HWDEBUG_MATCH_MASK	__GENMASK(3, 0)
+#define HWDEBUG_SIZE_MASK	__GENMASK(8, 4)
+#define HWDEBUG_WHEN_MASK	__GENMASK(11, 9)
+#define HWDEBUG_SELECT_MASK	_BITUL(12)
+#define HWDEBUG_CHAIN_MASK	_BITUL(13)
+#define HWDEBUG_TYPE_MASK	__GENMASK(16, 14)
+
+#define HWDEBUG_MATCH(_ctrl)	(((_ctrl) & HWDEBUG_MATCH_MASK) >> 0)
+#define HWDEBUG_SIZE(_ctrl)	(((_ctrl) & HWDEBUG_SIZE_MASK) >> 4)
+#define HWDEBUG_WHEN(_ctrl)	(((_ctrl) & HWDEBUG_WHEN_MASK) >> 9)
+#define HWDEBUG_SELECT(_ctrl)	(((_ctrl) & HWDEBUG_SELECT_MASK) >> 12)
+#define HWDEBUG_CHAIN(_ctrl)	(((_ctrl) & HWDEBUG_CHAIN_MASK) >> 13)
+#define HWDEBUG_TYPE(_ctrl)	(((_ctrl) & HWDEBUG_TYPE_MASK) >> 14)
+
+#define HWDEBUG_MK_MATCH(_match)	(((_match) << 0) & HWDEBUG_MATCH_MASK)
+#define HWDEBUG_MK_SIZE(_sz)		(((_sz) << 4) & HWDEBUG_SIZE_MASK)
+#define HWDEBUG_MK_WHEN(_when)		(((_when) << 9) & HWDEBUG_WHEN_MASK)
+#define HWDEBUG_MK_SELECT(_sel)		(((_sel) << 12) & HWDEBUG_SELECT_MASK)
+#define HWDEBUG_MK_CHAIN(_chain)	(((_chain) << 13) & HWDEBUG_CHAIN_MASK)
+#define HWDEBUG_MK_TYPE(_type)		(((_type) << 14) & HWDEBUG_TYPE_MASK)
+
+struct user_hwdebug_state {
+	__u32 info;
+	__u32 pad;
+	struct {
+		__u64 addr;
+		__u32 control;
+		__u32 pad;
+	} dbg_regs[16];
+};
+
 struct __riscv_hwdebug_state {
 	__u64 addr;
 	__u64 type;
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index be076865d02d..9959a8e4a307 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -37,6 +37,10 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_USER_CFI
 	REGSET_CFI,
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	REGSET_RISCV_HW_BREAK,
+	REGSET_RISCV_HW_WATCH,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -526,6 +530,302 @@ static struct perf_event *ptrace_hbp_create(enum riscv_hbp_type hbp_type,
 	return bp;
 }
 
+static int ptrace_hbp_note_to_type(unsigned int note_type,
+				   enum riscv_hbp_type *hbp_type)
+{
+	switch (note_type) {
+	case NT_RISCV_HW_BREAK:
+		*hbp_type = RISCV_HBP_BREAK;
+		return 0;
+	case NT_RISCV_HW_WATCH:
+		*hbp_type = RISCV_HBP_WATCH;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ptrace_hbp_fill_attr_ctrl(enum riscv_hbp_type hbp_type,
+				     struct arch_hw_breakpoint *bpctrl,
+				     struct perf_event_attr *attr)
+{
+	int len, type;
+
+	attr->disabled = 0;
+	type = bpctrl->type;
+	len = bpctrl->len;
+
+	switch (hbp_type) {
+	case RISCV_HBP_BREAK:
+		if ((type & HW_BREAKPOINT_X) != type)
+			return -EINVAL;
+		break;
+	case RISCV_HBP_WATCH:
+		if ((type & HW_BREAKPOINT_RW) != type)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	attr->bp_len	= len;
+	attr->bp_type	= type;
+	attr->bp_addr	= bpctrl->address;
+
+	return 0;
+}
+
+static int ptrace_hbp_get_resource_info(enum riscv_hbp_type hbp_type, u32 *info)
+{
+	u8 num;
+
+	/*
+	 * The NT_RISCV_HW_BREAK/WATCH regset ABI exposes 16 register pairs.
+	 * Cap the reported count so GETREGSET/SETREGSET never walk past the
+	 * fixed UAPI array even if the platform has more triggers.
+	 */
+	switch (hbp_type) {
+	case RISCV_HBP_BREAK:
+		num = min_t(unsigned int, hw_breakpoint_slots(TYPE_INST),
+			    RISCV_MAX_BP);
+		break;
+	case RISCV_HBP_WATCH:
+		num = min_t(unsigned int, hw_breakpoint_slots(TYPE_DATA),
+			    RISCV_MAX_BP);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*info = num;
+
+	return 0;
+}
+
+static u32 encode_ctrl_reg(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *bpctrl = counter_arch_bp(bp);
+	u32 ctrl = 0;
+
+	/* Expose the generic UAPI bp_type values in ptrace control bits. */
+	ctrl |= HWDEBUG_MK_TYPE(bp->attr.bp_type);
+	ctrl |= HWDEBUG_MK_MATCH(bpctrl->match);
+	ctrl |= HWDEBUG_MK_SELECT(bpctrl->select);
+	ctrl |= HWDEBUG_MK_WHEN(bpctrl->time);
+	ctrl |= HWDEBUG_MK_SIZE(bp->attr.bp_len);
+	ctrl |= HWDEBUG_MK_CHAIN(bpctrl->chain);
+
+	return ctrl;
+}
+
+static int ptrace_hbp_get_ctrl(enum riscv_hbp_type hbp_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u32 *ctrl)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(hbp_type, tsk, idx);
+
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	*ctrl = bp ? encode_ctrl_reg(bp) : 0;
+	return 0;
+}
+
+static int ptrace_hbp_get_addr(enum riscv_hbp_type hbp_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 *addr)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(hbp_type, tsk, idx);
+
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	*addr = bp ? counter_arch_bp(bp)->address : 0;
+	return 0;
+}
+
+static struct perf_event *ptrace_hbp_get_initialised_bp(enum riscv_hbp_type hbp_type,
+							struct task_struct *tsk,
+							unsigned long idx)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(hbp_type, tsk, idx);
+
+	if (!bp)
+		bp = ptrace_hbp_create(hbp_type, tsk, idx);
+
+	return bp;
+}
+
+static void decode_ctrl_reg(u32 uctrl, struct arch_hw_breakpoint *bpctrl)
+{
+	bpctrl->type = HWDEBUG_TYPE(uctrl);
+	bpctrl->match = HWDEBUG_MATCH(uctrl);
+	bpctrl->select = HWDEBUG_SELECT(uctrl);
+	bpctrl->time = HWDEBUG_WHEN(uctrl);
+	bpctrl->len = HWDEBUG_SIZE(uctrl);
+	bpctrl->chain = HWDEBUG_CHAIN(uctrl);
+}
+
+static int ptrace_hbp_set_ctrl(enum riscv_hbp_type hbp_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u32 uctrl)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	struct arch_hw_breakpoint bpctrl;
+
+	bp = ptrace_hbp_get_initialised_bp(hbp_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	decode_ctrl_reg(uctrl, &bpctrl);
+	bpctrl.address = attr.bp_addr;
+	err = ptrace_hbp_fill_attr_ctrl(hbp_type, &bpctrl, &attr);
+	if (err)
+		return err;
+
+	return modify_user_hw_breakpoint(bp, &attr);
+}
+
+static int ptrace_hbp_set_addr(enum riscv_hbp_type hbp_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 addr)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+
+	bp = ptrace_hbp_get_initialised_bp(hbp_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	attr.bp_addr = addr;
+	err = modify_user_hw_breakpoint(bp, &attr);
+	return err;
+}
+
+#define PTRACE_HBP_ADDR_SZ	sizeof(u64)
+#define PTRACE_HBP_CTRL_SZ	sizeof(u32)
+#define PTRACE_HBP_PAD_SZ	sizeof(u32)
+
+static int riscv_hw_break_get(struct task_struct *target,
+			      const struct user_regset *regset,
+			      struct membuf to)
+{
+	unsigned int note_type = regset->core_note_type;
+	enum riscv_hbp_type hbp_type;
+	int ret, idx, num_slots;
+	u32 info, ctrl;
+	u64 addr;
+
+	ret = ptrace_hbp_note_to_type(note_type, &hbp_type);
+	if (ret)
+		return ret;
+
+	/* Resource info: number of available slots */
+	ret = ptrace_hbp_get_resource_info(hbp_type, &info);
+	if (ret)
+		return ret;
+
+	membuf_write(&to, &info, sizeof(info));
+	membuf_zero(&to, sizeof(u32));
+
+	/* Emit one (address, ctrl, pad) entry per available slot */
+	num_slots = (int)info;
+	for (idx = 0; idx < num_slots; idx++) {
+		ret = ptrace_hbp_get_addr(hbp_type, target, idx, &addr);
+		if (ret)
+			return ret;
+		ret = ptrace_hbp_get_ctrl(hbp_type, target, idx, &ctrl);
+		if (ret)
+			return ret;
+		membuf_store(&to, addr);
+		membuf_store(&to, ctrl);
+		membuf_zero(&to, sizeof(u32));
+	}
+	return 0;
+}
+
+static int riscv_hw_break_set(struct task_struct *target,
+			      const struct user_regset *regset,
+			      unsigned int pos, unsigned int count,
+			      const void *kbuf, const void __user *ubuf)
+{
+	unsigned int note_type = regset->core_note_type;
+	enum riscv_hbp_type hbp_type;
+	int ret, idx = 0, offset, limit;
+	u32 ctrl;
+	u64 addr;
+
+	ret = ptrace_hbp_note_to_type(note_type, &hbp_type);
+	if (ret)
+		return ret;
+
+	/* Resource info and pad */
+	offset = offsetof(struct user_hwdebug_state, dbg_regs);
+	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, offset);
+
+	/* (address, ctrl) registers */
+	limit = regset->n * regset->size;
+	while (count && offset < limit) {
+		if (count < PTRACE_HBP_ADDR_SZ)
+			return -EINVAL;
+
+		/* user_regset_copyin() can do partial copies for odd offsets. */
+		addr = 0;
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
+					 offset, offset + PTRACE_HBP_ADDR_SZ);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_set_addr(hbp_type, target, idx, addr);
+		if (ret)
+			return ret;
+
+		offset += PTRACE_HBP_ADDR_SZ;
+
+		if (!count)
+			break;
+
+		/*
+		 * Reject undersized control writes, and keep ctrl initialized in
+		 * case user_regset_copyin() still performs a partial copy.
+		 */
+		if (count < PTRACE_HBP_CTRL_SZ)
+			return -EINVAL;
+
+		ctrl = 0;
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl,
+					 offset, offset + PTRACE_HBP_CTRL_SZ);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_set_ctrl(hbp_type, target, idx, ctrl);
+		if (ret)
+			return ret;
+
+		offset += PTRACE_HBP_CTRL_SZ;
+
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  offset, offset + PTRACE_HBP_PAD_SZ);
+		offset += PTRACE_HBP_PAD_SZ;
+		idx++;
+	}
+
+	return 0;
+}
+
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
 static struct user_regset riscv_user_regset[] __ro_after_init = {
@@ -577,6 +877,24 @@ static struct user_regset riscv_user_regset[] __ro_after_init = {
 		.set = riscv_cfi_set,
 	},
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	[REGSET_RISCV_HW_BREAK] = {
+		USER_REGSET_NOTE_TYPE(RISCV_HW_BREAK),
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = riscv_hw_break_get,
+		.set = riscv_hw_break_set,
+	},
+	[REGSET_RISCV_HW_WATCH] = {
+		USER_REGSET_NOTE_TYPE(RISCV_HW_WATCH),
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = riscv_hw_break_get,
+		.set = riscv_hw_break_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
@@ -919,6 +1237,28 @@ static const struct user_regset compat_riscv_user_regset[] = {
 		.set = riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	/*
+	 * The hardware-debug regset uses fixed-width UAPI fields, so the
+	 * native layout is also the compat layout.
+	 */
+	[REGSET_RISCV_HW_BREAK] = {
+		USER_REGSET_NOTE_TYPE(RISCV_HW_BREAK),
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = riscv_hw_break_get,
+		.set = riscv_hw_break_set,
+	},
+	[REGSET_RISCV_HW_WATCH] = {
+		USER_REGSET_NOTE_TYPE(RISCV_HW_WATCH),
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = riscv_hw_break_get,
+		.set = riscv_hw_break_set,
+	},
+#endif
 };
 
 static const struct user_regset_view compat_riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index ee30dcd80901..1315ac35157c 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -547,6 +547,10 @@ typedef struct elf64_shdr {
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
 #define NN_RISCV_USER_CFI	"LINUX"
 #define NT_RISCV_USER_CFI	0x903		/* RISC-V shadow stack state */
+#define NN_RISCV_HW_BREAK	"LINUX"
+#define NT_RISCV_HW_BREAK	0x904		/* RISC-V hardware breakpoint registers */
+#define NN_RISCV_HW_WATCH	"LINUX"
+#define NT_RISCV_HW_WATCH	0x905		/* RISCV-V hardware watchpoint registers */
 #define NN_LOONGARCH_CPUCFG	"LINUX"
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NN_LOONGARCH_CSR	"LINUX"
diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
index 5834b83d7f9a..21f225502051 100644
--- a/tools/include/uapi/linux/elf.h
+++ b/tools/include/uapi/linux/elf.h
@@ -460,6 +460,8 @@ typedef struct elf64_shdr {
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NT_RISCV_HW_BREAK	0x904
+#define NT_RISCV_HW_WATCH	0x905
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.43.0

