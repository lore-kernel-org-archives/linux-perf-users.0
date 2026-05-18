Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AD1DB356
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066378; cv=none; b=XhaK2jxYUMlRUNOKH5jwXOJsaSZ3MbjKJ3kzg4+4du+Ov9KeuCj3BPK0WEX/CRygoIGL3QX+Z2ZoP667BKxA5249TOgwVExYKOL4bKIGofum1uJPyYEnXGd8dtnOpq/VgpVoCeMI2quhH9hfZk7cOed3Vl1dmRj7QqJCRtThtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066378; c=relaxed/simple;
	bh=mc1UccgGcdPIWqIKU7+dZUZ+Iv9ppVrUU4wAKgnFNCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s+gY6S6c/wn/ohP4QsV69Q0vDkm9FEUZOsjWxPJIo6BngMylpIn/RHJRw3q8iK2m+NGdye5p5tVRUMLLmOaiDAxmJgEqdMK/Vz0FSPL/LVijrr0MuatGVw+vCqmZ6OM5dcSc9uhuNgP3JimHAwxKSY7P4Hl9SNoMrqkDZbRQCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr+95KLr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr+95KLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B61C2BCB0;
	Mon, 18 May 2026 01:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779066378;
	bh=mc1UccgGcdPIWqIKU7+dZUZ+Iv9ppVrUU4wAKgnFNCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vr+95KLrLhGBkqG0OFwyKclmGVArLHPSVfTLhcGrIwQcQZcF1RAIaES6hFaEt6omp
	 +djLFDNVbyEfFAbuhRdID5MvS+W10vHowgPgrZ6H9k8WiNIQbI2KdB6IqDEjttGviZ
	 pLWpSZiXm+rETTGLYcwaEBeGN2Rp9RASPWK3r+nRPQY4O2vpqR7w7xoofFIY8uxHYi
	 PiZyJQhrMLeqUXP/FlCqO8aZU8RRRisF6PFO0E6rl5ImRhiJ+RYlFq1b4tK8OsMISU
	 dAjzXlNP+sRRQ4XY8FZpCoI0fT0QowT5dhLrd/PHuCezimSLCeC+/m2x5XFmHaj4g0
	 bn4I+jLvdn10A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf tests: Add test for uncore event sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518003704.2434308-2-irogers@google.com>
References: <20260518003704.2434308-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 01:06:17 +0000
Message-Id: <20260518010618.18B61C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of dynamically allocated strings on error and skip p=
aths.
--

commit df52a005ba8bea64e813a32dded17fb34900d4b6
Author: Ian Rogers <irogers@google.com>

perf tests: Add test for uncore event sorting

Add a test for uncore event sorting matching multiple PMUs to ensure evsels
are resorted properly when parsed with mixed PMUs.

> diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/u=
ncore-event-sorting.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/tests/uncore-event-sorting.c

[ ... ]

> +	while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {

[ ... ]

> +		m.event1 =3D m.event2 =3D NULL;
> +		perf_pmu__for_each_event(pmu, false, &m, event_cb);
> +
> +		if (m.event1 && m.event2) {
> +			pmu_prefix =3D strndup(pmu->name, len);
> +			break;
> +		}
> +		free(m.event1);
> +	}
> +
> +	if (!pmu_prefix) {
> +		pr_debug("No suitable uncore PMU found\n");
> +		return TEST_SKIP;
> +	}

Does this early return bypass cleanup and leak m.event1 and m.event2?

If strndup() fails to allocate memory during the loop, pmu_prefix remains
NULL. The loop breaks, and this check returns TEST_SKIP immediately without
freeing the strings allocated during the perf_pmu__for_each_event() callbac=
ks.

> +
> +	evlist =3D evlist__new();
> +	if (!evlist)
> +		return TEST_FAIL;

Does returning directly here leak pmu_prefix, m.event1, and m.event2?

If this is updated to use the out_err cleanup path instead, will it
dereference uninitialized stack memory?

Calling goto out_err; here would jump to parse_events_error__exit(&err)
before parse_events_error__init(&err) has had a chance to initialize it.

> +
> +	snprintf(buf, sizeof(buf), "{%s/%s/,%s/%s/}", pmu_prefix, m.event1, pmu=
_prefix, m.event2);
> +	pr_debug("Parsing: %s\n", buf);
> +
> +	parse_events_error__init(&err);

[ ... ]

> +out_err:
> +	evlist__delete(evlist);
> +	parse_events_error__exit(&err);
> +	free(pmu_prefix);
> +	free(m.event1);
> +	free(m.event2);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518003704.2434=
308-1-irogers@google.com?part=3D1
