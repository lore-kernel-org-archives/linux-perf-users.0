Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05723A5E71
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404577; cv=none; b=o/L3EYPKsLzSTvdXtxeMEeWSXKPhkbs6PBNuy/Z1lueekd5WNYnBSrgq1IkL6Ktf8wMnjbFt6OHmpoR/NXOYcykNFyRszjsDt4GHIk5eK+kGOxEzTaVZBB2A0pnBhOkfGDeRnAPPXg+1/thD1LMBZwabqf9SD8Jb1/VL9DRB4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404577; c=relaxed/simple;
	bh=H3sK7eDKeNX0ySt+PcmkO3xXXQo6jud4pGqIWROe6PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HtOVrfcYXbCRfqWDJcr0NXdy91GbaLworPAkTD9a/8Q8UTdGRGjKY75WVUPkoWOpRmAI8oDhWMtDYv1U3MyQ1IiRJkLVHFY53FRjUTcP136sGwU+JeFp7xVg5JQaz9G1n4JYD+3BgMf2pCPvVDCuZsyntbj1cqoN8IrTVyf3NAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czCEdVeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czCEdVeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9427E1F000FF;
	Sat, 26 Sep 2026 06:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404576;
	bh=oF2bZElPb9W09zvSc0aj8X62kYexrkfe+UCrxZzsbkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czCEdVeLjMXiX4V3tAEw0PkJ/IgRFNufaIVD3ScGU/qVpQPKQow9oTrDyI/2GT+fD
	 zFMoumv3MJ0oTlzwgEpg8O9sKkDo9rd3MKoA/cpWsxG0RJFBh8KO24wYjk3+p1SuZo
	 aLa4zZV4iTAyW1LEwP9zohhnJ2ZBLIlXCSZBr21epDuql03t2gHeJABiSR2bPrV9vk
	 nSMkx8ChAst4hyX0ot0z2toxCdDWiXBkTmoWf0sAR/U7fuIiRbvBWwpqeSONfY07Ss
	 w31hxSvdvzCoB4vpXn2szD2lqYEDNLpMQ35dmWDCOzLAjANl6sXsMf03kAxgr4Ewpf
	 EnDCYXcwi+o+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/49] perf python: Expose addr location,
 transaction, and context_switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-9-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:36:16 +0000
Message-Id: <20260926063616.9427E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Expose destination address location components (addr_dso, addr_symbol,
> addr_sym_offset), branch/transaction metrics (branch_type, in_tx,
> flags, transaction), machine_pid, vcpu, sym_offset, and context_switch
> callbacks directly to the Python extension.
>=20
> Also include supporting fixes and infrastructure updates in
> util/python.c and perf.pyi:
> - Support fetching sym_offset on resolved sample symbols.
> - Populate sample machine_pid and vcpu from evlist__id2sid() when
>   perf_guest is enabled, and resolve samples against the matching guest
>   or host machine.
> - Expose next_prev_pid and next_prev_tid on switch_event only for
>   PERF_RECORD_SWITCH_CPU_WIDE records (returning None otherwise).
> - Wire up tracing_data in pyrf_session__new() and update perf.pyi type
>   stubs (including srccode() and insn() return types).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D8

