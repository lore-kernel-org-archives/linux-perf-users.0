Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADF31E83B
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108369; cv=pass; b=qAMhW+i7rROHX1S4iuhj+zhrsutIL/pGIY5xSe2NTFy22NbRNIEJrwOSaeWUGabrtio+f2vUEzuaVFw0Fpr/hY3BRhPHZPldXLwq8K96hQf5imcbFPe7ETWRKq2DYvw5bcmvxjteURXx4FNxi6z5kwgrReALcPSrh5WcAobNP+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108369; c=relaxed/simple;
	bh=tEcBow2gdBp+/voVp/g9x+g9NV2I+Be2aTB/lbhkaHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlAPxV+bUGCNoQfYj1r5pfJcedAV1Qas5uLUvdKq0Ou9IrWO+7yXBVZsMlF+aK+q2xHGBFeuVIifwafaoLKvlOqVdx5HmMbcJFhTaoayi34vx2sqE1uGJ/VdZhqs2MetfbQrU/QjokWSL+WbRARpEpAcf3mvGQT834wMWWSYp44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hL2pYXdr; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hL2pYXdr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf22c18ad3so111715ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 09:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781108366; cv=none;
        d=google.com; s=arc-20240605;
        b=Zsy3FPdThvANbKhBiJih6U6C+CGDIDRviOMehVCnTI3+0Qledb+lnCqyDjQnebqsXq
         6o2LhCajRZxnxnMl7ZLUHQ9tFIQFOrQiO7wtCt4CI7Nq24w92hG8oFfwg/2u/PGinHyu
         5Nfo9a9Gkalzv1CO50faJK5ZnKORJZ95i8W7WvUHb30KOcVCvZimdEV4WfW7Mqr+rLJD
         Op3E4YayHodX+2xzB1Y2XsAQ0Zeyd7JZClHN8fQ8Crl7fSVIGD1m5MB9KkhGysyD3BA5
         ZKEcMunrvD1W3viTvk9njiDBdwgeu+pwNbhnG5i6QbMUzACOQOEidjzeKqcEd/5vlyp/
         flkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vi11/rohvLJyMxroWGqfziqvFq44cunGgPMb0wuOPpg=;
        fh=RMrrY8uXq9lB77DUwwyPsptwvso7Nzp3Z1os0aArzMM=;
        b=Qay3MHkevTME4hxJ+rasAmG0/nEAqOULDOq8LcphPODbPrCEUT+nDn+JGbmJhMb5lm
         bZst/vLfVXv2zuWk7es29sO15xPewJiya3+PMSKaiUL4pWaPi8Fkmu0jxChtXtQmvh5T
         135iks1M7Jv4nIBnjSlwpnuo8syFPixGwlScEr938xiJ5whW0iC930vWUWjdlCnoyGoF
         0HssVRbxC/VU+O7Oy+SIVlT6QywaXDumg1hf0hMbYEyHIb+MMXJvyjB9FJgRWREmr08D
         IPMivj6LODEcB6x6EeKIF1Ff9D9QOI9G5jJs42ek6UoGOKylYNicw/sauBfxcNaf1Iz7
         lUzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108366; x=1781713166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi11/rohvLJyMxroWGqfziqvFq44cunGgPMb0wuOPpg=;
        b=hL2pYXdr4CwfLvTKLanwttjQywdcSG7O/Bm/S0nWjezyo/Ts6qjPR8SpufhVM/BHtf
         426VJB2T2c74DaE43o3Be4qS/SKUuVNrCA3ybUzH8DQ0Bl6WIPudOtfmJy/s7917O0VP
         gY7IL5e1UqKI+m/57hlg8LED4EugLzNFbgpRTv6bqX7YAlr3yIb68xGjs7Rda7AIeDYE
         pqq1pxkkgE7zyaH3A/YmZunylYJfgQIqMyNkonklrmtA7szN37jzdTN9sG5/hWHw5wNK
         ZbGaEx8MasU5cfl/VunIbccgAaZwk/YfOW6UDUeljotoLOmKsuIghsQxfqzmKxqxropL
         +/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108366; x=1781713166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vi11/rohvLJyMxroWGqfziqvFq44cunGgPMb0wuOPpg=;
        b=bOanPWvefS2CioUmbJWCcxIm+UndSBnU08FoB6A+UL6HYomzPFIBZN7V56xnjzG198
         TazA+Nz8sGShjmSZ/gniAjpmdA1tLarAcRGVNaozyqcLyupZaJzgDdmqwQ/qD90EFIb/
         Ah1Dx0OikpbpiVzhgvBkW8esEkf81PTVPGLG7SJtRteJOJ/xtze9yps4a26uJ9FcJI5m
         oipzKAx5/D4g1onbOHGpgnCsg7xTchdfWlKGbj+CqISEfPxcRSDJKAfghh5mGeZ6g7xf
         r0g1RuJaPDdJ93ncEnWyWDZ26tYAX9RMqsVrsggwSCmhI5e8J5vAW2fV2weAHf+dR450
         1AkA==
