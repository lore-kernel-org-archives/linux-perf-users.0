Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C238BF67
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307072; cv=none; b=LUHGJt6q64t4vq3/QU60CTvZmDOr2xlzAdEav+DDDf9JhKsEf7m3gpZ0Qy0BaXy1ooCb1uTnUbMIGykguOY54/drpjMjIMN/9EIj0UJhTCJmA0BlsowJjsr/itf77Jdn7ZEnSPG+GES7XNuOFf+uj5oMqcDWKMR1D6Pn0LNTZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307072; c=relaxed/simple;
	bh=dlpCCddLuH2iaU3A1oSlBZcs/zAruXz0wRF7fWFYkEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rtJ+h1n3+jVPYjoVejF/q/aLwI/RYEqjzDLwtv7C3WV2yt15QnmaQenHep2iN7EOwha1ckztsRRkG48Z/DKhVsvhQUVSMOqo94CVUim1xzmLi4cDfrm+OliJuZHZcQl/oXU0k6SZGRu6AatSSh6LPdakRLkg6p9kJVKvAMCj008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj4Ws48X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj4Ws48X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14011F000E9;
	Fri, 21 Aug 2026 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787307065;
	bh=dlpCCddLuH2iaU3A1oSlBZcs/zAruXz0wRF7fWFYkEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cj4Ws48Xqx3GHQmJOan4sU5njsiabZuyvJwYZ8hwDiBLtC5cq88r0kSHeWMMzA86g
	 ii5C5a3hV0CQMO/pd+Zb6GdhfmyCkxmcAs3tAGxxF2WJNFPZ3KOdcpNAz92fDL+AOC
	 KCNzoGYDqrt0mphqxa4y/8gInRxyilCgpCNX+TqaoB12pbC8tN0Tm3aDuscNX4OxhL
	 InjcWYqjfDq4DcEtFMSFb92Pqsv/PmZ8Tgf2oVNw+KfiEOfNq+l/7KO8r1452ekcVN
	 Hf3akDWhC7g2ywpRfmmQNwvgYTeCmvcMRIry6hLyqVBSLLFrLUxJS3zgO2iqWV+gAH
	 U2hc/2D9v+RtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] coresight: perf: Retry failed HW_ID writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-6-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-6-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:11:04 +0000
Message-Id: <20260821101104.C14011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Don't set the aux_hwid_done bit when writes fail so that it can be
> retried later if the ring buffer was full.
>=20
> Add a second attempt on stop in case this session only has one call
> to start. Otherwise there is no chance to retry and it isn't fixed by
> not setting aux_hwid_done.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-h=
w_id-output-failure-v1-0-9d532ddabcc3@linaro.org?part=3D6

