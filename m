Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809805;
	b=vKnwrEDQYT1Ep5r1JRKN3T032DQ8ZYsHv5a68cdV4OE4Do4PaZu9P6iD7wORb2sZxSdc
	 azSCoF3orDHujpiJsKzy0ZVQnqoPZC4RKLYHahIQTPRdwsNAsw2y0XnXXH+qskSs3MXPT
	 8IfpBbS7EOs1jnudzWcUynY3G3VherKX//x1MZbmdB46uTh0Bv1pyCgTqwGi9PpDdHyPX
	 XsP1A5/TJTqnK04Q1vDEaiq608owiImGUt/hxutOPHW5de9SiH896X4h3KmWsWfbI3gAE
	 nPM43UpitI79kaJ7Limyop4J1XMxA84PdpnJtNEgAcRn/8d0Ckpyh67kVyrwXIm24yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K+TJpyJLEc64pR1y3sjNY6eI5Fuf0yN+RZihnwp26U0=;
	b=VOnLs5v/QTa1Jhau7yl4ecWDRgJPmqweCHbQDVJcEF/c4jCXY9XJ8C8ff2npz4Z+G5A/
	 EF3QXUaFe12hdofvd/pg+TCRYMYpANxx2d8y9ZaIjvnu9phZssgdL8ln0E+GzpdHA+kz/
	 UiBrAJzmgs8LJ1N6HSFN7HFUbIMoT0E51JvOTci5VBYZdZ/CTixDx/eQddlmbK4bVzPk7
	 lDV3dt6o+EXphgEo1SVFBGByWXloXZKipb01bNBHfpt+aYYXCcJf6VRvGnaqudzdy0sTe
	 l+q83wrcxJ/ifni2MVMYLukyxvMMkMC/cKzGH+4nrkV7ofpb2gBO7GroFJzmlw32x1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KMyM/eXm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB4606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMyM/eXm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252FA1F000C4;
	Mon, 16 Nov 2026 06:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809805;
	bh=K+TJpyJLEc64pR1y3sjNY6eI5Fuf0yN+RZihnwp26U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KMyM/eXmGjjnpc2suEbpZiqtZXYUOzDy1Casy/YkX2A0emSs1wxMJCI7HWJcD0Hhn
	 Q8y3HE3c1nWvHu8lyKriwOQXgHDAo4pUzXDeyZhalnYBIx2fmVweH9wpC00WWK6HZq
	 xaGkD0Zu+CSNUlGI1d7uRjdV9+klT45RS8zVSLOpx/bwDnGjuaHDXhaORCJ7VUeJW1
	 CkshClBNSJydfreDgEIR5OYerq9pADn9FN7WhwR5rrjYBqpnZZaruxrqVbqCJciuMB
	 1CM8q30FiQBSKOWRZI8ZA6bcIrifTxdJ81L82qc35cvrYg8iw9V9gxEn/+Ob4uavZB
	 kd1h13VVeq4RQ==
Message-ID: <sashiko-outbox-216257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] perf tools: Scope mount namespace entry in
 dso__load()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-11-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-11-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:16:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enter the target mount namespace only for the specific binary types
> that need it in dso__load(), and use filename__read_build_id_ns() for
> BUILDID_DEBUGINFO lookup and in symbol-minimal's dso__load_sym() so it
> does not read the wrong build-id from the host filesystem.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D10

