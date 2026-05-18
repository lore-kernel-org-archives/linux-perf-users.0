Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5218DB37
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072788; cv=none; b=uPfjDNXc6QVCF1qWx0xwj/JNsUCaD3N+tjKBeTe5VefFk/KkDMq27CnpZLR7NCAiMND+cJJMW9eI+CnkoZ3JCH9+FTqM6k6FPt8RShyqDVcBhYWxOpjA1gBvZy3OZrRElMPtwV9UuqZiGHYev6aKuSzpMHvmFWavCgp/yhp6/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072788; c=relaxed/simple;
	bh=GOmP96ThMyhiZgfWdRo0ZU6j0rv+1uB560Vov5EHSYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=az3zJEuMTqZdSsWZLA5amkzL45VT+eezgMo3o1Xnj9w/sUd46aXjDufWck+V6tyN7fGbQM9OUEq7VfDWfJkdGk2ara4tcIBx5pVUONuAHh7zS3HN7oLtzcynsogVHhfDoE4xkSbeC03KFF5qpeJIvrem9zrlFF34npZC1TIKZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAl0ssku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAl0ssku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0B8C2BCB0;
	Mon, 18 May 2026 02:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779072787;
	bh=GOmP96ThMyhiZgfWdRo0ZU6j0rv+1uB560Vov5EHSYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mAl0sskuCIr7dYe81vWWGiyiDsNA17jxYqZNFZaZukv7vdjwvEvRH9rpHMVbDmMDd
	 p2RwNvur1GhIdRD/UBXAC/GuX8MHJ6caHAzLr1fR7flys/odUMvYA1x7CPWnd9bCGI
	 9pojZT6hxbVl3d9popGb2aBD2RCfcEdubd/sGDgkTe6xf4l3AaUkJBzQ1bFVogyxSz
	 U1mcBbD3JrELWTfibNFxgA6Rbjuo0Q/yfFIoQ0+zfCh8ji+cqVQmOL0d6Ez9dob91Z
	 vtt1JVpzOiKNrgoS5BknjUJVWfyOOToAH8C0QTd05QPfKrshK0OXNlTbp8xXe2g4wt
	 A45nGrhQ7GiYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf tests: Add test for uncore event sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518023225.2472122-2-irogers@google.com>
References: <20260518023225.2472122-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 02:53:07 +0000
Message-Id: <20260518025307.8A0B8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double free of `m.event1` when scanning uncore PMUs.
--

commit 5412f65ccaa1b5aa1cce690a35fcf6de242d9132
Author: Ian Rogers <irogers@google.com>

perf tests: Add test for uncore event sorting

This commit adds a test for uncore event sorting that matches multiple PMUs.
It ensures that event groups are correctly resorted when initial parsing
results in mixed PMUs due to common prefixes.

> diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/u=
ncore-event-sorting.c
> new file mode 100644
> index 0000000000000..88bda7a89a057
> --- /dev/null
> +++ b/tools/perf/tests/uncore-event-sorting.c
[ ... ]
> +static int test__uncore_event_sorting(struct test_suite *test __maybe_un=
used,
> +				      int subtest __maybe_unused)
> +{
> +	struct evlist *evlist =3D NULL;
> +	struct parse_events_error err;
> +	struct evsel *evsel;
> +	struct perf_pmu *pmu =3D NULL;
> +	char *pmu_prefix =3D NULL;
> +	struct match_state m =3D { NULL, NULL };
> +	char buf[1024];
> +	int ret;
> +
> +	parse_events_error__init(&err);
> +
> +	while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> +		size_t len;
> +		struct perf_pmu *sibling;
> +
> +		if (pmu->is_core)
> +			continue;
> +
> +		len =3D pmu_name_len_no_suffix(pmu->name);
> +		if (len =3D=3D strlen(pmu->name))
> +			continue;
> +
> +		sibling =3D pmu;
> +		while ((sibling =3D perf_pmus__scan(sibling)) !=3D NULL) {
> +			if (sibling->is_core)
> +				continue;
> +			if (pmu_name_len_no_suffix(sibling->name) =3D=3D len &&
> +			    !strncmp(pmu->name, sibling->name, len))
> +				break;
> +		}
> +
> +		if (!sibling)
> +			continue;
> +
> +		m.event1 =3D m.event2 =3D NULL;
> +		perf_pmu__for_each_event(pmu, false, &m, event_cb);
> +
> +		if (m.event1 && m.event2) {
> +			pmu_prefix =3D strndup(pmu->name, len);
> +			break;
> +		}
> +		free(m.event1);
> +	}

Could this lead to a double free of m.event1?

If perf_pmu__for_each_event() allocates m.event1 but not m.event2, the code
falls through the condition and frees m.event1 without setting it back to N=
ULL.

If the loop subsequently terminates, or if the next iteration triggers an e=
arly
continue before m.event1 is reset to NULL, the function will eventually
proceed to the out_err label.

[ ... ]
> +out_err:
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	free(pmu_prefix);
> +	free(m.event1);

When it reaches this point, will it call free(m.event1) again on the dangli=
ng
pointer?

> +	free(m.event2);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518023225.2472=
122-1-irogers@google.com?part=3D1
