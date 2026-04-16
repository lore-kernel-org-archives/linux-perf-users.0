Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA832C8B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364251; cv=none; b=C7z64WlBkoF9XJ2TDm2u3sb3fiFj1xxJlmPwCqtTfgM4dK4NZ1tEr3xqoVDw9RBcAtspoIDve61uapXKSaIZM35BStJDUTe+6X6wPRi2bHVEXG0gXiI1e2X7fFwy8pg/fPcSt0UPdl9MK+ymUC6QSe0R4w2en0/0xYpr39kgurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364251; c=relaxed/simple;
	bh=vonVHiOX1IAm8kJPd6glOwar216lMXSpcSv6+v+REoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHOaVdVkAGzTAlnUlBWSyuaZgNIbFt8yjJaDtwMs/QzUxb3cX0BE2WI9VZjRyK2ZfohYs1YvXOMftVEv1KmgjSOz3GJSnRGIURr9PLaJ66KLbjnsuQUAKAnyYCKMt3GIVjKzYYMud2BUkwGJ+zcQgj3sgp2WgK3y8KLIvWUV9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulXslhCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulXslhCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5B7C2BCAF;
	Thu, 16 Apr 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364251;
	bh=vonVHiOX1IAm8kJPd6glOwar216lMXSpcSv6+v+REoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ulXslhCv3U81HUYlF/xoxlSfQYQ2ge1BD+bkO2Qd/xT6c0DtwvI1cYsrWgqnn6wdR
	 dJwmM0SWwsD/mZePm2az/Xk3RngE8Sb5TDX5kcLrjQXdU6Dw1AMVE8UfvYR/veiait
	 /v85A6nrvde9Uz5XanvIjZSKdKL6RIlOA3sPhU5krYADtIBbuzY5cvFk+ijQBYwfcj
	 omOV1XPvXnkfhKGRYchE5JI4KXppRLwCBVgb/mZD0yZ9HG/FxJk8qRves1kEH2wIKs
	 ZKLdI6pwvBWpHMW0X2L5zn3h0KVIAZDcPIviuc+6tIBCAki3NE8FRiy3qFkYNWYUd8
	 z8x3QDVWt/gEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] perf test: Introduce storing logs for shell
 tests
Reply-To: sashiko@lists.linux.dev
To: "Jakub Brnak" <jbrnak@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416111419.385010-5-jbrnak@redhat.com>
References: <20260416111419.385010-5-jbrnak@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:30:50 +0000
Message-Id: <20260416183050.DE5B7C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] Returning 1 from the `nftw` callback to enforce a depth limit inco=
rrectly aborts the entire directory traversal, resulting in permanent tempo=
rary file leaks.
- [High] The directory filtering logic in `delete_file` fails to protect th=
e contents of unknown directories and causes parent directories to be leake=
d.
- [High] The size calculation for the log directory array `tmpdir` is vulne=
rable to integer overflow on 32-bit systems, leading to a heap buffer overf=
low.
- [Medium] The `PERFSUITE_RUN_DIR` environment variable is leaked to subseq=
uent test suites that do not request logs.
- [Medium] Test suites are executed even when log directory creation fails,=
 causing them to use a stale environment.
- [Medium] Using unsanitized test suite descriptions in the `mkdtemp` templ=
ate causes predictable directory creation failures or shell variable escapi=
ng issues.
--

commit d3121febf07f1014f3c0ec5faf10998a2927559e
Author: Jakub Brnak <jbrnak@redhat.com>

perf test: Introduce storing logs for shell tests

Create temporary directories for storing log files for shell tests
that could help while debugging. If the variable PERFTEST_KEEP_LOGS
is set keep the logs, else delete them.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 76fc37b440be4..306ecfe5e22ff 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -288,6 +292,91 @@ static bool test_exclusive(const struct test_suite *=
t, int test_case)
>  	return t->test_cases[test_case].exclusive;
>  }
> =20
> +static int delete_file(const char *fpath, const struct stat *sb __maybe_=
unused,
> +		       int typeflag, struct FTW *ftwbuf)
> +{
> +	/* Stop traversal if going too deep */
> +	if (ftwbuf->level > 5) {
> +		pr_err("Tree traversal reached level %d, stopping.", ftwbuf->level);
> +		return 1;
> +	}

Does returning 1 from the nftw callback incorrectly abort the entire
directory traversal? Per POSIX specifications, returning a non-zero
value stops nftw completely. This could abandon all remaining unvisited
files and directories within the test's log directory and potentially
lead to /tmp exhaustion.

> +
> +	/* Remove only expected directories */
> +	if (typeflag =3D=3D FTW_D || typeflag =3D=3D FTW_DP) {
> +		const char *dirname =3D fpath + ftwbuf->base;
> +
> +		if (strcmp(dirname, "logs") && strcmp(dirname, "examples") &&
> +		    strcmp(dirname, "header_tar") && strncmp(dirname, "perf_", 5)) {
> +			pr_err("Unknown directory %s", dirname);
> +			return 0;
> +		}
> +	}
> +
> +	/* Attempt to remove the file, continue on failure */
> +	if (remove(fpath))
> +		pr_err("Failed to remove file: %s", fpath);
> +
> +	return 0;
> +}

