Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2DD3CB2CF
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805916; cv=none; b=eENvjVQCUpnC+yv/IlnR4TElS/HJoEeh5oZMGDxzsMTfaFylj1p5/oWkcO0Z+uR86R+IIKc2QpgIUCHAeIDqguFBa2Hw8C6N0Le9hj7pye1i1ecmFuZDnLtPJ2q/jyJC7tifmYzGxc6isQe13lkvM3iUQNpVGBZxT8qi1XlP9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805916; c=relaxed/simple;
	bh=bI32wEny4vk5mri+r5lioAWcQrrc4wN6FEbk4Xax2pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZ9KjiDKZtjxrxNbgdOl4ioU7hcQzGp8krekGr8kiD5+2nhBwflKLLmo59QudB1L5ES/vpNdcVClEkqiUoRn0IRsVaa7mWSQ5PEr7ue5g0Nkj3fi9B9GaTR90yfwk79uQudvvMyFh8BYbNN6FthB6gOwkEtmLOnqJzs7v2SssE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXirVYOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXirVYOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7781F000FF;
	Wed, 30 Sep 2026 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805915;
	bh=bI32wEny4vk5mri+r5lioAWcQrrc4wN6FEbk4Xax2pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXirVYOLenrVz7ea5uS2IFtvDzIw7ar/GRl30qr7Rq2HGjjvlkXHCvR/USyHNAFq3
	 fvEZHuDcgGgpCKfGIrJNDfbEsNydBBCZeo4q/FhMKEmbKle/3yq1BarCgGq+xOsXJn
	 HsTRjqmQY98Q6CmWhKEzZFv6ybvOo3rJ1a6ZkXPb1zf/w63hIFVE3QuDYX53r137kc
	 rZv44WJMcn5OXgiFy1Hkx1nSKsHdJNQCuP7l3sruwBRBJCXjaSJt4CpS9FdS1ybuOb
	 1F9k0/HUCL03NnobMBLWaI5OXLO61Vkq5XeiFVsn/8rWakOTMAwbI1yWVRPc4cK5W7
	 ZxPbZKC7zIfBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930213716.2633750-6-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 22:05:14 +0000
Message-Id: <20260930220515.4A7781F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213716.2633=
750-1-acme@kernel.org?part=3D5

