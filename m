Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622270;
	b=aUR8i3Ux9FwdYr7Uhtowu/veEuOUL6lKutqX+IZx5fbPGpIM9VXd2R8lXUT6oNQA0WDG
	 0hr0EUF2BJikcDqful+MBLY871hb9sTyWl7QNeZZ4jSidCoGcxPQqOxQmEUlFdH0mRcYD
	 K7A6HV8VlM2xguvQf32fULMzIC+DsRA1ZRkxqFasZk8Gkw6HRSd81ldLxaM17lPTlUWU8
	 pDXS6/4Z0AnEfNHLJq/jPJ+cwuPcMAs9kHEDv7il6y89jKXDf5g6D/H/+2zyYhBZ+O/0m
	 GmD93rxg2Ry+HsKSuae6X2oApBgyIAcSrdFIbJKUPsxg8htSbHN4bN6Ws1ZIcg7Laug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KmAm85AQs42DKVHkWyng0+fVi5BWJVZKVhDCrr9Fd8I=;
	b=dwq7+q1bzGIKm81Ea5tueYXQvHdM27M2zBhDy3o2e8WsoJg49OJzlJBKg8Uf/jIeVhVA
	 WjNN8ykCTX0AjySYM7cltDtG96C2ykbCWPE2IJkE6EOyvGlW3dTWuuQWXrCylecUkOx8e
	 Cl6xBXL6DCPacXXprX72+9fP5KUxDL2GIZ6nFje0NrtodO6aoICXrVso6tFLDy04TRU4T
	 h+lVZy4nio2M7Y4vi/wdJ0rvRiNtmoDoYFwY49xryP8JPABzpZmUVRjrkvuoXhU4c4iAD
	 azyV4t6E2Uk82orWk59Cn5CRPjtmzF8Plv2X1veDXIkECNuIrMfeocrf8piwYluorvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4C7jCpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581C606AA15
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4C7jCpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A271F00A16;
	Mon,  2 Nov 2026 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622269;
	bh=KmAm85AQs42DKVHkWyng0+fVi5BWJVZKVhDCrr9Fd8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4C7jCpS8Yp/d0HvdKI990n16W204Woa8Ppkg5P1TdnvLh/a1C5a7eols1qR0fpC4
	 fp68Tsz0W7VZa+Jx79Ex/93od32dQ2dXSzhKH6tASECnmmedLSsRKsvc6tkNmUUlyV
	 wjUoDjrEUSMSiBpE2fNK96NDbDSDIhHnCIAdpPSjmx/Tl52lz+T+pdKqDhcxs3t6cg
	 0Rhy7zlPGP9wgtbpkpHRxnEVk7R5mITg6c06HStWBY7gBh7kISReu7NezTZqSWO2JP
	 DDCL6v2JklI6Zzj+A6i+seldUBGdKap6u8OWE9lryl28IiI5Y+Nm1Abf4Q1MSARIPi
	 OSAupXyZdlbXw==
Message-ID: <sashiko-outbox-193398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/18] perf test: cs-etm: Increase window size in
 disassembly test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-5-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-5-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:24:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When we increase the default timestamp interval in a later commit, less
> trace will be recorded. At the moment the amount of trace overflows the
> 64K buffer, so the exit snapshot trace is what happened at the end of
> the process rather than the beginning. With the new default interval,
> the entire execution will be contained in one buffer and the first few
> samples are always various instruction and data faults. These go to the
> kernel so don't result in ranges that can be disassembled.
>=20
> Increase the window to 6 samples to ensure something with a branch can
> be disassembled even with the fault samples.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D5

