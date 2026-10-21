Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623941;
	b=ho74xCzFES8fQT+TKUH3syuChdJo5/VBkg3aTg252k9kNKnUiI0KF5FW72EKDw13iWjz
	 RBkLRkxGsS6h5VZ/z71g2UEya+BsmLIJRqtSfKEnwqYP/4O6gnFs4R1+KH5RP4+fMiFlh
	 BCOi5qML3OzuTLFba74rxotAPTq5J/F6TH+er2pkFvCNOSzDuR3kGRKP2zls0Fnhi4ZNh
	 +UreIfVO/4aXg+pdTM30N00nnH0ajA2LvWHM01WVeIiAVza0h1GRUZcRRHgxkeSR33rA8
	 w2Ek196Z8FEsce2H8TdEoxv9zkKuBT5eEdVEtMxJUW8fwZuwe9oTDDk9ik8sHBkAnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N50ryFb4cpK0HRWP/hoW7QU38OmwiRZM05u/2aSIbmY=;
	b=t6tt2gTYft8sI+Z7Th0PXRaL4NMWnWQT6qpDdcwzYIhHf3NhKT/R9DlQhTeFgZPPCWNi
	 hVwgqSKFq98POs6kgFtfydFOxXw87TaMzyeKr+XEC5/yRIqvTNtfCO+egWYS3AP93F6eb
	 NkfaoGMKou2TnsXmQWoVuJQGcS4k89tb8uZRy13Bs4UaOWNu/jPDzJ1PTTCMWVIAp0WSX
	 nV/yBtkJas074VTeXny3J9RlUKFJzPIcRdGJbMmeDI9hXLknYdj4S+ICxSlTrQ4rCoW1W
	 FgEnb6KUIFIXq/asU7KMnNvCaVucYzoZ/hVZNLxLYQwBsgO47cLIQSTWQ1jtGA8EKtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCxRbm6Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A9606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCxRbm6Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D2E1F000C2;
	Wed, 21 Oct 2026 23:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623940;
	bh=N50ryFb4cpK0HRWP/hoW7QU38OmwiRZM05u/2aSIbmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCxRbm6ZCu7RJF5clGXmgI7JjNMtAbHxlvR5eI37nxmwWBiw65o9OHsI2vNC5t8nF
	 oPCuBQW7s3Tqjr3IPJD1+c0lnSjX5F9QBDUWvtSdGptcrLEn7RIyGmnKZmDoGor4u7
	 8X7Glra7ebuXbCmx4UStlZZiftUwSD0ugWyQay3ReRzkncI+W6cJHqQ3qjBVO6VKxD
	 GstX0oFcqGrO4QfPi5RLd56exmHdpiaPIVPZB3qu3V0H+M4MNG0pW4/RrmCUSohJnM
	 Z/bIo6Rw+V9gESCSj9Se99hyOoHOMmYH1hYb608XJKkn5x6bcIAJvDSVHXdBrJm5Dl
	 kruoHK3Qf38kQ==
Message-ID: <sashiko-outbox-180764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/17] perf maps: Fix lock inversion in
 maps__load_first() and bounds check in __maps__remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-17-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:05:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.
>=20
> In __maps__remove(), check that the index returned by
> maps__by_address_index() and maps__by_name_index() is within nr_maps
> before indexing and removing the entry, and remove from maps_by_name
> before calling map__put(maps_by_address[address_idx]) so that callers
> such as maps__remove_maps() that pass maps_by_address[i] as map do not
> use a freed handle in maps__by_name_index() under REFCNT_CHECKING.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D16

