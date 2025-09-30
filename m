Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AE19F43A
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258834; cv=none; b=BU3TLS+fD7H8d9e2H+LCa98uXs/6+jpSeOsVilPtuwLSbE3+43dMDWLRyx5ntksZAoPsLOl92tiQtVLgIYSjM+r5YXMNMYeB53eyH1Ig/Qx/BFh2aKYoQLeemVxYsd0lB78TxqEK6WlSH406DXAFcH6RQ8CiC4+pAgrNx76umMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258834; c=relaxed/simple;
	bh=WDi+kOMtuCbFd2kTDj/xboD7vpSTciuQOf5+6GI2qmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZRA52gDF9PrTiIuZ8sqvM+FmZQAzXuKjIJztJ2h5mPUUPEJChFm7kGB61S68pmr9paHaL2MpduIGAQH4udaKOQWCVvuVVgpJ4htHgVuzaBowF84tZxe49Q6kz6HgohcYHHLVWu8GwKRuISHnX4k8tGNvs50Ync1vPSDGTtL+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWXFrNBI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWXFrNBI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so42695ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759258832; x=1759863632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43W3+v+W37Q4GWwZZ+OBrrlblFUON9RNbFJsuNBD3zg=;
        b=SWXFrNBIvA1WXHEIJFO2UPxp7R6DwRkiZgKykZmQPNC9vM13tmH/FRrvRgncqgfa8j
         AdgtTbrElx0bUlInzLvQuvaVHZM13UZpcrZIbg8exIYcIaibHckNMEnAvzG3rc/Bu6/t
         ZoziqY3Flk2bZDppbWAKv10GXxTzTUAzIiB8t8rlC6IPIye4IObTCxHXM02CTsAbh8kE
         iDsHSgV3BKIggLOQys/bjoR7yfZRgYXSdrbAZvm7S6DRiA73bx4w2yPP3509NN9EBua3
         yKlQ4yXDm6CBazYP4FigC3bNGMBYG1tIDEye/rML5mx304JSda63UKGGvFqaghFNFubV
         zKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258832; x=1759863632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43W3+v+W37Q4GWwZZ+OBrrlblFUON9RNbFJsuNBD3zg=;
        b=lO0lIhyU/5YMwgLkfXmoprQvSaXSCFP/v2FjMOG03voYtO4vV5NoE8JD5E4JqMEwEB
         VVwibRcXCM4pSxJQB8HXKO0yWONLsf5ug3trB1L/WpCgZIT1F6ogHPu1qiDijFT6X3o5
         V7WXguVzPdHa7T7qIEmhjufbN0YqMNhwtz10k5ikDX+wET3FQx+bV9qwGsWTnDkntSWQ
         +4PY4ToduIOw1NeYIClP68t2b/hpg8FTJC1I79fuoGVBJhENffrdH0qW0gh/8nyFXnAg
         /6y/UnSgqdQ/IBlAVTkgBxGgmXN71MpYgxxpVrxnX7CjgZF4MNPY/cDe/L7mrqQtyqru
         eAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5b0pji69mkJYPWzgiJFcZXWBoVv/eFGq90jUSVfK5rjOdHYO/55BWyikxTVUZafNWxy9cbOncmiMIT3uP5A+z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0orklVO6S7WyCRmY8MAprjZF9e3vAGraLDIVAQDLoRW3wb+Fc
	HWIoCWVXkYz5A1CwqmW15kdYUmLOnNXZYDIzBmi0v4x3twxeGqAA4N4ETFltSoomIgDAlKbgtRR
	o4IeJnY3eXbif0AhnQ2gg6DxTa4aDarLbQFmTC81LsdGkEX3+VlTDfRQ2HjE=
X-Gm-Gg: ASbGnct+gK945UWfJuGv34K1EgLUynvi3ZYn1Q7eUQHGA0DiCd1RIFmJC2PjY2PId+4
	PXv1kLkjbHy8qs7UoZriaNuU/HrN4YygAYOszqkVcFb/ts8KyOgte+1BDJepZ5m9VQA2YtcIHbh
	o28lxn8WQ7sgtjwlZ3ji5LZaQMK3iXh8wgLBntCkPo8ITgnFHGaBCktaTvH/0qYVTCn08qW1FZD
	6kKfiEMopMrQrYiTp9oRTTFznns4SzSC2qvnD695zVyfV/FFbJYCLCzaH81fvQZ1Xl4w2wN7N1J
	70k=
