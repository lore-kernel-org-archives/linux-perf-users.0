Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF836BCED
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822419; cv=none; b=rA8OoJYqDbGNJOw/2EcwgRmTKpFGN4bKT1qgoqDApL2wpFQt78dQINxhz178DEMDhoLS9RhelDweVN96lVAPRw2R810B7kKx6XlDBBXjto5vGy42wxpjAB+oyM3isbmlnqQD7CSRncR/wVTP2QrNiPCIKrjBAS00BlM8XG8qngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822419; c=relaxed/simple;
	bh=mJpQji0kJ8FLTkKjh8hao4jqR/rAnl/7L+jmaxgE3wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzrFUA06C3TWYB8P+2UFRRydM1JOQgkzU4S6iQUjo+V4kIBgGAnTThYj73WQFWmRuFimwIV4CD7cSebPHeG8U/fvSOq/IZB9k1hk7OjuUFTnq5bYWE0/Z41iuzU5le3HVvZfXXTVW9ocakJ7VMYENwd8uGjxyUi783ObCMAdm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgRraFjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgRraFjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ADE1F000FF;
	Thu,  1 Oct 2026 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790822418;
	bh=mJpQji0kJ8FLTkKjh8hao4jqR/rAnl/7L+jmaxgE3wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgRraFjOv7ugw8+T0sZFlZ3e+KNNlbyoQtmLrVJFJ+oq3fqtmFplH9h6YJgoKt8yW
	 IXa0xOC5Qu2qr59TjJeJv8crkRrHffZemNvmXKTY8v+XnHF1PtkW/+ah4g20OQSUCC
	 uDjV4b2j9C7N2ii2Fa1XbL/GqjdCt6T2RwAmbfSoi+BxgolR7y4PdOjadOP/g3P0En
	 k3SMB2EKsal1ILUDUi80RZGPmuLB2APmiWGOX+QKLXi7Kc0CwvQMtAF3oz30KcjRxU
	 vPuFEqiug38NHQTs8bruuJM3f+bPWLmaS6mQocDU/t0bk8LWRWCqQl7xtBqCZTEsTy
	 K0FZY08v9zsvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf build: Clear GTK4 instead of setting unused
 NO_GTK4 when gtk4 is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001023423.1225713-4-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001023423.1225713-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 02:40:17 +0000
Message-Id: <20261001024018.28ADE1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001023423.1225=
713-1-irogers@google.com?part=3D3

