Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7371285C81
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884845; cv=none; b=WcSp21XUMohO/8BS5JbCSH2UtV1PwpH/J/tXEecCRsmbAPATyShht3bZ79sDytAPQA0I22qID75xS+Xmam82iYnd4fUHthy0SIUmMkq4x153dI0viaKNyt+Jv9w8aT4RYtlloVlyymRFLQSWp7f1hlgllCAiMQxd5NHC9PGbQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884845; c=relaxed/simple;
	bh=3eKPG4TUTR4+0R+9VHkqyjDfcIO6WcWdW7JtEbAMzYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU3dpQhCmF+jpf5+Y4+am7Dd2iOyGI0jgBolZ54J/BMLQP+gb79KbGMT2FJOPlSXzij2WeM1TPTcmAT/J+qABFLWIWg/PAUa15jMRD9t203EtzusS5JEwfiq5IsBW3CPcswb6bIfJhGFoj/QFBxz6awWpDxSETQ/tjGhN5MAknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OTQZUj1v; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OTQZUj1v"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b132f943a3so22283251cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884842; x=1756489642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfYucjg1h8+O9tUzDFG8M32q+vBz17OTGpTy9qZYkXU=;
        b=OTQZUj1v9NpyD3w5ILfE7N9VGv6YW9/WHMn77bii310dpGoTVyRbNSK7xtcP83IsR8
         +CQPog4T8onKtM6zuZ3alDo+nr5ZiGUXa4Pemo4/Lf7GR8gvnk637iQvvULIBqw0opmX
         I3yWXea7mGx5DqiyhlSXv8T9MRyVuyzNrHb73qSHaCRkpX5A3qIxtRwLnNm6dByhWlUb
         +dE7+KYuDCwMRIoMH948AZ2xU7725O6fF8rZ7r3BzcHhsNl1YiyGnVmJkBIwaWwX1dho
         Gw3d+24AvmRfukzB/05Uu2tzBOFJP383COFWcUFS5nuDcvSkfYsuCWQprWgiRf/C6WtK
         R/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884842; x=1756489642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfYucjg1h8+O9tUzDFG8M32q+vBz17OTGpTy9qZYkXU=;
        b=HWkYDUbE/CyUgoU5daOZL8OlT0ZTy5E+DTnhmIrVQpq/NY1xqZ6y1hd72M2zFajE0C
         jgholNKOFCFac7jmfsvoXiHRhi+HI3sQmO0AEDx3TjmQyEd4AAAk39aHYfkcq0zhee2k
         nwv/yC01lOa0YXrhCorifqaePaBzjdskMITQ0UCl/EOlT0fSwkULg94s9nXfYOOGdTYx
         ZYgjpMGk8GDpc4YHMH+/2KDcqroYxwK0qTXItjjzBwlIUrL+7XWS+BO8tVtjJEY82+Fo
         8PQ6e78ssC6cPMJsNKPMSdpmIuQNnAgsCtZt2+LvFMdixofXehzQn/30T2kIRJQH1uZR
         Rwew==
X-Forwarded-Encrypted: i=1; AJvYcCVqBtINUc+Sdt5mNehVg59A1j3I5yO7Rs1ahIlwiI6pcCW7Iepe1iId51hU5ub85PmeJKcn3nXqLIlSNP2t0mR3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2WID9CBGcz+ALjT8x/kmNUgedP7FDCO6gGup2bRoqZY8ecR6
	vXzJJr7skevWX1dLHg0AmBR8s7er5eQB3UVShePTBq0xL71KaRsK4rZ6PkDKiPCmC6k=
X-Gm-Gg: ASbGnctRTFumbMbrmIUlsb7+D6xlb0CssLnonu34Rh2q9/DkE2RfkSI5kSoblznxTLd
	EVdnqOGxwK7P48qz/JbktpBn0dxRlUFKUz9UeX9FALTJTDXxc5U60yaQnsOigruH7XvyHzeXpFE
	MwpGWdfBZYwg/D/vjdoQA/vFSBFlmFo1nKvBXragAePfdESStdHZgYTGK1FmlnyNwkIYmRhC4pY
	m3dTWeWqP7fxUmjf8qX45EorOGzeoXZiDlS60r0ZecEWtCWQLa37ASJrqAuidJIspD5LdfOniLm
	MlOwDl8ylDArR0QV4zMAbChnu7KC+dmfex3KCZ9Q3WPvfHCcJI6bl4N7zth+qy1NWtJ7DA3ynhe
	pdHG9vYvCjVEqZbu2D/10uJHvr89rIarmdHeY6ZNQaaSg8J9Dr3rBg/48DP/sUBCUZiTAX/q0oq
	APAWFb/Q==
X-Google-Smtp-Source: AGHT+IGIVSOen45mpOt0xYdR05GnbUoonndymEzs2Y2tUjKO6oUDKgrfkoqnPSp/0zNTXeE4BQVymQ==
X-Received: by 2002:a05:622a:2615:b0:4b0:75ed:bbf9 with SMTP id d75a77b69052e-4b2aaacb9dfmr44784981cf.33.1755884842505;
        Fri, 22 Aug 2025 10:47:22 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:22 -0700 (PDT)
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
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 2/8] riscv: Add SBI debug trigger extension and function ids
Date: Fri, 22 Aug 2025 10:47:09 -0700
Message-ID: <20250822174715.1269138-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
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
V1 -> V2:
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

