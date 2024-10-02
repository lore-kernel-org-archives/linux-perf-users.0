Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8623BB
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832718; cv=none; b=f+nreP0Jp93/wcWWUxTMbVAFrtHiNiI9n6pgFbSuDYF/nrZdsSQN99Z184yQRNfyxgovyDjFWCTtGBPDUB3F6A8fzGHg9RlRNVuT/2u7STh7GCVRtyCZ5rCHLhRy4LzAZJi2G5QXWgc2a0eGgxVJP+UxvfkzBHbOMx/tquq/xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832718; c=relaxed/simple;
	bh=h9fNixfJu1XiFqknMoC8M1ON+BvU5wmumZzRXi0l2Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPvniDk7slFdXSgpSg8WMAxeN6HQj07OpC7ebsJzRDlDFO95mvMEUX8GAcXUr+RvEd5ZvNODNvo4PoK22YBPpaiRgG6yNjyLe9ccEtaZnxCHQ/AtRCehhZEYqmLdelStttoYI3NEgFcAtDz941cXmWtjs6cPdgdss+eHZu3HGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dD3c6/Jv; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dD3c6/Jv"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so56055ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727832715; x=1728437515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHA2QnFgl8YZfRfy0oLQ6QiKpqcvbJT8o1WiZbiEx4s=;
        b=dD3c6/JvY79xtA1XA7zYWxFmTxAUfHE9StcriwcvqM37NSelDRIbdR4N5za6Si6tL9
         hXN8PnoJbjUK14OpaYz6Z2nUmpBSSL2EIVN+BAEX0IB6M3wgkxkngpnM2UYBTvNYJOXQ
         /6eAY+0gqxe4wqUDhQpz4srxAYd6fojn+dlSKDif++aissa3p8IabBgFtHOYoAQELH30
         1fMQuJRETwWAFQdVOj7HERcbwGGLnIF03ECYcZEm1NCd3b72L5rA+nfKmFc/LXd0HWWj
         WJNQkcHM107eXn9/AvEuL8MI6AlNyOyGDYMeDAIHMTWqr5j2MRJ4EziFWr4FTr98Rrq0
         WP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832715; x=1728437515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHA2QnFgl8YZfRfy0oLQ6QiKpqcvbJT8o1WiZbiEx4s=;
        b=WuNRFGFb0/dFGAuDlY1YtGrxa8bqHVLwRccfAWrxg0bJEzR0mhfG/MGg7tBBirwWDu
         7XA1/GPQnQOX7wH0dkhGQgg0BfVoZJj3Fnm6cIpeoAhUrr/dri78m08lreqfCCEMhxME
         OQ9RZcm66BMOP+mGxhPkaOmPUxPjXhVeVO8Hzh0lvETw6Bz9DGS9FNVWoT3GEhmK5lYp
         AuOM4FcuKKU+GVPDeGkVPf/NbO2XuuEFv0UqPzjgTm6XNmpdG/6KsDdMiNbhN6SB0t6y
         EVlj6TVYi5kevJwr6LSFApIEPISvYlQAwXN6Czuesy1lw8ke4LQGd3f/vZpC0ErSlcgV
         O0YA==
X-Forwarded-Encrypted: i=1; AJvYcCVDzHriRBIn0haBQ5EW4KHQG089Eh1MCZLTGH24GvGZwHTQfRizCtkHtsj9qcc/7XKd11/4U+cz0RzNEyvGJqvE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kzLz6yelssljqg6BI78GLxN50Gr69kEgOgnfUeD5RScY+pLl
	yr2tCEbOBr6iYgJWrfgf5QpP05HW9ojZ4od3ndk8517nI+pcSMdd6XuJ1O6nv6furL5taiEQlz5
	GkbgfDmaK7zLTasuelcUGBhoYrJ+w8plrjJ+p
