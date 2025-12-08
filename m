Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D312C11D9
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214824; cv=none; b=bF04NyLo/QLEqYDcoph9BdnXJb3gAbIjRw5TXOIWNrse8BbUPldDSofNl4D1nm6zXdFFhtnrcdb5b77X5FgeMSFZZwciR0Hoh3dqyRw0L3aYXHLXiI9Xf5y4oPZUSs+i9w7wOKV5ZAVJ+RR7F1PI+3NWVuXaGxyTxiYcjhEt1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214824; c=relaxed/simple;
	bh=dJu96LUxhmTfe6MqpPT8t2eutWJWf8EPiz34vl9hm6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRtzeETb7a3h0JTnTooLvKWKnIFS8jeJSXmWpNrMnEMRDD8JnUg+XBQYyeRcn2UUIw1svMOakJtbc7PM1ATIJhKZ7AZF22VV/Zm2iLQaPn9Sc3U9ZrjFh5XeqzEehGOVyptsZN+/AJKP81PQuBkFiMpHACCmX6fyzVciqwEj/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lw6ACB0h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lw6ACB0h"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e13bf404so421295ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765214822; x=1765819622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWk7VFUgVWNu+rpmHkrf22dK3SpwLQ2zoRJZviNUF4M=;
        b=lw6ACB0hcIZPJLGgu3duua/Lk6bQsB1cWSHBOTbedo8KCXnOxExc0XwAGG9PgzGY2V
         SK7gPdsIRJvRPZTPlqB0jQq2V7+c8gf69Lzsu1HdavFni/ePE5eyywxvmOmx1k9ZTZr0
         ik6i+GL2gY+hh5VP0cTu6cZWrCZtTwYJPEUnkNI8QkDVMdRbZyILIgRD/UCRnuuoZPjg
         t4025PSm90iq6OAzBypiSxp38MjXDXMDsGEQhG39NNmIp/TfQp39fKvUOVHDhhvatFC/
         LE9YAoyPbOxO2d+y4PsUeIlL6ClQVOzMKvNS0+HYtZzJrHOW0fWo46tH/ZKLZ2kgLbvw
         jUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765214822; x=1765819622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWk7VFUgVWNu+rpmHkrf22dK3SpwLQ2zoRJZviNUF4M=;
        b=Nj2BevH+DvILu+maOwqFDqnpHpEmHfu3Imi/gsD8HeaLLPOvxwfe5JN8RSnkeVIWgb
         +NN5itGg1bIaJk0TWJ5KI/jWZPu5pyszChR+4vKwOczmty/AnmEYnLWafwQjozKN+rkv
         yhWk7G91U2hGm3zwU/wQilVC6O1VPN02CVamsy19ASgG3Ijc5U3bI4tWd1ratPC/zZH9
         Jg0+RmaJQ8bp2PtRWWjW3oW7nFigxkEs9xhCKXyVI9qHvcM27X4pVH6TCPVA/nUbbA1J
         fZ0e05WBAKLzQmg5ODaDzxlO7SjaN6iZnIVlBT6EdqcITZ7uugFOvBwBT0OHW/v+if3l
         w1bA==
X-Forwarded-Encrypted: i=1; AJvYcCUVedS7TtjCQqtAH/whvWFOSo9rL/V8min0ByXnBZnpjvpCPyepCxEFWx8oYbIEbmS2OLzYFaOcqdTEsxAftq2i@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ73xC8hCy7xfC2JjVE9/+/jc4KRtiBCkpJBmB1EFyIEX8qpdx
	Kx5G5GA6qXlanBrvHG2r7ve7MtGMdeAOUEkTLgVQoCtRT0kv+PSrWwGEi63bNcqgEqwz5BEAm+o
	v64fwYSDDr3yyMUtF5wN4mA3ZZ0AOyQ5/S5ZKHAKv3LvvOpjaiBIkqOwGQ5c=
X-Gm-Gg: ASbGncu1BV8klj4eqaE3Yh9dGzLAEVZTGaG+DpmyO1zrQUfi5pwhdkzkppRxyC+Tyk1
	gzyrUfPkE6VPzY+flXYQ4qYqJhHlgCRrItiu+X7yuxDmrRz5LHcogkAVUP5NCK0D0HYHBJ5+t2s
	37L0jsyXmO0XwPTE1dtL7rBdZU8OPPTuvbwrdnLGLeRs81Rpwuk2ntYuyhWPzjTX7EVbGPe/ZUx
	vsl4if2bVyjadMZi7a3vQTlGjwfMJTFsuqSZC0wVS4XAhy5X64JEaUcDX4BRAFuqkH4KLKClIBn
	Tg7uQG3LUeJkhDkdH21KeaEX
X-Google-Smtp-Source: AGHT+IFQYdIWUFHGsASzoLXT6DBoF83KUFBeRXqWNibh+BQZKL3Q0zx44KwMORFfozkvA6iquIaYJyP25fiAzvyyX64=
X-Received: by 2002:a05:7022:50c:b0:11d:f460:faa3 with SMTP id
 a92af1059eb24-11e03e5d1dfmr293119c88.13.1765214821545; Mon, 08 Dec 2025
 09:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202213632.2873731-1-sjayaram@akamai.com> <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
In-Reply-To: <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Dec 2025 09:26:49 -0800
X-Gm-Features: AQt7F2rN7Wl_E7KMb2zKBnQ6RAYRbXHsNh2H-EVsKI5DJWcGu4ZbI-IcZIyiOTs
Message-ID: <CAP-5=fU8PA0u=YKroNK8ykF3f8oUrttgNzJ13LELCmNL0JO+=Q@mail.gmail.com>
Subject: Re: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
To: Sri Jayaramappa <sjayaram@akamai.com>, Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joshua Hunt <johunt@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 2:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Dec 2, 2025 at 1:40=E2=80=AFPM Sri Jayaramappa <sjayaram@akamai.c=
om> wrote:
> >
> > When there is no exclusion occurring from the cmds list - for example -
> > cmds contains ["read-vdso32"] and excludes contains ["archive"] - the
> > main loop completes with ci =3D=3D cj =3D=3D 0. In the original code th=
e loop
> > processing the remaining elements in the list was conditional:
> >
> >     if (ci !=3D cj) { ...}
> >
> > So we end up in the assertion loop since ci < cmds->cnt and we
> > incorrectly try to assert the list elements to be NULL and fail with
> > the following error
> >
> >    help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' fa=
iled.
> >
> > Fix this by moving the if (ci !=3D cj) check inside of a broader loop.
> > If ci !=3D cj, left shift the list elements, as before, and then
> > unconditionally advance the ci and cj indicies which also covers the
> > ci =3D=3D cj case.
> >
> > Fixes: 1fdf938168c4d26f ("perf tools: Fix use-after-free in help_unknow=
n_cmd()")
> >
> > Signed-off-by: Sri Jayaramappa <sjayaram@akamai.com>
>
> Thanks Sri! Guilherme reported a related issue and I think your fix cover=
s it:
> https://lore.kernel.org/lkml/aTXQw9dtP5df7LmP@gentoo.org/
>
> I came up with the following test based on your commit message, could
> you validate it covers the case for your fix:
> ```
> diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-hel=
p.c
> index 2280b4c0e5e7..9da96a16fd20 100644
> --- a/tools/perf/tests/subcmd-help.c
> +++ b/tools/perf/tests/subcmd-help.c
> @@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct
> test_suite *test __maybe_unused,
>        return TEST_OK;
> }
>
> +static int test__exclude_cmdnames_no_overlap(struct test_suite *test
> __maybe_unused,
> +                                            int subtest __maybe_unused)
> +{
> +       struct cmdnames cmds1 =3D {};
> +       struct cmdnames cmds2 =3D {};
> +
> +       add_cmdname(&cmds1, "read-vdso32", 11);
> +       add_cmdname(&cmds2, "archive", 7);
> +
> +       TEST_ASSERT_VAL("invalid original size", cmds1.cnt =3D=3D 1);
> +       TEST_ASSERT_VAL("invalid original size", cmds2.cnt =3D=3D 1);
> +
> +       exclude_cmds(&cmds1, &cmds2);
> +
> +       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt =3D=3D 1);
> +       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt =3D=3D 1);
> +
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1,
> "read-vdso32") =3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") =3D=
=3D 0);
> +
> +       clean_cmdnames(&cmds1);
> +       clean_cmdnames(&cmds2);
> +       return TEST_OK;
> +}
> +
> static struct test_case tests__subcmd_help[] =3D {
>        TEST_CASE("Load subcmd names", load_cmdnames),
>        TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
>        TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
> +       TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_ov=
erlap),
>        {       .name =3D NULL, }
> };
> ```
> If you build perf you can run the test like:
> ```
> $ perf test -v help
>  68: libsubcmd help tests                                            :
>  68.1: Load subcmd names                                             : Ok
>  68.2: Uniquify subcmd names                                         : Ok
>  68.3: Exclude duplicate subcmd names                                : Ok
>  68.4: Exclude disjoint subcmd names                                 : Ok
> ```
> Perhaps you can think of other values for the test so we don't run
> into more issues.

Running the test above I get the following before:
```
 68.4: Exclude disjoint subcmd names:
--- start ---
test child forked, pid 1443868
perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' fai=
led.

---- unexpected signal (6) ----
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
    #0 0x55ed35f172de in child_test_sig_handler builtin-test.c:312
    #1 0x7fea1d049df0 in __restore_rt libc_sigaction.c:0
    #2 0x7fea1d09e95c in __pthread_kill_implementation pthread_kill.c:44
    #3 0x7fea1d049cc2 in raise raise.c:27
    #4 0x7fea1d0324ac in abort abort.c:81
    #5 0x7fea1d032420 in __assert_perror_fail assert-perr.c:31
    #6 0x55ed35ea1524 in exclude_cmds help.c:106
    #7 0x55ed35f62e82 in test__exclude_cmdnames_no_overlap subcmd-help.c:11=
2
    #8 0x55ed35f17470 in run_test_child builtin-test.c:340
    #9 0x55ed35ea5834 in start_command run-command.c:128
    #10 0x55ed35f17ee3 in start_test builtin-test.c:546
    #11 0x55ed35f1838d in __cmd_test builtin-test.c:648
    #12 0x55ed35f18f2d in cmd_test builtin-test.c:850
    #13 0x55ed35e94494 in run_builtin perf.c:349
    #14 0x55ed35e9472c in handle_internal_command perf.c:401
    #15 0x55ed35e94885 in run_argv perf.c:448
    #16 0x55ed35e94bce in main perf.c:555
    #17 0x7fea1d033ca8 in __libc_start_call_main libc_start_call_main.h:74
    #18 0x7fea1d033d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #19 0x55ed35de4f41 in _start perf[52f41]
 68.4: Exclude disjoint subcmd names                                 : FAIL=
ED!
```
After the test passes and is address/leak sanitizer clean.

Tested-by: Ian Rogers <irogers@google.com>

I posted the test as a patch here:
https://lore.kernel.org/lkml/20251208172339.1445817-1-irogers@google.com/

Thanks,
Ian
> Thanks,
> Ian
>
> > ---
> >  tools/lib/subcmd/help.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> > index ddaeb4eb3e24..db94aa685b73 100644
> > --- a/tools/lib/subcmd/help.c
> > +++ b/tools/lib/subcmd/help.c
> > @@ -97,11 +97,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
> >                         ei++;
> >                 }
> >         }
> > -       if (ci !=3D cj) {
> > -               while (ci < cmds->cnt) {
> > -                       cmds->names[cj++] =3D cmds->names[ci];
> > -                       cmds->names[ci++] =3D NULL;
> > +       while (ci < cmds->cnt) {
> > +               if (ci !=3D cj) {
> > +                       cmds->names[cj] =3D cmds->names[ci];
> > +                       cmds->names[ci] =3D NULL;
> >                 }
> > +               ci++;
> > +               cj++;
> >         }
> >         for (ci =3D cj; ci < cmds->cnt; ci++)
> >                 assert(cmds->names[ci] =3D=3D NULL);
> > --
> > 2.34.1
> >
