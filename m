Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F68498933
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299035; cv=none; b=uGT/alNp4lW4xhzsiRw9WoTnlP4pUqfmMsWAFhhy9OxWh2Cpr0HzhdAkxLagaqv5Aav28UUxMjSwgmsSpwY1RQlWkcFLflkRbvyUiJrMkBGhNJRS5XuixI4P0hBZHb/pQzqPNVIbcN+4dWsl9pLzbo9OlyRCsWlx4buYwLz2aHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299035; c=relaxed/simple;
	bh=gTsx0DNd0K6i1tldkJmQIdbMNxAbCce7jAypsxq+6T4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rSa/rj2AqZ749XUJCMFXd5r29ofCRQfA6eScunSdeJjzsiguVRuIHEXRu/wSf4hG+6EktoMlu7l1u11XswOWj3dlNHMcP2h1jLbOQ/mWn0pMfNcDAxYdYU1Cc7d6e4QjlRxItbMAXAFnAROKymivCsWLVUzIkhsXOjlpjv4vUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K17qDoi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K17qDoi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7881F0089B;
	Tue,  6 Oct 2026 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299033;
	bh=lvu1dobXhxkBPRg+r70eZHuwLQnufr4bczybcnWwEkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K17qDoi3Y+sh9ZprrZ+zXcHi1MtwHK68quP+NsBmJS04cSVVH1xq9vkm7rvaKhGQ3
	 q0RxFHHSh7mkx6ZYB3kZYW+QZY4KUzk1MKZWFZduGq+Qxo74b8P9lSvV7jXZVN401u
	 BK8D/mVd3VtdZ5vXgQab+crKliLHyyHkHlrSDFQ7MW6LMSUqRdPh1YRL7nNGRVrgtt
	 rXAw+ErhwuvbvDFsGkZ8retg1k9I4zsI+HixxNa14Tj5O18ndMnIIijWPIYxdYD9TG
	 iSxaaBwF4stEm9nq1wzzP+PQzO3JGYW5/tGrIdkbLpqGy0MhmRoPnOtQa5orBfOLB6
	 tLsMJfJT2/eZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-7-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:03:53 +0000
Message-Id: <20261006150353.6D7881F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> With a pager both stdout and stderr lead to it, so isatty(stderr)
> turns false and the updates end up printed one per line in the
> pager's output: use /dev/tty in that case, so that the updates keep
> updating in place, untouched by the pager.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D6

