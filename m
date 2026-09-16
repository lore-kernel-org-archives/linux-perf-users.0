Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FE3B42E1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523102; cv=none; b=mUsevVtZtHKhJXMnt3ZxkFBHyAZBcgnnY0bywHHwzolf5oylHmYzQXv8wjhi5lm6eR1PNjhyQaqKO+iC+zpJCVMb3rrzebAwfuKwVABLHJK86Remys6/+B5sCDI8asOJM33rL+81VC1sTHraVj08SXVkyLK5ztqNxBP2G2PFnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523102; c=relaxed/simple;
	bh=A5pXNB3J76xKaHpQ7jWfDaPyVWJ84BUezcfBjc/AR+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZPEt50xTCqAEexbOigSdRptau3GPVUf7aSZvzudB+63OaI0rOhwUMwqA6qwi32NVw+Vtnjbvo/P1dAivhF5G9Rw7HXN340XSPTijeOiQNTXNl9VXFPXvgMzyxXaH/UQvlt4K3SbAnJReL5FiVepj5YZ45uccxTTOvpxGOoWwshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhghXDm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhghXDm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADCD1F000FF;
	Wed, 16 Sep 2026 01:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523088;
	bh=31mUzI+NI3PSZ4/P1Tc10Dl309Tl6zbDPtNfjzB+dLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RhghXDm/rSBpF/3ux8W3AjVOT4aUdO659DO3o42Ceg3ZNb3qdOvq8K2+Uk8LHNC8K
	 PObF9LOLcuFf00TQQGd6Wu5BcZt3e5IhOMfGsFk2grbqDBc6aKedWhY85ChJvfn4pS
	 TMsfxCYxlSSvkR1TtqEsdVkpC5YrTShUVivM6B/9R6kNYfTPFf08EmLqZVhCg4Ni5k
	 BTXIDUy3ucPq6R+RJQjAu66022Sn1zI6lb5LiZupY8MLbL55hvXjHsOlNBVSn2BLjR
	 3N4tcEt+943Dh6g9f8H34sq9ZXzP6hqC/Isht9TIjxANTtgDLDTvTD9IdAWTza1+d6
	 FIe+qWrR57Q9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/26] perf annotate-arm64: Support 'add' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8bee20cb7054ce8d0b1cfa064a4d62d0a1b29d42.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <8bee20cb7054ce8d0b1cfa064a4d62d0a1b29d42.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:44:47 +0000
Message-Id: <20260916014447.EADCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to track 'add' instructions for
> structure member address calculation.
>=20
> Unlike x86, the arm64 'add' instruction has an extra base register among
> its source operands. Therefore, in terms of propagating the data type,
> it is essentially performing a 'mov', except that before the 'mov', it
> first needs to be updated by adding the offset or reg2.
>=20
> A real-world example is shown below:
>=20
>   ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
>   ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 =
-> x19
> * ffff80008001c9d0:  ldr  x0, [x19]
>=20
> Before this commit, the type flow broke at the 'add' instruction,
> leaving the subsequent load with no type information:
>=20
>   chk [28] reg19 offset=3D0 ok=3D0 kind=3D0 cfa : no type information
>   final result: no type information
>=20
> After this commit, the tracker correctly follows the member address
> calculation:
>=20
>   var [0] reg0 offset 0 type=3D'struct task_struct*'
>   add [1c] address of 0xeb8(reg0) -> reg19 type=3D'struct task_struct*'
>   chk [28] reg19 offset=3D0 ok=3D1 kind=3D1 (struct task_struct*) : Good!
>   found by insn track: 0(reg19) type-offset=3D0xeb8
>   final result: type=3D'struct task_struct'
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D23

