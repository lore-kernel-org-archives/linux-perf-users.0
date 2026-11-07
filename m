Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019227;
	b=qVj+AxDKTAOX/KdoOeT5QEhWmd2TVsdsz9XBAE3aD3i1/GSeZnjrq4lEAO6IQOdueWzJ
	 RhM0eBkNNSao9x1OXdhAd4OBrm9ByxeiLtP/1W1Yg8S/RsKzTypJWtTp7+A02ALxKJTGp
	 MNfendONfgeLwoXTU8ILNtQAWxl0aU2RdJOlEWslCqvV4RxvxdEkpNoJPwhIjK1h4vSh7
	 XMiHA5aXJ8ai6ydlBUP9dgHZZniDh7mvzsG8U74Yr6UWhkvZbMu3I6iOLm7dEx+B+Ysxd
	 PKCrJcDKvSDRIjDA5GsvNPjpSuKzFxJSGJcrg6HwxxUvcvwYXkVe/+GKBo8vzXryoDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019227;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sxv5EqtnYWUCOVJkYUviHmwxoOD0vd5Ri8oexCtFYW4=;
	b=ivbKCSl5CTEycBzgJUqGIrzotmY7or7N1YCFKXnnrgeMGEz/V1ghbOiQaS7yYRVhI7jn
	 2fN22MjkYYkGU178lTofzxkUf3HrE1j7V0fdWXRlRF9X26QatPndomUGEQ8vhcpjdR/e3
	 piszpXaP0wAw1twG+8C5TXQDS3JYCw5y56eT6EVpZ87yeYrsuIHLH8Zr2tsUR0hbCYp9g
	 W2+6KtCgNH9vlANgVmAeXG3FYqVUBcT5J8Ot3ymEqknAIqS0LKYoeVZVywFNmvsGhx45/
	 SULulFL17aHI/7PNePLD4DAn4rD7DAug14Sw9wj5swST5/EMIjfeFSVpm7k6DOcxEwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1gmG5pY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AZUDdQz4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9A606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B9A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1gmG5pY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AZUDdQz4
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A72AhtT2563177
	for <linux-perf-users@vger.kernel.org>; Sat, 7 Nov 2026 02:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sxv5EqtnYWU
	COVJkYUviHmwxoOD0vd5Ri8oexCtFYW4=; b=L1gmG5pYYAgjaDrzkHaVi16Gsq6
	/LL/bdPzdAX+2q1kcDuvVuYbcHTP9YzU9jn16oZISlObiwgRlIxwbZW9kJI9vQUj
	WVGtlB3lCpDLs2sRw5F137AbZn8tqtHCfw1DoysxFjVKjoM/HCiWHUnWVF9YvRF8
	q4DeiWs7kiZTohtW0hA9dT/QPrJnvSPDnMNQDBD8/F2eKDk448Wx6S3wG7/cBwSs
	IO/cNrdrg8zXPxmdC79q77wGkr5uVdPkdfVXICkT9OltUFRUPjMJ3fchFLYcaMa7
	ZUltcETQFkaXmYGOJNKXt7SiZ6PyJs2iYJLoKbueD3CNUN5AosrUJ+Nol9A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxs82yr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 02:40:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2313166eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794019226; x=1794624026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxv5EqtnYWUCOVJkYUviHmwxoOD0vd5Ri8oexCtFYW4=;
        b=AZUDdQz4GnFK74AM6JZjHJ5yQBaIhAD3Hlsl5EEGfCF9O6LekDTVFe7zuP5Lt/tRON
         FFxQacwSQWI/V/u+TgOIOTgUmMT+HDHXVzWWCt43cgn0eLcS8ln3vD+pUdmPgyMRUCND
         aimgQHQSVu0lT7nmBlDDVLKCNfo+5cgITt2njE3LchirHHOkMUPXdFULu1pISORAWQVx
         +th3CMY8kKxhj/QTAhvEfSxZ75nhS6Fg4pzUyFsX4kxPFfF7L/B0kAARRyOtrGRtiw1c
         fCa/n6MQk4YCyTlwDGcKIIblXwLPm7+lXRrAc/ygJYZGbY3b4XfbqRcDO89WetzAK96X
         ZGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794019226; x=1794624026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxv5EqtnYWUCOVJkYUviHmwxoOD0vd5Ri8oexCtFYW4=;
        b=blmPdYNGQPGLLYGVCwP0pAXij2u6oBqqSFhIAyJKy71dKTnUgtXrGTltagjfm2qgg+
         oPW/oIvb3QBl9xuOim0BIgt86P92aazpuVldA3i+R7O9xnkVVDCypY0sOfOw8B6r/zX/
         hoP2MtIHJx8OasekuWQG+boHh2G6y10X2mMDpe8iEu86ffNnCcr6CH/CcM2eoBcJVbXX
         9bIhVisCc36aKYZIDAtuAzq5zbSqlYwsHXHKHAmSiqwgZYbEDi6pxnRnd037Z+wgMqYL
         hsOlzEHDW4t4EsnAKEDv+Aa8xOglBvWbFiMVatlYa77mKwEAK8w1SAW+mgyiPCyQ9z7r
         ujeQ==
