Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633579;
	b=H6YX1NE9aT+d1NMBmX9Fh7/dx8FauMvYkkJeIrUUzmdiPs/+M46EIDbWEiuc9Gqw4S4A
	 hwN/GgkO9xFK/GY41Fpiau9QO2LTbceev9wsFWcFXfZByovfn+/X8hL8oGUXjTdh4fo6P
	 9b2Y581sWO5vBQnSMgrUs8UejuYOYBHX8VavBBq6PttgpJXZMdUWOcH6g53+BJBnrB54Z
	 51Pr3BUzNuesnmoGdv2hs88cSt7gTWNlWkIYKoYRDADn77mMeJ9aK79BUO+AVHxmov6xQ
	 L2sKEAi4emzuI6sEgCJHzds8/HhGBgC03ctnEtE9+1wAPMnQ+jgUch3zQsFoJVehVoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CqK6LAzEHR6m7cruH/u2MLgHblxMLPEfHrzXGmNuLVM=;
	b=l/4nYxl2vx1cM14YHW4s419mOMXBJh3+gH1Zdlc8mI5ROW4HY/XGn0Va44AARWtic67I
	 3oReB1Ik4aNpZ/JKjob76spXi95mF0rZrp+TN9h9J+38vSev5pBxRXnpZ1RlGrp+Zo5kc
	 Bar4f4ZLC52e9Xq0KgCM7UCKDwEeM6ncjsc3DV7VXejKEvldqvLJPTUe1sFGsZMKlkzLW
	 yCrYN/9kJFPnn/L7BJHXIdsnIlV/+YwiMii+oLXavQ8qgalX5eA4vqBO6+0EnRKHungO2
	 zKK75azx2Ix+U1OlYgWpweFBHOo/MY7eeVSJUF50nhInuRsloeXVL/QUV6cxoZszjjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsMRFNLe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08D606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsMRFNLe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F61F000C4;
	Sat, 14 Nov 2026 05:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633578;
	bh=CqK6LAzEHR6m7cruH/u2MLgHblxMLPEfHrzXGmNuLVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsMRFNLe/btokCP+78+R1sa5zNETa9klFXsNpxhl/VribUCYWo2rUHnb4luES7ajE
	 X/irLdHrc2Q+AzqaULmrM2ZvVujeIjXDoOvfrn2Bqk1FIidNP65gfSdvU2ZCCTnLu1
	 Wz2Gqy+/88ET2v7w3NpUS6C62MJsYvDi2p6CTTGv+jrYhxGVWhFVgV2M70llLcBuNN
	 99Wc3uJUlvYIZJKnQGI8H9hopNm5OhMhYTg7hf+yzFpWN7EZVymQq/eUxxPCheWvXP
	 S2OO2Q1nmX+ThnYSD7XS5qJ3y7u206mrf+eK1R6oPimsT+2bNrXe/Y36APA3/PPDvZ
	 9Hfup/e0WXQMw==
Message-ID: <sashiko-outbox-214167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] perf test: Test lazy symbol name loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf-symbol-memory-send-v7-4-d992eced9f9c@uber.com>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
 <20261113-perf-symbol-memory-send-v7-4-d992eced9f9c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:19:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Add a "Lazy symbol loading" unit test suite. It covers duplicate
> selection without names, lazy names that take one or more reads or
> cannot be read at all, lookups from several threads while another one
> walks the symbols, eager and lazy parity on a real DSO (perf itself, or
> the one given with --dso), and a symbol table file that is replaced
> after the first name was read.
>=20
> Add two shell tests. lazy_load_symbols_parity.sh runs the parity test
> on four small binaries built for the loader's corner cases: split
> debuginfo whose function section is NOBITS in the debug file, a shared
> library with .dynsym-only symbols and aliases, a stripped library with
> .gnu_debugdata, and on x86_64 an IFUNC behind an IRELATIVE PLT slot.
> script_lazy_load_symbols.sh records a small callchain profile and checks
> that perf script prints the same output with and without
> --lazy-load-symbols. As root, it also checks that names are read from
> the build-id cache when the profiled process is in another mount
> namespace.
>=20
> Both shell tests skip a case, rather than fail it, when the toolchain
> produced a file whose names perf loads eagerly anyway (PPC64 ELFv1 .opd,
> .gnu_debugdata or a compressed .strtab).
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf-symbo=
l-memory-send-v7-0-d992eced9f9c@uber.com?part=3D4

