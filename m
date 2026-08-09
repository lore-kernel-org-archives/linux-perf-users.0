Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53F357D10
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260812; cv=none; b=durCJFTp+HzdCXLsp1FutYfiu9Uez4eBVzJ5EZP5fsxZqz65Sf1eRmr4Um4GGxtdGyk/PSyHOe28REc1pOZ2MA0sKBkmLgINPmIW5+w9m1FuEEeBM4iDbl97YZxfj5qWo7bFoKisrUjGCIqQm+serKcFkq1OODL56N7pxPsL4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260812; c=relaxed/simple;
	bh=MFk9zagsHXeGhSlz5k/N9tJP/1pjjvO82nl+in4fcbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqPPT73RhIzoectfizewaaJdhwwgSb4vi01QYUqjSu6e1XYCBUUl4+LgTnh4yW/u+PP/F8nY+pdUlwPPoyckVNLg8CDKZZyEdm3BWc86MF7ZAOQ4KQ63jG6kcaANb63pfyooSIP8YlYNAzqzDdXssdt6vxKdUk4kXN/M2eboduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uzhk2AYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uzhk2AYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403E61F000E9;
	Sun,  9 Aug 2026 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786260810;
	bh=BnMFPZ+DUCNdHUCEj/Z+RBvTtbwnx8rXbG3GoU3CKq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uzhk2AYOgT16bgMznQJpRQTyuErjlu+32s8+7TdGMU4mI7BefU3i/A0PqL9bnJ7hk
	 D1KSSD7Msn7yLyWXZH3WziQlXiqMxmobOq8QvRH5sO+2zPH6GZzpopYKiYcq5EbxJz
	 e4x4fETqfLvN+tTKfKG+V22v7Y41lwmG0cd1/FATJGq+TLCwf6AOXobcrltbi4icYm
	 4rhGDPYkQ1Q1DyJ6xppYBEjWMDIR5rZRYWsDspRm8uf4SLhbsyxg1jFsXDGevS+ZvN
	 wKDeVfR2qcOrwu0O7SPZI4NrJCFjbAIOsG/fpEilbZLqncWN1y+/vAinibVKwstv3l
	 MzpHIBu3zNwiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/15] perf python: Fix memory leak in
 pyrf_evlist__get_pollfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260809071455.1221514-5-irogers@google.com>
References: <20260624051535.3584977-1-irogers@google.com>
 <20260809071455.1221514-1-irogers@google.com>
 <20260809071455.1221514-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 07:33:29 +0000
Message-Id: <20260809073330.403E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing NULL che=
ck on the return value of `PyLong_FromLong` in `pyrf_counts_values_get_valu=
es` leads to a crash.
- [High] This problem wasn't introduced by this patch, but there is a memor=
y leak of `key` and `value` objects on the success path of `PyDict_SetItem`=
 in `pyrf__metrics_cb`.
--

--- Patch [4]: [PATCH v3 04/15] perf python: Fix memory leak in pyrf_evlist=
__get_pollfd ---
commit 4d7f49a1892b79c6131283be18ebf7cc1b0fd24f
Author: Ian Rogers <irogers@google.com>

perf python: Fix memory leak in pyrf_evlist__get_pollfd

This patch fixes a Python list object leak in pyrf_evlist__get_pollfd() by
adding a missing Py_DECREF on an error exit path. It also adds a check
for list allocation failure.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index af85c0771c448..c7ae1f85aec6d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2825,6 +2825,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyr=
f_evlist *pevlist,
> =20
>  	evlist =3D pevlist->evlist;
>  	list =3D PyList_New(0);
> +	if (!list)
> +		return NULL;
> =20
>  	for (i =3D 0; i < evlist__core(evlist)->pollfd.nr; ++i) {
>  		PyObject *file;
> @@ -2843,6 +2845,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyr=
f_evlist *pevlist,
> =20
>  	return list;
>  free_list:
> +	Py_XDECREF(list);
>  	return PyErr_NoMemory();
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential crash
here in pyrf_counts_values_get_values() when memory is exhausted:

tools/perf/util/python.c:pyrf_counts_values_get_values() {
	...
	PyObject *vals =3D PyList_New(5);

	if (!vals)
		return NULL;
	for (int i =3D 0; i < 5; i++)
		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));

	return vals;
}

Can PyLong_FromLong() return a null pointer during memory pressure?

If so, PyList_SetItem() will place the null pointer directly into the list's
internal array without validation.

Could this cause operations like PyObject_Repr to later dereference the
pointer and crash the Python interpreter abruptly instead of raising a
MemoryError?


[Severity: High]
This is a pre-existing issue, but there appears to be a memory leak in
pyrf__metrics_cb():

tools/perf/util/python.c:pyrf__metrics_cb() {
	...
	PyObject *key =3D dict ? PyUnicode_FromString("MetricGroup") : NULL;
	PyObject *value =3D key ? pyrf__metrics_groups(pm) : NULL;

	if (!value || PyDict_SetItem(dict, key, value) !=3D 0) {
		Py_XDECREF(key);
		Py_XDECREF(value);
		Py_XDECREF(dict);
		return -ENOMEM;
	}

	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
	...
}

Does the success path of PyDict_SetItem leak the key and value objects?

The error path correctly drops the references, but if PyDict_SetItem
succeeds, it does not steal the references.

Since this function is called as a callback in pmu_for_each_sys_metric(),
will this unconditionally leak both objects for every valid system metric
processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809071455.1221=
514-1-irogers@google.com?part=3D4
