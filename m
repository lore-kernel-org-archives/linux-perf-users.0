Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090227;
	b=xsELK6lvsu1m1h9ezI81mU+Kaw5PXHpLLZd1bMltm6U/0TM8AdQTMAHBUNqZaSJsAb/8
	 oeIwKWIs/SC2yHUF5L/awQot3gpCLb96IY/NGVJm32b/WeARtAksDzIHDzRdjqm/Mgoil
	 8EvyCxNRR7VFwxHmYN9ErqOqEhEt0PXcJdQJ1VoIDKKgn+jlwfNpICiW1DPhdFUzkNguR
	 VSw9/t2uu5xpoVHCM9eKb50O1oswEb7Vt+dqjI4lD3iGiy/1EPJYLI2qrpi1Rio0nLuun
	 KfJIuvt0GA427JHJceq1vU+m9BUrA8F3YN5Syiti/wmNT2MATplRLupWaKiTpSX/Iaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AYLDQ+yf8AHdWNChzIaxivscwK5yCyOEEBVUQLHdUIE=;
	b=YvHFB6TmdkzUndXxt4Udh+bVwSpjQk0ISThrGKKGeyKwcGEiOClqhZ0Ea/nxqHLWN2DK
	 KhxdPLWYLtKyzWVvlaGJe2P/kCF/ZC+F4XvE2hhheoKIdW3RdxphsJ06iSoGzwW7jmHdC
	 5kXzNzxFQaviImz3TE8QWW26FKuFYxHjPRWnQt6rs/QaKnozWHuFRbySzd7TuBxQw3n0d
	 fbOKCCpxKnLmMMaliKdGG0X1mmvJuItJ1X2uBT67sdBhCZ9sYC1Cmi68aJX0zSBp6lbSf
	 c7hx73UJE9G64ndKVN41TVgojps7DxscQYAojYX13XvsrlO6visaf2sx8QVfEuhCuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VEqxmkSK;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79F606A331
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D79F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VEqxmkSK
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2994025eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1795090226; x=1795695026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYLDQ+yf8AHdWNChzIaxivscwK5yCyOEEBVUQLHdUIE=;
        b=VEqxmkSK4eWCu5l3irtVT/zW/JOHulXWxYT/po655TWF4gILDkLFKPv1BcgYrtWYq6
         NhYw6ZaLojKoN6hFsfSQjvERRHoVsJlZGzxtgS+UYf5mQzAC+zQ3wNRFk55Q2XT2sBao
         IqNO3k6dyAlfY4caVvumv02B3IzsNSuYAvym6mjWRJyFBTL6oamVCfgCauoMR2UPq/kx
         eEfy8I1Ucb1AYI2eI0Gg3yNN/LggBvxf2TO24r6Ca5d2oRXT4eecvoXQSJhkQJQyyTQY
         +8cvCYlNzWcCPfmy3eij9uBFElf10BM3WsNrVilBe33rC9y/MnA4Mop+61oSqy6EXuQ5
         17qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090226; x=1795695026;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYLDQ+yf8AHdWNChzIaxivscwK5yCyOEEBVUQLHdUIE=;
        b=DgNoZ0r6ECeYf+xR9PcyWLNuOsLw1MGHQgEXe1KAifhzaW7PAAjDbSxGpn+5tD35KC
         sozk6TKuQEaAqchFq6JB41HybIKKr6t36wcomRtR6yIfhHmoMwCJNY7pmZeeGqqo2Lio
         BIKYC8qj2AEAonVyBAGaJpabLoX708gBoV+HYI6k9f2SAAsOHDfC6hHrOrY1DuB+QDWT
         GCFRvN2qMGh8fiLjSq5liBcjgLEulhDnPgAkt+lHmp9wLVSdTDhJd6eNEJ2IxcUtZAx4
         1m3E9NtgDVTtB2sN2At4J4D+Se2tH3bVtnzRSPxWdLrQEpuOPBQZLsX4zv/SD355wXcv
         MfSg==
X-Forwarded-Encrypted: i=1; AL+hErHUgG7BZrMfB1pwJ9g4xf55HCmR8TjYLcCIcTmnb1D/JGqD83eVevhxGImcjyXpvuOMRu1NPHwHXWT5Gjz0QRfX@vger.kernel.org
X-Gm-Message-State: APuU4Z+DsRNsEnOe2uIGkxXf1h045nbn9oGoSu1D7REarZ7FNfTykiw9
	6QgM7Ga6NIMmFmGm4W1X+7dDXX2764cjF9pAKB6nhLfsjPehCBJSqMB+gONUjlSSg3A=