Because nftw is called with FTW_DEPTH (post-order traversal), files inside
the directory are visited first. For regular files (FTW_F), this directory
name check is bypassed, and remove() unconditionally deletes them.

Are all files within the protected directory deleted before the directory
itself is evaluated?=20

Also, because the now-empty unknown directory is not deleted, would the
parent directory's subsequent remove() fail with ENOTEMPTY, leaking the
directory structure?

[ ... ]

> +static char *setup_shell_logs(const char *name)
> +{
> +	char template[PATH_MAX];
> +	char *temp_dir;
> +
> +	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) >=3D=
 PATH_MAX) {
> +		pr_err("Failed to create log dir template");
> +		return NULL; /* Skip the testsuite */
> +	}
> +
> +	temp_dir =3D mkdtemp(template);

Can the test suite description string contain slashes or spaces? Slashes
would cause mkdtemp to fail with ENOENT because intermediate directories do
not exist. Spaces could cause issues when the unquoted PERFSUITE_RUN_DIR
is used in shell scripts.

I see this issue is addressed later in the series in commit
deaef0503b790e27361344881ded63d280631c12.

> +	if (temp_dir) {
> +		setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
> +		return strdup(temp_dir);
> +	}
> +
> +	pr_err("Failed to create the temporary directory");
> +
> +	return NULL; /* Skip the testsuite */
> +}
> +
> +static void cleanup_shell_logs(char *dirname)
> +{
> +	char *keep_logs =3D getenv("PERFTEST_KEEP_LOGS");
> +
> +	/* Check if logs should be kept or do cleanup */
> +	if (dirname) {
> +		if (!keep_logs || strcmp(keep_logs, "y") !=3D 0)
> +			nftw(dirname, delete_file, 8, FTW_DEPTH | FTW_PHYS);
> +		free(dirname);
> +	}
> +
> +	unsetenv("PERFSUITE_RUN_DIR");
> +}

Is the PERFSUITE_RUN_DIR environment variable leaked to subsequent test
suites that do not request logs? The unsetenv() is only called during
cleanup_shell_logs(). If a test does not request logs, could it inherit
the value pointing to the previous test's directory?

[ ... ]

> @@ -627,9 +716,19 @@ static int __cmd_test(struct test_suite **suites, in=
t argc, const char *argv[],
>  	 * runs the exclusive tests sequentially. In other modes all tests are
>  	 * run in pass 1.
>  	 */
> +
>  	for (int pass =3D 1; pass <=3D 2; pass++) {
>  		int child_test_num =3D 0;
>  		int curr_suite =3D 0;
> +		size_t tmpdir_sz =3D num_logged_suites * runs_per_test;
> +		char **tmpdir =3D tmpdir_sz ? calloc(tmpdir_sz, sizeof(*tmpdir)) : NUL=
L;

Is there an integer overflow risk on 32-bit systems here? The runs_per_test
variable is controlled via a command-line argument. Providing a large value
could cause the multiplication to wrap around, resulting in calloc allocati=
ng
a small buffer, which may lead to an out-of-bounds heap write during the
loop.

[ ... ]

>  			for (unsigned int run =3D 0; run < runs_per_test; run++) {
> +				/* Setup temporary log directories for shell test suites */
> +				if (create_logs(*t, pass)) {
> +					struct shell_test_info *info =3D (*t)->priv;
> +
> +					tmpdir[logged_suites] =3D setup_shell_logs((*t)->desc);
> +					/* Couldn't create log dir, skip test suite */
> +					if (tmpdir[logged_suites] =3D=3D NULL) {
> +						if (info->has_setup !=3D NO_SETUP)
> +							info->has_setup =3D FAILED_SETUP;
> +					} else {
> +						logged_suites++;
> +						if (info->has_setup =3D=3D PASSED_SETUP ||
> +						    info->has_setup =3D=3D FAILED_SETUP)
> +							info->has_setup =3D RUN_SETUP;
> +					}
> +				}
> +
>  				test_suite__for_each_test_case(*t, curr_test_case) {

The comment says to skip the test suite, but there is no continue statement
here. Are the test cases still executed without the intended logging setup
if setup_shell_logs() returns NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416111419.3850=
10-1-jbrnak@redhat.com?part=3D4
