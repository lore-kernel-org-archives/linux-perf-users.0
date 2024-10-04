Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375731D9A66
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054938; cv=none; b=Tz3vrI6tVLFJaGOBEdpjGPVgjJWcXwnMiY0eZr58b2tQIkesTSZedMyrW9Cr35oQB2fQ6ggutXNmbTnU7AlGAJ1O2rBD26T0CVB7ISRFq92oDSMRntLxYF1ltY7MRisdLF/y7cxa33pD8BtpR4fM+OsAx/mYrsPs9r/ilD1qFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054938; c=relaxed/simple;
	bh=U5+mgVqDpZ8EdepkuKFsz1RkFX3keCfmZq1BWOhgP/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOS9mvd90hBak3931pWHuywiMn6Hn5tddbZOcbtc8AJOACjdUHablVUcBOOpgnFDKL3Op/MiYgd7yJ9Y6Fo+d8/HRMWTGjt0aR+DULrr2bEze424SCmi2cQltR2j/q/WtEV3LAauHvA9Dgn2gjEGljPyVrjT9oEqvJFbBkoNSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NcAgcvbY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcAgcvbY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b061b7299so168485ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2024 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728054936; x=1728659736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTtJQt69CttjR+DAPQPht1xa0MHigYqxKO3CJZrv8ac=;
        b=NcAgcvbYbP7pTChZCz/ssuAJI4+aH7eo7mKdatuM+TzwZxGA3WkkExOO4hs+hMssqm
         z1kG8Rf2fZYYTnKB7c6lsQPDUkcnk3G7pi2enRhAokkZCVfSvQtpoPXfJpsIDuIHXh61
         9W3xicv77MPe4Ye/P3SE5Ry1UGTFEcKH31pCQwcznNLtdYajke0NrMVsC8uSp6AfC/Ec
         5OK5sJ9vkLbDgz51YPpp/LH8eJHW2SAgBG3HK/tK49/7vo4fvAw5YfuFqQI85z884m0M
         D+jBoyuqTMS8uLO5HvXMd9M6IlKL6Ql3vh1LC8bMBhTt/yiIDI49PT0AoeHiQymeloi4
         NfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054936; x=1728659736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTtJQt69CttjR+DAPQPht1xa0MHigYqxKO3CJZrv8ac=;
        b=GSJwqYy17pJEDohwHaIOI7RTwmKT1TcntoYkE4GqKoAp6xT+UfnEqdEtxg0WukrUtA
         mmok3TQNxGNPOEsQwRLT7jMuCj/SItXaXY+omxY3N5EWKSSv98n3KDaLr9xxusvdGS/U
         +9F0mZlv2A414uTkM7YRAB8Y6zJVdVORhvazqLYzOKcj8zrKuKabJtG4GIEdYNFdUQLk
         vPVjjBFYycsRHrAdmBoSDEQJ1qUoGljx8Wr5oio0qA235LqYOopUdfww575hKrmZiRgB
         eCFpypSlDIXI5D+9ZlI/iG4Ok5gf/YhunVEZLZUyr5ufx/7U25L64xJINtYYQ775uObY
         4UIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSVxERXcpcsJJWpSxNTBWFbOcx0VGwAGNotepTy51fuc68oXolp9fgNz0My3QeEVGdOIQQjJftrTzvcfo7xC1j@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6xQ6x4czaQYtnA8P8/zjhjQp5NFK9UqGae0PLQVD9MG/2dSg
	EznsStr9RBdVrKXruAA2XOh1vsMSikG9Wo+AYFXM2tTnDOxjO4BEGfIELWVaUREaMgIsg+ov3Fi
	xl+V7ZOlP1CyZMH6h5qYuLFUmeEXqPSg1qiG4
