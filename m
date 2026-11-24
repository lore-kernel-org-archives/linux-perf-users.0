Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522644;
	b=g02lQ2Iig19ng63dxVE9rCXY/RaDQYZcN82QENmXUfhC++5NHXlKaHmHHmhssxNA9rXj
	 1xMpNXqhmphKlSyGtt0Q2UxW99DQZvMWBNz9pOi70WTNvlrhuB0HHGnP4w6gbXijzUa9l
	 +wPyK0n/PMye5ajWy4NzQItfOcVrIhrv85P0pV8oLTgX+djgftH7p7k1WCd9neKOu17QH
	 uibkaBxb09pLYdMyjXkuHxvSkF5bU+bo4f1hgqYFMSQryr8YjffPe8pgOYuGuG3kFIo6b
	 6SJSJ5qod0cL8e8qohbEP/KCVLAeEVdYLDBBQSlzd1F2yJQnx7r/8VAbsqv3rEce6ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6FdjKFucG+8QIvWt3VWEodZw6RrglbuJcDQVZ+yawKg=;
	b=bPulEc3rVlJCO0MsCeMq21yt//zKCMzFouQZOmb6LqzAL+e+fySGCCH3SDfqGfzn8cds
	 rPMK4T7jM5nKS+RsMWwQOyc1FGQtJGwpWtPD5R8MCnF9gdkmujBw6nJzIiHa9r9lFwImw
	 +RYZhRsr2QuC2QYoTAK6XYCpKv6U5LKUpbXELUH7YLG6t5wx10edC9cwVasx9+kDQQeNR
	 F+gC8f+i6HFVZQ+Ke45HyptQy2ySrHSYy4DKf+ZrV1zTRIlC7BOuiPhoLYHFmHts1BKZM
	 tEqG1wZOmemipgVr6EGsFYLazFzucjvFekniZoC75eJ0W0IjF38AaYcGtVooMfUWrzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRvxIsIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF64606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRvxIsIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC90D1F000D8;
	Tue, 24 Nov 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522644;
	bh=6FdjKFucG+8QIvWt3VWEodZw6RrglbuJcDQVZ+yawKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRvxIsIT98dPKbW3pHDLiVtuW/sAVLgFzhldfOWZLMxHkQLiZhAwWPwFOSP4xFPpE
	 Gca9oo2O5iMA8V4BmU1D82B3bpbOfDBNpyNF/ht2LneD2JEwexZBOhtgzdVgDiLszB
	 n58idMyCNpNbkWF/hbXulzI/OV/MWZ3k26HfN1X9tllQSH8MONVzXk6XLt1F4WxeP9
	 BxrKYwa4/rBZM0QJVoq38xJO/UbH0pgGUwQs0qsEayDAvWaM0OfFZveNC90rGeRDU/
	 n3qmRb59ycguUUWqsjcqnIeWrnjQ4S8rhR5anEGWy8kttDVnFNj7cGiv4WkhpzrRqv
	 afuojlYEPPmRg==
Message-ID: <sashiko-outbox-231119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/2] perf: Reject group leaders detached by CPU
 hot-unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Wade" <danjwade95@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124120503.334-1-danjwade95@gmail.com>
References: <20261124120503.334-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:17:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124120503.334-=
1-danjwade95@gmail.com
