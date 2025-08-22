Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB48299954
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885601; cv=none; b=J7TPjwEVorYqGAHAZvn7F2Ul22MvpynKvdRg2dBl9411lYEHYsnba0Eeof7pyVQuzUCCG7PwnB7PoN/EYh71Ggn7TbkLCtJ1XhdQrnLRke96xWY+2F0RPU6unknGln9DBSvL7tTh/gwV0M91vj8qqDOmsbCZm+lGxbb8PjwBMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885601; c=relaxed/simple;
	bh=QjGUX/IavHKYnweyZiQnCgeIEp0Qa7sid7tkHYHTpno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMx9aw0Qkmy/XS1aUnoag0I3jqzTRMuoyfi93TyVosNwPY2d/hCV9cji0r2xiU8Gu6D5DTtvUSD1ZWYS1o8ll3mkcCYujhYQUd5fSC8hduAc+FBTA1SgInqWwgzORCl1YCPeFBXyPHuCPAQrdoMTelIQdSuvu3FLVusGLCbgjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=bowIBjw1; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="bowIBjw1"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b17498109so808861e0c.2
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755885598; x=1756490398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9fNzpGQYiY8hUTovQusQUuPvFziC263n9KoSaKQGOM=;
        b=bowIBjw14hcCMcXEFQelP3F/IgxTFZDchFVES0znmztlohD5OqknGtwUauveTSnrWI
         d+g9ASlXmk6+S6w0s3lsxdo6K/nufGMQFXIZwbw9iynSEugqPGnB9tqXpw0Hcih9Onui
         iijzOiiuMaPBArTtbShD9NF713MkistmOXciz2PZKEmS10o7BfeUpLVebc5fgDvwRzKP
         xg2jY+GCeh9VBOPo2w7FXx5csbaTRSS94Be+Y1ueb3eVtMPtYQMLwwwYnbRwA83bIx5T
         3xrWnQYIygkpgtWfsU2DBLyYmw2+EVYgNGEEnHrWCUL7dgBJzqPflfVugdJwqWJfRBi2
         TVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885598; x=1756490398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9fNzpGQYiY8hUTovQusQUuPvFziC263n9KoSaKQGOM=;
        b=osaS9bCoq8bhPNrNjKAlxIMgsYmi6UlHfw1qZrBuxKeQZS2fJSHIjltwPgnlFJzEsn
         MKaoFWUyIbrc6QyoG2Y7o3FEG9pd0f6kAESWypwbo4XOTJOOH7aWOh44Tb0C9YAqE9ky
         RlW0iFTrSogG5eHQZCEPz09yrIAONL+T+rSwyJHSdaRBjfk5/PxPC2/KDiHr7ofhp0eR
         nj3Xz/fsoWCuNMTbjI4V7+bbnN0lgHb6QAiHADliWcIMlC926MS6cIWre9W/ntxt+cPI
         KWDQNx4aWyQ9L0QnYvL/LoUZNuEe2Ysd44AH5zGvQYS/P5KxfgUWm8TtSnRfsCe+sVqO
         L9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQGkexdGx1TJGlNJWMt4j0Emcx38GpkyXGhQMChYgfc6rzCVv0PZj4ya7XeyE+yiV6cWwT5paLKNgAieyNIeVV@vger.kernel.org
X-Gm-Message-State: AOJu0YzBG2ZAku9Dab3+zcoxhPDUb6OAe1DGjerSG99INSiYX5udCaW1
	7OF/NIPPokwzqsHfvphj6CaCatzWWn8hx0Ods/BM50fppkxl8t7gdd1e8pSuzU79MopTuGa0lXC
	UoThpgZvw/jBv/li+u2P6NY7wYPteXhjL1z/EHlR+lQ==
X-Gm-Gg: ASbGncu3cU7XJJdljyRsn8zrFm1f2MDqZpSSjM5OfdxI47nGDSKPj/B/aYRpbVes/Gi
	Z7H40TM0xmK0m8BsYEinuV6VDszplqJwyPtXH/bhiYytP7081wQaFFy6yySPcWfJaSxL8WJVxdA
	FvMUdYGdEPUv0Nx1TIGHPPc04ZNau91vfZWWq9QGOTdKmHKj7gtUpIp5cvs/MjbqCLtvhwhiL3x
	hp8gLXq
