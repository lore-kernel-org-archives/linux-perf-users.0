Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD31FAC51
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555462; cv=none; b=f73lYo9zdrRavKFm5Tw28BlpqXq96lBFWrAtMqFZjOA0EUVYE1DhblYjjajT8k7Hhw7pVMf4IGWo0vR3CXoZMegGGE8bqbsZp9mwq9csnbwQxxDSVxmFPcmlEcBfbNupLVzoD3/lsWg55bY1qlOFNZIJgTS8RYOfZJ0ILwT+liE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555462; c=relaxed/simple;
	bh=8H3wMQ/MbfGoC09L1FK6owB/PgM/HCZEYV5FlSKzB9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0ObmZxUKUii9PSUiHK3OEHm4/Klp1txKnNpFzLyygTclprOTJImy/5OFb9AKBSTD74j6nYGHKdFlSiXzJmUqUoQME7Irhsz7UJUcYBbzkD2Zz+nmd/RDtOfDRyO+hQWLnDtI6anWmdD7hF1VPEPMuFwXai8kB9us8JwUrTuL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aUsulFri; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aUsulFri"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216728b1836so1124365ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 12:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734555460; x=1735160260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DnlzBZ1bNkNrCyadScSxNwpP2f0bFLt+gzSGc7X//Xk=;
        b=aUsulFriOiUJHlAIMnRUPoQ+THfbjjbAh35BHX5+D288HYeeU1MOk1t8G89qb90YQI
         t3Q4bkmhJtuBlOZgzUhODG+21ZAzgwEnzgyOoIuM1B3c47wqUH7rfI0PCCLYlPLSuLJF
         5dDjQsP3VAY+a+vLV/4KXm2+cpLceLZHTunP3d5tXBrnXkHyYZctm5IGk0AKdNpCfRGy
         R6jOIDf1nyleZlb4dkaEeUeO0DwZCVQ0Ya30mjKB75vUNCGEaSlAXciHgVHCKEjON+7h
         mwZuQYJPZg8XVMuq0rG8/lfQPzYzeeWkDqHLmGo2/ZhlCQPFAa0kKuG3i88tZMxNceR7
         ui+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734555460; x=1735160260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnlzBZ1bNkNrCyadScSxNwpP2f0bFLt+gzSGc7X//Xk=;
        b=WUjiwAs5v8YIbXC5PGDExlgdd/KTvbRRsPoGMwXmu8dJAPLRZ0fc3tbWQzpqtfvxbx
         z8+ZIlxp/RR1aJ5poX6zd/IgQSG4CT6gR1/XjjD0zeCRLOsdUHl2FqdpAdx4slScQN7v
         HgDUjHEW/LXYiqkSyO7bFxAqW60YiMsO+uknazGHzp8LMOldrPZwssZKkHXvn3BKYJUT
         yVTg8eXq82cvJVt3+BAWeb0M6bWtVpeJKMGC9IUCqYJVOJ5RJzeT6lOMAWduxNqCx2jY
         wwYggL/1tBOXA+TF4kpFEqvngvPOpxplYpZZ1Xp5dfnmS+NirtxKYGrBqb3i7F3fDLz9
         kL+A==
X-Forwarded-Encrypted: i=1; AJvYcCVh2RMQS4CYhA3jRya9wSpURW1y0w8i84yheLjzZwnBFjpUPbdBs89z1AoTme9pBX9Gf9pPGoQ9Jp1giOdPK0z2@vger.kernel.org
X-Gm-Message-State: AOJu0YydIJMDImbEqetuFlLI84ZVGh7hsHVC+DR8Nx+t2RTwDQx4O8yi
	GZHXAL6J0IAK4RQ9+tKNoVMaRjnLtE7IkMUdXaB5nan3o6ng2FdB7JeC1NkM1aQ=
X-Gm-Gg: ASbGncuKEM+5R7rjgG6KWlqmyID/0BFQqRty4XEIXI+r3BiYNifH/fUPB6u5cy1DTvb
	VVU8ahWtW84m6keHswvWN+L3OrEyWiGzb+PC6nM3+GQ2lDRQTS7h7H9FwmV/V47dg+NFR50R3ok
	L/qrNz8mOS064X5U8Fp13tVO3jZlQQcfLRinPh+CQHKZzeZr8eTuzaxfCbDOTFQ8B7WchCw03uF
	kH6x0QIG/6TGgmZQufB0tfbJ/tIyNwCJ/oRu8ZgB/3JwaE=
X-Google-Smtp-Source: AGHT+IFbrr3Ugx9sJuxckBLXykfeFQB9mdy4wgUJpUjJFCoKZYBQ4+1F1qUWmiA9nhDeXvGo84jWaQ==
X-Received: by 2002:a17:902:e741:b0:216:386e:dbc with SMTP id d9443c01a7336-218d6fdfd08mr57672385ad.13.1734555459502;
        Wed, 18 Dec 2024 12:57:39 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5437asm80558955ad.162.2024.12.18.12.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 12:57:38 -0800 (PST)
Date: Wed, 18 Dec 2024 12:57:36 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Z2M3QNqQ_Sl1ZKtm@ghost>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2MXXFhUzoQmW4xV@x1>

On Wed, Dec 18, 2024 at 03:41:32PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > After binutils commit e43d876 which was first included in binutils 2.41,
> > > > riscv no longer supports dumping in the middle of instructions. Increase
> > > > the objdump window by 2-bytes to ensure that any instruction that sits
> > > > on the boundary of the specified stop-address is not cut in half.
> 
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> > > > A binutils patch has been sent as well to fix this in objdump [1].
> 
> > > > Link: https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> 
> > > > Changes in v2:
> > > > - Do objdump version detection at runtime (Ian)
> > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> 
> > > > --- a/tools/perf/tests/code-reading.c
> > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> > > >         const char *fmt;
> > > >         FILE *f;
> > > >         int ret;
> > > > +       u64 stop_address = addr + len;
> > > > +
> > > > +       if (IS_ENABLED(__riscv)) {
> 
> > > Not sure if there is a consistency issue here. Elsewhere we're just
> > > using ifdef, such as:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69
>  
> > I don't have any strong feelings about that. I can change it to be an
> > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > possible, but it's only a small difference.
> 
> Can't we just use uname here?
> 
> So that we don't use kconfig.h since its not used in tools/perf/ and
> makes it looks like perf is in lockstep with the kernel source tree
> version it was compiled from?
> 
> $ git grep kconfig.h tools/perf/
> $
> 
> BTW, what would happen if I collected a perf.data file on x86_64 and
> would read it in a RiscV machine with such a objdump version? The same
> problem?

Yes that's a good point, we should be detecting riscv at runtime too.

- Charlie

> 
> - Arnaldo
