Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A41A08C5
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573150; cv=none; b=LP6Qvs/gRwFxDPOY+xuUOoGSID421nHMxVp0abAg6vtXQUeZ4YroUxnmgjAf5soMIoV528u36XiaNrMJDlEVXpFt4oDOcg+048JnioxNLaqjRrAKsa+ZgosZ/LfwAWMqg42ctuEHOqp/xJmEP+FzaGq1cRBLgnS76tyY4dqbXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573150; c=relaxed/simple;
	bh=TffHVOo4qZ8y2qh3SIIszbhor2cAv2iwa3OVur5ndNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C466hzMmTwARmtx3OKwiE7AcIm/tzW/GOKq54ANN/LtWfh/ZwHrBbHYKzIp4K7MOmf4jTU62LpmzFY03dsDuBCwdgFjc6/dERMT/31QaFs8YSM2f7Bl3rs957mL0TJDWhaxztK1qcE4+38D3YBUqh7DJjGj/R9isRKmgQA3lR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IubEnUzR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IubEnUzR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728e1799d95so360405b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 17:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734573148; x=1735177948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0hIoYn7mPi3FgUS2MCNd0c4MX2xpkvKX7vy1y9aMeMY=;
        b=IubEnUzRvswRJCUebbUyswgw8VgWXlZaO6FXaCSnPiP4/9nVJdOmSAFi86lE3Q8zMU
         Xz+AYgcDkfiPAB+goXxaFbWDVQIHfVWHj36rx4NqIC604aextRVB8g3zIHBuF8cDzyW7
         zMODwNMghKd4QYkPZFdpVJcPonCWM7N93v7nKBnATgKpU5BWO0O1H8ZnKkjvmWgRVgJ5
         DHm9OE2SbxZrfo7IReXto2T860sts/irkYt9MuBLlxMX9LCSiq/0zwj+87AM5y6T5NbQ
         1744q0H+tboGVl9WqIbuGLHg8Au/uu1B5UTRtgRkYFsLeUKlnY0T1VH89+yExitl9Km1
         IsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734573148; x=1735177948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hIoYn7mPi3FgUS2MCNd0c4MX2xpkvKX7vy1y9aMeMY=;
        b=ZiKnuC/w0wxkgTG0f5tPcgligZmy3RnG0I7EqH7cQtzs8XLlaGK61UeIgNQfy3cBB2
         LhLZh1uHQq7VsYAgAilb4kMnuL/jR2litdPU5tgmySHnXCnJdMHQrdyJZXXMctiTE09P
         PW2CgavfU9O0kUxaXvbo2pFtcpyzinlUFZUj1TQItZJ0uIMhEgj5iOQtn3gzJPpHkMTY
         KisV7bPLphGLCsJGIfgqXhx0uVp3LsddsID9Yk5lorz9CTSAhTid5oteAWS4xz4tESQE
         YgGqRgkSklerZ7sJYTeAz8t8txWnF8wA1fHQPNwQP0R+7es3pEVtSHYHuo6y4K+v1Ogf
         AS+A==
X-Forwarded-Encrypted: i=1; AJvYcCWdF4iG3789C74fph587zr2Mz+nLj0zruTuySyhCSJDjB0BOIREC6PP/hp3u3ry0VKUDcfGGNu6KSaYe2borgLr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9U7GAUA2zJGLBzJn4yfjLNyeFbEFRxuvJFrfmzwJM0ci5wbup
	wEpEjsXXuL2iitpH579EhZY0ONlS9w1Qwv3pYgUfP2YTuFmRdUl1jpPV2c9vAYo=
X-Gm-Gg: ASbGncvJwa0pwefIvFdxGf1WLp4US2vhXO3N0VfV+HlxKT8pe1bIodSnBziBe+PAr+l
	hU//5UAQPxXg86FFOANNaunJzHkr6sVyS41BOxKz0IAvBc2FauOdd1YQvfbN1dg4kSTw7KFAOVZ
	i6zj6TYZg2bgKgAnolHCMDDv0AFGM/hiPbAZg/HfAK6JkPXh/plpyGFM8jLhGGaApn0NRtU4vQ6
	ASXUHBX9k30OeRkYpnYgNoAIPLMmH46BKrAfhSEo9j/OOg=
X-Google-Smtp-Source: AGHT+IGt+ZCDcVVFAePqIYU9RjJQ0k+diPgN8DgjguNeNHG5ckZLUG4P896wZazyc+1vhNXeSRFBkg==
X-Received: by 2002:a05:6a20:c799:b0:1e0:dc34:2e7d with SMTP id adf61e73a8af0-1e5b45ff9eamr7878142637.5.1734573147826;
        Wed, 18 Dec 2024 17:52:27 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb70sm135039b3a.98.2024.12.18.17.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:52:26 -0800 (PST)
Date: Wed, 18 Dec 2024 17:52:24 -0800
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
Message-ID: <Z2N8WLTmh0ojIzhF@ghost>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
 <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost>
 <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
 <Z2NNcy1jCLqb62h2@ghost>
 <CAP-5=fUBcu=Kd7StJvwdM_ArnSdOjmAcgR7NzDd+Ep8LrNMhyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUBcu=Kd7StJvwdM_ArnSdOjmAcgR7NzDd+Ep8LrNMhyw@mail.gmail.com>

