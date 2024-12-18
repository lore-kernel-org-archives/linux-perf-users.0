Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54114D283
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555756; cv=none; b=AOnI0dGuA8IBfeBUq33iujho0+xWxvT8P6whaqoISUXBfW/dSQkzhkypWWl7C1l7Lnte6VwTHmBLvv3wnL/yQ6Ia+dN50SSAh5TXh1LvOTDM1IMDMA/lQ4roEIMVzHi91P1ei8wd+QtiULpnCqidSLgt63l0jg4xBg5tKLUQhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555756; c=relaxed/simple;
	bh=Wmg6V9Kp+8xcAMfN5JLKf/Zv/txUVGtU/0FK9QGmSg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsYf0gCr5kDBt1yVIac+ji++2bqS2cbtdwCHfHO5i3c9C4WyUnHkpc7jLhqRHTNOWyHXwpxjG1zF2HTbbChrVt8mwkXUUIwvROp/tljleyT3icGN39cWg/l1YV+mvyx4npNWXeERMp5lkYT+knKr+m1C322p6wRLzVL4LyH1Zws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2TUL8CoU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2TUL8CoU"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728d1a2f180so99785b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734555754; x=1735160554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VEvOuS9GjCc8R1kkciZzUfnJPop9QAlnrlUsyAlmMgg=;
        b=2TUL8CoUEJ3AnQl782k/BHnn3PpPbOiF0hc7lccK5l7j2H0QX4gBfaoFQoxAKQQLU+
         NgcacYRySsEA25xO018IkyVGOvhoLNbL33g6T6dKoO6Ny+wpz4LcTSqPSx2x38ryIl7Q
         L68dhfuCBx5sDZG9ms2inv2kNHE61GpzaWWFmgCPzcBF1VOMRElDg0b+87Tk/BfRYVgU
         vvPG1+Q1WSoUTPQhhXMFzma1MNzDDEFGG713IlHAg28aB9AK+LQ/SgTA7czfaBe9GoRw
         QXcnjHRjcck0JCJakA6a7UucBmyLhY5jc4ciKhtxDnDZbu3ZfkzLs5Wmbgdy6uWr0KPC
         4myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734555754; x=1735160554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEvOuS9GjCc8R1kkciZzUfnJPop9QAlnrlUsyAlmMgg=;
        b=WTzGALvKtIg5/LXue6w4puHqwgE808x91cZuSNghGKbgd5CvdzxdhJK7FoOb72+0zG
         qS7OANdxQQH4ZRykGfLHVcnMxkMUTaYM+3XxCWBHrCc41ZnQHbDmo0UmwGO8p1V/Oxax
         G9BWotKOvBoXHzhZmKhACD4rXstR4Y2DLGa4Ec6XnFe2+p6iXQYemyCznvVTcPGew4ts
         H/yfrFH2U0FOWfEhGgsPKnuIfv3fvQ2bMBz7dhR71cZDZaNR7IJ1iTCeVuZ0uzI2GEnq
         GjnxhHEM+v2OV+rMkp+kX5ok8T/LIJHaCuKyqvXVEiAyL75DCt4SnXRWVRqfL59k1cN6
         LXaw==
X-Forwarded-Encrypted: i=1; AJvYcCXhm4IxcCocVH7aIb4HjTg/UImi66TsvqmpzINQsMbvjVZfwhBAykFKk0FysfBh81GdvO92exjZQv5E1VrUFAzD@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiPTIjspJRHtLLDn2DzRASdp6tw/d4TKNuMvHZoBq/Pyd5HxG
	MmwFXCI7khCgsQLbXSZhgEfaUq4nX8h2LyF1+FstVdgWW0MGS07tJceyFPUxer0=
X-Gm-Gg: ASbGncuVccj3EB3J8eAphPV8L65L/8ekN5yJoXXoxPhsGWgrh6ESOvXRq4H1BpcwSDJ
	qnVSqCQjWJlTQPLFoqZOqlnSDHhFBI0TFuidKjqXBM611enpo4qy0bPZdoAlXPLEQTC66/OXrXQ
	HEUNyFlqHnhDBBseWwZVAa7pD/5krvFmw7HECsUh0hWt2BJcP9WhPrNPmTbfMj3zkiGbvMuc0Ju
	CLkCSjWrA087KJE2aMwx2APV79ri6KUVYkaI2Xt1M5SQks=
X-Google-Smtp-Source: AGHT+IGGTepBnro/Yv+Td9aOesliGxiq1HfALi+NYhCuWSXz+YG9fqxb1BuJcfYw6mbiXYYJ+gAnug==
X-Received: by 2002:a05:6a00:7428:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-72aa9a10440mr1146368b3a.3.1734555753073;
        Wed, 18 Dec 2024 13:02:33 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b77290sm8969134b3a.113.2024.12.18.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:02:32 -0800 (PST)
Date: Wed, 18 Dec 2024 13:02:30 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
Message-ID: <Z2M4ZparbNRvRHpz@ghost>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
 <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>

On Wed, Dec 18, 2024 at 11:23:51AM -0800, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 10:41 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > > On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > After binutils commit e43d876 which was first included in binutils 2.41,
> > > > > riscv no longer supports dumping in the middle of instructions. Increase
> > > > > the objdump window by 2-bytes to ensure that any instruction that sits
> > > > > on the boundary of the specified stop-address is not cut in half.
> >
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > > > > A binutils patch has been sent as well to fix this in objdump [1].
> >
> > > > > Link: https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> >
> > > > > Changes in v2:
> > > > > - Do objdump version detection at runtime (Ian)
> > > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> >
> > > > > --- a/tools/perf/tests/code-reading.c
> > > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> > > > >         const char *fmt;
> > > > >         FILE *f;
> > > > >         int ret;
> > > > > +       u64 stop_address = addr + len;
> > > > > +
> > > > > +       if (IS_ENABLED(__riscv)) {
> >
> > > > Not sure if there is a consistency issue here. Elsewhere we're just
> > > > using ifdef, such as:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69
> >
> > > I don't have any strong feelings about that. I can change it to be an
> > > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > > possible, but it's only a small difference.
> >
> > Can't we just use uname here?
> >
> > So that we don't use kconfig.h since its not used in tools/perf/ and
> > makes it looks like perf is in lockstep with the kernel source tree
> > version it was compiled from?
> >
> > $ git grep kconfig.h tools/perf/
> > $
> >
> > BTW, what would happen if I collected a perf.data file on x86_64 and
> > would read it in a RiscV machine with such a objdump version? The same
> > problem?
> 
> This code is in tests hence thinking that a separate fix is needed for
> that problem. Hopefully the use of elf machine/flags tackles it:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n25
> We are getting somewhat disassembler heavy. We have llvm as a library,
> capstone as a library, binutils objdump and llvm objdump. Given the
> pain with parsing text, could we lose the objdumps? Similarly for
> addr2line?

Are you suggesting to remove this test case entirely to get rid of the
objdump dependency? The goal of this test case seems to be to check
objdump and perf return the same data, so it doesn't seem like there
would be an alternative to using objdump.

- Charlie

> 
> Thanks,
> Ian
