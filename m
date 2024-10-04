Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C291862
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003512; cv=none; b=E3z0Tx3UAxUDvBen0J6sbTBtYAUANDkAgPigqCkDporygxR2zv0gGBBL48OyzWTiR1hpYwZPjeBpZcjchWkzHWvIaLz4AaGHRxac3DiZFtAA0kUpIwkHD6wS2dsPUy18LE9zUZySjAV3qVKtzJsGHUEVCa1HvnnQ5GTDp1PEfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003512; c=relaxed/simple;
	bh=3+Gn4L3uIUxiHJvpmUPReJDduHXiPIypvMki7PnnUiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJQpp0Ia5E6dFTZALyf+57+p0uDH2RxSChEKCGsBCKArixmEDuxx3jmeR1+6ycBJo/VQypaeYOq0YlQPKvoed8u5xR+t/w5s/8kkE+VdisFYDmwYYPZdq77r22yirkCVlujRFmbmvyiYzBU1FO8B2xUYb7AVS0HVU0kRBTIrKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkX9FcqZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkX9FcqZ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45b4e638a9aso81311cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Oct 2024 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728003509; x=1728608309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR2vrV6Y62eMGmrzKTFLNbpnLrTyou+rMJibjWpup+w=;
        b=PkX9FcqZdwCVaYHvYChrGvI/48jMnYZ3cceDtLZnKjfdrbRr+9ckoDL53A7buZS1/h
         5WiRdFH5Yfr1gNmCYS8R972/fjpuT8oG8VQmaHM7K1G5LkgBmBY/ljTXgQrmRXkCLTLF
         CxFHEa3hxyLuBcR7VtdqC3vY9L4ZbK/zOvAd+1BjkFt1FVMGFcmX5CfM5MNsXDyQEz8e
         B9LN4w9IE7qMQqTu+Z9QP5jV6Q5hwirSCQxN5CxNtaZycsMIdEjfg2Qh5blSM4KnPs3u
         vMgndP3s6E6Lfy720NMSz+v7GrQ1cKBUSHqEiKzwG02oC742F7wrazxVXMbuLOVanO7F
         rPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728003509; x=1728608309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR2vrV6Y62eMGmrzKTFLNbpnLrTyou+rMJibjWpup+w=;
        b=Ory9f/9EZm4dv8YlQulRxHaIj1phqC8tHhgzdxF+ytzK57ItXnhU4lV8rxo2j+Za3D
         Q7Ri1YUl2YOlGdV54/eJglwNpxKEy11SdqOkL78Vjc7f1DSqrTOI4yQP8DoflzF/jtr0
         k3rze28dHhcl/Q37lwawP5MffD+vuBp3RS0WtQlNIDYCrXC6/VqG97594Ndp0s4n7kiB
         RXsVgJJYfPhlto8l9WYXiIw68kuSmJfJ9ANXQfaL7YMgVtI70ZDDRk/RlHpP+nzdT8Ip
         kN0qQDXJKAgkdScJQjpPxrAWHYkhTfyHRLelhVmpCIMBEUVMcJm90Dqs73i2YcR4XDdG
         CRiw==
X-Forwarded-Encrypted: i=1; AJvYcCUc5HkuctDyZDBmObziRDpESSg8M81ALzESPhdTa1pt/jfj35B7ZuO8qhp5REn/B4jrEKP/pKXgMo5El194TXVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6mepNm60NLq8X/ywfcEVG4cFvWwzOKcsovoxH9xP9h/Q3QcS
	9HM6b7cKCNx9M6+gLSr2bdAXpixE8W+1q3T7FH2WN57l1vRXM26BWoEo4kEAN4t2U3i2tnDZKBe
	H5ziy8lbqHkKmeN4ew5r6uK0a0aXVAFyy7A0w
X-Google-Smtp-Source: AGHT+IH760nJk4XuPt/E2avdOUblte2mJFfQ1ZzVclNec6L6k2y2ub3Qo5x69XSy0siJ1ZwZKAbnVfgMcvjc2FDZYI4=
X-Received: by 2002:ac8:648e:0:b0:447:e423:a463 with SMTP id
 d75a77b69052e-45d9df5d38dmr516911cf.3.1728003508498; Thu, 03 Oct 2024
 17:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvbocHwtPkwJwDOA@google.com> <CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
 <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org> <CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
 <ZvyBQ6xgGE4gZdoo@google.com> <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
 <20241002082859.8821e441024fe873a4301afc@kernel.org> <CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
 <20241002225614.774bdd0742a826557f142d0e@kernel.org> <CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>
 <Zv8fIh4jaY7QbeDZ@google.com>
