Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CE199D8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645296; cv=none; b=VvVmzMAk/q+cmfgZV4NVS6htjE8LDWd5tDX05SpgL7+7ud8r3tpnkHIg3YM53L/X3g/JT1G1ep6Rx/9sM4b44z0Xys+/bb+RomurtMuf1ouJxZkQGdq7ZCP+aZF5Cw7TAzn1EYnEB9JzhTMWJtemH1G6r/H0oeEY7o1/GVSRWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645296; c=relaxed/simple;
	bh=RT45PMQgxXkYFzIlszYV4fT8nnLdPi087KGmUzPuMh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jWzNHFGSZIPbcFvv/m/+j5Xx4OBsLTih1VkXo24lheal6Q2b5y314jY4p0twkD83IJANOTk6QUNqiaMnobq4ExeWxQFh9o4DFh8U4KculuNYlp2HyYRIeouu0a809ku6wsl/eGmzXU8fSFAdrWhNqUiMaMpnT6GFEtFngRJznNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bppxLzxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bppxLzxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D62BC2BCAF;
	Mon, 20 Apr 2026 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645296;
	bh=RT45PMQgxXkYFzIlszYV4fT8nnLdPi087KGmUzPuMh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bppxLzxc1PngoiniwSig2TN0BKH9MtJRK7mrUgq3g/uvR9JnQVs74EiYf97O9Izlm
	 0spwMcJo1HJ1eMZVgE/uOPSyrppEogldeKiUVYIYBGjsRx525VOymr12OtTLAXyTHs
	 LV2WuvfV30V+627OEwFtzn1WWGzB0y/5N1PayjoQtZpQCD8tMdSQyg8sD1m6aMCnFT
	 03MxL2erYjWRQys43NY/9a/EZAR3xTCQhlL7zwqbld/rI4vFTutJVvO/9n3GOQCZoA
	 1Wo/9wGIldeJ0GDlZRn0XlBb8Sc+jOut6pKggdqAVFyElQ3qdf5OxUGDbH+jinhxtf
	 xyEpT+OzCHAAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 21/58] perf python: Expose brstack in sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-22-irogers@google.com>
References: <20260419235911.2186050-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:34:55 +0000
Message-Id: <20260420003456.6D62BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Use-after-free and out-of-bounds read when iterating `brstack` o=
utside the event callback.
- [Medium] API Usability conflict: `.from` property uses a reserved Python =
keyword.
- [Low] Memory leak on error path due to unchecked `PyModule_AddObject` ret=
urn value.
--

commit 4c70568ebec741e82b2012742116fe71939a72c2
Author: Ian Rogers <irogers@google.com>

perf python: Expose brstack in sample event

Implement pyrf_branch_entry and pyrf_branch_stack for lazy
iteration over branch stack entries.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 1e393f354ea0b..52970c78106f6 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -866,6 +867,150 @@ static PyObject *pyrf_sample_event__get_callchain(P=
yObject *self, void */*closur
[ ... ]
> +static PyGetSetDef pyrf_branch_entry__getset[] =3D {
> +	{ .name =3D "from",      .get =3D (getter)pyrf_branch_entry__get_from, =
},

Does exposing the branch origin as 'from' cause a SyntaxError in Python sin=
ce
it is a reserved keyword? This might force users to unidiomatically rely on
getattr(entry, 'from').

> +	{ .name =3D "to",        .get =3D (getter)pyrf_branch_entry__get_to, },
> +	{ .name =3D "mispred",   .get =3D (getter)pyrf_branch_entry__get_mispre=
d, },
[ ... ]
> +static PyObject *pyrf_branch_stack__next(struct pyrf_branch_stack *pstac=
k)
> +{
> +	struct pyrf_branch_entry *pentry;
> +	struct branch_stack *bs =3D pstack->pevent->sample.branch_stack;
> +	struct branch_entry *entries =3D perf_sample__branch_entries(&pstack->p=
event->sample);
> +
> +	if (!bs || !entries || pstack->pos >=3D bs->nr)
> +		return NULL;

Can this regression lead to reading freed memory if the stack is iterated
outside the event callback?

Since pevent->sample.branch_stack is a shallow copy pointing to the original
event buffer, if a Python script stores the event object and iterates it
lazily later, the original buffer might be overwritten or unmapped.

If the overwritten memory yields a large value for bs->nr, could this bypass
the loop bound and read out-of-bounds memory from the entries[] array?

[ ... ]
> @@ -3434,6 +3591,12 @@ PyMODINIT_FUNC PyInit_perf(void)
>  	Py_INCREF(&pyrf_session__type);
>  	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
> =20
> +	Py_INCREF(&pyrf_branch_entry__type);
> +	PyModule_AddObject(module, "branch_entry", (PyObject *)&pyrf_branch_ent=
ry__type);

Does this code leak the type object if PyModule_AddObject() fails?

According to the Python C-API, PyModule_AddObject() only steals the referen=
ce
on success. If it returns -1, the reference is not stolen.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D21
