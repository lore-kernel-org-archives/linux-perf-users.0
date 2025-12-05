Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1A34C81E
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955008; cv=none; b=gbmT0P/Zb2vhtKvq1jN54kALV5LJpUDAc2lCp6G+w7a0XNgvq4/i9B09FDgdV6KEU+pb/RvC36y2SgQde031cxZS+3nwC4iUEroilva8QeejFrJdNgl7JT2gOdhnezoYiKkmhs8NRAelcoFW+klnTYmbBqKdTapsxULu1wV2nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955008; c=relaxed/simple;
	bh=ggYVYq/2wvZi4N/ZClkUiXE0PUFnEWG3UThBlJNwsws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMPiXtmexY0YQmdADwtfO0y5K8Kk/PeMDdtwFQzGUOYl5SA4enLvzum5vSqGII79sSsVkBXvdEzPCgB5EbFnEP4zquMY5RN9zAv4ZwcwVD6Qze7e9gwHIsnqDfrYzmsTHXnT3Meuq/4y7uNjYuzKbrKDg78bhfhQD3qwfNwwXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9r74sxE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9r74sxE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295c64cb951so266825ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 09:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764955005; x=1765559805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfKWxFNQ5/zRTBrUY2LpaD59EVDsgxwfR4FUJmyGUjg=;
        b=g9r74sxEpxxUKSmWZ9Fb4Z8UC6HC6UxSwaF0BkuCZ+w4YXypUKOmvlhG3LNsXvB5mR
         iBAYAUbN1ukhrW3hPVi4vMnULjNCgtQ1bcKYF0MeKuAa5zh0hx52/vE2WtW6jpfdZWeC
         WAdwNTM1zd/X+5aj7TaZFOJr0+dsXlN9SGExEp8ghZeu2mMOvqNTsa0kxCDIs11AALOl
         WrmhMyzl2+vZDUGxf9ms6tWbt+CL/rX0i99+pqJB02v1o8t1xCRfFr+oiKACfSGTIeH2
         MywlKAVxOyOQ0LoFxtIuuAwtpHI4i+gsMdgj5yNpIOa5QR5uJmS4FZKDADUU4zHmDrG/
         EgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955005; x=1765559805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfKWxFNQ5/zRTBrUY2LpaD59EVDsgxwfR4FUJmyGUjg=;
        b=iS4oPmiIXqrAjnYVOX8fxnVtBBk3i6XBZwjh8UC8YyDzdgLlB5vM1yo5p0X4z1tNAG
         eUULYxzHHeEveTB0PoZSXD2uZfBhC0Dl9WEhyPSiMYbrLRIbC7iYoeMDOe53nNaa1DAU
         KY/N7rmhgYBSlq5oclAIpyoNtR3HYmnSXIqvKlvyZH6uOnjLFHogjO8NCTNKJOipVT33
         Z4c7N1eT1Rb9r9ax3FMVCc8KWaMRNzzGuaFabmF1N5LpuDOTSHVYbSLKcoAHHQBa0UOT
         5YCE+wVocEj1eO0K22xA+sEd7qUctfZhB6gzFpVYBulssyr8IqHOjphq2c75JUDlXfiG
         /lyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Sg+dQZFntDVJjZHVt/ax53H+d64a++kviqvjLQ7x4oBwj8lP8G6i75Da1c5ypagF7PPtYWrSHKSZ8V2dlOPF@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkvoAY4GLRCkwf4zHXocmbMaTHoLhi8XPsjhBhrf4WbY3Q286
	nOB+Iv+/DGCh+u52NvE69EFoWhaBtUcfqOusfupwHP0VRo4/I5uM5R3Qcuy2Ew2UVYgAZzfyjY4
	TQ+G5vfs58whij8TXiFYoY2gv9wP1WupSw9pFiznHq29d10tsrhICtitOp6U=
