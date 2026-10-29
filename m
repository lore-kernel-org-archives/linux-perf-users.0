Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274611;
	b=LiNHzQSmbys9/mjoweDpLmG1NJKAJJAaGyBhb0ixY69GVn1tjaoTz2gJg17MRERo/uHq
	 04tC6pmiEKAGvwFcrwtEPI/BrHt+AALAU3jO1VnpNeI9FeneToFhin3hdK5UQ4kkJsK5K
	 +PkTXntodYOOVI3OAHumEzLAOucjPsL4Sxawghg2iW68QEhXPh9MC6hjk47nHZTs3OiCX
	 UryGDOZkopM79k5IrY5449vgfiGEr18TZfnzxY2adcoaTa3bQlbIYMijlzjekkeiKM85H
	 bHet7hTx2l0HEhDHUBCP9qnqb5xOrVXAgdsiRCSEJ0hBY/7IYHcI1FRSyZTVN1EdB7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8rCHi1GBk0hKG09zgHxal2DvzYlGptJwEeRT1dMlA18=;
	b=oVfJLe6ZB3CMQELEP4Lg5qp0KnkkRpy46/qp0HA2yiPipIv6xNjDCuOFIGrPcVEv788i
	 eJT3d2Uykud2b6RsemGFNHEZj5G/7XMDEyx1pLwinaAdqOwAkJrF5SzOhr0VBXB8wtEB5
	 4ICbhVTYbPaGv7HwdrYXDdvKclPpwLws5pWap82ayx4LTD7VTZooEs99x0dlbLi50mo+G
	 G8FZqdAci/bq1X1DXrAWV952OA52mizK5pSj0V1U897mHTOZekXf7nlSSHtDGmyXPFuNb
	 ow0ZCKU8LSwrnPPOl6AUmGOUKhFJIW+q6LtkGw8Fc3KpVWB5g9TjUdal1GeAme0mBsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=H0kAUE0F;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC4606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09CC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=H0kAUE0F
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3ae08d3dd4fso1091157a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793274610; x=1793879410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rCHi1GBk0hKG09zgHxal2DvzYlGptJwEeRT1dMlA18=;
        b=H0kAUE0FzOIbxr+gO4Sqo6zQU7YgLDHirZqAhcfE9R0a8Y4ZOYve843gw846IzYRq7
         Ckjw04hWuuOrlodR4UHxRvpNbStj/d6pexnqn586VfV9Ur+luwZqrRT5gxlfyZQFU2/z
         I7iyaoA1xNjEfprUiPB0JLor/ZjPLZmxb4m2L0FRMmAx6yxES1MqJXGo+zJMuI7y78xb
         tl35TVaC7nqG1RtdWuL/bncgW9qBPNLTlbUJC/1nUjEFZEWuidqcxTBnvPM6veBpQHvn
         4ATQHh0QURaaQK4760fjEYa//6p0itOGPV4EapK1k+Jwa06BtdiCyki4FNMQF7JNXoYg
         tNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274610; x=1793879410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rCHi1GBk0hKG09zgHxal2DvzYlGptJwEeRT1dMlA18=;
        b=qS9o3xMsJMH8SybiVqnSa4vw4n5Wq/Wl1nBT5C+KsifrwxPghx8DCECUplD1lNUAbW
         khhEhZNTqzgQvB7UomsuHJbK1/GAo+i5TWHgQ6LESerBS4TnO8wYPCGLAZALCJcP5ZyD
         llnZrY/AtTgLyJRdmZIqGiSdNCLUSdNm4UMuzAuoCO6XWtxm7e2z1b81OziF/zctfCHB
         Hu865pi/DG1oFt24bffQclrf6f+5q1WkdlydariIeJnZ2vGaCu2/CcwNYs+gtRmxKgTr
         PAcO3M3BvyDo7qmPAZ/hXTdjIwC7BURgGPd/xDwJ6GLgc3C2V5IiyZMijb/bsVz7hw22
         OFlA==
X-Forwarded-Encrypted: i=1; AKwUvBybsOUBQ8pWtgGB7fuKWMe+BwUN878PfspSGCCUBd6+52PaZaLF04hhiB6wrl3foPHsZeTA/6bA57gjKzPQU/La@vger.kernel.org
X-Gm-Message-State: AFq9FYJE183ycQw+65qs6YD4XK7UgtKFeiX5C5Gj5C4viulilM7yCOyB
	NyhmZCbo5zBV9zTnxn2UimJ2w7u+YtTDPwRma63ff3m+MjnCuolQGrrq5Hkdn4MmY7jU8OyCwx5
	zSkHwITnKdQ==