X-Google-Smtp-Source: AGHT+IHN5Pw8wYtFeHFJ4DDU+xLGFzS9sQmhI5Tce9Dj/vDQsPw6NkgnyCyM4tgMtxG9yWDCR9iydlyyxHZvh3aGi7Q=
X-Received: by 2002:a05:6e02:1feb:b0:39e:68d8:2891 with SMTP id
 e9e14a558f8ab-3a365f72af8mr1932815ab.6.1727832714882; Tue, 01 Oct 2024
 18:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com> <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
 <ZvW4iZpTinJKWIFD@google.com> <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
 <ZvbocHwtPkwJwDOA@google.com> <CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
 <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org> <CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
 <ZvyBQ6xgGE4gZdoo@google.com> <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
 <20241002082859.8821e441024fe873a4301afc@kernel.org>
In-Reply-To: <20241002082859.8821e441024fe873a4301afc@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 18:31:43 -0700
Message-ID: <CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Tue, Oct 1, 2024 at 4:29=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 1 Oct 2024 16:17:34 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > On Tue, Oct 1, 2024 at 4:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Mon, Sep 30, 2024 at 09:02:36PM -0700, Ian Rogers wrote:
> > > > On Sat, Sep 28, 2024 at 7:35=E2=80=AFPM Masami Hiramatsu <mhiramat@=
kernel.org> wrote:
> > > > >
> > > > > On Fri, 27 Sep 2024 11:15:21 -0700
> > > > > Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > > On Fri, Sep 27, 2024 at 10:16=E2=80=AFAM Namhyung Kim <namhyung=
@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > > > > > > > On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <namh=
yung@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrot=
e:
> > > > > > > > > > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <n=
amhyung@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers =
wrote:
> > > > > > > > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw sup=
port. Rename to
> > > > > > > > > > > > make it clearer there is a libdw connection.
> > > > > > > > > > >
> > > > > > > > > > > While it only covers libdw, I think the idea of this =
macro is whether
> > > > > > > > > > > the arch has register mappings defined in DWARF stand=
ard.  So I think
> > > > > > > > > > > it's better to keep the name for this case.
> > > > > > > > > >
> > > > > > > > > > How can the dwarf standard exist for an arch but not de=
fine registers?
> > > > > > > > >
> > > > > > > > > I meant it's about the arch code in the perf tools to hav=
e the mapping,
> > > > > > > > > not the DWARF standard itself.
> > > > > > > >
> > > > > > > > But we guard those definitions behind having libdw:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-t=
ools-next.git/tree/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
> > > > > > > > So we only have the regs if libdw is present, not if dwarf =
is in use
> > > > > > > > for libunwind/libdw. Hence wanting to be specific that they=
 are just a
> > > > > > > > libdw and not a dwarf thing. Trying to use the regs in libu=
nwind code
> > > > > > > > would be broken. That could change but I wanted to make the=
 code clear
> > > > > > > > for the way things are at the moment.
> > > > > > >
> > > > > > > I understand your point but calling it LIBDW_REGS looks unnat=
ural to me.
> > > > > >
> > > > > > I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF=
_REGS
> > > > > > in libunwind code but you are to some how know that the code on=
ly had
> > > > > > meaning if libdw was present? I don't like the implication that=
 DWARF
> > > > > > means LIBDW as throughout the code it doesn't. I think the name
> > > > > > PERF_HAVE_LIBDW_REGS better captures how the code is, makes the=
 code
> > > > > > more intention revealing and so readable, etc.
> > > > >
> > > > > I agree with Namhyung this point. dwarf-regs is defined only by t=
he
> > > > > DWARF standard, not libdw only. The standard encode registers by =
a digit
> > > > > number and the dwarf-regs decode the number to actual register na=
me.
> > > >
> > > > The code is not making a statement about the DWARF standard, take a=
rch/csky:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/arch/csky/Makefile?h=3Dperf-tools-next
> > > > ```
> > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > ifndef NO_DWARF
> > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > endif
> > > > ```
> > > > in the patch series NO_DWARF becomes NO_LIBDW, so it is now:
> > > > ```
> > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > ifndef NO_LIBDW
> > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > endif
> > > > ```
> > > > So the Makefile says that PERF_HAVE_DWARF_REGS is dependent on havi=
ng
> > > > NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS is defi=
ned
> > > > for csky.
> > >
> > > I think this is totally fine and we can change the condition later if
> > > needed.
> > >
> > > After all, I don't think it's a big deal.  Let's just call DWARF
> > > registers DWARF_REGS. :)
> >
> > The define is called PERF_HAVE_DWARF_REGS, notice the HAVE, but we're
> > not setting it while supporting call-graph dwarf with libunwind. It is
> > actively confusing.
>
> Does libunwind requires the dwarf regs? I think the dwarf regs informatio=
n
> is only needed for analyzing dwarf register assignment, not stack unwindi=
ng.

