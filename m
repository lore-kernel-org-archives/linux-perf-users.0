Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949089;
	b=MYB3SJGl/3eYhxCGoxHXZqHqy51UlBzrtZnfG/GfNXv8wDwVJSvo+UyONFPU5IZphXh9
	 Hd89B8FHbCXrvdKYv6fcLnBrYQqOV1tAtZN8eGn41GIG45fGFaHWDpkH1KmUomwZLAICx
	 hxmexeeO+Ixi4db6EwNZSReKE8o5IhlyJFoz3soHO/9ETVuBye32CyijDl8v1dbFAm08/
	 exD4/R287r3pYjWmeXZuLQuN83kjG+VZFu8xgAkJ5+r+YhlsYwpL+biXR29fFTZojZ2TJ
	 N9+QUx0MrluVhNCBv74Z6sZiHY0G3qMhe9CfYMgF6GP7M3WllHMKexmq1ohm7ZQyJkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AtPix4DjzwT5QEe/Wzl+fFGTK/Uzf4kgSyH69FJh64k=;
	b=I2s8ZK416zjxTFnxTMQoCVx/dT1MsBYHD/l4DP+lmioA+ccr6t2SckKfRS+dswT0onkg
	 W+/Y5ImKpld2Ep53xBe9UTwboq0+qt2QWj2ujCLY6KkYAznXF/g/n0cnC48NIi01Q/biG
	 Kb0gVTVTnZVmwmic4H17s+OInN51vbLPli19/mh++51gjWPglh+2bEYrsMevklmaSdnML
	 78pVHsldoQLa+9UwZJ2ToREMnh88nLK2tR51jjIYyspQe5uigqev87payZKVHhnMO95dj
	 2CyLe6bCOSFalfyUZe7ADKKdFHTD7Yqf0HdCU1PXJGYhbmx8lh0p/Uw0wxuf3rywymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQeBuAqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF63606A32C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQeBuAqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3AB1F008A1;
	Fri,  6 Nov 2026 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949089;
	bh=AtPix4DjzwT5QEe/Wzl+fFGTK/Uzf4kgSyH69FJh64k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQeBuAqTsJOZHx1fzyRMR7mVYmt2bCQoVUbb/cVKXE2Inn7dIbR44EZbTi1JhgNnX
	 x2oeG18jC35fIvxULnJBixjzcSywx2HSp+/GxmHupNnjrhEBWGhjxUQ1MzSNooPF9a
	 3/4C1wpCdEEXdc6qwd25QxuxkPQYgxnNmezZdpXeZDS/StI1TftdABouywmYumVKpU
	 b+Ds9RiQV97BYiONtfnrhFkPSYrSCKwyK9w/WNuGG6AxlJIywCZ6u2bFDr/GIeb0e2
	 6Oe6bS2CpRxCVJ3NTzyfwUsSgDvwBXndISl5KEUdAWp7f9oJYv6lAoyljiX59dkKYT
	 OpSwLKYSFjwrA==
Message-ID: <sashiko-outbox-200969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/20] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-14-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:11:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate
> dso__data_open and fd_limit in util/dso.c with
> __guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
> __dsos__addnew_id() from shared to exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D13

