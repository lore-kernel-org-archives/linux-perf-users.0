Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6838F6B
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464699; cv=none; b=cl99K9I8I5Q+4zmLtCm8Q8VFqjtkv0D/zs9++WjXaK16WocuqRCll64Sr7h7VJXISDNVeyV3pZEckydfvFBQ/s/4YQqBm3xaVYyIaWp+Q7+Qs71gl1AMHPDEwpSyt1wWUxztKICL1XHDspxqUm90e1mglAnNkbz8vtdyR+rD3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464699; c=relaxed/simple;
	bh=Sk0KsMgaB+xZjKeQ1toE0XUKUHEAW+cJu2j+0JU8sA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzUyNymq36hYYEq2o9rga0qNzunm12/PE8uRyGm7Wk6TO72HxpoZ1TYunTJVAS2lXb+ZhBfQ4EIojoPIv7eBXvYPntqkym1dO74jQ7pR/nX0nVtIlJ9VefZXVVa/AEt8k4p0UCmZ5kcRdExuAP06g/RReToX34Kr3Q7g9K8GtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SwInS51; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SwInS51"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso10815ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748464695; x=1749069495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CysRy/6eh5eLY4N+6IpIoDvJtx8LW/RoAsL4riwmZR8=;
        b=3SwInS51qeTN/UN/iFV/9FdlQRD2tY04D3lMfNROVV1VR8hNdEM4i4XfcSXUPG/HS1
         VkmfXL/I/ZZ/SPqXk99MnF66u8FqDBG3/7HADYbfamr4jPH4bGljzRBDdZgF5hZNtiBs
         AE6FrHnjGaiW+B+uMsfPPF/YL2dIrbgN89Fcrc7pcI68qzMxADtaNqZkXd/p8UvcArV7
         hNAcM4RAncbTIBfi0xy1jf7iH9sIyogaQbjITG+uKjPPlxBvq8dOF6Aolpgh2vd3vikI
         Aqi5bTxAY0IhQ4AYjSvAIsvMk6lXHuEX4sEKYTYt9S7Ax9sI+sqYOPjdG1zSCJKFHtel
         6E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464695; x=1749069495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CysRy/6eh5eLY4N+6IpIoDvJtx8LW/RoAsL4riwmZR8=;
        b=g2xR026zKA8eunNZqKcoi02KgIuvTDO7PH7E4FSiUYoxTeY9+iar35g7NUj1/bMRYR
         6bha5x7Xt4o5D+c3J8RnQZsdYrABnXEC9qd6a/CfD2srXvgWTV6jTXzfjwiStPJrNZHj
         0Hl5A+foJu+76jmqJRGB9cgS394zqmC5o/uK0xJOpDaUW//IZNJgF8w/K77PFlRJb+wT
         FsWXgkhUsv0z4Bw66bWmM93ZllsyYvpRareY4bec9KwgyAeLMm5CvBn6uYrRzCzy5FOb
         VmFB8H1jaFuGmLW5cvqL99KQv1c57YjveeHOdI7yPkPCHAZ6LlbBn4tqRdXxQZDO3N71
         DwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV82PJkJRUbMvbZv3l8NvIPqKg+Ou2trfBKMqiBP5f8+Pl44HdAjvQ1+NjCoz6lAXeyPMzUpiqUqb66AII/xdHP@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcuqqNxNKAPvQAlifCqzLyfJ0SeyKcjd32MljADmCBdqGU1H0
	rE9ehRKI9keo3o4q0WHsp8hCEUSlnNqPdD85l1i9lYKPQl04nj4u0ZObJQ9AiDYxpHYSoGTp6Fs
	OpUFzg7eRVykqQumZyQMxiLn7ttxIO3i3lF3soUfd
X-Gm-Gg: ASbGncu/7fswknHcL+dY5ME3h8gG2YEIFeVDHPsr/Ru+JIDMiTwTqoprCQTJp3FIpFd
	0I1LN1aXU4uejAWrMQgMkFvjsPKpnzl6UtKYr2O8G7wtTdkFtufHROo9YYP693FHX4UELssYuo2
	HPBax26/VA+CPzo3sYVG42pR6ke4s4FA/F/eL41Nx2XGpqHtzFXYEQZeGt2I0oUviGgtLVGAmi
