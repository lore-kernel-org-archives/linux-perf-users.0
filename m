Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA43859E2
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216302; cv=none; b=Kik09xW0lK8nwNwR+YAXoMEL6MQSMlK7j1rcOgK8pwHWwVGh+LYM7sMC6jOAjZRd4T9Rs0hzojZv6Q0wHy+bT3jOvkeLK/leIcIIlcrOCh//O+3QscOA7ymx7RT5L+8Bci6OjuOfuKW+SpF2e/71oRWK9PweqicHqC6vS/ioqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216302; c=relaxed/simple;
	bh=6EbBRp0oyuWGQ5LRF4KT1TgtSlwi8yhENPHexlPGKWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QNkwT340ovXna1H1xY83XZiqA3d1u2xTeZnLZbRu1B61hQYAhSZdnu4Tr8BK0//aXz2ecpwMM2CdQJlSqoSi6hdP9AX5Kk42dYNrtn63/nETcDT3RhfbL9193wFiSSh8pSGdvHYu0NilMdRcdismTMV8/a5Zah08CWpQWJKyCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag5W7Keo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag5W7Keo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3618A1F00893;
	Sun, 31 May 2026 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216300;
	bh=CSg6OQg1CaQh7fZKrZvhQjR+NIw7zYOv7wQxH6OTHUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ag5W7Keo/ywkx17Hm1LylxnVe3xYjFUAR2A7W4kMfd1MpkAOvSNTsXNkFH6yDSt1t
	 rwNP6USXrOVgBVRZS/hvxqBIolELYHWMIdMMxqcyV6mHP4dIYuqKcbniZEfYNEyKmx
	 c2zub8pCogXDb/28Yn6Ei+UNji5Z3xWCWhqFBFZNwmq1vJbK1t5xq/QgMQPHfSfFl4
	 6UTloco4geDTCjkjtrghZEJWgjtrpUrL5tQHqDHqEUwZDaAVT02PPI8+bz5p7V28QP
	 A82e7lJjfybzzNdwBCGiq8k1sfx8PVyvGHE6HsXrzZ8ONMuShZwK/98rqcYZAlQVeB
	 37i1EXKslASuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/15] perf test: Show snippet failure output for
 verbose=1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-9-irogers@google.com>
References: <20260531082235.940833-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:31:39 +0000
Message-Id: <20260531083140.3618A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The failure keyword highlighting algorithm exhibits O(N^2) time =
complexity when processing lines with repetitive matches.
--

commit 8bcbefa0f3bd8a885167c4cc981bc19a4d53f2ce
Author: Ian Rogers <irogers@google.com>

perf test: Show snippet failure output for verbose=3D1

This commit implements a smart snippet string processor to selectively
extract and highlight failure logs rather than dumping the full buffer
on test failures.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 9f71f11928c60..e00b0bffa67cf 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -398,6 +400,192 @@ static int print_test_result(struct test_suite *t, =
int curr_suite, int curr_test
>  	return 0;
>  }
> =20
> +static const char * const fail_keywords[] =3D {
> +	"error", "fail", "segv", "abort",
> +	"signal", "fatal", "panic", "corrupt", NULL
> +};
> +
> +static const char *find_next_keyword(const char *str, size_t max_len, si=
ze_t *kw_len)
> +{
> +	const char *best =3D NULL;
> +	size_t best_len =3D 0;
> +	int k;
> +
> +	for (k =3D 0; fail_keywords[k]; k++) {
> +		const char *s =3D str;
> +		size_t len =3D strlen(fail_keywords[k]);
> +
> +		while ((size_t)(s - str) + len <=3D max_len) {
> +			size_t i;
> +
> +			for (i =3D 0; i < len; i++) {
> +				if (tolower(s[i]) !=3D fail_keywords[k][i])
> +					break;
> +			}
> +			if (i =3D=3D len) {
> +				if (!best || s < best) {
> +					best =3D s;
> +					best_len =3D len;
> +				}
> +				break;
> +			}
> +			s++;
> +		}
> +	}

[Severity: Medium]
Does this inner loop continue scanning the entire remainder of the string up
to max_len for every keyword, even if an earlier match was already found by
a previous keyword?

Since the search isn't bounded by the earliest match already found (the best
variable), missing keywords will cause a full scan of the remaining string.

If print_line_highlighted() processes a long string containing many
occurrences of one keyword (such as repeating "error error error...") witho=
ut
newlines, could this lead to quadratic time complexity as the string shrinks
and missing keywords trigger repeated full scans?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D8
