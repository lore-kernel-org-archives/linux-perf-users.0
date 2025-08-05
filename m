Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAA23A58B
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Aug 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422807; cv=none; b=J3PMAwZnOYknp7CVVaFQdAgfMZpVRdKBf8zK70PJBXEjTztjkPLkss9ITklbPHrpwvAJn0t0rePX/B5OvXf9nOxBpKA9XvvqdN9NZFdP4WlHcPSt82F2TyzFdNErf3BTE8HvvO6KUtm97LQhQ5a9sl1rqgE/ghcIsZsTjVoYpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422807; c=relaxed/simple;
	bh=Mw1HF+WYqrZH50B60QETN97Z6Qf9c2O3cgvwGI4nSFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPKcqja5eZhNypHJbNM/K//f6o/mQbnJgZ0/3t+OyIlOCx/A9IETrUFSbvzmCsyrO0bxa7PwT72cZO/g+v+1xgrzaCUh+Pd/J5/ceTZTmxiuqo96uiSQPPU5wqSjVLc4QTMDYtpCC24twnYE3GQ3ffBdsZ1sCMtU6iyutPzhxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=WcrIQikb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="WcrIQikb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e7f940a386so171993085a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Aug 2025 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422805; x=1755027605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMI5Xwq0SqGXnmGRw5QTZMv+U2y6SNaFWej8c2zdngA=;
        b=WcrIQikb0VFMCoabuN1q9WZT2QVr9aFu9ytV5kdo8aLXFxoGSoJjFuEyYWaR9xt3NB
         ATrDEOAqwAaPCdLac/salE7Fmq73mMHJbpjHOaOL07Es7c9cVWGiWm+WZRvmbf7elDzF
         BA8E7SOpTN58Qnpph6STZtRFPR64WNZxS/GsU8nuGdUuWDEm4HD1pbYlI+TjbwRY265F
         CHO1yCnCbD2Eb/baWc/w2RTX5bElFPucouOGBDlyyFilTH14BdYJHZagOFWpmeX3QhOU
         nEBkxH+SdVdvPEMxBXfiodL5gB8fR4voQmEzr92H6FjisvLdpvZ44cDSvfjztiP15wR9
         /fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422805; x=1755027605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMI5Xwq0SqGXnmGRw5QTZMv+U2y6SNaFWej8c2zdngA=;
        b=VqMPRqhoRazIlHoJHJEL5FDxnKDMo+gITrHr7gSTwE+ZPk91xD+8+J6JOEYV0HZmsV
         xKfKUXZmJ590C3JcXJ3pvSjYwFeQlwderGoh2h2WUSrtpozc21QCHm9SENiokLTJBfMX
         +3iwmHxtRGp9T0x4K52mo5wkKLe54GvIH1IsCp3G3QN8PUUzOf7ao0qA2Pf9+lr4bdee
         vpHm4wAQ+EIj0jOEd3E6S/G08IXkk61vYrIzUrjGCFx662FKGv7AV+anRCiuOANSiU+E
         Dc3YppZjJqdYM8d8kNNCws8qKlme44FK8AGDZ/znZ6PVPcx21VnCyZVXzw7VIvTOAV8z
         hmeA==
X-Forwarded-Encrypted: i=1; AJvYcCWcDvO07p6uCwbXID8hhc4X6iEEVxMxYbNsJAGuWu1tJlyIyJcTL+Vc7lg9ToQQN6uBmoq7YgoI2DMPuoZlv4lt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zyw7+WQAyd0Iz/gKAzxb9EznWfahF3satl/JKXlGBLKlJufC
	yS8/nbfk7KhlOavgyf5u6JLqLepGMdiVZoKissAXgAVAJH5xd+sNArqMb4aIAKsAUM0=
X-Gm-Gg: ASbGncszItKBLghx5+Ki7EJ+73xA6BuI2BrD1LI/V5BqXGJkBTsyjTnL4jRFUi7Lm8n
	x2Uq0MV+jMa9mfS4hddznz6TgPOeD5pP53Y1R7OGfzIQRCskPLnDRVCkCdgi3nmB/Ky9IVucnnX
	H0+yJiZkUGCijve0hBObfFzUmlyfjdOCkgy/BD3dGgGc6iKTK0kaGe3n6pwUapOR2HtRD1U/SEi
	EZul/GDI10jqKPn0VawRdd6aBuFiRWQizrd86ZKttvTLRwgzDk6gfwd8wOOxYsNDlLpTb+CJ1Hl
	QbO8gCSIhS18AM5gvZXqc06JIv4vN/ztAQ2WdXl/2HXDWwxOJXBwn1S8h6eqCkOCYIEn4y8nzZu
	QlJBxUUvlAs7qzpQjZAXIy4rXfRoMjicZCKN15sXPe3hObg6ZT8Salpbof1mqm40ilOce6J+/6r
	s/ngjb2Q==
X-Google-Smtp-Source: AGHT+IGslZriZ3OsEZBWmVfkk5oCBsMISvqP0jsnyJuJf09cg7efSarv3MBZUu5//ACqxd//7g3UxQ==
X-Received: by 2002:a05:620a:430a:b0:7e8:2e5:feb3 with SMTP id af79cd13be357-7e814cf9504mr90508985a.1.1754422804849;
        Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
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
Subject: [PATCH 3/8] riscv: insn: Add get_insn_nofault
Date: Tue,  5 Aug 2025 12:39:50 -0700
Message-ID: <20250805193955.798277-4-jesse@rivosinc.com>
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

get_insn_nofault uses get_insn with pagefaults dissabled, allowing it to
be called in an atomic context.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Unsure if copy_from_kernel_nofault is an acceptable replacement for
direct dereference in __read_insn.

RFC -> V1:
 - Add new function instead of using copy_from_user_nofault
---
 arch/riscv/include/asm/insn.h |  1 +
 arch/riscv/kernel/insn.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index ba74e5b8262c..f87e0a48f786 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -553,6 +553,7 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
 #include <asm/ptrace.h>
 
 int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn);
 unsigned long get_step_address(struct pt_regs *regs, u32 code);
 
 #endif /* _ASM_RISCV_INSN_H */
diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
index dd2a6ef9fd25..c8f77c0093c9 100644
--- a/arch/riscv/kernel/insn.c
+++ b/arch/riscv/kernel/insn.c
@@ -2,6 +2,9 @@
 /*
  * Copyright 2025 Rivos, Inc
  */
+
+#include <linux/uaccess.h>
+
 #include <asm/insn.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -74,6 +77,17 @@ int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 	}
 }
 
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = get_insn(regs, epc, r_insn);
+	pagefault_enable();
+
+	return ret;
+}
+
 /* Calculate the new address for after a step */
 unsigned long get_step_address(struct pt_regs *regs, u32 code)
 {
-- 
2.43.0

