Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE630E828
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773842; cv=none; b=q9ceMELlJ8NEVMmzvBfS8ySqIDXhvI9nbK/ZFghXXJlLtdicD733wwyRn21zFwTxb1zc9+FOLzTfQi3BTZB0Aj/ETFSm/h2r4wafhL6Wepr5kDxQynt7Z/5Y0E+qRM26BVA7FlB2PvBurBWJQIx1dtvkZ9dFxDMyMaFHhTXdREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773842; c=relaxed/simple;
	bh=Uj5H/q4kq6fLaZRShIomXVzRksW6eUqyBjyGSCn1FdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4zSu3IgrVOZDk2HcpYtXvEqjvUN8nlIBgz057yNqgzLBskLGegVYMFYaElJnkOa8UHfAIhAJab8jBk+rHkVTLhrl3AmBMy95epZh4k9Oh3F0XkHzVtBAMUZAcZXAo23UbgFQyG6F9qqUI814qsoY+bfd0/t9tQyUTKmT9RXrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzEiKd7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzEiKd7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1529DC2BCB3;
	Thu, 14 May 2026 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778773841;
	bh=Uj5H/q4kq6fLaZRShIomXVzRksW6eUqyBjyGSCn1FdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gzEiKd7F4X2vJvdWITKT9ADdk8UJOVWdc55Gmw2OlaOuh62UXprVd8CC9maq/c5Lk
	 +QwC5MDPXhEodTKYReFSMlcbNlY17A7h1E0Kh5qD8VfsznvT3Ppam0liuUvQBF5DY0
	 XOsIOv+LaK0FCk9NIrZhkOu+aKcVHIrXDp3Ik8WA5TMleBTBOnNObi4q7pc1VSgwUn
	 xxpbP9HTY2vX4iGE/zYby0ZZMd/Lf/Ql6revUWBly4mImkE6pzIHGbnDgUvcdg7O9K
	 m9YaHMLrIqB+b6nOpDXc1uSdSsLanfJ5TLXmWWVj1an+R8sDkGF20rF+359l4HpKyq
	 fQDNZGGhpZfyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/14] perf test: Show snippet failure output for
 verbose=1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-8-irogers@google.com>
References: <20260513230450.529380-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 15:50:40 +0000
Message-Id: <20260514155041.1529DC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unbounded output and error context starvation in Pass 0
- [Low] Undefined behavior when passing uncasted signed char to `tolower()`
--

commit 957cea0e8173df2ef71d1dc7480195a00fb7a68a
Author: Ian Rogers <irogers@google.com>

perf test: Show snippet failure output for verbose=3D1

This commit implements a bounded snippet processor for test failure outputs
when running in verbose mode. It aims to extract important keywords like
'error', 'fail', or 'segv' to isolate the root cause, rather than dumping
the entire raw output buffer.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index ad1b941731ca1..45c1afb9ad333 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -394,6 +396,210 @@ static int print_test_result(struct test_suite *t, =
int curr_suite, int curr_test
[ ... ]
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

Could this trigger undefined behavior? The output stream might contain
arbitrary binary data or non-ASCII UTF-8 bytes.

Since the argument to tolower() must be representable as an unsigned char
or EOF, passing a negative value from a signed char can result in
undefined behavior.

Should s[i] be cast to an unsigned char here?

> +					break;
> +			}
[ ... ]
> +static void print_test_failure_snippet(FILE *fp, const char *buf)
> +{
[ ... ]
> +	/* Pass 0: Unconditionally pick marker lines */
> +	for (i =3D 0; i < num_lines; i++) {
> +		if (line_contains(lines[i], line_lens[i], "----")) {
> +			pick[i] =3D true;
> +			if (picked_count < failure_snippet_lines)
> +				picked_count++;
> +		}
> +	}

Does this bypass the failure_snippet_lines limit if a test outputs many
marker lines? Since pick[i] is set to true unconditionally, a test with
hundreds of marker lines might cause an unbounded terminal dump.

Additionally, if there are enough marker lines, picked_count will fully
consume the quota before Pass 1 executes. As a result, Pass 1 will be
skipped entirely:

> +
> +	/* Pass 1: Pick lines with failure keywords from start */
> +	for (i =3D 0; i < num_lines && picked_count < failure_snippet_lines; i+=
+) {

Is it possible this starves the quota and prevents actual failure context
from being picked up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D7
