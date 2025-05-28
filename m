Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A541FF610
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456843; cv=none; b=TjdYgJkDIs9J6EBOE2FUk/z9S4vK49AzOru6ASDnP+9Pnc4n1IiPz7uIm3iOP3QhK47U/V9KAJxuhA5Y3SkTd1otCZP6ZC+QGSm5ZBkO0xrwK8/VmNf/j+mgpK1Ii8/g91uLYRPmVdAxIe83HPrCTbF7dim46U7NvF7/qM87XmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456843; c=relaxed/simple;
	bh=Dyae6p0XkCLn3cY+5hqYXijVKH5spBJwwTcKDEsPWZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUAHKw/aI2ZpFn1Il/qOuJXBDF5d3ibBlgn4j5qIAJm5tPS+qXWqD9hVvkP3uh8INuWB9+t9MioUvK5mwiY9WG3Zb+Qf1oIcpx0fpBPkfnyCFPPHwpJibLx4BHoxI7orJ+uJOH6Cju4+qcdqs+j/k6ystAMDke8PFwcH5jSMM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXuQizHS; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXuQizHS"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so16815ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748456840; x=1749061640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM8Rc18VEtFQ1Tssf3yJOD2mv0SdQCHfqzTOhoG5MKk=;
        b=DXuQizHSxGQpsJ+zUO0aRy0XK3YKLt3G+bSqLxVaSDK8VqtfRxceRgp1gM84QYqh/p
         7um39EWW2pl6zRpcj+YW5mPbWL6Q+9BjGNQWJd0FRDXko30N6J2oP34Wn1svHsShBrXx
         erwEizo5qJE4SA7YNZs7aoDhiqIFJhN2A5D7drQEFoXIF6Uj7RLnjdnwkeQw0NA6w2uJ
         ty+6ySL938/vB2KEWcAaT5jpNYLzl5NzIFJNl4LcdfEizhrl8IAKmR2ggT/4V6SstHAB
         QtSRqB9I+DR5v+Vcsu4niSWIgyGSu+eZNM16spNBNXAKyxBfrEJWe3ayRQ/SpUi/11RS
         5WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456840; x=1749061640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM8Rc18VEtFQ1Tssf3yJOD2mv0SdQCHfqzTOhoG5MKk=;
        b=SBDvy2U0jXqWtnCAYd8r6sFIoyWDK6N6+sjgjA7+RwMORcIl+ASsbqqZd3ByD+x6/+
         Xx48VIeUVZoWKmjZBlV/Xd4iy/lCQWbo2tNVQoODfe7Zgv4LRPBCFTAKJaRjWFbBoUoF
         mKdAycq7vDPt/ADw4MgezKxUt9u01fmbHyNwkIQpyTGA1YWTOMjbUjj3AwmxlKEDg8HY
         egDMNhZ0XIq016ho6KXPSw8E2iNFcTIM7nTiecmINjSD/agIZP9TwHSVwH/l2HFEPNg4
         qVxX4+M55jfM4U2DLmr/PucTZNa9uejBRrt8RHGj15tWNKWhYPE3Q46SB3V3UGZDKT0M
         SHew==
X-Forwarded-Encrypted: i=1; AJvYcCW6MsA5PfdkX3RsMdrb+TH1kgTGoCDvpzXAs2JQVeKRHz71SAvPYSDUzsN0ANxDe0gZV9s7bhIoGcxtSWKSoXZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsc7zJVW2DYMXF/BqL3ZutGwdSGCo3y4b89CaMVddz/IaIUHc
	6L+oByNXJr2DpUXPUCvlp0FdFPV48s7qpJwLdDnlJ5/dHDksGXh7ewkX2tlv2HEeGt3stLxi970
	GBnAL/bVEAbWOEGhfa79Eb9J80duRYlxd0iUNaz6a
X-Gm-Gg: ASbGncvU11OMzRHiJvS+KiaHIMgKZ+opAYVqbuWZdlEjF8NFl3dLFXm/o5iwEI+Np7z
	MdwspdSlkDzK1D7bOQFCnRe/qZ3fo/zm1yP0bTMoYCIV3slxrf2gKffEptOH9j74X025Wr9c37a
	gXkvkEcAV6s9bi+SNrrEDMFav2D9pYhJlmPBS3w/8bozyaQ8s/swFaURXG+ZZReLCdwgVygQi2
