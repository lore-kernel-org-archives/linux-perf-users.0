Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C35C8EB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250444; cv=none; b=nJ/CDWHULMEF8fzkJUfAgShMNuO6tDqmCEdWwM3iYdR4YAa0qLueJtDTUi2pm7LeRiCaKPbDo8igbzyHdGu8AO+hjSF3qZdqkmW4eHTaqkbwb81PURYs1LquAaTJ20vZMLUBMGH4UC6UKwVUHw4EN+wE4YrtaOZ+8WZSVl/MDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250444; c=relaxed/simple;
	bh=lrYrJp8TwBizqVSNeZws9IQKWo5xkfKVir5y4rg4k74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YpmWE8qEcnr1apE7W1dEwmzNM8fzlGrQOpNpwZ6+F6uIELYCePzW8PaDMMtcDMyQK/MxuUv2K0iSo4ewRQHFlB+rKlOUNhrxkfk0EvU310AZaHQmCWzSB5fXvc4rBLm0xLp311GBIYO+JKxKJBxm8mGfyfYQscW8eNeLurDXbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIirzY9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIirzY9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEABF1F00A3A;
	Tue, 23 Jun 2026 21:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782250442;
	bh=lzeky5gPD40HBsUqqciW0l7a7g9notdMaHX5dyRA31o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIirzY9TaYqKPEn5ZWIDI0pnywLQam7OSHZH55RTSwKdiJo3AbSSjCJJ6JQd+/DYw
	 BVhxap70x1LmYZtX7zH4nnedK1Tqoc58QR/lN10755Q9bCpm+dDfDQLxz+I+2bQBce
	 H9JXC42yfFeC6TWb1GmHcYBGFstJhztEoIrrmzMXf8FaX/XAH75Ey6UAAJr8YZbI21
	 Ad5Ocf/gzzr0KgSEAoxlBQYldKmq9QChADtJZtQtnWfc6jTGfa3PCGtaPsyQa5Qp1w
	 Fy6vog0Vs0DkwY+2L4nOBDp5ng+fesV4ODG0UudjnLp4czerUIEcrNCg73PTq8Ag1/
	 WHGL2aSn3BdBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/13] perf python: Fix memory leak in
 pyrf_evlist__get_pollfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-5-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:34:02 +0000
Message-Id: <20260623213402.BEABF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added `Py_DECREF(list)` introduces a segmentation fault =
on the error path if the initial `PyList_New(0)` allocation fails.
--

commit dfef1d27b0ba6fba485792f67daeb68ccdaac6cd
Author: Ian Rogers <irogers@google.com>

perf python: Fix memory leak in pyrf_evlist__get_pollfd

Fix a Python list object leak in pyrf_evlist__get_pollfd() by adding
a missing Py_DECREF on the error exit path.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 11e1f39c1bea9..21e8b5a23a1c9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2843,6 +2843,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyr=
f_evlist *pevlist,
> =20
>  	return list;
>  free_list:
> +	Py_DECREF(list);

[Severity: High]
If PyList_New(0) fails and returns NULL, this will attempt to decrement the
reference count of a NULL pointer.

Because Py_DECREF unconditionally dereferences its argument, will this resu=
lt
in a segmentation fault on the error path?

Should we check list for NULL earlier, or use Py_XDECREF(list) instead?

>  	return PyErr_NoMemory();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D4
