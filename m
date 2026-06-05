Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598C419316
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688058; cv=none; b=sxW2mpfGaodwHbVpMEwxbKGSchq1FZ3NbA170pdOoDYa4OAxtq/5q4AfiW9Z82Uy0njfH0TgotBJR5gT6Azi2Q/sCCVarEPN3TNlAAOVGTN5l4oPHvuzFokc1mA9Vckvnno1kL0or2Tma5ywKvYjBn09FdLa8QlhF/LYyIRSlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688058; c=relaxed/simple;
	bh=dY0OhTMltvJNj4LOu0FpmtX3WOUuWbQA+eAjNGNkIEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFFv53pnXUR2qFDIejrjB51MdLW9CzRt9DYVMMIY5EUOgIs/5GICXsUqFvePR+tQLTCBgko5KJgZLPPPBCafzin1gyAmc83pp75LcMeeR4NEAgaek1IjR+p4VXszopp6zAyD/K1CdP4ANL92fCPnzd7DwZq17PftVUX2I1WwoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv9G2DbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv9G2DbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3F71F00893;
	Fri,  5 Jun 2026 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688057;
	bh=81pJ0ZfHbB/rgrpMIvoumbTmJ3qj6Uul3v08B58ya6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tv9G2DbF9ulLQhzY9mPcJ3zyBvAMLzKYu2JCt+8uf6xfesUEg6otmydElSZVlXSzn
	 BXaxgJ1hYZnb2rewaJuBZF04h8CT4VzHRep5SJzlS/YVeALQYTgn+e6btUFI/yBmYy
	 uWQ3fvzGpwGJynemhHBpfHSXWEdjbRy8KefJ0rGWLCkoi5BmZ0VcYKBEeAVlgVX8dn
	 ICjXkqAsASIgu4FEoIxzCfZyJDTECk+GAzr/nfNfMrPEW2HSbIvNty/ECTIjW5nBor
	 hX8T09QkLeCvnl+DHqnduD52DJnZ2msvcYH6ikFcsVXqr8aiNV3szdhUOC0/hnJmyy
	 NhgLGILx3dO9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/19] perf python: Expose brstack in sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-16-irogers@google.com>
References: <20260605191500.2477026-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:34:16 +0000
Message-Id: <20260605193417.1B3F71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap out-of-bounds read and information leak due to truncated perf=
 event copy.
--

commit 62a7a108ea094d1b9fdf0011865d427da46d2e31
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event

Implement pyrf_branch_entry and pyrf_branch_stack for lazy
iteration over branch stack entries.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 96694360c9787..eabc71c1f9a2c 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -1328,6 +1493,27 @@ static PyObject *pyrf_event__new(const union perf_=
event *event, struct evsel *ev
>  			addr_location__exit(&al);
>  		}
>  	}
> +	if (sample->branch_stack) {
> +		struct branch_stack *bs =3D sample->branch_stack;
> +		struct branch_entry *entries =3D perf_sample__branch_entries(sample);
> +		struct pyrf_branch_stack *pstack;
> +
> +		pstack =3D PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__=
type);
> +		if (!pstack) {
> +			Py_DECREF(pevent);
> +			return NULL;
> +		}
> +		pstack->nr =3D bs->nr;
> +		pstack->entries =3D calloc(bs->nr, sizeof(struct branch_entry));
> +		if (!pstack->entries) {
> +			Py_DECREF(pstack);
> +			Py_DECREF(pevent);
> +			return PyErr_NoMemory();
> +		}
> +		memcpy(pstack->entries, entries,
> +		       bs->nr * sizeof(struct branch_entry));

[Severity: High]
This is a pre-existing issue, but does this out-of-bounds read pose a risk =
of
an information leak or crash?

Earlier in pyrf_event__new(), the copy size of the event is clamped to
sizeof(pevent->event), but the event header size is not adjusted:

	if (copy_size > sizeof(pevent->event))
		copy_size =3D sizeof(pevent->event);

	memcpy(&pevent->event, event, copy_size);

Then, evsel__parse_sample() parses this truncated buffer using the original
larger header size. If the branch stack was beyond the clamped limit in the
original event, the sample->branch_stack pointer ends up pointing to memory
past the end of the pevent allocation.

Consequently, reading bs->nr and blindly copying that amount of adjacent he=
ap
memory into the Python object can expose arbitrary heap contents to the Pyt=
hon
script or cause a crash.

> +		pevent->brstack =3D (PyObject *)pstack;
> +	}
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D15
