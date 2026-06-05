Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984443C05A
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688289; cv=none; b=NmvW/2/A3TB+uDVK5EkbXxJmmtHlzXxI3llxY+hKJF7jtVVS4sFGiJAirE7clS3pVB3zfgqXa81uf72SwiW6eowMFHj4Ms5cIdW4MlppbLBGzFXUQV+cMD4iFivlXZMI231BRuuA1KhW8PtM3NfLK+5DC3IpW0Ut6Ik0HWupKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688289; c=relaxed/simple;
	bh=YZ5J+x54FKY3magMdVHNHJwA/8NUNhcffIXi5RrF+2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iF9vTIAIm+TkLrgdcWXTvU8m8+EIAy24OWAwjWaEk1ngDKkEaiB+izvyRQMN5bfaFb8PROxNjllD52WzGnvs2btOZvNShNYrC1Ve8zLjB47m4hA4W3L8Pd5jTEQDzORA8hjQRTjbFKeqR2R+fOS3wq1rCWMKbKn35MlSHMMiNFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfNPi8Cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfNPi8Cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9561F00898;
	Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688277;
	bh=YpqrAdK3ojiCsmPkyboT8l+NiCI1RY0owws55TqARu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfNPi8CqL4BKYoNNtGGk9scrmmGoXQfLG/mwt6Q0Yg/lqEHIoeuVWx79SW1yrlvsR
	 FX8daJPY0t7Jk4ypKO7ZIzUlwnaBsyfjE/ZXyfBkk99Ad2wp4F33NjgbRQFYfdUlwo
	 iJS/9qdlPdFv+VJMtkm0EqVzYfI/1Xhp8g57gd9EBwJq4QmFKLsPb/vAEKKy/Fr5Jt
	 hK4wXQ4tfhuhd6V2042RKEyMoLq56IEnuvhnP5/iEBztz59afqsUS/LbeC0dLlQId0
	 qXJhy2i2WgXYL4mXSR2g9gEvnrva1m54P18YtVpb8Ep6kOp3SbVIZ/QWJ50Y25/OqM
	 mQYW5mb6gc1Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/19] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-7-irogers@google.com>
References: <20260605191500.2477026-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:37:57 +0000
Message-Id: <20260605193757.8A9561F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] API breakage: The `idx` keyword argument was removed from the `p=
erf.evsel` Python constructor.

Pre-existing issues:
- [High] Python `pevsel` objects are permanently leaked when added to a Pyt=
hon `evlist` due to an obsolete `Py_INCREF`.
- [High] Type confusion in multiple Python API functions due to unsafe obje=
ct casting, leading to segmentation faults.
--

commit 32152cc198f8b97a7c285972f68510722b3dec17
Author: Ian Rogers <irogers@google.com>
Subject: perf evsel: Add reference count

The commit adds a reference count to struct evsel to manage its lifecycle.
This is particularly useful for Python bindings, where instead of cloning t=
he
event, the same event is reused and its reference count is incremented.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 7483741c024a5..0778322311850 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1028,7 +1031,6 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevs=
el,
>  	    precise_ip =3D 0,
>  	    mmap_data =3D 0,
>  	    sample_id_all =3D 1;
> -	int idx =3D 0;
> =20
>  	if (!PyArg_ParseTupleAndKeywords(args, kwargs,
>  					 "|iKiKKiiiiiiiiiiiiiiiiiiiiiiKK", kwlist,
> @@ -1041,7 +1043,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevs=
el,
>  					 &enable_on_exec, &task, &watermark,
>  					 &precise_ip, &mmap_data, &sample_id_all,
>  					 &attr.wakeup_events, &attr.bp_type,
> -					 &attr.bp_addr, &attr.bp_len, &idx))
> +					 &attr.bp_addr, &attr.bp_len))
>  		return -1;

[Severity: Medium]
Since the idx parameter was removed from PyArg_ParseTupleAndKeywords, won't
existing Python scripts that pass idx (e.g., perf.evsel(..., idx=3D0)) now =
crash
with a TypeError for an invalid keyword argument?

[ ... ]

> @@ -1073,26 +1075,33 @@ static int pyrf_evsel__init(struct pyrf_evsel *pe=
vsel,
>  static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
>  				  PyObject *args, PyObject *kwargs)
>  {
> -	struct evsel *evsel =3D &pevsel->evsel;
> +	struct evsel *evsel =3D pevsel->evsel;
>  	struct perf_cpu_map *cpus =3D NULL;
>  	struct perf_thread_map *threads =3D NULL;
>  	PyObject *pcpus =3D NULL, *pthreads =3D NULL;
>  	int group =3D 0, inherit =3D 0;
>  	static char *kwlist[] =3D { "cpus", "threads", "group", "inherit", NULL=
 };
> =20
> +	CHECK_INITIALIZED(evsel, "evsel");
> +
>  	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist,
>  					 &pcpus, &pthreads, &group, &inherit))
>  		return NULL;

[Severity: High]
This is a pre-existing issue, but pyrf_evsel__open() uses "OO" format speci=
fiers
to parse the cpus and threads arguments, allowing arbitrary Python objects =
to be
passed in. Shortly after this code:

	if (pthreads !=3D NULL)
		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;

	if (pcpus !=3D NULL)
		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;

Could this blindly cast arbitrary Python objects to struct pyrf_thread_map =
and
struct pyrf_cpu_map, leading to out-of-bounds reads or segmentation faults =
if
incorrect object types are passed? Should we use the "O!" format specifier =
with
the appropriate type objects instead?

[ ... ]

> @@ -1584,13 +1808,13 @@ static PyObject *pyrf_evlist__add(struct pyrf_evl=
ist *pevlist,
>  	PyObject *pevsel;
>  	struct evsel *evsel;
> =20
> -	if (!PyArg_ParseTuple(args, "O", &pevsel))
> +	if (!PyArg_ParseTuple(args, "O!", &pyrf_evsel__type, &pevsel))
>  		return NULL;
> =20
>  	Py_INCREF(pevsel);
> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
>  	evsel->core.idx =3D evlist->core.nr_entries;
> -	evlist__add(evlist, evsel);
> +	evlist__add(evlist, evsel__get(evsel));
> =20
>  	return Py_BuildValue("i", evlist->core.nr_entries);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does keeping the explicit
Py_INCREF(pevsel) here cause a memory leak of the Python wrapper object?

Previously, this was needed because the C evlist held a raw pointer to the
evsel struct embedded within the Python object. Now that evsel is dynamical=
ly
allocated and the C evlist correctly acquires its own reference to the C st=
ruct
via evsel__get(evsel), the Python wrapper object reference is never decreme=
nted,
which seems to result in a permanent leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D6
