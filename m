Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384388;
	b=jY2NRTpVwWs8Zih3v6/cH4K7B6X1xSdek7P9agQGzFut+BAetUitgUGaEJPgmO3OEY/z
	 MXl6w5U8vPiCLRgYFq892JoJYGqqXcOpYEMQ9yCwxuTPhveYfGr2GCxlzfC5Lz+ZY59mz
	 qDixPD9V9FMN5Vwhh+Fe6DRo1wCC28nc0rm3RTiu5XxJ6Se+gntyVXei2zFYra87y/v7t
	 VYGyg5nncUh7I7X0OBa4Z9e0pdduPkBUchadvYQz08JYKjUNqQSlNGiScnFL86ewP+7uB
	 vwlUaosUDdyXTm3JZYWXfhGW8SbogxBunW5fKQUpUAfhndlQtiHwxhs9Q1rmBsJHScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qX9uVgBNoG4MfaUlTOrr6dAMuIAHhTgniV0LVAQkYe0=;
	b=fl+alZ7DDE9yCJOtHWMwXHDEYmEr5DZf43x3jNv8ThXOYJ+pf8XiARcN3qkaghLjQ2eP
	 65+/wFrKhcmkJmHzHi5oJoC4tcutYG4TdQaP8vKBTGah5xzQFPSQzHHc2pZQO1FK1hXno
	 g9/EeOESjoF1f0utOLAtQDUUKmhaWOKvEBWCXHaOdnqbGoRMlC+qSWyXnc6SHpASqnLC+
	 COZGUeoAZ7FA3r4+QOY9j9x6fMZMsTn1onQl6aZh0RDmHlS0NTZIONh5lm8AgMci3+BdZ
	 Ovc4hCEl0wLXOBKnRzIQWlP4ff0iOwkUOwNCSc/1ogOxrdSK52MVFYoW0hhfnFwnJ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CNPd/oOS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E560A2623
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNPd/oOS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33C81F00A0A;
	Wed, 11 Nov 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384387;
	bh=qX9uVgBNoG4MfaUlTOrr6dAMuIAHhTgniV0LVAQkYe0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CNPd/oOSwHmAwoS3QDX6raDTsDnIJruYhG4nAqUBH3q3+Ul9ijIZt93aN2YAtL9K1
	 Qt6nBcCUheg8SQY6LFqk9UddFVOKDQpfs4CueUV82xIweLmRY6cTrc/OfXZ7j5bpRo
	 1GJnJFRccIgqmRtvyrwwjXELvbF/2ycVB2sgw1xesU0KFrCwCi1P7HdjZMNq627ItM
	 H1s4vKRmbMms9lkEkzwauIG2oA7NZLeyZRzvyxd3w3kkdfIf3FjU4XaC1LSgk/Ecj8
	 C2+sySM5J/I053PyJHvFgua35iGuKRp+QRXpGbO+1iw7mUapI8YzeO2JR9E+/S7nXk
	 NhdDsleBi2mYA==
Message-ID: <sashiko-outbox-208567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] sched/rt: cpupri_find: Use cpumask_intersects where
 applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111075945.3930230-2-sshegde@linux.ibm.com>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111075945.3930230-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:06:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cpumask_any_and returns, usually the first cpu in the intersection
> of the two cpumasks. However, if the returned value is not used or
> only to check it against nr_cpu_ids, that implies whether the two
> cpumask have a bit in common. I.e cpumask_intersects.
>=20
> cpumask_any_and uses ffs on (addr1[idx] & addr2[idx]) whereas
> cpumask_intersects checks only (addr1[idx] & addr2[idx]).
>=20
> So replace such occurrences.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111075945.3930=
230-1-sshegde@linux.ibm.com?part=3D1

