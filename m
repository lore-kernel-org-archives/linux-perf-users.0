Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDE3C141F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252530; cv=none; b=jBvhKqC+4227C1R+n2sblTDQqTp6c/CGJTX9yiOxPhrhYNkluz5vQa/CeCGRRmOWjydRXv9DM1XMhB3sQfLzo6mcxFGfv8P9fHo1UYlYaoBwa1I0MSflpG+Tpmxfg3NDYWuEqskvgyof5KFRVLiFTzPnmmVYz6I8L0Zl8o+T07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252530; c=relaxed/simple;
	bh=B2dn+A85RYBGXX/4imzy6MfpJIxfMnjXLWQ619u1rC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bORcLWN/s4O1VbQiJmQozw+yLnwvr1Sh7B7wvWSfONDff8VhZOT61XHjD9v5ABa+2+CzDLoBl4c+Q7E9cNyQp19qK5aE8NKOMVRtxX2k25JHrUoxySKo/0tCINhl+V3fAhQa9BoF3Zr9TjruMDbbEm8pUUyrkSYhInZnhI8vQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoVRVMaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoVRVMaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5291F000E9;
	Tue, 23 Jun 2026 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782252529;
	bh=fr/lQsSksSAObiPqmFTkmP6DfOv5FCgP12+O5kgQ22c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoVRVMaF1xarhx8BFVfvCln5/G2q2W3KKstrgmrUcZNkHxl6vHQICZdESsZIYD1d0
	 w58P9SJDsjw1nldv8w6yRyn5QH5mIsDAVZSZLQhOsBvLNPkPnzzk7goATAGZdu3xyc
	 /RyRBmafi2RoK6mVAPZrni9uJx4MlWvj4Ir10dSzj0yA4Cv9Q7Av8kRWbQcUu08dET
	 6KO2GpK9Ihyo1zgz0mtr8/pj2ygm0CSY9U7JhDKhlPWd3JqbSmemP7ypptjDAekaTS
	 eMBos+1XzKc9tvDZRKXOjC7/5sIQGYcjiooZ4YRgmsjwgi4fyWIQDSnUu/vLGGKNoG
	 o7U7VLtgWsklw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/13] perf python: Check counts_values size in
 set_values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-9-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:08:48 +0000
Message-Id: <20260623220849.4D5291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The Python bindings for `perf_counts_values` incorrectly use 32-bi=
t-limited C `long` functions and types for `uint64_t` data, leading to data=
 truncation on 32-bit platforms, incorrect negative values, and unhandled `=
OverflowError` exceptions causing fatal `SystemError` crashes.
- [High] Deleting the `.values` attribute from Python causes a segmentation=
 fault due to a NULL pointer dereference in the property setter.
--

commit a4cb87d6d79ff9be6c884154fa1d1f913fe545d5
Author: Ian Rogers <irogers@google.com>

perf python: Check counts_values size in set_values

The set_values function incorrectly assumed the list contained exactly
5 elements. Add a check to prevent out-of-bounds access.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 21e8b5a23a1c9..f9398bc30a80b 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1913,6 +1913,11 @@ static int pyrf_counts_values_set_values(struct py=
rf_counts_values *self, PyObje
>  	}

[Severity: High]
This is a pre-existing issue, but does this function cause a NULL pointer=20
dereference when the attribute is deleted?

Just above this context in pyrf_counts_values_set_values():

	if (!PyList_Check(list)) {
		PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
		return -1;
	}

If a user executes del obj.values from Python code, the Python C API calls=
=20
the property setter with list set to NULL. Passing a NULL list directly int=
o=20
PyList_Check(list) will dereference the object to check its type, which=20
causes an immediate segmentation fault.

> =20
>  	size =3D PyList_Size(list);
> +	if (size !=3D 5) {
> +		PyErr_SetString(PyExc_ValueError, "List must have exactly 5 entries");
> +		return -1;
> +	}
> +
>  	for (Py_ssize_t i =3D 0; i < size; i++) {
>  		item =3D PyList_GetItem(list, i);
>  		if (!PyLong_Check(item)) {

[Severity: High]
This is a pre-existing issue, but can this loop lead to data truncation or
crash the interpreter?

Just below this context in pyrf_counts_values_set_values():

		self->values.values[i] =3D PyLong_AsLong(item);
	}

Since self->values.values stores uint64_t data, assigning the result of
PyLong_AsLong (which returns a signed C long) can truncate data on 32-bit
platforms or produce incorrect negative values.

Additionally, if PyLong_AsLong raises an OverflowError for very large
integers, the error is silently ignored and 0 is returned to the interprete=
r,
which triggers a fatal SystemError crash.

The same underlying issue appears in other places where we expose uint64_t
data:

tools/perf/util/python.c:pyrf_counts_values_get_values()
	for (int i =3D 0; i < 5; i++)
		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));

tools/perf/util/python.c:pyrf_counts_values_members
	counts_values_member_def(val, T_ULONG, "Value of event"),

Should we be using 64-bit functions like PyLong_AsUnsignedLongLong() and
PyLong_FromUnsignedLongLong(), and ensuring exceptions are caught?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D8
