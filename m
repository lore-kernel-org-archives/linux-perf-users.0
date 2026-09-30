Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA33D1A81
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767972; cv=none; b=glJ54WlxlGvSbS9Qwd6imUVXPnQNbjCQhqH8go1PH/aZOxa7t3VTXqcp7kJyOg6yG/VyUC30OLZLoSDgQsv5TNSOJ4w4zYt67JoNxj/BAl4GfcMs8PuYTnWw65PXpVBPFinIidBUsjZScHXyuCVHE1aoQ/Gug/eu9ZNDzVO+Nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767972; c=relaxed/simple;
	bh=rkE+dCoU3tI06u7qD0yzMdkpLmV6d6XL21LElN1VuEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ojE8natbH1taYs+Qgw8GdE3zepVOMJFZg0aGdkqaI7HviYFG803o4tlq7C/XoeMz5myNKujdKOPy72+mgXEwlLG5JtFuBGXPY559iAkM363ngmwbKuaLg/pFKzntq/AuxZ9oBgr2RMQOys1f2wwtZ1mAsR9Bv9RRnKPOSsjE+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7LEUkYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7LEUkYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12CB1F000FF;
	Wed, 30 Sep 2026 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767971;
	bh=rkE+dCoU3tI06u7qD0yzMdkpLmV6d6XL21LElN1VuEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L7LEUkYDDBdDxV5zMTyVIOpKsKpvszd4tLOl6dlLyCXMC30I9T0F1pnPmIN/fPbL2
	 HIzlUHX/3RVR/acnhBW0hQkFaiKOprRY2MSTvSzcBJxYGEVzoJ/rYvxgWjM27t1wc2
	 M2y5Y0BfwlcbwK/022LWywBMFSmAl24dNXKFKwpP4q2w3LU1vY9F9s0EWlhasNKBkz
	 KEINdmwYtoY0BJyoE4Fa96YPy2cdibK9WmHYXpxg1p8IvHnhq3/hqfz4Z1Z4nWDpLa
	 b+J22z0JhbAZ6Zm4/UNcH6phkETyUUZZP3U8SDHDqdE0ZJpAcmsru4/AgdhhoKinI0
	 PHL/sbcdM0Fxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930112454.16331-6-acme@kernel.org>
References: <20260930112454.16331-1-acme@kernel.org>
 <20260930112454.16331-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:32:50 +0000
Message-Id: <20260930113250.E12CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> hash the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930112454.1633=
1-1-acme@kernel.org?part=3D5