In-Reply-To: <Zv8fIh4jaY7QbeDZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Oct 2024 17:58:13 -0700
Message-ID: <CAP-5=fVvzNMDPUpAvK0itjG0ZptrSg-_BN3t6UwB4XAvSsDt8w@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>, 
	Dima Kogan <dima@secretsauce.net>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Oct 02, 2024 at 07:27:16AM -0700, Ian Rogers wrote:
> > On Wed, Oct 2, 2024 at 6:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> > >
> > > On Tue, 1 Oct 2024 18:31:43 -0700
> > > Ian Rogers <irogers@google.com> wrote:
> > >
> > > > On Tue, Oct 1, 2024 at 4:29=E2=80=AFPM Masami Hiramatsu <mhiramat@k=
ernel.org> wrote:
> > > > >
> > > > > On Tue, 1 Oct 2024 16:17:34 -0700
> > > > > Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > > On Tue, Oct 1, 2024 at 4:10=E2=80=AFPM Namhyung Kim <namhyung@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 30, 2024 at 09:02:36PM -0700, Ian Rogers wrote:
> > > > > > > > On Sat, Sep 28, 2024 at 7:35=E2=80=AFPM Masami Hiramatsu <m=
hiramat@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 27 Sep 2024 11:15:21 -0700
> > > > > > > > > Ian Rogers <irogers@google.com> wrote:
> > > > > > > > >
> > > > > > > > > > On Fri, Sep 27, 2024 at 10:16=E2=80=AFAM Namhyung Kim <=
namhyung@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers =
wrote:
> > > > > > > > > > > > On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung K=
im <namhyung@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rog=
ers wrote:
> > > > > > > > > > > > > > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyun=
g Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian=
 Rogers wrote:
> > > > > > > > > > > > > > > > The name dwarf can imply libunwind support,=
 whereas
> > > > > > > > > > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with l=
ibdw support. Rename to
> > > > > > > > > > > > > > > > make it clearer there is a libdw connection=
.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > While it only covers libdw, I think the idea =
of this macro is whether
> > > > > > > > > > > > > > > the arch has register mappings defined in DWA=
RF standard.  So I think
> > > > > > > > > > > > > > > it's better to keep the name for this case.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > How can the dwarf standard exist for an arch bu=
t not define registers?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I meant it's about the arch code in the perf tool=
s to have the mapping,
> > > > > > > > > > > > > not the DWARF standard itself.
> > > > > > > > > > > >
> > > > > > > > > > > > But we guard those definitions behind having libdw:
> > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/per=
f/perf-tools-next.git/tree/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next=
#n3
> > > > > > > > > > > > So we only have the regs if libdw is present, not i=
f dwarf is in use
> > > > > > > > > > > > for libunwind/libdw. Hence wanting to be specific t=
hat they are just a
> > > > > > > > > > > > libdw and not a dwarf thing. Trying to use the regs=
 in libunwind code
> > > > > > > > > > > > would be broken. That could change but I wanted to =
make the code clear
> > > > > > > > > > > > for the way things are at the moment.
> > > > > > > > > > >
> > > > > > > > > > > I understand your point but calling it LIBDW_REGS loo=
ks unnatural to me.
> > > > > > > > > >
> > > > > > > > > > I don't follow. Wouldn't it be unnatural to see PERF_HA=
VE_DWARF_REGS
> > > > > > > > > > in libunwind code but you are to some how know that the=
 code only had
> > > > > > > > > > meaning if libdw was present? I don't like the implicat=
ion that DWARF
> > > > > > > > > > means LIBDW as throughout the code it doesn't. I think =
the name
> > > > > > > > > > PERF_HAVE_LIBDW_REGS better captures how the code is, m=
akes the code
> > > > > > > > > > more intention revealing and so readable, etc.
> > > > > > > > >
> > > > > > > > > I agree with Namhyung this point. dwarf-regs is defined o=
nly by the
> > > > > > > > > DWARF standard, not libdw only. The standard encode regis=
ters by a digit
> > > > > > > > > number and the dwarf-regs decode the number to actual reg=
ister name.
> > > > > > > >
> > > > > > > > The code is not making a statement about the DWARF standard=
, take arch/csky:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-t=
ools-next.git/tree/tools/perf/arch/csky/Makefile?h=3Dperf-tools-next
> > > > > > > > ```
> > > > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > > > > ifndef NO_DWARF
> > > > > > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > > > > > endif
> > > > > > > > ```
> > > > > > > > in the patch series NO_DWARF becomes NO_LIBDW, so it is now=
:
> > > > > > > > ```
> > > > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > > > > ifndef NO_LIBDW
> > > > > > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > > > > > endif
> > > > > > > > ```
> > > > > > > > So the Makefile says that PERF_HAVE_DWARF_REGS is dependent=
 on having
> > > > > > > > NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS=
 is defined
