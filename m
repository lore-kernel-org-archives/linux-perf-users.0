Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F15BA2E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127048; cv=none; b=csHu6gANZq8VWNyz4cFaqoo9uyX8Jw7XhAmgqylm5HvZ4vntmHuYK8t1Uyych8CWO2QnEqdW+TGvcrYs473IT56o+pssyG5wrgNlVD3jxi9JZTAgxrpLYgMc3CMGYOz8AXvYVHyZLuhI6+egBFmObj65P5wy+8R5Q9yokUg2FHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127048; c=relaxed/simple;
	bh=xWPuZPyD6AD4ttWXNLenqhc/vYTYd/LsIesyNd1rCps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZcwBhqqvNu7Xe0hWIwPE8kAPmtegiYIL7bE3LD+gDilWidPXCsSlkJ+qzQi8vcQzlhsYGvYYuACVeki+iurJ8vjZBGHsdhb4S+uidsynw5pALvGdjoC+dSNplZ0WPRyLJ1Z++ywGaK+peFvKgKjNaBRI8PlsY5WduhgqekuG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOstkqiX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOstkqiX"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e283b2d065so6115ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753127046; x=1753731846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsK5pnoT1g+F/vi1tUc8e94tYZEFjRh7lpAcZTfaDso=;
        b=ZOstkqiXwEB9hVES6NtdFC6g3pJoOMllMoZUHgRYe3ZY6YgCKdc9ADkGPOEqJ9xgde
         aAh6PFSkGUC2YrW07dMATrZyc8WpQDzZkEAeTMEtryu2gjNuIcLr/seHUOdyI22oPD7h
         3cWZP0c7G+UulUoju9fHRHPFZ86RbaogfSVTOKFdvRWexZ4vIWXD+YdNMPr+Wd4x6lwV
         MRN/Do+VmXZTM/NRxUjeDhcMPHxTCz13oOhonjrMqGmCnAG+bT3o9H+WUHKVP1kDlRgt
         RHFY/9JUrGmvpyVWjhpoNKzZYw0NveFLrKcuvSN1twJTyXN/SDjyERlcUJIFV0aMlnmz
         1ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127046; x=1753731846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsK5pnoT1g+F/vi1tUc8e94tYZEFjRh7lpAcZTfaDso=;
        b=Kdj5nQ1L+HAjD8Owsuwl8e8D+9oAwhkql4l/j44U/pPVfIJKXwoTP59QhXqq3sgSE6
         y4N4Gg5gbHEofK4Yt4l3Jx+Co8f8zL9f/MKTExyLWH3o/ARx+0cmK3bualK3cE2PoECP
         /lhkmYa2vxhYKS/0+bB+9dh+mSWA24QtQqfu3uOt8CtM4foDJyNqpC3GfwAAwdio0YC0
         JUDaHa+HJqW72ajN5xrDr53reTPGqysjVaVuAyhmWIekCKown5pY0LwlQBpSlnjucPmf
         hDCsS8x1fBA9ffxaZA8RCcrJp8Sst+qVbGjaK4cHMLJatNtQAHv7We8oVxAMFtWLBrVm
         LGHw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfOC7i7Cir3NDujy6nrPKKF6MKgFthJJKuQQvQiBLTJvGInzqv2WtD3do5v5pCVidoQHEhWI2HsM0020JgmqI@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQkWL+fDF1OF3mKBxvom6y9j/sKHEouChYtF5vNCCwOcFecDO
	Xvr+5P01ZVeE4tEzMi2rS5x5hphqIZjuy3I7d4Yn6qbf8Np1ZfvgHQCgNynvjjEarftbVoGwfKx
	1Lq+tyyUP41hWH0NayInx+kXzZn+xVQsORPxl5d0U
X-Gm-Gg: ASbGnctvas85+JsAV3xyXgeyvIXIGEbWmoBiiEf+dITAYbsxNKHNJ60eN7TIpewU6FY
	IkaToCwxpTkL96CDFwa59KfwZ+HGL3Z553WpNDStf2IWV/rzb0aa3jLUOL+gZvdAvJFumTATCBV
	cw5FID1g4I4DGPlv5/FTKW2jCEZX+KLwJGYqnow9zpxrGVlaLTcW22ZfMu81Nn0W9zfBSk35uRp
	cMRWMqTnv+Zr2RA2+0dJD1ir1bomW/GLGu2
