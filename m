Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622760;
	b=ibX9+U98m3pPxLEcXwlIgr4UjjwEJ3TSGdyY1ZBSCTNsnpj5rikTiyidcfsi+2YPTkgv
	 2VTW/9nFJzqHGpcZJ+yo4IFEHP+pZTCE5/TSuHPRvdC57I+a6KNdcpJCHbg4coyVIpv1y
	 fjVhYiL9LSYAGZBK0kRB7R+kVkgJjjvZgjAtRnqLXmLA39QViz1VVuRnMXCCJBRgUCzDz
	 064JwteqEwgT0WwrcHWUd7I4n12r1z3SxSIG+BnQc2x1ccPEows5QHKK0tMWlWYX818pz
	 u0p0zx2K/G9V8hl9kN6D11fTsvdo1/qZNzIyy9oF2x4leKgLIuf9bE+buJHKQ4E2U1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622760;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G0/j86GDbjYVs69Qghcpkngw6QJcutXyjkkptA+dHMY=;
	b=E5slw9mt/40DoDe8SO1Oy9vdyVE4PZVII3rqoK2w5XAzESY9UULg+yQ30bjT7Bo6QXri
	 VPZxPd1TnIiHDO1Z8lxOvrMLryGfwijQf03oz8I7jOrBCxsKfzDRsSFXJgG23zPizy+TZ
	 EYZB6cHiR3iiXgKBI5BzkTHRilPIoXuoG5GrPPFTJmoc3I96sdUHZza8XEIWkz8DjK0Ds
	 OCK8aFVg7aaEoNCSaC72TOU8PLFNmnOVZD80FF7D+UmOmbAHyoYo9M8luo1vNQXm6+ANv
	 JCdBXx/RTauZPI9O8FkboAW0n4aurokPaHcqio6HMqq8AsHqzDOuaLI7oItBB1qhcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzzIlnaK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A404606A337
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzzIlnaK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB18C1F00A1A;
	Mon,  2 Nov 2026 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622759;
	bh=G0/j86GDbjYVs69Qghcpkngw6QJcutXyjkkptA+dHMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzzIlnaKgO2OwrRJJm4xGmJNaiHfdtJEYj7AXKfgkJbOAEQ6Kxj7/kaFCdVpnSBNX
	 vtqI3VVRbb/2IeUwKadUsk+EmRlxcpMub3Y8C8GiyPqXOMZ+s9HncNz5T8jBRjTT00
	 PxmPj7q7sEXsXNYUjy8Va/4wJTBYJW3/X03zFiN9o9zPubEBMZUKl9UbX1MqklXTGF
	 nnOQMcDbsw5RBTRqX2iV++X9FnqdfL39i7tw7DEdtmrTMiJgDg4m2RbKv9vzzo5s5h
	 knN9M+RNo04Easp2X2B/buZ9/fqPKq1rPB5DAwOLV46NllOVHWIz3PyQQ6IRR3Vgf2
	 2Rw/fN+0BCybw==
Message-ID: <sashiko-outbox-193417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/18] perf test: cs-etm: Add test for per-thread
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-17-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-17-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:32:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Test that per-thread mode works when the process migrates across CPUs
> and that the decode happens in the correct order.
>=20
> A TODO is left in for when support for decoding in order with Perf
> records is added.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D17

