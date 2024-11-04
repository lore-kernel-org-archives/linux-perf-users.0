Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE71C8767
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754146; cv=none; b=oPUDpnoPX3IhPM/+cDISERumjsFV6pL46AvnY+Jk/7WTYpMo9eGyOkUrB3A5dhXu9T7ofv/dYQsYncNC1RaDV4wMBpYtvkerarCS/Ed208PNOBp1b+eWHfAerFFAU3yd+QaUmiKThgoBOg//+QKf+L/STVset9ppMPhiw6RYKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754146; c=relaxed/simple;
	bh=mQRAzqLwZxZBpeCMeLt10YkglB34o54AhZJV0mqr2pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foViyKcgnKCNLULx8bcJjUEzwZZi4Kk04ILJ/S79G+twX+ifSLBEF+SN7D7W3YopPWvvzOvNAWElwDgPDbTHUHZdZE0RAKDjlaXphMCrEvx3xN/irmURsOdoGtIvxOIU55ndKYmKijzb6IFCYJj7wTbSvczGQGDeMvP2638aMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t520OVkU; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t520OVkU"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso19295ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730754144; x=1731358944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ68oLt1BvdJpTXqYSNLPbv4o5eNZm7+qs/QrLliEOY=;
        b=t520OVkUCBOMwlYSsL63sYA0oQD3ZN9lpY1eO9WfGMp6f4EQ4GZBzDIX6i0YWh8X0q
         lIgndaVQoD5qbPFFC6YiMaT/H+HtxjB8ltrBf9hbk1APg/n/ee18Rjet2zE3Ga6XWWnI
         gP5LLfFoQXg9v6aeqegUVCXhiIeFS51k4lMkkQDzI+XZrW7vMiC/2R+hRKGM9oLlr/zW
         UTbBgNRzdh3rHcS/GRx6fR5LD/lsqPztXi/krWu6y7sF/u5olDSSBaZ4nujosehaP695
         ZNJeNv8cnYguBU0ZBoLTMgWqQA9o1F3cunMkmtvoQV7jQWE61FK3rN7oNwF2yd0avxnb
         aZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754144; x=1731358944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJ68oLt1BvdJpTXqYSNLPbv4o5eNZm7+qs/QrLliEOY=;
        b=i9fIlsVlyzvf3PN5uaCu0DL5hUuBoV4k/5LVlYwngDdCRGfh8p19mG3C4g3R0+e+WZ
         /yE8YtEf8aolwdjTEENjDD7t2TlxgCha5P08JDyAqXOz2eEgoLW68oZmropt2S5FIMJC
         tQn1Lf1Q+O4W4izFDqy5hLw4h8Z0uqVCJnLRV5+Y6TeCEz8W0ps2drhHsf2uRtSXBKhb
         fSqf3fTTXOz//agBUc13kRi/qEwKBO777ShCRV1BGdKRdGfXBi8RLs+REXcVwZvnkGW+
         +GUVj8GuINLlHGQqeDOPCu4HECntYNeKnnAMY3dcIiSkvkYmld7DEdiAt/Va7emdU+17
         PyAw==
X-Forwarded-Encrypted: i=1; AJvYcCX0atD8ML40Im2tLxvthyivp7R9hwhnUqezrejwqZtGcynqWRB4ae2o43ugRnX1f+ssIK0ZOmTBN9X46jiPKD7p@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg09iEVr1PXRqAzRqEIstmaNwUxFuXLpvvt/9d+dQiQ02G7h25
	J9cqDtctCplkovvl8u2oR5FzqPcABql6x+9BemttB/av6aHodkLp3gUNUkHOzNOUOEIH+n9/+lD
	2vAbj5/Qoeav6jX4aB+vJQepIRe7UvFkNIugMZyafLvw1KYgNicqR
X-Gm-Gg: ASbGnctpZmdG+KllU1IhFJnVhHIr30iDMJge6Hv1n8rrFZ+vQU8H7T6E4EnYuZgJQbe
	YFwgyOFXqQ+j2KKcl5Xx/EmTFHd1yEUftU4l3TD/aGL6lgr3xq9yB/q0Q//NClXo=
X-Google-Smtp-Source: AGHT+IEXRBEnfz+bmmrxEbzCK+nou//ojvw9LhODU8WyvC1tr73EEfO51NmnGxD/VOzW/aLxESTh87p5xWuMRdejivo=
X-Received: by 2002:a05:6e02:1a4f:b0:3a6:b0a3:540b with SMTP id
 e9e14a558f8ab-3a6da9c4eeemr816575ab.20.1730754143977; Mon, 04 Nov 2024
 13:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104175953.535202-1-acme@kernel.org> <20241104175953.535202-3-acme@kernel.org>
