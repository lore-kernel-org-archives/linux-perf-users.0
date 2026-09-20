Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09D3CF21F
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882192; cv=none; b=I6PCobPlZVuAt+BYcJmAzT5mfo/+Yei4kpULnFqSvRejalXTVMNaiuYEOx48neTHBvIXh0+fCwToEc8jj2x5XNgJs2PHPETis5iIstMh021ZMp0c0Mu0qYoiDOpAzeTR+LfskG2eFMnGx+63Ojeoc9EbIyaO5lUtwkgKP3GghuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882192; c=relaxed/simple;
	bh=Qxv3w7P0+RHMHWMeY++AypGHIsCyvEfs2M/hM9wDeHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A4WoNhdFVyxa6XMfEuGJlGvwH0nSEuOTtJ5XJZ4/FVZzPwwKBHH7WiKpvC7/KGl2301UB+utYOX4Xur/zr1mj3wXSsj1seOlEwj8dXsG4JhCj6YYlXPEQzEnlrJe0pvcpXTZj0iB3jK0Ne9mqI5Ym2KaP2LRrwnOjcAc/5eDGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwdtb8aA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwdtb8aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDF01F00893;
	Sun, 20 Sep 2026 05:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882191;
	bh=7LWBA8z1OzG/ThjesHK1gxZ1my8akEOdQyOqQHXgUV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwdtb8aA2bY97ahm08Q8layyBfDAJf2EaWE9ivSkr5WLC5VOnSc+cbx9zFFYvkb3W
	 Xbgh8V5hdLiJsTmb8y3YvUiiX3FEgkqv/qnaP80fDKlwUwLwd0g3topcAU3EPDvIym
	 jU0zqx/9l5VVTuKdbSFiy8ECWwItXRlXsU21wz143BOSnewO828s/z2Yk4cG3bXlm3
	 OQAG2hP4W09J8ECMIn+OU1mHqUPNTwfBuidJV4hGOhh78cci+9/mjYZFnCgmwVyEMH
	 w1WBeRsWs87XDrtjdVjTLDqHu/tYFYIM0wwaKH/AVErraknK32qbOnkOuIicE44Oit
	 mXp1BnrSzMP+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 19/49] perf python: Port flamegraph to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4d2311a64b4bc573451b3a51be2b7eef16d58d00.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <4d2311a64b4bc573451b3a51be2b7eef16d58d00.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:29:50 +0000
Message-Id: <20260920052951.4EDF01F00893@smtp.kernel.org>
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
> - Add Subresource Integrity (integrity=3D"sha256-..." and
>   crossorigin=3D"anonymous") attributes to external CDN stylesheet and
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D19

