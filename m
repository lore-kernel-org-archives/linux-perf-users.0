Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F101522A;
	Wed, 29 May 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010352; cv=none; b=p8FN40PKXlaRmbD+Z61ZCNJqtCDg1VXFccBWsPeI15IR1+vk7aBMY6Ctp22HlzCPW3XZBGg1Q47aaNCeMGkdmqVxIrMnKxo+IRD19hLXvZIVCV6tdfLn/WfEuRig+BKEddUL8GIoMci+ck/VEpY4+FAVZ2cGBjL7WQEXuHLZM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010352; c=relaxed/simple;
	bh=xb1JN1y1CMO2f8a0qx3FZtOhvXUAeWKxP5purARNaI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMxGnHiLRW8gqNyWYCtxAsAYgnfApS6YpjZnyoInKpw8R+vgKZWWvwOET8d5q5R36DyNmmdNzXB5lhr1CjuJt35zY1aTAJLWjxnLXIE2og3iEXtLJ2+mGto3FaqcBMkHAE73irkkA4l5t4LckC165/Z2SNvuD2HukLYirCcRPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so43941a91.3;
        Wed, 29 May 2024 12:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717010350; x=1717615150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB+hEeQGtAuqaIgp6KRG4K6CzFSG34l9ai+1CFQ5EHw=;
        b=mI2+IonlyqCqYZx9991pYwl+Ad6FXRAnDWOFwUP5O572sCkWhG5V13ailvV8dOjUR2
         9DcKGqHsCiEEJzTTbHdZf14VZtNfpCZ92XmOMjHKt1BvoMC2Uy1CVFRJazn8qM/z7g4i
         DvwkidnM5Ys71pzxpKv/EyQlYr3KgTeV6LPTuXxGkBh6DkbillqlMQ/saj3Z/+scyo8g
         a6mIyTYY+ObQ9Ic7KXITDD1FDbtoAs7vl9C4q9lI8hD/QHiBOb6y8Y1O4ikvf8K0NUc9
         1qsdwYxzW32hyt8+R1oie9ICELPDilM8nXz49XEzQOaAuhmS/OC3Y9cHBYBZc7+EGXYZ
         RhfA==
X-Forwarded-Encrypted: i=1; AJvYcCXGenu3EIom06sCdDcDvUgKHIMr2J8pLZtqktYG0+58gwJx0k5TyAjKNxAABn3vVv5UmdHtMxG/0EyLG2vOqVs7W/wExiSWtGWMmf5LNhPX8YrQUkfwQrc+EBEzRnnYP1Iq2vpCVig4mBlqCGwZsw==
X-Gm-Message-State: AOJu0Yw618pUmH098z4NxeN0OeszYcEcvOtmKbJDqD8/KOCVJSV3QIpn
	a/P17d8P0r46QHiVHDfgoUzHe8BjfqDJVY2IpGxGKBM0eJhMVilAIMdnGDxl11GQjiyy3HrwIzE
	kbNYDxeyjIjQ5n9Iso4enGvSKYvY=
X-Google-Smtp-Source: AGHT+IFm1+tDYSwKd/p+X6+OnZVWDrWbRmfDMQGhEmk4TvTFihvAL+QZ4+OTGKp438p6gjJLMZI+ciewCLbvgaS2BN8=
X-Received: by 2002:a17:90a:4592:b0:2b2:7e94:c5e0 with SMTP id
 98e67ed59e1d1-2c1ab9f933cmr38112a91.20.1717010350217; Wed, 29 May 2024
 12:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521133029.83654-1-ben.gainey@arm.com> <20240521133029.83654-5-ben.gainey@arm.com>
 <CAM9d7chssov_fW3ZbpYqGRyhS=xuHLyJ7=rkxTNnJ6fkgEdGJQ@mail.gmail.com>
 <a12573d18f7c8bf73c24c572e43965e3f250acea.camel@arm.com> <e114bf8d2e7b6c0874fffdf8867c954a08772da3.camel@arm.com>
