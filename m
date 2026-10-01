Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F93CF21F
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833646; cv=none; b=K/o2h3CRBV4UQ2x1tqeomXUXm2n5+V8l7mZXGYULUVRyHHBkboMC+GVot8Hdv7e9klfezGd3XoDMd1AVvKcTdLz2QJIVaVEtWkoYJrz6TL077pZ/nj0avthsis0HmqZ9p1retMbhAs+GEIa86SN0WWkXZyh7U8kSoamlZOICi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833646; c=relaxed/simple;
	bh=/TAsCLR1w4lt+7rtDWmBKRRP4PbUKQ72AW2pyGJphro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2M/qXJyUXzpFBxsXyoSUDnP8CblbBUxPWBuG3GlgAw4Qsas7nem9XDNLfsndVEf2pL/NFxe62U05fOj5slHTMlGcnPajf/PF3EiBtDsIKUnPY3FIKEXRn8h3P7HHuRMcxK+49UD9cu+4wSxKGoQgqJ9EuCzGejwoPx4Pn+f6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmgguPHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmgguPHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF5B1F00898;
	Thu,  1 Oct 2026 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790833645;
	bh=/TAsCLR1w4lt+7rtDWmBKRRP4PbUKQ72AW2pyGJphro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HmgguPHshhfaMVqpveGWGqz/oiRhGVgoI5ziSWpPxNur35avLl8CZIWLSNTcj4Ql6
	 5FwSax+FgXmXR0oYPxPlSHcTx++DOihMbGMRglcgmm2ARspaXHOO3blNDFmQR0lBhc
	 VqpFPSXW08ZJv35XuZaTEL/KEY3N2vok62S2E7boATHZP9omxbD3CJVjXtPeOzePWi
	 tVPELtb4ktXX8aFS/uyJlylWPOAU1hdVnAfvLiYSkeOZElhDoGUI0Nx6VpZ7fm6H90
	 aezFhGCYp8MSbo3z83FGkISb3HjNQbpnJcT/YodP34aENQNoHO1JgIMXTCH0LfFqmg
	 LSSe4hb6fy65Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf build: Clear GTK4 instead of setting unused
 NO_GTK4 when gtk4 is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001054120.1570943-4-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001054120.1570943-1-irogers@google.com>
 <20261001054120.1570943-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 05:47:25 +0000
Message-Id: <20261001054725.6DF5B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 4751bddd3f98 ("perf tools: Make GTK2 support opt-in") switched
> Makefile.config and Makefile.perf from checking 'ifndef NO_GTK2' to
> 'ifdef GTK2' (now 'ifdef GTK4'), leaving 'NO_GTK4 :=3D 1' in
> Makefile.config unused. As a result, when building with GTK4=3D1 on a
> system without gtk4 development headers, Makefile.perf still attempted
> to build and install libperf-gtk.so under 'ifdef GTK4'.
>=20
> Replace 'NO_GTK4 :=3D 1' with 'override GTK4 :=3D' so that 'ifdef GTK4' in
> Makefile.perf evaluates to false when the gtk4 feature check fails.
>=20
> Fixes: 4751bddd3f98 ("perf tools: Make GTK2 support opt-in")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001054120.1570=
943-1-irogers@google.com?part=3D3

