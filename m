Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA4353A6B
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047926; cv=none; b=riB5R2yt+tV/Px7QusIL/68UHqFWI2D/XZcHn2JKQR/c0iTOiQ3ttev2/HiIrxVmzmnIprxdbLWYJp6ThGMh2GwrAe7dYiWz2Jb+oGAgUTBx6HL52w8nmRMQHdEUL/eTCXMxSAo/j4NfDXK0ZRhRTxkJDbBcHincvyfAezeI+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047926; c=relaxed/simple;
	bh=VjElWmc0/uro2T6SyBoRDmZJwfby8Mwy7qXCyKSdzIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwrSkTpeyqSls84CS/LwXC1BjJAVZFoR9sQl+CZcZ/CQBl1g2Uj20sTtoemJKpPb6Hg4PRWz9QmRvj5kpY/WHtT7nxfHmQTkY+U+pxkoAOB4iiOjFWfndAuoZJUEy6sGkpJzsX7MqBFo+0n1zYuz7FilIPHkIxlDXOS4f/duQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTukPSt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTukPSt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFED71F000E9;
	Tue, 18 Aug 2026 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047925;
	bh=VjElWmc0/uro2T6SyBoRDmZJwfby8Mwy7qXCyKSdzIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTukPSt+8uvwYkvQFt9gmTqBVo+ibh6La1ZzywSjfHe8wWD7PWFoV3a3xHatLWV02
	 bgHYfS1scTAE5eKTWFaT8SFr4/sAHs9tJAjg1HsNY+Prade/966TqCymjp2LHn2Si4
	 G8D4B8NZ4n3oscjenwq8CUFTz1so4xCjTNXTtIHEjmhot1u0u6/AqhwIEvg8Ey5+d6
	 LC5PjTlTW8hmoTUY5XEpV3kPbOHoyYD7vTc1yfzhJ2XTNbxcVgaDlimIZMFzvfGRxS
	 a0RMfZgflMryuwyh0GcvFfNtrmg7KXlg3opuym5degmA+i3gAFzmKIg6aj5fzRG3to
	 5xUFKB9S3CXVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf vendor events hygon: Add Hygon Data Fabric
 PMU events and metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818100118.12944-3-liuqi@hygon.cn>
References: <20260818100118.12944-1-liuqi@hygon.cn>
 <20260818100118.12944-3-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:12:04 +0000
Message-Id: <20260818101204.EFED71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add perf JSON event definitions and metrics for the Hygon Data Fabric (DF)
> uncore PMU.
>=20
> Signed-off-by: Qi Liu <liuqi@hygon.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818100118.1294=
4-1-liuqi@hygon.cn?part=3D2

