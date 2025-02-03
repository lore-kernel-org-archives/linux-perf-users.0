Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B91D515A
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609342; cv=none; b=dzxCBAkA7pv/5Rok5krmCbY2kShm2zsaYzxVm3dAYBfV1adJ1QXNKgDwG2llxau3U9mIo6XHFZCQzQOgXAyLFOgjHj8OPo05RhiwAJ6Hy2bI696M3ICjHu3BIPsQBgamyIB2KgV7+TN86vgN9n8J0yCTlDYQAdM2uFhLkbLWqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609342; c=relaxed/simple;
	bh=RrA6XOwtMtx+JH6++S6+ucWJ7rkJfmXz5me7tMf1tnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QISIhe3/mEyR60VWwKtuWKoTIqBsEmCw5IUYByLxzL/NmbFyTXFwLF1fWwAzI2fPqAezCg+OM5sYG99c4ttJbRVbYgRaxA1G/nImd5pIuaRWg0CrwmCSrFYLLQotqgZBQlW0INPaYjqgDqdVS1uLaak55hSNJLX6x/KBwlHWhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qyg7Acxd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qyg7Acxd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163b0c09afso82876015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 11:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738609340; x=1739214140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+cVOS5FJmIAsNqPulg8a9PrdBe6p9kJKl40HshGULo=;
        b=qyg7AcxdhP2NMx4n5i6oVyjcPexrpC51Yvwza7w9n95KB3mQ0HJkO95SfBeCq2y3W+
         /roead5zMV2PnLyhvo4NFxerQix0QOmSUlkkppxED7Ck5xnA7gXgEkkVCp/gZ6uBahA2
         oKLqWGHLfPDs6xHqQXJQCt8cfX402E4CC2X15DcAzwuOKzPe+1ueFmr9dTlJ2mBbyC5J
         CKp03i8qy6+s9OIhwj7Gul0uwaPCoPFpKRtpI+ScK4OyNH1H5nu7nUsLBs9i0BvGsco9
         XNZdIX1eSkwewu04xPGo+3HKL9VT/87OLRFRJZMTuI0brcuCmHM8thTfc5XK2LWBgS0o
         qTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609340; x=1739214140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+cVOS5FJmIAsNqPulg8a9PrdBe6p9kJKl40HshGULo=;
        b=U8kiINirOzWeEL0zGcO69sHHgf+few3k+PTZWg/cwJUgc8dBMf5zvSJkktNrxI0Gt7
         yP/tPWhGTaX1ST+JlBRfefiJMuzhTQW8AYdvhfD2W+1F6AEmcrdYFr5XEbMdRdb9mdpY
         1dW9Vwn0vmb7ihiEFUuqzA8hhhi2qKUihHENwCiVRW9hYvHusDLDTSrdUqMiU9sTS26P
         YCIoJ0arDhHNMZwYx62oslOIAGBgk49hVYwzSd16H3+agdpd6L4pAmeUfKdSMPkPmH0o
         MGigT9DYNVoOE66Lu54IIF7BX9THBizaq2Af1LxTGlyhMGF/uMujgemzyaHB77h574vy
         5P5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNQ2gSeADqZS0W92B6tjpSHvJpQi9X8xpZj5DYS9R3Oyhklbdb3srdIl+w0ovIHL2pY4m29iFU0Qx/FbAI54RC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17lYpcCyWYyrExFjgwrUH/IVn6/PhomWHi3dFFCr8W5kvg/7E
	3WDaPUST4JBpPFIgStiN1ylzrtFnzO3quNFYbn+H4qqtnMXxXB8l8bpmLKNP5kU=
X-Gm-Gg: ASbGnct40gJd3NUMR0g3m7XCQPQ0H9issIPHH5EsQK3wHwVlGmviQ9xH/wZ+sBKVNiQ
	AAx66XarM7Gnf5CJxvpUmviA8A2uZX2Yo6gQ+oQwSzFsMpD9IO9vl8plpZNJ5BLlZ70BQOyGCCD
	6TAK5wDxrOI0rnY9m6S6HB5clU12N+KQ9DbtEEK7CMPJjzTCmHCi+sV0nbNoctSsnOyT/2MWIbt
	rdYZpXaxALFChZaHFj8urFaQenROSdQvYh/VAQ3HNEbixtXL5r1ypBz+uMYAVt/gXFwdruxCpGP
	uZVCpcRovjc=
