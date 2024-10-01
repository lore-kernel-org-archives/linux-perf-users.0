Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB74A5F
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727755374; cv=none; b=On3VVF9vP19sbx8R0SU7mEMbEWxYBCoVbw6nSO92xrcm0b7ZMLlQ8iYtPx2hPxX3Pam00HT4F7m7HaWm/c1LPwW4UxbnzkRe1R0NcDqY00luaF+Is2OI0uuJyEGiMVAivHdIYLwR/CK2mxRPnRQnhObqZ0Tqop9bh+CFLaDdYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727755374; c=relaxed/simple;
	bh=f6E6T/xbDW+AREQa2nYBAzHcDbQaseyBERQzPrkRDsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ7alB6RSCzKeD+vau2Ut43VRiH0+aNNXK1KOSOl3QvgIZRVNRdbcGaAHKpFt3dB1phA004PBMYgfTi2qS8FhqVmysLGVHNX3zJtWYqztwkSiHNyn99S2CXfR1OlcHQKevIu1UQPTKpcKRP8cBTFZ8D4yc73yufhaoJtsXD3Osc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVjHs7/S; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVjHs7/S"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b3d1a77bbso111615ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 21:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727755372; x=1728360172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTRBpY62cGIaCiYfv+fHgPBlCl5eNDCdAMEWIVrc83A=;
        b=hVjHs7/ShUblB0+6kw02WgPwjyG2k6QyGciNQwgPhaXtGJYlU6dcexafzkI/xcjINy
         QN4JiS8IXYQtTSLAicixfwW6UG5PfLNZde9ND11SEuR8r4uPWRfqxvOK0hwvrwAbSPtm
         2fpszd+ERI+R2Vex/Ve5P+drBB1RR/aFW/dDQjPb+2gpc2VYGo/VMK2V+F+Am7N6ukqQ
         ou6k2bCX302eRqiQldb1fgJNADBEhaHZm7sr9n4JBtcALQ6QJ2rV7l0cSV065A7JCAMz
         0VeNXFzrFRV7HR4auLO9Yfr5PZrU6Nk6pdl6a/W6Q8636YJlHdArLvd5+1BUfEW9GfaC
         wKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727755372; x=1728360172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTRBpY62cGIaCiYfv+fHgPBlCl5eNDCdAMEWIVrc83A=;
        b=CnlzVoEjS5dqSRMcDbT1qJVjo2mzmuqx126fa6qP4ktvQyIHSzXtlORUCN6n25r+DI
         BXe919mEOXNiD0l7buV9EtcsA/U9FVJR/wIykwByTy8KzNODxHYQRc3i7xuUCTDUXrCV
         jDpw6rKLdawFQFf6tSwywWW0MA9pafUaODW/6D/FxYDCwmNlIfmIKyvytV4iK6lD2wav
         fWcB7c2EHmAEKYXSECpUum6DOnelVbOMi+cQEob55QyoUls1Vd0t4mb8DKBblBg0Fgw1
         DRfwVrPhuZK7J6IrH2NzjTg0Hmvj1OQCql0DR0hUsqE/wSlAm08koK+jOPTLWg3T8aXe
         o2lA==
X-Forwarded-Encrypted: i=1; AJvYcCWMW2M9S6LciHAc8qzu+C7irN/EZg3JWYuIoMH48n91c+j1lQ8NhaWe9p0l9aP5m5csbMem6zRPXgN3sacxjrNb@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAMbx5GxTpI50ch9FIGXXn+EyHbT7U7qZkQyiIT4lPcGj27Wo
	MQ1bt+sA9aC/hug6EuiR6KEwGImpysdnMFjHY9PhBZvAGhBSqwVXDkPxZJ9AE3Zl3/MCLIqg/XQ
	gxzuYLzYgljmSAmQRechta4QQY/Em0jDthqLk
X-Google-Smtp-Source: AGHT+IHcOhg1eTvqLxOLm/LvDvlI1V+MvjBigviHx5BnGyDe7kNjG3NbWO1B5p/U3gkTeMqgh6SzSFGgOjI2IsaV87M=
X-Received: by 2002:a17:903:283:b0:20b:13a8:9f86 with SMTP id
 d9443c01a7336-20bad44e1camr1802145ad.28.1727755371468; Mon, 30 Sep 2024
 21:02:51 -0700 (PDT)
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
 <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
