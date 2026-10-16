Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C73C10A9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185852; cv=none; b=lcQKcaQRsECL5Lzs8JufzJRYoS6oZUa8tevvc00dJraO8dXAnjEgZqAD2i2zobPU/9xiuGAt6nNncCPYtvh1NnP7T55CBY0iVhuSkFBaCZmQZmKWH82Cnuao7TMtpGisiYeNt5zpNT3VLHv0hlb3DbxqEBzU3YIX8E1YvATZWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185852; c=relaxed/simple;
	bh=cklO0UqgU8N/WydPKV61va2F5VMUdnFfREY+Gg9t+xo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MnVSr770b0ybXXQXP2zb8XGOJV8SclUxv8pBpXlzE+CgtSi77aethOe7qsl+TQMwYTYFuKuJkRM/scuCooSQ8wl9aiWpjSCHbW0qmUOX2pEw4ayk+E5ALYlKf72YoVGfJ3BLtrGJB8Shgn/X/sgesERy+INhiat5nBEu+jzZxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neXXLquv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neXXLquv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5871F000C5;
	Fri, 16 Oct 2026 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185851;
	bh=cklO0UqgU8N/WydPKV61va2F5VMUdnFfREY+Gg9t+xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=neXXLquvUyuQRqz8Wi5rd2JIqXnXDclEHhGKjYeWgzOMhIYGWmyNC7fo6E1V7AM/Q
	 4rwVUom/wd/lrXPGE+5wiAzz0m4B6D5xL2CxyWaRoNX++ichmUuZPrvj2TmA5MVb9T
	 Des/Uvk21Nw/jAC0U8wQ5MJWCZo/5NwfWYZ//9T2hC5f23LR3BqV8tNsj3WLV3ur1T
	 n8eWtkwVVyVyKZanpt3GU4eoShuijU0JzaXnZ9ePg+BXw7kHnMTutah2q+7WYTfcyI
	 +iMOeOZeM2HbXHhWXDKjFR3P28Ib6dPrl8JzedJbh5d6EzoniXaSxcFVXNY6iQvpuz
	 ee303Keuf2MGw==
Message-ID: <sashiko-outbox-174956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/21] perf test attr: Introduce mask_bits(),
 generalizing hide_core_pmu_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-12-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> What hide_core_pmu_type() does is take a set of bits out of each of the
> '|'-separated alternatives in a value, wildcards included, keeping the
> rest of the expression: extract that as mask_bits() and implement
> hide_core_pmu_type() in terms of it, a prep for using the same thing to
> ignore, when comparing expectations, the sample id bit perf ends up
> asking for and the read_format group bit that a PMU count can remove.
>=20
> No change in behaviour.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D11

