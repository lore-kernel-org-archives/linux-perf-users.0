Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5145979
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919188; cv=none; b=btvDw7upC9Zq3zevjdxvrPRORHtydnhcjH7UxFxrZiwyfEYkten43d3G51NyDKxIf6Txbl5WXOHHASrRN2P6/vxOjlj7qYlprgDK5sBk3TwcTGZPquuAiQ4CxfSpS0dRMbG1xcNwWH9aRAEPoqqJcE98hGB7c+Z1peP6QXn7/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919188; c=relaxed/simple;
	bh=72WsRYhKuUKJMpOR7EBqv7G/wkvArhvNvja90/TzAy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/z5OUrS4UzAGxBPlWSCapqiyhi8C6Bt1C16jNgPUzvM3IwssldkAsS1BoRbZRxrZHcUUk6jFNqhe5FV1kQOxlA2piONvGVlC1d0449CadpH6dsVFVrwJ2WebHT4W2CVzC7nBnQ95r+xouDnHhR30vv87HsT/8NYnDF4649U1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+/+Clto; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+/+Clto"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso2158a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716919185; x=1717523985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1Fj0jA4xvnb6MvCjHyiX5Ob+tMjMXGvJSSTYFMvZUk=;
        b=A+/+CltoBO4es5oUOvikG/xiVd4F+fp8FJknEC1PCvAapP0dAdZ0BxHNCoo059n3fL
         eppNYhnnSOp6Fs4K5RXFJWSg3pK3+4yX7xFi2ekCrZx7tZft9EexyOoVln3NPkX0sQ7n
         C7KbWGPRJOKqQIrggVBZ9Z/Nc+9oBJFtaNgG0xssqCgZnoyrosGehX3cu7uO+K1MSIWB
         NUOuseE8YyrpW+x4tYrA1FGBFKo9n1eIO5WURQMBLHUeShf0CTptp2bsqisQ+LZPbDRK
         XFoo5WEKx/b8RZkwiPGjAGJK9p6AMN/0GcT+z1eyDnyz1JnOMLa0nh306yQUJ8MeJcUZ
         vSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919185; x=1717523985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1Fj0jA4xvnb6MvCjHyiX5Ob+tMjMXGvJSSTYFMvZUk=;
        b=YMnvzJILKd/GZxPRvPW9Ux3ABfuIi3OzFjxsC/01ZDG5K6coYzKv7GTnxiO+5mQJr+
         JKjdf+FSsDT9akUVo17Jj0ya91vZYC8G33V51MbTQOjUy4oIh6dhcPJFSr3Pmn1p1MFo
         N5LRl/C7y3SL6ozrwTx7UjUl9uYtjrTpV3Jsn5JQk0f9WCs4BgFaBWt2cwiMzxmbg7UM
         SKIgPgvEQ8EhGKZwPgFkZYYPujSRXKTenb1sYfxWANVbDMuxnXMWznOa1UnKQ/5O0g1J
         HPotBNcsMAAZLfw4SDqbmZvT/x5hy1hNXDu5RQi7Jocsy83tBReophcxldj9VKvibzVU
         xgeg==
X-Forwarded-Encrypted: i=1; AJvYcCUaa8dbLK+jzFkvMPqCJz67XcKA03S7HfXm+8hH0Zw0cjc6085b8WT86awKsHPb0oCfbyxV5DOiw6OM7gp9cyzMnzpPNYRcqtYGebr5xPvmpA==
X-Gm-Message-State: AOJu0YwBSMY7LrX8SbdqAANpeZsxFe4JcZmbHKpshCYqPHbbuexo2fLH
	CU4hsucpXFwFlNSB+ZWNJIHOwjQPE2dp3NaTWIe9S/9BA8p+btOryxEo6UJmRFdQgZis9cClygK
	IqK8ti8O+btnaFSA1pnLPd58RJ0PYdS8dUAo=
X-Google-Smtp-Source: AGHT+IGJqOi1xS3B+ok1xdaUbGB4iWRTymvvpz7+ZUp8pp7Hlw/1kIDQEPcxbHVl6fe64hlWwTSkckBfdjI8U6vQW7s=
X-Received: by 2002:a50:ec93:0:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-57a027edcafmr10452a12.7.1716919183916; Tue, 28 May 2024
 10:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com> <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
In-Reply-To: <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 28 May 2024 10:59:30 -0700
Message-ID: <CALJ9ZPML-QNcsJfo6tBMfmJzb=wF1qQsMFTbNvtRwH-++J1a2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
 helper functions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 9:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, May 15, 2024 at 12:36=E2=80=AFPM Yabin Cui <yabinc@google.com> wr=
ote:
> >
> > Hello,
> >
> > We use helper functions to save raw data, callchain and branch stack in
> > perf_sample_data. These functions update perf_sample_data->dyn_size wit=
hout
> > checking event->attr.sample_type, which may result in unused space
> > allocated in sample records. To prevent this from happening, this patch=
set
> > enforces checking sample_type of an event in these helper functions.
> >
> > Thanks,
> > Yabin
> >
> >
> > Changes since v1:
> >  - Check event->attr.sample_type & PERF_SAMPLE_RAW before
> >    calling perf_sample_save_raw_data().
> >  - Subject has been changed to reflect the change of solution.
> >
> > Changes since v2:
> >  - Move sample_type check into perf_sample_save_raw_data().
> >  - (New patch) Move sample_type check into perf_sample_save_callchain()=
.
> >  - (New patch) Move sample_type check into perf_sample_save_brstack().
> >
> > Changes since v3:
> >  - Fix -Werror=3Dimplicit-function-declaration by moving has_branch_sta=
ck().
> >
> > Changes since v4:
> >  - Give a warning if data->sample_flags is already set when calling the
> >    helper functions.
> >
> > Original commit message from v1:
> >   perf/core: Trim dyn_size if raw data is absent
> >
> > Original commit message from v2/v3:
> >   perf/core: Save raw sample data conditionally based on sample type
> >
> >
> > Yabin Cui (3):
> >   perf/core: Save raw sample data conditionally based on sample type
> >   perf/core: Check sample_type in perf_sample_save_callchain
> >   perf/core: Check sample_type in perf_sample_save_brstack
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>

Hi performance events subsystem maintainers,

The v5 patches were modified based on Peter's comments on the v4
patches. I'd be grateful if you could take a look when you have a
moment.
Thank you for your time and consideration.

Thanks,
Yabin

> >
> >  arch/s390/kernel/perf_cpum_cf.c    |  2 +-
> >  arch/s390/kernel/perf_pai_crypto.c |  2 +-
> >  arch/s390/kernel/perf_pai_ext.c    |  2 +-
> >  arch/x86/events/amd/core.c         |  3 +--
> >  arch/x86/events/amd/ibs.c          |  5 ++---
> >  arch/x86/events/core.c             |  3 +--
> >  arch/x86/events/intel/ds.c         |  9 +++-----
> >  include/linux/perf_event.h         | 26 +++++++++++++++++-----
> >  kernel/events/core.c               | 35 +++++++++++++++---------------
> >  kernel/trace/bpf_trace.c           | 11 +++++-----
> >  10 files changed, 55 insertions(+), 43 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
