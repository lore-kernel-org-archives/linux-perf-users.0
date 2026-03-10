Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854423101C0
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156183; cv=pass; b=ItbG3FQGmbYc69Db4/nishFRnGOhg8RZLkKzEiEVEGXXoGCc4HW9jH5YqrpZZMKqvI9bx0pcjxL3hJ6y3LglFeNy97cUmxmABWESP6Ik/wrzUdQzJ60LsS3+lU+QnqUFHkI+YS9Mm4Wf7W0hv/QQbS+krBCKkWuXlHJm/07jcws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156183; c=relaxed/simple;
	bh=a6kxvYOwf8y6EbYqD/I79AOj9D0QkacJAfJfR5Ct+No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ7llrXJeL/wEQMPksu5DVCXGmGMF8rFMFk33cf5NGQFo6pPKUPvxnduQppJ5dg12VgY0JiMz9zKKTMO7WzCd5kHd1XfLdzpfIKw4rqjs3y9/GtcGSqPzdzT5p2lTBJWztJ98qvhyEpHA2RFaynKRq94IT8nVwEo/NVPkDz6EfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgBwBXGN; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgBwBXGN"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1270f10a774so10313c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 08:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773156182; cv=none;
        d=google.com; s=arc-20240605;
        b=F656sv7ZtEzs84rvCMZH+QRUgIBAoobmWamQS6CX1jT9CMHCi2VBAZ62TMLg32rrRC
         RgXAQDV8O6YoVCmvYQoo9yY5ICNsEBEQzglqDxDopMcX66imCPVyUwS5cRmA7My5nxzb
         BwdyOOfbCWTn7rlu8tOoMdt1TvKkjfqMglBkwdUn/jJM20GHSsWro2s1rHdy1G1DfOeZ
         yeFkllRTF6b1BY39ZkwJ4GX0xwgVbScD8FFpYWWM56SZP1fUw0/SxYQo5cP/1BMFoCcM
         vTL2qWZEZP36p7IgJOmyMdjlRXWFZFQVuyQdqIOdRSzOLY0rr7kXyX4c+bSh0Tr2JjPL
         DLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkpSWMmBGDoTKnfXB84P5fs71N8w3y0/StyiyLOlFuw=;
        fh=BwSYWz1STnAYmmLVctEMeI/Q7NuNJG80u60wk7Uuh7g=;
        b=c0ta+S4vMV7YYNBl3R0w5USU77DsPYLFakx8n3BFRAVbLyiYcE5jQgV3CnT8ybWfag
         /4IAK8GH46Ji1ZcS5z/H9nnePkms6suctZZy2SsTKu0cwEfMnHwqB8RnyOK9aLWpRVNG
         1cZEC1SVkCJOGYX+QgIAbh5L89PpBRcTmacJL4NRzgVze1cN4YQkc1U0onwb8dbHD08e
         omYDFPOtTM7i8SkaEkiZBG0oEWN9oIBUdI3yQtiz5LAgitLaPXj55T99IuvGhdLcf2Id
         5Z/+GVOwBGS0IfEMTLy9zQ7ld4GD7vz84mDFj97CeUUAmhXpKP6TbL1dRn9TdeeQFA9Q
         4F8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773156182; x=1773760982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkpSWMmBGDoTKnfXB84P5fs71N8w3y0/StyiyLOlFuw=;
        b=OgBwBXGNM6QPcuBAO6MCTBwz9Ib/s1I406bhsWTKKHki5TE6MOTVbCE5uk9ZcTp5xG
         UGMUC10yzZcxsVFOTo2q+JxZvGU3JDu8ab7Vtr7A/BsK5jku1BGVVDrTePPM9jrAeEum
         NwNYdKnUk4SL3jDffG95QgmkiGUUJ99DfJYFHLn0wzX5NOEp8MNZknmVIkLPuQ58Zr6w
         mpH8x9Th+WSpqbBkEKGp0FtpKwyO6KU3wnkEknI2BN8EvhVujjbmAXzGSjxfdtmCsMhu
         nP/KwCdAWBk9QPL+PRIA2/zc6a6eARXCTaCh9yDuhfVIOMU622AfvNaTLD2lBFgpYNun
         CW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773156182; x=1773760982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkpSWMmBGDoTKnfXB84P5fs71N8w3y0/StyiyLOlFuw=;
        b=DRp6XGpKi1tro+ed7z4klM+0atRDnaN68oan9kVj0Gq8+E5Nd6giBC074ylSEHreGN
         /hrym5Apcqr16eap5oAs/ww/mHoMTJl16eDFQWUZJOX9Yhz2mHyDj/iRcJwwnZ4mq/X/
         NWZp4ZZOqKIhoySG5HwICQafkSGDgbJLZZUxBXHFTMdEBgX62IxcSYwKa+YT4nawsJCC
         DdDG4drJTXONhs9GfoDvZOxk5cbW9EOI02NHE8Jie+UySNoCOOVPEtTWaXL8Q1v9gxfo
         zbV9U8MxBrXEQHxMptfug7T/gSvJIWh6OLN/MwkClBnRnfgyYXp4JAQz9AVUSjdQ8pyE
         9SVg==
