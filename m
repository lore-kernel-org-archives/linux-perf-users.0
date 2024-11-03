Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D27320B
	for <linux-perf-users@vger.kernel.org>; Sun,  3 Nov 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609972; cv=none; b=sQeU46hUxsD+zYOIV/8F2h1aQZJB8tDj17LhVWaX1a28f2x36trjJ60CgjUv6WhvAByc1dQntMldSA2u+/9kOxXdsUo7k798ucE5rqZ8kmfna0pcVxSXUaNmgIemiARBhxR00+wytfAslF87nDnP0fkSxmZX9A+TBGs1pIJXpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609972; c=relaxed/simple;
	bh=CVRfBxqyVboxDlXOvDCdkmeqxkb0nfVb9iagkfDWGZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sExB1BV+kSr61RY8ECRhuLMXYAUGs0wX+TBlBJYfaSX33hlztNMJ82ecABaG6AIxoGdsMFyEBiOVji6Vwbltsz1RnY5m/8RhPNO5QIfEywfQ7dXa4TuLd5cvLmo/QQNlwpvr3hSgd61L/Y813AXt1iF+vUpHhZZg+MBzakANKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3DvIwoD; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3DvIwoD"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso366025ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730609970; x=1731214770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A9sz3MB+zVbjeZOy9mWAXJ1yDGla5ge8ekzfLCZ0e4=;
        b=h3DvIwoDIGqi3IBmwDNl4x0mKnVS/q0maCH5zo6jLqq7U2hnSW/x27Byh/59RuIzDc
         Pk2z3AIRsgyh5NQU6qbHE//4g6pc6egcXnVKCI3CA3c0BugALJ7OSB9GW2oNNcewbNct
         aZNVOJyhReCifU2hbeMdTfHXKbmAU9Nx8mzG10yTfD/6cb0HovJocBULDQPuAj6snE6G
         5xzT+ed4gW2ifYofNWyYM+/JOQj/MnKy/GFod+QSj6ocw1As/0KHAM+iVv3ya90P/Uv0
         qsT1+8ZdUjtPFHdxgUX39AgepqWBrv2NZpSGuOrG4xBXcXIxTipRtYJKXV9s+9LdqzWS
         RcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730609970; x=1731214770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A9sz3MB+zVbjeZOy9mWAXJ1yDGla5ge8ekzfLCZ0e4=;
        b=XwhFiEB94xzRDSzIAfafzijYlo79lPAcPsuGDOSx4kiT/K4laUNsQcUZhaZL30LprT
         UE4J4zIBIZlW8QwKFAE6L5xMtxpl4c91809vnws3JImtSjdSxcc9l1/jxwUtgvnsp9Ln
         DpuSTqqkECyDDfUIpLSd6sbbkwuyhJTK+GvdgTQicU62VDK61Ivah7IkdxF+1ZQTq0TM
         B1kfzknFevOoudEO5H+TysF/cx9MXPjmLb9X0VDC4Adh4mvJXcCct8O2q0N/Wa+jPuP+
         ndSGQFc5eg2XYDvV7zJ1HaU31S/trudd6j3d2ZaOlsO2OIpkWKVg3/5Kxjs6uV6ooUf1
         /SqA==
X-Forwarded-Encrypted: i=1; AJvYcCXGLKbrOqj76/T7Gbx5jjNn0+RKfu+w0Ds5ibhgHD5F/Ng8gvkUEyzfFB3YXbgOto0Kwab85lLrIQPAVBNrhpNj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxul60eeTaKIRWvklr02B18OWJ9UaSgWMSlkUQJujfnts5VNS/4
	U70QN5lNe2DRAl3UDeKAwdLSTK5iIWDQMvLTfF+3RHPOg2Wzx531z4tzKToT0+8kJ/TxnMUuSsn
	ywzFI6eZznG1HK+m5NhDERRlv6qpYV7MkOQQG
X-Gm-Gg: ASbGncuORtgZ02K3fCsi9AkaHtyFWfWMbPzn+St5fQmRJrB05HXZxLCQa1OSlhAvf7B
	cU4vEQre9/ThaXdUTD1PlvH4EK9WrqF9E
X-Google-Smtp-Source: AGHT+IFNAoSxkRhIGQStGyhrMj2HwETDDsgRcV7KeIqZb9YSfrd8l85BJE4VDOmORtTAjNipWvlZ8MW6X80ezvT2sC8=
X-Received: by 2002:a05:6e02:1d1c:b0:39f:83dd:5672 with SMTP id
 e9e14a558f8ab-3a6bdd00d23mr3152865ab.16.1730609970366; Sat, 02 Nov 2024
 21:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102231702.2262258-1-namhyung@kernel.org>
In-Reply-To: <20241102231702.2262258-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 2 Nov 2024 21:59:18 -0700
Message-ID: <CAP-5=fXVAVJD_KZb6wqnisO+cdnwQtz5JHvUULrXhynVGsVJHQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix ftrace test with regex patterns
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 4:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> During the parallel testing, I've noticed some ftrace test failures.  It
> seems the regex pattern checks 100 msec of nanosleep with the error
> range of 10 msec.  But sometimes it's affected by other processes and
> resulted in more time in the syscall.
>
> The following output shows that it took more than 120 msec and failed.
> Let's update the regex pattern so that it can allow more drifts.
>
>   perf ftrace profile test
>   # Total (us)   Avg (us)   Max (us)      Count   Function
>     121279.500 121279.500 121279.500          1   __x64_sys_clock_nanosle=
ep
>     121278.400 121278.400 121278.400          1   common_nsleep
>     121277.800 121277.800 121277.800          1   hrtimer_nanosleep
>     121277.100 121277.100 121277.100          1   do_nanosleep
>     341760.289  56960.048 121273.400          6   schedule
>        176.200     25.171     31.616          7   scheduler_tick
>          0.923      0.923      0.923          1   native_smp_send_resched=
ule
>     345522.360  69104.472 345320.600          5   __x64_sys_execve
>     345486.585  69097.317 345312.700          5   do_execveat_common.isra=
.0
>     340730.300 340730.300 340730.300          1   bprm_execve
>          1.758      0.879      0.883          2   sched_mm_cid_before_exe=
cve
>          1.112      1.112      1.112          1   sched_mm_cid_after_exec=
ve
>   ---- end(-1) ----
>    81: perf ftrace tests                                               : =
FAILED!
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/ftrace.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ft=
race.sh
> index a6ee740f0d7eca07..11010711efa193b3 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -72,7 +72,7 @@ test_ftrace_profile() {
>      grep sleep "${output}"
>      grep schedule "${output}"
>      grep execve "${output}"
> -    time_re=3D"[[:space:]]+10[[:digit:]]{4}\.[[:digit:]]{3}"
> +    time_re=3D"[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
>      # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nano=
sleep
>      # Check for one *clock_nanosleep line with a Count of just 1 that ta=
kes a bit more than 0.1 seconds
>      # Strip the _x64_sys part to work with other architectures
> --
> 2.47.0.163.g1226f6d8fa-goog
>
