Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7D18CC13
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899222; cv=none; b=UA17rpiuvIALn97svRDZjIeQx5deQ7MxZOtRWJR1J39+50iqPefhkZuFP+lV1LAms0EyS43nKunpt4jKOUt2LPVL0mWVLDJR/gtwujUyXWn2Zr+r5HwuXesjRSQUueGwF1OtyprnzBnJFxOaaRcTJcQT3JiYiX7S3eJbXm//vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899222; c=relaxed/simple;
	bh=MlcJh6O4PoP+/p0rWQUk1w+EL1TmKn7n+oFo0lwLWdE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l8ON4kPRZJJDVjysqoB5dcRtzHxQipBztS1V1EroZUjZzc2aU0+lQPDdfV6x+9AomWdwHyUjG7aipdMriP7vJgB+URFFDLe0Gm11DG0CdUoEMuodCRBAk4X6Gf6Tz/Jm4fEg5LHZxIqozNdDmbWC2EGcQPWV0rhWamjQIw+iLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqhsTDLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqhsTDLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1121B1F000FF;
	Tue, 13 Oct 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899221;
	bh=OTp1Ex4klnsQaGJBtsH9/tHXzV37a5n5rmnLzdSi5Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqhsTDLgtcpaPAEP+M9gTpZum4YM1ec3ZiuitHiDG9nhu4KO/2Tn6BmP9lKQ7gTTA
	 DeLcm3VdiwPueeQShHyWBmiBXshpbGcg/Po7Irj2SC8h2fEHaIruhsQxemJ6j64ZU8
	 mOE+Jla2KzvY9vGwpKJ8goQdfPXB40Ey0M6PXW7bMOWSGe3VR0y43Yx0KkEzze9VsZ
	 KJuODFXXwoyuHk8wptiTXqkQ1miZ69DhIlQc+GicGyZvvsENTkcK1Q/9M+tkClaN11
	 3tXwgTMr/2ZMGTUDbzVBb1Ez7zihZvz7W3NPcXPP/Q1Wn5TAlQn/rr/+OSPfF6CQH7
	 GooVmqZGgWIkw==
Message-ID: <sashiko-outbox-169860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/15] perf annotate-arm64: Support 'add' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6f048c44fafe387ebe8e02815dc860e069c5b43c.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <6f048c44fafe387ebe8e02815dc860e069c5b43c.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:47:00 +0000
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
> [ ... ]
>   found by insn track: 0(reg19) type-offset=3D0xeb8
>   final result: type=3D'struct task_struct'
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D12