On Wed, Dec 18, 2024 at 05:20:15PM -0800, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 2:32 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Wed, Dec 18, 2024 at 02:13:20PM -0800, Ian Rogers wrote:
> > > On Wed, Dec 18, 2024 at 1:02 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Wed, Dec 18, 2024 at 11:23:51AM -0800, Ian Rogers wrote:
> > > > > On Wed, Dec 18, 2024 at 10:41 AM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > > > > > > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > > > > > > On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > > > > > After binutils commit e43d876 which was first included in binutils 2.41,
> > > > > > > > > riscv no longer supports dumping in the middle of instructions. Increase
> > > > > > > > > the objdump window by 2-bytes to ensure that any instruction that sits
> > > > > > > > > on the boundary of the specified stop-address is not cut in half.
> > > > > >
> > > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > >
> > > > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > > >
> > > > > > > > > A binutils patch has been sent as well to fix this in objdump [1].
> > > > > >
> > > > > > > > > Link: https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Do objdump version detection at runtime (Ian)
> > > > > > > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> > > > > >
> > > > > > > > > --- a/tools/perf/tests/code-reading.c
> > > > > > > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> > > > > > > > >         const char *fmt;
> > > > > > > > >         FILE *f;
> > > > > > > > >         int ret;
> > > > > > > > > +       u64 stop_address = addr + len;
> > > > > > > > > +
> > > > > > > > > +       if (IS_ENABLED(__riscv)) {
> > > > > >
> > > > > > > > Not sure if there is a consistency issue here. Elsewhere we're just
> > > > > > > > using ifdef, such as:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69
> > > > > >
> > > > > > > I don't have any strong feelings about that. I can change it to be an
> > > > > > > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > > > > > > possible, but it's only a small difference.
> > > > > >
> > > > > > Can't we just use uname here?
> > > > > >
> > > > > > So that we don't use kconfig.h since its not used in tools/perf/ and
> > > > > > makes it looks like perf is in lockstep with the kernel source tree
> > > > > > version it was compiled from?
> > > > > >
> > > > > > $ git grep kconfig.h tools/perf/
> > > > > > $
> > > > > >
> > > > > > BTW, what would happen if I collected a perf.data file on x86_64 and
> > > > > > would read it in a RiscV machine with such a objdump version? The same
> > > > > > problem?
> > > > >
> > > > > This code is in tests hence thinking that a separate fix is needed for
> > > > > that problem. Hopefully the use of elf machine/flags tackles it:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n25
> > > > > We are getting somewhat disassembler heavy. We have llvm as a library,
> > > > > capstone as a library, binutils objdump and llvm objdump. Given the
> > > > > pain with parsing text, could we lose the objdumps? Similarly for
> > > > > addr2line?
> > > >
> > > > Are you suggesting to remove this test case entirely to get rid of the
> > > > objdump dependency? The goal of this test case seems to be to check
> > > > objdump and perf return the same data, so it doesn't seem like there
> > > > would be an alternative to using objdump.
> > >
> > > I can imagine having an objdump dependency for a test but not for some
> > > more core like `perf annotate`. We have to do weird things when
> > > parsing text, like this code I'm not proud of:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/srcline.c?h=perf-tools-next#n523
> > > The issue with that code is that LLVM objdump has changed its output
> > > in newer versions to be closer to binutils objdump. Did that break
> > > perf? Maybe it just broke what our variables think is an LLVM objdump,
> > > but things aren't really broken. This kind of issue doesn't occur with
> > > a library, although the differing needs of library versions is a real
> > > thing.
> >
> > Yeah doing the parsing of the text output is not ideal... For this test
> > case it should be possible to dynamically link against libbfd.
> 
> I need to write the patch set to delete libbfd from perf. IANAL but
> the issue is that libbfd is part of binutils and GPLv3, while perf is
> part of the Linux kernel and largely GPLv2. GPLv3 is incompatible with
> GPLv2:
> https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility
> While using dlopen means we're not linking against libbfd, we may
> effectively be using it as a plugin which again GPLv3 (in my IANAL
> opinion) wouldn't allow:
> https://www.gnu.org/licenses/gpl-faq.en.html#GPLPlugins
> Currently to get libbfd support in perf you need to be building the
> binary yourself and add to the build BUILD_NONDISTRO=1. We do this as
> part of our build testing but having all the #ifdef-ed libbfd code if
> nothing else makes the code harder to understand.

Licensing is fun ;)

> 
> > I would
> > guess something similar could be done with llvm-objdump but I am less
> > familiar with that. I don't know if that's a good path to go down
> > though.
> 
> In the past I perceived there was hostility toward LLVM from the Linux
> kernel community. I guess GPL was considered the special sauce as to
> why Linux won and the BSDs hadn't, so the preference was to favor a
> compiler that used the same license. I don't think that's true any
> more and I think there's a lot of sense in using LLVM's libraries
> rather than reinventing them in the perf tool, or using perhaps less
> orthodox sources like libcapstone. I'm not a fan of the text output
> processing stuff so getting rid of objdump and llvm-objdump support
> would be good imo.

Yeah I agree. This test case did end up being interesting though as it
unconvered this change in behavior of objdump on riscv, but that's
tangential to the purpose of this test case. We need this patch on riscv
to stop this test from failing, but it is also reasonable to approach
this differently and not use objdump at all.

> 
> Another area where I think we could lose a lot of code baggage is with
> libunwind, as BPF support requires libelf which brings with it
> libdwarves which when present means we don't use libunwind. I've heard
> reports that libdwarves is slower, but I'm sure we can add caches to
> speed it up which would likely benefit a range of people. I was kind
> of hoping with all that deleted we may be able to get rid of the
> majority of the arch directory, but the syscalltbl work is adding to
> that directory :-)

Yeah... The syscalltbl work will add some extra parts to the arch
directory. A lot of the additions are generic and a chunk of
arch-specific ifdefs were able to be removed, but we still have the
"problem" that not every architecture uses the shared syscall table and
supports different syscalls.

- Charlie

> 
> Thanks,
> Ian