X-Gm-Gg: AYBFou0fhcTT/oOXGvF4A9BFfPY9lmF1qfV+r0mU9coJ4R2wonxBbU3IgK9LTaKLCQO
	BiADpcIAj3IfsSa4fuZABUYBG6DhgNRa6BH1e/O1tAuWYanAg4ml4KMQVUXvz1XEQXRq3Mu5pBW
	5ZfmicpiAUM87TULvz0C8mpU+2xfcLpLJe89bIRcGBjCFKeFZwhBCP1X/aQH7S7HkALL+ii4/gR
	zFyTSwX58p3E8SymFIRjepIwCI7K4bftsfoWxid8SYcILKy20KKKxS/ZPgyO8sqlnyDd4n7WIrJ
	7daf/wE7mxaFZb1k8lz+RB1pV3zA9q10nxFovC1VDJGJ2e/WWG6CG2b1ykkvM3vL8GEGSCQoi38
	gJyd8k8AHoNB7ifyHmSFVEVHl8/KjOk75pYw85gQmjYwPcY3Dgo5nFZBs8XZ6uFhw4aj/43zfa/
	kuiXCWLB+IpWYPmM2aJXFxFzuSFk3eUo/H4M0bDyz+a9IxInPtAAJyTndBA2lXjghCcWmEJKElg
	DWI5xQRdtvi2slZejboozE/dqTzxcFLeAbYMEez0r0sHb1QlUjG12mjIyBdcIENYlF7V46wEOR2
	Jh2dDzlREo6LhRg+9BzdWh61/nEy6qz+mDLV4W+t72K2dkdlL9qND9EfZxlgPy3JvQSQctXEJOd
	708oj66E=
X-Received: by 2002:a17:90b:3f8c:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3ae5835d8a6mr4169699a91.59.1793274610195;
        Thu, 29 Oct 2026 04:50:10 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm4151053a91.1.2026.10.29.04.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 04:50:09 -0700 (PDT)
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
Subject: [PATCH v12 09/11] MAINTAINERS: add RISC-V SSE maintainers and file coverage
Date: Thu, 29 Oct 2026 19:49:51 +0800
Message-ID: <20261029114953.27453-1-zhangzhanpeng.jasper@bytedance.com>
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
Content-Transfer-Encoding: 8bit

Add the RISC-V SSE maintainers and cover the architecture entry,
firmware driver, PMU documentation and selftests in a separate patch,
as requested by Himanshu Chauhan. Also add coverage for RISC-V firmware
drivers and the architecture selftests.

Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.com/

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 MAINTAINERS | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65e8a4b5c90..f275e9d4847 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23506,6 +23506,7 @@ C:	irc://irc.libera.chat/riscv
 P:	Documentation/arch/riscv/patch-acceptance.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 F:	arch/riscv/
+F:	tools/testing/selftests/riscv/
 N:	riscv
 K:	riscv
 
@@ -23518,6 +23519,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
+RISC-V FIRMWARE DRIVERS
+M:	Conor Dooley <conor@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
+F:	drivers/firmware/riscv/
+
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
@@ -23573,6 +23581,7 @@ M:	Atish Patra <atish.patra@linux.dev>
 R:	Anup Patel <anup@brainfault.org>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	Documentation/arch/riscv/pmu-sse.rst
 F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
@@ -23612,6 +23621,19 @@ F:	arch/riscv/boot/dts/spacemit/
 N:	spacemit
 K:	spacemit
 
+RISC-V SUPERVISOR SOFTWARE EVENTS
+M:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
+M:	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
+R:	Yunhui Cui <cuiyunhui@bytedance.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/include/asm/sse.h
+F:	arch/riscv/kernel/sbi_sse.c
+F:	arch/riscv/kernel/sbi_sse_entry.S
+F:	drivers/firmware/riscv/riscv_sbi_sse.c
+F:	include/linux/riscv_sbi_sse.h
+F:	tools/testing/selftests/riscv/sse/
+
 RISC-V TENSTORRENT SoC SUPPORT
 M:	Drew Fustini <dfustini@oss.tenstorrent.com>
 M:	Joel Stanley <jms@oss.tenstorrent.com>
-- 
2.50.1 (Apple Git-155)

