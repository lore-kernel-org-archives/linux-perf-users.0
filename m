Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250204;
	b=S5XyaOIHyeJdypf9BZTx5ZlW4D/B44/W2hc6y/Zal5h6PWmaXCWw/nBri4ucPraM5zmY
	 kk3oMwTdLOnIQk5M9gFI/Nl+vjr/VC3QiqAjZKVIBBfdyANvIiC8Zxx3r2VgHZ6ZYtmdE
	 odpnt9xKBOl9Pki7OyQVw8W6W+uofcxIQc14GW1dTEfCGRN4anhFWHJ3rRd8DSL5k93jE
	 k3Tf/pP1WWh3FJtjggJ5xPizK3c+G93g/s2MKTr4u0anPLR0B4bOcw8JQAShH5FxU2Zns
	 UCMUWJKyZWPnAo5ShXVnUuqJHzPZ7+2xkiomV7fbey79f7k4lbXwntvsXVsOKa7YJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CJRuhHWA5bXExYfy6AQNwKf+WoIaYMUyGgbkyvyUbao=;
	b=yETLx15T7iVHtGvOdMQu2ZKkwVuWqF7eYhflb2cJfGaV6X5FVJZfw4ECdYXetGGgtWK1
	 hS2T4cLuENeo4Q96XG0FgBGmu8xfYiHXEwdYLv4MCuu5E4ta/+14idQ+71+cxKe4Jdt6L
	 jtf2BW81kTwD/K07Te6A2RSSYabPBzZ8wfWFyDtxkTg4LaMXn3LFwDpfe5OniTjfrvDTw
	 SaMuBbQGtk0vSo0u+FzlBG+PLS1Z5BnHKzYtZY6/x1Z20cz2yavx1miFzinyrzi6QNY9o
	 a+E847bb58Kzb+C2iQmzgrXgVNcrJQr4d0icZdi+P+SH/jGrPlxtrdyV0d/lQVqxfSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSEr1H65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE65606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSEr1H65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645281F01828;
	Thu, 29 Oct 2026 05:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250203;
	bh=CJRuhHWA5bXExYfy6AQNwKf+WoIaYMUyGgbkyvyUbao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSEr1H652nvcr+S+fOGj6O2Ji5Z7gwjIflcAo8SIbFNHYoKcPxqneNpbFaXAaR5wl
	 MiUPw35zAae9G6BNlYXRHqEuxBjKLpHWBe6Udi92cUz5sCg3MXlARzE9fo0uVWSMYq
	 iFYoI0F6rVg0PDZyCH8odKUxuRm+ziBX/qcrPI3YaJCf/luUw16jXXko0j1Q1FReiR
	 bILm7Q9eFqXWOq/NB3YA9ogpdKs6N73cG5sE/yAk+VVLazre3/bzjySx/1D1nEu47p
	 1wJxDIZgOjFUtYLdrBGEYk9XCMXp3+KPBY5YejTJuvfTbjX28Nu6rcXFVhLcwB5Ckm
	 Ekn66J1wW0NbQ==
Message-ID: <sashiko-outbox-188727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 15/18] perf/x86/intel: Clear raw LBR counters in the
 LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-16-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-16-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:03:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Raw LBR counters are currently stored in the reserved fields of the LBR
> stack even when no LBR event needs them.
>=20
> If an LBR counter event is present, it clears the raw LBR counters while
> processing the stack, but those counters can be leaked to userspace when
> no LBR event requires them. Clear the raw LBR counters when no LBR event
> uses them.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D15

