Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704451;
	b=OsbgDPJM5zkdU13ig869ouPGYRjbwfxKZ0rio+1VCVzr8rb3h8zBdlDyhivFxyO+o9HC
	 KX7bxUoasFrPLsmbwLHzdiH4UIby3Rbjyrg/WWrUbBf+PlkaBbtsSU2zn0QGA6BRocBSi
	 SptmKdvuL+I7TGWT6e+mak/6FHDcf89sfI8NJOjJ2AFQqmXnEkVHV3Q3X/yDjGtwfL/Ka
	 rIRNRfR3PEipn5FHJaFzZ2g7V8hHItXudpa4+7lNGA005JMLlDQFKZSesV+kb8p8+OP62
	 0kaqpmZCro8E/WRUXmaJFOvNZOnErbR22Ez2qRDRIejMHR/eDzPoWxpjTdm8KDfbyww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YzRzICTwnwDjcPemVKf5S8wi0crGsJpntxUMoAZOiSA=;
	b=JC3d9D96Eqnmi6NvtIjRtS4jGGF1Op8zWhq5UNoo+4MKr3JnFrjiKHskA2Jry1RB2Tfx
	 /HgLYiAESWh0wYhpUrG5QB3cy4bd7Pv19Bc7zkUuFnhJUYOhsXqeUJ6xmrsYLVhPMEWDG
	 qHwKK867JU+ocGmIHyPC46VOQlJdSeE7+4csbvu2ShV4FslcaTxsYNHpYfqCVnRT7UTgQ
	 CufjeKhg1eOfULCwOCFmCACFtCwcAQCsMvbJZZoCivkqtsZJTvgjn0JmZzhm4AwxtpfiA
	 bybuKfXqNElCmBRIZqNlqMZ8zLqmsgvyLXvD5gP9/8j2Pc3V1VyEKrfAcsOUp8esarA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbytpdmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD4606A33E
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbytpdmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88E91F000C1;
	Tue,  3 Nov 2026 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704451;
	bh=YzRzICTwnwDjcPemVKf5S8wi0crGsJpntxUMoAZOiSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbytpdmxtnlAY/MqG2F8jYya6L8yOoxsK3m5O1LK7Du5oVeDr0cIv6k6RJscoUyG2
	 /XSkJqPhEqVXPuBKM+YBXBin0aeUl0dfxLKXmjTiCne07dvdv3bpN+3wq3F0uumvqf
	 6P1bioFQi3RoEcwAUsP5MDoDvsIw5r3X8XR4eWb9f+v1mEX1tT2eLRFILwpHpMqJai
	 veD/2Nqg2z1S/CxSFBcLeCi4pthS/v1ar1ZoX7tPjoTsqqiL+TcMxHHMfTFRTFh1Ul
	 jZEp3zwDjBLHkby3hj0ZO5DDI+ISfDRNjgb9uQHUqAmgCMB0DRYLiTdHflXfKSCQm2
	 304hfxy4gwN8Q==
Message-ID: <sashiko-outbox-195126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] arm64: dts: apple: t8132: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-12-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-12-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:14:10 +0000
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
> Adds the PMU nodes to all t8132 devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D12