X-Google-Smtp-Source: AGHT+IGt/lDjGygSMb510tyPWCXLfazyR3LkE8L6AAjTAM4ZiSvNgB+wWBZW/iFdeNwNElp+8YxvC072BxQ51RLuYzQ=
X-Received: by 2002:a17:902:fb87:b0:202:3a49:ace7 with SMTP id
 d9443c01a7336-20bffb31c15mr2548135ad.20.1728054936036; Fri, 04 Oct 2024
 08:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
 <CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
 <ZvyBQ6xgGE4gZdoo@google.com> <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
 <20241002082859.8821e441024fe873a4301afc@kernel.org> <CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
 <20241002225614.774bdd0742a826557f142d0e@kernel.org> <CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>
 <Zv8fIh4jaY7QbeDZ@google.com> <CAP-5=fVvzNMDPUpAvK0itjG0ZptrSg-_BN3t6UwB4XAvSsDt8w@mail.gmail.com>
 <Zv95OTflePPTMi7I@google.com> <20241004234544.76317dc8c7027bcd4b70fda3@kernel.org>
In-Reply-To: <20241004234544.76317dc8c7027bcd4b70fda3@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Oct 2024 08:15:22 -0700
Message-ID: <CAP-5=fUr9X4TKd8RA9SEJfsaAvvBJxh5UzKToJoOS_M=0mEpCQ@mail.gmail.com>
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

