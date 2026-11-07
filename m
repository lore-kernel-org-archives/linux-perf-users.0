Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048912;
	b=G2tl/BzeZdhIs/9dNV61luR2JD7dU1g2yyqvp404j39YRAQhF6Z8HTKSEi7RjCzX/vCS
	 W+kjhsrxuxyzBRwODOHXs76LFDAUOKsqX9MZIFiFKj4qJks05pNRye2IZjg1FSk5Ske5X
	 DdpfaFgEKCCY5EjUfVTC1Ltg5LLyDkL2HqxWjWsB6dYuPhXObbHdWTaTgQdH1/5gwnCNR
	 21B+/t8CkLE8ldUXFLYv1qfHAUkmnqDpEz3rHfVsjF3zbvo/r4/DzOzDOF26sAUPPIV3K
	 U74i4aQR7FBOAGW57mw5CKQE32Vo783STFv/RtXSTDP27Sa+dKPrXihmOIshDbtD4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l9qiVzcDh2Ek0uMBj9gWzMXKWAZLps8MzyJSeqnEmJc=;
	b=OQ+QVqNKPFBXgICfjCsKOimva+uTYRkS2Az1a5VI9MjiD70wHkcxrcMFOVks5HZ/y3o+
	 429ReWyp4RnKou1tiWgiOExtbivgzEfJu6LdfXgyyFAkZCaScvsEs9jte2pTpbneMueuw
	 oVwEpZuU1wyTU5VSXQU2AZjZkTQ+cFTHRd9HBjFFvp7Gc5wa6elJ6L5LoJAg1DiaHBMd/
	 G8sea8HpOTE0rX7fJS1AqBwR2tBSfg3hh89DpwDZR1wdPQ7LVCC8ky9+1Az9lmTtPRqLh
	 JyE4YAaaGTK+FFinUmT4Fl9ii0Qv7W5wfLY1hxU5LLaUNT+0KHLhZzJNwuw34FkqS3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsvjGUx5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCCF606A32E
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsvjGUx5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F56E1F0089F;
	Sat,  7 Nov 2026 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048912;
	bh=l9qiVzcDh2Ek0uMBj9gWzMXKWAZLps8MzyJSeqnEmJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsvjGUx5l2JuWfc6o1ep1P6Pd9MEBqyWqb3VptFv88vLNdUD77zAq4gOzyR+7/KcZ
	 L0WdzmYUvkk0k9zwxApHg0UUboLfQUQJpkQDOL871cuwqef/KgM95uztzVlo6WoPHl
	 5S1uOpjpS6bZ2+ofXuUNSBl0A4euh8ZCvHDP1zXtLfYAFDQRL6TXDhoe7okfiCcOvf
	 mA2YQAE3TcTaESU6FgWkMIVhi95c1FapNfTsEGjGCTuAuiWQdZlNGP8v/z2kZk0WFK
	 m2WNzxbH0F9Nn1ADViW9bgYzeA347acDMqgC8z+o02YANdez4NXf+6mwUnOg58lPqo
	 qy+y6xg63jCSQ==
Message-ID: <sashiko-outbox-202831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] arm64: dts: apple: t604x: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-13-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-13-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:55:11 +0000
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
> Adds the PMU nodes to all t604x devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D13