X-Gm-Gg: AZFdTZfdud2HWQDHO00/viMt5lpiX9xlwuyBNlHTgKYXEDS2HaOTm8NyuZ3kdo+nBXk
	yrIKDmUFVjU1Qq9nvRkJGXxY07J9wTWAjmuH7TReDKOc2zMEWF8dqdw4KiDIsRlUl51SFp320F8
	Qqj2FNQHinNrX5NbrnBJfIytbcvA0gigvdmZoKuk1S/EWp9RTgggSS79jtMD+Qwsx/SJ2ZvqlPx
	V1F4S4UTgHNDcLxRRu1EFai22jHsbPqeOCUgMxsqvvIEzKWCXGfeMtpdws9CE96QgpiQvRrWzAJ
	TC1JAGKnjuTmrE7VnwU713aXcXZ+jgE6s7df9Y8y1OCvIYdDpT5DsBdlnYbNsBPDtv9crXb4DDV
	xKmaY/AQNGToJWncYS1Ul/4BMZkCBgOSCivfO+JESU/V/5f3xaJEpqJaZibN+pg/VyK6FTjpf5l
	fM5e9apRzI7vQcMOatN+az+fjJsucIR6wMNYXM/burDzszUOLqfPUG58hNjvqDzu0F2wJFqNAC3
	PMjW1oi/tQsSqiPaSANN2sUp7MkWx09QgntnxWwcXZqpalX+IhlaEvhnGVqDKkhTZznxFH6hkyy
	RtP5LANGj5G9i2Xs69cd8ZtBCuSniCG5+dSgzS58ILInkvgk7JLNPfDrVL8kp+nX4RnwDxU8zff
	6q/UUxK2W1pSu0Opye5rcxJzCE0XS
X-Received: by 2002:a05:7300:3e86:b0:36e:3ebb:7ef3 with SMTP id 5a478bee46e88-38282bb5c41mr4863247eec.39.1795090226193;
        Thu, 19 Nov 2026 04:10:26 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([186.240.245.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm17604650eec.26.2026.11.19.04.10.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 04:10:25 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	himanshu.chauhan@oss.qualcomm.com,
	conor@kernel.org,
	anup.patel@oss.qualcomm.com
Cc: clement.leger@linux.dev,
	cuiyunhui@bytedance.com,
	atish.patra@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	will@kernel.org,
	tglx@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	shuah@kernel.org,
	yuanzhu@bytedance.com,
	yang.susheng@zte.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangzhanpeng.jasper@bytedance.com
Subject: [PATCH v13 09/11] MAINTAINERS: add RISC-V SSE maintainers and file coverage
Date: Thu, 19 Nov 2026 20:08:33 +0800
Message-ID: <20261119120824.13969-22-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
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

List Zhanpeng Zhang, Himanshu Chauhan and Clément Léger as co-maintainers
for RISC-V Supervisor Software Events, with Yunhui Cui as reviewer.
Cover the architecture entry, firmware driver, PMU documentation and
selftests in a separate patch, as requested by Himanshu. Also add
coverage for RISC-V firmware drivers and the architecture selftests.

Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.com/
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 MAINTAINERS | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..c2d283895ef4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24060,6 +24060,7 @@ C:	irc://irc.libera.chat/riscv
 P:	Documentation/arch/riscv/patch-acceptance.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 F:	arch/riscv/
+F:	tools/testing/selftests/riscv/
 N:	riscv
 K:	riscv
 
@@ -24072,6 +24073,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
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
 R:	Valentina Fernandez <valentina.fernandezalanis@microchip.com>
@@ -24128,6 +24136,7 @@ M:	Atish Patra <atish.patra@linux.dev>
 R:	Anup Patel <anup@brainfault.org>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	Documentation/arch/riscv/pmu-sse.rst
 F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
@@ -24176,6 +24185,20 @@ F:	arch/riscv/boot/dts/spacemit/
 N:	spacemit
 K:	spacemit
 
+RISC-V SUPERVISOR SOFTWARE EVENTS
+M:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
+M:	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
+M:	Clément Léger <clement.leger@linux.dev>
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
 M:	Drew Fustini <fustini@kernel.org>
 M:	Joel Stanley <jms@oss.tenstorrent.com>
-- 
2.50.1 (Apple Git-155)

