Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364953A2E33
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561084; cv=none; b=EQPAy4jq1FmQjgrn0QurCbSI3FH9uomy8Vtz5CAUSO7Q58JKtterpoAtRngzFUax/S1kaZCkH1CAKmIEgegVo4tU4/iYxUlT0U7pKHHuYTEhUy/fq39u5xTYpvG8NYZF6UMaX3wKicg1FeFzXiZH7EjUFS6uDd8KX6M7jn1ej8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561084; c=relaxed/simple;
	bh=BCOf1sQ0pZqm+tjgCzMTv403QdWDY5MhlV+ByFwvSx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfwaqI4CgDGcLRdrWauV+EJHV86fe90a2pL3xusNCapxgR6yMzG25MtIS7m8NemIPIpuhxvysCYdlkhEsGc+h4ZOivaP5LqepbPC7PrpQ1EtPVsIYognpsoqfk2ZGrTSMQZvyvQwauwZdag0+9yKreoCB56pDm/XmpVXEL5SUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVHbkWa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVHbkWa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FA01F000E9;
	Mon, 24 Aug 2026 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561081;
	bh=BCOf1sQ0pZqm+tjgCzMTv403QdWDY5MhlV+ByFwvSx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVHbkWa9qyEiZSciO8z3gNDV/WDONS/SZuZN7BFo7FYW0pAxPBWYWmdvyyddb9dMq
	 ceHhvTBl4YwKPqu9mQcc27UuDy8Ju/aFyh9DZHgs/Sm7IU2pNTrquJdZPCKXk5m0cL
	 wMUoAPPmnKC421cIGM8V1vw7+oXlYHxCNrD4h9/Wcn5xNc96U+sgbDjxT7lkWr3aqm
	 en4yLjEbnVKn/gfMd7pkSG97d58ogbvY6cx+cFkKuOTG4njGcJrVB3is7szIjzr2IU
	 K7TU2ZBMgPPm71JWC0vNZCgVKL92x3ugw0f3vp8y36RH2inYvhQhCRCr+WaWEHkWBY
	 1mGFiqf0ejvYg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 04/23] perf: Eliminate duplicate
 arch-specific function definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-5-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:44:41 +0000
Message-Id: <20260824084441.82FA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Define default common __weak functions for perf_reg_value(),
> perf_reg_validate(), perf_reg_abi() and perf_get_regs_user(). This helps
> to eliminate the duplicated arch-specific definitions.
>=20
> No function changes intended.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D4

