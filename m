Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA435675E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603107; cv=none; b=bGlNSUH3xKZiu96e0JiS4XlZxmO3A23VkIKb4CIJTyVdMYBH2XxWTwJLuEUPrbm0QPQpuP1fi4A3RNsKHfebzRD3PpNTe4yUwxOiZCEBd/IehWIyZeeCIRv/0wjxYF1+0cypTYCpku1NyBxHz/BkSfQdJKBD97ZrtgHYsKN8FuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603107; c=relaxed/simple;
	bh=MAyIKkM1Umc7NklNhZYqmUsDVgCZk6/0vvB+zxlHsyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jIDNDwksetLLrsd13DGvMLR+K4qkb8mdjxuiKKGyT5IObnnV+whR3PS0gD/WcIjpiOW5RH6MRScO6SKvE3aKLFH5LWBL7iNhEyeDmMfD9qm+2oZqgW9LhE2xK27Ef9fp0T4gOs+t5u90KxzYLHwgSUUvGXu7AcCgS+B9vaI5pvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbh9of1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbh9of1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3CD1F000FF;
	Wed, 16 Sep 2026 23:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603106;
	bh=MAyIKkM1Umc7NklNhZYqmUsDVgCZk6/0vvB+zxlHsyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbh9of1YdU44G5Fl7CRcBSI1oOQYzrWUjtrDn0X7EBd3BtVakxmmXokTFqijqgZmk
	 /OL6rogIL89Dw12R9kW8QdIR5QMlag4HPU8GZoe4IZ+Cu162GJsizeYjJrnSwTHC9a
	 6eyMrQZSDATeTTudDjFIVxdfb7FQnXTsFFR2wdLIVN3VVJw7ad6Jfs7n0TpZvlryln
	 JpF4k88pmFES7dUX9XAdcZVCel/VabqLn4rYqnl5kwp3otqynJQS6R+dYUU2Z8IZir
	 RJ87HaZtfYhYsGdiBCoCn3Rpw62bs5H7IFjjrF82WxuCRFJIWztTx7g9sh2+EAv6gt
	 +p+9PjAZAKexA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] perf evlist: Implement evlist__can_merge_hybrid
 using first_wildcard_match
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-2-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:58:25 +0000
Message-Id: <20260916235826.1D3CD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add logic to dynamically identify mergeable events spawned from the
> same wildcard alias via first_wildcard_match. first_wildcard_match is
> populated when events are parsed, in `perf report` the events come
> from a file and so the first_wildcard_match is computed by matching
> event names.
>=20
> evlist__can_merge_hybrid only tests whether merging is possible and
> doesn't modify the evlist, so that it may be used as a predicate, for
> example, to decide whether to display a hint. The linking of all the
> matching events is done by evlist__merge_hybrid.
>=20
> is_pmu_core_len identifies core PMUs using the hybrid topology of the
> perf.data file. Should the file lack the topology, the PMUs of this
> machine are scanned but only when the file was recorded on the same
> architecture, as PMU names like "cpu_core" are architecture specific.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D1

