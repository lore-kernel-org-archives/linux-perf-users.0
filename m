Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A347A62
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080857; cv=none; b=SMVbarIzFgK/mVziKSLjvdt599+vBoufY5NO3HTi81jHOMGwUh1TsRtaxtYy8gTmQMbhXxLr4OYJmBLECbhtC8gnWL1n1OKUszfSUcrqL+54Vn87Pg3OLVMZqPIzMNpDxM0AYdwbZ65UM0t3KLtCVXgUCXf/wpx4ONASwQXwDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080857; c=relaxed/simple;
	bh=T7qaaicGJUnoLXKokM7lS8p2Swf1u65hJRrhBHJ4Cq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZPw/xctYJapofldNI1UXBNvjKMJpQLqVTrIgjdPkGZmTC1AUGU8qFYWKYYLkDjNPE21Dm1t8DCoWWidOkbRCHrB3BHejKse4N6M0tuOCiE8BHvbV4qKrRRsv0e6axfN+6Od7o6NRi5MCQJ2l506XvnZw1WMUqNFmxSGe+9v9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSboWkT2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSboWkT2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd7509397bso115545ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080855; x=1724685655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFRYt1Wga+lCQYlrwyH/jQ7PLLA0jQfcjmSTgkpdY8k=;
        b=mSboWkT2LK3HK41e2CQ1nDnrdUZWecsxtQys/omoYUb5p8/IAGei/fuaGOXsLzi60y
         nUNDCFEMBsr0HXcAhX2LkqsktVpi5WTHcE/y/WBgTm6KZ6QXsWNzsHwyo0vClr3V34Vr
         JeSZevpsi7/wu2jnj/BcIuFJo4uJcIe8aVeQEeCrFLExQ5yPcFn3aGHsKkT6UwC+vN2U
         IeVqn/8tQSKURvEDz8EiWYOo0VK1fGBCBMlBsKVoq/ja02MhSJBmegik1c487yFNlF81
         HIYI8Tq54F2So+Qeq4GJI1S0PzprpXMdmz081OXwdXPajuXxCKfwtFzn3Gak2ektKuN/
         GiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080855; x=1724685655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFRYt1Wga+lCQYlrwyH/jQ7PLLA0jQfcjmSTgkpdY8k=;
        b=Ro5UmHMae3nquj1oIX+ntssmxbXyohlfnbgEzM2+g6UJwDyFflWwb+6/77zPEpdok3
         Fus7aIJLz2s+lg+2A+jy2FurzJYaU6AdqthLPBZ0PkKnZm4bGIV46WPeQDvO4B19Ue6q
         jRcI03jnIktVoHHVs4mKXlF57HfkVqRnELeBACbq381ZRJx06VL3u52QzSXBlFTSNkI2
         hbFjMb3K87HHgddhwUtxFmeaCbUfQvWucOc4+8BjsB9Ua/d2QfXqbrZNg32g74Hac0/D
         0fcsqMREgE1lnCpl0Q/vXgRP1J5S+16y+8JhfpZX7CbjMjr+WFihnzhoRHd/EfMY2mnK
         lfuw==
X-Forwarded-Encrypted: i=1; AJvYcCUBgTBlSxMuXjhXfV8cEsONllwoRznSWGp6wsek3Ts9PgIg1IzwvyMGbMXerzpQbYqHrs6lWUqKjTRcJpT92sIBFZfLn9JS42ZKXTFhFo/djw==
X-Gm-Message-State: AOJu0YyNtwp0jycva33f/K2g03v1d4K+cyZXpL/DEIdmXLs0O6Qizi0p
	+Zv3TfuVMntZW3B2IhO/xP3DQfKu1Les088CPEl11e3A4YzzycGO1qh9+uukHg+PKHDdqgYWGql
	kdxpZOImbHOWccUSmB00lpNNpUEIDyOPMp7oN
X-Google-Smtp-Source: AGHT+IFatrDwzmdUbS4q6O9KOGQeYdl7aB8/H49bOtD2OTjVUoJK6sYswiWNTrCU8Kup3Nu2/Hm3I8yeMaFQOnnNFM0=
X-Received: by 2002:a17:902:d2c6:b0:1fa:f738:62fd with SMTP id
 d9443c01a7336-2021bcf798bmr1410285ad.7.1724080854415; Mon, 19 Aug 2024
 08:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818212948.2873156-1-namhyung@kernel.org> <20240818212948.2873156-2-namhyung@kernel.org>
In-Reply-To: <20240818212948.2873156-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Aug 2024 08:20:43 -0700
Message-ID: <CAP-5=fXzXYD1FE_0k45hWzHsKtnra2WOR-K+u30eTECP3i9KOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add cgroup sampling test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 2:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add it to the record.sh shell test to verify if it tracks cgroup
> information correctly.  It records with --all-cgroups option can check
> if it has PERF_RECORD_CGROUP and the names are not "unknown".
>
>   $ sudo ./perf test -vv 95
>    95: perf record tests:
>   --- start ---
>   test child forked, pid 2871922
>    169c90-169cd0 g test_loop
>   perf does have symbol 'test_loop'
>   Basic --per-thread mode test
>   Basic --per-thread mode test [Success]
>   Register capture test
>   Register capture test [Success]
>   Basic --system-wide mode test
>   Basic --system-wide mode test [Success]
>   Basic target workload test
>   Basic target workload test [Success]
>   Branch counter test
>   branch counter feature not supported on all core PMUs (/sys/bus/event_s=
ource/devices/cpu) [Skipped]
>   Cgroup sampling test
>   Cgroup sampling test [Success]
>   ---- end(0) ----
>    95: perf record tests                                               : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 36883b03169f..048078ee2eca 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -206,6 +206,28 @@ test_branch_counter() {
>    echo "Branch counter test [Success]"
>  }
>
> +test_cgroup() {
> +  echo "Cgroup sampling test"
> +  if ! perf record -aB --synth=3Dcgroup --all-cgroups -o "${perfdata}" $=
{testprog} 2> /dev/null
> +  then
> +    echo "Cgroup sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -D | grep -q "CGROUP"
> +  then
> +    echo "Cgroup sampling [Failed missing output]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F cgroup | grep -q -v "unknown"
> +  then
> +    echo "Cgroup sampling [Failed cannot resolve cgroup names]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Cgroup sampling test [Success]"
> +}
> +
>  # raise the limit of file descriptors to minimum
>  if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>         ulimit -Sn $min_fd_limit
> @@ -216,6 +238,7 @@ test_register_capture
>  test_system_wide
>  test_workload
>  test_branch_counter
> +test_cgroup
>
>  # restore the default value
>  ulimit -Sn $default_fd_limit
> --
> 2.46.0.184.g6999bdac58-goog
>
