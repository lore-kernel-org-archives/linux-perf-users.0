Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1914F9F4
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735868703; cv=none; b=LZEhrPIQP7dx+bVELuyTg7vxa2JfMqoMfkgnqrRADd6f7CZGUI2ZtKhyDwHVQUx8OGNBLjRu810vhgnXnXZGJZiMS5dXfirFqtTXpX0ObAzWlyw8TSfY8S8DR1Pao09o9Z8RLG23I7P2IK2gIsQgqXvVHa4v/BuvL3JZxMnAJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735868703; c=relaxed/simple;
	bh=8DXRkjKiMXyKKlr3S0B4rCNSO4zHo1bxFapnvPyVoTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLhDVqJjr/QIWwm79FiJxIr3n1AStRv4DDhIcUPzkew5wYLj4l8rnyIQ8XdoI33OgjlcpB3vN8pkfDn8hDOcXlzf+QoZ31nHA/vbNcWiPzqY9Tn2jHQETYuOKnmPy+B8OCwO8exTayeHjMfnfz5ri/pQWxi3bZet2rdInU19BVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k54mYGDo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k54mYGDo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21680814d42so139915905ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jan 2025 17:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1735868700; x=1736473500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJ3eKF6usIayHtABB82uMYDq9+VNdHrqEKVZK5a0SvE=;
        b=k54mYGDoQrnvc9W7givm587O+CNnoeSHTOGs7VYXW694O29NSvz/UsAy5f+oj/wLql
         /athqu7ZAFs284J0474qVOIM41myBXXyOkl4HpSnvdsbDiFfZHyA50nwN69ikvnqoc16
         ZwxlEeM53Fqck1KPgtaHz1M5kxm9t/6+K4pjD2h2UKTDWTSMVqQpeQUsd2pGFA+SFaWM
         0Dkyok3l82XpFNuU+wP1UhLvOVgy2K1QT8lQrJ/fzi/+//M4hCHvFW5NOutZuhl+dysB
         y9jJEEhr/pPXZImYvGXpRw8EY7Y/CJrT4xJxvnHtov+Qasy6pz+o3cv9sfOS8z8eEmhY
         xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735868700; x=1736473500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ3eKF6usIayHtABB82uMYDq9+VNdHrqEKVZK5a0SvE=;
        b=A6H70Hj0efpXBEfl227hYit5yxmDP6aZKUbVaWjmyoae6eDm0zsxLuYmhQ04KQbBl1
         odZWyMGnxXFd1kjQD5AIZT82jT+yDFQ8Fw9t2VKvUWx/ibVXljaTckZruWpwxsDijylT
         Sbx0pLcR11B46vYc8/OzNawWR614k4pzWmK7a2AQKjmB+JOuKj8LXX9Y297l9c01FPO4
         JWfHR+rRP3kFJNJxNUhfs4fBksO7IkFjvrCxHmqOm6IqLYB1/tMZCHx+x2hkOof6VmFV
         hOr1LQ8JAOC9JM6DRypYrnIngOZE8oXX8vMIDCM6Vm4lW38VtQPzXfpXLkLWtiflGUyB
         4rDg==
X-Forwarded-Encrypted: i=1; AJvYcCUjus4vL5LTG3+InH21It+02EZqmmLbX7EHbByaLX9CP3vcC/JygBJ3JNxOfGVkf2O9Qkp/nGaTavl+vp+W0UKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzS9XiuoKhG9M+Mf8A6OjU4gwLtMMzt69eJtqpPXPYqHTgeQe
	fYDq+buQN6f60ewgktYsW1wCsfkMxgT5OP/uMDGaALd57TuXBlikbneTRSZgeCE=
X-Gm-Gg: ASbGncu2HF+cqmGJUPH9dYvVL7NvgYFoOU1uY/AR0p2/juAij/g1FPS2b/hbobLhgr5
	io8ZQiRr3Bi7H3iWUMQa9Reciw+4N+T+t/0AQMH+PyZKzBk12WVjOCyaA1m/D+H2Et2cFKmoXQ4
	ZxuaXRGNXE4YLqfG9M1Haj7buvbnYTZD5RNq7krsupOICAAnt2zYQyxUDxfVlHq2p82kq8xtL1i
	46UBTjyUw/xpS/9BYGDVgL6Q0jsEJ8VoL/+zkVPpOuNgdfFGAFm
