Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019183;
	b=cx0KS8jgLorwD84Fm002w2ujPSuCvhtagRlrw8omgn37LUvoa3g34/LQ3P9vSu/EaPUO
	 oM7UW9p5yhejKchOtOFcku8zjbaK39c24ITn0CjO40cI4ee/Mw2K+pekzNArdnu4ZsWgT
	 L5exah9OtyBPZmyUKHuomGf5m4SdCjxJxjOJDl/zfLCprunmujJcahETVPkUf3NtoNY5S
	 21HNrPON2BsY860MsxaxBgsnUbfUoE9PHrAksWQij7OJvr1Pz+D+T84/fDTwhIxXSZNTl
	 f6UrvfYYiRkbUr8Ons0AQcW+LtN0iVkH2n/b7z3Rv2HSs5kKzlH9jpc+VaWZ4FSJb6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019183;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DD7zSBTm+fRAOF0y6fbMJq0BP4yAAl3ffI/pbHgz4uo=;
	b=i63aOWX5/ZWIh97DAWK4M5c5zZ9SI7sPIQRSXK0Fqf7acpvj2snpKCUQVMFKaGIgl3Xi
	 WxtwXDw1SYdWpvHYFJaLrQX28onr8ksEBa/OLE6rDh+lkZV7rZnsIZpdCVnrzPYCcpHO7
	 bRwiazteQ8IrY+h+jP/Nh2ibyxVg+qUhCHke4KRTUMdZuBviCNTRNV6n2Uy2A18DzDHuc
	 XTfYHoyNxegez+VmTASq2mRqp0DAJkZ9voKHy5gigY0mvHVvCklI8NTA/M834XkYcfz4T
	 y0ugMhIGdvTc/xnVjL9K1vyhTXBjr7cXSHSP37UZQYJSB7bS1LNe5pE9L1Hfu3DilyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4R0JLOz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bvyut42S;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD1606A32F
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AD1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4R0JLOz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bvyut42S
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A72Xumx1237688
	for <linux-perf-users@vger.kernel.org>; Sat, 7 Nov 2026 02:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DD7zSBTm+fR
	AOF0y6fbMJq0BP4yAAl3ffI/pbHgz4uo=; b=f4R0JLOzdi4aW5Ke8zjPDcpoNEb
	V2YqSAl1etGON1nLYy2CwPN+BJDvXp7FnZbRqrSPxfxI5M9SZwk9FbA8KK/r304f
	NNdJsSLvd0WuJOqSs3uPXPGwX3rTFzXS+LQuS0wx6yeWM3Otp7+h0WEC4lhnJryK
	ts3hwtieG2+53nBkDiG7ARpVeySOZHeMqBkKgNc/oQtrFJ3NDUqvwzv0rS175xWL
	I+HHnrSbaMXlv9En74HrmZSgfB+KDJ2jKZyI8YxTF97O4JLoeP39jP/UCtAGTw44
	tMUsI/3vVPgpCQlhmmP6uTBBI6ay6wFpB4A0EMUWKajx7XGu2F7Aegj4NxQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagr0em-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 02:39:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-370230d93efso1882909eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794019181; x=1794623981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DD7zSBTm+fRAOF0y6fbMJq0BP4yAAl3ffI/pbHgz4uo=;
        b=Bvyut42SUwkGeBCGvWj6rU7KTGRIwCdTl5N0jpPICbARVR1OJngw8NP4+rIQ1Tmp4o
         Qc0CLMl4h6MIFjJwBQWyH/xRYefk+Klp1155BCruPzQ0Eb5eI2rBOXPDllG+GkKYmOgo
         4SW+6t8jMNbk++K2cii3zyiJH3XryNJeeUcGLQlrNOqwBWOKshEFMaRGU7iknWTg9Dv7
         yufBSWo4huAzJKQqI3ZoKyBjOeJj916hItt/8v7kCMq/5468MtLQ+AP/7Z8f3Q+/TrqV
         4/S+rHO7mMO1ss++Ct47+lYxOQ6VgO+4zNsXpWRQ0oDAk8yNmBsr6eK991b7sMjC0+XL
         ex/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794019181; x=1794623981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DD7zSBTm+fRAOF0y6fbMJq0BP4yAAl3ffI/pbHgz4uo=;
        b=Qf1ul9qp47vJKUoli3nmk0DYWRxbVKN1suLCJ2T13J0fUMJ2xCWNIf1LonIVg7vi+V
         h5d52gRiiSv2Uao+0rvBEXh3pW+5+NwcpC6i2nUqaG9PlSh+cDOgmClssJM/44yXHzp6
         GybQkLvw0VRjCp8Y93Z8oe/6SqSMTCSUNem782nTmTDCTH/MJtnST7GirTc0eNXDKl1R
         nGt/+rSbNkuiY6D3vXKYLk1iITVuG/2+hondg+xcjDfSD+k14Wjx6knjltO2tgzEpUq/
         C9Gxnm+Xk6UOw+WY0EiEEye+RvZ0stdm+PhZSuvSeEs1lo0iixM28hYoFGAXcXrZayt4
         E6aA==
