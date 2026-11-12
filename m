Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471319;
	b=vapCd0fGRiR7/pEkc0lTs2Qo99G7lg+d01YyOzzH839fB0/hmir7y/yn5FqA8oOwwYXX
	 5tjvDGSoHAln4PUhmzGMBeJYtekEfGyVb++kA88faxULyJrEC+xqmOroqvUGxx53YuTch
	 sUdU+iBcVqTA/+cHX1Ai1ogxhtE+cr811ojaffGo5AXZHQJO7KpiW/l68d7ZRx3a0KgLe
	 4PG5IMS7pWtMq1O5iVPD5X4lpnLudM/QAqT6Zizml/UG+Y8WcrJ6mLBvI2RmwnbEhOLVP
	 r8v/774HndlRHJrdTjcLPIkHk4fCLiu6IksMNXKgN9aGq8E8zs7pIEihBKIarewI6gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uZZ/RA1zPCfCU5K9Tt4iqVnW4BOixVxPGoMVM/B9JUo=;
	b=hFVsuyZ8Qq0wmZSvQ8EBvg4o+4Tu1xhpnGAQHMAFl0MSfAIzIz+9svNSnnIXmTZobxa4
	 uknM9eIcvudJ53vPW+tz4QvxzmuWF0hEJZcIJpD0sYG6sJcazUnDmPo7XUjla1SEfPgPr
	 M/+/dx3Zdv0olhdiDNAZNVOZZ0NQXPEfMvdEewmiUtSNzfOhjI7trybLGQkHOQN9xgywe
	 11OhOPEUV1ZCEKH/2ZB/O/bQQ2Gygc31rdLXX6xZHnBxhgF5MB5dhh24KHRMsJm4vkJU8
	 54Y8NgRewblcjY5HlCV/Mpn2Z4PceRcezCQ/ZabNiZvWeLNecL9k0TYX8lsWyLVklYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcBddydv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA2606E94B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcBddydv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF66F1F00A0A;
	Thu, 12 Nov 2026 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471319;
	bh=uZZ/RA1zPCfCU5K9Tt4iqVnW4BOixVxPGoMVM/B9JUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WcBddydvIJe+B82vW7wXrbz66oaixS8cymWsFCzCMvWD8CTVXKGIODpGA7mTm9gkp
	 +GLAJZ+8ofWTN5cd8GykHmB3WyYIjUM9iaHA9/SMzlNk7hXYLQF0fpkwazrmXM5V+Y
	 JAPlRR7+y/eeFurZEc0/I3+dHQzfgYMovtIVUqB3xWTokJ/h9W/eAlUfaRRHL4PKkp
	 ZkCv67CvAf+e5avaKhgWiQCobOYZIhh+51y3QTeFnG/kUwj/PQGQ3lAfGqD2HqvJUJ
	 i7DcXRnngNnObbRcxlONhNcJ/wN4N9QI5TDxe77PH4X8r/X7Js+/AsevQlSin+neZh
	 uncJpkOsPQBLA==
Message-ID: <sashiko-outbox-210681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: propagate evsel__set_filter() error in
 trace__expand_filter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112080924.2082-1-gubin@cmss.chinamobile.com>
References: <20261112080924.2082-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:15:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> At the end of trace__expand_filter(), the return value of
> evsel__set_filter() is ignored. When the strdup() inside fails with
> -ENOMEM, the function returns 0 anyway, leaving evsel->filter holding
> the unexpanded filter, which still contains the symbolic constants the
> loop meant to resolve. The failure then surfaces later and indirectly:
> evlist__apply_filters() passes the unexpanded string to the tracepoint
> filter parser, which rejects the symbolic name, so perf trace fails to
> start with a filter syntax error whose real cause is the missed
> allocation.
>=20
> Propagate the error so the -ENOMEM is reported at the source and the
> caller fails immediately.
>=20
> Fixes: 90df0249c2ea ("perf trace: Expand strings in filters to integers")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112080924.2082=
-1-gubin@cmss.chinamobile.com?part=3D1

