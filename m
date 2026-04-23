Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C114EC73
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917984; cv=none; b=XdO40zHFOa7GbYT1Nh090moaGnpY0abU4WcRqGH3kfTjOrhYvM5ojG8fZXy0NrI/aqTgyxEiQtN2GRb0ky5GhvEZa4nVW3T5XnqUq6MrkkgWGfQff1yU/bp+JqLLBd1+XAW+Rier4TKHds090LmENumQCG4sCLJGKNOuH/wUcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917984; c=relaxed/simple;
	bh=kEbAvr1RHmJ3lRH4opHmX7ZXcnNxbJbKdGJw0b3v3UU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pd4J3SDaSzYbd+nCJ6XKQv84UGFlvxjdWPQQTnQcgLXVMfAdF62+GjV1Zn0fJG25dj6S+/CoT/6Ix15vshQuFJqiK3RYcq+G1dVF8bQKuryT40BUb08pvpCb653kQWG5s9qIn7rO1nITGo3SctexvLX5/MsIeVf0EABijPQynzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE8qmXWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE8qmXWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117B2C2BCB2;
	Thu, 23 Apr 2026 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917984;
	bh=kEbAvr1RHmJ3lRH4opHmX7ZXcnNxbJbKdGJw0b3v3UU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZE8qmXWPlkwuPR0vErgOdWjdGmlXL3TDNm20cNzzbfQjjj7qKdhvEumtwV2wB/wDo
	 6GiDGW/yi1wpl39vg8aMSnilb1qlykVZG/DexZbj16DtEUrXaSLxZ852E9Znu9HHol
	 XdImSbPXz0jIie5U8uKuSEl4VPfaJHwS9z4UtUGtZmd1KaI7H7DYBZZb7L34rxWz/1
	 AvVtfWcIpoHqqq62F3cMK6y56BVSYKDRMSB1hRg/3FxUAVgJ5YpFY2Xa5yBJMAtt6m
	 aATmJpy4jDdUJARHIlwz6Vmt3LJNytVqotPZSJ2ABhKbO4M+6Q215i/SbV5eVyvLMN
	 c8Xe0KkZiNh2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/58] perf evlist: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-11-irogers@google.com>
References: <20260423035526.1537178-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:19:43 +0000
Message-Id: <20260423041944.117B2C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Invalid free() on Python-embedded evsel objects causes heap corrup=
tion during evlist teardown
- [High] Python evlist item access returns a disconnected clone, discarding=
 modifications and breaking object identity
--

commit 493a283e594520e58a08e73743511567aac59ef5
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count

This commit introduces a reference count to the evlist structure. The
reference count is initialized to 1 at allocation and decremented in the new
evlist__put() function, which performs the deletion when the count reaches =
0.
This change prepares for future modifications to the Python bindings.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 1e6c99efff90e..3f0758d5bd904 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1302,7 +1309,7 @@
> =20
>  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  {
> -	evlist__exit(&pevlist->evlist);
> +	evlist__put(pevlist->evlist);
>  	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }

Does calling evlist__put() here introduce a regression where evlist__purge()
will eventually attempt to call free() on an evsel that is embedded inside a
pyrf_evsel object allocated by Python's memory allocator?=20

The commit message mentions changes being broken apart, but could this
intermediate state break git bisectability by causing heap corruption during
teardown?

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

Does returning pyrf_evsel__from_evsel() here result in a disconnected clone
rather than the original wrapper?

If so, could this cause any modifications made to the returned object from
Python scripts to only affect the clone, leaving the actual evsel in the
list unchanged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D10
