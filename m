Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB14D9F68
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584025; cv=none; b=Uah4BCSslCXlY4YPigH58qYFShpGKKvMmabObW70m6QE4n7RsDN+pmQ0ekZqSXvsMkYiVU+amVf0N615Bps8D0T+QYgmBXEqz6C2wqy0WYnf7eEoHbJ2yGu6dtJmu1sMQ2zeWWm0hvxnS/IgMjY25tPVYE1UgwFLnJ7m8i4HsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584025; c=relaxed/simple;
	bh=rez3glegKjtgUD4bOVIgvOEZ30PMNiQl42EPiumDeAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1O++Y6SMNou+O5IQiaKSimUx7YkzXkrNkQe4DC/KhnOZ5nVp6oq572jln8FCDswEKOdtp5yMLK32xmkUzbbEM+5KJdeByvIMMDS6VL4X3k/+j/7SdIEry8Te7xyzFHi4gXvm2DZjNLS+Y2bJFSonYHgoC0i8swIkMTB2+dQazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYM5lp1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYM5lp1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD8C1F000FF;
	Wed, 16 Sep 2026 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584003;
	bh=5oNgT7ZqJVq7otbh9Wp+jQJ9agGnd5c6xoqIQHuvOBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYM5lp1LZwhOH/07o6qMFNFD0MfruU6wgya7eeVEyRp+VenkNepNsd0TLJKxrIiaV
	 c6BIijKQtBipvRoe9TeVwYtdVARoIZ4ApoqqmiQ+Bk6bIHL7rQc1amEu9fTzhvqa5P
	 HxJUFqjihr7ILYrEj0K9OMLw05nFrROChXed2hXFmxOPuqpMZvFlDhaJvoqZNsRK4a
	 sdAzjUzNIYHC9DarSS7RaFMCP8k9DYRF0nJrFXJc4WF4TAGSavB91CkuVodrBLUA93
	 cUOswB3Vc9c7Ueulp838aQnw+qDmPGCQeJo9TbytS3i5SZmxekMgtwGkPmYDX6eZtu
	 +aCDk408QNiPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-3-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:40:02 +0000
Message-Id: <20260916184003.3BD8C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf already uses debuginfod to fetch source files when annotating
> (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> which queries debuginfo keyed by build ID when a module's debuginfo
> isn't found locally, largely the same thing this adds; eventually
> that one could be moved over to the new helper.  For the analysis
> tools there was no way to obtain the debuginfo for a DSO in a
> profile when it isn't available locally under the name the DSO was
> opened with, for instance the vmlinux for the kernel a profile was
> recorded on when processing it on another machine, or after the
> kernel and its debuginfo package got upgraded in between.
>=20
> Add debuginfo__find_build_id(), that uses the debuginfod client to
> locate a debuginfo file keyed by the build ID, checking its local
> [ ... ]
> that make NO_LIBDW=3D1 on a system that has the debuginfod client
> keeps linking.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D2

