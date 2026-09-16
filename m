Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550429E10F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519933; cv=none; b=f3XIh5TAm81FFFNMXRlmsN9it5sEGxwYDLI8p0oAa1T6AQ2egWIrp7c+Hd5Qjh/y6MprxGTjgOTH9wRlnXo2yBJeAs6KTzgWKXCqKyRzMNGGloMk2U8DaElnX9l6+mv5XTnX+MluKLR+LiegmXSbJBTZkr4qo5FRxMTJpVyFLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519933; c=relaxed/simple;
	bh=fhcaAm6FZfU6WVab1RumULzV1uLYMVmAL9rKpFyq/1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFM1zqiWrHQx/6I0u2yaAsG32Qsy+80VnAcby12wthC8/DGunMqOnBCzUZTyCprUEW7xh6jUz7Cz+YQR50l62qRkp2mcit/GW0CPC3Ftv9voats9I5izv6BVzRb3ft3DKILgLeegVEU/AfUmCCqiMIQ2/aMCwYpofFgAaD0FNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBO4qGVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBO4qGVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECCD1F000FF;
	Wed, 16 Sep 2026 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519932;
	bh=dfdDIDAaDKE4FKDZmC3wiVY149B0B8l2qMN9Z/SAPTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UBO4qGVutSKDZX/kVi9QSnTj2KRCDIriefRs9br0c1zOp2cyrkoRQHJ2NvVH5kqa7
	 mNWprlhI9QIQrP4L/NFBbIoe1u5e1OA6KckQO87WIcKj3Rwvt7FPc+nqx60UMcT1Ak
	 exSZnTg7ZpinK+Xh3PktpwhawK73SDYUy7ZaKEgTJ9zbHcGDbBVTf/3f3R8b/N6DSo
	 76+IqDaDRbXM2O0OfpK/Kg1IC63LH9nPQvNtAJqHgCjiK4a4QgGuFkFL0PnbU8Rs5B
	 s8YngDVEME6/rsyYfnY0TAhFBRUuvVkoFpJJXK7PtIDdmZplmcrmTgPZ7/qNaeyX3K
	 qKVjnVsnQyvyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] perf/x86/amd/uncore: turn amd_uncore_ctx events
 into a flexible array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916004516.268192-1-rosenp@gmail.com>
References: <20260916004516.268192-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 00:52:11 +0000
Message-Id: <20260916005211.BECCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The events pointer was kzalloc_node()'d immediately after the parent
> struct allocation, with the count (pmu->num_counters) trivially
> available beforehand.  Move events to the struct tail as a flexible
> array member and fold the two allocations into a single kzalloc_node()
> with struct_size(), dropping the separate kfree(ctx->events) in the
> free path.
>=20
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916004516.2681=
92-1-rosenp@gmail.com?part=3D1

