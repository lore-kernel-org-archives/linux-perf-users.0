Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BF19259F
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871735; cv=none; b=eCBnTZpWnpCza25edGWpjnoYcaexI/InK5telTUN+ggpghX8eCz+eFHMszc+MPhD15oL9bAb7Em8yVcW1Z7MUw2GE5Jl8moZh5uugwErKgf5rgx9alxlEmimSv9GBGxu9dr/tt7KG9WGNvqv5qL1BwsVHdvQuxS9vssDaf5puTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871735; c=relaxed/simple;
	bh=WByhWmAW5j9cQa9BYhcDr/NkumXfBFSpeQWdsFz/ULw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgyjE3gIZO7JLiPqeUyQRMIV+OnfMJKMDE62471N1azHTCrbH1FWypzPGAOdUzQB15qy02GAvUPsICns1hDvCw6iYFAn9KTdE0spxrjgsL+FN5LCVty0jxqxukrra02uE74SS8jVte5/8jX1zKLrmn+SqvauGmiWvRlX0OzLo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gs1POZ8a; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gs1POZ8a"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so5865ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745871733; x=1746476533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t34wb3LufXxsreMxoYBGqZz29OOuwJmg0rd4hhRLfU=;
        b=gs1POZ8a9Zl0HmZPLxdfoGi63xXRH4DsBMh6HMXA0oZl1y71L2fNZkRNUHzCsTh1Dl
         PENkMZ2I0v2U1L6C6lhuEKoBA/f7FXpE7npFzBEQE/fOzgXzn5Oh34mXrk+Rl7D8Z2Ro
         gnw5FsG63/G6SRsY0yCnmo9aucn1VdrHNfGeZZsvwq1OYpdx42m/o1o33qgEItG6WWUE
         B1UlHztnWuF5LtvKTFU8zaUIrBcdWcbP2Q80P3BldeQG94MHAHClI0n0+gTHW9gF4BFh
         Sd4y+JTnqMnPFG98czJuxXjiVdTqNhh9iTx/Q+WtafIiXNN5cmvVESBcLS+fe6oosi3J
         tELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871733; x=1746476533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t34wb3LufXxsreMxoYBGqZz29OOuwJmg0rd4hhRLfU=;
        b=bpMuu1GaesZ8QEIXlCsHhLJYEotJD6uEu1Nma5zpdaLb1oynuikN4Fz1K0oUwEBE1m
         wJ0z4tRDGrAI2RlQvMedqnRxi3HO2seZBe3noZRBsVoD3U7pNLACG5IfW7tiR9c/GPes
         eNgPcIWjHD+TFgbfUKFLadHIUGAlAz8t60c0uWJ2hz2kukU1XsnHhr5j2nPREWP4Y26u
         WLawzgzOSZVo6uz/lqzDZBXOrph0Gu09tVgtRs60wrw/IBWVUtB80sikLh9K2WRtCWer
         a4xri9ZKIb/92skqwn0DbPYdlIyeZjf9c4TYEcxb0gt63dlx/fba2u+Obk4lOeUm+7wN
         cCUg==
X-Forwarded-Encrypted: i=1; AJvYcCWHJeB4XSgh2S5hrK7m5Wz4vQIUCFpX+JLo/jl8nM4w5guvxKU08zkO4405Lj7kIYgctiQSZd/PfpAfeFusSLey@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpYQDVoSNmW2FlNnsS2KtoI7N3psIIXWKYaEx/g3y5Ozm/NFe
	TklIax0Riwb70qnpfT6c5gK0Amk9+sQeJr97wbouyDZpCO1X2GeDHEh5AoUHgoPUb16PsR5ffRD
	wGUfJ6ssqqL+qfXSztep0S0nANWfsdikTPdQx
X-Gm-Gg: ASbGncuHQIi2qffA0VMLQAlDgDfJGR56p9N+lO9Qbusou5kqfyZBh9Mdt9urZ+uXnRs
	PukrD0NLR9VBF3LqgbfF4S3kylDc/6GGWqRihaaGrBwGBL0OVOjd/zAgszUpBbaxMS/P/tCQDH0
	I55Ah/W28SbwBr56qNmYiu0ZtCukipnfalHDbEOM1eNDsVOMWaXuQ=
