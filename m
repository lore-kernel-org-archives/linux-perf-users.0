Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693816;
	b=qoTnC90mmFEjZeCVKUQOxeqYUh7/tCh5NmAWppLxg5XtPEWm7afhZSJ3rJEFldn5J7Eq
	 omprR8OTUdGuj+cRZV15y6ttcGm/4/ICg0NOcDBeI21zSnYOlxdjob7ifMit7ApgP4t5W
	 mTP3aNOpLdhWY2Ri5yMg1AuX1CnD3zxPB7fjPJkkPr682tbzJ5UCcZZNxbzhAKk8XZoyQ
	 VbpbZvgM42hJcMPOx5/uXZCvxGS20yOXAUar0WYlcwinsBCIO5ph9t423R99ipKzyn0w/
	 9rCfyjRr4l2zzht/PP/xkOubG5Pvc4zDTJgyIcpXbRM0cMg78bozPxGr6FQPBZPgbIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6qg0kkSyS0O5zEsXNxgqzu45FY2FzQ7wuxbC29pK+lg=;
	b=MJjE97r5VOJpeQMVJkREdB9CEgy1RLsw4lhmMnknJR61KvNPMuq7JFmTAtmZl7CBakY9
	 maXqK7BLgfyDVMqm6Ea7Xo0LNvnXb00YVBwG3GdCYSqJq3qhtBx39CO5+7/KAfeGPmVA1
	 utr1Fl66tjmLWi62fEOPWLq0YLEg8X8P4Hwqb7rTO1m0iR7ZhhHem4OvcQJmojwLcZ5Ir
	 5iebCYygh/7FtEnEzj9VqwYetrtjB/XFlqdjLOP5vmKQgA4WFbs+AkQHEsvXebKMxDoku
	 XZP1eYUxBlT58Ii4UsQ4WoXc5Gbd1I1uvg7eZCEc4SIxs3eVxlYgvWMIV95E3Az4VwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuElRmUa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A9606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuElRmUa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3431F01825;
	Thu, 22 Oct 2026 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693816;
	bh=6qg0kkSyS0O5zEsXNxgqzu45FY2FzQ7wuxbC29pK+lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuElRmUaIzq1AvZCrJKQ2nC9BqrST1m2siTRa0SZYb5Ck7wRi8nssXKQcUYdc0ewo
	 uCQgouHlDOhjBNxhFfmU07fwiTHOVcJAqZo7tRYIc15to6nTSCVLsglU3PAMnMI5vk
	 uniZiVWi+QxQ13CSUbQyWrdhGDRFWntjbhxI1BcvBlQvdQrhO0sPNaTS6ZYPzlAWNO
	 tGoeJ7LkU1rlnISFHaRxqJTrvReOdxWOBVv/rrUUJ0CK57igN2p9YUafqJYNIRCDOS
	 S2RT/dBcimPL/sBz3+qDePCn9KKGIGR7F5l29orRrQrXayAJWyu2P8EG/HYTQxwcE5
	 +FwFUEh3lqlQQ==
Message-ID: <sashiko-outbox-181920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] tools headers: Sync linux/socket.h with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-6-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:30:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   be3a5e06b962 ("net: add SO_PASSPIDFD_THREAD to get a thread-specific SC=
M_PIDFD")
>   5bd369c05576 ("net: Add connect_socket() helper")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/=
socket.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Acked-by: Mahe Tardy <mahe.tardy@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D5