X-Forwarded-Encrypted: i=1; AKwUvByTU7BXiNFmaVN39scWZd371RMLRsCD+kfT10VtxFq9X71nddVNTqhE/HbHMKit9fc7UrJ7uckpBlOr4C+LU4ug@vger.kernel.org
X-Gm-Message-State: APuU4Z+ATdbNZg2DyCwyvMP7faEpXKInZ+Sa/WV4/0oypCiB8y21yyAK
	HpI8brHJhDilrAtLqpqv7Xse8qazP+FrW1LwgZ+xvHC0YKtoWWvj0E+kCCLnGDOUNK1yMpzqGVf
	VysgfP2HPAaRXKKgJQTkHJyrWfDFjq5KhRCoYtDnVbwim9+ZBj9mk1/Oi67W1qYQHWjqQ1wikZj
	cKitJb
X-Gm-Gg: AYBFou2I8UAeOzrlu9H6cPh+7OiKktrkDg405jqayRTsE+BBDnd8erjBt1+WjILRZ2i
	63la29+QUh0FaaxHaEyc43y77Avw3PAwB80tO8QOR3+PJGc2BWckYNL9+zlxITd5PHFXV30SUHr
	4cH3xr14NHem3tLGRMPd3Xh97o4lG9NxeOlDZOwyP8e4Vmyqdytdx8lwLMjFqsat8QlkpOGla2m
	YrQ8ks/toFLlevXfo16+YQUxC6JZrkwGNh+vG11w2f3gYJtc6oeMd7XWzWta1fx3xFKPLVJrUYS
	fliH8kw6lf4cj1XuZwP+zpmX1bR+JlCQYRzj9h/ge6Dd/Xq+x3b88LnLbJ05Es5Cr7Xge/ijJCt
	AO+SOsXJ9ZyqitO7MlK9WjIlQ4WFTsgV3X8HQf5nJsMgVpQtPeYTIgtG8mP+OFuWTTAwmFImNKl
	J17BLpgNC4ajtNI8WPYo9BJgW4dqNuPQV7EHjisGvYo+JG1eyeRUTC8CXBoOv9WTVgi+7SJKgRR
	g==
X-Received: by 2002:a05:693c:2801:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-36f75f26494mr5202947eec.20.1794019180109;
        Fri, 06 Nov 2026 18:39:40 -0800 (PST)
X-Received: by 2002:a05:693c:2801:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-36f75f26494mr5202906eec.20.1794019179239;
        Fri, 06 Nov 2026 18:39:39 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm11069040eec.29.2026.11.06.18.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:39:38 -0800 (PST)
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
Subject: [PATCH v8 1/8] riscv: Introduce support for hardware break/watchpoints
Date: Sat,  7 Nov 2026 08:09:10 +0530
Message-ID: <20261107023917.40606-2-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwOSBTYWx0ZWRfX3reYvhRcC1ey
 YTiH7uSW68lV2oxzJm3qbQrnE+F/rQHEmr0DVJk9aZSId1im7aBssiBvwAeXedf8vT10H4UBjl9
 cvLDShXx9bYIOxJ7g9ELU7FHekPAylbeMT2cJdio0f9XfxM+DaRpSwZjjTJYcufnLIjTgro2WaO
 SpPnqTQMGOQy+dE5n4/nGamQTfi0UScxEdAqOZaAyOG4MMKtK4fa3lmWxu4Y8Co0jiMKpy8xke3
 BYl0xY5pEtdSZJOmXnDjovIwgAaCtZLKa5fWpAc3N+wlF6x+itUSJTvUMMNywxvBvv0N6XDglTi
 RXILcxYmniQi0cM4pIzriDMA9naTYmAGJ+24qKKRvxKLmdROb8UxsAy92xY41JR2ilBV04F71M2
 gcMv511HA+29XVvV9+1KXBgG01lIXxu1HOfgdlNWO0ZdxnkQ8FsuEPFA2bxu7qPI5Nvmd7j2H3z
 zjF8RQ7uFsnz+CzQ7WA==
X-Proofpoint-ORIG-GUID: FRLhsSrnTypz6AzECE6BS8opuPVSBvlO
X-Proofpoint-GUID: FRLhsSrnTypz6AzECE6BS8opuPVSBvlO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwOSBTYWx0ZWRfX8JmUKNGVT3OC
 JAFw6sQx1YUejr/+UUN299tckYUxlF98b/snfTtNykUk7Zn58dLRXgpt2rWzg7Z/oAuSjVTibnL
 Nwj6KkVer5cssJlOqJ7GxhRjUxG1yA4=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6aee8f6d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=lv0vYI88AAAA:8 a=lIvaXsvmuLkBGoZy2n8A:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=1CNFftbPRP8L7MoqJWF3:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070009

