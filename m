Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472036;
	b=MHJdi+QAa6dfXEJP2iuaB4MfZE0+n5XZo8BDSOfJbqyhKLRGQQxxJVbqaFOpXzpfdn3N
	 06y+kHbksHSKmNezSawvOgeGlhcGXjDLroGN2NAbCTDXhRPF8YjKn/WYufVpBcz/WEBW+
	 uX3SUnreI4DhK7e7elRekjDKAGJMySWzSKfBPkF0RllKlS2IXygXvyIegeB8JXaXTFM4I
	 xHgIJiXX9Vv6xV8h0kbPaAEvGFah1wJzMluGytqIQkytf8rzSaqvUeBu9C1fsJLEgDw5W
	 1ALiAvsycyyZeqXK9NNMqUaFUwXHWpYnxS+l9dpXOcE8LWjeOC7OBLDTBy3sIuWWRaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TzNQaEkAHvAwklv9Ljhrq7ri4W7DJ2/kl02briTl7IA=;
	b=5l5sbhgP2e3S2N581rJjvNX8A6754WgL3qRp2XxHR0TMv7jiZkMzqRWZ6P9n7aPGSVt3
	 Rh+gHALpeslj7j8Ia4t3ZlxaGnRSSlCJxtO2gXcKoTQAl4HQlLd8rSWiD9mKNQtpASqOk
	 d5BXn4H2sRbQmSShJ7Z7Vh5PRr/ORSECZDSzQib0Ymci3E2fCHyfu3cCBHqMWiF2c2XVG
	 koFcYTCHwkWmFRh57hNQYxd4QrHEe9OKBRNZKWJwN56cUV1f0eVWfSLzifLKTta7VmwnE
	 awxM5sGzJykd6KtTkcbtPkpjQFHEQpNJi+ONkn4zwgaoNl0IhuRQpE/O8glABDadrUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQMG4xbj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD8606A695
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQMG4xbj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840551F000C0;
	Mon, 23 Nov 2026 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472035;
	bh=TzNQaEkAHvAwklv9Ljhrq7ri4W7DJ2/kl02briTl7IA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQMG4xbjaggubYW/++LTjwk6tdgnPrbtTrSH58l9GSK8ElAGfaTM+eFXVB040LUH1
	 xLAYlAcOIkE8AYBahJf9XHtPcXHnDHTIB6T/+f7eZ0fXgp69sI2yXChs7oPBsdirq+
	 jpftgSItRuJz33LPUjLpztQsBEss0pBvvBnjItzHSHed+c1dAMzk0u4ygCAsITR4D/
	 XmrWHRjtJFLF8K5YhGz0coCfDvQJSWPzckb9v3NHhoiSvhgXj9ojBTuhYT3LWh+JPN
	 ZxaMTW+suEctUb4pAIdON18RNOfBrXduw3twc/TWiWobelyTRtJgK8DARMXzjOwHjw
	 m4fDj48MxL+pA==
Message-ID: <sashiko-outbox-230127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 00/19] perf coverage: A harness for perf, and the
 fixes it found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:13:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 19-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123220024.1489=
1-1-acme@kernel.org
