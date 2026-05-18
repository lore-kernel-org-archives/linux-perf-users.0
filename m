Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225381E25F9
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067241; cv=none; b=jH/SO3zVpU4e1bVbrbB+UlgCF9y0ZCifUXTEiRdPTt+UNdvnZ8OwIgoeTISUMDGHDn1BMLr73Q/5eA6Mzt8whMxAkDI+gIhBjd11A/5ZjYDYITleP+U8pgOJRHqVtCZa+NERocYSnHxsiYqwYvL+1+AOswrardEJ0sq0onqAZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067241; c=relaxed/simple;
	bh=HzMfMF9SKD/oNwVtUDR6NPZ7pgR27HH1M3jOezoOIOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mH13FAAS4bJo9eA7NJl7RM2TYJ9tnvyByXXiUiB9/+GNR+yH4o3Vge6UhK0s5eqhGhZ2XNqKhCbckP08YurZHyOLT9TcW4Ixw2RkwiA5oKcGvH+Da2frmnWQLxrLlQLeAFO0pZr1qW8Rb4Whik74K7Xdk4+98XwD5vvmL+EgNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M55eyPXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M55eyPXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA4DC2BCB0;
	Mon, 18 May 2026 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067241;
	bh=HzMfMF9SKD/oNwVtUDR6NPZ7pgR27HH1M3jOezoOIOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M55eyPXb/Rk9SA2UEJoLxOUzWLUJULAtxp1Q+SdfNXYevdGWbOVKLMPO+9+ecBUod
	 5z81LiVenyKCRethpRxKiliPfnKnBec8mPHnqt8XglSywdlMSFPxBCh/7swUnqt7vB
	 o8+0vgUFjguK+XMPZp7KCFBSugHBn9lnDKmpzb3KXqyO07hyGyy2RPkIyZcQcW3klc
	 0RCcgYRPuA3HhkkXHVdk+IM0y8MfMSrEty4Pw9Kx9FrHoGf8pZ3hmpPuETMRE2feVb
	 moFggqAIOLMoIQOnHXbtRm4oSAiGH8fF7kqsXPc+a3lQQXDPhl9eRLNlsZRO8BMdMp
	 Kz5fmTq1sAAmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf arch x86 tests: Add test for topdown event
 sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518003704.2434308-3-irogers@google.com>
References: <20260518003704.2434308-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 01:20:40 +0000
Message-Id: <20260518012040.DDA4DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The validation block for `expected_instructions_group_size =3D=
=3D 2` in `test_sort()` is structurally unreachable dead code.
- [Low] Passing `test_sort()` directly to `TEST_ASSERT_EQUAL` causes the te=
st function to execute twice upon failure.
--

commit 418562cab64daaf4f2d774b19e333bea0ea7f81a
Author: Ian Rogers <irogers@google.com>

perf arch x86 tests: Add test for topdown event sorting

This commit adds a test to verify that slots and topdown-retiring get
appropriately sorted with respect to instructions when specified together. =
It
also adds a related test to ensure the slots event is injected into the
appropriate group when not explicitly provided.

> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/te=
sts/topdown.c
> index 3ee4e5e71be3b..9e9dbea7998dc 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
[ ... ]
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (!evsel__is_group_leader(evsel))
> +			continue;
[ ... ]
> +		} else if (strstr(evsel__name(evsel), "instructions")) {
> +			CHECK_EQUAL(evsel->core.nr_members, expected_instructions_group_size,
> +				    "instructions group size");
> +			if (expected_instructions_group_size =3D=3D 2) {
> +				/*
> +				 * The instructions event leads a group with a
> +				 * topdown-retiring event, neither of which need
> +				 * reordering for perf metric event support.
> +				 */
> +				struct evsel *next =3D evsel__next(evsel);
> +
> +				CHECK_COND(strstr(evsel__name(next), "topdown-retiring") !=3D NULL,
> +					   "instructions second event is topdown-retiring");
> +			}

Is this validation block for expected_instructions_group_size =3D=3D 2 reac=
hable?

The loop explicitly skips events that are not group leaders at the top.
However, in the test cases passing 2 for expected_instructions_group_size,
the slots event is injected as the group leader for all three events.

Consequently, instructions becomes a subordinate group member and is skipped
by the loop entirely, which bypasses these test assertions.

[ ... ]
> +static int test__x86_topdown_sorting(struct test_suite *test __maybe_unu=
sed,
> +				     int subtest __maybe_unused)
> +{
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;
> +
> +	TEST_ASSERT_EQUAL("all events in a group",
> +			  test_sort("{instructions,topdown-retiring,slots}", 3, 2), TEST_OK);

Does passing test_sort() directly to TEST_ASSERT_EQUAL cause the test to
execute twice upon failure?

The TEST_ASSERT_EQUAL macro in tools/perf/tests/tests.h evaluates the
provided value a second time in its pr_debug statement if the assertion
fails.

Since test_sort() allocates an evlist, parses events, and prints internal
debug logs, evaluating it twice creates duplicate work and duplicate debug
output.

Should the return value of test_sort() be stored in a local variable before
being passed to the assertion macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518003704.2434=
308-1-irogers@google.com?part=3D2