X-Forwarded-Encrypted: i=1; AKwUvByozpLRt0/eryj58SawWnOmw6RaoqNwG8Fr2phSrItIkzDtrYkWl7a2Umk9gomAiBV56Z5xrBnbjANu1024V7Li@vger.kernel.org
X-Gm-Message-State: APuU4Z8celNzN29GanmEY62KlCdATaU0hHgqY3xvvyZCqVCPKYsUaW8N
	hM6T18ElcAqbt3MzT+GGLKIwFf/JQKxlf+Ygi5pdvT8SmZTidCXZLl42Ti2tfVxkEdGo+yc8v/W
	8RGyFIY2YOGoeF17nUFdWJtRS6c23vBJ2guxqX7R9Ko6pTT6Z8Sk5UrtPFCn8YEb2Ya/fdNkL
X-Gm-Gg: AYBFou2YxjHAVHgKWevkX0G2FlzOyATO70xIMQPyO8FgB3f9MTOYc1SMWc2VDwo5gsg
	MnoHWPd+GfT79VwgDS4PuHCt0M6cvDxPvBFSXCmF2eKEATWLq1+dYgMCO7CjiRpkPO61hL4spi7
	+xMpjHpmHgwwgM7oO0T0vuZE8nupqNhuBAbtk+azldxHo2zhZ/wgjDx9o/ceHJBpgr3EIlYPxx8
	yNvg0uY1FP7oati1LfY7Fg8foTl9aQujR/dFv3/6HTIaM7zdciInQC9hBaEY+tjSI5T6Efcx8G/
	4uSy0k4QCswupWYQWoWOJHQASPEP/OiNbSYh6Jcb/DAIj119L1En/2g3Ozw2+8U7qwjYoLdn2t5
	Pv6ySwzoObzoeXrbPB3TiNusQAKi5aHcPTJg7wc849tumL6z9Qrz1S1RpvYo12StHDD0iNowFTq
	wlLmxa9T862MVRphg2xq/geqC4PBB+Q1akENJrfs/OoI3Z/KwpPYRT2q0TL0MaH9qQCxq0HSZw5
	w==
X-Received: by 2002:a05:7301:6190:20b0:36a:1089:9836 with SMTP id 5a478bee46e88-36f75839295mr5734766eec.15.1794019225373;
        Fri, 06 Nov 2026 18:40:25 -0800 (PST)
