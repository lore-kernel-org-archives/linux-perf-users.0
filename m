Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE831BC08F
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187450; cv=pass; b=pW7gw+acueIbDcEqPl4RNo4DKYY+z79CQ7Q9giQV2Qa42EQAMUCGsAjUPhIaee2Iv2iiGERq9lGGI4K2B79aBe4afnXIHtyBfUDsWUVP0G6zFDzD0TfQYsUmcsgL6XmQJCm472DHVtM7fhU0+gHEEzzVpboySmS6bbR2Xr83Ycs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187450; c=relaxed/simple;
	bh=2X++cz32aJkr0IVQ0XDX2N6+fNl43uSVzC3bFVAtwME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcnsCShv3AjbmEjSqtGRfe10RLUumfXhm0xDUKldWpY16QpYr/2DKuyt1jmCul8X7MOB53S+2BjxqVxnheRQ7yLJy1b+MFjWKNmi31dl7VtIHL9GB4+sE2gx5NwBmdG18pal0I+KKz4sGkh6BcPUH0XZOyc2pwMcmQd4mO21+9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfs2puiX; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfs2puiX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a76b39587aso124065ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 08:57:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769187448; cv=none;
        d=google.com; s=arc-20240605;
        b=bjqAtvgK8EiFecgx6rDQrg8nzFj4F9blEtQsbasZJIma6/hGbyK9U7rwH5UHTyHBYT
         SIeO7fWPo/jEzqKr/fSwAOBz9XU/stz4vTlCe4AIGYn1twDZO6SHL9IbOjVXTJtxwer8
         nJF+NQ7X5pBKDHjBdGwbFybQqV4WCZtq34kntIqSMewikeYvDWTpaGkFan2j+ZXxjn59
         uG+VOHPy6yK2SfgZKYHaae0gvnBL/F9qUjFqpYTFwhZQ1dKOVnKLAZkwaKoLGFEJoO+t
         IDSt7PBFVw6mRGywvv9YGcB1j9RzkAza6LyTpLWW4rPQXWSEkLud/ROpBWvDTvcniV2k
         ccUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BicnkL95J4CUqu7n5fIEn6NS/hnja8FUeA30NbmYsNM=;
        fh=SBbyMHuUcDpnSHuzI5u4XeERU+dJCB5RdA7JpVdm2vg=;
        b=AOYnxrS/3WzLgCmjW9v4C/3uV1SwpDbLhpFwDKtAZMfXAMFQT21JNBGXVtRiGhWFYi
         WzpG0OPk25EtVPf3evI7UsqYEzi9SzidOrXiAXY1T0vKRilHpDqDAQ1xQ4Uo1VaLY2fs
         giam0DplIS5vQGe3MQB/CjnEkCqH0QJ7DiQWh7iqD1/uUX+vdwo6b+JqPL29PQ2XUDLP
         zk3HDUl4/91nOVm1Al7cQcJ3L8Gk7R/g2NqmGVetv72XmmZuG9PMLZ0wOvqM2vQHnvfB
         4chwXi58kBaroz4ErGWRP833rMJAucwmgW5pPdN9xbcwtTlBetMqk4LmLF55gVtJdQ+Q
         u0zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769187448; x=1769792248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BicnkL95J4CUqu7n5fIEn6NS/hnja8FUeA30NbmYsNM=;
        b=zfs2puiXo1jjFkkQf+SJ2PXDDN/OtBF/JqmnAC4AskiSZCusDeLBZpKYWqoR8mPCmM
         uCLIHcIgXw7PtbE6RZ1KjffMcAToNZkwMdN81ewD89hgFzYry6UVjr0TOI5tvtafLTD/
         CvvDsSgtfdZPbmA465yRpUPHQLsymBcK+RW7dvUj4A+BOwOFpA/FWmC/jP/j6c2DzFix
         504hEdO1o+1EXyOu+yOD7SiHPEyH1NXIJqwH/WTX4G9QYpeNh3THLb+HXCaBrP8K8LmA
         XbOOW1BWxW3/qOZONHgWuKbs9SkG4ejBf7hBx4Cjyv1vV4u6a6gXg4hHW+FVai+2eUtZ
         y6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187448; x=1769792248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BicnkL95J4CUqu7n5fIEn6NS/hnja8FUeA30NbmYsNM=;
        b=WKf4gq6tilzxmduxCC57OnB1KsCvbsbp87xAYk2p9iIWGMZqOlUElW2XkUAbc8Iexl
         KUEFRwJTK2GfEcA1B/jOD7rCgv3jbafsG3aesAxuGgnuy9xWE1EQYY9qMenrBRFi+TgA
         TmeBRwM+ne+euQDYzqmeX5RiflgsdGSShUKKlNkgx+BWKu/BBhy0i0y5gFmbMKDXqj7E
         W84SsAVkNXp405nmMQYxiqDnQzKzTPiAbKENFmEVfbOSAyXGFvmZivbt5xcmx84ITvyE
         72ij2bmmZc2nKNBCmnlRH8beL5pX1xEE1E+GaRKm7dFkZeer1mNTr53qNEvEPC3+namc
         lK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg3I/ITIC9l52VkTYM8ZXPDrB1vKRwugIKIfxbewL570p3xYX1301nkba63/OversFfWCpD7xJ1nLOBJslz8kI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kLLGS7TvBKU6FYE1NV3YOBXtfG5/SOBbC8w2Ewk3LX0FaBIy
	VNjPpAWlkRMWoAYqhcL8rQZewv1U0XZtjhjPpM1v34oBZlI16FSpx29VjRbEZu+9HcHwd0msQ3K
	Q/65WioElgTbzaPblfRJTnrLMKWXEJv+DNZ2bNvCX