In-Reply-To: <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Sep 2024 21:02:36 -0700
Message-ID: <CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
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

On Sat, Sep 28, 2024 at 7:35=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 27 Sep 2024 11:15:21 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > On Fri, Sep 27, 2024 at 10:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > > > On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > > > > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhyung@=
kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Re=
name to
> > > > > > > > make it clearer there is a libdw connection.
> > > > > > >
> > > > > > > While it only covers libdw, I think the idea of this macro is=
 whether
> > > > > > > the arch has register mappings defined in DWARF standard.  So=
 I think
> > > > > > > it's better to keep the name for this case.
> > > > > >
> > > > > > How can the dwarf standard exist for an arch but not define reg=
isters?
> > > > >
> > > > > I meant it's about the arch code in the perf tools to have the ma=
pping,
> > > > > not the DWARF standard itself.
> > > >
> > > > But we guard those definitions behind having libdw:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
> > > > So we only have the regs if libdw is present, not if dwarf is in us=
e
> > > > for libunwind/libdw. Hence wanting to be specific that they are jus=
t a
> > > > libdw and not a dwarf thing. Trying to use the regs in libunwind co=
de
> > > > would be broken. That could change but I wanted to make the code cl=
ear
> > > > for the way things are at the moment.
> > >
> > > I understand your point but calling it LIBDW_REGS looks unnatural to =
me.
> >
> > I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF_REGS
> > in libunwind code but you are to some how know that the code only had
> > meaning if libdw was present? I don't like the implication that DWARF
> > means LIBDW as throughout the code it doesn't. I think the name
> > PERF_HAVE_LIBDW_REGS better captures how the code is, makes the code
> > more intention revealing and so readable, etc.
>
> I agree with Namhyung this point. dwarf-regs is defined only by the
> DWARF standard, not libdw only. The standard encode registers by a digit
> number and the dwarf-regs decode the number to actual register name.

The code is not making a statement about the DWARF standard, take arch/csky=
:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/csky/Makefile?h=3Dperf-tools-next
```
# SPDX-License-Identifier: GPL-2.0-only
ifndef NO_DWARF
PERF_HAVE_DWARF_REGS :=3D 1
endif
```
in the patch series NO_DWARF becomes NO_LIBDW, so it is now:
```
# SPDX-License-Identifier: GPL-2.0-only
ifndef NO_LIBDW
PERF_HAVE_DWARF_REGS :=3D 1
endif
```
So the Makefile says that PERF_HAVE_DWARF_REGS is dependent on having
NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS is defined
for csky.

Dwarf in the code base implies libdw, libunwind and potentially other
dwarf capable things like llvm. If we don't have libdw then NO_LIBDW
will be set and PERF_HAVE_DWARF_REGS won't be set. That is the more
general dwarf thing will not be set because of missing libdw. This
goes contrary to wanting this to be true whenever a dwarf thing is
present - something that reflecting what the standard says would
achieve.

In the code base right now PERF_HAVE_DWARF_REGS isn't a dwarf
dependent thing, it is a libdw dependent thing, this is why
PERF_HAVE_LIBDW_REGS is a more intention revealing name as it makes
the connection explicit.

We could change the code so that in Makefile.config we set something like:
```
...
ifndef NO_LIBDW
  PERF_HAVE_DWARF :=3D 1
...
```
and in the arch/.../Makefiles change them to be:
```
if PERF_HAVE_DWARF
PERF_HAVE_DWARF_REGS :=3D 1
endif
```
but this is going beyond the clean up this patch series was trying to
achieve. I also don't know of an architecture where dwarf is present
but registers are not, so having a definition for this case feels
redundant.

Thanks,
Ian

> Actually, there is a histrical reason I had called it is DWARF. I used to
> use "libdwarf", and switched to "libdw" for required features. So I know
> there are more than 1 implementation of DWARF library, and the libdwarf
> also uses the same operation number because it depends on the same standa=
rd.
>
> https://github.com/davea42/libdwarf-code/blob/main/src/lib/libdwarf/dwarf=
.h#L809
>
> So I think we'd better keep it call as DWARF_REGS.
>
> Thank you,
>
> >
> > Thanks,
> > Ian
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
