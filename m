Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D319D89E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051504; cv=none; b=YnVWFHENiMzcLi5WTBv6wsWkKjZd7YnSJLQyt/iRa8v+v1jM1TlcnhfmPhWpWn0CpHh2p+3m8LC/LWI4NMmQ6TWZfYyEPqHoMA0KUfjkKlB5JaNzLQekOgbcJACFTClr2xwQIiCEmZmQ8ls/6VCeh5bRCANx74Hb90d+YCveYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051504; c=relaxed/simple;
	bh=fP4jFs44z0MxE3ihaA+psM2FKR0fFw63jEXECCSiwoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tz2JX/Yb6qHdA6uvIiliid0kXx+ikdOzlYV07wA/Hk3r2406QjRhY4kFYImiUqwFR7UrShSU/LGzdy+BUEqEqrSl8kNnWCMXeGDQHaP/REkIkDKv7Q2YHh9Ecx5O84Fu442JSHKC6JNy5j+cYVXjIPLOyfunKnhD5pDLhUXeU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbUKXZ8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbUKXZ8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5147C19425;
	Fri, 24 Apr 2026 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051503;
	bh=fP4jFs44z0MxE3ihaA+psM2FKR0fFw63jEXECCSiwoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NbUKXZ8rt9Yzff2RQePvXbzjpHYkRSaIPA2mFIlrpw7Ox108MdD2GGaZGWR3UQn8H
	 khVddM3cjFWzI/5ar0oVtMc8a+RcNkeltl9+EFNu/yF03D1p7oOFBzjsX6JWUHqhkO
	 RIyL9H+pQwIAudLpZEpYUk7J8kLohcsaJ5q0uiO3PdFsF6tRtxKq76DW/o/B9wqNAo
	 8nAiJplAAMQru9I0W4q1bPCaWLHgEIKDv08ALxXBVTOXeG9NTUSGgcT0YNylGnVNMv
	 o0zW8WXviS3Fa6BUquZa1IrgO86vIW/L90HKviYMir/3PKX20fTN3JDbTW7UHIHeZ9
	 vKwC435j0j6RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/58] perf evlist: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-11-irogers@google.com>
References: <20260424164721.2229025-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:25:02 +0000
Message-Id: <20260424172503.B5147C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Python API crash (BUG_ON) and semantic breakage in `evlist[i]` due=
 to dynamic cloning.
- [High] Heap corruption due to invalid `free()` of an interior Python obje=
ct pointer during `evlist` destruction.
--

commit f86d4772779db7dfab01f3dc1c165176b797dc57
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count

This commit introduces a reference count for the evlist to prevent issues
with cloning in the python code. It switches from evlist__delete() to
a refcounted evlist__put() approach.

> The combination is needed for the python code to operate
> correctly (not hit asserts in the evsel clone), but the changes are
> broken apart for the sake of smaller patches.

Does this intentionally break bisectability? Even though the fix is
introduced in the next patch ("perf evsel: Add reference count"), leaving
intermediate commits broken makes bisection difficult.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1285,15 +1285,22 @@ static int pyrf_evlist__init(struct pyrf_evlist *=
pevlist,
[ ... ]
>  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  {
> -	evlist__exit(&pevlist->evlist);
> +	evlist__put(pevlist->evlist);
>  	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }

Does this trigger an invalid free when destroying the evlist? Calling
evlist__put() will drop the refcount and eventually call evlist__purge(),
which iterates over elements and calls evsel__delete() (which calls free).

However, when an evsel is added from Python via pyrf_evlist__add():

tools/perf/util/python.c:pyrf_evlist__add() {
    ...
    evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
    evlist__add(evlist, evsel);
    ...
}

The evsel is an interior pointer embedded within a Python-allocated
pyrf_evsel object. Passing this interior pointer to free() will corrupt
the heap.

[ ... ]
> @@ -1794,17 +1817,16 @@ static PyObject *pyrf_evlist__item(PyObject *obj,=
 Py_ssize_t i)
[ ... ]
> -	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
> +	return pyrf_evsel__from_evsel(pos);
>  }

Can this cause crashes and semantic changes for python scripts? The new
pyrf_evsel__from_evsel() dynamically clones the evsel using evsel__clone().

If a script calls evlist.open() before iterating, the underlying
evsel__clone() hits a BUG_ON(orig->core.fd) and crashes. Also, returning a
detached clone means any modifications made to the event by the Python
script are discarded and do not affect the actual event in the list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D10