On Fri, Oct 4, 2024 at 7:45=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Thu, 3 Oct 2024 22:12:25 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > On Thu, Oct 03, 2024 at 05:58:13PM -0700, Ian Rogers wrote:
> > > On Thu, Oct 3, 2024 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > > I agree renaming libdw-specific parts.  But the register is for DWA=
RF,
> > > > not libdw even if it's currently used by libdw only.   So I don't w=
ant
> > > > to rename it.
> > >
> > > So your objection is that we have files called:
> > > tools/perf/arch/*/util/dwarf-regs.c
> > > and PERF_HAVE_DRWARF_REGS is an indication that this file exists. Thi=
s
> > > file declares a single get_arch_regnum function. The building of the
> > > file after this series is:
> > > perf-util-$(CONFIG_LIBDW)     +=3D dwarf-regs.o
> >
> > Well.. I think we can even make it
> >
> > perf-util-y +=3D dwarf-regs.o
> >
> > since it doesn't have any dependency on libdw.  But it'd be inefficent
> > to ship the dead code and data.  Anyway we may remove the condition to
> > define the PERF_HAVE_DWARF_REGS like below.
> >
> > diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefil=
e
> > index 67b4969a673836eb..f1eb1ee1ea25ca53 100644
> > --- a/tools/perf/arch/x86/Makefile
> > +++ b/tools/perf/arch/x86/Makefile
> > @@ -1,7 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ifndef NO_DWARF
> >  PERF_HAVE_DWARF_REGS :=3D 1
> > -endif
> >  HAVE_KVM_STAT_SUPPORT :=3D 1
> >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> >  PERF_HAVE_JITDUMP :=3D 1
> >
> > >
> > > My objection is that PERF_HAVE_DWARF_REGS is controlling the #define
> > > HAVE_LIBDW_SUPPORT, so dwarf (that can mean libunwind, libdw, etc.) i=
s
> > > guarding having libdw which is backward and part of what this series
> > > has been trying to clean up.
> >
> > Why not?  If the arch doesn't define DWARF registers, it can refuse
> > libdw support because it won't work well.
>
> It actually does not DWARF registers, but just "dwarf-regs.c" file
> since arch should define DWARF registers if the compiler generates
> the DWARF.
> Here the flag means only "we implemented dwarf-regs.c file for this
> arch." So if it is called as "libdw-helper.c" then we can rename the
> flag as PERF_HAVE_ARCH_LIBDW_HELPER simply.
>
> > > If we rename tools/perf/arch/*/util/dwarf-regs.c to
> > > tools/perf/arch/*/util/libdw-helpers.c the PERF_HAVE_DWARF_REGS can b=
e
> > > renamed to PERF_HAVE_LIBDW_HELPERS to align. Then
> > > PERF_HAVE_LIBDW_HELPERS guarding the #define PERF_HAVE_LIBDW makes
> > > sense to me and I think we achieve the filename alignment you are
> > > looking for.
> >
> > I don't think it's a good idea.  The logic is not specific to libdw.
>
> Yes, the logic (DWARF register mapping to the ISA register name) is
> not libdw. But I think we can also implement it in "libdw-helper.c".
> (In fact, this implementation does not depend only on Dwarf, but
>  rather on the convenience of ftrace.)
>
> > >
> > > Yes get_arch_regnum could make sense out of libdw and needn't just be
> > > a helper for it, but let's worry about that when there's a need.
> > > What's confusing at the moment is does libdw provide dwarf support,
> > > which I'd say is expected, or does dwarf provide libdw support?
> >
> > As I said, it's about refusing libdw.
>
> I think Ian pointed this part, even if libdw is available, dwarf-regs.c
> controls its usage, but libunwind is not.
>
> >
> >   ifndef NO_LIBDW
> >     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
> >       $(warning DWARF register mappings have not been defined for archi=
tecture $(SRCARCH), DWARF support disabled)
>
> I think *this message* is the root cause of this discussion. It should be
> changed to
>
> "DWARF register mappings have not been defined for architecture $(SRCARCH=
), libdw support disabled."
>
> or (if changed to libdw-helper)
>
> "libdw-helper.c is not implemented for architecture $(SRCARCH), libdw sup=
port disabled."

So looking at the code I think the whole thing looks wrong. The
get_arch_regnum function is used by get_dwarf_regnum which is used in
2 places in annotate.c:
```
static int extract_reg_offset(struct arch *arch, const char *str,
                             struct annotated_op_loc *op_loc)
...
int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
                              struct annotated_insn_loc *loc)
```
So these functions are passing in an architecture. In get_dwarf_regnum:
```
/* Return DWARF register number from architecture register name */
int get_dwarf_regnum(const char *name, unsigned int machine)
{
       char *regname =3D strdup(name);
       int reg =3D -1;
       char *p;

       if (regname =3D=3D NULL)
               return -EINVAL;

       /* For convenience, remove trailing characters */
       p =3D strpbrk(regname, " ,)");
       if (p)
               *p =3D '\0';

       switch (machine) {
       case EM_NONE:   /* Generic arch - use host arch */
               reg =3D get_arch_regnum(regname);
               break;
       default:
               pr_err("ELF MACHINE %x is not supported.\n", machine);
       }
       free(regname);
       return reg;
}
```
But why, if the machine is EM_X86_64 and I'm on an x86-64, can't I
call get_arch_regnum? The code should be something like:
```
if (machine =3D=3D EM_NONE) {
#ifdef __x86_64__
  machine =3D EM_X86_64;
#elf...
```
Once we have an architecture specific machine then instead of
get_arch_regnum it should call get_x86_64_regnum or
get_aarch64_regnum.
```
switch(machine) }
case EM_X86_64:
         reg =3D get_x86_64_regnum(regname);
         break;
...
```
Is this better? Yes, it means that the annotate logic can work if,
say, annotating/disassembling an ARM binary on an x86-64.

So we need to pull all the tools/perf/arch/<arch>/util/dwarf-regs.c
files into tools/perf/util/dwarf-regs-<arch>.c files. We need to
rename the get_arch_regnum to reflect the <arch> in the file name. The
Makefile logic can include all of this unconditionally and
PERF_HAVE_DWARF_REGS can just be removed. In the process the ability
to annotate binaries from one architecture on another is improved. It
needn't be the case that we have dwarf regs for the architecture perf
is being run on as we may be annotating an x86-64 binary where there
is support.

What's strange is that get_dwarf_regstr in the common code already
does things pretty much this way. This whole Makefile, arch, weak
function, PERF_HAVE... logic just looks like a mistake that is making
the tool worse than it needs to be. I think this is frequently the
case with code in arch/, a lot of the functionality there can be moved
into pmu.c and doing things conditional on the pmu, which is
inherently architecture dependent. This can fix unusual cases of say
running the perf tool on user land qemu, where we may have an ARM perf
binary but see the PMUs of an x86.

I can work to put this into a v2 so please scream if my reasoning
doesn't make sense.

Thanks,
Ian
