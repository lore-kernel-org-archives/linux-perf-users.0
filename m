Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864C226888
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512308; cv=none; b=I030GTouUY72DK9ui7pl9KntgAPcu4EAtF3+LHFKPNXqCVoQ9Xc076P/bqBVBnpz+5sNholtbGWJW9VGzP90BWmcLCY3vHjiTajTrtceHAHh4BtrLQNxgCHDu8G3/pNhPCqHCfSsHUE9zuV2X+8wek0AAuPqjGeYBswJtCVq85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512308; c=relaxed/simple;
	bh=VRACqwLtqG405sUQP9wgEUkAKSCxa6x4ikdBLq1iZFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cgfjn0vBgBGpULtcSBWwNKMwMuC4Qo8cXDoax+4FD/b+A85RnkrbgzYVNhIG4/OC9G1Z7IE3ZU4th7eZwytEJqHDLmXVaWK86T5Vd0FYvfxAtNrTy+1hc/iUgHcX5T8LoQUT/iUJfYdxnQn7whO6xOFSV85qZdazVIPtJooUCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUpzWb3g; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUpzWb3g"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3de210e6076so48415ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751512306; x=1752117106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMs1iA4VzQfj9dq/bOJSB/O8bvX9Hz97FNpAqXL/LkI=;
        b=hUpzWb3gOMQNQ1gDGFeurS9O1MWtBLl/DYj8xjA/EfIC1ib7sbujoYZcnX4roFF/PW
         INVxwKl0t0+Kv8kL+f1eGV+r6oZvcuC9BGNy6pg7uzUBGoHpuG+jFOZWgK0K64FzDEF+
         LmtZ/JGlDXcvSmzIzhvS2799irWVXsGbNIx4909jdo6miUL1GiUG/GxcI9LXmQxovfil
         AZfUKJX6CPb8uBa3/MXeHPxrYNHr6oaNCVweuwu0aYZRS7ooYSpGFg+4viPH2AMoEQrX
         BqaQ4I3fAV6bZbqmZPmgqFglY+9e21aIfqWT+dpcBjdNvHBoF9BlGjSj3pgfCCJm+kWn
         5EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512306; x=1752117106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMs1iA4VzQfj9dq/bOJSB/O8bvX9Hz97FNpAqXL/LkI=;
        b=Y1aOsgzWnnJlXHf6A+f/p/boXRb6EzlseJLBcSNfVwuUPMoTAExUXb7WgkDVCzuXDe
         BskF43mHpHrARWkkWVEY/qXwRO32tC3239V4RIw2xSiOEEdA6m3ZimPmMyrDEBEYXRD1
         Ewy+jgYbnX1wEpZohAYRq8m6EYS5VNhof2Woa3IfLEsyLYSbLXsPcO4WQbxanJKRuEjP
         XoZ3usXjNfDTTIXa6Ib28+ACyFvvJK2VPMuCjZ5yl0hQHtJMzqy8OXVQF5E3s87W44k/
         UGnWbeg1i2hmWYwS/U9r/YQWMeQpXIhl9iA2icDpmEgAFbziZ/4en+LLPX+hvJa0XrY7
         /KlA==
X-Forwarded-Encrypted: i=1; AJvYcCWMW6NwyO9etGsqCoKxT8AQ0+o44pu9yI4hGW2lmj5PZAw4ScnFsmKztu1I6nH1y+qrylBtW/bmTD5njaBcbzdH@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHjp6MEwYIo/ShOWChxUgVQXJmzAGvPGOtMMO4/zVRpdbAuNg
	5xiW3EKkz7bjLb+iPoKmxWZ3FLU90MInBS+EKVMXCF6JA99st5i9Uz9kQLkFKufCFEd2VYvPvIW
	rr2dBvXdWEGyb3PWiYA8POxmH14BXD3kbge8KcpAm