In-Reply-To: <20241104175953.535202-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 13:02:12 -0800
Message-ID: <CAP-5=fVZpdO=ct9sFMpVs9QunjofSz9JT0MLf_MoF98EitQ7=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Don't build the python binding builtin
 test case with NO_LIBPYTHON=1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:00=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The python_use test suite was being built even when the python binding
> that it is designed to test is not being built, fix it.

The python module that the test is testing isn't strictly using
libpython.so, that's `perf script`. Perhaps there needs to be more
than 1 overloaded #define.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Testing this patch:
>
> When building with NO_LIBPYTHON=3D1, i.e. explicitely disabling linking
> against libpython and thus not building the python binding:
>
>   $ perf check feature libpython
>              libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
>   $ perf test "import perf"
>   $
>
> Not disabling linking with libpython, the default, that results in the
> python binding being built:
>
>   $ perf check feature libpython
>                libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>   $ perf test "import perf"
>    17: 'import perf' in python                                         : =
Ok
>   $ perf test -vv "import perf"
>   Couldn't bump rlimit(MEMLOCK), failures may take place when creating BP=
F maps, etc
>    17: 'import perf' in python:
>   --- start ---
>   test child forked, pid 533419
>   python usage test: "'/usr/bin/python3' -c "import sys ; sys.path.insert=
(0, '/tmp/build/perf-tools-next/python'); import perf" "
>   ---- end(0) ----
>    17: 'import perf' in python                                         : =
Ok
>   $ strace -s1024 -f -e execve perf test 17
>   execve("/home/acme/bin/perf", ["perf", "test", "17"], 0x7ffe04832040 /*=
 38 vars */) =3D 0
>   strace: Process 533458 attached
>    17: 'import perf' in python                                         : =
Running (1 active)
>   strace: Process 533459 attached
>   [pid 533459] execve("/bin/sh", ["sh", "-c", "--", "'/usr/bin/python3' -=
c \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); i=
mport perf\" 2> /dev/null"], 0x133179a0 /* 40 vars */) =3D 0
>   strace: Process 533460 attached
>   [pid 533460] execve("/usr/bin/python3", ["/usr/bin/python3", "-c", "imp=
ort sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import p=
erf"], 0x5566715c7280 /* 40 vars */) =3D 0
>   [pid 533460] +++ exited with 0 +++
>   [pid 533459] --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_=
pid=3D533460, si_uid=3D1000, si_status=3D0, si_utime=3D4 /* 0.04 s */, si_s=
time=3D2 /* 0.02 s */} ---
>   [pid 533459] +++ exited with 0 +++
>   [pid 533458] --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_=
pid=3D533459, si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>   [pid 533458] +++ exited with 0 +++
>    17: 'import perf' in python                                         : =
Ok
>   +++ exited with 0 +++
>   $
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/Build          | 2 +-
>  tools/perf/tests/builtin-test.c | 2 ++
>  tools/perf/tests/tests.h        | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 01ed9335db4dba4e..8596616907adf244 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -20,7 +20,7 @@ perf-test-y +=3D hists_link.o
>  perf-test-y +=3D hists_filter.o
>  perf-test-y +=3D hists_output.o
>  perf-test-y +=3D hists_cumulate.o
> -perf-test-y +=3D python-use.o
> +perf-test-$(CONFIG_LIBPYTHON) +=3D python-use.o
>  perf-test-y +=3D bp_signal.o
>  perf-test-y +=3D bp_signal_overflow.o
>  perf-test-y +=3D bp_account.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index d2cabaa8ad922d68..13f7b24694d1d0b0 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -79,7 +79,9 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__syscall_openat_tp_fields,
>  #endif
>         &suite__hists_link,
> +#ifdef HAVE_LIBPYTHON_SUPPORT
>         &suite__python_use,
> +#endif
>         &suite__bp_signal,
>         &suite__bp_signal_overflow,
>         &suite__bp_accounting,
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index af284dd47e5c7855..3144c7916532825c 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -99,7 +99,9 @@ DECLARE_SUITE(dso_data_cache);
>  DECLARE_SUITE(dso_data_reopen);
>  DECLARE_SUITE(parse_events);
>  DECLARE_SUITE(hists_link);
> +#ifdef HAVE_LIBPYTHON_SUPPORT
>  DECLARE_SUITE(python_use);
> +#endif
>  DECLARE_SUITE(bp_signal);
>  DECLARE_SUITE(bp_signal_overflow);
>  DECLARE_SUITE(bp_accounting);
> --
> 2.47.0
>
