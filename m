Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FA139D0A
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Jun 2025 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264970; cv=none; b=Y959yyt6hLzSmMQyhNL9ZQ74pLeC5eOqyj3g5awBXFxw+D+BHGZKR56osHzc4qevVQFQUe5zn6XGot3Si6N0pGoXRlyeq16EuRCJAvxswcNDiqF+s6HK11iWv69cPBwKfY001ArWAYnB8NTXKBCV4TZ7KtDa7mnZKWHWhiA0I+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264970; c=relaxed/simple;
	bh=/48P32ijFzoxC/Rcque3bPwNScUR+vA7vZs9TfeU/ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdn3hOi2gzEvjEk8EMS+z+ZlUB9cbE5a34nMQrZfESF0iIKeuTssiZJI8DJVcKisIqroFAkW2sfxPHUFEzr2dRtJ1N4VLVp15DEYWVCKWywaZAor9/iwfd0j4qSji5aO9etly6Xp26QBQX67A91s7/BTi/m3LInPdYPrVHwjmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wziDc9EL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wziDc9EL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60768e108baso2685143a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749264966; x=1749869766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBwuS6lp3dTf3+9IER3gtiWhPdetZ3F/Kvrweuj6c8w=;
        b=wziDc9ELKT3dINneNVKB1CywkPSiMZQm2RkHjB+l86Cyb8drw73lN2BenDMhBFzOw2
         ZfWutv20EMXHdgjfy/WhYCRDlh85/I0xhHntpJu0EY4UAxbv0KPoO9cL+FNmMQQKau7a
         gs1rZ42lqE1gAlMowgqnSto+RYpcmrwwk3ahyBXWdx0p1tO9MVOYQMxFprS+Db+RubZ4
         TM9ZVBIDvoH1PACwVnm7NjLwrBm2yZkXN7ELa2A7g+kxlW21sGToH9pbkP7V6C2GhEmL
         juGJzHR5u0j6Xo6fjm/23e8Cp4Z4xifkLhJ0Nwx+eazjdY+R6LOjhP/jYRDdR4cNjWB3
         XHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264966; x=1749869766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBwuS6lp3dTf3+9IER3gtiWhPdetZ3F/Kvrweuj6c8w=;
        b=hjb2xYixd6PJivCTi3OMhpVovY3GtFYldl81lssM+nGNdxu14oMsACVHoVELt7FQ0q
         xJi/88oZ3ni8eBRU8kpfIWurvZ+lQzy/b03Ck0+fRti5LfEQmn5FaZoKQ7uk+egZRRLf
         VGw7c4X9hrgbe2yCQE9HspUv2z28AsMYQ49RGYPIJVOu5L0B2CtKgXdhMXZTFXIFCjQm
         bu4Ti7tDQ8oOK+4oMTSi/ZfCldblGezO+9zCW0uZtIiWdo1LhRmgfhkZ88RLpy6CPU74
         xybLjh5onmOwtcuVub6Iuvgc08zXdUK/h8PTRrUanXFmJdNXHTl0Agc1FQcdJ+CiC7mf
         Jbkw==
X-Forwarded-Encrypted: i=1; AJvYcCUmfTw3LNfeeOHMSSWfaqn2jpIbNVWQ5jritKG2zjBELl6zh8E+p23TcsyU6xL6JUaxr5yx6Q0kUQ5AfmkQICo5@vger.kernel.org
X-Gm-Message-State: AOJu0YyspIA+eS7cX8Z0MB+GfE7lXjqPvFZM0qCiD63UiCOu2rWmcyLC
	C+v1/CbDhFVh2n2ouoY5eJ12o4oNbmomg0Cud0+kfzt2KtU0+yOPkMD18Sz5CRp4HO78TPnzR/T
	Yt1Tv92TswgylbuaFUeowJ1uU3umYKwJXLpfcxnu5
