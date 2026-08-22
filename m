Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D622E975E;
	Sat, 22 Aug 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411775; cv=none; b=NdwsAPpEYQVyUxu5tH8By0zdhSIOq2c5kQUMqnCzenBmWXGtlFFKw20CmCMpSiWKXYqSl/YqlJ7UAviKsi2iLRt6UZKD/7EwwwXLfSYPryPFPh/PC6FLxCXk38h6b48UteuT1obPqUSfy6HbPfBbjD6kDqy773AdliTbJ+QxfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411775; c=relaxed/simple;
	bh=aV9SrxxAD+HhOJeo33umeakE9lubLDMmgqa9IB4GFXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSaG2WBT7AN6pLjasV4P5YeNY4/yh97zNGoxaSO5qq7fTiiKC7nNGLGFNwHuQE7h2WABQT3pbqBcLN17U8W8IT0WWeVBqCQ1XNUOBEyXRL2UbG4GzBg7cU7llrIiAddaPg+LE3z6F4IOc1jjfo8i1Ea10aZLukPKKagSxtsRhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYE/Mq1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYE/Mq1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A561F000E9;
	Sat, 22 Aug 2026 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787411774;
	bh=aV9SrxxAD+HhOJeo33umeakE9lubLDMmgqa9IB4GFXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lYE/Mq1D04GPIFEumvLDTkTRyEz6RqlGH6LV1oz2gGw9MiTl0oXzYI/A+FqZ7Ya4j
	 4MiCLEVxDOiOAlv9JAGt1TRy4e5X6xK7UWSZc5HPgu0ZdNxGGHskXv6NmMwi/0WnJq
	 4GdXIjs+8F6NZl5K0qXv30XkDZjY06SsLEBgHkW5R07+qtePuwwWlLaWxblbugGKyu
	 X5hShRxtE3btAWSNZhhWnP6D3QX4x/TIJKSotERVTvqE+LHL03+i/8Jt5HdD4erm4t
	 9Kt1A4PYaB4mFYKLz0z05ZvMfGxP6sU++7ivGKqW9AGZ4yRsLNhDy3Q2mRYzC2gkxP
	 wqcI58YsXGzqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] uprobes: Free utask on dup_return_instance() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keke Ming" <ming.jvle@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260822150906.528208-1-ming.jvle@gmail.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
 <20260822150906.528208-1-ming.jvle@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 15:16:13 +0000
Message-Id: <20260822151613.D4A561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> dup_utask() installs the new uprobe_task in t->utask before copying
> return_instances. If dup_return_instance() fails, the partially copied
> utask is left attached to the child task.
>=20
> Free the partially copied utask before returning -ENOMEM.
>=20
> Also, dup_return_instance() copies the return_instance before fixing
> up extra_consumers.
>=20
> Here, if no deep copy is needed, clear the copied extra_consumers
> pointer.
>=20
> Signed-off-by: Keke Ming <ming.jvle@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822150906.5282=
08-1-ming.jvle@gmail.com?part=3D1

