Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503C2DFF3F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228592; cv=none; b=CUJLZgI4zZfuFm6zRUFHNDzl+rsBfOayyWJ0HSShvKRM5fA2+gH2Zjhz9xsRaw6uRFx3mCWoiQvPd1HBiO9YiQUt87axydMhkzrPMblbMZ+BZhTggymHtZhmGikJuhTC2xy/7aHVfTOG8owNeoH6UNVxATR1BVWpDcAfsR6EOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228592; c=relaxed/simple;
	bh=WUDMcp5dRqmupRukjpzy5PTIuemDH4bDMY67QsEKzQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hKlzmuW/FVW6MoVmFuy0g9TnfInE4cWCLOAQdRWX/GQFmAYs+ow2ahHjadi7fcgqIqDvgpipq3RQ2Em4oz9Y9ab1ArkJ+dWgVhCD9i6cfW6YDp7bhI/fUpXngoaRqaolj3vmBg1bRbfSrDpySM4n4A2fVlQms/kwKrutlCVgfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWSPfxq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWSPfxq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E7A1F000FF;
	Thu, 24 Sep 2026 05:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228590;
	bh=AkQysXOx/AfjAAsnXhyU/FeCacsaaaTRt0eZbq6haEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aWSPfxq91yU687VijW29RlCEuv1gj5tllaY1tLzcn6CL3y0khT0tBgY8un8xOQrlb
	 3CQI/MbCQIxIz14bedANLZmbbDsc0JJTJBGPsTMQBjBS50EKezGmwGY6B6yFx0lhSL
	 JvdNLfddOO9BFgkVfKbwpOf+rxKrJ+fwrvsUXmWF0f0lfQfDw4BvrUlmMe3H+mjtZN
	 pM6uyaSLf0U/dlHoaRrAI0dKBBrnZSkbcH2V+KAkdQ6GoZQ/hAfIPwHBNhgxvoc9xp
	 WTkOATDyxcs1SuDFL4qXyiTbuO4kuiqbT0JuLbpgnGrqOTvB8+/khzPXXDx9iLVY2O
	 THm99l6xSvtjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/21] perf vendor events intel: Update graniterapids
 events from 1.20 to 1.21
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-8-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:43:10 +0000
Message-Id: <20260924054310.B9E7A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/8732d043b432e9d04086a07feb23d9d=
f70a10f17
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D7