X-Forwarded-Encrypted: i=1; AFNElJ99Oob2jYno2x26c/Co4oZ0iaSZtmY0bqVfrj/f54yQSMn344hIddoCjI+bk7EDhG+Z7Hdx63E7dvWrT6ri3ho+@vger.kernel.org
X-Gm-Message-State: AOJu0YwYP1PD3wJhjGtEqXT81OsNYWUmeqfzUsS1b3xPYelYiYJc/G6v
	XnO4Bu6fcza2vUlr7PwFYAp/tPxfRCHaPPWFH8KVUheXwVu3kHzl5ufOn0YBq8AYb35mz9vJ8ts
	7DFg+swLCzMZg/cf0QGVEe7WH1Rh6ZiDGIDnEKdZi
X-Gm-Gg: Acq92OEPChipXv6PNeRxBS80jFyFxkRqq96ZMCpOOI30rru0+zseqreExiZPQCnujz/
	MYPvPW2CySgFsEQyhReLYktOJQPbVRKfyCxvcGoJQTLJyde1RggOuSoY3/TBOiPz3A8dtjMJbm7
	j9Wqokwq7QnPCYdhDdYkKP1bWEq8I7A3As6V1nSSFDs+tUgSsQeCtmYmWaJ/zwYsfOm1bFAWlby
	gxu00sTxdd/Nz7E/EcMBaxQRM7SrpIzj+zYKzrCqxQO7975Vkdvpx1v+YcQdo581HJg5LI1RQJs
	QAmJo9YTrJdDBRofsJ8VDQ0TX26h6QUt8IcjSBWnGMEz1wwkoMxnVnRiT8U=
X-Received: by 2002:a17:903:3c25:b0:2c1:ee6e:4e4a with SMTP id
 d9443c01a7336-2c2d942700amr238395ad.27.1781108365793; Wed, 10 Jun 2026
 09:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610112451.1553054-1-jremus@linux.ibm.com> <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
In-Reply-To: <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jun 2026 09:19:14 -0700
X-Gm-Features: AVVi8CeML9xOHpqDi-kOipKhEhSw8qM5oNh-G4lar_licy0sI8HoLNL-mbAU5DU
Message-ID: <CAP-5=fUowmCCdfAOoPimduZ53GTfRPp1qPLMUfXU6R80=x88Eg@mail.gmail.com>
Subject: Re: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling
 as PIC
To: James Clark <james.clark@linaro.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 6:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 10/06/2026 12:24 pm, Jens Remus wrote:
> > On s390 the Python extension build fails as follows when using a linker
> > that is configured to treat text relocations (TEXTREL) in shared
> > libraries as error by default:
> >
> >    GEN     python/perf.cpython-314-s390x-linux-gnu.so
> > /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> >
> > This occurrs because util/llvm-c-helpers.o is erroneously built from
> > util/llvm-c-helpers.cpp without compiler option -fPIC but linked into
> > the shared library (via libperf-util.a(perf-util-in.o)).
> >
> > On s390, object files must be compiled as position-indepedent code (PIC=
)
> > in order to be linked into shared libraries.  Commit a9a3f1d18a6c ("per=
f
> > s390: Always build with -fPIC") added compiler option -fPIC to CFLAGS
> > for s390, which is used in C compiles.  Add -fPIC to CXXFLAGS for s390
> > as well, so that it is also used in C++ compiles.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Great! Perhaps we should add a fixes tag for backports. Perhaps:

Fixes: a9a3f1d18a6c ("perf s390: Always build with -fPIC")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >
> > Notes (jremus):
> >      This patch applies on top of the perf-tools-next tree:
> >
> >        git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-ne=
xt.git  master
> >
> >      Note that this resolves the issue discussed in thread "[PATCH 1/1]=
 perf
> >      build: Fix Python extension build with GCC 16 hardening":
> >      https://lore.kernel.org/all/ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2=
-a85c-945b6f05615c.ibm.com/T/
> >
> >   tools/perf/Makefile.config | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 333ddd0e4bd8..33f90968c8a9 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -109,6 +109,7 @@ endif
> >
> >   ifeq ($(ARCH),s390)
> >     CFLAGS +=3D -fPIC
> > +  CXXFLAGS +=3D -fPIC
> >   endif
> >
> >   ifeq ($(ARCH),mips)
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
