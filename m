Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28917BED0
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257439; cv=none; b=ulMb/QCO234OgOSWjzGZeT1KJi2GKDg0DahG86fkACdPU/ZvLoLS+CEM5mcjk2v0KdIiGiMiu52geMNJ971irJFtt8yXq6MFhSvvT8hbTrlL5oTvgRVy67iBLDj0ZWnghiV/FzM0tO+n46KxPr3OrkZfE8ILTR+UqKz/O9k8Gn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257439; c=relaxed/simple;
	bh=DOyx0Uwu5Z+nfnY57u0l74Rt4m0qeTNKBfBxIQ7uiIo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eHpmc/HDdDMT+ELMNnaJp7X0xwsQ2QGQRCk0KmV/FTmaxq6hgMskd2qgWfwhsOWWJz3qCOob+x7tVQf5w/LbGCM2JTZ+dNwlZV5oiqBdWxe6a56e+ieMBSUnBcHN4MBlcch9+v0EAtMOLvzzfYA4gGLXxsQqH4DKx19IZl1Trxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR2/8DCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR2/8DCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA811F000C6;
	Sat, 17 Oct 2026 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257438;
	bh=FaL+BO2IZ0u/KCNl8vdfsiBxeSDuW2CSSM66sy/MSYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OR2/8DCcj3E7rbMazgJ0Yukm1MGFUisxWJPc+KZORQSgm30QOg8vD806RvHiXnG+T
	 m9H6LVmWr6w+Q+EFQt4LZF8HPH0Q2HHeDUVAh+kbxiEN/F/4SV7ZfDCPmvRbZSkR+N
	 lrYUHeoq3whxzp6KAsC3rHWmByFWHMY++Ia0hJGSVwgsFmdoIYbtlJlcOAn3NvmfP4
	 M+eVeAXjuEYZygJ5TW9ZlWBjYagFVje7EjheMk7Lr1hig1+2m9Fz476GvLl7oqLjqq
	 TY/Rwtzm0VEyjGbDoFMoys7LZMcoGTsRMJ//B6MAxvWwgG0mtx/kgFYwkTPQHefhtL
	 fkoOrWQAnBwog==
Message-ID: <sashiko-outbox-175696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] perf test: Add tests for lock_held() BPF sample
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017171437.2066343-4-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017171437.2066343-1-irogers@google.com>
 <20261017171437.2066343-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:17:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add unit tests in parse-events.c for parsing lock_held(),
> lock_held_read(), and lock_held_exclusive() BPF filter expressions
> (standalone predicates, negated predicates, and compound group
> expressions) and extend record_bpf_filter.sh with lock_held(),
> lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.
>=20
> Example output:
>=20
>   # perf test -v 'Parsing of BPF sample filters'
>     5: Parse event definition strings               :
>     5.7: Parsing of BPF sample filters              : Ok
>=20
>   # perf test -v 'perf record sample filtering (by BPF) tests'
>   112: perf record sample filtering (by BPF) tests  :
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Group bpf-filter test [Success]
>   Multiple bpf-filter test
>   Multiple bpf-filter test [Success]
>   Cgroup bpf-filter test
>   Cgroup bpf-filter test [Success]
>   Lock-held bpf-filter test
>   Lock-held bpf-filter test [Success]
>   112: perf record sample filtering (by BPF) tests  : Ok
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171437.2066=
343-1-irogers@google.com?part=3D3