So you are saying the #define is guarding a libdw feature?
perf record/report --call-graph=3Ddwarf is supported with either libdw
or libunwind. The dwarf support in the tool may come from more sources
hence wanting in this patch set to be clear what variable is guarding
what. PERF_HAVE_DWARF_REGS is set to 1 for a specific set of
architectures and only when libdw is present. The variable is saying
that libdw supports the notion of registers needed for the #define
HAVE_DWARF_SUPPORT that patch 9 in the series renamed to
HAVE_LIBDW_SUPPORT. So I want the makefile variable
PERF_HAVE_LIBDW_REGS to guard the #define HAVE_LIBDW_SUPPORT, rather
than what is being argued by yourself and Namhyung that the #define
HAVE_LIBDW_SUPPORT be guarded by a variable called
PERF_HAVE_DWARF_REGS and that is only set when NO_LIBDW isn't set.
We've made a digression into the name dwarf for a reason I can't
fathom, at best it is inconsistent. Having dwarf registers is like
having a bright sun or numeric numbers, it is a truism (playing devils
advocate maybe if there were an ELF file format for postscript we
could have a dwarf specification without registers). Anyway, I'm
trying to connect the dots that libdw support controls the libdw type
variables and defines hence not wanting 10 out of 11 patches applied.

Thanks,
Ian

> Thank you,
>
> >
> > Thanks,
> > Ian
> >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Dwarf in the code base implies libdw, libunwind and potentially oth=
er
> > > > dwarf capable things like llvm. If we don't have libdw then NO_LIBD=
W
> > > > will be set and PERF_HAVE_DWARF_REGS won't be set. That is the more
> > > > general dwarf thing will not be set because of missing libdw. This
> > > > goes contrary to wanting this to be true whenever a dwarf thing is
> > > > present - something that reflecting what the standard says would
> > > > achieve.
> > > >
> > > > In the code base right now PERF_HAVE_DWARF_REGS isn't a dwarf
> > > > dependent thing, it is a libdw dependent thing, this is why
> > > > PERF_HAVE_LIBDW_REGS is a more intention revealing name as it makes
> > > > the connection explicit.
> > > >
> > > > We could change the code so that in Makefile.config we set somethin=
g like:
> > > > ```
> > > > ...
> > > > ifndef NO_LIBDW
> > > >   PERF_HAVE_DWARF :=3D 1
> > > > ...
> > > > ```
> > > > and in the arch/.../Makefiles change them to be:
> > > > ```
> > > > if PERF_HAVE_DWARF
> > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > endif
> > > > ```
> > > > but this is going beyond the clean up this patch series was trying =
to
> > > > achieve. I also don't know of an architecture where dwarf is presen=
t
> > > > but registers are not, so having a definition for this case feels
> > > > redundant.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > Actually, there is a histrical reason I had called it is DWARF. I=
 used to
> > > > > use "libdwarf", and switched to "libdw" for required features. So=
 I know
> > > > > there are more than 1 implementation of DWARF library, and the li=
bdwarf
> > > > > also uses the same operation number because it depends on the sam=
e standard.
> > > > >
> > > > > https://github.com/davea42/libdwarf-code/blob/main/src/lib/libdwa=
rf/dwarf.h#L809
> > > > >
> > > > > So I think we'd better keep it call as DWARF_REGS.
> > > > >
> > > > > Thank you,
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
