Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB08F49
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917941; cv=none; b=DQ7jgM/hGfnhj9QbUamFW/dKIjE54kjqCCGxPeuRIg6JcFX2c41c9m0bUJdmePWiqO6QzniOihZCZeOpiDQTRxFHn89YYSpqEu9F5LaJggg+GDQJytSLLMGpM3dD2I1Ca8CbWCCj/cE6q+D5vZaTAoTKWB0r2HaHg46fbp1hgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917941; c=relaxed/simple;
	bh=FhgNHZWdFTsjEPqb8NVAwwS/4eUtkcrwUGgS+HwRv+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cD9mGDmKRbwpzXxDmHmFYBy0jvyhR1D5sxmO9Cu1ri0uAL7aqJW/ousFaYddWKuhQM2cmsf8c64R6mPa6Rh5mxb1RmrmV/l114e5vG4f3hVpGOGYspZPlfpBwY+qCAqwEiIEjnzI5aBOvOtgq9243U2KzutYmNCQO9ApI4Q8PiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF78K5D+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF78K5D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D03C2BCB2;
	Thu, 23 Apr 2026 04:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917941;
	bh=FhgNHZWdFTsjEPqb8NVAwwS/4eUtkcrwUGgS+HwRv+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LF78K5D+Hw5azYXoc7/uJLAbrjOf3v3B0e01jJqUHjZugZXj/lAqQa7av74nLP5H5
	 tPyFxrvnayBe4EiYokE6H1MBfFGeS4uNmdZtQc0dYCTxucZVGkM/E5EnZhO2YMuW/c
	 WPXmura0tiHxrvWXpjYSwehEz3jpfB4isHotA5P76l4Vz0oUxc6fcRrsh34vEsnZuz
	 08rAmvl9ggF6/Lz7CXdgxKIJLnYq4TfxRbicE9yqhsBu5JQP/Njo23EPV6aJu1QSon
	 jd5AvyPUTcb4Ih+bfvHpsvUNPW1G0pniVfoUjaVSt6wZ6BhuZiwjfDwGPjQZf6D7pw
	 2DP/jhrLfiVaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/58] perf python: Expose brstack in sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-22-irogers@google.com>
References: <20260423035526.1537178-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:19:00 +0000
Message-Id: <20260423041900.F2D03C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] A circular reference between `pyrf_event` and `pyrf_branch_stack` =
causes a permanent memory leak on every sample containing a branch stack.
- [Medium] The `brstack` property returns a single-use iterator instead of =
an iterable collection, leading to unexpected API behavior.
--

commit 7706b9a1f76a3982766c802596501351980d123a
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event

Implement pyrf_branch_entry and pyrf_branch_stack for lazy iteration
over branch stack entries.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b7f877189f8cf..5ace996267151 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +struct pyrf_branch_stack {
> +	PyObject_HEAD
> +	struct pyrf_event *pevent;
> +	struct branch_entry *entries;
> +	u64 nr;
> +	u64 pos;
> +};

[ ... ]

> +static PyObject *pyrf_branch_stack__next(struct pyrf_branch_stack *pstac=
k)
> +{
> +	struct pyrf_branch_entry *pentry;
> +
> +	if (pstack->pos >=3D pstack->nr)
> +		return NULL;
> +
> +	pentry =3D PyObject_New(struct pyrf_branch_entry, &pyrf_branch_entry__t=
ype);
> +	if (!pentry)
> +		return NULL;
> +
> +	pentry->from =3D pstack->entries[pstack->pos].from;
> +	pentry->to =3D pstack->entries[pstack->pos].to;
> +	pentry->flags =3D pstack->entries[pstack->pos].flags;
> +
> +	pstack->pos++;
> +	return (PyObject *)pentry;
> +}

Since the property returns the same object and advances pstack->pos during
iteration without resetting it, does this mean the iterator gets permanently
exhausted after one use?

Would it be better for the property to return a new iterator object or
implement sequence semantics?

[ ... ]

> @@ -3157,6 +3312,28 @@ static int pyrf_session_tool__sample(const struct =
perf_tool *tool,
>  		}
>  	}
> =20
> +	if (sample->branch_stack) {
> +		struct branch_stack *bs =3D sample->branch_stack;
> +		struct branch_entry *entries =3D perf_sample__branch_entries(sample);
> +		struct pyrf_branch_stack *pstack;
> +
> +		pstack =3D PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__=
type);
> +		if (pstack) {
> +			Py_INCREF(pevent);
> +			pstack->pevent =3D pevent;
> +			pstack->pos =3D 0;
> +			pstack->nr =3D bs->nr;
> +			pstack->entries =3D calloc(bs->nr, sizeof(struct branch_entry));
> +			if (pstack->entries) {
> +				memcpy(pstack->entries, entries,
> +				       bs->nr * sizeof(struct branch_entry));
> +				pevent->brstack =3D (PyObject *)pstack;

Does this create a strong reference cycle where pstack->pevent holds a
reference to pevent, and pevent->brstack holds a reference to pstack?

Since neither pyrf_event__type nor pyrf_branch_stack__type implements
Python's Py_TPFLAGS_HAVE_GC and tp_traverse or tp_clear protocols, can the
Python cyclic garbage collector detect or break this cycle?

When the Python user script discards the event, wouldn't pevent's reference
count remain at 1, preventing pyrf_event__delete from executing and
leaking pevent, pstack, and pstack->entries for every event containing a
branch stack?

Since pstack->entries eagerly deep-copies the branch stack data, is it
necessary for pstack to hold a reference to pevent to remain valid?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D21
