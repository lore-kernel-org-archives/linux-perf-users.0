Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F22264D6
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Aug 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422806; cv=none; b=dJMsglOBEy3S/A5IE+xJp9Ye1dod9kl06X8zKO7+nO6wjNdLzTjvst39j+JAq+dwAQ7Em+/aRc7dLmybokUOPpKLOJrVlFV34tG8jC17gcv3aD68QRDW8xI8rpL+Fqpq3XzE9ufsC+0JYHexrGgJsQ26wYhtHbB388xAlqwx+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422806; c=relaxed/simple;
	bh=3yynwp5xkX2tlPXadX9UGBNDDBTvMVZycNKpFPtm3RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayo3udFcjEFOdwktVyNAM234adWB8dTiauu8xkPGoR7P7lgF0VKc8YL1jQUSspJTj8zupIB1OfiDEVCxLjUdhMZ3I8hefybLoOInQAERM3SkZ93ATZrqsrjX0f5HPpFWSWyW6cZdnun6xSyK7YY50dfci1Qkie1tM2eimqq8Z4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Lz6no2bh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Lz6no2bh"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e344e0212eso30055485a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Aug 2025 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422803; x=1755027603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBx+S5U+eiCq8pUooPV2kB8TZrzcZaWUvNy/30cjCv8=;
        b=Lz6no2bhsa1jJH8jZxqPZzw3Dy+jEShkPkGbr2xpO7yZmfg/EmJmBTdU4AKMwF4SZ2
         Jp1aH6/3uCD+GK5l2mnVRV+X2Mf2Ttn+dFLEIz3zQwfrZZhN8D0P+YmQQNFIIHaq04TF
         NjPS4cYh7xexa/uVR3g/EruKQLPo4FYuFg+UYyQrJHmbZ8OU7+ecTynfKoXfNjZgFTFX
         ifV+JOYl830td9WF3lnPdhjZBYJ7o/4IgAOZmetAhaNmcaOIrnssYivNasrwoj6ZE6ve
         fd7+2DDwDjdtWsQSgAYwsvtWk5CzUO3tIkGbyE3f4lLsPKU1ts7PkJF3VcRypCtllwM4
         DYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422803; x=1755027603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBx+S5U+eiCq8pUooPV2kB8TZrzcZaWUvNy/30cjCv8=;
        b=FFSdMAtakkaC4ksIw51y6SqiYGIF4Z928oFBbqoGfBUOZejNpjInZamH073G+zwb0S
         IARQg1B063gNPEWCIGLoG847kdxjpUb/hDS5AhklY93vQJz+k1xFzVMyADpkbAl3WKVK
         LFAwzRh56mh2bjRwx156SpClTSuQJVr1zsFk+aIwev7jN9FZcnlf2D1PGiltuEJCl9OE
         B16mkmCrClagS7OIXj3cpm+nlpB+ki/HCYrmCSUuLsGgaGLeDaRTOq/D+SEhqu6XPtPW
         E9XSCrZynEAv0q2JFWlnTm5e+w7a4mA18T/ttQ/3r2QTyF7lEFaSXt8AGJ/H9gXhWJYQ
         B6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXEP0WGF42bTczzYpCkkZeRJXuCrF0vdH9JnPsXsO4RwFsCVZtaKS2d4tpeR7g40jMq0HMvK3srAfoI2JTmlWEf@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxFACL053adnkVxDmrhPPj8/WWpN7Zj9GyvEkWtQ6hRtiDmtq
	p1dX7GecO6ZG4JYI6EyAMHP6zSRSzji0PXlfDd98q16w5jZH9IOmaCWxbBv5lNC75sA=
X-Gm-Gg: ASbGncvgEPsfH3ImIjBRG3vtH2GjrjyHp82rvP+sOgOnjcqDeTUUA0bAiKpGubTIDSH
	i+YZrujQGIru6fTI8WB/Dm9gabrXw6UE4GCrRnEGDDNRubOwiSa/FRTizDpEmEnlGdt0J7/QSuU
	HfqH7UcPBwdZczXDGuubnOygmarO3OP/xyI5Ynn7k8g2+v6INOcJbYKUCRR71gCcJ1zPeeNfvw6
	eNTBVNIrnvbh0zWem/HHrfcjSnr4EE+lXexr1G+XXVuTh8dlAWFkmtJAlfizA6qpulOcJZVJDbe
	nCQ9xcMnFD7ATejnrgfanWuXeg9Z3jY0zyysgxil5l7rcTL15gMB9gPJws2JytTF++F2Ds50Lju
	YbZ+K6YUDzctACOUv2x1RfBSjJZJWn577RjY9RXfHOn7mDdQoe74jcZPW2bO49Hu9oXKoEE/k34
	r6dNraMQ==
X-Google-Smtp-Source: AGHT+IGX7OQglHEEPOq98awptA6J/9DSpmeeKDOZlvbBLWPX9HQBX2UPCjNuTmMSORoLz+090C2k2w==
X-Received: by 2002:a05:620a:424c:b0:7e6:99d7:3340 with SMTP id af79cd13be357-7e8156bcaacmr32337785a.12.1754422802272;
        Tue, 05 Aug 2025 12:40:02 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:02 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley  <conor.dooley@microchip.com>,
	Deepak Gupta  <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/8] riscv: Add SBI debug trigger extension and function ids
Date: Tue,  5 Aug 2025 12:39:49 -0700
Message-ID: <20250805193955.798277-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805193955.798277-1-jesse@rivosinc.com>
References: <20250805193955.798277-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

Debug trigger extension is a proposed SBI extension to support
native debugging in S-mode and VS-mode.

The proposal for the extension can be found at:
https://lists.riscv.org/g/sig-hypervisors/message/361

This patch adds the extension and the function IDs defined
by the extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
RFC -> V1:
 - No change
---
 arch/riscv/include/asm/sbi.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..be2ca8e8a49e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_DBTR = 0x44425452,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -402,6 +403,34 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+/* SBI debug triggers function IDs */
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_SETUP_SHMEM,
+	SBI_EXT_DBTR_TRIG_READ,
+	SBI_EXT_DBTR_TRIG_INSTALL,
+	SBI_EXT_DBTR_TRIG_UPDATE,
+	SBI_EXT_DBTR_TRIG_UNINSTALL,
+	SBI_EXT_DBTR_TRIG_ENABLE,
+	SBI_EXT_DBTR_TRIG_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+};
+
+union sbi_dbtr_shmem_entry {
+	struct sbi_dbtr_data_msg data;
+	struct sbi_dbtr_id_msg id;
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0

