Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D376370AE6
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454940; cv=none; b=dVq5DS7zq0VxuiYfwy42B9D68m5Yz7JNce6siDc7VsUkrsCMf9ECJ+VttezBRHDrfXzqqLzRh965LZUt+o6poptIc3vd/mGfttWbs2JaFqk+VfUGmXJvr5qudg9tkYkjzK7bQnUddmI68DNCQf69mExk95/NBv3bG9WuHuPSsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454940; c=relaxed/simple;
	bh=669UCIo4KlJHTrGnFXBI+rB7kgfbDyPHXteQ8T4Ni+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ou764FqjLVwuV3Ie+ELbwoibihQnrXKl7oF6h4BfFbXF7wQh7jhDtaQ+Zk3HI3ccdn6s6kRaeC/bsWMW0Ht11nZlV435KqsGZ2YDFfBwshsBpz5wrYmwsX7G+v5Q7LfTMd/bz8uWj6EYCdnv9oEAYc9HpJ1H4Gea19UBaVVOxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4IJw7EN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4IJw7EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB91F000FF;
	Sat, 26 Sep 2026 20:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790454938;
	bh=yvSVJSh0ViZJWi9qdWiUl1MBbyGQ8/DjyJsXXKc18aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d4IJw7ENDLeqXmSqpOXgU+u0kGZRl2elNbp6krOzKS9vNO/4rHjQ4h/oBQExUEHA6
	 xSX0IcfT8tJJbcTaFpEPoBJkGdZz75/b4KE0bj6bHbOoTwd1ShQ+bqJCNV2xREvJmg
	 Afu7ZwDgWGF9BgYHGr1HGh7AivHzyXfVIAsXI1efgszbM5Zq8Bp+xGPHmQHYhkpiGs
	 Y3BaZR4eHlvGUlVLsev2kfKQgIeQj0PLfdwpPfgR8Aa3GXvD/hWM68jsMJMfzROTEy
	 5FIguHY9hTDBpNo+0vtq9nDwm50opQ5GAqZv7fPWQqueTKTLZ25GjO6fZU1jeeQEK7
	 nM/b2hgujyQrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf timechart: Remove the unused
 use_old_power_events variable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <argr21X4JoSl1O2W@x2>
References: <argr21X4JoSl1O2W@x2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 20:35:37 +0000
Message-Id: <20260926203538.41BB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It is set once and never read: its only reader went away in
> 20c457b8587bee46 ("perf timechart: Adjust perf timechart to the new power
> events") and nothing used it since, so the assignment was dead code for
> 13 years.
>=20
> clang 23 extends -Wunused-but-set-variable to file-scope variables with
> internal linkage, under the new -Wunused-but-set-global subgroup, and
> with the -Werror that perf uses by default that turns the dead
> assignment into a build error:
>=20
>   builtin-timechart.c:355:12: error: variable 'use_old_power_events' set =
but not used
>       [-Werror,-Wunused-but-set-global]
>=20
> as seen building with clang 23.1.1 on Fedora 45 and rawhide, where gcc,
> older clang and clang without -Werror all keep building it.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/argr21X4JoSl1O2W@x2=
?part=3D1

