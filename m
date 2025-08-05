Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0522147EF
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Aug 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422802; cv=none; b=UvOFsAd9H/ofLfHAsqe0jpvKekk/Sd4SS4iUtxI5KTtf0ZOU4Dp3i4yRDJ/V8rzO5sRMG6Vinjv/XXG0qdGijZj3QAwCmljQeZ8Vh0CB8jRU4GaikyfQz7pIRcIqk6QnWhZZDyxkkUSGAegvC5241Okrj197mHKzUBl5+4mgZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422802; c=relaxed/simple;
	bh=+qlcnySMX8H8r8qM3Fwa6oKB8CHMdlILBs2oyCCdlVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgN7IBPryOmnf3qLwqB7b2TppnptWcuHk68VLMb3D40um0jDGodpI+Q931jii+OwBBcgIrdpjKQaaVReLZTOZuSXgnIjmArJJSUINUvZptXceA+YYrjl7T70sXnyUfmtD3CDIKW0Wt8VDUANhaUaElqnZAo5SR8bl+ABpWCkc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=gS5q6bHH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="gS5q6bHH"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e182e4171bso501353185a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Aug 2025 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422798; x=1755027598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Av9ulXUYq8yypH92LgefCWXE0SBG4q/HDQdjt7nKwbs=;
        b=gS5q6bHHwwqgpwrJhZNvQG/XEsuG5cccTu8L091bJqboPLHuExlcxVjdz7tIheybqi
         8cIap9noWifxDLoB65B7TBWgdLKDBflBZfxgmQoL5OlR4Z+EStzVXHTi7MwTUHPrdYj+
         oUWxgLWrt1PNk70r7TyXz6kwuYASvBQfZUkugyXqTpnTzChq6Z1qHobD1qr/KANWJhOd
         H4cRBgnL3fasaoTAI4xSgQYf8AhrnZ4g3O6Lh0oHoPrL/p4oPuiOur84xJLB817ezYYW
         29Bi/JC5T2fDDvl9QwSKqZqJs9J64b57QtzIVt2yQW3tMKvfreoH6Js/5e77EHv/ogQl
         GD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422798; x=1755027598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Av9ulXUYq8yypH92LgefCWXE0SBG4q/HDQdjt7nKwbs=;
        b=sUkyB/j3eKIS+UEiZ9zlGrQHIhSW33xp4RM5lBdrPz/O2n/zokV33/8loWKZ/a3DHp
         /q+QzJn9/PnnkcN3tKiAqZ6OqxPnd1ZCTfwVYRbsqgJ6m5dnSJ9sdct1O93oSsiPzikD
         9+C/ynaJu5ruOsdqtByuOTimvtD6eNT4WQHCtwSVr7tcpPezjem40JIa+SZps+W2QTFh
         XtYQ2R92eKpgxGZE2E5WCMzVZXhh91aisX4ZpPWzMiCNq5w3Lg+prx/3gNZRvV/PmqFv
         pREeAXNfPGH6lgvOKlBN2OnKtUCkk5a/z4h9bCxazT0Ph66/FbHKv2bTdb07eiT6BCwm
         5vGA==
X-Forwarded-Encrypted: i=1; AJvYcCWhTHsgt61NT8PgoYbTG+c9ddfPhy7BxzeOY9fJ6EjVWv5LnLt+esT7dbcXTJvn5wp8idg2sZsF5mHQ1XWk5R4y@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgaMO1crIs0dog/s8gmZF9x7M0BdnZhJn1KM4zJVSxjVvN2oc
	SIBXJGf28qKuqTLJ/WpWe8mgRj15lBq0nUHPCtpchro24keychGgm3J4AldwHUFngz0=
