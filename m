Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E02356B8;
	Wed, 21 May 2025 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833655; cv=none; b=r+PLZ3oQ5Giscmv7GhTbePYO49JpU4cgzmYo1Y7G+DeShkLLqcDxe4F3Lz5KJa4SZyAsJjyBWAQN2Flgzkm5JColRZGX0gU1OsT8v8NC05NL3nQjcXv/Mtzqc3bC4j/DuCxoNFq47u7ZUmpqlo+LQF93mLQR94KsPyBxDA5DIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833655; c=relaxed/simple;
	bh=QV4yK2hdnVnPbG4+FrwDEmlzNcQ54yHXdjN0E1nJArg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBvWEjbzSD3ZlezFCjtqHeiKy47moaKeAKbMBydj4j4cfhD9F5VgQi2Ot1b5q9l8JTIcqr0e3/N6Cso9DdR5CReN14c7zcLTNIcyqc+bnv5uao1nRCJZ6ASZI/4d7WMGYV0Zys1UfHlPdGFPWWbpn3jVcu+OQex5TYNpW03hFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz1xdeY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz1xdeY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24134C4CEE4;
	Wed, 21 May 2025 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747833653;
	bh=QV4yK2hdnVnPbG4+FrwDEmlzNcQ54yHXdjN0E1nJArg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz1xdeY/QPHCQbpqW9YLMXj3bxMFPssdJH0C0K4GT/BUMmGTR93G0dgcis8DMBozs
	 YP/b8B2bWkXH60z94+TQqwmsGm8EGUJWwqHuZAkdGKzGvKAyjteKhGt6wRYNV8FO1e
	 D9jHd2m+QL7iRIVq5PlMru57TVJOvDsQWpaWxpfJsN1DOMBImxx1XNCjWyDCJZW7ZC
	 qXtl8M49PS/HmPEyyZa+ak/8H+1qaASVYLxEAcvWa2SuSxP3hdX6RuCgCtz/JlU0cs
	 qePwY7H6A8GENPHxze8c1fs3U32wvtz+q79I1SiiV7eXXKYtTdbgXg6CQQr0uIZt83
	 S8G/9xtNsJtPQ==
Date: Wed, 21 May 2025 10:20:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 4/7] perf python: Add support for perf_counts_values
 to return counter data
Message-ID: <aC3TMl2MJL1_BASE@x1>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519195148.1708988-5-irogers@google.com>

On Mon, May 19, 2025 at 12:51:41PM -0700, Ian Rogers wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> Add support for perf_counts_values struct to enable the python
> bindings to read and return the counter data.

This (and another one in this series) are coming from Ian, that didn't
modify them, so we need a Signed-off-by: Ian, as per:

Documentation/process/submitting-patches.rst

---
Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author.
---

I'm adding them to my local branch, please ack this,

Thanks,

- Arnaldo
 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  tools/perf/util/python.c | 92 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index ead3afd2d996..1cbddfe77c7c 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -626,6 +626,92 @@ static int pyrf_thread_map__setup_types(void)
>  	return PyType_Ready(&pyrf_thread_map__type);
>  }
>  
> +struct pyrf_counts_values {
> +	PyObject_HEAD
> +
> +	struct perf_counts_values values;
> +};
> +
> +static const char pyrf_counts_values__doc[] = PyDoc_STR("perf counts values object.");
> +
> +static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values)
> +{
> +	Py_TYPE(pcounts_values)->tp_free((PyObject *)pcounts_values);
> +}
> +
> +#define counts_values_member_def(member, ptype, help) \
> +	{ #member, ptype, \
> +	  offsetof(struct pyrf_counts_values, values.member), \
> +	  0, help }
> +
> +static PyMemberDef pyrf_counts_values_members[] = {
> +	counts_values_member_def(val, Py_T_ULONG, "Value of event"),
> +	counts_values_member_def(ena, Py_T_ULONG, "Time for which enabled"),
> +	counts_values_member_def(run, Py_T_ULONG, "Time for which running"),
> +	counts_values_member_def(id, Py_T_ULONG, "Unique ID for an event"),
> +	counts_values_member_def(lost, Py_T_ULONG, "Num of lost samples"),
> +	{NULL}
> +};
> +
> +static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_values *self, void *closure)
> +{
> +	PyObject *vals = PyList_New(5);
> +
> +	if (!vals)
> +		return NULL;
> +	for (int i = 0; i < 5; i++)
> +		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));
> +
> +	return vals;
> +}
> +
> +static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObject *list,
> +					 void *closure)
> +{
> +	Py_ssize_t size;
> +	PyObject *item = NULL;
> +
> +	if (!PyList_Check(list)) {
> +		PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
> +		return -1;
> +	}
> +
> +	size = PyList_Size(list);
> +	for (Py_ssize_t i = 0; i < size; i++) {
> +		item = PyList_GetItem(list, i);
> +		if (!PyLong_Check(item)) {
> +			PyErr_SetString(PyExc_TypeError, "List members should be numbers");
> +			return -1;
> +		}
> +		self->values.values[i] = PyLong_AsLong(item);
> +	}
> +
> +	return 0;
> +}
> +
> +static PyGetSetDef pyrf_counts_values_getset[] = {
> +	{"values", (getter)pyrf_counts_values_get_values, (setter)pyrf_counts_values_set_values,
> +		"Name field", NULL},
> +	{NULL}
> +};
> +
> +static PyTypeObject pyrf_counts_values__type = {
> +	PyVarObject_HEAD_INIT(NULL, 0)
> +	.tp_name	= "perf.counts_values",
> +	.tp_basicsize	= sizeof(struct pyrf_counts_values),
> +	.tp_dealloc	= (destructor)pyrf_counts_values__delete,
> +	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
> +	.tp_doc		= pyrf_counts_values__doc,
> +	.tp_members	= pyrf_counts_values_members,
> +	.tp_getset	= pyrf_counts_values_getset,
> +};
> +
> +static int pyrf_counts_values__setup_types(void)
> +{
> +	pyrf_counts_values__type.tp_new = PyType_GenericNew;
> +	return PyType_Ready(&pyrf_counts_values__type);
> +}
> +
>  struct pyrf_evsel {
>  	PyObject_HEAD
>  
> @@ -1475,7 +1561,8 @@ PyMODINIT_FUNC PyInit_perf(void)
>  	    pyrf_evlist__setup_types() < 0 ||
>  	    pyrf_evsel__setup_types() < 0 ||
>  	    pyrf_thread_map__setup_types() < 0 ||
> -	    pyrf_cpu_map__setup_types() < 0)
> +	    pyrf_cpu_map__setup_types() < 0 ||
> +	    pyrf_counts_values__setup_types() < 0)
>  		return module;
>  
>  	/* The page_size is placed in util object. */
> @@ -1520,6 +1607,9 @@ PyMODINIT_FUNC PyInit_perf(void)
>  	Py_INCREF(&pyrf_cpu_map__type);
>  	PyModule_AddObject(module, "cpu_map", (PyObject*)&pyrf_cpu_map__type);
>  
> +	Py_INCREF(&pyrf_counts_values__type);
> +	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
> +
>  	dict = PyModule_GetDict(module);
>  	if (dict == NULL)
>  		goto error;
> -- 
> 2.49.0.1101.gccaa498523-goog
