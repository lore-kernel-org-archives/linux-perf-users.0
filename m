Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020014;
	b=ru+7Qog9ZPPAn0j6EhWDxYsb5/XTsfveKymD308xrAhgln836+qvHljMoW8omLuosz3H
	 qq5XsH6LTLHNyoft0/5GbOd6eygCoq5VzH+U4o7vzXMVKVYCmvYBnNPatNSRPNDwcfmyR
	 iP/pCVIYvciyw/+21OKhK1u+NvOQg84q8nET4qKODW4qrBVpCbCpBXPELH9/t9Nmf8XsX
	 tOCz2uW0OZ0fcvaJboeaFRn2ihMcK1SD9JO/+IyFoohT6eB2ayrrmq2SqCPuYNfpDh86n
	 JARCBCKkqUbE7NPFSMxSfzZXrZvmSydNlUgOt8aCFYupwf56qBjaQeVA3ikzQ/hCJTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QvRW4OtEn8gmQHuqIJu0ICfPptzBtkV7nM4mwRr2XcQ=;
	b=ifpbeLpUv1njqvWmlWDqvDNCITZfnztbT2vKurnYSt4LecfIH/5ehlb8xOg2GOxORxHv
	 NXfvkuNZY0afTvcmCeI7mwx/RijqolSbAVnLCPj47JsKPsRGWENok6JCuhy0sonte+WGr
	 AZ98hi1pLal65aXaVVPzSF2r4rbVJpfCYfkhRktrRR2mG4aHE8/UOfWtR/oEwohvxuWBs
	 EQjFxWo+F7h57PLtgaRiI8+joT7GGwQkLYhWdThoaT+LhiOltC5ZpVvja3MKZi17pz/wA
	 Kkx8x55vt8qC/4WdZ/x2grjgCn3RJvwBJONAOgoPCPwjmEXwh3ryiujC9ouFogmbkew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn1DQBwd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473B606A33A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn1DQBwd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66131F000C4;
	Wed, 18 Nov 2026 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020013;
	bh=QvRW4OtEn8gmQHuqIJu0ICfPptzBtkV7nM4mwRr2XcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vn1DQBwdiCAXwIqqai50gbqVsn+4bfHeVzcmLxgEWI8pG7L8V5C0yDeoEmm9DkSli
	 jIoaCvw7dbERXV5/PiUjcNiaofvoWiGF9gWRe+RWMkApFW0DykTnRI/zno4UCtKcqD
	 NZFc5k/3pbXRR0waNFjaov5cZdafSS3bZPYA+/kxEXA3rX2WQPL19jWE0Ieht19SZS
	 2JUj4lgcHAzbDx4B4oww6/TWFnJtm+wwlV5nGIZ+/J7LccK4cwz5BmYkKUFrE+5LDO
	 Bd6yXVB1Tg1hM+X/mLoqzhkJU0zx8mFZJ5F+eDWll6VMADuQN9YckC9dSuoG3ML9Nw
	 JqWTJiCyUlqdA==
Message-ID: <sashiko-outbox-221522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/34] perf cs-etm: Always enable Perf event timestamps
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-14-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-14-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> We still need MMAP timestamps in per-thread mode for overlapping mmaps,
> so always enable them. Also update the comment above to reflect the fact
> that Coresight timestamps are on by default, -T just gives more frequent
> ones.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D14

