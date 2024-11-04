Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553461F7541
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754003; cv=none; b=YqvSaUdxsC9I9FeiX6fuAAaurd7l0giorOBEvWO+LX1uTUUwN6Qe/H744iRjRc/aXZdK+3NaGAnbzyPX2WgVhj6NUkN5exktMzP8AeJA+ounPziia2QNo+wZVBWxZu/l9UgUhuLwDo/89fzadgs/cknrfGaPh1GjrF6Di8br7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754003; c=relaxed/simple;
	bh=qPKby6mEFXwyJAYSpRhy7gqmWnhuWSVnX5mdNFLwFZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcf2ouH4lOyafnXDctWfCSv01FZfQhCH6Gq3+obKnCHm2POWwhxpg5LSlcfy750pBzC64HeXQ5WkmzLw79d5mBMwXTOUu5Q+N00yQr/E0pTP4z7TWNdlV1ieKcsa9+dDj5/CHjxRYrwoYftGCKrcpvCxITyST//0GFXch0mEBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeG8usZ0; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeG8usZ0"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso56585ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 13:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730754000; x=1731358800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb2PwGank2KycRxYb7JirzUUvD3h5XSJZvlzLcEuHX8=;
        b=NeG8usZ0qGBEcex3ovTUA5rbdtvjZjBXxc85VeNxkbZUeRyQnHq0KNK7K48fk6T90p
         DORGJ72JQ9eQ7U5fe7VV2j4EiG8y09b5JYAyFbIw/CmKaG17AD348sRd6QksAcIRSm6P
         gYgk7Gk6lku/h4M3FVaMvB0QAG5taRVFQa47XEhY90ZY3Kf3DeEY6bzWIzpYjjWNZRAL
         JCHebm1xrKoVcIrod6EIh9A6vbzhgKcJs0jUCKLCLz05a1s/bN1FdjVlXTY9PocOZwHQ
         FF9KhEgpJSWt2qytP5XY2okYoyf7LPd8iDFyv1DEqgnSFadVL48tNgoVArhzH63mtdJR
         GuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754000; x=1731358800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb2PwGank2KycRxYb7JirzUUvD3h5XSJZvlzLcEuHX8=;
        b=DKpDTo8Zmk2AcxWJT1H0XsW6jyyoq8r/KRhnvKZlLJq3ypy/cXL1Ki2nkCQb79ABSf
         3YF2uMBmzWPnwfIAILramudULbfdtHt+s0HfUhWktzPapUl1GmuMuOCCKH9ddf6Mw3F+
         zGg5xKJKDHFcjurhm86YsV0ROA8svalOF7TSDVBpyM0FQ9BRhTDULFXa5g5mFGfIy7ZY
         TzAL1QwOM2MsZf/qwN5mb2g21/7yCcOAXiOsTbkR6EyiMKAA1qV/rr7o5hiuNe2bjfPo
         XJcqWo65+TyRhnT25qNvK8mppSB82v6ud5R0mwul/7E0lCKCWTs8vYREn1F3Q3YCtsAB
         CEvg==
X-Forwarded-Encrypted: i=1; AJvYcCWq7tQwZiVEacpIIqsCrnEX0Foo3n71UmAenFTSIFBDjn5/YbbBxuwpjfxSjhh/L+4V2CWtHilj+8NTXrWpeO/a@vger.kernel.org
X-Gm-Message-State: AOJu0YymoHP3TfjVBuPMnlge/85gFI4yhAhywVYn19DQlfDiUjbzs3BL
	9N/Enl0JyBW1m9iBSgd6slM1XSxUV7hVlD35BE+qdLbPskSUGnoIDVZ5U+2yVpN0yolz9nfmPZK
	I5277V4wta7kIso10axKZZ85JamPhlnUvkkcn
X-Gm-Gg: ASbGncub3jDQFMvBVxjkujq5PWzngHbP/H7y4Wb7Aq6BghMsy6r8QaBt+Yg0ZYz7ka2
	zlGM5rsAGHQoOmO31CaTIEaF1PxNiHt80YezXOAbwQ+SKfItaUXdDiMEVE1yaKg==
X-Google-Smtp-Source: AGHT+IHEDRLmfzud1ZH0GJEErOf2boHSAzT61a8gPjs+St1GGErBgIh5B0AthkTQhcGYmfGP0API+5Nz2rC64yzdiq0=
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3a6daa7c653mr712485ab.11.1730754000313; Mon, 04 Nov 2024
 13:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104175953.535202-1-acme@kernel.org> <20241104175953.535202-2-acme@kernel.org>
