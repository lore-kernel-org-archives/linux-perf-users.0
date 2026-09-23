Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB838DC71
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188068; cv=none; b=n6v3xBwP0WWYA/cPd4/0F+4c+E2hzQpxfIfSab2LffHiPH3QysoX+X4Mu0HDQCSwkVK3U0qpk+lVaqZodiiuLJB2Yw20Sy+6qg+YMx0hxHabfvrie2L2d/z70n5JpkjHHGBzELFBn30LWWoAmYl/hPiK9f6fnKv1FGlJU807ABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188068; c=relaxed/simple;
	bh=Ll9RzEnzjo/BCm22MKVCjD+2fjNgRQz2/Cak9odFG24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iigbcjq5K7OCbrwJ76hHxqpgwTCnPw7mdd8hFRn0+uzc3jkLUlwxOJklP0WKxPeJXD58me4SaRathx3owkOKIhFznPNPaaoU2f4qtEbkp/iv/vILtSgHw956FX7MZlCWMHOexOkNtRFocCSj0Fwm5ML/B/JQkqBmf6f45fafFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OelrH6Gs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OelrH6Gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E90A1F000FF;
	Wed, 23 Sep 2026 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188067;
	bh=P5P+zQceazRHAYxfaV/xvrdG2XDM7LT16qKlaeqDLG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OelrH6GsUC0qhLXw5RFknpp1w6DmME2cwb5vk7V/COyEpCRF1R1LwpyQ7ygmPwF1B
	 S2prdPWLSAEYOZkXegYyLUBxCzowVS5ZnI0GFOedOseWp7Olh6qNzUociEvWX5txCF
	 1Lm2LmFQQvsxo9hpHePkRXo0/KNbKs90WoYqvlNg/ZG2m7ZTp3Ej1QSV/qPGtTbMfP
	 Gx1KjwjVUPJFYibX1UxMo6q2kL8BdRl92efV/TEK+Qa5uBteBenZkjoTkfiUGLVDoW
	 MOoFrt9e+4XMI8vrJOf5GD1dPUbpzh4aAGAZGNh0p06rf50BWejlli0OFId30FQMmN
	 EmUtKuUkRnj0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/49] perf python: Port flamegraph to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-20-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:27:46 +0000
Message-Id: <20260923182747.4E90A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port flamegraph.py to a standalone script in tools/perf/python/ that
> uses the perf module directly, avoiding intermediate dictionary
> allocations for event fields.
>=20
> Improvements compared to the legacy script:
> - Add Subresource Integrity (integrity=3D"sha256-...") and
>   crossorigin=3D"anonymous" attributes to external CDN stylesheet and
>   script tags in MINIMAL_HTML.
> - Upgrade CDN HTML template hash verification from weak MD5
>   (hashlib.md5) to cryptographic SHA-256 (hashlib.sha256).
> - Escape '<', '>', and '&' ('\u003c', '\u003e', '\u0026') in embedded
>   JSON payloads (stacks_json and options_json) to prevent HTML script
>   injection / XSS when rendering untrusted symbol or command names.
> - Skip invoking 'perf report --header-only' when the input is stdin
>   ('-'), a FIFO pipe, or a character device (S_ISFIFO / S_ISCHR) so
>   non-seekable streams do not hang or fail.
>=20
> Add a shell test (test_flamegraph_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D19