X-Google-Smtp-Source: AGHT+IGlJOK8lsWm8Cmc19QjQZCDFg/Q+5Dom/f2Np8/qC3K9ofC60FF2YnXzD02V2GYbVMkVLFEug==
X-Received: by 2002:a05:6a00:124a:b0:725:f4c6:6b68 with SMTP id d2e1a72fcca58-72abde404e9mr65911625b3a.4.1735868699801;
        Thu, 02 Jan 2025 17:44:59 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:e7aa:b727:e049:3265])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b20b3fbbsm19449947a12.24.2025.01.02.17.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:44:59 -0800 (PST)
Date: Thu, 2 Jan 2025 17:44:56 -0800
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
Message-ID: <Z3dBGM5L41v0RlZf@ghost>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
 <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost>
 <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
 <Z2NNcy1jCLqb62h2@ghost>
 <CAP-5=fUBcu=Kd7StJvwdM_ArnSdOjmAcgR7NzDd+Ep8LrNMhyw@mail.gmail.com>
 <Z2N8WLTmh0ojIzhF@ghost>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2N8WLTmh0ojIzhF@ghost>

On Wed, Dec 18, 2024 at 05:52:24PM -0800, Charlie Jenkins wrote:
> On Wed, Dec 18, 2024 at 05:20:15PM -0800, Ian Rogers wrote:
> > On Wed, Dec 18, 2024 at 2:32 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > >
> > > On Wed, Dec 18, 2024 at 02:13:20PM -0800, Ian Rogers wrote:
> > > > On Wed, Dec 18, 2024 at 1:02 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > >
> > > > > On Wed, Dec 18, 2024 at 11:23:51AM -0800, Ian Rogers wrote:
> > > > > > On Wed, Dec 18, 2024 at 10:41 AM Arnaldo Carvalho de Melo
> > > > > > <acme@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > > > > > > > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > > > > > > > On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > > > > > > After binutils commit e43d876 which was first included in binutils 2.41,
> > > > > > > > > > riscv no longer supports dumping in the middle of instructions. Increase
> > > > > > > > > > the objdump window by 2-bytes to ensure that any instruction that sits
> > > > > > > > > > on the boundary of the specified stop-address is not cut in half.
> > > > > > >
> > > > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > >
> > > > > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > > > >
> > > > > > > > > > A binutils patch has been sent as well to fix this in objdump [1].
> > > > > > >
> > > > > > > > > > Link: https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Do objdump version detection at runtime (Ian)
> > > > > > > > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> > > > > > >
> > > > > > > > > > --- a/tools/perf/tests/code-reading.c
> > > > > > > > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> > > > > > > > > >         const char *fmt;
> > > > > > > > > >         FILE *f;
> > > > > > > > > >         int ret;
> > > > > > > > > > +       u64 stop_address = addr + len;
> > > > > > > > > > +
> > > > > > > > > > +       if (IS_ENABLED(__riscv)) {
> > > > > > >
> > > > > > > > > Not sure if there is a consistency issue here. Elsewhere we're just
> > > > > > > > > using ifdef, such as:
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69
> > > > > > >
> > > > > > > > I don't have any strong feelings about that. I can change it to be an
> > > > > > > > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > > > > > > > possible, but it's only a small difference.
> > > > > > >
> > > > > > > Can't we just use uname here?
> > > > > > >
> > > > > > > So that we don't use kconfig.h since its not used in tools/perf/ and
> > > > > > > makes it looks like perf is in lockstep with the kernel source tree
> > > > > > > version it was compiled from?
> > > > > > >
> > > > > > > $ git grep kconfig.h tools/perf/
> > > > > > > $
> > > > > > >
> > > > > > > BTW, what would happen if I collected a perf.data file on x86_64 and
> > > > > > > would read it in a RiscV machine with such a objdump version? The same
> > > > > > > problem?
> > > > > >
> > > > > > This code is in tests hence thinking that a separate fix is needed for
> > > > > > that problem. Hopefully the use of elf machine/flags tackles it:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n25
> > > > > > We are getting somewhat disassembler heavy. We have llvm as a library,
> > > > > > capstone as a library, binutils objdump and llvm objdump. Given the
> > > > > > pain with parsing text, could we lose the objdumps? Similarly for
> > > > > > addr2line?
> > > > >
> > > > > Are you suggesting to remove this test case entirely to get rid of the
> > > > > objdump dependency? The goal of this test case seems to be to check
> > > > > objdump and perf return the same data, so it doesn't seem like there
> > > > > would be an alternative to using objdump.
> > > >
> > > > I can imagine having an objdump dependency for a test but not for some
> > > > more core like `perf annotate`. We have to do weird things when
> > > > parsing text, like this code I'm not proud of:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/srcline.c?h=perf-tools-next#n523
> > > > The issue with that code is that LLVM objdump has changed its output
> > > > in newer versions to be closer to binutils objdump. Did that break
> > > > perf? Maybe it just broke what our variables think is an LLVM objdump,
> > > > but things aren't really broken. This kind of issue doesn't occur with
> > > > a library, although the differing needs of library versions is a real
> > > > thing.
> > >
> > > Yeah doing the parsing of the text output is not ideal... For this test
> > > case it should be possible to dynamically link against libbfd.
> > 
> > I need to write the patch set to delete libbfd from perf. IANAL but
> > the issue is that libbfd is part of binutils and GPLv3, while perf is
> > part of the Linux kernel and largely GPLv2. GPLv3 is incompatible with
> > GPLv2:
> > https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility
> > While using dlopen means we're not linking against libbfd, we may
> > effectively be using it as a plugin which again GPLv3 (in my IANAL
> > opinion) wouldn't allow:
> > https://www.gnu.org/licenses/gpl-faq.en.html#GPLPlugins
> > Currently to get libbfd support in perf you need to be building the
> > binary yourself and add to the build BUILD_NONDISTRO=1. We do this as
> > part of our build testing but having all the #ifdef-ed libbfd code if
> > nothing else makes the code harder to understand.
> 
> Licensing is fun ;)
> 
> > 
> > > I would
> > > guess something similar could be done with llvm-objdump but I am less
> > > familiar with that. I don't know if that's a good path to go down
> > > though.
> > 
> > In the past I perceived there was hostility toward LLVM from the Linux
> > kernel community. I guess GPL was considered the special sauce as to
> > why Linux won and the BSDs hadn't, so the preference was to favor a
> > compiler that used the same license. I don't think that's true any
> > more and I think there's a lot of sense in using LLVM's libraries
> > rather than reinventing them in the perf tool, or using perhaps less
> > orthodox sources like libcapstone. I'm not a fan of the text output
> > processing stuff so getting rid of objdump and llvm-objdump support
> > would be good imo.
> 
> Yeah I agree. This test case did end up being interesting though as it
> unconvered this change in behavior of objdump on riscv, but that's
> tangential to the purpose of this test case. We need this patch on riscv
> to stop this test from failing, but it is also reasonable to approach
> this differently and not use objdump at all.

What's the next step here? Would you prefer to get rid of this test
entirely? I sent out a v3 that uses uname [1].

Link
https://lore.kernel.org/lkml/20241219-perf_fix_riscv_obj_reading-v3-1-a7d644dcfa50@rivosinc.com/
[1]

- Charlie

> 
> > 
> > Another area where I think we could lose a lot of code baggage is with
> > libunwind, as BPF support requires libelf which brings with it
> > libdwarves which when present means we don't use libunwind. I've heard
> > reports that libdwarves is slower, but I'm sure we can add caches to
> > speed it up which would likely benefit a range of people. I was kind
> > of hoping with all that deleted we may be able to get rid of the
> > majority of the arch directory, but the syscalltbl work is adding to
> > that directory :-)
> 
> Yeah... The syscalltbl work will add some extra parts to the arch
> directory. A lot of the additions are generic and a chunk of
> arch-specific ifdefs were able to be removed, but we still have the
> "problem" that not every architecture uses the shared syscall table and
> supports different syscalls.
> 
> - Charlie
> 
> > 
> > Thanks,
> > Ian
