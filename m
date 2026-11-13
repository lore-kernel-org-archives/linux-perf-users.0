Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607087;
	b=YIWDXBPRmpjsWoHVgQ7aNopDpPsXqbeHv41UJ32KGEiglnB5sSe0jvfcYXdkPYEAdURD
	 R9Zi/I+4xqu/OHXQoBZWt43vIXvqH9Hw4dABTPkEj/keOyqAk3G5EgiZUvR4L2U742OiX
	 AO1SXjlVVxZ4Ri0XAT63v/F9RsQBE4wYEj+51cseAagg/Q7KO9LrgnXS1ATe+VWUOnW22
	 XhqvtFnXyVAw7CJZTbEei8U2toK6pSYuijQWoaVZgFiISyYM3wEg9N2PP1Xv3gzn1eewn
	 waz6FBZIAl+ncoddd0FSHchuO/cL9Nfd/7wudQvFp9OkWnbvGrVHwyIUFIde0tvZrhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dGmIj7YG3MmqKgZMSw78FIw/M3baBE86uZWvbxyjSWM=;
	b=pQ2kIea115UlgiBX81FlZSn2S/9aE9jxcCcOwrF6W8k2PJ2m7fi3Sr0fCkVcuwkeCNKK
	 fUUmdICymquY6MSEQ57DsEwq1mnzfOYN8Xm4J+2PNF/pbv1NRqO9PLRag2pL54jaqz2XY
	 Zo5bS0W/ewUPjpkOcUchIZj7pJERYYe8MovhLMQ6H1eDYVMJwbrJkMxQaKLZhDkoTzZLe
	 QHvth+FoULkHZTSQipFbwsAPmicoHP+kKHZ7MaqF3A0+2JkBydbWRxDOxK3To6Gx3MISW
	 Kp7dDWUTcIrSoQmmYubZav57koALTVaARMXLReVHZkA4UhUfRYksni2/tJ1lUasSewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJ0pjgYi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E57606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJ0pjgYi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD09B1F000C7;
	Fri, 13 Nov 2026 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607087;
	bh=dGmIj7YG3MmqKgZMSw78FIw/M3baBE86uZWvbxyjSWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJ0pjgYiDKAH1IeBmDRIhD1WL0L0tmrYGRcm1atLKbPh6/zmVugLWDs2gq24uEzzr
	 khkcZbyx50s7jk53gwEfpCCuMBEUXnFjf2q2PbT9xiykrqhbw7JI+GkZC9vWMGKbQm
	 CFgdH+Oxm+L78u4abRnVjoi+iJ3hSMS1MtoWB8MEjvzst7RW+vdPq0AdivY9gAXQua
	 XfTbHYOmx+7mG+yAoFawJKD6xBtOiw6iuiOqW8snkzLSJYMK7To+QeS99C20giARv/
	 wJhHo/KkyyaptG/Qm9L+jJbbOJEtZ6wuA+11qLlEeSp5WX0D2tWIADo4MSwaAecNIk
	 ldC4Wm/hslzXQ==
Message-ID: <sashiko-outbox-213756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/26] perf hwmon_pmu: Use generic hashmap for hwmon
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-18-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:58:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert hwmon_pmu::events in util/hwmon_pmu.c to
> DECLARE_HASHMAP(hwmon_pmu_events_map, long, struct hwmon_pmu_event_value =
*)
> and use hashmap__for_each{,_safe}().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D17