X-Received: by 2002:a05:7301:6190:20b0:36a:1089:9836 with SMTP id 5a478bee46e88-36f75839295mr5734715eec.15.1794019224581;
        Fri, 06 Nov 2026 18:40:24 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm11069040eec.29.2026.11.06.18.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:40:24 -0800 (PST)
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
Subject: [PATCH v8 7/8] riscv: Add software supported single stepping with mc/mc6 triggers
Date: Sat,  7 Nov 2026 08:09:16 +0530
Message-ID: <20261107023917.40606-8-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: -YtqUr7OU0RcMfARdMgX6RVQGCyMO-FW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX9EM3CSOy5RAl
 kbq42v7JBuxbsWaJ4llCoTzWwxz+r6xmXocWF3KK1BfPX+19qKNZgV6tAHCyXWJzx9rIM0ocoDg
 iNVIxASakU4K2JZYwEP+nHTNlXpqGqA=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6aee8f9a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=m8l0dXrX7-G3mt2yGekA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX9TDY43vriCA8
 nVIE9KXdrUG2gPy8b+JozGB7HpstC78F/gzYKYqHoL3G7Ektt7unJ/MldBSbBolCiyySJCTfeUy
 lrKr3NeRxwOXJXbm3l4PQF88o1W6zbQ/xUq3sQk7QNQctR6uNmkGTtyTqySM3UAUjw3KyELc492
 SOlDS9aav0kMwFQKsCkq2rocKlYuZFtbKNTWxM1O8ffQ3LAO3jesZaO8vy6UPUVuyurAsWiBhzY
 az2IhPGraJhaDbnPlGujLpPulwxfBtT4zTaFV7Qj1AsGT891NeEPHXyfBGm0gq7bCZjcX6xzTaK
 /T8inMIxteNJoHn0eFpjItEHfmEHV5RIrnruk8wXFbkk8GzgscbG3bVmYQinNUB01ePYExAywKV
 UF2aGRLHtppYytsXOd5fzreV12N1etDEa+bCtGghYc0/Lsg5tXWt+unEvnSkNfxwxfTSUIW/XuO
 PEIerOzSZe/X2IGjOnw==
X-Proofpoint-GUID: -YtqUr7OU0RcMfARdMgX6RVQGCyMO-FW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070010

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
 arch/riscv/include/asm/hw_breakpoint.h |  16 ++
 arch/riscv/kernel/hw_breakpoint.c      | 297 ++++++++++++++++++++++++-
 2 files changed, 308 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
index 6e8913d69df2..b3ccebb5185e 100644
--- a/arch/riscv/include/asm/hw_breakpoint.h
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -15,10 +15,26 @@ struct task_struct;
 /* Maximum number of hardware breakpoints supported */
 #define RISCV_MAX_BP		16
 
+enum riscv_hw_bp_step_method {
+	RISCV_HW_BP_STEP_DISABLED,
+	RISCV_HW_BP_STEP_ICOUNT,
+	RISCV_HW_BP_STEP_SW,
+};
+
 struct arch_hw_breakpoint {
 	unsigned long address;
 	unsigned long len;
 	unsigned int type;
+
+	/*
+	 * Single-step callback state.  While step_method is enabled, the
+	 * hardware slot is temporarily programmed as either an icount trigger
+	 * or an execute trigger at next_addr, and the original trigger config
+	 * is restored when that temporary trigger fires.
+	 */
+	unsigned long next_addr;
+	enum riscv_hw_bp_step_method step_method;
+	bool pending_perf_event;
 	unsigned int match;
 	unsigned int chain;
 	unsigned int select;
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
index 4231170d4901..72be50943937 100644
--- a/arch/riscv/kernel/hw_breakpoint.c
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -15,6 +15,7 @@
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 
+#include <asm/insn.h>
 #include <asm/sbi.h>
 
 #define RISCV_HW_BP_NUM_MAX	32
@@ -62,6 +63,9 @@ enum {
 #define RISCV_DBTR_MC6_HIT1		BIT(25)
 #define RISCV_DBTR_MC6_HIT_MASK	(RISCV_DBTR_MC6_HIT | RISCV_DBTR_MC6_HIT1)
 
+#define RISCV_DBTR_ICOUNT_U		BIT(6)
+#define RISCV_DBTR_ICOUNT_COUNT_MASK	GENMASK(23, 10)
+
 #define RISCV_DBTR_MC6_HIT_FALSE	0
 #define RISCV_DBTR_MC6_HIT_BEFORE	1
 #define RISCV_DBTR_MC6_HIT_AFTER	2
@@ -77,6 +81,7 @@ static union sbi_dbtr_shmem_entry __percpu *sbi_dbtr_shmem;
 /* number of debug triggers on this cpu . */
 static int dbtr_total_num __ro_after_init;
 static int dbtr_type __ro_after_init;
+static bool dbtr_icount_available __ro_after_init;
 static unsigned long dbtr_init __ro_after_init;
 
 #define MEM_HI(_m)		\
@@ -194,6 +199,17 @@ static void init_sbi_dbtr(void)
 		return;
 	}
 
+	tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_ICOUNT);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to detect icount triggers\n");
+	} else if (ret.value) {
+		dbtr_icount_available = 1;
+		pr_warn("Icount trigger available.\n");
+	}
+
 	tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL6);
 
 	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