X-Google-Smtp-Source: AGHT+IGn5vdUvXU42asTYKNQVZYOTWSFQylr/vzhKnTrBq4lq3wiMD7MVYIp2kAGpgvKTA1X/43JEESbQNKODDhNtrQ=
X-Received: by 2002:a05:6122:2502:b0:539:27eb:ca76 with SMTP id
 71dfb90a1353d-53c8a2ea9admr1107586e0c.5.1755885598348; Fri, 22 Aug 2025
 10:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Fri, 22 Aug 2025 10:59:47 -0700
X-Gm-Features: Ac12FXx85Q9pdAS3tmJucpDWbmumN5hD5YReh0RpBOKeYl8mPi6vXHz7zLBXbxM
Message-ID: <CALSpo=aQyb+E0HHDRoXs0f5vvxJtMpCA546ROkq0e3B-ur9QBg@mail.gmail.com>
Subject: Re: [PATCH 0/8] riscv: add initial support for hardware breakpoints
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Evan Green <evan@rivosinc.com>, 
	WangYuli <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:47=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> This patchset adds initial support for hardware breakpoints and
> watchpoints to the  RISC-V architecture. The framework is built on
> top of perf subsystem and SBI debug trigger extension.
>
> Currently following features are not supported and are in works:
>  - icount for single stepping
>  - Virtualization of debug triggers
>  - kernel space debug triggers
>
> The SBI debug trigger extension can be found at:
> https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-=
triggers.adoc
>
> The Sdtrig ISA is part of RISC-V debug specification which can be
> found at:
> https://github.com/riscv/riscv-debug-spec
>
> based off the original RFC by Himanshu Chauhan here:
> https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro=
.com/
>
> Second RFC by Jesse Taube here:
> https://lore.kernel.org/lkml/20250722173829.984082-1-jesse@rivosinc.com/
>
> Himanshu Chauhan (2):
>   riscv: Add SBI debug trigger extension and function ids
>   riscv: Introduce support for hardware break/watchpoints
>
> Jesse Taube (6):
>   riscv: Add insn.c, consolidate instruction decoding
>   riscv: insn: Add get_insn_nofault
>   riscv: hw_breakpoint: Use icount for single stepping
>   riscv: ptrace: Add hw breakpoint support
>   riscv: ptrace: Add hw breakpoint regset
>   selftests: riscv: Add test for hardware breakpoints
>
>  arch/riscv/Kconfig                            |   2 +
>  arch/riscv/include/asm/bug.h                  |  12 -
>  arch/riscv/include/asm/hw_breakpoint.h        |  59 ++
>  arch/riscv/include/asm/insn.h                 | 132 ++-
>  arch/riscv/include/asm/kdebug.h               |   3 +-
>  arch/riscv/include/asm/processor.h            |   4 +
>  arch/riscv/include/asm/sbi.h                  |  33 +-
>  arch/riscv/include/uapi/asm/ptrace.h          |   9 +
>  arch/riscv/kernel/Makefile                    |   2 +
>  arch/riscv/kernel/hw_breakpoint.c             | 763 ++++++++++++++++++
>  arch/riscv/kernel/insn.c                      | 165 ++++
>  arch/riscv/kernel/kgdb.c                      | 102 +--
>  arch/riscv/kernel/probes/kprobes.c            |   1 +
>  arch/riscv/kernel/process.c                   |   4 +
>  arch/riscv/kernel/ptrace.c                    | 169 ++++
>  arch/riscv/kernel/traps.c                     |  11 +-
>  arch/riscv/kernel/traps_misaligned.c          |  93 +--
>  include/uapi/linux/elf.h                      |   2 +
>  tools/include/uapi/linux/elf.h                |   1 +
>  tools/perf/tests/tests.h                      |   3 +-
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  .../selftests/riscv/breakpoints/.gitignore    |   1 +
>  .../selftests/riscv/breakpoints/Makefile      |  13 +
>  .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++
>  24 files changed, 1641 insertions(+), 191 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>  create mode 100644 arch/riscv/kernel/insn.c
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_=
test.c
>
> --
> 2.43.0
>

Oops, this meant to be V2.

Thanks,
Jesse Taube
