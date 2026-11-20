Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201528;
	b=Fbw6lRyUyxmIvKGEwNvuP22y59gpHNpE5IoLfgUh3O1EtYTsW/nK8iiNiSXnBy1DvCKa
	 4Qck+ccpMXHJbi8Iwm0mFf5P5c2G98P5QYtix2S/obCM9KicEb6iiPi8adTYavasdN8nI
	 k/sM4ptq2p8WlPsitNe8FUFtERblBu7YbMFzu4J77zGxB2r7R7q26AsQUw+zYlLu1OOeh
	 NJsI5GwqXiyKpnesrQh2Lswif6aovJ4njNF3vwTaEoNTPzYaETcpyVW1VMyeiDT76RI7T
	 YKfXQUIYYvjtZWJZLc5zPxpsCSZweWCb9+e+SNAeL+L5BgrtGu4DHmn6munT54YE12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YWDB41tA+HvQnXXnJ/zlNp/Wqg62ipfC6ot3DUlJhrg=;
	b=asx66oVREutb3OHa1hQgNcrobvT15/n3es3MycIgNPMfr3UpAYgaoI0XABUtwbnzXhBc
	 KC/VhU+4uZuklJrP1fkmDRwOD7G72RZpdA1LV6PLXUr8xNZ4mbnRlYyIPOpjkC0tZrooS
	 j/4bfjoQ2R3geAs5RenUJJPvqpHMEXN44x9MUoCK9e9zcYCUum2ujnGfo3T2wrSPlmG8G
	 DxoGe24re317+Kn3Optm2lgkmu+2jcm9d0XO4Zu77i6eMIXKTbsaCWkqKtd+ZVAJT5KH6
	 UxOp6Owe8Wyn1fBmx3CpapFFQz+2+402deSY1C8mU6Kj9dazx9RS3J6JCvM7DPu+FwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkPIC9+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24D60A2630
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkPIC9+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593431F000C6;
	Fri, 20 Nov 2026 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795201528;
	bh=YWDB41tA+HvQnXXnJ/zlNp/Wqg62ipfC6ot3DUlJhrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FkPIC9+02DZ9PIUkxzxl6ht2Ed877WXI/eHlNhHP87NjN/5fIsA6vYLxOLfkMk0iE
	 TwjPORcZDh00vaFcurSBH934A3iZnhx1vRINLpM3VeADwybgtsgCru7oVmpJ0b1trN
	 brIPS6JmUHlQsqruyDqmzfurr04oAlSL21TOdTnEbM0IEEl0/TBiJDXViJMGaPKzgy
	 pkqIdhDEaEvfdFB8DT9Hf5zliXRsJBcA+My+tj4Dhi6inhcIlQG6wpdMWlG0hWTjw4
	 ewwfdq6rGb+x3P185fL1JN1PuhuEq0tYhdbjX65gAPtYWIIfA28fYWEy2W+h5ajlil
	 Z36AAYQW24wiQ==
Message-ID: <sashiko-outbox-225888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] coresight: perf: Filter sources lacking the
 selected configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7ba910406fc81e09d31e9c6f3909012b9b85bf22.1795196854.git.aaupov@fb.com>
References: <cover.1795196854.git.aaupov@fb.com>
 <7ba910406fc81e09d31e9c6f3909012b9b85bf22.1795196854.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:05:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A system configuration may deliberately omit some CoreSight devices.
> Keep generic configuration enablement as a successful no-op for
> nonparticipants, but exclude ETM sources without the selected
> configuration before allocating an AUX session.
>=20
> Add a setup-only query while the configuration is globally activated,
> checking device registration and per-device availability under the
> manager mutex. Use the existing path-building failure handling to remove
> unsupported CPUs and fail setup if no usable source remains.
>=20
> Suggested-by: Mike Leach <mike.leach@arm.com>
> Assisted-by: Devmate:GPT-6.1-Sol
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795196854.gi=
t.aaupov@fb.com?part=3D3