X-Google-Smtp-Source: AGHT+IE9bzHVt/yUEPZJKDRNU4/P3m0whhwjx11oXjO87AScLkBfxZoU0C1CnCERqAW+9+XcXXaK/T5DZtWDKt5e4aE=
X-Received: by 2002:a05:6e02:1a0b:b0:3dc:670e:ad5f with SMTP id
 e9e14a558f8ab-3dd91cc4504mr906045ab.14.1748464695389; Wed, 28 May 2025
 13:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521165317.713463-1-irogers@google.com> <20250521165317.713463-2-irogers@google.com>
 <aC43Et06tyrBOrsT@google.com> <CAP-5=fUYUDq6hmd+e3_E7HCRPYuy-0KLE+gLuSCWAHh3A5wJLA@mail.gmail.com>
 <aDdR0pCNSmxCEyEZ@google.com> <CAP-5=fVv9+0UdYDNQ52T-QgKfUYBL-pgRwd_ac3jp7KW8sxrRw@mail.gmail.com>
 <aDdtWlUbDZtM9pvg@google.com>
In-Reply-To: <aDdtWlUbDZtM9pvg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 13:38:03 -0700
X-Gm-Features: AX0GCFv-h49dYmQU2vung1CGzOzr11YPBVSw5C9RIXQXF3GPgA73aQr5Xf0vg88
Message-ID: <CAP-5=fXaaQv5eFTheW52CNc-5Zhmfow2aZ59vnJy74XL2oEcfw@mail.gmail.com>
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

On Wed, May 28, 2025 at 1:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, May 28, 2025 at 11:27:06AM -0700, Ian Rogers wrote:
> > On Wed, May 28, 2025 at 11:11=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Wed, May 21, 2025 at 02:15:24PM -0700, Ian Rogers wrote:
> > > > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, May 21, 2025 at 09:53:15AM -0700, Ian Rogers wrote:
> > > > > > By definition arch sample parsing and synthesis will inhibit ce=
rtain
> > > > > > kinds of cross-platform record then analysis (report, script,
> > > > > > etc.). Remove arch_perf_parse_sample_weight and
> > > > > > arch_perf_synthesize_sample_weight replacing with a common
> > > > > > implementation. Combine perf_sample p_stage_cyc and retire_lat =
to
> > > > > > capture the differing uses regardless of compiled for architect=
ure.
> > > > >
> > > > > Can you please do this without renaming?  It can be a separate pa=
tch but
> > > > > I think we can just leave it.
> > > >
> > > > It is not clear what the use of the union is. Presumably it is a
> > > > tagged union but there is no tag as the union value to use is impli=
ed
> > > > by either being built on x86_64 or powerpc. The change removes the
> > > > notion of this code being built for x86_64 or powerpc and so the un=
ion
> > > > value to use isn't clear (e.g. should arm use p_stage_cyc or
> > > > retire_lat from the union), hence combining to show that it could b=
e
> > > > one or the other. The code could be:
> > > > ```
> > > > #ifdef __x86_64__
> > > >        u16 p_stage_cyc;
> > > > #elif defined(powerpc)
> > > >        u16 retire_lat;
> > > > #endif
> > > > ```
> > > > but this isn't cross-platform.
> > >
> > > Right, we probably don't want it.
> > >
> > >
> > > > The change in hist.h of
> > > > ```
> > > > @@ -255,7 +255,7 @@ struct hist_entry {
> > > >         u64                     code_page_size;
> > > >         u64                     weight;
> > > >         u64                     ins_lat;
> > > > -       u64                     p_stage_cyc;
> > > > +       u64                     p_stage_cyc_or_retire_lat;
> > > > ```
> > > > could be a follow up CL, but then we lose something of what the fie=
ld
> > > > is holding given the value is just a copy of that same named value =
in
> > > > perf_sample. The code only inserts 34 lines and so the churn of doi=
ng
> > > > that seemed worse than having the change in a single patch for
> > > > clarity.
> > >
> > > Assuming other archs can add something later, we won't rename the fie=
ld
> > > again.  So I can live with the ugly union fields.  If we really want =
to
> > > rename it, I prefer calling it just 'weight3' and let the archs handl=
e
> > > the display name only.
> >
> > But that's my point (or in other words maybe you've missed my point) .
> > Regardless of arch we should display p_stage_cyc if processing a
> > perf.data file from a PowerPC as determined from the perf_env in the
> > perf.data file, or retire_lat if processing a perf.data file from x86.
>
> Agreed.
>
>
> > The arch of the perf build is entirely irrelevant and calling the
> > variable an opaque weight3 will require something that will need to be
> > disambiguate it elsewhere in the code. The goal in variable names
> > should be to be intention revealing, which I think
> > p_stage_cyc_or_retire_lat is doing better than weight3, which is
> > something of a regression from the existing but inaccurate
> > p_stage_cyc.
>
> Yeah, but I worried if it would end up with
> 'p_stage_cyc_or_retire_lat_or_something_else' later.

Perhaps it should be:
```
union {
  u16 raw;
  u16 p_stage_cyc;
  u16 retire_lat;
} weight3;
```
to try to best capture this. `xyz.weight3.raw` when the PowerPC or x86
use isn't known, etc. In the histogram code the u16 is a u64.

Thanks,
Ian

> Thanks,
> Namhyung
>