RISC-V hardware breakpoints and watchpoints are implemented through the
perf hardware breakpoint framework. Use the SBI debug trigger extension
to install, uninstall, update, enable, and disable Sdtrig triggers.

When handling a debug exception, use the trigger hit bits reported by
hardware to decide whether a trigger fired. Clear those bits after they
are read so later exceptions see fresh state.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 MAINTAINERS                            |   9 +
 arch/riscv/Kconfig                     |   2 +
 arch/riscv/include/asm/hw_breakpoint.h |  49 ++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 897 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c              |   6 +
 7 files changed, 966 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..73b69e8dcba1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24163,6 +24163,15 @@ F:	Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
 F:	Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
 F:	drivers/pmdomain/riscv/
 
+RISC-V DEBUGGING
+M:	Himanshu Chauhan <himanshu@thechauhan.dev>
+L:	linux-riscv@lists.infradead.org
+F:	arch/riscv/include/asm/hw_breakpoint.h
+F:	arch/riscv/include/asm/perf_event.h
+F:	arch/riscv/kernel/hw_breakpoint.c
+F:	arch/riscv/kernel/perf_*
+F:	drivers/perf/
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@kernel.org>
 R:	Troy Mitchell <troy.mitchell@linux.spacemit.com>
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e7891a2a89da..2cfd9f369534 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -173,6 +173,8 @@ config RISCV
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && RISCV_SBI
+	select HAVE_MIXED_BREAKPOINTS_REGS if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2 if !EFI_ZBOOT
 	select HAVE_KERNEL_GZIP if !EFI_ZBOOT
diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
new file mode 100644
index 000000000000..dcce20ba3faa
--- /dev/null
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 Qualcomm Technologies, Inc.
+ */
+
+#ifndef __RISCV_HW_BREAKPOINT_H
+#define __RISCV_HW_BREAKPOINT_H
+
+struct task_struct;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+#include <uapi/linux/hw_breakpoint.h>
+
+struct arch_hw_breakpoint {
+	unsigned long address;
+	unsigned long len;
+	unsigned int type;
+
+	/* Trigger configuration data */
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct perf_event_attr;
+struct notifier_block;
+struct perf_event;
+struct pt_regs;
+
+int hw_breakpoint_slots(int type);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data);
+
+void arch_enable_hw_breakpoint(struct perf_event *bp);
+void arch_update_hw_breakpoint(struct perf_event *bp);
+void arch_disable_hw_breakpoint(struct perf_event *bp);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+
+#else
+
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#endif /* __RISCV_HW_BREAKPOINT_H */
diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
index 85ac00411f6e..53e989781aa1 100644
--- a/arch/riscv/include/asm/kdebug.h
+++ b/arch/riscv/include/asm/kdebug.h
@@ -6,7 +6,8 @@
 enum die_val {
 	DIE_UNUSED,
 	DIE_TRAP,
-	DIE_OOPS
+	DIE_OOPS,
+	DIE_DEBUG
 };
 
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f54c336bf547..ede0cddddd31 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
new file mode 100644
index 000000000000..421ecd8549d9
--- /dev/null
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Qualcomm Technologies, Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/kdebug.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+
+#include <asm/sbi.h>
+
+#define RISCV_HW_BP_NUM_MAX	32
+
+#if __riscv_xlen == 64
+#define cpu_to_le		cpu_to_le64
+#define le_to_cpu		le64_to_cpu
+#elif __riscv_xlen == 32
+#define cpu_to_le		cpu_to_le32
+#define le_to_cpu		le32_to_cpu
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+enum {
+	RISCV_DBTR_TRIG_NONE = 0,
+	RISCV_DBTR_TRIG_LEGACY,
+	RISCV_DBTR_TRIG_MCONTROL,
+	RISCV_DBTR_TRIG_ICOUNT,
+	RISCV_DBTR_TRIG_ITRIGGER,
+	RISCV_DBTR_TRIG_ETRIGGER,
+	RISCV_DBTR_TRIG_MCONTROL6,
+};
+
+#define RISCV_DBTR_TDATA1_TYPE_MASK	GENMASK(__riscv_xlen - 1, __riscv_xlen - 4)
+
+#define RISCV_DBTR_MC_LOAD		BIT(0)
+#define RISCV_DBTR_MC_STORE		BIT(1)
+#define RISCV_DBTR_MC_EXEC		BIT(2)
+#define RISCV_DBTR_MC_U		BIT(3)
+#define RISCV_DBTR_MC_S		BIT(4)
+#define RISCV_DBTR_MC_HIT		BIT(20)
+#define RISCV_DBTR_MC_SIZELO_MASK	GENMASK(17, 16)
+#if __riscv_xlen >= 64
+#define RISCV_DBTR_MC_SIZEHI_MASK	GENMASK(22, 21)
+#endif
+
+#define RISCV_DBTR_MC6_LOAD		BIT(0)
+#define RISCV_DBTR_MC6_STORE		BIT(1)
+#define RISCV_DBTR_MC6_EXEC		BIT(2)
+#define RISCV_DBTR_MC6_U		BIT(3)
+#define RISCV_DBTR_MC6_S		BIT(4)
+#define RISCV_DBTR_MC6_SIZE_MASK	GENMASK(19, 16)
+#define RISCV_DBTR_MC6_HIT		BIT(22)
+#define RISCV_DBTR_MC6_HIT1		BIT(25)
+#define RISCV_DBTR_MC6_HIT_MASK	(RISCV_DBTR_MC6_HIT | RISCV_DBTR_MC6_HIT1)
+
+#define RISCV_DBTR_MC6_HIT_FALSE	0
+#define RISCV_DBTR_MC6_HIT_BEFORE	1
+#define RISCV_DBTR_MC6_HIT_AFTER	2
+#define RISCV_DBTR_MC6_HIT_IMM_AFTER	3
+
+/* Registered per-cpu bp/wp */
+static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RISCV_HW_BP_NUM_MAX]);
+static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
+
+/* Per-cpu shared memory between S and M mode */
+static union sbi_dbtr_shmem_entry __percpu *sbi_dbtr_shmem;
+
+/* number of debug triggers on this cpu . */
+static int dbtr_total_num __ro_after_init;
+static int dbtr_type __ro_after_init;
+static unsigned long dbtr_init __ro_after_init;
+
+#define MEM_HI(_m)		\
+	(IS_ENABLED(CONFIG_32BIT) ? upper_32_bits((u64)(_m)) : 0UL)
+#define MEM_LO(_m)		((unsigned long)(_m))
+
+static unsigned long dbtr_tdata1_type(unsigned int type)
+{
+	return FIELD_PREP(RISCV_DBTR_TDATA1_TYPE_MASK, type);
+}
+
+static unsigned long dbtr_mcontrol_size(unsigned int lo, unsigned int hi)
+{
+	unsigned long tdata1 = FIELD_PREP(RISCV_DBTR_MC_SIZELO_MASK, lo);
+
+#if __riscv_xlen >= 64
+	tdata1 |= FIELD_PREP(RISCV_DBTR_MC_SIZEHI_MASK, hi);
+#else
+	(void)hi;
+#endif
+	return tdata1;
+}
+
+static unsigned long dbtr_mcontrol6_size(unsigned int size)
+{
+	return FIELD_PREP(RISCV_DBTR_MC6_SIZE_MASK, size);
+}
+
+static unsigned int dbtr_mcontrol6_hit(unsigned long tdata1)
+{
+	return ((tdata1 & RISCV_DBTR_MC6_HIT1) ? 2 : 0) |
+	       ((tdata1 & RISCV_DBTR_MC6_HIT) ? 1 : 0);
+}
+
+static bool ranges_overlap(unsigned long start1, unsigned long len1,
+			   unsigned long start2, unsigned long len2)
+{
+	unsigned long end1 = start1 + len1 - 1;
+	unsigned long end2 = start2 + len2 - 1;
+
+	if (end1 < start1)
+		end1 = ~0UL;
+	if (end2 < start2)
+		end2 = ~0UL;
+
+	return start1 <= end2 && start2 <= end1;
+}
+
+static int arch_smp_setup_sbi_shmem(unsigned int cpu)
+{
+	union sbi_dbtr_shmem_entry *dbtr_shmem;
+	phys_addr_t shmem_pa;
+	struct sbiret ret;
+
+	dbtr_shmem = per_cpu_ptr(sbi_dbtr_shmem, cpu);
+
+	shmem_pa = per_cpu_ptr_to_phys(dbtr_shmem);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			MEM_LO(shmem_pa), MEM_HI(shmem_pa), 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: failed to setup shared memory. error: %ld\n",
+			__func__, ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	pr_info("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
+
+	return 0;
+}
+
+static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
+{
+	struct sbiret ret;
+
+	/* Disable shared memory */
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			SBI_SHMEM_DISABLE, SBI_SHMEM_DISABLE, 0, 0, 0, 0);
+
+	if (ret.error)
+		pr_warn("%s: failed to disable shared memory. error: %ld\n",
+			__func__, ret.error);
+	else
+		pr_info("CPU %d: HW Breakpoint shared memory disabled.\n", cpu);
+
+	return 0;
+}
+
+static void init_sbi_dbtr(void)
+{
+	unsigned long tdata1;
+	struct sbiret ret;
+
+	/*
+	 * Called by hw_breakpoint_slots() and arch_hw_breakpoint_init().
+	 * Only the first caller should run SBI discovery; later callers may
+	 * arrive after __ro_after_init data is read-only, so avoid a locked
+	 * write if the bit is already set.
+	 */
+	if (test_bit(0, &dbtr_init) || test_and_set_bit(0, &dbtr_init))
+		return;
+
+	if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
+		pr_warn("SBI_EXT_DBTR is not supported\n");
+		dbtr_total_num = 0;
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to detect triggers\n");
+		dbtr_total_num = 0;
+		return;
+	}
+
+	tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL6);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to detect mcontrol6 triggers\n");
+	} else if (!ret.value) {
+		pr_warn("Type 6 triggers not available\n");
+	} else {
+		dbtr_total_num = min_t(unsigned long, ret.value,
+				       RISCV_HW_BP_NUM_MAX);
+		dbtr_type = RISCV_DBTR_TRIG_MCONTROL6;
+		pr_warn("Mcontrol6 trigger available.\n");
+		return;
+	}
+
+	/* fallback to type 2 triggers if type 6 is not available */
+
+	tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to detect mcontrol triggers\n");
+	} else if (!ret.value) {
+		pr_warn("Type 2 triggers not available\n");
+	} else {
+		dbtr_total_num = min_t(unsigned long, ret.value,
+				       RISCV_HW_BP_NUM_MAX);
+		dbtr_type = RISCV_DBTR_TRIG_MCONTROL;
+	}
+}
+
+int hw_breakpoint_slots(int type)
+{
+	/*
+	 * We can be called early, so don't rely on
+	 * static variables being initialised.
+	 */
+
+	init_sbi_dbtr();
+
+	return dbtr_total_num;
+}
+
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned long va, len, end;
+
+	va = hw->address;
+	/* Execute breakpoints encode "match any instruction size" as len 0. */
+	len = hw->len ?: 1;
+	end = va + len - 1;
+
+	if (end < va)
+		end = ~0UL;
+
+	return (va >= TASK_SIZE) || (end >= TASK_SIZE);
+}
+
+static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw)
+{
+	unsigned long tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL);
+
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		tdata1 |= RISCV_DBTR_MC_EXEC;
+		break;
+	case HW_BREAKPOINT_R:
+		tdata1 |= RISCV_DBTR_MC_LOAD;
+		break;
+	case HW_BREAKPOINT_W:
+		tdata1 |= RISCV_DBTR_MC_STORE;
+		break;
+	case HW_BREAKPOINT_RW:
+		tdata1 |= RISCV_DBTR_MC_LOAD | RISCV_DBTR_MC_STORE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (attr->bp_type == HW_BREAKPOINT_X) {
+		/*
+		 * Userspace debuggers can request execute breakpoints with
+		 * bp_len == 2 for compressed/non-aligned instruction
+		 * addresses. Program execute triggers with "match any size"
+		 * to avoid missing valid instruction fetches.
+		 */
+		hw->len = 0;
+	} else {
+		switch (attr->bp_len) {
+		case HW_BREAKPOINT_LEN_1:
+			hw->len = 1;
+			tdata1 |= dbtr_mcontrol_size(1, 0);
+			break;
+		case HW_BREAKPOINT_LEN_2:
+			hw->len = 2;
+			tdata1 |= dbtr_mcontrol_size(2, 0);
+			break;
+		case HW_BREAKPOINT_LEN_4:
+			hw->len = 4;
+			tdata1 |= dbtr_mcontrol_size(3, 0);
+			break;
+#if __riscv_xlen >= 64
+		case HW_BREAKPOINT_LEN_8:
+			hw->len = 8;
+			tdata1 |= dbtr_mcontrol_size(1, 1);
+			break;
+#endif
+		/* Set to match any size */
+		default:
+			hw->len = 0;
+			break;
+		}
+	}
+
+	/*
+	 * Match only the trigger's actual privilege-mode target. Setting
+	 * both bits makes the kernel's own S-mode uaccess (e.g. SUM-enabled
+	 * loads in strncpy_from_user()) spuriously fire a user-space watch.
+	 */
+	if (arch_check_bp_in_kernelspace(hw))
+		tdata1 |= RISCV_DBTR_MC_S;
+	else
+		tdata1 |= RISCV_DBTR_MC_U;
+
+	hw->tdata1 = tdata1;
+	return 0;
+}
+
+static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
+				     struct arch_hw_breakpoint *hw)
+{
+	unsigned long tdata1 = dbtr_tdata1_type(RISCV_DBTR_TRIG_MCONTROL6);
+
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		tdata1 |= RISCV_DBTR_MC6_EXEC;
+		break;
+	case HW_BREAKPOINT_R:
+		tdata1 |= RISCV_DBTR_MC6_LOAD;
+		break;
+	case HW_BREAKPOINT_W:
+		tdata1 |= RISCV_DBTR_MC6_STORE;
+		break;
+	case HW_BREAKPOINT_RW:
+		tdata1 |= RISCV_DBTR_MC6_STORE | RISCV_DBTR_MC6_LOAD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (attr->bp_type == HW_BREAKPOINT_X) {
+		/* See rv_init_mcontrol_trigger() for rationale. */
+		hw->len = 0;
+	} else {
+		switch (attr->bp_len) {
+		case HW_BREAKPOINT_LEN_1:
+			hw->len = 1;
+			tdata1 |= dbtr_mcontrol6_size(1);
+			break;
+		case HW_BREAKPOINT_LEN_2:
+			hw->len = 2;
+			tdata1 |= dbtr_mcontrol6_size(2);
+			break;
+		case HW_BREAKPOINT_LEN_4:
+			hw->len = 4;
+			tdata1 |= dbtr_mcontrol6_size(3);
+			break;
+#if __riscv_xlen >= 64
+		case HW_BREAKPOINT_LEN_8:
+			hw->len = 8;
+			tdata1 |= dbtr_mcontrol6_size(5);
+			break;
+#endif
+		/* Set to match any size */
+		default:
+			hw->len = 0;
+		}
+	}
+
+	/* See rv_init_mcontrol_trigger() for rationale. */
+	if (arch_check_bp_in_kernelspace(hw))
+		tdata1 |= RISCV_DBTR_MC6_S;
+	else
+		tdata1 |= RISCV_DBTR_MC6_U;
+
+	hw->tdata1 = tdata1;
+	return 0;
+}
+
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
+{
+	int ret;
+
+	/* Breakpoint address */
+	hw->address = attr->bp_addr;
+	hw->tdata1 = 0;
+	hw->tdata2 = attr->bp_addr;
+	hw->tdata3 = 0x0;
+
+	switch (dbtr_type) {
+	case RISCV_DBTR_TRIG_MCONTROL:
+		ret = rv_init_mcontrol_trigger(attr, hw);
+		break;
+	case RISCV_DBTR_TRIG_MCONTROL6:
+		ret = rv_init_mcontrol6_trigger(attr, hw);
+		break;
+	default:
+		pr_warn("Unsupported trigger type\n");
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static void dbtr_encode_update(union sbi_dbtr_shmem_entry *shmem,
+			       unsigned long idx, unsigned long tdata1,
+			       unsigned long tdata2, unsigned long tdata3)
+{
+	struct sbi_dbtr_id_msg *id = &shmem->id;
+	struct sbi_dbtr_data_msg *data = &shmem->data;
+
+	/*
+	 * SBI_EXT_DBTR_TRIG_UPDATE takes the number of entries in a0.  The
+	 * trigger index for each entry lives in the first shared-memory word;
+	 * that word is named tstate only when the same union is used for
+	 * TRIG_READ replies.
+	 */
+	id->idx = cpu_to_le(idx);
+	data->tdata1 = cpu_to_le(tdata1);
+	data->tdata2 = cpu_to_le(tdata2);
+	data->tdata3 = cpu_to_le(tdata3);
+}
+
+static struct sbiret dbtr_update_trigger_locked(unsigned long idx,
+						unsigned long tdata1,
+						unsigned long tdata2,
+						unsigned long tdata3)
+{
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+
+	dbtr_encode_update(shmem, idx, tdata1, tdata2, tdata3);
+
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE,
+			 1, 0, 0, 0, 0, 0);
+}
+
+static int dbtr_update_event_tdata(struct perf_event *event,
+				   unsigned long tdata1,
+				   unsigned long tdata2,
+				   unsigned long tdata3, bool wait)
+{
+	struct perf_event **slot;
+	unsigned long flags;
+	struct sbiret ret;
+	int i;
+
+	if (wait)
+		raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock), flags);
+	else if (!raw_spin_trylock_irqsave(this_cpu_ptr(&ecall_lock), flags))
+		return -EBUSY;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+		return -ENOENT;
+	}
+
+	ret = dbtr_update_trigger_locked(i, tdata1, tdata2, tdata3);
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+static struct sbiret dbtr_uninstall_trigger_locked(unsigned long idx)
+{
+	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
+			 idx, 1, 0, 0, 0, 0);
+}
+
+static bool mc_read_and_clear_hit(int idx)
+{
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	unsigned long flags, tdata1, tdata2, tdata3;
+	struct sbiret ret;
+	bool hit;
+
+	/*
+	 * This runs from DIE_DEBUG.  If the exception interrupted another DBTR
+	 * SBI call on this CPU, blocking on the same raw spinlock would deadlock;
+	 * the handler can still fall back to address-based matching.
+	 */
+	if (!raw_spin_trylock_irqsave(this_cpu_ptr(&ecall_lock), flags))
+		return false;
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
+			idx, 1, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to read trigger %d. error: %ld\n",
+			idx, ret.error);
+		hit = false;
+		goto out;
+	}
+
+	tdata1 = le_to_cpu(shmem->data.tdata1);
+	hit = !!(tdata1 & RISCV_DBTR_MC_HIT);
+	if (!hit)
+		goto out;
+
+	tdata2 = le_to_cpu(shmem->data.tdata2);
+	tdata3 = le_to_cpu(shmem->data.tdata3);
+	tdata1 &= ~RISCV_DBTR_MC_HIT;
+
+	ret = dbtr_update_trigger_locked(idx, tdata1, tdata2, tdata3);
+	if (ret.error)
+		pr_warn("Failed to clear hit bit on trigger %d. error: %ld\n",
+			idx, ret.error);
+
+out:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+	return hit;
+}
+
+/*
+ * Read mcontrol6's hit1:hit0 field for trigger @idx. If either bit is set,
+ * clear it in hardware (the Debug spec requires the trigger user to do
+ * this; hardware only ever sets it). Returns the RISCV_DBTR_MC6_HIT_*
+ * value read (RISCV_DBTR_MC6_HIT_FALSE if unimplemented or unfired).
+ */
+static unsigned int mc6_read_and_clear_hit(int idx)
+{
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	unsigned long flags, tdata1, tdata2, tdata3;
+	struct sbiret ret;
+	unsigned int hit;
+
+	/* See mc_read_and_clear_hit() for the trylock rationale. */
+	if (!raw_spin_trylock_irqsave(this_cpu_ptr(&ecall_lock), flags))
+		return RISCV_DBTR_MC6_HIT_FALSE;
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ, idx, 1, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("Failed to read trigger %d. error: %ld\n", idx, ret.error);
+		hit = RISCV_DBTR_MC6_HIT_FALSE;
+		goto out;
+	}
+
+	tdata1 = le_to_cpu(shmem->data.tdata1);
+	hit = dbtr_mcontrol6_hit(tdata1);
+	if (hit == RISCV_DBTR_MC6_HIT_FALSE)
+		goto out;
+
+	tdata2 = le_to_cpu(shmem->data.tdata2);
+	tdata3 = le_to_cpu(shmem->data.tdata3);
+	tdata1 &= ~RISCV_DBTR_MC6_HIT_MASK;
+
+	ret = dbtr_update_trigger_locked(idx, tdata1, tdata2, tdata3);
+	if (ret.error)
+		pr_warn("Failed to clear hit bits on trigger %d. error: %ld\n",
+			idx, ret.error);
+
+out:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+	return hit;
+}
+
+/*
+ * HW Breakpoint/watchpoint handler
+ */
+static int hw_breakpoint_handler(struct die_args *args)
+{
+	int i, bp_ret = NOTIFY_DONE;
+	struct arch_hw_breakpoint *bp;
+	struct perf_event *event;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		event = this_cpu_read(pcpu_hw_bp_events[i]);
+		if (!event)
+			continue;
+
+		bp = counter_arch_bp(event);
+
+		switch (event->attr.bp_type) {
+		/* Breakpoint */
+		case HW_BREAKPOINT_X:
+			{
+				bool hit = bp->address == args->regs->epc;
+
+				if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL)
+					hit |= mc_read_and_clear_hit(i);
+				else if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL6)
+					hit |= mc6_read_and_clear_hit(i) !=
+					       RISCV_DBTR_MC6_HIT_FALSE;
+
+				if (hit) {
+					perf_bp_event(event, args->regs);
+					bp_ret = NOTIFY_STOP;
+					goto exit;
+				}
+			}
+			break;
+
+		/* Watchpoint */
+		case HW_BREAKPOINT_W:
+		case HW_BREAKPOINT_R:
+		case HW_BREAKPOINT_RW:
+			{
+				unsigned long stval = args->regs->badaddr;
+				unsigned long bp_start = bp->address;
+				unsigned long bp_len = bp->len ?: 1;
+				bool hit = false;
+
+				/*
+				 * Prefer tdata1.hit from SBI trigger readout whenever
+				 * possible. Fall back to address-based matching if HIT
+				 * isn't observed/supported.
+				 */
+				if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL)
+					hit = mc_read_and_clear_hit(i);
+				else if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL6)
+					hit = mc6_read_and_clear_hit(i) !=
+					      RISCV_DBTR_MC6_HIT_FALSE;
+
+				/*
+				 * Sdtrig may report STVAL as the lowest accessed
+				 * address while the watchpoint can match a higher byte
+				 * in the same access.  Check for full range overlap
+				 * rather than comparing only the two start addresses.
+				 */
+				hit |= ranges_overlap(bp_start, bp_len, stval,
+						      sizeof(long));
+				if (hit) {
+					perf_bp_event(event, args->regs);
+					bp_ret = NOTIFY_STOP;
+					goto exit;
+				}
+			}
+			break;
+
+		default:
+			pr_warn("Unknown type: %u\n", event->attr.bp_type);
+			goto exit;
+		}
+	}
+
+exit:
+	return bp_ret;
+}
+
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data)
+{
+	if (val != DIE_DEBUG)
+		return NOTIFY_DONE;
+
+	return hw_breakpoint_handler(data);
+}
+
+/* atomic: counter->ctx->lock is held */
+int arch_install_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	struct sbi_dbtr_data_msg *xmit;
+	struct sbi_dbtr_id_msg *recv;
+	struct perf_event **slot;
+	unsigned long idx;
+	unsigned long flags;
+	struct sbiret ret;
+	int err = 0;
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock), flags);
+
+	xmit = &shmem->data;
+	recv = &shmem->id;
+	/* Avoid sending stale union contents from a previous id reply. */
+	xmit->tstate = cpu_to_le(0UL);
+	xmit->tdata1 = cpu_to_le(bp->tdata1);
+	xmit->tdata2 = cpu_to_le(bp->tdata2);
+	xmit->tdata3 = cpu_to_le(bp->tdata3);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
+			1, 0, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("Failed to install trigger\n");
+		err = sbi_err_map_linux_errno(ret.error);
+		goto done;
+	}
+
+	idx = le_to_cpu(recv->idx);
+	if (idx >= dbtr_total_num) {
+		pr_warn("Invalid trigger index %lu\n", idx);
+		ret = dbtr_uninstall_trigger_locked(idx);
+		if (ret.error)
+			pr_warn("Failed to unwind trigger %lu. error: %ld\n",
+				idx, ret.error);
+		err = -EINVAL;
+		goto done;
+	}
+
+	slot = this_cpu_ptr(&pcpu_hw_bp_events[idx]);
+	if (*slot) {
+		pr_warn("Slot %lu is in use\n", idx);
+		ret = dbtr_uninstall_trigger_locked(idx);
+		if (ret.error)
+			pr_warn("Failed to unwind trigger %lu. error: %ld\n",
+				idx, ret.error);
+		err = -EBUSY;
+		goto done;
+	}
+
+	/* Save the event - to be looked up in handler */
+	*slot = event;
+
+done:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+	return err;
+}
+
+/* atomic: counter->ctx->lock is held */
+void arch_uninstall_hw_breakpoint(struct perf_event *event)
+{
+	struct perf_event **slot = NULL;
+	unsigned long flags;
+	struct sbiret ret;
+	int i;
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock), flags);
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **candidate;
+
+		candidate = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+		if (*candidate == event) {
+			slot = candidate;
+			break;
+		}
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("Breakpoint not installed.\n");
+		goto out;
+	}
+
+	/*
+	 * Keep the software slot populated until the hardware trigger is gone;
+	 * otherwise a last debug exception would look unhandled.
+	 */
+	ret = dbtr_uninstall_trigger_locked(i);
+
+	if (ret.error) {
+		pr_warn("Failed to uninstall trigger %d.\n", i);
+		goto out;
+	}
+
+	*slot = NULL;
+
+ out:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+	struct perf_event **slot;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock), flags);
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("Breakpoint not installed.\n");
+		goto out;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_ENABLE,
+			i, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("Failed to install trigger %d\n", i);
+		goto out;
+	}
+
+ out:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock), flags);
+}
+EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
+
+void arch_update_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	int ret;
+
+	ret = dbtr_update_event_tdata(event, bp->tdata1, bp->tdata2, bp->tdata3,
+				      true);
+	if (ret)
+		pr_warn("Failed to update trigger. error: %d\n", ret);
+}
+EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
+
+void arch_disable_hw_breakpoint(struct perf_event *event)
+{
+	struct perf_event **slot;
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("Breakpoint not installed.\n");
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_DISABLE,
+			i, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("Failed to uninstall trigger %d.\n", i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
+
+void hw_breakpoint_pmu_read(struct perf_event *bp) { }
+
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
+
+static int __init arch_hw_breakpoint_init(void)
+{
+	unsigned int cpu;
+	int rc = 0;
+
+	for_each_possible_cpu(cpu)
+		raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
+
+	init_sbi_dbtr();
+
+	if (dbtr_total_num) {
+		pr_info("Total number of type %d triggers: %u\n",
+			dbtr_type, dbtr_total_num);
+	} else {
+		pr_info("No hardware triggers available\n");
+		goto out;
+	}
+
+	/* Allocate per-cpu shared memory */
+	sbi_dbtr_shmem = __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_total_num,
+					PAGE_SIZE);
+
+	if (!sbi_dbtr_shmem) {
+		pr_warn("Failed to allocate shared memory.\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Hotplug handler to register/unregister shared memory with SBI */
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			       "riscv/hw_breakpoint:prepare",
+			       arch_smp_setup_sbi_shmem,
+			       arch_smp_teardown_sbi_shmem);
+
+	if (rc < 0) {
+		pr_warn("Failed to setup CPU hotplug state\n");
+		free_percpu(sbi_dbtr_shmem);
+		sbi_dbtr_shmem = NULL;
+		dbtr_total_num = 0;
+		dbtr_type = RISCV_DBTR_TRIG_NONE;
+		return rc;
+	}
+	rc = 0;
+ out:
+	return rc;
+}
+arch_initcall(arch_hw_breakpoint_init);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f8292adda099..1b9ccc0b6b8d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -287,6 +287,12 @@ void handle_break(struct pt_regs *regs)
 	if (probe_breakpoint_handler(regs))
 		return;
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
+	    == NOTIFY_STOP)
+		return;
+#endif
+
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-- 
2.43.0

