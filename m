Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A21624D5
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937028; cv=none; b=ZYKXS1rbgiv6Tml96zprg+ozhd1X07HpJhIBHNGJWlAHrtFTR7ABKXqq74wIeaHOljI2N5dkgHZb77RcpKDaWwVlTGTxlF2nVmmCudbFDWcNfCaNFNrbJess6M9c4AhL/jCda0rlbwRoGuPzvBc79K9+tk3OMXETeHw32lEhNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937028; c=relaxed/simple;
	bh=uI5Q84VAnchThgQta/4/yxR5cQnVqXX4ViVp8xs4S3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9hf54s1U+q/lM4ckIYgg31uQfx3EIwJ1bCfoP+v3jm+MBDCH5KH0pFOXZgG2QOsDx0wjlLNFPTfEhL35+Q6KXoewowvHegFdX0erIz7uoIu2m48egK1Z/Nat7yibHy8COZHkyw/elyygC/E3zG5Eb+CiI8IrFZxo+cK07F556E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI3WH0J1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI3WH0J1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCAC1F000FF;
	Fri,  2 Oct 2026 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937027;
	bh=kVf9mfSGq5ubt5sXuXOFSPXHMoSoYFZGF1uTDhRdxbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hI3WH0J1DGx65Mx6+CwPs8ec2n2a/jiKvnhYD1niWHBw4kuBvWHbjz/Ff8AlrHGZc
	 h/lCzGE9AXg2tHj/lTApfq6KttIIRY6RhQ/kBoNV8b4WwnRWPtedK0Rbhx7hBGXVY4
	 m1cifHFG0G77QcO1Jvo3/JDH2+JE+LdX3dAZ/BSJh8dt0MN84KGN/wIzF7EKjySscg
	 jnSp/kcz5TyfU4yFnRL95S3VsKj58X6W/qPuvRpiAitfPxaN7VGTBNbeXmpik5vZxh
	 +QfCXXfjSrkqZyAAMKE1E58jjXBeMxHmE8Bt+5jO2ziBpnvhYIbJE9DAkWK6oEnRRA
	 GQuqtJFPRu45A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 9/9] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-10-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:30:26 +0000
Message-Id: <20261002103027.0CCAC1F000FF@smtp.kernel.org>
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
> sum the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Data type profiling of the workload with cacheline info:
>=20
> [ ... ]
>              0.00%   0.01%        struct folio +0x34 (_refcount.counter)
>              0.00%   0.00%        struct folio +0x18 (mapping)
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D9

