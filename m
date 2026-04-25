Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D830BF6F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158783; cv=none; b=kX8/eBfrmziVaD8VavBTerI7kTBUmDd5X8/skuMP9M0CVEZ4zuDdh61liY3G50uLPcZZq+eWZIl/VEGaFz2Aen2M5NUHzWVDn2nN6iXvxs0QEmCyF2BoXbZhIy06SaWkTRWoEejdUywQhbiAQJ0qae0W2sB8UtJnSuLKH8IsBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158783; c=relaxed/simple;
	bh=8zPxbqvnDt8r8nTAua2+MsItoA86POmXHfZ37Pblh6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/+RHogHcLNHIujjWZ0oboM0GzGFQVNS4Ka+qhE0wVCTOLZqoXDNzpaFrX8sU7HW0yfrhlqUCEY9rIK3Cn2Lm+vpYRUvjux25PfPhIC9M8O3DxB4cHeEwWKkQTqjgbFwxXLlWGJOXyZ2jzlyseLxFOIpBCSrdh6qvLvzgDpa1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH9f9WzN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH9f9WzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0623BC2BCB0;
	Sat, 25 Apr 2026 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158783;
	bh=8zPxbqvnDt8r8nTAua2+MsItoA86POmXHfZ37Pblh6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XH9f9WzNXUDjumH5JYrTx9iVKonoQ1Sjb9XDFKCg0yN2M9vGGfu3HKcnR3KmfUma1
	 RMKMaPfXQeSz4IvCW7tPZvDqzN3B2HGDqWqso8LyiwIi+i2rGOWbb1hsH1NkvboiBA
	 D8gp+2COAjHPii3rOpqsl37Uj//bSk5TWeM8bqQ5zooYeTCh0oF9r8cGLYwpiXdL9Z
	 X4GaoeXVi+iCj38pZfGt/KDBOEGc0VpLGL4YOQiZDJ/uujOdGBdsZdbSkBsC8LlcBf
	 NMzYMo2QwZ3kH497HDuFxv2u1YNv6WRKT5W+EEw053L3knYFcRdIKmjT2D5Pdqqj3y
	 nQuurmvab0stg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 21/59] perf python: Expose brstack in sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-22-irogers@google.com>
References: <20260425224951.174663-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:13:02 +0000
Message-Id: <20260425231303.0623BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unbreakable Python reference cycle causes a permanent memory leak =
for every event with a branch stack.
--

commit 258ce9fbe4f8832b7edea1df3b558bac40529cda
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event

This commit implements pyrf_branch_entry and pyrf_branch_stack to allow
iteration over branch stack entries in perf python scripts.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 17d0ee15336f..256129fef4f8 100644
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

[ ... ]

> @@ -1307,6 +1462,27 @@ static PyObject *pyrf_event__new(const union perf_=
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
> +		if (pstack) {
> +			Py_INCREF(pevent);
> +			pstack->pevent =3D pevent;

Does this create an unbreakable Python reference cycle that leaks memory?

The code assigns pstack to pevent->brstack below, and here it assigns pevent
to pstack->pevent while taking a reference via Py_INCREF. Because neither
pyrf_event nor pyrf_branch_stack implements Python's cyclic garbage
collection protocol, the reference counts will never drop to zero.

This means the event object, the pstack object, and the calloc'd
pstack->entries array will be leaked for every sample processed.

Unlike the callchain implementation which requires pevent for lazy resoluti=
on,
pyrf_branch_stack__next() iterates entirely over the pstack->entries array
that is eagerly populated via memcpy() below.

Since pstack->pevent appears to be unused during iteration, could we avoid
the memory leak by entirely removing the Py_INCREF(pevent) and
pstack->pevent back-reference?

> +			pstack->pos =3D 0;
> +			pstack->nr =3D bs->nr;
> +			pstack->entries =3D calloc(bs->nr, sizeof(struct branch_entry));
> +			if (pstack->entries) {
> +				memcpy(pstack->entries, entries,
> +				       bs->nr * sizeof(struct branch_entry));
> +				pevent->brstack =3D (PyObject *)pstack;
> +			} else {
> +				Py_DECREF(pstack);
> +			}
> +		}
> +	}
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D21
