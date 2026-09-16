Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EA376A0D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523172; cv=none; b=iIfwe84SfoqKwPCyGrqMVocB3KAh6R+YDVHjusCX678eOUdrvuv8PPZVdi/W2uRjqmzlpQP/CnOpvoUjBQRSmKkwvgBpvKDIPFocwUBQXff8gjtNhE4U5JUeSP2hN1isxC9/zaIJihORSAY6byb30e8KE62BVHhC2xu4nuARxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523172; c=relaxed/simple;
	bh=89QbWIWkXpMoufViOXgzstLRHbxBSKMJqSc4c4e8xIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kb70Yyr+3DyqBicq9fheGa1gRZf3qRvjbEnYio+HBTZnQXqFwZpHZWrRUjwgXUxBv1Ah/kGcnaT+NiLTQEXxViPDhzJwq2nKSgH4HzmND9hRZ5G1cz/et68kGXNTHUYA6ekptMqaQKzIPOW6bNKlV7Xvhit1g51+nnQo4G7K55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQReF/6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQReF/6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3F01F000FF;
	Wed, 16 Sep 2026 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523159;
	bh=TVxjP5+dLqPDsxkLSgnMQ964D2GepwTDtEBnmdgBgTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQReF/6MAzTLGGh5EkNDVsSQrEDbEpAVhrgGDwOK91Ph9b5pwjtKi5SBFAQI2wPBM
	 HHfd4jnKSdoR4Yq6ygxhy+ntBPOqwt56nxOZzuiUhV6RqB2ZGpiTRrMxEf2mM5sdMK
	 tLhD11dDIHwgInqEL/ebKuwNzH/SLwzSXmln8JwZ3WjsIdlHLbNBeVWP+a/Txz2Bgd
	 ZTvQBqp0rIig46f8Jt1wjTbh4U/qDJPRIPybY8rwyUlg14WgGveMoho+WP4kqcH5oa
	 IUh5qWJdvd8A2hi2erhaRK8fJbRIqzjrHMqLV/6g56Gcswy8MF41fmchPRLG3Y9DMk
	 knqJypMTuSItA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/26] perf annotate-arm64: Support 'mov' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7ce94ff2b32c4a6b06a79031bc5c825fb563c12f.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <7ce94ff2b32c4a6b06a79031bc5c825fb563c12f.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:45:58 +0000
Message-Id: <20260916014559.5E3F01F000FF@smtp.kernel.org>
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
>   chk [9c] reg21 offset=3D0x98 ok=3D1 kind=3D1 (struct vm_area_struct*) :=
 Good!
>   found by insn track: 0x98(reg21) type-offset=3D0x98
>   final result:  type=3D'struct vm_area_struct' size=3D0xb0
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D22