X-Google-Smtp-Source: AGHT+IEM/lS6y4DuHKiIEoKKoyTfjmEUxznON4WUoGrg1CsBYoBN3tBLUNLNmCEDnbtoPfWUe0tncsmQ32lIXB4Djf4=
X-Received: by 2002:a05:6e02:1b01:b0:3dd:a562:ce54 with SMTP id
 e9e14a558f8ab-3e2bf33d62emr419775ab.15.1753127045578; Mon, 21 Jul 2025
 12:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113182605.130719-1-vmolnaro@redhat.com> <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-6-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-6-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 12:43:53 -0700
X-Gm-Features: Ac12FXyMSWqy1antYF9o2QJZ8vpA9I3p3hka_tbci7eW7keA-TpusPEJVHwUZ8E
Message-ID: <CAP-5=fXMdXu+MN9-VRnKPe7n9FmbyZc+x5myrq-X1JgOV9vf_A@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] perf test: Introduce storing logs for shell tests
To: Jakub Brnak <jbrnak@redhat.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:27=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> Create temporary directories for storing log files for shell tests
> that could help while debugging. The log files are necessary for
> perftool testsuite test cases also. If the variable KEEP_TEST_LOGS
> is set keep the logs, else delete them.

Is there perhaps a kunit equivalent of log files so we could keep the
implementations as similar as possible?

Thanks,
Ian

> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c  | 90 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests-scripts.c |  3 ++
>  tools/perf/tests/tests-scripts.h |  1 +
>  3 files changed, 94 insertions(+)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 4e3d2f779b01..89b180798224 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -6,6 +6,7 @@
>   */
>  #include <ctype.h>
>  #include <fcntl.h>
> +#include <ftw.h>
>  #include <errno.h>
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
> @@ -282,6 +283,86 @@ static bool test_exclusive(const struct test_suite *=
t, int test_case)
>         return t->test_cases[test_case].exclusive;
>  }
>
> +static int delete_file(const char *fpath, const struct stat *sb __maybe_=
unused,
> +                                                int typeflag, struct FTW=
 *ftwbuf)