X-Gm-Gg: ASbGncsqf/lCodq5qY7kyKHA4Z0jWkJZfS1m9y6jjuPbfXQQzJqXYVVI4+E6TVoww8V
	7FaXbyCi4/nMxzQRxvLy5NVH7YAgnxa0giLgHy05YKzeKkMUX8EoA0P5azNrZG6p+o8bnH4DLUK
	iyduwUfalOKBqsxyYlzjsLCuA7p1Xze02pE8vl+4+dhg==
X-Google-Smtp-Source: AGHT+IHJCZebGgjyJO17uG1F1i8wPHijoEc7hEla+k60E5llZdICFrh6CbER2gg43i5MjcVWFm5kWnH+KYgI7nD9P2w=
X-Received: by 2002:a17:907:940e:b0:ad8:96d2:f3a with SMTP id
 a640c23a62f3a-ade1aa0fc92mr468400266b.8.1749264966154; Fri, 06 Jun 2025
 19:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEHugAPinlWLuTAS@x1> <aEMqwmCmbyAlb1Y1@google.com>
 <aENM_KGb-x14pHRX@x1> <aENOrmDxKPYAaYNR@x1>
In-Reply-To: <aENOrmDxKPYAaYNR@x1>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 6 Jun 2025 19:55:54 -0700
X-Gm-Features: AX0GCFuGD45yemnNiPWTYMgSjjr814i18fpLyo-SPtnOOxM1kwn_DTMqaaZUluc
Message-ID: <CAJpZYjU3o0uFbDNhttpRFOv4j+RfTfdJqeP_4bejp_-_qoUkDA@mail.gmail.com>
Subject: Re: [PATCH 1/1 v6.16] perf test event_uniquifying: Skip test on
 platforms without 'clockticks' events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Howard Chu <howardchu95@gmail.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Weilin Wang <weilin.wang@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Arnaldo for finding this problem. Please feel free to amend your =
fix.

-CT

On Fri, Jun 6, 2025 at 1:25=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Jun 06, 2025 at 05:18:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jun 06, 2025 at 10:52:02AM -0700, Namhyung Kim wrote:
> > > On Thu, Jun 05, 2025 at 04:22:40PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > I'll add this to perf-tools for v6.16, please check.
>
> > > Plesae see
>
> > > https://lore.kernel.org/linux-perf-users/20250521224513.1104129-1-cts=
hao@google.com/
>
> > Oh, great, I'll drop my fix and get that one instead.
>
> Nope, that one returns ok if the test can't be performed, it should
> return 2 so that it is skipped and since we don't have a way to show the
> reason for skipping a shell test, when using 'perf test -vv' the warning
> that is there already (the needed PMU not being available) will be
> shown.
>
> So I'm amending this on top, ok?
>
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/per=
f/tests/shell/stat+event_uniquifying.sh
> index 5a51fbaa13bb9b3c..c39d77ab4ad95bfc 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -47,6 +47,7 @@ test_event_uniquifying() {
>    # Skip if the machine does not have `uncore_imc` device.
>    if ! ${perf_tool} list pmu | grep -q ${pmu}; then
>      echo "Target does not support pmu ${pmu} [Skipped]"
> +    err=3D2
>      return
>    fi
>
> Then we get:
> root@number:~# perf test uniqu
>  93: perf stat events uniquifying                                    : Sk=
ip
> root@number:~#
>
> Instead of the misleading:
>
> root@number:~# perf test uniqu
>  93: perf stat events uniquifying                                    : Ok
> root@number:~#
>
> With -vv and the fix:
>
> root@number:~# perf test -vv uniqu
>  93: perf stat events uniquifying:
> --- start ---
> test child forked, pid 94671
> stat event uniquifying test
> Target does not support PMU uncore_imc [Skipped]
> ---- end(-2) ----
>  93: perf stat events uniquifying                                    : Sk=
ip
> root@number:~#
>
> - Arnaldo
