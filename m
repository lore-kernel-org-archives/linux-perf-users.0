Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A33101A9
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969370; cv=none; b=I5aaXaHuhbaIxb3TwOr3fxLZVEN4YYjfw09J2QLnC+1T7bdbb+Ja4NAeDIKTRFZy62RbEUACi1T3xroqhTvvOI4vg2oE74mYw5Bs8wq9JoBnHtNpkfIvXcb75tZf2gjh5kvVuvHoqVpFTKRemR3G59jjO1qTVO8HDQVcJ598zmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969370; c=relaxed/simple;
	bh=A0n7VrAvkfOBzudWgX7UE0QrcpNTIX3CUAmCI7UAF8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFVWBiVaLS7q78QtR6NfvW94+6CkU5AG2umhxCgv841YbryJF3sfPHhh4DWgzNSWSmT5FHIOahuvd/yyJfuxzIUHJ7cG7MUgfnH+ucQi+UOa7rx8iSZr0ShDiYcGvw/UjzFS7zaVnCMCU86eHlHlMfSvx4GtkQQFADKU2g9X4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYbCcUoP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYbCcUoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF5A1F000FF;
	Mon, 21 Sep 2026 05:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969369;
	bh=W/fR8fDy9nmZLVjZZ5wgHZWHJLZ/ZW+PX0Vb8ptlRv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYbCcUoPsG1C8a4hKLLwH+Y4LE3TkRLio0CTYDhC7swYsQxUdJ+yOfUatJWSLwqx3
	 sqnt17znahYsehlqMmzzkT4AwQbjsF9Nqz21JGtyAL8/MRL99D8S6JtR8cP6Ama4TI
	 FP7Drg7wcuBuQ0BDBYDP4F5RixgfX4isffmYPGs0BGT9oo0iYI9L1ppIvk3zO4OuGG
	 bo9aFm1B2NrV0j1tryXrAqQOkhIMQvaFT2xW2MqaqYG3VpAp7dvkEwIpe9ZmNNOkS9
	 /D2r7a4NXPldhTB5QFvhpzQnPpT7JPbjFg8lwMVN1V5wPjRcgVhmugWvr+wLSZ2OqJ
	 Qv/ySq4hUBzKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 40/49] perf python: Port intel-pt-events and libxed
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4d33e1434e2f6dacdeee2d8f891fb03ea32eed20.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <4d33e1434e2f6dacdeee2d8f891fb03ea32eed20.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:42:46 +0000
Message-Id: <20260921054248.ECF5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port intel-pt-events.py and libxed.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor intel-pt-events.py into an IntelPTAnalyzer class with full
>   type annotations to encapsulate trace state and stashed output.
> - Configure instruction trace decoding directly via perf.session's
>   itrace option and context_switch callback.
> - Dynamically select 32-bit vs 64-bit disassembly mode in libxed.py
>   using session.is_64_bit and annotate instructions with source lines
>   via sample.srccode().
> - Rename methods in libxed.py to snake_case (instruction, set_mode,
>   disassemble_one) and remove Python 2 compatibility code.
>=20
> Add a shell test (test_intel_pt_events_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D40