X-Google-Smtp-Source: AGHT+IFd4Kl8836dzc9vu4lsDYW2giR8SUOs2tR/CZqf56ma4yrC4qckrBhCAKDN/A1HjkQ/GfxZV1Ot/qkm+uGI84Y=
X-Received: by 2002:a05:6e02:790:b0:3dc:7c30:c6d2 with SMTP id
 e9e14a558f8ab-3dd928079c9mr152535ab.27.1748456839970; Wed, 28 May 2025
 11:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521165317.713463-1-irogers@google.com> <20250521165317.713463-2-irogers@google.com>
 <aC43Et06tyrBOrsT@google.com> <CAP-5=fUYUDq6hmd+e3_E7HCRPYuy-0KLE+gLuSCWAHh3A5wJLA@mail.gmail.com>
 <aDdR0pCNSmxCEyEZ@google.com>
In-Reply-To: <aDdR0pCNSmxCEyEZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 11:27:06 -0700
X-Gm-Features: AX0GCFvWI1R9REX5VoYYVsZyhaRf2cKWzDmoyux_Rz-w7siJZVQd-yB4sdzLp9s
Message-ID: <CAP-5=fVv9+0UdYDNQ52T-QgKfUYBL-pgRwd_ac3jp7KW8sxrRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf sample: Remove arch notion of sample parsing
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, May 21, 2025 at 02:15:24PM -0700, Ian Rogers wrote:
> > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, May 21, 2025 at 09:53:15AM -0700, Ian Rogers wrote:
> > > > By definition arch sample parsing and synthesis will inhibit certai=
n
> > > > kinds of cross-platform record then analysis (report, script,
> > > > etc.). Remove arch_perf_parse_sample_weight and
> > > > arch_perf_synthesize_sample_weight replacing with a common
> > > > implementation. Combine perf_sample p_stage_cyc and retire_lat to
> > > > capture the differing uses regardless of compiled for architecture.
> > >
> > > Can you please do this without renaming?  It can be a separate patch =
but
> > > I think we can just leave it.
> >
> > It is not clear what the use of the union is. Presumably it is a
> > tagged union but there is no tag as the union value to use is implied
> > by either being built on x86_64 or powerpc. The change removes the
> > notion of this code being built for x86_64 or powerpc and so the union
> > value to use isn't clear (e.g. should arm use p_stage_cyc or
> > retire_lat from the union), hence combining to show that it could be
> > one or the other. The code could be:
> > ```
> > #ifdef __x86_64__
> >        u16 p_stage_cyc;
> > #elif defined(powerpc)
> >        u16 retire_lat;
> > #endif
> > ```
> > but this isn't cross-platform.
>
> Right, we probably don't want it.
>
>
> > The change in hist.h of
> > ```
> > @@ -255,7 +255,7 @@ struct hist_entry {
> >         u64                     code_page_size;
> >         u64                     weight;
> >         u64                     ins_lat;
> > -       u64                     p_stage_cyc;
> > +       u64                     p_stage_cyc_or_retire_lat;
> > ```
> > could be a follow up CL, but then we lose something of what the field
> > is holding given the value is just a copy of that same named value in
> > perf_sample. The code only inserts 34 lines and so the churn of doing
> > that seemed worse than having the change in a single patch for
> > clarity.
>
> Assuming other archs can add something later, we won't rename the field
> again.  So I can live with the ugly union fields.  If we really want to
> rename it, I prefer calling it just 'weight3' and let the archs handle
> the display name only.

But that's my point (or in other words maybe you've missed my point) .
Regardless of arch we should display p_stage_cyc if processing a
perf.data file from a PowerPC as determined from the perf_env in the
perf.data file, or retire_lat if processing a perf.data file from x86.
The arch of the perf build is entirely irrelevant and calling the
variable an opaque weight3 will require something that will need to be
disambiguate it elsewhere in the code. The goal in variable names
should be to be intention revealing, which I think
p_stage_cyc_or_retire_lat is doing better than weight3, which is
something of a regression from the existing but inaccurate
p_stage_cyc.

Thanks,
Ian

> Thanks,
> Namhyung
>