X-Google-Smtp-Source: AGHT+IGcN0Vo5CKWdsr1pwOo6noYRq4z5e3fkA1+iadto7tAVdbWOLyGP+oftVvWDTpnF5AAlr0ojg==
X-Received: by 2002:a17:902:db02:b0:216:69ca:7714 with SMTP id d9443c01a7336-21dd7c46297mr353702245ad.11.1738609339800;
        Mon, 03 Feb 2025 11:02:19 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4f63:f9d5:2cbd:2947])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31fcd3esm79813435ad.104.2025.02.03.11.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:02:19 -0800 (PST)
Date: Mon, 3 Feb 2025 11:02:14 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the
 build
Message-ID: <Z6EStkn-YZ8zaO7u@ghost>
References: <20250201071455.718247-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201071455.718247-1-irogers@google.com>

On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> This work builds on the clean up of system call tables and removal of
> libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> 
> The system call table in perf trace is used to map system call numbers
> to names and vice versa. Prior to these changes, a single table
> matching the perf binary's build was present. The table would be
> incorrect if tracing say a 32-bit binary from a 64-bit version of
> perf, the names and numbers wouldn't match.
> 
> Change the build so that a single system call file is built and the
> potentially multiple tables are identifiable from the ELF machine type
> of the process being examined. To determine the ELF machine type, the
> executable's header is read from /proc/pid/exe with fallbacks to using
> the perf's binary type when unknown.
> 
> Remove some runtime types used by the system call tables and make
> equivalents generated at build time.

Our approaches are very different but I sent out a patch to do this a
couple of weeks ago [1].

Did you look at that and decide you didn't like the approach?

- Charlie

> 
> Ian Rogers (7):
>   perf syscalltble: Remove syscall_table.h
>   perf trace: Reorganize syscalls
>   perf syscalltbl: Remove struct syscalltbl
>   perf thread: Add support for reading the e_machine type for a thread
>   perf trace beauty: Add syscalltbl.sh generating all system call tables
>   perf syscalltbl: Use lookup table containing multiple architectures
>   perf build: Remove Makefile.syscalls
> 
>  tools/perf/Makefile.perf                      |  10 +-
>  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
>  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
>  tools/perf/arch/alpha/include/syscall_table.h |   2 -
>  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
>  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
>  tools/perf/arch/arc/include/syscall_table.h   |   2 -
>  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
>  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
>  tools/perf/arch/arm/include/syscall_table.h   |   2 -
>  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
>  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
>  tools/perf/arch/arm64/include/syscall_table.h |   8 -
>  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
>  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
>  tools/perf/arch/csky/include/syscall_table.h  |   2 -
>  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
>  .../entry/syscalls/Makefile.syscalls          |   3 -
>  .../arch/loongarch/include/syscall_table.h    |   2 -
>  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
>  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
>  tools/perf/arch/mips/include/syscall_table.h  |   2 -
>  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
>  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
>  .../perf/arch/parisc/include/syscall_table.h  |   8 -
>  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
>  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
>  .../perf/arch/powerpc/include/syscall_table.h |   8 -
>  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
>  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
>  tools/perf/arch/riscv/include/syscall_table.h |   8 -
>  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
>  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
>  tools/perf/arch/s390/include/syscall_table.h  |   2 -
>  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
>  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
>  tools/perf/arch/sh/include/syscall_table.h    |   2 -
>  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
>  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
>  tools/perf/arch/sparc/include/syscall_table.h |   8 -
>  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
>  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
>  tools/perf/arch/x86/include/syscall_table.h   |   8 -
>  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
>  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
>  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
>  tools/perf/builtin-trace.c                    | 275 +++++++++++-------
>  tools/perf/scripts/Makefile.syscalls          |  61 ----
>  tools/perf/scripts/syscalltbl.sh              |  86 ------
>  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
>  tools/perf/util/syscalltbl.c                  | 142 ++++-----
>  tools/perf/util/syscalltbl.h                  |  22 +-
>  tools/perf/util/thread.c                      |  50 ++++
>  tools/perf/util/thread.h                      |  14 +-
>  54 files changed, 598 insertions(+), 506 deletions(-)
>  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
>  delete mode 100644 tools/perf/scripts/Makefile.syscalls
>  delete mode 100755 tools/perf/scripts/syscalltbl.sh
>  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> 
> -- 
> 2.48.1.362.g079036d154-goog
> 
