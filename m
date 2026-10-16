Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941F3BFACE
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189301; cv=none; b=Ssx8Gh4eR7B7K8c1j2uU0XYU8I9QVgUU0mNOxlvTJU8X+9Rwu8U8UE52CqOqB75urnjqE1UMzSBEhH6aRHw0BE99iHdTHaoAFvAs1LYNIQAkMNecydO8ZEeUbZOeaTl53VnP93PClk59frI+fOuweTMxc5zqkYMm5yKAweVnhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189301; c=relaxed/simple;
	bh=1TbvwtYMrN3ZAUutmW2qwr+zX1h17YPU/cLewEHhoPg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A8huhbVPrs/w9EcPccqw41HSqwJaKP6ZP7OfciVKtXLck36ql4ujQggZQ1ZPXmdi9ajy8WNITilHZgxWxlzzQF6sTrLkvxjQiy/e8PWy+a5+OYcF7LN+c0+6CVwgSNo2px2YINKvtAAfWMYKHXHV1jVaZlssPyYK6hIdHaXUajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgWCvfpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgWCvfpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F179F1F000C4;
	Fri, 16 Oct 2026 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189300;
	bh=1TbvwtYMrN3ZAUutmW2qwr+zX1h17YPU/cLewEHhoPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgWCvfpgg92Y+JiLu/eT54ts6qkEYHmYFktr/jluLdYEGgShM6F1pxC5WCua0DbYw
	 EygMyg+OxYv0Pdk29j/g9g3jx8iML9MIzODJEWDgre+ZX4+xHcqEICb6F3KpOEztZR
	 TYlDzL41YyvEBYeNRJBu5ohPxWEK+T8k/1i7KcIsfxE9Cu52l0KMsKRvcX0B+mN/ZZ
	 v6nl1e3G0AKM/NfGuXtZRmIdPI4PQfPfdYYBOZAmwcaq8IwIQiVDoWT7+vuEde07Hq
	 UPWRUmffBTquzirAGlqaA+4nHEAJ+mj75wuLaiRDz31xCyBF3NcT91jPdJMldBAH2L
	 +dbht3qhP/z1g==
Message-ID: <sashiko-outbox-175007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/17] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-13-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:21:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D12