X-Forwarded-Encrypted: i=1; AJvYcCWenlHhiZOGnMDujnqfm0T7+mVy1z1cIfWGjUIDfHA1x2Y8WMaI2252V/BCyLJKXFjpPMccKS/DulYiXeGaxsFd@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3VsgshRuYK52s9EVBvBhK0p7oT5L81f1LYQYagLrQXPh+0V1
	tindqkGfHBIkHVNQYnTIgHoj9Yhs6i4bnxKqV+jFHEgeYoDA1x+6s4Q8pVBKv3ZNGTpXF36bVse
	rvlhSTSpf//NnwH+PekSLbBGPV3LP/Jok7l+ch2Bs
X-Gm-Gg: ATEYQzwtFEXj0djbzNMSI+AdKc0mZ9e1L1xd4J9aneZWSC6tn+4MjX0n6uqfDjqTo+H
	ucVLzY8jmgJeB0d3oYliRoBfx/7KNNLJpsgjVRm3Q74D9YN16zdzTVqHlrnjO1VV5h3Ab2EOpWT
	xm0QOEvaSuYPnAXJRjXCIFka4NyPef8Fk9m3Fkdj+6IA2mjolA9i3GjRNkEQaDY6QgldZxtVULt
	HA7USXVPp6ofrF5CyH8BLAC/WVUF/Xe5+ebSRMCUvvQjHgEBVd/ghqE9ZnqA1kQ6AalCyow4Xon
	AVMnbJiBDm6dIVieOT5A2TD5T68DcDBQ4DM=
X-Received: by 2002:a05:701b:4283:20b0:127:3459:3361 with SMTP id
 a92af1059eb24-128de46eb5amr146652c88.6.1773156181028; Tue, 10 Mar 2026
 08:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155728.98026-1-jbrnak@redhat.com> <20260309155728.98026-5-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-5-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Mar 2026 08:22:48 -0700