> +{
> +       int rv =3D -1;
> +
> +       /* Stop traversal if going too deep */
> +       if (ftwbuf->level > 5) {
> +               pr_err("Tree traversal reached level %d, stopping.", ftwb=
uf->level);
> +               return rv;
> +       }
> +
> +       /* Remove only expected directories */
> +       if (typeflag =3D=3D FTW_D || typeflag =3D=3D FTW_DP){
> +               const char *dirname =3D fpath + ftwbuf->base;
> +
> +               if (strcmp(dirname, "logs") && strcmp(dirname, "examples"=
) &&
> +                       strcmp(dirname, "header_tar") && strncmp(dirname,=
 "perf_", 5)) {
> +                               pr_err("Unknown directory %s", dirname);
> +                               return rv;
> +                        }
> +       }
> +
> +       /* Attempt to remove the file */
> +       rv =3D remove(fpath);
> +       if (rv)
> +               pr_err("Failed to remove file: %s", fpath);
> +
> +       return rv;
> +}
> +
> +static bool create_logs(struct test_suite *t, int pass){
> +       bool store_logs =3D t->priv && ((struct shell_info*)(t->priv))->s=
tore_logs;
> +       if (pass =3D=3D 1 && (!test_exclusive(t, 0) || sequential || dont=
_fork)) {
> +               /* Sequential and non-exclusive tests run on the first pa=
ss. */
> +               return store_logs;
> +       }
> +       else if (pass !=3D 1 && test_exclusive(t, 0) && !sequential && !d=
ont_fork) {
> +               /* Exclusive tests without sequential run on the second p=
ass. */
> +               return store_logs;
> +       }
> +       return false;
> +}
> +
> +static char *setup_shell_logs(const char *name)
> +{
> +       char template[PATH_MAX];
> +       char *temp_dir;
> +
> +       if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name=
) < 0) {
> +               pr_err("Failed to create log dir template");
> +               return NULL; /* Skip the testsuite */
> +       }
> +
> +       temp_dir =3D mkdtemp(template);
> +       if (temp_dir) {
> +               setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
> +               return strdup(temp_dir);
> +       }
> +       else {
> +               pr_err("Failed to create the temporary directory");
> +       }
> +
> +       return NULL; /* Skip the testsuite */
> +}
> +
> +static void cleanup_shell_logs(char *dirname)
> +{
> +       char *keep_logs =3D getenv("PERFTEST_KEEP_LOGS");
> +
> +       /* Check if logs should be kept or do cleanup */
> +       if (dirname) {
> +               if (!keep_logs || strcmp(keep_logs, "y") !=3D 0) {
> +                       nftw(dirname, delete_file, 8, FTW_DEPTH | FTW_PHY=
S);
> +               }
> +               free(dirname);
> +       }
> +
> +       unsetenv("PERFSUITE_RUN_DIR");
> +}
> +
>  static bool perf_test__matches(const char *desc, int suite_num, int argc=
, const char *argv[])
>  {
>         int i;
> @@ -626,6 +707,7 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>                 for (struct test_suite **t =3D suites; *t; t++, curr_suit=
e++) {
>                         int curr_test_case;
>                         bool suite_matched =3D false;
> +                       char *tmpdir =3D NULL;
>
>                         if (!perf_test__matches(test_description(*t, -1),=
 curr_suite, argc, argv)) {
>                                 /*
> @@ -655,6 +737,13 @@ static int __cmd_test(struct test_suite **suites, in=
t argc, const char *argv[],
>                         }
>
>                         for (unsigned int run =3D 0; run < runs_per_test;=
 run++) {
> +                               /* Setup temporary log directories for sh=
ell test suites */
> +                               if (create_logs(*t, pass)) {
> +                                       tmpdir =3D setup_shell_logs((*t)-=
>desc);
> +
> +                                       if (tmpdir =3D=3D NULL)  /* Could=
n't create log dir, skip test suite */
> +                                               ((struct shell_info*)((*t=
)->priv))->has_setup =3D FAILED_SETUP;
> +                               }
>                                 test_suite__for_each_test_case(*t, curr_t=
est_case) {
>                                         if (!suite_matched &&
>                                             !perf_test__matches(test_desc=
ription(*t, curr_test_case),
> @@ -667,6 +756,7 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>                                                 goto err_out;
>                                 }
>                         }
> +                       cleanup_shell_logs(tmpdir);
>                 }
>                 if (!sequential) {
>                         /* Parallel mode starts tests but doesn't finish =
them. Do that now. */
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index d680a878800f..d4e382898a30 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -251,6 +251,7 @@ static struct test_suite* prepare_test_suite(int dir_=
fd)
>
>         test_info->base_path =3D strdup_check(dirpath);           /* Abso=
lute path to dir */
>         test_info->has_setup =3D NO_SETUP;
> +       test_info->store_logs =3D false;
>
>         test_suite->priv =3D test_info;
>         test_suite->desc =3D NULL;
> @@ -427,6 +428,8 @@ static void append_suits_in_dir(int dir_fd,
>                         continue;
>                 }
>
> +               /* Store logs for testsuite is sub-directories */
> +               ((struct shell_info*)(test_suite->priv))->store_logs =3D =
true;
>                 if (is_test_script(fd, SHELL_SETUP)) {  /* Check for setu=
p existance */
>                         char *desc =3D shell_test__description(fd, SHELL_=
SETUP);
>                         test_suite->desc =3D desc;        /* Set the suit=
e name by the setup description */
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index da4dcd26140c..41da0a175e4e 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -16,6 +16,7 @@ enum shell_setup {
>  struct shell_info {
>         const char *base_path;
>         enum shell_setup has_setup;
> +       bool store_logs;
>  };
>
>  struct test_suite **create_script_test_suites(void);
> --
> 2.50.1
>
