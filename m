Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98851126F3B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140988; cv=none; b=FcE05TOoW6OWL2gzrr2kN0hjalbYerj/KrhSg1p/S5fs8+m/w7lg0UG+CsIRCYLsE+dOVraPXfngmQ61TYLhV8SM71aHCfQl7S1VvHvhgjdjHJvnkWn9/Fv/I1/h7xtKgCZPgkjLRo9mDKwovtBcfMN8btsa88G52mgjUW56NIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140988; c=relaxed/simple;
	bh=BPCIzSiYJTDnSg7+I0AAc04Oin0v8f78F60bC6LgiVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gdtUHCpwPPNG1KgSIoujGZ6D0n+ZP0xBic8VZ9utBpPlK19NU5QCjvGRpuJOCqfT4rliKgWQu3iNZRY7+lFDsB5huwZTU8tc3g9ERGkCruzC3pfLXQbY5We1q2MnkmU6gNSXg5qvrYR5g8DWPG/VPYHaf9RjgfDNflQEAhZCJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlVxm3Uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlVxm3Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6452AC2BCB0;
	Sat, 25 Apr 2026 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140988;
	bh=BPCIzSiYJTDnSg7+I0AAc04Oin0v8f78F60bC6LgiVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AlVxm3Uu09nsjuqrJQH+g6lgoEJNl/eqaPNerAsOv7ShNb2usLn1UEdOnuFy5wO39
	 3ZZfRuE6ZGH8BAJbzIv4ae8StL7BcL7W1a51fBkt03M29ukEJta8sBvzIorw3GW7Pe
	 4lr9jPbpAaZnTZ+DDr2PXf/vN+jwyxbxemLF4W30xlLiFfTKJYk/2aPUTClRyM7nw6
	 QAfItwppnbifDB6Xu4hqyMy8H0VzYWEm+ySLIcjg9qlvuA0k5ItypD+f4swPLwfP4O
	 LiD51E+te5yIvgfY80ZlU+vk4GNrQDUILG3BCICd+sqHUea3PBfPA/1xRqniT1YBg+
	 3PZEdtXouhWug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/59] perf evlist: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-11-irogers@google.com>
References: <20260425174858.3922152-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:16:27 +0000
Message-Id: <20260425181628.6452AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Python API bisectability breakage causing heap corruption upon evl=
ist destruction.
- [High] Python API bisectability breakage causing `BUG_ON` crashes and bro=
ken mutability for `evlist[i]`.
--

commit 1fe320874850c1396e51c8aec7499414d09675c4
Author: Ian Rogers <irogers@google.com>
Subject: perf evlist: Add reference count

This commit introduces a reference count to the evlist structure. It ensures
that evlists are properly managed with evlist__get() and evlist__put() call=
s,
changing the Python bindings to handle evlists dynamically instead of cloni=
ng
them.

> The combination is needed for the python code to operate correctly (not h=
it
> asserts in the evsel clone), but the changes are broken apart for the sake
> of smaller patches.

Does this break bisectability?

Although the commit message states that the python code breakage is fixed in
a later commit in the series, knowingly introducing a broken state in the
middle of a patch series violates strict kernel bisectability rules.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 1e6c99efff90..3f0758d5bd90 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1551,7 +1558,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlis=
t *pevlist,
>  				  PyObject *args,
>  				  PyObject *kwargs __maybe_unused)
>  {
> -	struct evlist *evlist =3D &pevlist->evlist;
> +	struct evlist *evlist =3D pevlist->evlist;
>  	PyObject *pevsel;
>  	struct evsel *evsel;

Can this cause heap corruption upon evlist destruction?

Looking at the full context of pyrf_evlist__add(), it appends an interior
pointer to the C evlist:

        Py_INCREF(pevsel);
        evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
        ...
        evlist__add(evlist, evsel);

When the newly allocated evlist is destroyed via the introduced evlist__put=
()
call, it invokes evlist__purge(), which calls evsel__delete() on all contai=
ned
events. This would trigger a native free() on the interior pointer=20
&pevsel->evsel from the Python-allocated object, leading to an abort in gli=
bc.

While the commit message notes this is fixed later in the series, it leaves
the tree broken at this specific commit.

[ ... ]
> @@ -1794,17 +1817,16 @@ static PyObject *pyrf_evlist__item(PyObject *obj,=
 Py_ssize_t i)
>  	struct pyrf_evlist *pevlist =3D (void *)obj;
>  	struct evsel *pos;
> =20
> -	if (i >=3D pevlist->evlist.core.nr_entries) {
> +	if (i >=3D pevlist->evlist->core.nr_entries) {
>  		PyErr_SetString(PyExc_IndexError, "Index out of range");
>  		return NULL;
>  	}
> =20
> -	evlist__for_each_entry(&pevlist->evlist, pos) {
> +	evlist__for_each_entry(pevlist->evlist, pos) {
>  		if (i-- =3D=3D 0)
>  			break;
>  	}
> -
> -	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
> +	return pyrf_evsel__from_evsel(pos);
>  }

Does this result in lost mutations and BUG_ON crashes during script executi=
on?

The new pyrf_evsel__from_evsel() call creates a shallow clone of the intern=
al
evsel via evsel__clone(). This means modifications made from Python, such as
evlist[0].sample_period =3D 100, will only affect the ephemeral clone and a=
re
silently lost for the actual event.

Additionally, evsel__clone() strictly asserts that the event is not open by
checking BUG_ON(orig->core.fd). If a Python script accesses an item after
calling evlist.open(), it will hit this assertion and crash the host proces=
s.

Again, while the commit message notes this is fixed later in the series,
it introduces bisectability breakage here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D10
