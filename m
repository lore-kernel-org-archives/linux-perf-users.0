Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754394;
	b=Wqf+p8Uzn8ur23G8/RF6joOhpgNmkkbO9UbjAJRjaKglFBSvzeJq9SzG1L2U28+xhLG5
	 F7FuTCl+EGVgNTzYRGUsN9k+LnyDerj1SWxt+0Jwlbn01jxstiofbVezuL0rj/IO2Hlu7
	 6nnyyBX8NXwTTJ80ZE+/MklEEIMWi0WeiLqa+GevESp7ngJPLs5vu6PTNWsukJEmvbn2k
	 PWOIkJSwn5upLfrAhImPz/ioGEu01EYysXetJaSrpyeF6G9StHFSvYZl6xavfp1yJPihV
	 xY1rxzQL01X4L1T+kPlfO4MADMW4zpF21ocAIeHZSAZ2kdtlOQbDaxkgZSxnbvdDiTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754394;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EraADTqaX4cREKVoBxNPClGGc+iujzSAIHuiuleTva0=;
	b=LJOONlTGfL+X65k/jkJORgAuBY28/eZlxJ/bTiE4IB7BqyEwYbeXPR+aw8qJqVzjwa6u
	 uhP3eDx/4rUTbMcZlsI2FDosT6vyjbc1X7PDo6GaIIJtAC0Sb9cNBuHnlodn+vjF4BXFu
	 ukz+opb9Opb9vtoMjRupuW5L3K3SgwZweXr7AP8WGh5SAmyJ1pijJ1SeDCZyOwlZet69G
	 LcHSIcpclWUpE6Jy25Zc2HcMht3SZaCm4BLvAV9AhsGviaGUDM5D1JzErNTgAxr64mtd+
	 RxDdGqyobpgkD0PlNre3Ab51p+NMlqaWQTlWRei6D2vc8GNqD58btkMmOHNmTS7FH9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDtsb9jL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AB606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDtsb9jL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B118A1F000C1;
	Wed,  4 Nov 2026 01:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754393;
	bh=EraADTqaX4cREKVoBxNPClGGc+iujzSAIHuiuleTva0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dDtsb9jLghw7DT0IYE2ErGQO7EydzL4PIlLlxauxe6RXdet6DxCCcn+kWncsTXCCP
	 P/cLjQo9QakYSC9LAxe7yS+YxNwBJvDGQn+0mPNVX6K5xAInXZ0P4EGo3oRDCz92Hp
	 va6NYIMluK6D8N0DGORG9muZsZUWTbFdARQ1CSh/F9mV+hJ6E/jZKGuDohqJvpVj+d
	 1jLRSABu/kq0nrW8aOCo3PIY6CMNtiOIBpOQ9kMh7yYZup/+tPd949Xr52MgWbY3JE
	 5UAZGmQtoJmn3adkx5rK31trAzcY5vB41YYDdoKp4RhdgmXfcEAC2eQGHWB2I5ahOL
	 H2SwtnEXWMZag==
Message-ID: <sashiko-outbox-196344@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/41] perf pmu-events: Add e_machine to struct
 pmu_events_map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-8-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:06:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CPUID strings in the pmu-events mapfile.csv files have an
> architecture specific format, such as "GenuineIntel-6-55-[56789ABCDEF]"
> on x86 or a MIDR value like "0x00000000410fd0c0" on arm64. When perf is
> built with JEVENTS_ARCH=3Dall the tables of every architecture are
> present and map_for_cpu() compared the host's CPUID against all of
> them, even though only the host architecture's tables can match.
>=20
> Record the ELF machine of each architecture's CPUIDs in struct
> pmu_events_map, EM_NONE for the test and common tables, and have
> map_for_cpu() only consider tables for the host's ELF machine. The 32
> and 64-bit variants of x86 and PowerPC share tables.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D7

