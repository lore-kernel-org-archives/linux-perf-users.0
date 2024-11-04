Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DD1FAC3A
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754410; cv=none; b=nwkAN+2w7kiU9RAE5rQInX51RR5WZrISlqxia8KYCp0gaDowww20rHFu4PrecUwy2siBVbk79GWSZNVocEaf5uJcaR41guPuoo7mogbsWScA4CxxEZLg8NPM31nDh/PsCaD8gXoTwyYtvf0Q/pXU5TsCK95THtFfTxVKdBTpcMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754410; c=relaxed/simple;
	bh=9RjTPFEQXXi8G0IerLZGozkA4RzgGbTlEP2CyRIRfeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLo/FOlx9eBpeGhyjzgInJlpPrRkc7Ee5vh54KysT7rfI+NLfd+yuLW4rxZ15tBj4VttoLC+Hn40L1YX29bKvEDaApN2kM5CO6Vw2NHjy0OhgearMMo5RTddirZnq+CF26BdaJSEd5JiOmufaGehfrpjpsXLzuuVO9KL+b57Yg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NhjMGgMU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NhjMGgMU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so4143995b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754407; x=1731359207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBYozqmP4kgDqCATVF4mr9l1mgqwfE3SxQIhbzP4kRk=;
        b=NhjMGgMUEhgRno7PwfPvg6lB9l+PEwpt6ye+KSHWVS5F5iT9iFGvBllz8wwcC56ejm
         kv42oOgWIdOMajUCC5ddSPjdPYaNJWNVngXYcmpY1NGr9nE3418abzwbW7vO1jCVxTDy
         rPkCiYWbYjmwbENymnDv8leINzDK00qPAQ87QEwPOTPgPQlCc5Qdc1iQphA+GcEyjxQm
         ct/DBeZxAVnSb69RHe0JZNApS2uNXbJ+IQ9bJHZ9+dw/E27mAUMVXwyq0SICl+ervKYt
         6XaK9QbFY1K/iKGwf93r3mrYHeADV2WB4ztIUZnR/c3KGs1hhXP/xStfOzCduyd/tzDY
         Nf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754407; x=1731359207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBYozqmP4kgDqCATVF4mr9l1mgqwfE3SxQIhbzP4kRk=;
        b=MeONUVQUqYfylYlPzQ7emiISKBwLIikjhBba5LrZZDVnjIEIMjlxOKW/T6rng+NLfk
         inp7GW0IfOwfmSgH/fOXwQiwsSROW0M2qCLrnQDjKB9gxTsKAKP7VsblU7fwsVvfINrI
         daHFZOZv+5qN/49e8f36CAsmQLVUq561UiWVuK+FitHV/09AHqRgHrpwnKvAnlWgtzWY
         2Xwzp1qTQg/+uROxlmpqbVyxKwgAFj4kV2XRgd4ojLPN4fEk2svy2ySljZcWiaFMLyge
         G63Qfhcwz33243urrQiIFgkuWwAR0gWYIryxq1O7LnbQ/+wxPslhUVwUQTOdm5g18T26
         ENPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSAJbehI4Lko9psS4uAliAjwc4pOWsnBR/XibzMJuv8R+5aGrMvZFzCraRx/do8rHmTbgwkywbaR7fBaEWw/b9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv624yR+zmURqwFfj4fjGHAzDm5sfJlSZrJKA6+NCx6bckEd++
	Wzn1pByiPXnp9dT6Zd8NlP8MxRl2w+8yh4AuEW8hf7y+y0VFEaQKpMZ8YC/iTVI=
X-Google-Smtp-Source: AGHT+IEw7Pl3WMMSXrcg/sNy1bE2C/ljw19KDpDHK234X+biDUyX9c1c/9FjwUYq0Fp1+rkwdwDnZQ==
X-Received: by 2002:a05:6a20:d8a:b0:1c6:fb66:cfe with SMTP id adf61e73a8af0-1db91dbb56emr23905631637.21.1730754407516;
        Mon, 04 Nov 2024 13:06:47 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:06:46 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:04 -0800
Subject: [PATCH RFT 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-2-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=9RjTPFEQXXi8G0IerLZGozkA4RzgGbTlEP2CyRIRfeA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmeZT/lrQPcgVSp866b5oottGWZXne8zlbMz/PXfP45
 jJB/7jmjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACbCkM/I8EGjLfRN5emCxfff
 Rt6svpYVp9S0KufSprL9ixpVVctvHWVk2Lp43dZb9d071xb2bZlirmHzr33jpYSkuarLqw/PaGT
 YywQA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Arc uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                           | 2 +-
 tools/perf/Makefile.perf                             | 2 +-
 tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/arc/include/syscall_table.h          | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6774b67d4668..504d762cc572 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),riscv)
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 18294b840121..02ff3f2fcf12 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),riscv)
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
new file mode 100644
index 000000000000..11707c481a24
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..391d30ab7a83
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += arc time32 renameat stat64 rlimit
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
new file mode 100644
index 000000000000..4c942821662d
--- /dev/null
+++ b/tools/perf/arch/arc/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1

