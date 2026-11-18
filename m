Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020275;
	b=vxlq5GpKoMuCptr5vcz2lBHLYjYnLpOZ0Dx1v+l9uL3bAJdJwpaHvX8kMFshkG5ZIMmH
	 esgEu1+IUDBSJrcIRp+tcOF1cYu2Bt40imSv3zsswyyqKdNAp+K14oEUqdyIKz6r/mBz6
	 Nrk1tLGweqp5iu7xcyOuGJI9iG9SgyZ2aE07fRkznjIRirEfLQNC0ifV6nvCCiSfIWOau
	 JdjRNROuNRLD4wtFrBLgMgcpKOG6uA+H/V23PZ/quROHvjdrNBhxNa3w6DvDku1uImtLv
	 i+33MbfByZftlu0KUDz6D2D/aJaPymoV8mB6bhkSDEcS9i0GgsRFzYmYCnuYiJwj5Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q3rCMAyaLi2Bm/Xzp5eR+S4xx9TcGrceJ31yIEPsUPk=;
	b=Y6d7bpsFrOH1rAsVCy+nnIrKvQPDE9lPihYGlpAAYz0rbiPUjMeoFhQrQ7dpohY+Mins
	 1gQd8tEPCslYgQvIVUREBBi8t5u+rfojEkzN4keIp4z33WQiB+24Ba2mSu03PzGop/bPu
	 KoJxwD8uByXseEe/O0VtNsSVinkVc6aj8PIXp3uP9wrqnCII1k9oj59quRzqFTRi9tdCW
	 A91JklASR0qW7Hsg9/BCj8cCO8Y6P85989CCRYnwyXes/lMEXhoHFk5VZId6Y7iwTyQ96
	 3k2L1B6pXQsov1SzQzMY1BCgbbMDz1sKCf+0/k1bP1h01GJH5wK3A06ZFTX3onrWEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXhMEjBZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EB606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXhMEjBZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED101F000C6;
	Wed, 18 Nov 2026 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020275;
	bh=q3rCMAyaLi2Bm/Xzp5eR+S4xx9TcGrceJ31yIEPsUPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXhMEjBZI3DO20aph8+fRP8tJR0gcoQYtTnih9god+d3/anKfv08eN4Y8R15SMXB2
	 LFUVd9hmoaOO/Lkfoc5XADuM2UqVMYqkj1J1ZSfSzmICDBGUiplRN0RiokEpz7UKAX
	 zQxj3alJh9YgV0T8fdHvn7enNt/PQVU2WRgEQzdmaBgVLiKEwLnzJjxy7WY2RNj2Ak
	 dzmq87wRA9WIiE4XHRsn8i5TgK19z9BvKYGZb0ghGn7jhXsnSHjzyTS1fVNX4k/2s9
	 wAjV4QMpvaJMU1ENbBc966WmT3gfQk9L/VDu4s1etHokylGw9OjjD28ut27gS2GKgt
	 lzS7V05XBi9CQ==
Message-ID: <sashiko-outbox-221541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/34] perf cs-etm: Remove old pipe mode support
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-10-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-10-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:44:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Pipe mode hasn't been supported since we added several peeks to
> cs_etm__process_auxtrace_info_full() that require random access. Even if
> it was supported, we would have to buffer the whole file anyway to make
> fully ordered decoding work. You don't know if one core stopped tracing
> for good or whether to wait till very end of the file for the next one.
> IntelPT has the same issue, see 'perf-intel-pt.txt#Pipe mode'.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D10

