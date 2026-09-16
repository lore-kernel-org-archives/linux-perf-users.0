Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAE3ACF17
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523017; cv=none; b=j/UK5KcZtY36IX+6KsWrAhmbppD/bDv/crnqM9nKSGUWfp+ebS1WakgiDsF2fo3c4/j+GbLuRk6SfPe1wOPdevuhMNtluiIFVE/kdNLpqSYYK12J4bMmBBCiBT40R/K48Z2/l2k6re+S7QczLD+t3tzo5/QvVwswUYWRc+scKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523017; c=relaxed/simple;
	bh=z6T/3zDuFB/smNXMMWL5fHyBx2+xTPuMrFR4Mms6v5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kProgPKOFm0LHR+thQ3jW0Z5UkBA5pRtPhovsVISWMEMSK8hsTqFDUsGCUwyHNJZoEHLYLds/ZljJg3239HqPQvANhz4ODTDRV4n9XqwQo5ElTSPC60+ch/zf74DCnAO0oRmd8up43DwA14jyU0AC1/72yB52XVZh94EMHQ455Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE/UQ0vP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE/UQ0vP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21FC1F00893;
	Wed, 16 Sep 2026 01:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523011;
	bh=C7T8E38sSMC4zvw0EMEV4Rd1IIaAeyhPVdlLWS9q1co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IE/UQ0vPBQSrki7gPFpY3YRhRWoPaBhzTLeACveuKrbsdmvaw7e7DpcjjMDNLl0uv
	 ZrutXnlbCeR3Hs9D3ORDM2eq4nNBQavo9RI61xpLRI/O9roql+IhAyEUB1h6QX2NU6
	 8KyHCB6HNF02c+ZakRuJPnlx0x4/mJkvhK45kD09AEjRz2sVam7wmVUb23taOZHPiJ
	 jVx4xBBcl3Ft9m0UaZVxDKQMu//9reYeq/7GC2vEW5afma3hU3gAFzsNIZgmaMw37X
	 vqm6+QgJuG85oJ0l3WtwTty/bGwdXiFLpH/yWo6moqkQIlbMYa8rJFQ8kDVyk0Z/oT
	 tpqVLMZ+ImE4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/26] perf annotate-arm64: Enable instruction
 tracking support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c6c920ced23d0292b2de141070b1d9727701318a.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <c6c920ced23d0292b2de141070b1d9727701318a.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:43:30 +0000
Message-Id: <20260916014330.D21FC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable basic instruction tracking for arm64 by implementing three
> essential functions in the find_data_type_block() call path:
>=20
>   find_data_type_block
>     -> arch_supports_insn_tracking  (1)
>     -> find_data_type_insn
>          -> init_type_state         (2)
>          -> update_var_state
>          -> update_insn_state       (3)
>=20
> Changes:
>=20
> * arch_supports_insn_tracking(): add arm64 to the list of supported
>   architectures, allowing find_data_type_block() to proceed with data
>   type analysis.
>=20
> * init_type_state(): correctly identify ret_reg, stack_reg, and
>   caller-saved registers for arm64 during type state initialization.
>=20
> * update_insn_state(): add the update_insn_state_arm64() callback with
>   conservative register invalidation for call instructions and those with
>   destination register(s), preventing stale type propagation. Full
>   instruction-level analysis support will be added incrementally in
>   later patches.
>=20
> With these changes, arm64 gains support for basic variable type
> inference during instruction tracking.
>=20
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D13

