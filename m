Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499A48CD5B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640907; cv=none; b=OezlZL3CSpY8WBC+TGJDL0FW0NFM4Hbl8hfh46auklE/w7ABaqWXpiKmvvI2S4D3z8kT9yypyvQqhD0FYQ350hoyKABAPF/CsNw5Yo8/cRnGzDrp2HtzafA6Xx9XHP2R16q4vbzfzHjmhslfluoLZm5VyPs8yYUE7uIXnh+E4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640907; c=relaxed/simple;
	bh=pPOpcy5fw7cx1WranmLRf0QkxCcEYzivaIerq/b5FFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzDcO293JyltyEbu0Mb0iLgu4u0SvTtgvVJp1fgOgYnGwn2wLAffH0UxaUQtsRTXFkzjt/oXJz+HhwpJ1quet+CbgGegs+5d92I/2P4J3xoeNBZ3LvkEf3lwr8B+5D3BcT9jL9HjDFuDKSu2UNbZRdmTjcwaE+mf9D5/ViUQLGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd+qsgGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd+qsgGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55871F000E9;
	Thu, 13 Aug 2026 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640906;
	bh=pPOpcy5fw7cx1WranmLRf0QkxCcEYzivaIerq/b5FFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sd+qsgGF5wTHxkWuVHdTmWSvMoijKnWElLsSWiQcadCI6Fu9n3ANKR3v5g6bgUofy
	 DrVwYmjZyfrlRU6+qz4lQ03JMqebOwHMJFnWq8JYd4fcz0h9yGI8pVczzXJM3JXjPE
	 xdV9OwAqtuCVZQYVOiLMQSe+PBZ+kDeMbFf9x6XUOPpTLdC6KtioxN9zi4XC75VXQr
	 Y9SLTns9G5ddVcmm23luRvPvdta45ksFv6qjxT7AiB00J6q5sLxMaFpTZ4D5FdeTXk
	 GlOcHg/gUbwyFiaTmC/3P1lTcHqWPmbE5m629ZWsYxe5xjtkVs1AO2PNLMdZlYolYH
	 noAnzemrxUCUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf vendor events arm64: Fix Tegra410 Olympus
 event 0x0197
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813170155.1156593-3-bwicaksono@nvidia.com>
References: <20260813170155.1156593-1-bwicaksono@nvidia.com>
 <20260813170155.1156593-3-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:08:25 +0000
Message-Id: <20260813170825.C55871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The name and description for NVIDIA Tegra410 Olympus implementation-defin=
ed
> event 0x0197 incorrectly indicate a TXREQ limit between one quarter and
> one half. Correct them to describe a TXREQ limit below one half.
>=20
> Fixes: 86ff690f45cc ("perf vendor events arm64: Add Tegra410 Olympus PMU =
events")
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813170155.1156=
593-1-bwicaksono@nvidia.com?part=3D2