@@ -397,6 +413,9 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->tdata1 = 0;
 	hw->tdata2 = attr->bp_addr;
 	hw->tdata3 = 0x0;
+	hw->next_addr = 0x0;
+	hw->step_method = RISCV_HW_BP_STEP_DISABLED;
+	hw->pending_perf_event = false;
 
 	switch (dbtr_type) {
 	case RISCV_DBTR_TRIG_MCONTROL:
@@ -414,6 +433,168 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	return ret;
 }
 
+static ulong get_step_address(struct pt_regs *regs, ulong insn)
+{
+	return get_next_insn_address(regs, insn, regs->epc);
+}
+
+static int dbtr_update_event_tdata(struct perf_event *event,
+				   unsigned long tdata1,
+				   unsigned long tdata2,
+				   unsigned long tdata3, bool wait);
+
+static bool hw_breakpoint_event_active(struct perf_event *event)
+{
+	return READ_ONCE(event->state) == PERF_EVENT_STATE_ACTIVE;
+}
+
+static void clear_singlestep_state(struct arch_hw_breakpoint *bp)
+{
+	bp->step_method = RISCV_HW_BP_STEP_DISABLED;
+	bp->next_addr = 0;
+	bp->pending_perf_event = false;
+}
+
+static void disable_unhandled_singlestep(struct perf_event *event,
+					 struct pt_regs *regs, bool deliver_event,
+					 int err)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+
+	/*
+	 * If the temporary step trigger cannot be installed or restored, leave
+	 * the CPU with no active trigger instead of re-entering the same debug
+	 * exception forever.
+	 */
+	pr_warn("single-step setup failed for bp_addr=0x%lx epc=0x%lx: %d; disabling event\n",
+		bp->address, regs->epc, err);
+	clear_singlestep_state(bp);
+	if (deliver_event && hw_breakpoint_event_active(event))
+		perf_bp_event(event, regs);
+	if (hw_breakpoint_event_active(event))
+		perf_event_disable_inatomic(event);
+}
+
+static unsigned long icount_step_tdata1(void)
+{
+	return dbtr_tdata1_type(RISCV_DBTR_TRIG_ICOUNT) |
+	       FIELD_PREP(RISCV_DBTR_ICOUNT_COUNT_MASK, 1) |
+	       RISCV_DBTR_ICOUNT_U;
+}
+
+static int restore_original_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	int ret;
+
+	/*
+	 * Rebuild the original trigger from the perf attributes instead of
+	 * keeping a second copy of the trigger data.  Do not update the
+	 * temporary trigger in place when changing back from icount/software-step
+	 * mode: uninstall/install gives the original breakpoint a fresh hardware
+	 * slot and clears any transient hit state.
+	 */
+	arch_uninstall_hw_breakpoint(event);
+
+	ret = hw_breakpoint_arch_parse(NULL, &event->attr, bp);
+	if (ret)
+		return ret;
+
+	return arch_install_hw_breakpoint(event);
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
+	clear_singlestep_state(bp);
+
+	if (dbtr_icount_available && !arch_check_bp_in_kernelspace(bp)) {
+		/*
+		 * User breakpoints can use an icount trigger to retire exactly
+		 * one instruction.  The sdtrig icount path reports EPC after the
+		 * counted instruction, so the callback sees the post-step PC
+		 * without decoding the original instruction here.
+		 */
+		tmp.tdata1 = icount_step_tdata1();
+
+		ret = dbtr_update_event_tdata(event, tmp.tdata1, 0, 0, false);
+		if (ret)
+			return ret;
+
+		bp->step_method = RISCV_HW_BP_STEP_ICOUNT;
+		bp->next_addr = 0;
+		return 0;
+	}
+
+	if (!event->hw.target) {
+		/*
+		 * A CPU-wide software-step trigger follows one task's decoded
+		 * next PC.  If that task migrates, the per-CPU slot may wait
+		 * forever for an address the CPU will not execute.
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	ret = get_insn_safe(regs, regs->epc, &insn);
+	if (ret < 0)
+		return ret;
+
+	next_addr = get_step_address(regs, insn);
+	if (next_addr == regs->epc) {
+		/*
+		 * Some control transfers, notably SRET, cannot be represented
+		 * as an execute breakpoint at a different decoded PC.  Refuse
+		 * the software step rather than programming the same address
+		 * and looping on the original breakpoint.
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Software path: update the trigger in-place to an execute
+	 * breakpoint at next_addr.  Build the tdata directly without
+	 * calling hw_breakpoint_arch_parse() so that bp->len and bp->address
+	 * remain valid for the handler's matching logic after restore.
+	 */
+	tmp.tdata2 = next_addr;
+	tmp.tdata3 = 0;
+	switch (dbtr_type) {
+	case RISCV_DBTR_TRIG_MCONTROL6:
+		tmp.tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL6) |
+			     RISCV_DBTR_MC6_EXEC;
+		if (user_mode(regs))
+			tmp.tdata1 |= RISCV_DBTR_MC6_U;
+		else
+			tmp.tdata1 |= RISCV_DBTR_MC6_S;
+		break;
+	case RISCV_DBTR_TRIG_MCONTROL:
+		tmp.tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL) |
+			     RISCV_DBTR_MC_EXEC;
+		if (user_mode(regs))
+			tmp.tdata1 |= RISCV_DBTR_MC_U;
+		else
+			tmp.tdata1 |= RISCV_DBTR_MC_S;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = dbtr_update_event_tdata(event, tmp.tdata1, next_addr, 0, false);
+	if (ret)
+		return ret;
+
+	bp->step_method = RISCV_HW_BP_STEP_SW;
+	bp->next_addr = next_addr;
+	return 0;
+}
+
 static void dbtr_encode_update(union sbi_dbtr_shmem_entry *shmem,
 			       unsigned long idx, unsigned long tdata1,
 			       unsigned long tdata2, unsigned long tdata3)
