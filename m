Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1604BEE2C
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183214; cv=none; b=IhtCnXI9CfwU244kenx9iYUFho2sF8hXwiYJtiYa0IDDG+AhgNAZfNdd8/B9heVoPkZ61SutHaq2Syj/OvmyXNyNA0a4OcQb+WDRIoFYLmXjRAIjw5C2P4gcXyg4j6stB4C9U6b82/sxLwpPTmy0YUreOCjGuOAu8MbDEmnjXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183214; c=relaxed/simple;
	bh=lmWrh7LpNslrTT5GkWy6/i3YkBeRW4u+PLG5d/gjFrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4gn2wlsepDs/DqdnGLYspntPgnwRUK0OTZ7Zo6vzzzITJ5BkezkIK9Pun8yRyIl7Usr7usnQterAeJ3aR905A08Vd+tbQHhhFvISLbp6QJbMR6OwGPU70yMGSNv8U7AtvfmlPFdTu5iLX+/I7Ux2yPh8K2QSrOC31eRJC99Knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haXEjjIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haXEjjIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7241F000FF;
	Sat, 12 Sep 2026 03:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183213;
	bh=G3xmTeKmaWSqi/tfIklW0962DRhrf3suQXV2FUjPmIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haXEjjIX/3MeLKu2hj9erJTwArEbJ/U9cXHrcI4C9yOjWbxbmcJogt3OmYao81ag4
	 f5N0jVyJn3HkA4BonKaAANA9c29Lub6FX6EPqUoIT3h/RkLIaM0DKtAv1zbKayY5I4
	 nBXbr1Tk50XXev4A8rKC+Z31NpYbDCoF1kpnMIETpJKkJ90kmlKX9tCR02yW+KVSwJ
	 5jJaxahb7vHUkNfMqlvkKh9VIjXHvws04X1FwqV8WRcty7VBey4upvWtF4y3CuJyXB
	 iX6mypyhmGvkjgVBC6cBtRH/LMphNs3jJwHiD+3hzA8NVY8YbeFa3CA9ftrX3+f8ri
	 sL14XfFFCZPUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf thread_map: Deduplicate numerically equivalent PID
 and TID strings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912031112.1814574-2-sh_def@163.com>
References: <20260912031112.1814574-2-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:20:12 +0000
Message-Id: <20260912032013.2E7241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of <stdio.h> for snprintf.
--

commit b1526ce24c053489c0a3385a95c4492a0906a746
Author: Hui Su <sh_def@163.com>

perf thread_map: Deduplicate numerically equivalent PID and TID strings

This commit replaces the ineffective prev_pid and prev_tid checks with an
intlist seen-set to correctly deduplicate numerically equivalent PID and TID
strings. It also adds new test cases to verify this behavior.

> diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
> index 877868107455e..0299c8fd0a6a9 100644
> --- a/tools/perf/tests/thread-map.c
> +++ b/tools/perf/tests/thread-map.c
> @@ -56,6 +56,39 @@ static int test__thread_map(struct test_suite *test __=
maybe_unused, int subtest

[ ... ]

> +	/* test numeric deduplication of PIDs */
> +	{
> +		struct perf_thread_map *base, *dup;
> +		char pid_str[64];
> +
> +		base =3D thread_map__new_by_pid(getpid());
> +		TEST_ASSERT_VAL("failed to alloc baseline map", base);
> +
> +		snprintf(pid_str, sizeof(pid_str), "%d,0%d", getpid(), getpid());

[Severity: Low]
Does test__thread_map() in tools/perf/tests/thread-map.c need an explicit
include of <stdio.h> for snprintf?

The global review guidelines mandate explicit inclusion of POSIX standard
headers for all libc functions to ensure musl libc compatibility, preventing
reliance on implicit inclusion. Since this introduces a new call to snprint=
f,
strict libc implementations like musl may fail to compile without the direct
header inclusion.

> +
> +		dup =3D thread_map__new_str(pid_str, NULL, false);
> +		TEST_ASSERT_VAL("failed to alloc duplicate pid map", dup);
> +		TEST_ASSERT_VAL("wrong nr for duplicate PIDs",
> +				dup->nr =3D=3D base->nr);
> +
> +		perf_thread_map__put(dup);
> +		perf_thread_map__put(base);
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912031112.1814=
574-2-sh_def@163.com?part=3D1