> > > > > > > > for csky.
> > > > > > >
> > > > > > > I think this is totally fine and we can change the condition =
later if
> > > > > > > needed.
> > > > > > >
> > > > > > > After all, I don't think it's a big deal.  Let's just call DW=
ARF
> > > > > > > registers DWARF_REGS. :)
> > > > > >
> > > > > > The define is called PERF_HAVE_DWARF_REGS, notice the HAVE, but=
 we're
> > > > > > not setting it while supporting call-graph dwarf with libunwind=
. It is
> > > > > > actively confusing.
> > > > >
> > > > > Does libunwind requires the dwarf regs? I think the dwarf regs in=
formation
> > > > > is only needed for analyzing dwarf register assignment, not stack=
 unwinding.
> > > >
> > > > So you are saying the #define is guarding a libdw feature?
> > > > perf record/report --call-graph=3Ddwarf is supported with either li=
bdw
> > > > or libunwind. The dwarf support in the tool may come from more sour=
ces
> > > > hence wanting in this patch set to be clear what variable is guardi=
ng
> > > > what. PERF_HAVE_DWARF_REGS is set to 1 for a specific set of
> > > > architectures and only when libdw is present. The variable is sayin=
g
> > > > that libdw supports the notion of registers needed for the #define
> > > > HAVE_DWARF_SUPPORT that patch 9 in the series renamed to
> > > > HAVE_LIBDW_SUPPORT. So I want the makefile variable
> > > > PERF_HAVE_LIBDW_REGS to guard the #define HAVE_LIBDW_SUPPORT, rathe=
r
> > > > than what is being argued by yourself and Namhyung that the #define
> > > > HAVE_LIBDW_SUPPORT be guarded by a variable called
> > > > PERF_HAVE_DWARF_REGS and that is only set when NO_LIBDW isn't set.
> > >
> > > It will be only used with the libdw, but I don't care.
> > > "HAVE_DWARF_REG" (internal config, just indicates the arch implemente=
d
> > > feature) simply means there is `arch/XXX/util/dwarf-regs.c`.
> > > Also the APIs provided by the dwarf-regs.c are still based on DWARF
> > > standard, which defines registers by number like DW_OP_reg[0-31].
> > > So the mapping of these suffix number and actual register must be
> > > defined for each architecture.
> > >
> > > That is why I had introduced dwarf-regs.c and call it "dwarf"-regs.
> > > Even if the implementation depends on libdw, this dwarf-regs.c is
> > > still based on DWARF standard.
> >
> > You seem to be missing the point of the series which is to clean up
> > inconsistencies where dwarf is used to mean libdw. Here we have libdw
> > guarding a #define with DWARF in the name, it should have libdw in the
> > name as the patch cleans up. This is a coding thing and not a dwarf
> > specificatin thing.
> >
> > > > We've made a digression into the name dwarf for a reason I can't
> > > > fathom, at best it is inconsistent. Having dwarf registers is like
> > > > having a bright sun or numeric numbers, it is a truism (playing dev=
ils
> > > > advocate maybe if there were an ELF file format for postscript we
> > > > could have a dwarf specification without registers). Anyway, I'm
> > > > trying to connect the dots that libdw support controls the libdw ty=
pe
> > > > variables and defines hence not wanting 10 out of 11 patches applie=
d.
> > >
> > > Oh, wait, I think we can apply other patches. I just don't like this
> > > patch. I think the other patches are good. But this is
> >
> > Then we are intentionally aiming to be inconsistent, with libdw
> > meaning dwarf with a #define that just states a truism. Arguably the
> > code is better with none of the series applied.
>
> I agree renaming libdw-specific parts.  But the register is for DWARF,
> not libdw even if it's currently used by libdw only.   So I don't want
> to rename it.

So your objection is that we have files called:
tools/perf/arch/*/util/dwarf-regs.c
and PERF_HAVE_DRWARF_REGS is an indication that this file exists. This
file declares a single get_arch_regnum function. The building of the
file after this series is:
perf-util-$(CONFIG_LIBDW)     +=3D dwarf-regs.o

My objection is that PERF_HAVE_DWARF_REGS is controlling the #define
HAVE_LIBDW_SUPPORT, so dwarf (that can mean libunwind, libdw, etc.) is
guarding having libdw which is backward and part of what this series
has been trying to clean up.

If we rename tools/perf/arch/*/util/dwarf-regs.c to
tools/perf/arch/*/util/libdw-helpers.c the PERF_HAVE_DWARF_REGS can be
renamed to PERF_HAVE_LIBDW_HELPERS to align. Then
PERF_HAVE_LIBDW_HELPERS guarding the #define PERF_HAVE_LIBDW makes
sense to me and I think we achieve the filename alignment you are
looking for.

Yes get_arch_regnum could make sense out of libdw and needn't just be
a helper for it, but let's worry about that when there's a need.
What's confusing at the moment is does libdw provide dwarf support,
which I'd say is expected, or does dwarf provide libdw support?

Thanks,
Ian
