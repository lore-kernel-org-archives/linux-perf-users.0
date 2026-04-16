Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09712741A0
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339528; cv=none; b=p8NlqqtWGTTztIZqSOCq9sCxYIXMMAqHA02N9oQhZudnvKKmIzIFBv7cPX3f/nauUCTJEU3HEslynQHkHG2yzPYWmHdTU5lDW2dmXdm6K8ks5C8u7l/2ANfItG6iZF5BC+Ybl9CHVUSzwRu6KaEjT93+cyXwKhgpFOEmJogqd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339528; c=relaxed/simple;
	bh=hpvE3HNF0WMD5qs1EVy6f5M+GWu2NMi4gay9M/WvTxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A70G8HCT9ArkpZImHjsgjsmaUHnr0iiNYDOdEi2O8PpH/afF32qdc52gvR++rw2uZynLmKlh2w7ZUgPzgnjo6E2BepVpNNnahaURKxjdmlK5Q8HqbUqWSUxG2op5JPgh/aKFdZ8d9IekSdrQhHWigU53kYCzjDkXvYDTZTkOS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muVm1SAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muVm1SAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6FEC2BCAF;
	Thu, 16 Apr 2026 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776339528;
	bh=hpvE3HNF0WMD5qs1EVy6f5M+GWu2NMi4gay9M/WvTxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=muVm1SAQYAqJbKNDJv3rVEZXmYY0/0BSg4tW8Qz+rXOXI8U8GMOECfLlxKEJFSbqd
	 tTjaNwxu96X/WaFbOjsi0SV4e/7rD+2ryov+e3ZggB0EYEjFKKm4RKuQaJRyah1sOa
	 NUF+5M+felkurniEA19hfYWPNcMCAGryuHTUMmHEOtVq9VrkP8SZ5nglMeHt2OZRw0
	 zoqPV58l3Z/HZAC3PB7vQqD42E0re+KBkVffB0Opaxilp1oSVSxbbn/vVGrp/ai7Ka
	 hf+VlVZQdT86XmopJEcxzLMmE9pY+hCq0UYdRuWHSWs3p9BqxYObzYM9XP820bQ9+9
	 abErGZmJrXoXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] perf tests: Create a structure for shell tests
Reply-To: sashiko@lists.linux.dev
To: "Jakub Brnak" <jbrnak@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416111419.385010-2-jbrnak@redhat.com>
References: <20260416111419.385010-2-jbrnak@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 11:38:47 +0000
Message-Id: <20260416113848.5E6FEC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Stack buffer overflow when constructing file paths with readlink().
- [High] Unsanitized file paths are passed to system(), leading to test fai=
lures and arbitrary command execution.
- [Medium] Inconsistent symlink traversal in `is_directory_fd` can cause in=
finite recursion.
--

commit 3485f6ce4f46698279bf2224bae7f656e8fcbc73
Author: Jakub Brnak <jbrnak@redhat.com>

perf tests: Create a structure for shell tests

This commit implements a new structure for shell test suites, grouping them
by subdirectories within perf/tests/shell instead of placing them all into a
single list.

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8f..680dfe650f146 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -151,14 +200,64 @@ static char *strdup_check(const char *str)
>  	return newstr;
>  }
> =20
> -static int shell_test__run(struct test_suite *test, int subtest __maybe_=
unused)
> +/* Check if dirent entry is a directory using file descriptor, handling =
DT_UNKNOWN case */
> +static bool is_directory_fd(int dir_fd, struct dirent *ent)
>  {
> -	const char *file =3D test->priv;
> +	struct stat st;
> +
> +	if (ent->d_type =3D=3D DT_DIR)
> +		return true;
> +
> +	if (ent->d_type !=3D DT_UNKNOWN)
> +		return false;
> +
> +	/* Need to stat the file to determine if it's a directory */
> +	if (fstatat(dir_fd, ent->d_name, &st, 0) !=3D 0)
> +		return false;

Could this cause inconsistent symlink traversal depending on the filesystem?
If the filesystem returns DT_UNKNOWN, fstatat() without the AT_SYMLINK_NOFO=
LLOW
flag will follow symlinks and report them as directories. This differs from=
 the
fast path which correctly skips symlinks because their d_type is DT_LNK.
Could this lead to infinite recursion if a symlink loops back to a parent
directory?

> +
> +	return S_ISDIR(st.st_mode);
> +}

[ ... ]

> +static int shell_test__run(struct test_suite *test, int subtest)
> +{
> +	const char *file;
>  	int err;
>  	char *cmd =3D NULL;
> =20
> +	/* Get absolute file path */
> +	if (subtest >=3D 0)
> +		file =3D test->test_cases[subtest].name;
> +	else	/* Single test case */
> +		file =3D test->test_cases[0].name;
> +
>  	if (asprintf(&cmd, "%s%s", file, verbose ? " -v" : "") < 0)
>  		return TEST_FAIL;
> +
>  	err =3D system(cmd);

Since file contains the absolute path to the test script, what happens if t=
he
kernel source tree is located in a directory path containing spaces or shell
metacharacters? Will system() fail to execute the path properly?

[ ... ]

> @@ -167,65 +266,117 @@ static int shell_test__run(struct test_suite *test=
, int subtest __maybe_unused)
>  	return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
>  }
> =20
> -static void append_script(int dir_fd, const char *name, char *desc,
> -			  struct test_suite ***result,
> -			  size_t *result_sz)
> +static struct test_suite *prepare_test_suite(int dir_fd)
>  {
> -	char filename[PATH_MAX], link[128];
> -	struct test_suite *test_suite, **result_tmp;
> -	struct test_case *tests;
> +	char dirpath[PATH_MAX], link[128];
>  	ssize_t len;
> -	char *exclusive;
> +	struct test_suite *test_suite =3D NULL;
> +	struct shell_test_info *test_info;
> =20
> +	/* Get dir absolute path */
>  	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> -	len =3D readlink(link, filename, sizeof(filename));
> +	len =3D readlink(link, dirpath, sizeof(dirpath));
>  	if (len < 0) {
>  		pr_err("Failed to readlink %s", link);
> -		return;
> +		return NULL;
>  	}
> -	filename[len++] =3D '/';
> -	strcpy(&filename[len], name);
> +	dirpath[len++] =3D '/';
> +	dirpath[len] =3D '\0';

If readlink() fills the entire dirpath array, returning a length of PATH_MA=
X,
won't these assignments write out of bounds and corrupt the stack?

[ ... ]

> +static void append_script_to_suite(int dir_fd, const char *name, char *d=
esc,
> +					struct test_suite *test_suite, size_t *tc_count)
> +{
> +	char file_name[PATH_MAX], link[128];
> +	struct test_case *tests;
> +	ssize_t len;
> +	char *exclusive;

[ ... ]

> +	/* Get path to the test script */
> +	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> +	len =3D readlink(link, file_name, sizeof(file_name));
> +	if (len < 0) {
> +		pr_err("Failed to readlink %s", link);
> +		free(desc);
> +		return;
> +	}
> +	file_name[len++] =3D '/';
> +	strcpy(&file_name[len], name);

Similarly here, if readlink() returns PATH_MAX, file_name[len++] will write=
 past
the end of the array. Also, won't strcpy() overflow the buffer if there isn=
't
enough space left in file_name to hold the script name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416111419.3850=
10-1-jbrnak@redhat.com?part=3D1
