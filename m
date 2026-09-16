Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82F3AA1BD
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523536; cv=none; b=PSSCzFfY++RkzNuRSQp5qDSaKvXzgoGIFeR6I7J8LqvCRrCU9ZDBaN3t+fVYXuVeCisiuJZnZbHQblUqFCfyhl4G3nxAJ0NTg2uaBMygrVefRFHzmNwfee4g7DQyjZ9wJNt5aazgy0+pLEbSne1zQMIkwWp9bMbVaRNJFth2UwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523536; c=relaxed/simple;
	bh=j5BeAg5OqHUrNDcD0dH4jJ6Wohf1+hamtk98YdB9TrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HZmJG5cMwhSsNlUz3jyZr1buMmuw/1qDnaSlYTfcKGtTQi3fv+3aD9q/mWYBZ1Bc6JllFm90M23/sYHfC3WUx8JaOKngh0BG+GuAuLqGf5X90IgfPuEoeE8duEDvEXVMV2GaiSI1Y2GXzLRW1vjC38BgGqQKLv/9yuXcN6deVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W30liLJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W30liLJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2DF1F000FF;
	Wed, 16 Sep 2026 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523527;
	bh=pb91DJNCmWCZLsbhyctJ2MCFuUACuYf+4XHSVm/ObwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W30liLJ2jew57ibgoqrYVvuUBOsP5iendTuO1VPQEvd2zaXGVQC9rytSRU+J0zEQI
	 CZ9z02x+RvAhVxLwZC/mQF4r72/ZLeD35eFAl/x2FMDGry9t1A67JjDHG09LB6UfAd
	 vYBHSdTRlumVJph0I1Xme/wZFtId15c/VgE80H4jCa59YAxOg1rkZc9XZtFTR5dydD
	 YqRPk586COW5sODE5sDDXMaZ6EihSanpmxg0LJRMGKxCOazpD7h0wS9JXGPFyFZxv+
	 30eXh+Rc8uGSXgwgNg16zjomSVrZHrMRGvLMfMmfFxhrIBR3Q/eWML4I/M7wh4yG2k
	 Z6rbNiZCERbIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/26] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a98490f9cdae934fa44a209d8807a2f4365582f5.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <a98490f9cdae934fa44a209d8807a2f4365582f5.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:52:07 +0000
Message-Id: <20260916015207.6F2DF1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D26