X-Google-Smtp-Source: AGHT+IFw+uaHG3qywqDO8quGFytFYPdFOjGAURjv6bxAuwL1EMjzAmXI5FAd5cCyo7imjUiuIm5ecl0TTBohqCJa5m0=
X-Received: by 2002:a05:6e02:188f:b0:3d9:2b9f:49bd with SMTP id
 e9e14a558f8ab-3d95d89933bmr825525ab.6.1745871733005; Mon, 28 Apr 2025
 13:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424195831.1767457-1-irogers@google.com> <20250424195831.1767457-8-irogers@google.com>
 <aAvDStpWjwC7grya@google.com> <CAP-5=fXcTssH=bGQLDmPeT=fGf270B1-ocsP2Y7EP_RV=M838A@mail.gmail.com>
 <aA_fYvTI7YRIy2k9@google.com>
In-Reply-To: <aA_fYvTI7YRIy2k9@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Apr 2025 13:22:01 -0700
X-Gm-Features: ATxdqUHOTk_IXTG3Cep-9E8EP1IyjezhKdOd6pFkrN__beKdTuskgRT3EVPv1Us
Message-ID: <CAP-5=fX92dj4+UJrWGQpO15U62zJZDZ39SMgen8171RJ3Jcygw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] perf dso: Move build_id to dso_id
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	James Clark <james.clark@linaro.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 1:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Apr 25, 2025 at 11:46:40AM -0700, Ian Rogers wrote:
> > On Fri, Apr 25, 2025 at 10:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > On Thu, Apr 24, 2025 at 12:58:30PM -0700, Ian Rogers wrote:
> [SNIP]
> > > > @@ -1665,18 +1675,20 @@ bool dso__build_id_equal(const struct dso *=
dso, struct build_id *bid)
> > > >  void dso__read_running_kernel_build_id(struct dso *dso, struct mac=
hine *machine)
> > > >  {
> > > >       char path[PATH_MAX];
> > > > +     struct build_id bid;
> > > >
> > > >       if (machine__is_default_guest(machine))
> > > >               return;
> > > >       sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
> > > > -     if (sysfs__read_build_id(path, dso__bid(dso)) =3D=3D 0)
> > > > -             dso__set_has_build_id(dso);
> > > > +     sysfs__read_build_id(path, &bid);
> > > > +     dso__set_build_id(dso, &bid);
> > >
> > > Why not check the return value anymore?
> >
> > Checking the return value was a mistake. For example if we have
> > libc.so with a build ID and then it is replaced with a libc.so without
> > a build ID then build ID wouldn't be updated previously as reading the
> > build ID had failed - no value found.
>
> I'm not sure if it updates the dso as a whole.  This functions is to get
> build-ID of the kernel and it seems we can skip this if it already has a
> build-ID.  But if sysfs__read_build_id() failed, it may have a garbage.
>
> Do I miss something?

I think there is a missing initialization, I'll add it in v2.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > >
> > > >  }
> > > >
> > > >  int dso__kernel_module_get_build_id(struct dso *dso,
> > > >                                   const char *root_dir)
> > > >  {
> > > >       char filename[PATH_MAX];
> > > > +     struct build_id bid;
> > > >       /*
> > > >        * kernel module short names are of the form "[module]" and
> > > >        * we need just "module" here.
> > > > @@ -1687,9 +1699,8 @@ int dso__kernel_module_get_build_id(struct ds=
o *dso,
> > > >                "%s/sys/module/%.*s/notes/.note.gnu.build-id",
> > > >                root_dir, (int)strlen(name) - 1, name);
> > > >
> > > > -     if (sysfs__read_build_id(filename, dso__bid(dso)) =3D=3D 0)
> > > > -             dso__set_has_build_id(dso);
> > > > -
> > > > +     sysfs__read_build_id(filename, &bid);
> > > > +     dso__set_build_id(dso, &bid);
> > > >       return 0;
> > > >  }
