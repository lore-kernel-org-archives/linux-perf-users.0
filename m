Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246516;
	b=01VzBbv5AfsRpYjPhHroUKpGyq2OrX96hDKMNsU9fFflK3u7sdGT1cwhvlYyM22iiRDQ
	 LeTMCrWFYJVKpGnZZ4bFV2oIR1a6uEtqZpBzDZla+PcJY25gav3vBkXVVHYuhjJL1e0+F
	 SobtCHnX1lfvVaEZnTeb93rMMOKOpnkVBEEAcBVlNFM9NaXc8QwQTzXT60+5UCZkYto01
	 PUmDoqGjfwvWsUNb8Aowowlz+alWD+sGn4/JpkzKbsv6JX5cDeO5OCOUHBsZTl31T+CXq
	 LgCjk/qmQ78nHSG6L/3KGZ37MgWdrlAIBriwLhMlPT94wNxyI2S75oN+ngmigmCiTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zSiWEMEgKEh/IETxRwmflyvUvx6EcIEU8dtUgEt7HHM=;
	b=G+YE8+Y+ByxWlmQeQcju+o7k7jttjeBCtyy5axF4SsbQLzkfKxw/ku9S88B5woMPXDb5
	 xkL7KAm6YXM8dYYo5EV4jAPIrL7y3tFaoqkORs/l5zpFlefmBh1rITESwHxSZcXvgxQdl
	 30WxkkxGekWdu/wHE1WTffp/isZwllo0l6dVAxaQP0Dn1wvx1BN0SX9SCeCL82m8cEi72
	 OVhnBH0cFXO6nW7LcZbbuoF0eHNiqqi/IuZu9Yl9f/Gq30OgsjzdOxVksLqVXzd46TBS3
	 1MK3MoNa5fW2eQzmItV/btf013u7Rd5ay7Wta5uSPwOYEX4JZ+cnqkBf8B5WEyF/Xwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDMuziqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F7606A320
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDMuziqB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8D11F000C4;
	Sat, 21 Nov 2026 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795246515;
	bh=zSiWEMEgKEh/IETxRwmflyvUvx6EcIEU8dtUgEt7HHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDMuziqBJJ8shansCnVsfRWZWufUN56FZo+RkQeZpDEwPXqyPvaAa+F/AFxYobVJR
	 QuPB9I9OHQI0avDw9TH2tv94hqbbLxu/JcbX1UhAbYdFY6P6Z9vIYlx0O675FgZjHf
	 A8CKbrlAdtbphrgb1I6K1kb3KDmibODYmRWIrTtlJV0TUT+lusxSEP0lA3rIF3VXOM
	 G80Vnb5DYYXqGZH0WjM6+zEUPnmP8JYhYTYDgrpr5rjKp06p3I5iWOJNUxq96pQfaK
	 n9VkTMQEnbUNy9JdSedZvlojjqU5JKhSiC0JY8sjDsiFKuLPEPNDdIvhXyNh/uhpvJ
	 RtBCRAbqlasSw==
Message-ID: <sashiko-outbox-226784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 00/10] perf symbol: Sorted arrays, DSO-owned
 lifetimes, and memory shrinking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
References: <20261121071651.67118-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:35:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 10-patch series:

- Patches 1-6 and 8-10: no issues found.
- Patch 7 ("perf symbol: Optimize incremental symbol insertion w..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 7.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121071651.6711=
8-1-irogers@google.com
