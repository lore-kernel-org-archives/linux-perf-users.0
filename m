Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081503B9DA5
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109710; cv=none; b=bMpRBKJ1kOh/BYAvCJ9jY3D6fNTO52c/YtNWfaKbc6a8Oj03FdYEKjtoCezqsUQLBCi/czoi4fJgU2BXq8JggvvWOSf7f7xFU1oHSdXSErzCNB5eHREG0Flyu1EkxzbSQet96GL8r86iMCeHIlgpEqmAtLUrAyVPIrRfqQZ/104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109710; c=relaxed/simple;
	bh=NtvGwa+R1i1EZsFRwesCXOOtnAEdqqu6NuTwgix8ELY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZyZrrVrgY90Vg6KjLqIILrM6CmDNbTXEijtacpht0w2TMFERSnqRi9Nvqaw/YB66wzuDWEcXIKRc1aMRLGuFrnf/pe9G3ED+fDAUdvKo1qKwC8AkgJA2aNUNDpfZd8NyQzz8XKNtCcRUjXFX4MvM9jSf2ChTZjLcTSmlXVcFB5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meh62n9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meh62n9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEE71F000FF;
	Sun,  4 Oct 2026 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109708;
	bh=GR3xDykIqzYgnD4490X1l2YrghrTOsreHn+q16eNaqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=meh62n9SmmiPgR+BcEA0RBVZmacE9EDvSzY/kpdxe6Jx8A4HNv9U9vPcxn1yTNpKz
	 YR6UyJjdvLIyqUoNZjr/ydoA4LFG+yjbO/Z+mb6LT68GWJrPIWugVogSvADbiaj1Kc
	 PrsJOEBJhm5AEkZX10yYgb8a/hK6WPZgP0LNB6HRucaXqCPcB2PiZ107rxbUim3csA
	 JsQ5r/59Y7x0acB29tQhrUg8nY6hVIEh9GpJUJaZ06yE6tvUM8uPEBe/RuD9KwdESr
	 tWQeAEpnYVaHC7MHktjmFlgaz6BgQKE5Zn0H4GVU7VU5xETFlqG88r9FDD0UCIbuyO
	 5Bg3r88QeDTrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/9] perf config: Make perf_etc_perfconfig() never
 return NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-3-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:28:28 +0000
Message-Id: <20261004102828.6FEE71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf_etc_perfconfig() returns what system_path() gives, and that
> allocates, so on failure every caller dereferenced NULL, the
> pre-existing ones in perf_config_set__init() and in the daemon
> included.  For the usual absolute ETC_PERFCONFIG system_path() just
> returns a strdup of it, so use ETC_PERFCONFIG itself when that fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D2

