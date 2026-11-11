Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384184;
	b=TzT5py4gZlQ4cQ8F5lpiXQhV8GTV5DUU3fufm4LxAZ/4jaWkdAjmHzGlwjrVPT4dTt5z
	 avBwA8ZD9Fx7LlklR5a5mFGKA35V1HSDym8/v4UQ0UMEY0/B3DS6Gq4TuoW1b3gn8yr0q
	 e4Vv7jgVaa9wLo1lJlhx7Ac7jK1H3qrnjo9ibNyPQehSGRNxBOGC/QLi0qlPB5Hq3P8QP
	 yt4O12QkjY100OuX92jzbVkIWSg+sO6DpHlmcp9eoCEi8r0GsryGaVn1f1jbXcuk2OaZI
	 pnUr0nfzLrGwvOaTzT9PJqdnSI0HU3Omvd5z0iXx5CG/u5Y/29KZa03jtlecLlurOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384184;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mHK41UdYKOvdp1SeMhXE4mlrGMLg3Ar3ZmU1ioTSmqA=;
	b=EafkI8tJLaETRqNM45zDLd0/Y9IGp9xnoQwxPXPWe9TVEYf6EdjRrUL0I9mX1Fnk79zN
	 pDUAvKNlqNX7BQR+eeHR5TpOFqempN4clzOXUAEhU6HyD8hBmEYllXEONG/frPr9e4HAA
	 EnHhbhzyIpZ5cKQvg4KVKtAbg65GnBLIeVq/Xt4fW6AC+kPpcV+PwrVgHhQ14Eey6vGha
	 B5bot2mmBV2sHTbN9l4w8CngSy1h+uobFtpbFOT+8VQHrgpRoPc/BhaDz/Z213qWDflqA
	 65jWDnpqexEVBLfcaDVyUnX4wd8zVrZnQM3Y0K9SeBLdLG9khws5C9r5Okzu4cPPo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUdyc0jM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B0606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUdyc0jM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952D1F00A05;
	Wed, 11 Nov 2026 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384184;
	bh=mHK41UdYKOvdp1SeMhXE4mlrGMLg3Ar3ZmU1ioTSmqA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oUdyc0jMBh/kjw+4iaIZXWMJWH4odQg9258KtkgCfu09Pl+m9p4IJGC3hzunt9Mpz
	 T+bzZKWn4KfkCSZvpUZ8A5eJ5kjOHv4tQow4ysXUakrtyRpbsDKh+yrZes6uHx6FCD
	 FPnpFGtAE7d4koou3rJO/PKgOWgt3pWjkBhTxaOqRla0ebst0LmoGSzM28tAJGsb7z
	 yXQqIUsOID0pQExgIxwSHnQK2QXf5vVAoA52o+wjPGXafsj0s69i5IVp3n1ByxcJDt
	 tkBKMtNFUDFvwFsON7OdeZNmB8tQ+E2CGdGRt7hPy6sZ5ufat/cfoRvgoJRegWPsgc
	 RMs8r2+Sr0EZg==
Message-ID: <sashiko-outbox-208559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] arch_topology: Use cpumask_intersects where
 applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111075945.3930230-6-sshegde@linux.ibm.com>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111075945.3930230-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:03:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Looping over one cpumask and checking if any bit is set in another
> cpumask is same as evaluating if two cpumasks intersects or not.
>=20
> So use cpumask_intersects instead. It is probably faster too.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111075945.3930=
230-1-sshegde@linux.ibm.com?part=3D5