X-Gm-Gg: ASbGncvrQ5w4RSM/e6VEq1NdgnHqqN8UCufhmqpJTrCSaXSA5blr6iiSVkbBJeGskxS
	PQKHMYaAFghAAYtpRsoTckxH8LvJNq47UhFcMlXMb+EI/B66hRH/Tb6cIAWnssnQ4p4XKoVUVRe
	9dgpphJ0KELRqO/C5jVVRmHA2P14wdW0tlnxXoLxl8+jnwmNrYwW5pNAx7jiN5aWWtPVokLHUWV
	JDSUlnKjYDRj9EyfH8xnV1FAyGS4ynXoMIPkm4Efw+KMdZbNSFov/pp4q6jqURnw8mQkiElDVow
	CPeck/N4nRo/XNJ/SH9V/tZPSMUG/QLKY/4igJlmojHBXVz4zuOLeUhDDDCxhyQvJk+lKXCyMVb
	81fHwKfFvFjpYwWMk1Prun6mAE5dhW02p9TKdpPPhIBUjIsfqvLC8tCdTelYbbnyuBjSEp2zbx+
	BSZRv2aQ==
X-Google-Smtp-Source: AGHT+IGaYz9rbHDaluNVvJAMepELkYucyj+ueO/efwJAG+Ld5Sktyl2JYCmbLDUiGqnvS0NmhNn2LQ==
X-Received: by 2002:a05:620a:370f:b0:7e6:67b3:ebf2 with SMTP id af79cd13be357-7e814d1a1e2mr85393985a.27.1754422798022;
        Tue, 05 Aug 2025 12:39:58 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:39:57 -0700 (PDT)
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
Subject: [PATCH 0/8] riscv: add initial support for hardware breakpoints
Date: Tue,  5 Aug 2025 12:39:47 -0700
Message-ID: <20250805193955.798277-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds initial support for hardware breakpoints and
watchpoints to the  RISC-V architecture. The framework is built on
top of perf subsystem and SBI debug trigger extension.

Currently following features are not supported and are in works:
 - icount for single stepping
 - Virtualization of debug triggers
 - kernel space debug triggers

The SBI debug trigger extension can be found at:
https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-triggers.adoc

The Sdtrig ISA is part of RISC-V debug specification which can be
found at:
https://github.com/riscv/riscv-debug-spec

based off the original RFC by Himanshu Chauhan here:
https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro.com/

Second RFC by Jesse Taube here:
https://lore.kernel.org/lkml/20250722173829.984082-1-jesse@rivosinc.com/

Himanshu Chauhan (2):
  riscv: Add SBI debug trigger extension and function ids
  riscv: Introduce support for hardware break/watchpoints

Jesse Taube (6):
  riscv: Add insn.c, consolidate instruction decoding
  riscv: insn: Add get_insn_nofault
  riscv: hw_breakpoint: Use icount for single stepping
  riscv: ptrace: Add hw breakpoint support
  riscv: ptrace: Add hw breakpoint regset
  selftests: riscv: Add test for hardware breakpoints

 arch/riscv/Kconfig                            |  13 +
 arch/riscv/include/asm/bug.h                  |  12 -
 arch/riscv/include/asm/hw_breakpoint.h        |  59 ++
 arch/riscv/include/asm/insn.h                 | 132 ++-
 arch/riscv/include/asm/kdebug.h               |   3 +-
 arch/riscv/include/asm/processor.h            |   4 +
 arch/riscv/include/asm/sbi.h                  |  33 +-
 arch/riscv/include/uapi/asm/ptrace.h          |   9 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/hw_breakpoint.c             | 769 ++++++++++++++++++
 arch/riscv/kernel/insn.c                      | 165 ++++
 arch/riscv/kernel/kgdb.c                      | 102 +--
 arch/riscv/kernel/probes/kprobes.c            |   1 +
 arch/riscv/kernel/process.c                   |   4 +
 arch/riscv/kernel/ptrace.c                    | 169 ++++
 arch/riscv/kernel/traps.c                     |  11 +-
 arch/riscv/kernel/traps_misaligned.c          |  93 +--
 include/uapi/linux/elf.h                      |   2 +
 tools/include/uapi/linux/elf.h                |   1 +
 tools/perf/tests/tests.h                      |   3 +-
 tools/testing/selftests/riscv/Makefile        |   2 +-
 .../selftests/riscv/breakpoints/.gitignore    |   1 +
 .../selftests/riscv/breakpoints/Makefile      |  12 +
 .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++
 24 files changed, 1657 insertions(+), 191 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c
 create mode 100644 arch/riscv/kernel/insn.c
 create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
 create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
 create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_test.c

-- 
2.43.0

