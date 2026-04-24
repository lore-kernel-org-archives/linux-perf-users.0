Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0F33D512
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051143; cv=none; b=fKtqwINnNwVWwbGw0E/Dj+3cJuIkbDGg2Y/2MfeuY01QbjA+XZ9rTGDK7nbT/6Ksf5rD4Q8m18DOPXoeF3rw4w+vk7nhAo7MpeBiuBKzDVsd74l8vqXKN9uZ/a+D5R6iA8GBLNHSa9Awj9dZLKQvQGpJrenfSh4hrw/SkygsiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051143; c=relaxed/simple;
	bh=hYROlWp1dIi0dbjI2GIDHKOD+n4ivR3eCb/nA+Z0hZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EsWu5UpbfxLAKd5ufVAAeI+RWrmPGP2YY6lx5gWAYuHCR7Epn4v05ZO2QPazEb/I5cGO49p1a6U5ZGDLyEZg9CaekPpYVx8eVSJMxrbKLs2Wr2s3K9n6MU8KL202cGwma5aVOYo1cJwJqtRm+QgOPnn8nFsbGEzW1jaKztuOYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knNO6Bqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knNO6Bqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47C8C19425;
	Fri, 24 Apr 2026 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051143;
	bh=hYROlWp1dIi0dbjI2GIDHKOD+n4ivR3eCb/nA+Z0hZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=knNO6Bqc5KY+OENeji+AV3zMjrtsLefm6VzqEATqx3zO3liMkIpA6aLZnNJEY5+26
	 31yG3URPPFxUAAkh50zdFdE2Y8SwLDrz09+1xG2NGwaFS5bnV2TnCHw1ECSTsFX2Yi
	 +IkkoT6V/CuVadquhJ03Set0WB/t5XdKVPN1+Eu0WhzUpw9R9LsDLtOsQ0Ntzpwf1I
	 xfWhDUzNKI7yG3CoTifW9Jz2BpxMYD7uQqoikHWyiMjW0qLnujU67I6emTCJH96gvZ
	 HErZDVuygins9a6nRjRac+aRX9sSa8ftB9efUnH5uGOGMHv7D50B+cI513Ng5rqUo+
	 gVUNqTB/Dh57w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/58] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-17-irogers@google.com>
References: <20260424164721.2229025-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:19:01 +0000
Message-Id: <20260424171902.E47C8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Linking the perf Python module fails with undefined references to `=
syscalltbl__name` and `syscalltbl__id` when built without libtraceevent.
--

commit bc598ef831f6053687cf5a98e1f88fb63ac39178
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

Use perf's syscalltbl support to convert syscall number to name assuming the
number is for the host machine. This avoids python libaudit support as
tools/perf/scripts/python/syscall-counts.py requires.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 35eda69a32e164..f240905e07d6c1 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2635,6 +2637,36 @@ static int pyrf_session__setup_types(void)
>  	return PyType_Ready(&pyrf_session__type);
>  }
> =20
> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args)
> +{
> +	const char *name;
> +	int id;
> +
> +	if (!PyArg_ParseTuple(args, "i", &id))
> +		return NULL;
> +
> +	name =3D syscalltbl__name(EM_HOST, id);
> +	if (!name)
> +		Py_RETURN_NONE;
> +	return PyUnicode_FromString(name);
> +}
> +
> +static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
> +{
> +	const char *name;
> +	int id;
> +
> +	if (!PyArg_ParseTuple(args, "s", &name))
> +		return NULL;
> +
> +	id =3D syscalltbl__id(EM_HOST, name);

Will linking the perf Python module fail with undefined references to
syscalltbl__name and syscalltbl__id when built without libtraceevent?

In tools/perf/util/Build, syscalltbl.o is conditionally built depending on
CONFIG_TRACE (perf-util-$(CONFIG_TRACE) +=3D syscalltbl.o), which is disabl=
ed
when perf is built without libtraceevent (e.g., via NO_LIBTRACEEVENT=3D1).

Since there are no stub implementations for these functions in syscalltbl.h,
it appears building the Python extension on systems lacking libtraceevent
will fail with linker errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D16