X-Gm-Gg: ASbGncsbqADUcCYXwdZT5zNIjRzK3nockUCALGtIQi6l3bpqFMNokhv7bO32NotIQaC
	RLZI267XsBcUQNdR9JiU6QQ7goOUlaRVz/OhU5XQLDtzQqzYvnWLJrmXa4R7liTAEZ4VcBlMN1i
	qOI1mg93b0bGVQblzjtnSDiEHbBXDm1iM4eQpQ919CaiRB+6OTQk1/vL2x5WHs7L/yYCU8QJqyR
	I1i1AEwhdZjTzptr8BihxGrMa/hLAL31UNzHga6hqcMxbQ4iAKVFoXieugO/fFP2qcvj9b2NqY2
	RDEPeb5bKxfEIdTDnJptKb1qLg==
X-Google-Smtp-Source: AGHT+IFra1fdE04Ait94R+eZT31ZuuQLHYRbKdWcXv8S35gzzcNWaENqSRSFfbq/LOUN3qwbEsEI9RY0t8eaM9dbcIU=
X-Received: by 2002:a17:903:2345:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-29dd184c356mr1839625ad.10.1764955004566; Fri, 05 Dec 2025
 09:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com>
 <20251204-perf_fix_syscall_header-v1-2-b8e27f74ed6a@arm.com>
 <CAP-5=fV-d_X1uFYACEOJOxOY43+fj9aEm0_bp7NGSo9kZVMJ4Q@mail.gmail.com> <20251205162147.GR724103@e132581.arm.com>
