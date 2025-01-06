Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A11E049F
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200778; cv=none; b=c0FtbvIda1OEb4ZTx/l7Fm6HGcb5A932nJarwDEUq+7fmsAckDA4PnngMKHR+4zzkE12RiwU6etx9GTqCwu3ZgjWEdlKfDok9jIvXF6JhaH9RR0VJ8EYgm48WZBWzM5nKa5EjLnIQMnI6LOjepyihUZfijTS3ARZD6oihN7ECac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200778; c=relaxed/simple;
	bh=rzzeei0/SImU5lnAmGz8PyLgz3EBRWIr6q/BwRxiJMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6jlvZpa/UxzcnU5gfcyLf+sh/Fe6SmthM+CQ4ROebJXRIbduDBPk6S+WoPiR+Pf1IH1jcDNGdVMrIFmuuK1TF7htj9gstmxnEe9L5LBonK3Laj+m3aBhYHXrZ8qj4HI33K9VAPKsVqN3OVJe7m3gocUzc33p1Vi9s9SpSPOn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fVYtR71; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fVYtR71"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso10595ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 13:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736200776; x=1736805576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYxcRxnxvVhgv+dhrIwA9mOZtcWh5GK/IoKaPCpfDhg=;
        b=3fVYtR716D7Hvq6jhUuaZFHm8sKNCoSj0h1QZsp7YFjfdZZRNlUPcliNyIbi9IonzJ
         ox5S6sFywTUQMsWxxcQHrO5K6pMGnRrQPYNL2I02mDjnuec8NJCgP8omEkNLVXiHMnOQ
         JwBt3MMV/xkWzPqk7kwPS8vgOlWrkFsS+XorFBDZZEO+PQRz1Bri1/2VUoNdJXMmPSVm
         8K/cfxLqbIP8V8AwDzkTMZcpQTJ8T7OfvT14R7fzFtHTs1CZe5Eox/W5eujKGRSC/97U
         dRasKr97+v8ImnJ0G7U2w6DM30V+OHx4+08LBmS21DRhxv8nSlChyF+mR2PFDMJzNDt4
         uUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200776; x=1736805576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYxcRxnxvVhgv+dhrIwA9mOZtcWh5GK/IoKaPCpfDhg=;
        b=ICAX3Iu1MbHxJngS01aZSOGIPW3Ugj+PY4Kfsn0/2Q2q6yXgqDi5I3FF1SE0dQj6bE
         6Tc07OtDyXDtt90PGC4ZQwfjRIJxHtMqFKOzW/vQ2uzo0yEAeeElDrM2GMK2ZF8UFN2V
         6hLx9L+jabS4reBIlJFPhQuxMwzR/g/Yxg6ugkONsb4iyOnLLIsoodpM83SRHlORJRZr
         yeMpYf0V7dzrMHWQXe0hk2uqfw96/RY8+xff1zcQzfmalNWFq9Y+Fa3+QZqPhlk46y28
         Sat5HxfwqwNL90TdYo8oxsM6gysIybahYmf2qhY+86zQhFU+ldNChHFDM0mFIYwa9wSE
         b5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXbUu1iojxbm/8OwmgCZjRKSbCxWREQY5oI9nOjIjWZOLmmnVfw8p1OBbYVM7bMJZo7iO2UX76o6KYkXT9MFBo@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBqJjphxosxc1hihM/9YqPAFT8T0fnBnoQYtsKX5jrn+oK4s/
	AbOPEKomgoSAv8glBTsL9xe/HKI1zUn6tXQ15C8/4SGlz6dmQPe2C731NvBRGUN0IdfgsXPkzvK
	EYIDkwRwUXBrLOyVcsFv3F5y1P1FeFQMhjkr3
X-Gm-Gg: ASbGncvT3mBLE7XqDs6/GUZNXPQi9lGpwXuy/edN4M5pvR8DKDP1qR0Rvw99RqvA/za
	VKFpai3d1nZ88xFeAFORW4Ch7pGjy76wmffYW2F3wgwBARa0jckZ1yEfw+wX3hpL+L9lt
X-Google-Smtp-Source: AGHT+IHe3YR4JRkQefWueAUct9RpLCH5RbzZJFmxoF5ot4fIMmt6Ez8JLdaAmT6sJxCVzTFxzGh5dFjnijZpuud1Uoo=
X-Received: by 2002:a05:6e02:1525:b0:3a7:ab4c:115b with SMTP id
 e9e14a558f8ab-3ce323fe0b2mr1019185ab.10.1736200776241; Mon, 06 Jan 2025
 13:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com>
In-Reply-To: <20241106003007.2112584-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jan 2025 13:59:25 -0800
Message-ID: <CAP-5=fVyDp2TcUGfmxRoKnE8yOp3xgfrJ5tagMiaieTjepEF+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf evsel: Improve the evsel__open_strerror for EBUSY
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> From: Ian Rogers <irogers@google.com>
>
> The existing EBUSY strerror message is:
>
>   The sys_perf_event_open() syscall returned with 16 (Device or resource =
busy) for event (intel_bts//).
>   "dmesg | grep -i perf" may provide additional information.
>
> The dmesg won't be useful. What is more useful is knowing what
> processes are potentially using the PMU, which some procfs scanning can
> reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:
>
>   Testing intel_bts//
>   Error:
>   The PMU intel_bts counters are busy and in use by another process.
>   Possible processes:
>   2585882 perf list
>   2585902 perf list -j -o /tmp/__perf_test.list_output.json.KF9MY
>   2585904 perf list
>   2585911 perf record -e task-clock --filter period > 1 -o /dev/null --qu=
iet true
>   2585912 perf list
>   2585915 perf list
>   2586042 /tmp/perf/perf record -asdg -e cpu-clock -o /tmp/perftool-tests=
uite_report.dIF/perf_report/perf.data -- sleep 2
>   2589078 perf record -g -e task-clock:u -o - perf test -w noploop
>   2589148 /tmp/perf/perf record --control=3Dfifo:control,ack -e cpu-clock=
 -m 1 sleep 10
>   2589379 perf --buildid-dir /tmp/perf.debug.Umx record --buildid-all -o =
/tmp/perf.data.YBm /tmp/perf.ex.MD5.ZQW
>   2589568 perf record -o /tmp/__perf_test.program.mtcZH/perf.data --branc=
h-filter any,save_type,u -- perf test -w brstack
>   2589649 perf record --per-thread -o /tmp/__perf_test.perf.data.5d3dc pe=
rf test -w thloop
>   2589898 perf record -o /tmp/perf-test-script.BX2b27Dcnj/pp-perf.data --=
sample-cpu uname
>
> Which gets a little closer to finding the issue.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian
