Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4187CF16
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613228; cv=none; b=TNSaL+ARa8xdlQIGvBlCOVX0uXFe2wwZHXg4iOgZ+kLSs4Oh9obr47zoVufZ621jBDdmWf7DGwxphWeGeq4vSUqvidQHJuHa1l9jdBNKhP7CLYxbDCEnxIr5Y0W+SOijkCo7kVSj7AS+7R1RLSwgCnN3Sb4+jRc7WYXBc9UYsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613228; c=relaxed/simple;
	bh=uosmIa0GdVoMs1ABunZv/jgZZbiZMC9pM4CtJyMw8eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDWj1flPlCrqJQf9KFc83/hJme0LrCaLTStelxkeLgAHYc9zz6G/cl+dgZ7agWfocB69Ijx8i+nl3FaZHSH+CuFt4OaMiDxcAjH/n/L3zWM1074KfSIo7wy9WhuqjbvODJV+JD5jNlwgL34+GEaiIm1MlB58ZP2Vd7qookZyXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVw7f3s+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVw7f3s+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa901ad6f3so24655ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719613226; x=1720218026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EFO3/rFMxrftGPMwU438grq5mXkTNd2/4CMKLvTXOU=;
        b=tVw7f3s+rU02H6QKH7ysS51hBD47dgMzLa2mjz5L3bV71+27hOyTPBAwNxlggWQ0fA
         AEYJqYKAMBe/oKInKWA3VjaPuoYb1pXi1EcW3Ib9VrdRbKJjM0kmkfdtC9cHrTBNy/uT
         3GEtroipmoUv8haUQLySDjke3n8kAoEWFMb5dJs+UqtqoJ59pi4JBmKMkc5foLxjC26a
         Aq8sAyD4EKKbHyrX0vvgdbCO2EJv0YNHQC3zuhEoTtJzrlGe7fwrOdKrhFh+KmpIe8s9
         mBpXJsutzUWw3KcHNkROImkMu4SyRsuBoGi0yhHcn4o71P1OpGw0jtgXFWMPu49cOSvo
         HKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719613226; x=1720218026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EFO3/rFMxrftGPMwU438grq5mXkTNd2/4CMKLvTXOU=;
        b=q4AlkJwQQTQfwc6zqdm2zEKoLETkoNsFAIqQxxOjKdBdCHjh+o1UWGxcEPqvB64PX9
         gPgUTIhwFhkKzSoIGWSx5IiLt+e0LHsjAdbPDbNNdqic/C3HtOi1bksPsINifhVYk+Fc
         BMigj57yD/U4YRFkFAhLOGqX+v1kzAk7GAcw/Kipb0V+tERi9CdrfvROdovVYlGpsq5F
         9fOxJUj9v0/J7u7HH4b1IbmoRP+eC37JEIBBe+dUu3VcZ9UH/ghCo9PysmokMfhmY8jV
         lAVGDlcTfXaE3jYft4tvbUwvfQbSXD6vsV2mXpi9Y3Bm0Ce4P0sg5TFX18mZjrKzBDFe
         Vyag==
X-Forwarded-Encrypted: i=1; AJvYcCWPumLNACdqtErtEuDkKJlPnurx531XQh8sHQpVjY4gXWVc1D+8MbxFVs4UWk96uQHq7GqPWbNydFpeIdRjAnaHfcXCEpieaVxu5t4s5B1sOg==
X-Gm-Message-State: AOJu0Ywj9ypPUX/mQhnZVaeNa9nTQcq5oYKBo/FmfDxltER7qxS1eukF
	eKUcScnpMqerYT5q4A88UUAqZY/teDm0C727+XaxBVNar88Lz9bL+ZYUAhv8oqrwSFTbYqz+qo9
	bQ1MWC/MXjRfRgWfqpX/mhQZ2qxKDWCJQRssM
X-Google-Smtp-Source: AGHT+IHEe0h3YEu+Kbqt3fJNADmwaraZWr621drxzSA5gqe0zGtMw0IqlrozWqpLXnbDUQCy879BMHwjlDZh/iZscsw=
X-Received: by 2002:a17:902:c1c9:b0:1f6:15b1:4e05 with SMTP id
 d9443c01a7336-1fad8eda2f3mr354295ad.17.1719613225678; Fri, 28 Jun 2024
 15:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628215751.1512250-1-namhyung@kernel.org>
In-Reply-To: <20240628215751.1512250-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 15:20:13 -0700
Message-ID: <CAP-5=fXrQS=VKULkhtXjqS7Bw4CHmhNVhVPq+tV8cP=gBgcrYA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Print test description first
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 2:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently perf test prints the description of the test when it finishes
> to run the test.  But sometimes it runs long and users want to see which
> test it is running.  Change it to print the info in start_test() so that
> we can see it right after the test.
>
> No functional changes intended.

The issue is around parallel testing. I sent out these similar patches
that displayed a number of remaining tests in parallel:
https://lore.kernel.org/lkml/20240405070931.1231245-1-irogers@google.com/

My thoughts are:
1) we should create a list of parallel safe tests and always just run
those in parallel before doing serial tests. Things like testing all
PMU events, which may fail due to EBUSY, can be on that list until we
add some logic to spin for EBUSY.
2) the series above doesn't work because the waitpid with WNOHANG will
cause the file output from the command to be lost if the command has
terminated. We need to buffer that output by calling read prior to
calling waitpid, so we really need some memory associated with the
run_command to read into - maybe this isn't run_command any more but a
new abstraction that takes and creates strings.
3) why is the test run serially so slow? Can we change "sleep 1" to
"sleep 0.1" or similar.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/builtin-test.c | 54 ++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index c3d84b67ca8e..33defd3b7185 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -243,12 +243,17 @@ static int run_test_child(struct child_process *pro=
cess)
>
>  static int print_test_result(struct test_suite *t, int i, int subtest, i=
nt result, int width)
>  {
> -       if (has_subtests(t)) {
> -               int subw =3D width > 2 ? width - 2 : width;
> +       /* If it printed other messages, print the header again. */
> +       if (verbose > 1 || (verbose =3D=3D 1 && result =3D=3D TEST_FAIL))=
 {
> +               if (has_subtests(t)) {
> +                       int subw =3D width > 2 ? width - 2 : width;
>
> -               pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_=
description(t, subtest));
> -       } else
> -               pr_info("%3d: %-*s:", i + 1, width, test_description(t, s=
ubtest));
> +                       pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, sub=
w,
> +                               test_description(t, subtest));
> +               } else {
> +                       pr_info("%3d: %-*s:", i + 1, width, test_descript=
ion(t, -1));
> +               }
> +       }
>
>         switch (result) {
>         case TEST_OK:
> @@ -282,25 +287,12 @@ static int finish_test(struct child_test *child_tes=
t, int width)
>         struct strbuf err_output =3D STRBUF_INIT;
>         int ret;
>
> -       /*
> -        * For test suites with subtests, display the suite name ahead of=
 the
> -        * sub test names.
> -        */
> -       if (has_subtests(t) && subi =3D=3D 0)
> -               pr_info("%3d: %-*s:\n", i + 1, width, test_description(t,=
 -1));
> -
>         /*
>          * Busy loop reading from the child's stdout/stderr that are set =
to be
>          * non-blocking until EOF.
>          */
>         if (!err_done)
>                 fcntl(err, F_SETFL, O_NONBLOCK);
> -       if (verbose > 1) {
> -               if (has_subtests(t))
> -                       pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_d=
escription(t, subi));
> -               else
> -                       pr_info("%3d: %s:\n", i + 1, test_description(t, =
-1));
> -       }
>         while (!err_done) {
>                 struct pollfd pfds[1] =3D {
>                         { .fd =3D err,
> @@ -330,12 +322,8 @@ static int finish_test(struct child_test *child_test=
, int width)
>         /* Clean up child process. */
>         ret =3D finish_command(&child_test->process);
>         if (verbose =3D=3D 1 && ret =3D=3D TEST_FAIL) {
> -               /* Add header for test that was skipped above. */
> -               if (has_subtests(t))
> -                       pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_d=
escription(t, subi));
> -               else
> -                       pr_info("%3d: %s:\n", i + 1, test_description(t, =
-1));
> -               fprintf(stderr, "%s", err_output.buf);
> +               /* It printed the header first, print messages in a new l=
ine */
> +               fprintf(stderr, "\n%s", err_output.buf);
>         }
>         strbuf_release(&err_output);
>         print_test_result(t, i, subi, ret, width);
> @@ -376,6 +364,24 @@ static int start_test(struct test_suite *test, int i=
, int subi, struct child_tes
>                 (*child)->process.err =3D -1;
>         }
>         (*child)->process.no_exec_cmd =3D run_test_child;
> +
> +       if (has_subtests(test)) {
> +               int subw =3D width > 2 ? width - 2 : width;
> +
> +               /*
> +                * For test suites with subtests, display the suite name =
ahead of the
> +                * sub test names.
> +                */
> +               if (has_subtests(test) && subi =3D=3D 0)
> +                       pr_info("%3d: %-*s:\n", i + 1, width, test_descri=
ption(test, -1));
> +
> +               pr_info("%3d.%1d: %-*s:", i + 1, subi + 1, subw, test_des=
cription(test, subi));
> +       } else
> +               pr_info("%3d: %-*s:", i + 1, width, test_description(test=
, -1));
> +
> +       if (verbose > 1)
> +               pr_info("\n");
> +
>         err =3D start_command(&(*child)->process);
>         if (err || !sequential)
>                 return  err;
> --
> 2.45.2.803.g4e1b14247a-goog
>