X-Google-Smtp-Source: AGHT+IEw7qp+IVzcy2v8GCFyhpJdtkddMCwZwYWMuaXJe8Ku/NnGZBBsZkTYnPSGelfPJr58aSqLsKjFXRHON1dkeKQ=
X-Received: by 2002:a17:903:3d0e:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-28e8003c15amr629375ad.6.1759258831098; Tue, 30 Sep 2025
 12:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930160923.13728-1-jbrnak@redhat.com> <20250930160923.13728-6-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-6-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 12:00:19 -0700
X-Gm-Features: AS18NWDlKkWqDP039ulJhsOqIYUK5F8ofgvxM702USqrV-GXimsZguqunxOOL5A
Message-ID: <CAP-5=fUJZEoAbNu+ZzjgshHRbq94dLn6-KPdzC=i9i350K=4dw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] perf test: Introduce storing logs for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:09=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> Create temporary directories for storing log files for shell tests
> that could help while debugging. The log files are necessary for
> perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
> is set keep the logs, else delete them.

I think log files for tests are a good idea. We run tests in parallel
but read the stdout/stderr sequentially. For a failing test we may
fail to read stdout/stderr in some situations as the process has long
since died. Rather than add log files specifically for shell tests
perhaps update start_test to pass the file descriptors to the child
test processes and then clean up in finish_test?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/builtin-test.c?h=3Dperf-tools-next#n528

Thanks,
Ian

> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c  | 91 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests-scripts.c |  3 ++
>  tools/perf/tests/tests-scripts.h |  1 +
>  3 files changed, 95 insertions(+)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 6fc031ef50ea..a943f66cbac0 100644
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
> @@ -282,6 +283,85 @@ static bool test_exclusive(const struct test_suite *=
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
> +       if (typeflag =3D=3D FTW_D || typeflag =3D=3D FTW_DP) {
> +               const char *dirname =3D fpath + ftwbuf->base;
> +
> +               if (strcmp(dirname, "logs") && strcmp(dirname, "examples"=
) &&
> +                   strcmp(dirname, "header_tar") && strncmp(dirname, "pe=
rf_", 5)) {
> +                       pr_err("Unknown directory %s", dirname);
> +                       return rv;
> +               }
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
> +static bool create_logs(struct test_suite *t, int pass)
> +{
> +       bool store_logs =3D t->priv && ((struct shell_info *)(t->priv))->=
store_logs;
> +
> +       if (pass =3D=3D 1 && (!test_exclusive(t, 0) || sequential || dont=
_fork)) {
> +               /* Sequential and non-exclusive tests run on the first pa=
ss. */
> +               return store_logs;
> +       } else if (pass !=3D 1 && test_exclusive(t, 0) && !sequential && =
!dont_fork) {
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
> +
> +       pr_err("Failed to create the temporary directory");
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
> +               if (!keep_logs || strcmp(keep_logs, "y") !=3D 0)
> +                       nftw(dirname, delete_file, 8, FTW_DEPTH | FTW_PHY=
S);
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
> @@ -628,6 +708,7 @@ static int __cmd_test(struct test_suite **suites, int=
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
> @@ -657,6 +738,15 @@ static int __cmd_test(struct test_suite **suites, in=
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
> +                                       /* Couldn't create log dir, skip =
test suite */
> +                                       if (tmpdir =3D=3D NULL)
> +                                               ((struct shell_info *)((*=
t)->priv))->has_setup =3D
> +                                                       FAILED_SETUP;
> +                               }
>                                 test_suite__for_each_test_case(*t, curr_t=
est_case) {
>                                         if (!suite_matched &&
>                                             !perf_test__matches(test_desc=
ription(*t, curr_test_case),
> @@ -669,6 +759,7 @@ static int __cmd_test(struct test_suite **suites, int=
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
> index 10aab7c19ffe..9b4782bc1767 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -255,6 +255,7 @@ static struct test_suite *prepare_test_suite(int dir_=
fd)
>
>         test_info->base_path =3D strdup_check(dirpath);           /* Abso=
lute path to dir */
>         test_info->has_setup =3D NO_SETUP;
> +       test_info->store_logs =3D false;
>
>         test_suite->priv =3D test_info;
>         test_suite->desc =3D NULL;
> @@ -434,6 +435,8 @@ static void append_suites_in_dir(int dir_fd,
>                         continue;
>                 }
>
> +               /* Store logs for testsuite is sub-directories */
> +               ((struct shell_info *)(test_suite->priv))->store_logs =3D=
 true;
>                 if (is_test_script(fd, SHELL_SETUP)) {  /* Check for setu=
p existence */
>                         char *desc =3D shell_test__description(fd, SHELL_=
SETUP);
>
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