X-Gm-Features: AaiRm50bxjtKAWvxiuYyAzM5u9GIwZxZgk_JuiU4S14Rm63ridp_JAfHigWFYxg
Message-ID: <CAP-5=fWV2M1KpmPg114W5brc4_eMHNSw2TrJ_tPFs97+V5mL+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] perf test: Introduce storing logs for shell tests
To: Jakub Brnak <jbrnak@redhat.com>
Cc: acme@kernel.org, acme@redhat.com, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:57=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wrot=
e:
>
> Create temporary directories for storing log files for shell tests
> that could help while debugging. The log files are necessary for
> perftool testsuite test cases also. If the variable PERFTEST_KEEP_LOGS
> is set keep the logs, else delete them.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c  | 103 +++++++++++++++++++++++++++++++
>  tools/perf/tests/tests-scripts.c |   4 ++
>  tools/perf/tests/tests-scripts.h |   3 +
>  3 files changed, 110 insertions(+)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index c1515fa8a947..70f4a61357ec 100644
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
> @@ -51,6 +52,9 @@ static unsigned int runs_per_test =3D 1;
>  const char *dso_to_test;
>  const char *test_objdump_path =3D "objdump";
>
> +/* Number of logged test suites. */
> +size_t num_logged_suites;
> +
>  /*
>   * List of architecture specific tests. Not a weak symbol as the array l=
ength is
>   * dependent on the initialization, as such GCC with LTO complains of
> @@ -288,6 +292,85 @@ static bool test_exclusive(const struct test_suite *=
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

Returning non-zero here will terminate the nftw, would it make more
sense to always return 0 say as many files are cleaned up as possible?

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
> @@ -627,9 +710,12 @@ static int __cmd_test(struct test_suite **suites, in=
t argc, const char *argv[],
>          * runs the exclusive tests sequentially. In other modes all test=
s are
>          * run in pass 1.
>          */
> +
>         for (int pass =3D 1; pass <=3D 2; pass++) {
>                 int child_test_num =3D 0;
>                 int curr_suite =3D 0;
> +               char *tmpdir[num_logged_suites * runs_per_test];

Could we avoid a VLA with a calloc here? It is test code so I'd prefer
correctness over performance.

> +               unsigned int logged_suites =3D 0;
>
>                 for (struct test_suite **t =3D suites; *t; t++, curr_suit=
e++) {
>                         int curr_test_case;
> @@ -663,6 +749,18 @@ static int __cmd_test(struct test_suite **suites, in=
t argc, const char *argv[],
>                         }
>
>                         for (unsigned int run =3D 0; run < runs_per_test;=
 run++) {
> +                               /* Setup temporary log directories for sh=
ell test suites */
> +                               if (create_logs(*t, pass)) {
> +                                       tmpdir[logged_suites] =3D setup_s=
hell_logs((*t)->desc);
> +                                       /* Couldn't create log dir, skip =
test suite */
> +                                       if (tmpdir[logged_suites] =3D=3D =
NULL) {
> +                                               ((struct shell_test_info =
*)((*t)->priv))->has_setup
> +                                                       =3D FAILED_SETUP;
> +                                       } else {
> +                                               logged_suites++;
> +                                       }
> +                               }
> +
>                                 test_suite__for_each_test_case(*t, curr_t=
est_case) {
>                                         if (!suite_matched &&
>                                             !perf_test__matches(test_desc=
ription(*t, curr_test_case),
> @@ -681,6 +779,9 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>                         for (size_t x =3D 0; x < num_tests; x++)
>                                 finish_test(child_tests, x, num_tests, wi=
dth);
>                 }
> +
> +               for (size_t x =3D 0; x < logged_suites; x++)
> +                       cleanup_shell_logs(tmpdir[x]);

Perhaps it is worth commenting that leaving/leaking the logs in the
event of an error is deliberate?

Thanks,
Ian

>         }
>  err_out:
>         signal(SIGINT, SIG_DFL);
> @@ -750,6 +851,8 @@ static int perf_test__config(const char *var, const c=
har *value,
>         return 0;
>  }
>
> +
> +
>  static struct test_suite **build_suites(void)
>  {
>         /*
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index 3703ad7b3b75..c45b41b5bf07 100644
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
> @@ -438,6 +439,9 @@ static void append_suites_in_dir(int dir_fd,
>                         continue;
>                 }
>
> +               /* Store logs for testsuite is sub-directories */
> +               ((struct shell_test_info *)(test_suite->priv))->store_log=
s =3D true;
> +               num_logged_suites++;
>                 if (is_test_script(fd, SHELL_SETUP)) {  /* Check for setu=
p existence */
>                         char *desc =3D shell_test__description(fd, SHELL_=
SETUP);
>
> diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-sc=
ripts.h
> index 013031239883..1dd91f1444e3 100644
> --- a/tools/perf/tests/tests-scripts.h
> +++ b/tools/perf/tests/tests-scripts.h
> @@ -16,8 +16,11 @@ enum shell_setup {
>  struct shell_test_info {
>         const char *base_path;
>         enum shell_setup has_setup;
> +       bool store_logs;
>  };
>
>  struct test_suite **create_script_test_suites(void);
>
> +extern size_t num_logged_suites;
> +
>  #endif /* TESTS_SCRIPTS_H */
> --
> 2.52.0
>