In-Reply-To: <20241104175953.535202-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:59:48 -0800
Message-ID: <CAP-5=fX+e8bQZHbPwNq+kudqCWjuVryXzdJDJ94EBeSMuFGEBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test python: Robustify the 'perf test python'
 test case
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
> While working on a patch to not build the 'perf test' entry that tests
> the python binding when NO_LIBPYTHON=3D1 is used when building perf,
> meaning that the python binding will not be built, thus no need to test
> it, I noticed this inconsistency:
>
>   $ perf test 17
>    17: 'import perf' in python                                         : =
Ok
>   $ perf test -F 17
>    17: 'import perf' in python                                         : =
Ok
>   $
>   $ perf check feature libpython
>                libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
>   $ ldd ~/bin/perf | grep python
>   $
>
> Even without any python binding or support for loading it present in
> perf, it says that testing that feature somehow "passes":
>
>   $ strace -s1024 -f -e execve perf test 17
>   execve("/home/acme/bin/perf", ["perf", "test", "17"], 0x7ffe99ae5d50 /*=
 38 vars */) =3D 0
>   strace: Process 519319 attached
>    17: 'import perf' in python                                         : =
Running (1 active)
>   strace: Process 519320 attached
>   [pid 519320] execve("/bin/sh", ["sh", "-c", "--", "echo \"import sys ; =
sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2=
> /dev/null"], 0x377ba9a0 /* 40 vars */) =3D 0
>   strace: Process 519321 attached
>   strace: Process 519322 attached
>   [pid 519321] +++ exited with 0 +++
>   [pid 519322] +++ exited with 0 +++
>   [pid 519320] --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_=
pid=3D519321, si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>   [pid 519320] +++ exited with 0 +++
>   [pid 519319] --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_=
pid=3D519320, si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>   [pid 519319] +++ exited with 0 +++
>    17: 'import perf' in python                                         : =
Ok
>   +++ exited with 0 +++
>   $
>
> It doesn't matter if we fork a new perf process to run just that test
> entry or if we don't:
>
>   $ perf test -h -F
>
>    Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-f=
ragments>|<test-numbers>]}]
>
>       -F, --dont-fork       Do not fork for testcase
>   $
>
>   $ strace -s1024 -f -e execve perf test -F 17
>   execve("/home/acme/bin/perf", ["perf", "test", "-F", "17"], 0x7ffda8faf=
ed8 /* 38 vars */) =3D 0
>   strace: Process 519336 attached
>   [pid 519336] execve("/bin/sh", ["sh", "-c", "--", "echo \"import sys ; =
sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2=
> /dev/null"], 0x159d99a0 /* 40 vars */) =3D 0
>   strace: Process 519337 attached
>   strace: Process 519338 attached
>   [pid 519337] +++ exited with 0 +++
>   [pid 519338] +++ exited with 0 +++
>   [pid 519336] --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_=
pid=3D519337, si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>   [pid 519336] +++ exited with 0 +++
>   --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D519336,=
 si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>    17: 'import perf' in python                                         : =
Ok
>   +++ exited with 0 +++
>   $
>
> The system() call (that execve) will return zero even with that echo
> being piped into nothing:
>
>   # sh -c -- echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tool=
s-next/python'); import perf\" |  2> /dev/null
>   -bash: syntax error near unexpected token `0,'
>   # echo $?
>   2
>   # sh -c -- echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tool=
s-next/python'); import perf\" |
>   -bash: syntax error near unexpected token `0,'
>   # echo $?
>   2
>   #
>
> If we instead avoid the echo and use 'python -c' to pass that simple
> python script just trying to load the non-existent perf binding we get
> less processes and a more consistent result even in this pathological
> case where PYTHON=3D"":
>
>   $ perf test 17
>    17: 'import perf' in python                                         : =
FAILED!
>   $ perf test -F 17
>    17: 'import perf' in python                                         : =
FAILED!
>   $
>   $ perf test -vv 17
>   Couldn't bump rlimit(MEMLOCK), failures may take place when creating BP=
F maps, etc
>    17: 'import perf' in python:
>   --- start ---
>   test child forked, pid 522859
>   python usage test: " -c "import sys ; sys.path.insert(0, '/tmp/build/pe=
rf-tools-next/python'); import perf" "
>   sh: line 1: -c: command not found
>   ---- end(-1) ----
>    17: 'import perf' in python                                         : =
FAILED!
>   $
>
> The next patch will sidestep all this by plain not building the python
> binding test when the binding isn't built, i.e. with NO_LIBPYTHON=3D1.
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

Fwiw, I found the commit message overly long.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/python-use.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.=
c
> index 0ebc22ac8d5b47ed..b7325caad22bab10 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -14,8 +14,8 @@ static int test__python_use(struct test_suite *test __m=
aybe_unused, int subtest
>         char *cmd;
>         int ret;
>
> -       if (asprintf(&cmd, "echo \"import sys ; sys.path.insert(0, '%s');=
 import perf\" | %s %s",
> -                    PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null=
") < 0)
> +       if (asprintf(&cmd, "%s -c \"import sys ; sys.path.insert(0, '%s')=
; import perf\" %s",
> +                    PYTHON, PYTHONPATH, verbose > 0 ? "" : "2> /dev/null=
") < 0)
>                 return -1;
>
>         pr_debug("python usage test: \"%s\"\n", cmd);
> --
> 2.47.0
>
