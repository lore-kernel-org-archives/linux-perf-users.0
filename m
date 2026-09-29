Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B483390C85
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665483; cv=none; b=QMwqcUu3rRwetmUnCow01/qhWlxQBfnBNzldN/ovlUxABouGtjxuUJCIEuMc+s0QIeqAro9w7QmMNHiOvCt2bm/dcdD4yIOhhbeS7SwSbZhFuLjCgkRH1K25ALCcjhAhGbiWrYesmUC1okpLijWPBwsimTL9Jl0TI+wyrTEw67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665483; c=relaxed/simple;
	bh=BcpqIEcICJ50K3X0EgA4t0rum7+wUiCkaI+NdhKVVRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TDLK4U7LaboEpM/UG+zTz+LlPHLWnhmg72pDQqgBxwKerh8C9qzz0+CwybJGOZfOZdrBB8ozpWOKwAXHDV0660WcozumeWDP5m4VL6m3OGW6GD+aA2GixUfmE0wwJRXbw5hOkjdHrQOXurmx737qEEHXeV7JKpyLjpI08FXRuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4N1jAY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4N1jAY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE01D1F00893;
	Tue, 29 Sep 2026 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665481;
	bh=BcpqIEcICJ50K3X0EgA4t0rum7+wUiCkaI+NdhKVVRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4N1jAY04EualMVcJ78VjCxODF81OhlcSMl2BioFsXg1i2kDQnVf/Stv60hChwQ5+
	 MsjFE0lj8yQp10954OxXa8yp6W9ai2MC9blYMEh7ESBibF4K1NgxL32Qr2SZSe2yl9
	 U+DDRc3gJ+QxhRk5leokctH6metRodPP3jQhDJ/C+3mkUEXbPQFHdyd2a4aMcoT5G4
	 fqX+MnodlpNt4dWVf0z+aSewu8nV6lZDXikis4h1Kj5Sj7F6o9miQ1/Ig5HCXQ4zB4
	 TjYJk1EbAjc6XYgfsahHVMdAAv+c5Y9xn8a7yDsYVIN0ebcEqJ2LJ+OdyanDjBFXjv
	 ZYZB6CcibrksQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] perf test: Deflake failed-syscalls Python shell
 tests under load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-6-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:04:41 +0000
Message-Id: <20260929070441.BE01D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When running 'perf test' in parallel under heavy system load, a one-shot
> 'perf record -e ... -- ls /does_not_exist' without '-B -N --no-bpf-event'
> can exit in under 300 microseconds before 'ls's PERF_RECORD_COMM and
> ENOENT sys_exit events are captured, while also contending on ~/.debug
> build-id caching and BPF event synthesis.
>=20
> Pass '-B -N --no-bpf-event' to 'perf record', sleep 0.05s in a subshell
> after 'ls' so its events are flushed before the parent subshell exits,
> and wrap the record and check steps in a bounded retry loop (up to 5
> attempts).
>=20
> Fixes: b76c43d09b06 ("perf python: Port failed-syscalls-by-pid to perf mo=
dule")
> Fixes: 4e3fe6987cba ("perf python: Port failed-syscalls from Perl to perf=
 module")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D5

