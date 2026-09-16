Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D23B841F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523004; cv=none; b=ThU0WI2jm/jYJEZenVTytugyTAOntSCx6g8l3H2W8C3V/wQjBjeNvlMXIvlFb6/RsnXbHYviXhUWo2RUp47UxtTWvzf9NeLZzdBVU2J7GGF5b7wInoMc3Zwn/4ghwi/NsUDnuSoepySAEF+YgQo/T1ZR3wq8UUJ1ZC8tMZE4Rew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523004; c=relaxed/simple;
	bh=agIK1rFPzh59GRiGfwnF8X+LzY0mHD8fvjNLmFrzN2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pA5xmLaEtDHo414N2J9OR/epnULIMNXMWy3a20gs6gvmknvczCUT+sx4B2FJ6IRr+P9g7BYUCZ0lIDy0sX5vUOZjTk4f6g+kGADnsiZCK1MMmGyaxjoJW3jznUKKNmGUwXpDFu0CBrOw3Uwr1bu/Sm2Fh7gVdWX0zaZKXUPG5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJeD/MdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJeD/MdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F61F000FF;
	Wed, 16 Sep 2026 01:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522982;
	bh=dk7/At719BPnEriVKdRdij4sTaUQxDBZN8woRhyFQfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJeD/MdMuxP/+sFUpj/1w8k0MWT4/5p5MELgmLbOFBCzLeiA9xM1SPqj+2+VSJMZ8
	 qdagP8u8Dhxgr0YOe8awVXjZouE/AIkHDleFjRocrc+RkG0N9y09qy0kVW87EGtTKA
	 AkAtOpfjEVGUqZARwxJzE3h+FINaI8VsA8au4YwL39QuLNUEq6L5715/4BFKlikFLk
	 0NozpYPUq0j9vqG5oIsZ4BDwFLIHTWHQjZ3gmAOp9nFILIZYjBrtEVJe3WUAo+QbhE
	 9tTc2Gd3DueaOi8HGNk+kIAwHh8OLLoVIqAcoVUoE4P+6VLo1ngFK7mcz9xuXK5s5c
	 380l8R4nDIKYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/26] perf annotate-x86: Delete stale stack state on
 store of untracked register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c0695f40485edccc49bf66d45ca32bc87c2373eb.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <c0695f40485edccc49bf66d45ca32bc87c2373eb.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:43:02 +0000
Message-Id: <20260916014302.886F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a register without a tracked type is stored to a stack slot that
> previously held a valid type, the code currently performs an early return.
> This leaves the old type information intact in the stack state.
>=20
> As a result, a stale type bug occurs:
> 1. A tracked register is stored into a stack slot.
> 2. The register becomes untracked/invalid (e.g., across a function call).
> 3. The now-untracked register is stored into the same stack slot.
> 4. Subsequent loads from that slot erroneously pick up the old stale type
>    because the stack entry was never invalidated.
>=20
> Fix this by introducing delete_stack_state() to search and free a stack
> entry for a given offset. When storing an untracked or invalid source
> register into a stack location, call delete_stack_state() to delete the
> stale entry before returning.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D20

