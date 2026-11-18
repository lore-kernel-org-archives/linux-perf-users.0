Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020041;
	b=ratOT1aqWVfZ8zFHxGzeHr/PUwdjlslEdixkpW/JrjzQKt3GWOj6yfJIdvOGCWwYWqSj
	 5gf2aXZ5AvDvKlyRTRXZjvJixwGnR/0SvvO4POlzvZUuMmvxqGBWiy3na3f8ryOYNZOuK
	 wv5DTw8i6o27VifzqekS6PpsOSu0ZJjYc+TAkrTBFK0mhvnjczG07WCrvPWOJNmDRgHm3
	 6IP2rI164LnXbnkVgjsEmOSzzpByk0nKCdiIasA1rsiL/hKalsZxE6IDZ7CM/cp+2VyR7
	 zGf87TXYi/GIAA/HjvSBipzRZKqq/k7RDeCBglwKwWJ24ebqOOAOAsWMUNbc7HVWkuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HmwrYXxDcEP5GA/8xpd4EXdrLBLrI3MhPyaXZ/kJv0w=;
	b=47y7kzpl9/COv7lRVAeYRciD7caoPrS7FV1nkI2AL4kBt3Vyz5wWiXlWGCZwdEpPKE2O
	 fIpdgAhF1FyLFpAgRqUhKZdelUB88hnayKqPuCP/73iqWbf4tMagtoqq/Ybs2vuQkIw5z
	 SOYdX81upGMgDNNu7ZDSdD9XWPKwvjNrlVSl7kKwvR/pDtoZUzl6zFeEYAgXWPcJNuLRe
	 BrpiGqorxHw2mEsJsqvyoklkk/z/b1HT6iOT5Gr/jHAz/SN9w1fnH+fQUSa2XaVN+t3G0
	 DQBAHAqEHAXUwvbgrUa3hvFbEfOiVhVu+MvfkYepU8FMn+UGwz2ohXvPZunaeIs1P/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lh9v9C4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4F60A2605
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lh9v9C4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDFE1F000CB;
	Wed, 18 Nov 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020041;
	bh=HmwrYXxDcEP5GA/8xpd4EXdrLBLrI3MhPyaXZ/kJv0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lh9v9C4DJZWe9YAS050JCfsX47HqlOKQ9X6K3lagHI6v1Jx9RZz/x0/3viDl9QUOR
	 2v3gBIplASHikZRKTmcYrDizDCU/T8Tng2V8H7YnyGFWe2a8Ywjs0dYtYMWsgCBa9+
	 dTC0cRgxtE+Uvish2uIhBP8+cdzGEo5mjBIAVnn8wF1OmpmboHWNDYsE/HGZPGM4ba
	 71f7o01TCAgYWF0N8yl/feUUFfDfzpIbIcEDGqywtQn3hz3qy7IrQxwMYMHcS8Sv+t
	 wDbpO7FCd2sXF7fApOy/1lKKzDJ4d0aiQI60AaVOwaPCrGuenywLj+Qd60Kw7TJS3D
	 tXuSWdlIeHSkA==
Message-ID: <sashiko-outbox-221526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/34] perf cs-etm: Fold packet state into the trace ID
 queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-21-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-21-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The packet queue no longer owns a packet buffer. The remaining timestamp
> and packet_count state belongs to the surrounding trace ID queue.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D21