X-Gm-Gg: ASbGncvm5I3P0YojW82tGGrMg1uL/HBCQs4bmmPvsttiTAJU44As3cVI5OmZCRG5801
	jLmJjtk/AOIgrmYlLnBqJBPTy74tKfkpJV1imfjjqIwGBGj8EZP3N6genrTMlfhyaHLFjBzmT8v
	QzFks0K0+/zMXpr5BLf7yv+Pml0kxDjjIuXwC30pllvhYX
X-Google-Smtp-Source: AGHT+IE2uy6ZtAAR4XNqkkpMC5NW36o3cJ4DiEPaTAbIb7LdQWZIujiawdJrL3M0BAkOiT54KCzcxADDJG1aaEk8EIA=
X-Received: by 2002:a05:6e02:2509:b0:3d9:6c99:5a83 with SMTP id
 e9e14a558f8ab-3e05c7b2fb2mr2110175ab.8.1751512305627; Wed, 02 Jul 2025
 20:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703014942.1369397-1-namhyung@kernel.org> <20250703014942.1369397-9-namhyung@kernel.org>
In-Reply-To: <20250703014942.1369397-9-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:11:33 -0700
X-Gm-Features: Ac12FXxEwm4Ubryr2j9csHROXsk6a4uajgH6t0MVbO3w6B2sd_FGylhxC7YHyuE
Message-ID: <CAP-5=fVnFzA7ocHu4ivuc0A=85W-TNhTGUjxnMgBCXX34BrJgQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf test: Add more test cases to sched test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
>   $ sudo ./perf test -vv 92
>    92: perf sched tests:
>   --- start ---
>   test child forked, pid 1360101
>   Sched record
>   pid 1360105's current affinity list: 0-3
>   pid 1360105's new affinity list: 0
>   pid 1360107's current affinity list: 0-3
>   pid 1360107's new affinity list: 0
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 4.330 MB /tmp/__perf_test_sched.perf.=
data.b3319 (12246 samples) ]
>   Sched latency
>   Sched script
>   Sched map
>   Sched timehist
>   Samples of sched_switch event do not have callchains.
>   ---- end(0) ----
>    92: perf sched tests                                                : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/sched.sh | 39 ++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sch=
ed.sh
> index c030126d1a0c918d..b9b81eaf856e6555 100755
> --- a/tools/perf/tests/shell/sched.sh
> +++ b/tools/perf/tests/shell/sched.sh
> @@ -56,38 +56,61 @@ cleanup_noploops() {
>    kill "$PID1" "$PID2"
>  }
>
> -test_sched_latency() {
> -  echo "Sched latency"
> +test_sched_record() {
> +  echo "Sched record"
>
>    start_noploops
>
>    perf sched record --no-inherit -o "${perfdata}" sleep 1
> +
> +  cleanup_noploops
> +}
> +
> +test_sched_latency() {
> +  echo "Sched latency"
> +
>    if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
>    then
>      echo "Sched latency [Failed missing output]"
>      err=3D1
>    fi
> -
> -  cleanup_noploops
>  }
>
>  test_sched_script() {
>    echo "Sched script"
>
> -  start_noploops
> -
> -  perf sched record --no-inherit -o "${perfdata}" sleep 1
>    if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
>    then
>      echo "Sched script [Failed missing output]"
>      err=3D1
>    fi
> +}
>
> -  cleanup_noploops
> +test_sched_map() {
> +  echo "Sched map"
> +
> +  if ! perf sched map -i "${perfdata}" | grep -q perf-noploop
> +  then
> +    echo "Sched map [Failed missing output]"
> +    err=3D1
> +  fi
> +}
> +
> +test_sched_timehist() {
> +  echo "Sched timehist"
> +
> +  if ! perf sched timehist -i "${perfdata}" | grep -q perf-noploop
> +  then
> +    echo "Sched timehist [Failed missing output]"
> +    err=3D1
> +  fi
>  }
>
> +test_sched_record
>  test_sched_latency
>  test_sched_script
> +test_sched_map
> +test_sched_timehist
>
>  cleanup
>  exit $err
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
