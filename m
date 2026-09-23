Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F843E06E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148220; cv=none; b=Sx9CC5tbMSTYJu4XWRiKCgIsbiv82ihkEVe3xIfoZEB/fg1YO48O09wYAVeTNnmiWgCZ0I7icqaPYuOWxOl4b8Y4gKQxYANN7H1g3NJXteaKCAuYnGWPjZabJIOtsnE77/XS5ZeRu4/d9KXVmrQpUPOeK4y41pcjTUopU+Lopls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148220; c=relaxed/simple;
	bh=75Cf+oGbvFvjUfll7DiiEw1yKtcxiH31xyL+8j4703I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iDiprR7bd7QrkWmrriVksOrcxwUrEm0gIb8oYZQROLp5qMShf3pKUglprOsy3baE5MoG+JqKdTHqiC8zWEiH+WgOYwJPba1g+ZAyO5JAFhHdoBu8FgrowXjLG/7eQtLwafqkCQqA1i4VTfftHunS9VKsRit+BUUCYWkHbiGrB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV2F8tow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV2F8tow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F1E1F00893;
	Wed, 23 Sep 2026 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148213;
	bh=75Cf+oGbvFvjUfll7DiiEw1yKtcxiH31xyL+8j4703I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fV2F8tow1RXeb0b0hU0KlOoNNX0b23n2GWJdudqVUPXUzasvAvxNmBQSrl1qY9evx
	 euNHUILK5zGEi/GScTvXicYxevBn88pKCpz78N1Br8haLYufTxlZKT6dioxh3nEjbN
	 REUeA/E4MfN6BPEnftdp0J7sBr1wzF2dQDZpBYZCUnNVA/2bf6bEjIhQx0g8Cowupb
	 t3Cj5p3FsAVGYm7mwUuxx/7b6VuaKW4PpcZmKu0mfJA8Lm1Ul6ihkAe4mOoDoeiHVc
	 xiILlYBuTla212pzQhp9AmOoccvgbT21jOpw4JyGtBrsu6Vf58vE+rdBPyzzyKhV3R
	 YFX5Gfw6hbVlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/23] perf test trace_summary: Improve error
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <db0864b553cee9cb053cc92473dce9788ac4e14b.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <db0864b553cee9cb053cc92473dce9788ac4e14b.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:23:33 +0000
Message-Id: <20260923072333.85F1E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pattern matching fails in test_perf_trace(), print the command
> that failed along with the actual match count, the matching lines
> found, and the last 20 lines of output to aid debugging.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D20

