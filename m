Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612C33343C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561256; cv=none; b=D0PcM/ie442tRoXt7hFJg2STsMnfStbK4UmjqX9+76qN1PRIcscwDGtDqS6XP0oXLCHKO8K/tbU/uKmsdVoKD4pPfZBM6L+cWj6mxskp5rVhqfMqLY8jimNfQAHL2FAmlnEZdvWhMZIFWtrMi8XGOjSye3BiMKktu68cIPJxXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561256; c=relaxed/simple;
	bh=xOojiI/mqH/xTaDu5yMfqd5Mrlu2YZ2/c+s3+rX5vco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AJcLvEfQPg6gq3wbn1Ig0FNHGw8FQ8nAPmHEEmVt1QQpPpbrw8UUGfBps37cIO0TQl42LOPVRXNq6vMocgO1g6a5T2XYoiH/kye9WqIHOoQv/nEKRu9/ldx883rraJvgMOKQ8OMmOANdrEkTwI3X6C69KQTuOz/d8lVKHgiTYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwldNPx+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwldNPx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F7E1F00A3A;
	Mon, 24 Aug 2026 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561250;
	bh=xOojiI/mqH/xTaDu5yMfqd5Mrlu2YZ2/c+s3+rX5vco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwldNPx+Ey4nNAvb768GrM24vDELPQ72GM3Bc9vZCHZWNHYxQc3n91KDRrRbCyR5f
	 //HPpDRWRZG4J+ucc7KQ1Oq14te0qSWNB9P/lvaXH9wJ8xFPV0fmJze5VIb87qLz27
	 49xFY5ugozyKyYg0oPfPqvqwCkEkdodLfZ644n+NGeSPiUdOJEvvKz3F3ImAvRkm2+
	 WxLZGyYogqd72Lmh8Z+m74NKm6k2DHSMdwBWuhIPn5ki4WA5Lm5VSxtBGKj46pvMnc
	 +2/fhqJlSeVRQta4/eY2f6tARbhXceopainSShKFxtBlS1E9bCwr5jFjw/G4Z7E7Nz
	 p15JIgcqs4Tow==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 07/23] x86/fpu: Add
 update_fpu_state_and_flag() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-8-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:47:29 +0000
Message-Id: <20260824084730.54F7E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add update_fpu_state_and_flag() as suggested by Peter and Dave.
> The helper saves user FPU state and then sets TIF_NEED_FPU_LOAD,
> ensuring the task FPU state is saved whenever the flag is set.
>=20
> Subsequent patches will use this guarantee in NMI context by checking
> TIF_NEED_FPU_LOAD before retrieving user FPU state from the saved
> task FPU state.
>=20
> Also add barrier() in the host/guest FPU state switch path and move
> clearing of fpu->__task_fpstate after switching back to host state. So
> fpu->__task_fpstate is always observed as host FPU state when non-NULL.
>=20
> Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programm=
ing.kicks-ass.net/
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D7

