Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C101D61A3
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693310; cv=none; b=n8DgOOifQMmVP8HDsaFE8m8FYD6BVDwB58jAx1dNYOchL+YsKN79Omwa01gdYx2viWHEtwutc51WS2Ht067KOnkDWDfT6HQkkvZWDMVOYD45xfz7O/7d1F76mt5e5AhWMp7mOqMkoYGFZC+5/ZM3YkO9XZI9hZrkGxq/fTffxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693310; c=relaxed/simple;
	bh=Dc/5CWn5I9oj0IhCuyvb47QZKddMSwNPrXDwm06esJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFmBNkK2TxUzyyIuBTJ/PCB+tYbYPUQBtAA1tpdWbi6x4ukF5oXqSoR1TCkyuehX8lb/hMVMALFVBGmnwYlIcz0cWzyKkKF5SqwS5AoDEEGF3vDV5N0JfMIdcYrh44moeSlcLasSsEeCuE3lcgX5KReLfNDGucLfpBnW3u2Gtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvehh1DR; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvehh1DR"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so137075ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 09:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731693308; x=1732298108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnHS6ipKNUUpXk/6JmH9J/OJBc1PBR+N05vgPQHYS08=;
        b=dvehh1DR0/Di6XWMW+AmghMfE2Fk/Se9bNDiGSmgRjO16FUideu/VZKrJNKvxCgYKz
         0RPB+0SslcB9C9IQuhYsg/Q0lK1sYXw0DkvR2RVAqwjEkGK5u3BLE7NHN7OPyN40IcDh
         moMNd+v+v0uyVcnM3rKb6JyIN0Wp1JOR8EgmoE4jHcm0WN4ljT78XFPA1zjMvYea599t
         FvVvuukHCeiXAStKphDMgjW538oVpQKQ3fxk5NHOlHO+s3aztNJlMaYa0vwRI6RrBjEy
         sGHdQMcahXZQuFW4tR736xzcLwg8vs35OXZ87hA0a5nVdEXKBroL1p+h6heJ077ApVT1
         DDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693308; x=1732298108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnHS6ipKNUUpXk/6JmH9J/OJBc1PBR+N05vgPQHYS08=;
        b=sg6J4bqb55Qk1UTjvbJqO9XtZbDU0CCnTAU13hDgjOUm9vabGzRnUXK+vF/W4dd6Tm
         7zNLb1C8gKvEaGLbAStm1z8vn4tuijEXDNaWip8/dkxGUbC7m3ZwBDabq03AbMdaMsWv
         2jvLgYstwnfcGBQX+YyqZllHuS3krJZcFBm3to+oLh+WIYGTKXj1UWJ5LOuC73O9wDGZ
         u2BvGf91TdnnXNlIFEl8xOX97sTOXQmUj/qVv+Rn6TGPA4HYPmknevXrYl8zC+EpecmL
         2FAWZwFDMyVIqy4oFStWgBIn6Y+25KnHmzV6GrzyZHpqq2r2iwf07bZc3OyJ+L8etcOZ
         8v4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnJpPI0I51/zud8FY3/zvQjMs/U7uKN+Eua91ZvF0n9q09c4HQUgUCAnxDTnCYr9LV1gBnt4ld9hVSX8d+qZ53@vger.kernel.org
X-Gm-Message-State: AOJu0YzATZ+tcHpmHIV+CgHQ0UV1jRP28UARR7Zrh6pBOBCiXaEx4Ypc
	qq16C62Oei4thOUkR7P/OjdXQ8BZ3qbkRv9eVHPFjVhhU37DIWEA++/QT1mY46VwHmN5wj/Ukz8
	Rq+Pv27LPH8k71BGqhEaMl7M1oe5gz0yORcCW
X-Gm-Gg: ASbGncv8hJlv2mXQO1qzDuP3di7vgvkYpqS24zK7da7aB+hYfOIGGAdAIDtK4RF2xkV
	qs+O+6Jm+FYaHF2+2KypOkuGwkoQxZuh4
X-Google-Smtp-Source: AGHT+IGFQN2nBXFYab64aGS4JtOZbQ+HWAGUOdHNwbOsju2UCSDpdaV9yh5k0nEy6/NghsRYHkioIry2Xz7RaFY58EI=
X-Received: by 2002:a05:6e02:1a0a:b0:3a7:319f:e486 with SMTP id
 e9e14a558f8ab-3a74f776eefmr581795ab.7.1731693308209; Fri, 15 Nov 2024
 09:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zzdtj0PEWEX3ATwL@x1>
In-Reply-To: <Zzdtj0PEWEX3ATwL@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 Nov 2024 09:54:56 -0800
Message-ID: <CAP-5=fX7JZNmiaNDezExqGk9FMXdHihxvLNmnD8HHB3YCehemg@mail.gmail.com>
Subject: Re: perf test failures with tmp.perf-tools-next
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 7:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> With what is in tmp.perf-tools-next I'm getting:
>
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name                                         : FA=
ILED!
>  84: perftool-testsuite_probe                                        : FA=
ILED!
>  86: probe libc's inet_pton & backtrace it with ping                 : FA=
ILED!
>  96: perf stat tests                                                 : FA=
ILED!
>  97: perf all metricgroups test                                      : FA=
ILED!
>  98: perf all metrics test                                           : FA=
ILED!
> 117: perftool-testsuite_report                                       : FA=
ILED!
> 118: Add vfs_getname probe to get syscall args filenames             : FA=
ILED!
> 119: Use vfs_getname probe to get syscall args filenames             : FA=
ILED!
> 120: perf record tests                                               : FA=
ILED!
> 121: perf record LBR tests                                           : FA=
ILED!
> 128: Test data symbol                                                : FA=
ILED!
>
> root@x1:~# perf test -vv 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test:
> --- start ---
> test child forked, pid 391389
> hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
> hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
> ---- end(0) ----
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name:
> --- start ---
> test child forked, pid 391390
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-BA-3
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'pwm1'
> Not a hwmon file 'pwm1'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'pwm1' that has no input file
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event=
1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'temp_test_hwmon_event1'
> free(): invalid pointer
>
> ---- unexpected signal (6) ----
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name:
> --- start ---
> test child forked, pid 391391
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-BA-3
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'pwm1'
> Not a hwmon file 'pwm1'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'pwm1' that has no input file
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event=
1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'temp_test_hwmon_event1'
>
> ---- unexpected signal (11) ----
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@x1:~#
>
>
>
> I'm working on removing the vfs_getname code from 'perf trace' so those
> will go away, probably there are patches fixing some of the other ones,
> I'll try and look after those, but probably later today I'll push what I
> have so that it gets exposure on linux-next.

I'm trying to repro the hwmon issue on tmp.perf-tools-next, with asan
root/non-root I get:
```
 11: Hwmon PMU                                                       :
11.1: Basic parsing test                                            : Ok
11.2: Parsing without PMU name                                      : Ok
11.3: Parsing with PMU name                                         : Ok
```
I'm trying more machines to try to get a reproduction.

Thanks,
Ian
