Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECF54A7F3
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874290; cv=none; b=VTDawnffe26ZIsWUBx5b+n8XvsxXWkugzl9NADuAUjHZ8Ok+HEnaiN0wcnAa8exfcND5lE0ieWHiW8XDYkvIOMHk8P3tcNBOmfy57NzD0aYQC3iQAa4JMK/d2RIQFrpDgDOWT7a+dw4fF2D6TJy0ykOFBjhqpf3AndK8+Oti3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874290; c=relaxed/simple;
	bh=yA9LHlJ+HcYtI/1jNn/JjAHJ09nd1ML0O3SAjV5L/V4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=imhd3ghJY3aKF6i4yZ3UWFeAU6vm3mMRpD08PqRtFULKBqzY9USRo3IPy+rN9jbs6StiLEXYV1X//whcZjz2IcG1yV5zqyhFSedW42+IScvKR5fd8Om5Mrq8+08WXR2rPxfvsiBdyvP73GDVcxrrW/CoIBYCf1cLgzOUV4TVdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E5C1F00A3F;
	Tue,  8 Sep 2026 13:31:06 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 26/26] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d857b8bcea3aa9a218b2feebc4235095b25f5c72.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <d857b8bcea3aa9a218b2feebc4235095b25f5c72.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:31:05 +0000
Message-Id: <20260908133106.30E5C1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to handle the 'mrs' instruction,
> enabling the tracking of the 'current' task pointer in the kernel.
>=20
> On arm64, the kernel uses the 'sp_el0' system register to store the
> address of the currently executing 'struct task_struct'. This is
> typically accessed via the 'get_current()' inline function, resulting
> in the instruction 'mrs xN, sp_el0'.
>=20
> To resolve the data type of the target register, first verify the
> access is to 'sp_el0' within a kernel DSO. Then, locate the
> 'get_current()' inline function's DWARF Die at the current PC and
> extract its return type (which should be 'struct task_struct*').
>=20
> A real-world example is shown below:
>=20
> [ ... ]
>   found by insn track: 0x2c(reg0) type-offset=3D0x2c
>   final result: type=3D'struct task_struct'
>=20
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D26