In-Reply-To: <20251205162147.GR724103@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Dec 2025 09:16:32 -0800
X-Gm-Features: AWmQ_bmoDgU9UIBznBrm1oMoQSsSLFBfzXPatb9epvdQ1bC2Jid6qZ0b2vBIOGk
Message-ID: <CAP-5=fW3ZVfTU-=3WJny6KuD+DC7fzNzAehUscztr8Zhhfwrmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "perf tools: Fix arm64 build by generating unistd_64.h"
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:21=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Thu, Dec 04, 2025 at 10:19:59AM -0800, Ian Rogers wrote:
> > On Thu, Dec 4, 2025 at 8:53=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
> > >
> > > This reverts:
> > >
> > > commit 8988c4b91945 ("perf tools: Fix in-source libperf build")
> > > commit bfb713ea53c7 ("perf tools: Fix arm64 build by generating unist=
d_64.h")
> > >
> > > Since we now have a static unistd_64.h for the arm64 build, there is =
no
> > > need to generate unistd_64.h in libperf.  Revert all patches related =
to
> > > generating unistd_64.h.
> >
> > Could we generate the file and then compare the two? We do something
> > like this for empty-pmu-events.c here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n49
> >
> > Similarly, could we get rid of the unistd_64.h generation and just add
> > a build time validation test? Generating the file is painful in many
> > ways, as this series testifies.
>
> Thanks for suggestions!
>
> I had a question: why we need to maintain unistd.h particually in
> ./tools folder?  This header is a standard C header and should be
> provided by toolchain instead.  Due to multiple copies, it is a bit mess
> the programs might include unpurposed one.
>
> I went through the history and found:
>
>   commit 34b009cfde2b ("tools include: Grab copies of arm64 dependent uni=
std.h files")
>
> It introduces the header unistd.h for generating system call table.
>
> Afterwards,
>
>   commit cb8197db8c09 ("perf tools arm64: Use syscall table")
>
> unistd.h headers are not used to generate syscall table anymore.  Since
> then, syscall tables are maintained in
> tools/perf/arch/*/entry/syscalls/syscall*.tbl for each arch.
>
> To verify this, I did a quick try with removing x86 and arm64 headers:
>
>   tools/arch/arm64/include/uapi/asm/unistd.h
>   tools/arch/x86/include/uapi/asm/unistd.h
>   tools/arch/x86/include/uapi/asm/unistd_32.h
>   tools/arch/x86/include/uapi/asm/unistd_64.h
>
> I run the linux-tools-container-builds and confirmed all x86 and arm64
> building tests pass and did not see any failure.
>
> For a neat fix, I think we can remove all unistd.h headers:
>
>   $ ls tools/arch/*/include/uapi/asm/unistd*
>   tools/arch/arc/include/uapi/asm/unistd.h
>   tools/arch/hexagon/include/uapi/asm/unistd.h
>   tools/arch/riscv/include/uapi/asm/unistd.h
>   tools/arch/x86/include/uapi/asm/unistd_64.h
>   tools/arch/arm64/include/uapi/asm/unistd.h
>   tools/arch/loongarch/include/uapi/asm/unistd.h
>   tools/arch/x86/include/uapi/asm/unistd_32.h
>   tools/arch/x86/include/uapi/asm/unistd.h
>
> Any concern?  I would get maintainers's confirmation before proceeding.

Thanks Leo! The tools/include directory is a concern for me as the use
of it is pretty unstructured. For example, what does <linux/types.h>
refer to? In the perf build it is actually the kernel version of
types.h rather than the UAPI version, despite perf being a user land
tool. In general this is necessary to get other kernel headers to work
(say list.h). I think it brings about a number of concerns, one being
around licensing. My preference would be to make tools/include an
explicit dependency, like libperf and libsubcmd. It would have
associated header files you could install and depend upon, placing
those header files onto your include path from the install directory.
Things in tools/include with different licenses can have different lib
variants so that it is clear what license is being linked against -
generally GPLv2 vs GPLv2+linux syscall exception.

Given that we're mixing kernel and UAPI headers there is a need for
the headers to be hermetic. We can't just use parts of headers from
the kernel, some from UAPI, some from the latest kernel tree and some
from whatever libc is on the system. There are differences in the use
of things like u64 vs __u64 that will all too easily give build
errors, especially when building against an older libc.

Arnaldo did make some moves to clean up tools/include with patches like:
https://lore.kernel.org/lkml/Ze93VPYpegMMt5kk@x1/
That mention a breakage I caused ARM64/James around tools/include (I
mention the library idea above again, sorry I'm a broken record):
https://lore.kernel.org/lkml/CAP-5=3DfWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yr=
SSA-otQ@mail.gmail.com/
I think the breakage shows things need to be hermetic, which may mean
we need unistd_64.h. I think Arnaldo's moving of fs.h shows that less
in the tools/include directory is better and supported by the
maintainers.

Thanks for doing the build testing! Doing a simpler grep:
```
$ grep -r "asm/unistd" tools/include tools/perf tools/lib
tools/perf/check-headers.sh:  "arch/x86/include/uapi/asm/unistd.h"
tools/perf/check-headers.sh:  "arch/arm64/include/uapi/asm/unistd.h"
tools/lib/bpf/bpf.c:#include <asm/unistd.h>
tools/lib/bpf/libbpf.c:#include <asm/unistd.h>
```
I think unistd.h is needed to make things hermetic for libbpf :-( If
we can make libbpf use just the regular unistd.h then life would be
good. My experience is that libbpf tends to like the kernel way of
doing things a bit too much - <rant>they have the IS_ERR/ERR_PTR
antipattern rather than just using errno, as because you know this is
user land and that's how stuff normally gets done and we can make
pointers type safe. Also don't try adding comments to their syscall
APIs unless you enjoy being called "wrong" a lot with no constructive
feedback. </rant>. Anyway, I think getting rid of unistd.h is a good
thing but it will probably break perf's build that invokes libbpf's
build because libbpf will be mixing kernel and old libc headers on one
of the maintainers build test platforms (likely an old one) where the
type collisions yield compile time errors. To avoid that I'd suggest
making libbpf not use asm/unistd.h as a first step. We could get lucky
with something non-hermetic, but it wouldn't be my preference.

Thanks,
Ian

> Thanks,
> Leo
