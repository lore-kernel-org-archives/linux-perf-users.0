Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607182;
	b=fQjfJbGCToNlJW+ensWEgjeauno8cxZHP67nfFabcV5Q9JxrX5OyZ4hnksT2DM8CNlQq
	 8vdtwmZEa1SJAdo6KAgtxvDjcOjDw2w0agECi0OaxyNYQsatuqYASHjNw2xJVMcO3iYj8
	 Zptf/GNTE1HKZAnWwJ53iCKH1cgOb7+hj8Geof7ATJaCdCMU3t971Zz5Exu+71o3j1dbS
	 u4MFmzpS/bsAlTHlWXndMkMN0h3OpqrkY8xGM7j1J1RAS4aNUUU4BOfThyZ2FWDYnviWX
	 v6Qtv3i9vHvhbGluTXcb6U3k/0iRrlj9EV2uvcgx/FCWPmGJlWI2SUOzxSy9rtB0EBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hWJgkJbJUk6jtsBOErgRFKtUI3a1T6x1N2vNzE/5VyI=;
	b=adrrEHqK/vP2DSYE4HVUBHoLp2bQW3msIEBFQ7l2wy+f7kefqG08/NvHYKkodnFlKxyF
	 GSFpnkY4H9JxdVnBO6qAIt8MVDUq/rxRqRbiRcEe2Ts6Z/qJAet8PJO7rarYxlAnP0EQj
	 r99zK2maNCHySPc8OIzBZmf2XR6Zlb/M+8E+5dVbOf0FmVxQLvuoJwPwnZnvxrUXvfw1Y
	 LPKUyUDMx82GjrG97RHZOw9thBYSx4HGqASPB/zyUfZEBf5lxOMbEtcdDeEqrrwckYG+p
	 1MtvBNmiz7JV5sdRvhW/JxdAqDr2ds1V5pp3ytKLGmcua/GwjgeD2TuQbsD4Ls4fefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvOOZzyV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6C606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvOOZzyV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C81F000C4;
	Fri, 13 Nov 2026 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607182;
	bh=hWJgkJbJUk6jtsBOErgRFKtUI3a1T6x1N2vNzE/5VyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvOOZzyVwmlSbCkN+X/SuFiVr7BFCK24x8sFWVL4uPX6prlbs+ids180NHB6K4IQT
	 Xmsq8lryQMvTZXAKqxHFu17FZR2rBwSFjyUp9eTAVMrN4UdXl6pegAxMsFKySyF4KR
	 GDshW3QLKAFSpj5lV2euL0g9YYpihSVVn1zx25A2Lb/1tLCDsS3EbvTnoyrHZR/BAR
	 O2o137kdNaXHMEOHu8BzWgwcDroQrEP+4RHeNgYSqpEUI1P8qv3me8Ad/QcPcJwZ/J
	 YCGlVSTfdPfDAmNOWC3XK+KoYvYWuYWhm5kq534kpX5w2D8QKlMsmmn1MJxkiFkmT5
	 Rb2ozrM5a1v5A==
Message-ID: <sashiko-outbox-213761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 24/26] perf inject: Use generic hashmap for aslr
 top_addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-25-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:59:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert aslr_tool::top_addresses in util/aslr.c to
> DECLARE_HASHMAP(top_addresses_map, struct top_addresses_key *,
> struct process_top_address *).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D24

