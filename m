Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635430CDB6
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489227; cv=none; b=shfBN+6L9gbwXiH9CXb5e9oqifXhjn4YCAABjrEO4SdeTnt2LAs7qTWzN0xsTilQYKprS5Zm45XK4LfOBnnRN1xawcdBhngb83Rsu5ACieBs+LOjSJNR2imkt1Uv++KnsSbNiDy4evGGE1EOEswz+cnkwvHqCXO5PjwLnWtMmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489227; c=relaxed/simple;
	bh=0OwWLQpKXA9U/LDFGGQcf7CgJ/yAVsHaT0Q9KLHXPoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CqN1mclsbvy7uih0QbYLA6z3tG1tDJWJp61HfQ+ZmkJhukWncZBwg0oLpe+SeT7bQIHlLfX9+7UK89ItRgAg/HEZjE2MxAtGBcKvt9UmpfvLfu71d2zB/4vyW28Vyjr3uI0WJcJ1htYldGt5LcBSVNkZuz7kHIrwr3qGYXAPAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkSaw9tI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkSaw9tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C0A1F000E9;
	Fri, 22 May 2026 22:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489226;
	bh=FDd8Wf+WLWjyCvcKwIyiETiJU5TCgmKa4wYVLN/MgME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkSaw9tIwXSx8+ZKbwxqwBL94WzMrwt6tfWWiYeKXB6kPTJxYh3Od9VOKUt1V9ccj
	 X4BMVl9nmncEhX1vnnLhFcgvfMx3uXUHCXmCTyhgcLURlmZwDsKU9i7Sh58/DsTdB/
	 fXQiXYRkTiBdC2XmXb1EjqWpE055rLMU/+orErqo4m/WxkWug4T9uzg1Snn+kChIQy
	 TqcZkwHhg1z9Tg4WCv3gjv3WYdGLtwLryFa6Q3qI8xVKB34MSZAbJi98vRBNRSE1RB
	 OcEQ7hFRQPTe+hGfWMMY3TLcY5fWyITxBTDOAl8kAdwnH5AeXl/fMkcMhHqQ0ABOl1
	 F9JkK8bL9m96A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 19/23] perf python: Expose brstack in sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-20-irogers@google.com>
References: <20260522220435.2378363-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:33:45 +0000
Message-Id: <20260522223346.32C0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] An unbreakable circular reference between `pyrf_event` and `pyrf_b=
ranch_stack` causes a memory leak for every event containing a branch stack.
- [Medium] Returning a valid object while a Python exception is set trigger=
s a fatal `SystemError` in the interpreter.
--

commit c44b624d7ee17549d2a93cdf268bc3540d223c20
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event

This commit implements pyrf_branch_entry and pyrf_branch_stack objects in t=
he
perf python extension. This allows lazy iteration over branch stack entries=
 in
a sample event.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 4ee3fdbf35de4..218d772346e2b 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -1361,6 +1516,27 @@ static PyObject *pyrf_event__new(const union perf_=
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

[Severity: Medium]
If PyObject_New() fails to allocate memory for pstack, it returns NULL and
sets a Python MemoryError exception. Because the code falls through and
returns pevent below, does returning a valid object while an exception is
set trigger a fatal SystemError in the Python interpreter?

To handle OOM without crashing the interpreter, it seems the code needs to
either propagate the error by returning NULL, or clear the exception using
PyErr_Clear() before returning pevent.

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

[Severity: High]
Does this create an unbreakable circular reference between pevent and pstac=
k?

pstack holds a reference to pevent via Py_INCREF(pevent), and pevent holds a
reference to pstack via pevent->brstack =3D (PyObject *)pstack. Since neith=
er
type uses the Python cyclic garbage collector (via Py_TPFLAGS_HAVE_GC and
tp_traverse), it appears this cycle cannot be broken by Python.

This could cause an indefinite memory leak of the event object, the branch
stack object, and the dynamically allocated pstack->entries array for every
event containing a branch stack.

> +			} else {
> +				Py_DECREF(pstack);
> +			}
> +		}
> +	}
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D19
