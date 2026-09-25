Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA13E0081
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380213; cv=none; b=K8hARgzjmX6ItMAHY5FGVbawzwhVHwJCp5MDeYk0PX25Rvov3Cnbmpi2YwLyjzVyO6YWyk78kDyh4Zg2AFzxOTI5ft51ySF5FtOyQTtIDHCB8biqrQ+r5b3whqRIMWj2y6GvoWGqp1gP+MWpJlfBnfZy/T0LS8dBa6DHP2hLsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380213; c=relaxed/simple;
	bh=AmZoI4/w+d1ndPTjn1fRinQwDrhXzr8KHla0I990/cQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BheB6lPK+/CE0HTUhiGHzK6OkIwfqehObrMJ7a0W8NdI3Utu4a/PM7qKh5tQwQP/H66Pz+rNobvNbo/K/eZpns9QPcLbBaUSWWwmyiPgLawgYAMHII0NaktjUobkaxk/5K1fgIGWwVYQtqeljJifFV96vNTeMEJNtqVYmSxV/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCn4ONsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCn4ONsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9261F000FF;
	Fri, 25 Sep 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790380211;
	bh=/sJ1huuq0m09SxSUaWBY7EnXW2x4a+zMkgDgbvayY0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCn4ONsUhNSEKsawnwPxJMrDdRTDk3gc700P2xH/6fsco2vPoAMTTfmTKcsI+aUnV
	 KrKhdj7PPLzW1V3dqmwXCmHiY2C2/gWjTEz67H61tmzioEkVv94skUIH/wcaj0WrDq
	 XtMNBLbPwoRDJkxFXfqUeUmT5yMNfJ7CDC8DVhM3friTEY89fzt0qgOAW5COb7KTvN
	 49W8AB/8/8Py0NBihU7RGFsytSXsCSKgfUEFc+fbDflgAim5Q7devc8F9HngJkCA6N
	 sI4D3iKpBFTxTcOc2yMJa8maoP9oS7WQJQDrgK+OnXn704BPR/vymdcvWPKK2Sooz1
	 tEpUZUMqwNozA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] perf tools: Bump the minimum Python version to
 3.9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <arcHnvhd56I8SrZH@x2>
References: <arcHnvhd56I8SrZH@x2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 23:50:11 +0000
Message-Id: <20260925235011.9E9261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf's build only refused interpreters older than 3.6, the check added
> when jevents.py started using f-strings, and jevents.py carried a
> removesuffix() shim to stay usable on them.
>=20
> The kernel itself requires Python 3.9.x since 5e25b972a22be224 ("docs:
> changes: update Python minimal version"), so tools in the tree are
> expected to work with it, and staying compatible with older
> interpreters stopped paying off:
>=20
>  - the PEP 585 generics, list[...], used by the type annotations in
>    jevents.py and util/setup.py are only subscriptable from Python 3.9
>    and, being evaluated at import or definition time, they break the
>    build on RHEL 8's python3.6.8 with:
>=20
>    TypeError: 'type' object is not subscriptable
> [ ... ]
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arcHnvhd56I8SrZH@x2=
?part=3D1