In-Reply-To: <e114bf8d2e7b6c0874fffdf8867c954a08772da3.camel@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 May 2024 12:18:58 -0700
Message-ID: <CAM9d7cjmH=nkEt-z_XpZ1J0oL-EY2d52oz70-KpN+uzM5SEk6A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, James Clark <James.Clark@arm.com>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "irogers@google.com" <irogers@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 29, 2024 at 10:48=E2=80=AFAM Ben Gainey <Ben.Gainey@arm.com> wr=
ote:
>
> On Mon, 2024-05-27 at 18:47 +0100, Ben Gainey wrote:
> > On Thu, 2024-05-23 at 18:41 -0700, Namhyung Kim wrote:
> > > On Tue, May 21, 2024 at 6:30=E2=80=AFAM Ben Gainey <ben.gainey@arm.co=
m>
> > > wrote:
> > > >
> > > > The tool will now default to this new mode if the user specifies
> > > > a
> > > > sampling group when not in system-wide mode, and when --no-
> > > > inherit
> > > > is not specified.
> > > >
> > > > This change updates evsel to allow the combination of inherit
> > > > and PERF_SAMPLE_READ.
> > > >
> > > > A fallback is implemented for kernel versions where this feature
> > > > is
> > > > not
> > > > supported.
> > >
> > > But I'm afraid the test would fail on old kernels.  Maybe we need
> > > to
> > > put it in the selftests.
> > >
> >
> > Sorry, not clear what you mean?
> >
> > Is the issue that the fallback on older kernels fails, or that the
> > "perf test" tests fail?
> >
> > Thanks
> > Ben
>
> Just to follow up, I've rechecked the fallback on an unmodified 6.9.1
> kernel with the following:
>
>     perf record -vv -e '{cycles,instructions}:S' ls
>
> With an unpatched version of perf running on an unpatched kernel, the
> cycles event is opened as:
>
>     ------------------------------------------------------------
>     perf_event_attr:
>       type                             0 (PERF_TYPE_HARDWARE)
>       size                             136
>       config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>       { sample_period, sample_freq }   4000
>       sample_type                      IP|TID|TIME|READ|ID|PERIOD
>       read_format                      ID|GROUP|LOST
>       disabled                         1
>       exclude_kernel                   1
>       exclude_hv                       1
>       mmap                             1
>       comm                             1
>       freq                             1
>       enable_on_exec                   1
>       task                             1
>       sample_id_all                    1
>       exclude_guest                    1
>       mmap2                            1
>       comm_exec                        1
>       ksymbol                          1
>       bpf_event                        1
>     ------------------------------------------------------------
>
> whereas with these patches applied to perf, on an unpatched kernel, the
> output is as follows
>
>     ------------------------------------------------------------
>     perf_event_attr:
>       type                             0 (PERF_TYPE_HARDWARE)
>       size                             136
>       config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>       { sample_period, sample_freq }   4000
>       sample_type                      IP|TID|TIME|READ|ID|PERIOD
>       read_format                      ID|GROUP|LOST
>       disabled                         1
>       inherit                          1
>       exclude_kernel                   1
>       exclude_hv                       1
>       mmap                             1
>       comm                             1
>       freq                             1
>       enable_on_exec                   1
>       task                             1
>       sample_id_all                    1
>       exclude_guest                    1
>       mmap2                            1
>       comm_exec                        1
>       ksymbol                          1
>       bpf_event                        1
>     ------------------------------------------------------------
>     sys_perf_event_open: pid 3442954  cpu 0  group_fd -1  flags 0x8
>     sys_perf_event_open failed, error -22
>     Using PERF_SAMPLE_READ / :S modifier is not compatible with
> inherit, falling back to no-inherit.
>     ------------------------------------------------------------
>     perf_event_attr:
>       type                             0 (PERF_TYPE_HARDWARE)
>       size                             136
>       config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>       { sample_period, sample_freq }   4000
>       sample_type                      IP|TID|TIME|READ|ID|PERIOD
>       read_format                      ID|GROUP|LOST
>       disabled                         1
>       exclude_kernel                   1
>       exclude_hv                       1
>       mmap                             1
>       comm                             1
>       freq                             1
>       enable_on_exec                   1
>       task                             1
>       sample_id_all                    1
>       exclude_guest                    1
>       mmap2                            1
>       comm_exec                        1
>       ksymbol                          1
>       bpf_event                        1
>     ------------------------------------------------------------
>
> The command falls back to the same configuration as was previously
> used. The same is true for the instructions event.
>
> `perf test` fails on an unpatched kernel in "15: Setup struct
> perf_event_attr" for the test "test-record-group-sampling1" but that is
> surely expected for unpatched kernels?
>
> Is there some very-old kernel version where this would be expected to
> succeed by accident?

I don't think so but I don't want the test to fail depending on the
kernel version.  Maybe we can check the allowed combination
first and skip the test if perf_event_open() fails.  And then it can
verify if the kernel rejects the unsupported combinations.  Not
sure if it's easy to do that in the current attr test framework.

Thanks,
Namhyung
