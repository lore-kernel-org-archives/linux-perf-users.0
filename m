Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048924;
	b=H8ySz4nMeW+gfFNUHZBMRxjNEasMcw9eIVED7NzvenXEUe4iSVxUTBYPXttxvDSbP0lG
	 e4N2RxUa2jR97KDxE2LxwKmn9iJ/pg1B2O3T2h9NGwRQewmVXTMxOpkp9Q04NbnREdUQ5
	 f+rgjlMWPVgcViwafwHIp3gv40/y4Sgzu5V2JVE5k65VF/PuJPP8sYbnu4ndmJANZQbJy
	 M1ehnkG4aAlJyy26btqJ/r3C65F9t93ciew1e3TfVChI9mY1NpsnmIcqQ6cnYkspglXDU
	 BCdR4Yltw5xxfRltYsZBQKW5nVnk5VF2mLPnK52bzbgATS7Nku/AzNzEdndg1HytcfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048924;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ofDrGbGsXuCIOILnDKDyq++EnKlezIcA8OREWDidtfg=;
	b=V4amnH39yGKapc2jWWdMU0KjkK2GXJNSsUkgan43i9zyvq+u4/ZyBF0ubgKL51D+pjy1
	 TMM+0Hvv5T9MxJiP4uaVBeAtrmi+88HYblJCfB8XGriqL8SyaPn3JVlQAGItV3N07PX9C
	 2ITDz8DMbbGavHR/pU1By1U7Djcd77DNdd3vgQwCopg/hnJfJW9uRbJFC1WHLUsO3rkBb
	 9X6zijUrOndx2WpRQHIp4N/8iDwWBnw3omt9RMNWsFdJ7cVW457nc+Z3oQRvhasO/Ttc6
	 xPnquF5EapCs5yfBDOLDFw0WkGhw2FB6uiogO24uNX0vI/RSPzQsJpiajCyrQCOKsrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKoI8Oht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAFD606A335
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKoI8Oht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658C91F008A4;
	Sat,  7 Nov 2026 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048923;
	bh=ofDrGbGsXuCIOILnDKDyq++EnKlezIcA8OREWDidtfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKoI8OhtzGhWGsaD9OOeobb6SOr1+OaW968S0Tvg8j4Vky7ptpWEgat6wKCFgUz6g
	 dkXfGy64pMGv0CcXIsrDxPlKVZH06ndjlu1FbxFMnwvJJ9+xGSdKcud/3W94FzCuVP
	 vhzvbR9CVL50pU6OPjBHhgXUXXvbQBSaiR8toPuEal9+TXuE0tfAHF8aflUqWea9RW
	 iRBmYudfiHT0nYdbTiy0qKiAoQJV0uJRbdpZdikZla5dkAwJUq3VHWXDz7bcnk+MW5
	 Z0OcbeVW3suoXPPZRuxOzzvc0HuxuJ2+UA31UbjTUNhoNShqp+cSh7sQUcwy+g8DnR
	 trTP5x0tDpCNw==
Message-ID: <sashiko-outbox-202833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] arm64: dts: apple: t603x: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-11-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-11-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:55:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Adds the PMU nodes to all t603x devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D11

