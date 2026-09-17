Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A423A99F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622170; cv=none; b=A74apVuJTXhuRCqCot5tr/GFGaDhujgEYxPoanKn6p8N2RRkOMqLMBgHN09OWDY8FLSnSSqWPvcZqzm/mGA4a5RV1FYX9HuCAVPbRMdPVznFLTDN5BGt3l12Z/M6CEzJRjzIUYxwIZ8mKsZHT6rGwGQ/xW44jJlAp87/Dv/yljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622170; c=relaxed/simple;
	bh=0DLGgM4hgH0kZoC67hdwMx9x6MCdFoE3MitCAW9SFjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDpD46gUhxF92aFxb2h/+d4RW5rBT+XpZaisnN0+hi9M6yWgcjm8Y1TkgvSjw+XYAJeoLz/fK1neSSJxkCQn073kBvS5iGrBJB6VisQFw+RC8qzRZaGz0HfG7sl7Rrn5SoCV1dTwxIFFxbenmd0TKPPWEQmXE6DHucPOBo69ay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV/J+e5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV/J+e5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA24A1F00898;
	Thu, 17 Sep 2026 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622169;
	bh=0DLGgM4hgH0kZoC67hdwMx9x6MCdFoE3MitCAW9SFjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VV/J+e5bU0YJMtx1GjwLTwE2bX9g34ucJi9l7ZSnmyviPel/J5muheXzMa1nPBVdx
	 VGhRqCgrskUnPd0dtV7Nl2qfm3gG115cfzSU+cJP+lcPBFvE4I9gIjY6TTBFQGNi+z
	 VKAJH+Y7bdcJmYwFU7NgKVXDSFTdlb1EXahuWLJvlYm93n6p0vm9XIi/kihYDxm5xr
	 f+HXGzxgu05HjzzWgnT65iLCJdunsdRV3uukgdebUPu8WO79x6Xybs2oqPQ3iT/DfH
	 1aFfH0Aefl0EjzZn6Lxc7FdRouCFD+S3gbsJyCV2UzFGo1+B814S+AadJMLGZfGTpG
	 /bXc4wBYjGcqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] perf config: Add core.hybrid-merge to configure
 event merging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-8-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:16:08 +0000
Message-Id: <20260917051608.DA24A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Provide a core.hybrid-merge configuration option in .perfconfig
> to allow enabling hybrid event aggregation by default, avoiding
> the need to pass --hybrid-merge explicitly on every invocation.
>=20
> The config value is a default rather than an explicit request, so with
> --hierarchy it is ignored with a warning, while giving both
> --hierarchy and --hybrid-merge on the command line remains an error.
> For the same reason it is silently ignored when there are no events to
> merge, as would be the case on any machine with a single core PMU,
> whereas an explicit --hybrid-merge still warns. Record whether the
> option came from the command line in symbol_conf so both can tell the
> two apart.
>=20
> perf stat has its own merging options for counting, the sampling
> core.hybrid-merge deliberately doesn't alter it and its
> --hybrid-merge must still be given explicitly.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D7

