Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34C7083D
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571230; cv=none; b=aK8tYNbkDdd7oEkweNKaNh6cWO3EHjhgH5g9uTUKAEZIVmPeRo823fKbzZKwsZLR+HlbLnt6g58MLfc3wrFhfmryOc/LA0ZglnGDhJ5jgp0WPS4UGL6QY03xde+akkwst7SYFxDpJmNBwFXniEGLpekUcyB6rlCtteHw5UKOxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571230; c=relaxed/simple;
	bh=xvks63l7xONUwaoT5VH2/yr6G1LcwAiQ5h0NQg210K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jX5vBhzoFOCcRPOVjMYg9SdBb25rcGDhWAjmVBqicTaRvM3wa8zn3CClkI+Xf4ApccelowYWNNGjqEoP7e2BPNFyHkkCiDl3bjVr4W62q5VvyfFX6hlkIundPSRwB9C7uv+CDpjSMbYq+1JMwH4UI4f7z2ZT9bSiDzh1MNLYm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nan6i04P; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nan6i04P"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so51265ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 17:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734571228; x=1735176028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RHVxPSc6oea9aIgGh4D/2dAt3qJRUgcCKfo5Ib7QPU=;
        b=nan6i04PY2vQHnmy9B640KabGWuJhDcGsq2ngN+ejpXmFadvOMviETtWDAD9nfW9Iz
         fqVrqKcuslqjWMxUTm3Nxw1ZOutZHlCOX398cipG28MVY5DOFu/CiEs2bQUcipRviKXy
         vdEI3QKtopsOWPSYkPF1uOVnZ2Z2R8WZE6EqAp9x+d+W7mYV1o76+35S2Aos1J0u+7py
         wRXROSbW4cyh9SHXfNoxwxwKps3Xb6ExXfs/cJgRvOwO19I7dqMWRguAvMSVWloRYEfy
         oLPRisxugyRKrrp2dJwQoFeN9VIs+cWmOKt+snlmLjrBDkg5XJ5H49Roadnsa2JMrZ3R
         hu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734571228; x=1735176028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RHVxPSc6oea9aIgGh4D/2dAt3qJRUgcCKfo5Ib7QPU=;
        b=r5izEWRXKRHVSBwljheqrKOS1kgpgOeddhsv/uBQx5kWc2Decmdc/GgyFT+nBETyTN
         Xn+mVg0/+U6An58yBr5JFb5l/TMk2iIIuhGcY3UOcTLwV18j6Yf0XOfXw2UVCIFgndGc
         noMn5w29aJB4K4iKxaZi7dt9pPsWJht2WysnonT+tq89aWWr9bf86AANbm3u5BiGrHKj
         DGJJDnwnFTvnqWLp5wpROaq8SHXqGYCpu54qP0A3FST2bDmv587WVSRdHTF3C86MNyzC
         HkZwOJyTnbPmNWAV4r6b12PRNvXo/P4hVqR90jAhyKRCJsuOVll7Cim2wMr0G43ihjGj
         Lf5g==
X-Forwarded-Encrypted: i=1; AJvYcCU5VgkpUpEfJ0rgWOZ5ru0pUfip93JI0BfZqgUNeZKSIIqBAY2xZS6lFyR0Q6oZBnYl/O4N18dtN9eHVorBuhpd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoq2w3hVWyQHp6xgmXR0GTaskLsf12X4jMysyaAdmUkOInhL1U
	UW83Tl5EorxVmWf2Onb8XES7EEueH7kxZHoTGuFnLHBhHbV+CNdzHmkYou+I84gpM1WQRPWXwou
	0C3DkDVeu4paKDjwQWwHpnYp70rcz48ISgDIv
X-Gm-Gg: ASbGncvBEBCYDPMFSHjyBKfPinXlWtizjCA3RXatwc6H0NgJdzoOCjAmTIDpFWsEEHi
	P5dAhiA6MBsC44VnIyEgWheSP3N9JeHbnVbCeO3k=
X-Google-Smtp-Source: AGHT+IFT4VomyTbaDm+Tt9oLhBLkCP6zjLLV9ggnhwJAIaPZFjvjp4bRFXXsaIbxAGg8/I8njI04ZXZzDs+aEIwkU1Y=
X-Received: by 2002:a92:c54e:0:b0:3a7:a5d2:c641 with SMTP id
 e9e14a558f8ab-3c05833f719mr1448515ab.14.1734571226270; Wed, 18 Dec 2024
 17:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost> <Z2MXXFhUzoQmW4xV@x1> <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost> <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
 <Z2NNcy1jCLqb62h2@ghost>
In-Reply-To: <Z2NNcy1jCLqb62h2@ghost>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 17:20:15 -0800
Message-ID: <CAP-5=fUBcu=Kd7StJvwdM_ArnSdOjmAcgR7NzDd+Ep8LrNMhyw@mail.gmail.com>
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:32=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Wed, Dec 18, 2024 at 02:13:20PM -0800, Ian Rogers wrote:
> > On Wed, Dec 18, 2024 at 1:02=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > On Wed, Dec 18, 2024 at 11:23:51AM -0800, Ian Rogers wrote:
> > > > On Wed, Dec 18, 2024 at 10:41=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > > > > > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > > > > > On Tue, Dec 17, 2024 at 3:52=E2=80=AFPM Charlie Jenkins <char=
lie@rivosinc.com> wrote:
> > > > > > > > After binutils commit e43d876 which was first included in b=
inutils 2.41,
> > > > > > > > riscv no longer supports dumping in the middle of instructi=
ons. Increase
> > > > > > > > the objdump window by 2-bytes to ensure that any instructio=
n that sits
> > > > > > > > on the boundary of the specified stop-address is not cut in=
 half.