X-Gm-Gg: AZuq6aJ67KBdJjrTg51gaI+gqmZ/b7uxJDLPLbQM93eU7holWb406iNXLKEjx8UG3kj
	TfQA18a0k2GlpINOuK+8Int5tacvDpB1rR4g3PTblq/bRDtAZBWqHsO3AvAM8BAOg3ce9DHQYmD
	f861MXKfOoYx2Fiozk5uqtyHWjy3rGYNAJdK7wrE81Z2T4laCHCHZIw6cInONIwZejNAEIszzth
	QeOr7mjw6iHv42BpoeO1vd4lvtS+2pXUUsYboqXd3pEIWx2IHo4vMWHzdTsO2FrpH9CvRBFY44G
	2jeIXQ4AvHki49/2ygelvKHzgw==
X-Received: by 2002:a17:902:f546:b0:2a7:516d:18e2 with SMTP id
 d9443c01a7336-2a805d15923mr3187605ad.9.1769187447555; Fri, 23 Jan 2026
 08:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125155648.197527-1-jbrnak@redhat.com> <20251125155648.197527-5-jbrnak@redhat.com>
In-Reply-To: <20251125155648.197527-5-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Jan 2026 08:57:16 -0800
X-Gm-Features: AZwV_Qhn8It0xfWqjrEYkkBVkre2fqxD4doMi4pIbcc8uz_Z5Y8uxwGDiztQtns
Message-ID: <CAP-5=fXmkpLMh=rd4xExDTUyp_Dw=AP87Zr2rFFm3Me66=RknA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] perf test: Introduce storing logs for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 7:57=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> Create temporary directories for storing log files for shell tests
> that could help while debugging. The log files are necessary for
> perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
> is set keep the logs, else delete them.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
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
> index 04114e6dc2d6..e5a4e86db644 100644
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
> +       bool store_logs =3D t->priv && ((struct shell_test_info *)(t->pri=
v))->store_logs;
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
> +                                               ((struct shell_test_info =
*)((*t)->priv))->has_setup =3D
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

Is the test log clean up happening while the tests are running in parallel?

>                 }
>                 if (!sequential) {
>                         /* Parallel mode starts tests but doesn't finish =
them. Do that now. */

At this point we're going to wait for all the parallel tests to
finish. Shouldn't cleanup_shell_logs be after the work has completed?
Something like:
```
if (!sequential) {
/* Parallel mode starts tests but doesn't finish them. Do that now. */
for (size_t x =3D 0; x < num_tests; x++)
finish_test(child_tests, x, num_tests, width);
}
cleanup_shell_logs(tmpdir);
```

Thanks,
Ian

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index 3703ad7b3b75..bf974e4b9051 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -272,6 +272,7 @@ static struct test_suite *prepare_test_suite(int dir_=
fd)
>
>         test_info->base_path =3D strdup_check(dirpath);           /* Abso=
lute path to dir */
>         test_info->has_setup =3D NO_SETUP;
> +       test_info->store_logs =3D false;
>
>         test_suite->priv =3D test_info;
>         test_suite->desc =3D NULL;
> @@ -438,6 +439,8 @@ static void append_suites_in_dir(int dir_fd,
>                         continue;
>                 }
>
> +               /* Store logs for testsuite is sub-directories */
> +               ((struct shell_test_info *)(test_suite->priv))->store_log=
s =3D true;
>                 if (is_test_script(fd, SHELL_SETUP)) {  /* Check for setu=
p existence */
>                         char *desc =3D shell_test__description(fd, SHELL_=
SETUP);
>
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index 013031239883..05d403e9be31 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -16,6 +16,7 @@ enum shell_setup {
>  struct shell_test_info {
>         const char *base_path;
>         enum shell_setup has_setup;
> +       bool store_logs;
>  };
>
>  struct test_suite **create_script_test_suites(void);
> --
> 2.51.1
>
