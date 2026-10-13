Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA2332EC5
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899146; cv=none; b=UwZuKhtU/D481gccAqm8RuKgyqo1pXDCU7u7dqDIrSt0QOiRmoNdqIAF6QMHw47F3DN8KF6cFzmg0zQ+Xo0LkBjygIvSo1hg9CuKI6SVp53mKF7o2IIyvWeDuT6iVgyA40Vr25vANHuyUR7Yv1uIVx/e14sUV5whA7hw9bpc/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899146; c=relaxed/simple;
	bh=KCYPgDZ76F64zPKC1tU5Ebu6JMi6o/3ZiuOEtCFwESY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EUKWCsy8bOwp4xpMoQ5IHO9ApVjXcrFR4WVtO3NTLJIGywKmwmoGCL70SH4BeqgPsiIp3lkdKgIEYxVXs67wfp6iuNoUhCkYa73vcyzTgBFaenIsbNjeav8LFAGEqJMQZRDjZe5huQw2JzTQP5s/cEYY5OS7TVdZxUoJA5hz96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWpcybmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWpcybmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED51F000FF;
	Tue, 13 Oct 2026 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899145;
	bh=F74pSQv2x5kGaS/PDFi9ArG9rmMx+Kf2Evl5glFfumY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lWpcybmjY7nDwiIrIQZNHrs6hFu3SYJWaxKtxqej7MsLmwTVwTciLoH5qX5AixvGN
	 BbkVFg00jLPmLwJOwXTmmuXThfuw/TMfc0Crr3Z5MjPAxCeVWpIrrsPp+wXD6TNvWr
	 lyxKmo576FmTnakNmBdWtQ/16TtEfzKbsp7Cu3IYlFy8NjQFo+JswNbrqkh53hb72K
	 5m1Ww7ngBV+BosfWWDjlbyZdoaqMt4eRWK2pwI8G0E6uM6HLvSv5X4x2Z0GkMPlJS+
	 yUBcuAJ1FiAAbxUkaXTk8bZ9LPnX4SGMKt10ELfU4mRvgrivt+glEhXImXVSheHcLC
	 pv5fOH+kHOEwA==
Message-ID: <sashiko-outbox-169859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/15] perf annotate-arm64: Support 'mov' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9e8a4f59ac1750e136795fbd58aa6613dab30f93.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <9e8a4f59ac1750e136795fbd58aa6613dab30f93.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:45:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to support register-to-register and
> immediate-to-register 'mov' instructions.
>=20
> For register-to-register 'mov' (e.g., mov dreg, sreg), propagate data type
> information from the source register to the destination register.
>=20
> For immediate-to-register 'mov' (e.g., mov dreg, #imm), store the immedia=
te
> value in the destination register's imm_value field and set its kind to
> TSR_KIND_CONST, allowing subsequent instructions to resolve it as a
> constant.
>=20
> A real-world example is shown below:
>=20
>   ffff8000803eebf8 <get_vma_policy>:
>   ffff8000803eec20:  mov  x21, x0          // x0 (struct vm_area_struct*)=
 -> x21
> [ ... ]
>   found by insn track: 0x98(reg21) type-offset=3D0x98
>   final result:  type=3D'struct vm_area_struct' size=3D0xb0
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D11

