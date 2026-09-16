Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC13A16BC
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522701; cv=none; b=e54gcL955GRYnuK1ZAxrimoLrvSS48d1IFQqLDhg+DseERzb0IyrAFFG+LPwJ1/oJrQ9rap1FklPJp5G4+dTDeq0bRHLwnn1jiOvAbbIKegnPjn4Lp+4eVURasSMoH6hQa7KJ+0xrf1wdf9GcXW/C5mBp0DhyHN/3M8S99N3xa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522701; c=relaxed/simple;
	bh=Tc+Is1AV1ue2/AerwexegG0Qz0CDZ5uAcib6w79c3T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rgR7gQqDUkK9qLIdbGbnIOFNM1IU/yu0AUpTw3HY6Nh9d+IpAi2mJ6pyAL1/y4jjLa9yHnpbBpv1uXk7Hsl2RIEIIlWTBl4AQC2ehRtzEquntRjfUk3VVH+/ITSRkeR0L3ixwyn/GqrzjEDC08lRWaceTdkDtYxAJXvsJ61oADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE3IqRJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE3IqRJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6911A1F000FF;
	Wed, 16 Sep 2026 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522691;
	bh=Cv7zazTEoKbCt4iy01s8CXNezPlnvcTyFdhB3YBX7G4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YE3IqRJ5QvU5mMcwR8a8vHPW0cmkzbliw8VjUapKPvN8v5UsFSxBgsQoGhbMHfUJS
	 MbNkqAytmQeRfj/aMwhe1IPJtmLWk9UK/JO/DUFMWzJieWZy/C/ww72tgjS49kqygF
	 yfLp85PM+Ejb6jJNa13h/V+qQcyWIvsaebG+N8d4QCgA9icPaas8JHXC8IYT34ef5Y
	 IgaJC/zt9nY2H0P0VVyHShbp5sjOnLWkaLN8wQczdTms2Npd/k6IsTe0CuD9ozeg/I
	 V1DsIUxneOj1JYPtZRqswetBhlj0c+Kmf3p7BT4gROeGyyJdtuOBSHi+c/km8mYkeE
	 0SZKzK4T/twDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/26] perf arm-spe: Set default synthesized event
 period to 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <40acb41b77fcb4aef1efe720c651563043800ff3.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <40acb41b77fcb4aef1efe720c651563043800ff3.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:38:11 +0000
Message-Id: <20260916013811.6911A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When using --itrace=3DM for data type profiling on arm64, the 'Percent'
> values in perf annotate output are all zero:
>=20
> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples=
):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  Percent     offset       size  field
>     0.00          0       0x10  struct mmu_gather_batch  {
>     0.00          0        0x8      struct mmu_gather_batch*    next;
>     0.00        0x8        0x4      unsigned int        nr;
>     0.00        0xc        0x4      unsigned int        max;
>     0.00       0x10          0      struct encoded_page*[]      encoded_p=
ages;
>                                 };
>=20
> However, adding the -n option (show-nr-samples) reveals non-zero sample c=
ounts:
>=20
> [ ... ]
>     0.00        0xc        0x4      unsigned int        max;
>     0.00       0x10          0      struct encoded_page*[]      encoded_p=
ages;
>                                 };
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D11

