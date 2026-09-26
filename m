Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADC38AC9A
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404221; cv=none; b=DB8B5YYL64pPQS7Wv4tsRAHEZGHRxo8TvFc+OFqvne6XKDH/a1QqEpsu+1vw9eV6rJA/koA7/sx4jGP4UIMc1aosfvLwwq1r+Kd4IQ6LYXzgln5/mGbY2+RqmIIXPiPTfIftXQXo8qzdapgTTVKPMa4aKEnf1exZxZhkQe6llrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404221; c=relaxed/simple;
	bh=l3btm8COzOnMGi+N3wsb9pAc/n7SlGHSX5GrmU+csTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3px2y+YPoQfiHa8ktx4ht59q7fBhw2YFAdW5ZsMcnzPCixk+8X+P1EJ29dgj3Y1hXGD1+jRFEiZ08Sxel72TYTmigtw+L4YiYaLdMnlw+d65wofhOMO756j6bQOMbiwRRLGkAkDPP7/ft/E4hWclagHxmjS6sM80RenHTCf0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+RZUZbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+RZUZbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF711F00898;
	Sat, 26 Sep 2026 06:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404220;
	bh=+nj8o0Qt1MWtVsHWviUbLthUTp4uK/6T+w+aC76FUq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+RZUZbqW8WCjJY0ZQUcb4kvSfELQtmR4KFOeWZ+eA3IYlhvx++RJE5MFa43vuWBV
	 iZuSOLhvWNdKFZGraWte158DKA5g2+WpLrBu8KazNfBFN90RWZ+ArnTDW4buWrqytc
	 5+5RNn6yKSiSkbvDTSSJkFGWPL8thC8XKMHv2qVbQuwSPnCvSOhNPlcmCVf5x9Z209
	 tBHdBIRrgHpnajVxcDxodf9PUizni9vS3VWajfazFczWE8rDShkmoIak/b42YJIRzp
	 EGQpPBa9+qBlyLTaDHuKG5KZSgNHZSfMB6l3//GjGicO4rKJ2BbH+GqJ6NTYD12IJI
	 kX5OQv1XCvQuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/49] perf python: Port flamegraph to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-20-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:30:19 +0000
Message-Id: <20260926063020.2CF711F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D19

