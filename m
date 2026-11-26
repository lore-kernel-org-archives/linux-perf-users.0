Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666967;
	b=YSouebzgJhKXq1+MFu0DNcyIBq+wqDB5OvBOW+KvuOCzgIfNXO2lhUROwvCjBdg8Hvay
	 eiwBCtZNm8o57tBwl03nYflB139nQcbhkwi2EitCUpB9XD8zkBA2COhOoUdUoyzeWEL3g
	 XJnGYp6NoeEcB3gc5YooIjK+TH5oO5yxjT1tw60UiSTFrcMI96w3PNsdqjHKKfkTKpAK2
	 +3g55Q3fOELT7BJmZL84vDQ1+yEhk7OdrnaJhzRE+Doaiw8lcuSexJR5pN6RhVAz6+hku
	 wm8cZFt4CAuCR55vymtE8TkoSFo3ynXVBF3vB2Xui4nEQ5mwpHw6z48wAFyYU4XZA9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VRTnteiqUXWSPf62T+t+gdbCBUwiWJzIyqDERuq1zOw=;
	b=TGhyCX1MGYUhaqOeUr4RyzErlZX3POMpBHkLrDseISPaXTSetcDqTZqVp02aOMBpqt86
	 dPNaxvOJqd4ni5c6jRoFfrWn3WLb3OXvSBKhdpCnBO4XoRHwLkMoyijaUM4JRMf0TZ3+J
	 7IehI+Ll6N8gPxz9+oU4cqH0SQuTL3QFdm5O6wbJvSmGkIpvJfIuXSQO1/GeqORhxSXBy
	 kiobrzgWOt3Gid4cu/eLWkfIO3AMcLaYyliZLYgKYhq9M9w6wlnCVNIODgvxQZ3f3jNj0
	 M25SYO7oHEtXaVGFUrDy4argGKX1kDO1dic/ETlXiZ1R4gPb4KGH0qRypU+Xc9788Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtUIX0yg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57D606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtUIX0yg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970291F000C0;
	Thu, 26 Nov 2026 04:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666967;
	bh=VRTnteiqUXWSPf62T+t+gdbCBUwiWJzIyqDERuq1zOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dtUIX0yg1/ajUatt+nL0y0+BcaBeeIqqcQanCIbOe7Z5RbpUPja6yTlDQdxWEdVke
	 j9rCOL67kjjdh/g4snDMsMXzCBylSob3aNaYHP1jL9WKHD3a3hOMZpoORw5EHqUQ4g
	 FzsGFbGjP6IjJnRQuZHTmXSAjPUO9zd0OGM/inaNIOJprdtjdQSj5wW2r+5tzmr5Oi
	 q+PeYlZXJl/VvE5LWtuH7DsG6hYw3XqORjW/DHWO8ndoLW4lnT3YfJFuBiCNQ46qex
	 sSRng2VHmgzp2gvz1qYwYhF2thURVYh72xa1gLgg9c7WmdNaC5ilMXaU0KPZoFQ6Ts
	 tT59hMVD5YFvA==
Message-ID: <sashiko-outbox-234730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-6.6.y 0/9] perf/bpf: Fix NULL pointer
 dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luo Gengkun" <luogengkun@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
References: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 04:22:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 9-patch series:

- Patches 1-3 and 5-9: no issues found.
- Patch 4 ("perf/bpf: Call BPF handler directly, not through ove..."): 1
  related pre-existing bug noted

A detailed review has been sent as a separate reply to patch 4.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126043458.2394=
658-1-luogengkun@huaweicloud.com
