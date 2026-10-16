Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594DF2C21E6
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110515; cv=none; b=kYuHx8LbkubV0cETinWpLX7tIG2RrODCPIH7ZokPrO4lfgE/0NLCnv7xOKgebLrMsDFTFMGh/Jz+cFaiQs+td+MZFHHtbD1KTg1re7a/AENb7rayWJfwwd2GEehDKCvMzM49BM/ZIJIZw3WzN3G8oVpqJXVxyuALC5b4z+mpSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110515; c=relaxed/simple;
	bh=jzhdsEl95Tee1DNol+Xb84oMt6BZ4LzQikg6JIsDnRU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GOgYh1qBMOqcoDi7PaBoWBdeY7YGRh2r9/4owx2wwFL80gJgIZtwFx9CRdhDG7CLqmef6DRVwHUdnV8E+8o9buswt/WuDB/zB/LB5NAWw8OqnmNWbNH7A2mWmTzGZzUYIgd3+qXbgOzcS/7PcgA/9i+QnAYXaoJFDrNpac7DcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTcHT3Mz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTcHT3Mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96A1F000C5;
	Fri, 16 Oct 2026 00:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110514;
	bh=fj2TpNcqfj1Xd0OrI/qt4PWVHON7hnW52fwjw3rwzZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lTcHT3MzAkktbe3JnQ+5jat4aAavOoIv7PolJEFZTvF2fP6DAq41MBsfs3rrWX4np
	 AsWgf2FxmskxZlocj5iv2TwCYor6BCixqsDpebkHSSwbmrrM7i6QFJkZ0zfbOE0C3d
	 jUA6/M4pn97rbSEReJajgc0HDit/978g4xyRb+HxJdxJXdO/JxNbrfQd/wj/EVzxlU
	 TlUDBNpbWvPvUHoxo39jScZE9tu8c5MRUvdZc4DzlKo6nazLOTchWyuvf9IcOj2f6p
	 7xZOKhp53UkGeocJhccJYNXzYMeu/VocCeO2rIa2aNH/cNDBLxChmi5tujn+a8Rdkl
	 pPT3M2OQoHqAQ==
Message-ID: <sashiko-outbox-173529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/19] perf test: Take turns using the perf mlock
 budget in the mmaping tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-20-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-20-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:28:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The mmap size used when none is asked for is derived from
> kernel.perf_event_mlock_kb itself (see perf_event_mlock_kb_in_pages()),
> that after rounding down to a power of two number of pages ends up being
> about all of a single CPU's share of that per user budget, so with 'perf
> test' starting all the selected tests at once, any further mapping done
> while another test still has its ring buffers mapped fails with:
>=20
>   Permission error mapping pages.
>   Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
>   or try again with a smaller value of -m/--mmap_pages.
>=20
> that then shows up as a failure or, worse, as an "unsupp" skip in tests
> like the attr ones, i.e. as a false pass.
> [ ... ]
> this machine for, and the BPF metadata collection one, whose output isn't
> what the test expects, are not budget related either.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D19

