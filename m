Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549408;
	b=f3nP3uPUJFdvYj1tjb+I5+rwhPUIYgQo+Ro8KFFUF5dREDdppJK7P4MGZtwtUvBfMaKX
	 SvEmvIubiKdEUiCK9tVJHxk4BGK3S6hBX/GPLVrNT2BHdOGBkjaLmRx8sH7vZyPufral2
	 4kCnKjosvseKHS7BP8U49v5is6A7DyQSsHxAHpk+lKJfO833/MykCJh++fLODC8Hd8pUl
	 XOmYY1DT8iJBUm8Nsg6+47URZua/Rl9rQ5WupdqxsbkiENkpGHymp+2fDdC6Ng7KGZbdd
	 h/bO6NWrVOVIUCYfDPgTWNmmiHHRl22QeVaKnOQUuh4WrLp/fCcuziIV/2WQ4/9J3hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=suB6VbqXe/IDBZ2RoxugFbZt099fv5jinsmdyNUpTP4=;
	b=xd+H8Tg/62TZ/ehIwJ1hCcPTcxVdC05twPLQZ5uvROdPzNbswjB86qwo8DqBvOU5xRA1
	 B0X2rJy7aDrH1OXx2CDF2i2lRR28LZXzXEnxhtUGJfSvXi/VGjCnimzE4OwZ1Myzz/yb2
	 DuOu4T6VKWTEEaagmg0slU+fWROLnh6f+un5+zwEPrXPsH/vNMLrb97XFHG9FY7q0/VMk
	 +9UGs0FoLsRuELfNEeUq0e3ct0m+Y0347uIdCixxXm+FFwwu1GegYUR7RWitqs5lujI0g
	 zOSrv29CXHtTKaAwmmmEreqkCYB4vLGJwPB7h96B0SwUF7LeKwm/QZ1CMQTBnXU4eFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU4hB7jF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CB606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lU4hB7jF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1532B1F000C6;
	Tue, 24 Nov 2026 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549408;
	bh=suB6VbqXe/IDBZ2RoxugFbZt099fv5jinsmdyNUpTP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lU4hB7jFwOw89rFivGsEJxsmJAwIKAIjFQM5kSj4CHLtgPcQX9CiWzy0oaQqrSsmx
	 va7sB70doh0g8/uCXst/DM1RBT1QC6hNKDtRbbHh3E06NbVkCabPWyEQe0PAs3kEzk
	 s+dxLInLt486BRZJaWdHEO/MIK881r1aP8HO5PAHJCCF2sf1QtvPttPgSkTU9U+k3f
	 H2pCKEeIWEb1nOx8kupUtYccAs9Qo5EI7NIVdnGcwkLoKSyjp+BXqax3QalYpLQXop
	 84XZVal7HknEYiqjDqd1lwP6MhyLBtOzDmBkJuLRgeA5R3OlgD8VrUY+NRrXYdEbAG
	 jY8Nd2EcJkcUA==
Message-ID: <sashiko-outbox-231902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 0/7] perf script: Lazy symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
References: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:43:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 7-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-perf-symbo=
l-memory-send-v9-0-56f298185eae@uber.com