@@ -574,12 +755,43 @@ static unsigned int mc6_read_and_clear_hit(int idx)
 	return hit;
 }
 
+static int handle_triggered_breakpoint(struct perf_event *event,
+				       struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	bool defer_perf;
+	int ret;
+
+	/*
+	 * Report user breakpoints after the temporary step trigger advances
+	 * past the armed instruction.  Otherwise signal delivery can re-enter
+	 * the same execute trigger before the PC has moved.
+	 */
+	defer_perf = !arch_check_bp_in_kernelspace(bp);
+	if (!defer_perf) {
+		perf_bp_event(event, regs);
+		if (!hw_breakpoint_event_active(event))
+			return NOTIFY_STOP;
+	}
+
+	ret = setup_singlestep(event, regs);
+	if (ret < 0) {
+		disable_unhandled_singlestep(event, regs, defer_perf, ret);
+		return NOTIFY_STOP;
+	}
+
+	bp->pending_perf_event = defer_perf;
+	return NOTIFY_STOP;
+}
+
 /*
  * HW Breakpoint/watchpoint handler
  */
 static int hw_breakpoint_handler(struct die_args *args)
 {
-	int i, bp_ret = NOTIFY_DONE;
+	int i, ret = 0, bp_ret = NOTIFY_DONE;
+	struct perf_event *deferred_step_event = NULL;
+	struct arch_hw_breakpoint *deferred_step_bp = NULL;
 	struct arch_hw_breakpoint *bp;
 	struct perf_event *event;
 
@@ -590,6 +802,74 @@ static int hw_breakpoint_handler(struct die_args *args)
 
 		bp = counter_arch_bp(event);
 
+		if (bp->step_method != RISCV_HW_BP_STEP_DISABLED) {
+			bool pending_perf_event;
+
+			/*
+			 * This trap is for the temporary trigger installed by
+			 * setup_singlestep().  Software stepping must match the
+			 * decoded next_addr; icount already reports the post-step
+			 * PC and can restore the original trigger immediately.
+			 */
+			if (bp->step_method == RISCV_HW_BP_STEP_SW &&
+			    args->regs->epc != bp->next_addr) {
+				/*
+				 * A nested breakpoint can fire before this
+				 * event reaches its decoded next_addr, for
+				 * example when perf delivers a signal handler
+				 * with its own breakpoint.  Let the later slot
+				 * handle that trap and keep this temporary step
+				 * armed.  If nobody handles the trap, restore
+				 * below so a real divergence does not lose the
+				 * original breakpoint indefinitely.
+				 */
+				deferred_step_event = event;
+				deferred_step_bp = bp;
+				continue;
+			}
+
+			if (bp->step_method == RISCV_HW_BP_STEP_ICOUNT &&
+			    args->regs->epc == bp->address) {
+				unsigned long tdata1 = icount_step_tdata1();
+
+				/*
+				 * A trap can be observed before the original
+				 * user instruction retires, leaving EPC on the
+				 * armed breakpoint.  Delivering the deferred
+				 * perf event here would account the same
+				 * breakpoint twice, so rearm icount and wait for
+				 * a callback with a post-instruction EPC.
+				 */
+				ret = dbtr_update_event_tdata(event, tdata1, 0, 0, false);
+				if (ret) {
+					disable_unhandled_singlestep(event,
+								     args->regs,
+								     bp->pending_perf_event,
+								     ret);
+					bp_ret = NOTIFY_STOP;
+					goto exit;
+				}
+				bp_ret = NOTIFY_STOP;
+				goto exit;
+			}
+
+			pending_perf_event = bp->pending_perf_event;
+
+			ret = restore_original_breakpoint(event);
+			if (ret) {
+				clear_singlestep_state(bp);
+				perf_event_disable_inatomic(event);
+				bp_ret = NOTIFY_STOP;
+				goto exit;
+			}
+
+			clear_singlestep_state(bp);
+			if (pending_perf_event && hw_breakpoint_event_active(event))
+				perf_bp_event(event, args->regs);
+			bp_ret = NOTIFY_STOP;
+			goto exit;
+		}
+
 		switch (event->attr.bp_type) {
 		/* Breakpoint */
 		case HW_BREAKPOINT_X:
@@ -603,8 +883,7 @@ static int hw_breakpoint_handler(struct die_args *args)
 					       RISCV_DBTR_MC6_HIT_FALSE;
 
 				if (hit) {
-					perf_bp_event(event, args->regs);
-					bp_ret = NOTIFY_STOP;
+					bp_ret = handle_triggered_breakpoint(event, args->regs);
 					goto exit;
 				}
 			}
@@ -640,8 +919,7 @@ static int hw_breakpoint_handler(struct die_args *args)
 				hit |= ranges_overlap(bp_start, bp_len, stval,
 						      sizeof(long));
 				if (hit) {
-					perf_bp_event(event, args->regs);
-					bp_ret = NOTIFY_STOP;
+					bp_ret = handle_triggered_breakpoint(event, args->regs);
 					goto exit;
 				}
 			}
@@ -653,6 +931,15 @@ static int hw_breakpoint_handler(struct die_args *args)
 		}
 	}
 
+	if (deferred_step_event) {
+		bp = deferred_step_bp;
+		ret = restore_original_breakpoint(deferred_step_event);
+		if (ret)
+			perf_event_disable_inatomic(deferred_step_event);
+		clear_singlestep_state(bp);
+		bp_ret = NOTIFY_STOP;
+	}
+
 exit:
 	return bp_ret;
 }
-- 
2.43.0

