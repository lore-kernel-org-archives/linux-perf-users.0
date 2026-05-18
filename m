Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D555800
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779062727; cv=none; b=U4dweG1TSnyyzYsDYwqxDhZ/DW2Sw3LkguLCnA9KwcrVr3Beonbdwgv5jAbp3/9rqlnNW3L+ReZkZ1y4/Zypub3ZE0Gd+lKJHRQVDpPeqB3DuroBxlFZbntIv3UlqUVu72nTVms7MduCP6yu5DRSrIi5n0095IqZPgYfDWC7UtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779062727; c=relaxed/simple;
	bh=nplP+OuwQ4yOrm97uIs1O49yuOTooFByJLsBP0TwMHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tCPBn7neZv7UU8fFLcDp3/NKmCX6gUFU62FB88HHyjT8aRfXccDEDUUpZY88Y28uQyqMfY4x/zxLsb9CKR/ANV/IR9nTEKevByN8+QmLRxX4g8Wbx9gZgqiWYZW6cNUw3WT2tUuew4n3W/PiQNqVVfp1g0kzlpr6XxvHuRdevK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw9OZuE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw9OZuE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123B2C2BCB0;
	Mon, 18 May 2026 00:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779062727;
	bh=nplP+OuwQ4yOrm97uIs1O49yuOTooFByJLsBP0TwMHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pw9OZuE3fTPW/KCeqHnnm6wFdG1qK/rH2xvrLlE36VfUw4oNQYKL3NIu/QVAfllBL
	 99umZxHazBcB9B0tWO0rbu05r+f/Q4nr/qPhEt6KEmT1PSfIdXJk35n6CkmDMKX9co
	 QgayTAGKkE+irNk6axPc4fR21c9vp6jH89pWfaLXmiNfllTwa6bvW30elWwK/WqWG0
	 KRTw83WhMJNA30RGiwbQl7tlW9mEZ8L3TSyNY3aaMYuZ80BDG8mYGZY+MN4jiOaWRJ
	 GHTHrY4DhjYAEhymX7OhTu0VGV8t4r6KEoosjuh0+9wBtSRAi5k01tqgdd6bcksOxY
	 67KKGhME4kZPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] perf arch x86 tests: Add test for topdown event
 sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260517232849.2391357-3-irogers@google.com>
References: <20260517232849.2391357-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 00:05:26 +0000
Message-Id: <20260518000527.123B2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory leak in test_sort() on test assertion failure.
- [Medium] Dead code and completely ignored parameters in test_sort() due t=
o a logical contradiction in test design.
--

commit 412c12ca56b31a24a283d86a447c891e7731f0d0
Author: Ian Rogers <irogers@google.com>

perf arch x86 tests: Add test for topdown event sorting

This commit adds a test to verify that slots and topdown-retiring events
are correctly sorted with respect to instructions. It checks that metric
events are placed after slots, which should be the group leader when
required by the PMU. It also verifies that the slots event is appropriately
injected into groups when not specified.

> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/te=
sts/topdown.c
> index 3ee4e5e71be3b..ee8d673a0e7b1 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
[ ... ]
> +		if (strstr(evsel__name(evsel), "slots")) {
> +			/*
> +			 * Slots as a leader means the PMU is for a perf metric
> +			 * group as the slots event isn't present when not.
> +			 */
> +			slots_seen =3D true;
> +			TEST_ASSERT_EQUAL("slots group size", evsel->core.nr_members,
> +					expected_slots_group_size);

Do the TEST_ASSERT_EQUAL and TEST_ASSERT_VAL macros leak evlist and err
if an assertion fails?

These macros execute a direct return TEST_FAIL when a condition is not met.

This would immediately abort the function, bypassing the out_err cleanup
block and leaking both the evlist structure and dynamically allocated
error strings.

[ ... ]
> +		} else if (strstr(evsel__name(evsel), "instructions")) {
> +			TEST_ASSERT_EQUAL("instructions group size", evsel->core.nr_members,
> +					  expected_instructions_group_size);
> +			if (expected_instructions_group_size =3D=3D 2) {
> +				/*
> +				 * The instructions event leads a group with a
> +				 * topdown-retiring event, neither of which need
> +				 * reordering for perf metric event support.
> +				 */
> +				struct evsel *next =3D evsel__next(evsel);
> +
> +				TEST_ASSERT_VAL("instructions second event is topdown-retiring",
> +						strstr(evsel__name(next), "topdown-retiring")
> +						!=3D NULL);
> +			}

Is this expected_instructions_group_size check unreachable dead code?

Both parent test functions (test__x86_topdown_sorting and
test__x86_topdown_slots_injection) exit unconditionally with TEST_OK if
topdown_sys_has_perf_metrics() is false.

Because the test only executes on systems that enforce "slots" as a group
leader, "slots" is always injected or reordered to lead the group.

The evlist iteration loop explicitly skips non-leaders via:

    if (!evsel__is_group_leader(evsel))
        continue;

Consequently, "instructions" is never evaluated as the leader of a group
containing "topdown-retiring", making this block unreachable.

Furthermore, tests pass 2 for expected_instructions_group_size in cases
like "{instructions,topdown-retiring,slots}", which contains 3 events.
If "instructions" were actually evaluated as the leader, the assertion
would incorrectly fail.=20

The test passes because this parameter is ignored. Does this indicate a
logical contradiction in the test's design?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517232849.2391=
357-1-irogers@google.com?part=3D2
