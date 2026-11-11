Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431234;
	b=5BTYEwvTA6TdITvTngpOzBGOQJ2rJih+B0OKrmHiHseTOVvGeJ3NooSMg3xKbEM58Rtc
	 o7kw0R5pMOqKGjOTisTUtGf7rIxdypE9kBmCs0rjZW5z2NhBOUkLRF5Lx3ImZf10wcu9Q
	 TmDrc2M3o+CYbxNUHdRSFqRyTINasJmR+JdSfR9WxFHOyBXqGH+D97IY/JKvKlb9kdwOz
	 tAgiLzNlV7J684aIquuJZBB9W7YkIqXslMH3DcQbJlDXDuTG8qVz7pIO78k61afEhOUno
	 Q2sc45WxdqLaDdx1n6eviBIyFq4h7VcDlis6nFkmFGcLbH6Kgw2PdTlPchQmE7AZITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ujx1uAHdpTGrXVag86rwTVmy2hHOXLaB/H/YzhG+0dk=;
	b=nJKJj1BOcVVZ3meocxat8bWzWXOc+pCshw7Ig2PUcGCwa5DxbfL5ol1KpET61zG35jkZ
	 +MeHajl3AX25rPI5/j9W5o4cof1HQLCzM/d20k661LwPVHqY3zxg+2A4J586FNWJPl1sr
	 UFmKGhKemp3BdYJzSzj6uxAYe6vVjVDHhNfmULvLcXgXEKbe+6loMIYgarjyU+aEeEMe8
	 TM8m/gRIrVlW/usEVzgx1dKeB2JfWM/j1eNTvo3KzmknFJNSxyNX1dA7eN+EBcmIfIK02
	 uB/ZDvqzSaO73NvEp8fTf4FQKwcOKvpe3/TQ6f8XHrQuBszSeU2gnNSR4w6JdcNixdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iALBjLt1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA02606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iALBjLt1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666BB1F00A05;
	Wed, 11 Nov 2026 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431233;
	bh=ujx1uAHdpTGrXVag86rwTVmy2hHOXLaB/H/YzhG+0dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iALBjLt154WZjhSmfNxbvT3D+x4ecUuZgHebu9/XNiGtvmsL5uR7bzbZ6ta/4Curg
	 /wQ1WclfvBvcL4G7VqoD2N7arx+7GJW3y2D08xruZJ9iT+DYQWlFjJarIPDScs54xW
	 pBVmgEs+VuQpc5pN+lgxnkfy6Yn7Uw9IsFvZxNW5GMiOi4Zw86y6smF7o2nUOcXLj+
	 NkA1C7UGcrZkGtT40BEVC87/qo8h2YvvBQWdL1MmWTSshXQe6sG2EuBMXPZdrSQRVN
	 XLnJcRxI8KIdhrsxrR/DhU1eVgWLYzXnZv9tArOPhhjd75C+QtjtUMvpQM5k8JVXNo
	 apNMT5uGg2iJA==
Message-ID: <sashiko-outbox-209687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 18/20] perf maps: Fix lock inversion in
 maps__load_first()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-19-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:07:12 +0000
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
> Fixes: e77b0236cd0c ("perf maps: Add maps__load_first()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D18

