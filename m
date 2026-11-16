Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813030;
	b=PyaSd4d8n07rAvwtT0Ea+JzWQ1lBkJkqAH6np0itH3PceDYiqKZaFHvFHv4GaTH7E38g
	 4AVZbMZnxNxMdNZ9U7x+M2E2k5dgX/sK85lTAWKl/15US9BI6GazP1Y5gUyE56ySywv8H
	 bSu/48ArOTW1UuL5ryAmJcsM1hOLYu3TrIbdVL4DO0BdYHMwKWbM2iSX2QYukcNRFeAq9
	 YkZRcfaTklTWlxA5weBH0cgG6HjQNyBMMpQJsyS/hcUCef7Q7yjcGriBMIGbYqH8MGRP7
	 st3PJ2mK9TGYISYQbGTvLFZWm/4HLw2pmsCXEH5BFiKoen0TuF05ijHx4Fa5wkEU9pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d2ZgD1XwT8enu1do3gwTV2eZJSru0tCLQmeo5jHRfJg=;
	b=XCylf0Au2uujL74fTqtxwjtyJnU/z73/56hSYZ/Yin4cryNlEIwFq1uxunB1LGG+exeH
	 9eGzrudsMyKfXes9lplndWUpIz6EV/s1V79T0WQ3E5R7Nxt9r/eSjO+z1jKU4splpRZD+
	 pw2fuafP5iz9HulJnjijh0IPlHaRIIjlSUnoi88XhFJWFrDMlyQFsis0XPiFJQAq3kBkR
	 o88Bdj8R+MRUMSGAOyPswgGr4unxdan5QjSC/asVtpAXCuitwgmD29xUXF9SM5E+jctqs
	 YPIFG1kvfiw7q1/kQ27lu07H9Ufz6lZM5iKcpw+MMGpOM3O5UUacpcRy5qh8h2RIa/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="THlT5qu/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83E606A32F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THlT5qu/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E6C1F000C4;
	Mon, 16 Nov 2026 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813030;
	bh=d2ZgD1XwT8enu1do3gwTV2eZJSru0tCLQmeo5jHRfJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THlT5qu/c0Kt9Ori0UWQ1yGNIkvHcFbvOw8NNYvFj8m7yYpxfYS8vNAYbSSAqQ/QE
	 Y09soUqEdXDGa9u9sGs865MsILFHQbgNENfHCwk3D0zZmgHl8xzxIjpKhlFBu+Ko1t
	 +7R8baLKA2+VtkUu4akum2psffurkgfRyQhlX1lCYa5PF0R/Of5JC+gtJHYQ95WBUj
	 zL8YurlYB667VtYXFetjvRvFY1vCbXeLQb+IUBM1Kr2slDgST/EiAErXQzFfFWqI9b
	 NUrMI7zDcvxC8Aa5HqRX3A3kLBtJYc/7Ne2FGkEsPBeE6i7THLKMK1g3RBiyBu6XDJ
	 Jbk+mLUOUJ9fA==
Message-ID: <sashiko-outbox-216390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] perf build: Enable jevents string compression
 when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-9-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:10:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Pass --compress=3D<available> to jevents.py during regular builds to
> enable block-indexed string compression (packing generated PMU event and
> metric strings into independently compressed ~8 KiB blocks decompressed
> on demand by (block_id << 16) | sub_offset), constructing the fallback
> list from CONFIG_ZSTD, CONFIG_ZLIB, CONFIG_LZMA, and none so jevents.py
> only emits decompression C code for libraries actually linked into perf
> (e.g. falling back to zlib when built with NO_LIBZSTD=3D1, or uncompressed
> strings when all three are disabled).
>=20
> Expose JEVENTS_COMPRESS=3D<zstd|zlib|lzma|none> (or a comma-separated
> preference list) in Makefile.perf to override or disable compression, and
> track NO_JEVENTS, JEVENTS_ARCH, JEVENTS_MODEL, and the active compression
> selection in $(OUTPUT)pmu-events/jevents-flags so changing build flags
> triggers regeneration without rerunning jevents.py on incremental no-op
> builds. Also cover JEVENTS_COMPRESS=3Dnone in tools/perf/tests/make.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D8