> > > > >
> > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > >
> > > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > > > > A binutils patch has been sent as well to fix this in objdu=
mp [1].
> > > > >
> > > > > > > > Link: https://sourceware.org/pipermail/binutils/2024-Decemb=
er/138139.html [1]
> > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Do objdump version detection at runtime (Ian)
> > > > > > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_r=
iscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> > > > >
> > > > > > > > --- a/tools/perf/tests/code-reading.c
> > > > > > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char=
 *filename, u64 addr, void *buf,
> > > > > > > >         const char *fmt;
> > > > > > > >         FILE *f;
> > > > > > > >         int ret;
> > > > > > > > +       u64 stop_address =3D addr + len;
> > > > > > > > +
> > > > > > > > +       if (IS_ENABLED(__riscv)) {
> > > > >
> > > > > > > Not sure if there is a consistency issue here. Elsewhere we'r=
e just
> > > > > > > using ifdef, such as:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-too=
ls-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n=
69
> > > > >
> > > > > > I don't have any strong feelings about that. I can change it to=
 be an
> > > > > > ifdef. On other lists I have been told to use IS_ENABLED whenev=
er
> > > > > > possible, but it's only a small difference.
> > > > >
> > > > > Can't we just use uname here?
> > > > >
> > > > > So that we don't use kconfig.h since its not used in tools/perf/ =
and
> > > > > makes it looks like perf is in lockstep with the kernel source tr=
ee
> > > > > version it was compiled from?
> > > > >
> > > > > $ git grep kconfig.h tools/perf/
> > > > > $
> > > > >
> > > > > BTW, what would happen if I collected a perf.data file on x86_64 =
and
> > > > > would read it in a RiscV machine with such a objdump version? The=
 same
> > > > > problem?
> > > >
> > > > This code is in tests hence thinking that a separate fix is needed =
for
> > > > that problem. Hopefully the use of elf machine/flags tackles it:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n25
> > > > We are getting somewhat disassembler heavy. We have llvm as a libra=
ry,
> > > > capstone as a library, binutils objdump and llvm objdump. Given the
> > > > pain with parsing text, could we lose the objdumps? Similarly for
> > > > addr2line?
> > >
> > > Are you suggesting to remove this test case entirely to get rid of th=
e
> > > objdump dependency? The goal of this test case seems to be to check
> > > objdump and perf return the same data, so it doesn't seem like there
> > > would be an alternative to using objdump.
> >
> > I can imagine having an objdump dependency for a test but not for some
> > more core like `perf annotate`. We have to do weird things when
> > parsing text, like this code I'm not proud of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/srcline.c?h=3Dperf-tools-next#n523
> > The issue with that code is that LLVM objdump has changed its output
> > in newer versions to be closer to binutils objdump. Did that break
> > perf? Maybe it just broke what our variables think is an LLVM objdump,
> > but things aren't really broken. This kind of issue doesn't occur with
> > a library, although the differing needs of library versions is a real
> > thing.
>
> Yeah doing the parsing of the text output is not ideal... For this test
> case it should be possible to dynamically link against libbfd.

I need to write the patch set to delete libbfd from perf. IANAL but
the issue is that libbfd is part of binutils and GPLv3, while perf is
part of the Linux kernel and largely GPLv2. GPLv3 is incompatible with
GPLv2:
https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility
While using dlopen means we're not linking against libbfd, we may
effectively be using it as a plugin which again GPLv3 (in my IANAL
opinion) wouldn't allow:
https://www.gnu.org/licenses/gpl-faq.en.html#GPLPlugins
Currently to get libbfd support in perf you need to be building the
binary yourself and add to the build BUILD_NONDISTRO=3D1. We do this as
part of our build testing but having all the #ifdef-ed libbfd code if
nothing else makes the code harder to understand.

> I would
> guess something similar could be done with llvm-objdump but I am less
> familiar with that. I don't know if that's a good path to go down
> though.

In the past I perceived there was hostility toward LLVM from the Linux
kernel community. I guess GPL was considered the special sauce as to
why Linux won and the BSDs hadn't, so the preference was to favor a
compiler that used the same license. I don't think that's true any
more and I think there's a lot of sense in using LLVM's libraries
rather than reinventing them in the perf tool, or using perhaps less
orthodox sources like libcapstone. I'm not a fan of the text output
processing stuff so getting rid of objdump and llvm-objdump support
would be good imo.

Another area where I think we could lose a lot of code baggage is with
libunwind, as BPF support requires libelf which brings with it
libdwarves which when present means we don't use libunwind. I've heard
reports that libdwarves is slower, but I'm sure we can add caches to
speed it up which would likely benefit a range of people. I was kind
of hoping with all that deleted we may be able to get rid of the
majority of the arch directory, but the syscalltbl work is adding to
that directory :-)

Thanks,
Ian
