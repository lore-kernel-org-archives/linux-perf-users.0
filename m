Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094E3B530A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805723; cv=none; b=kpWmUrSQg6CmUaqKSvvzvRK4SGeXi0UwURY5m1EN9+6tU+HIJ2ekh33TXua4k0Uqwid9J9DJpD0NpdvQwkcq2UBjyPocWuGN7yCDaTzTsdW2YLIodxGA4RrgmQ0f2JPbGTdx9GLas6ENMTRkuAYz51+8UJ2ObhBdsia9EyX5wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805723; c=relaxed/simple;
	bh=T12qymgwhx4BooNtj5OTZWzyGFQhvxJ59xA5WNWa+Yg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XguJUEEc0rYDMXykKOTC9a48csqp+ksXEIVjiHv0UXFm//UsyRdCtAAPHEZ/6bP8wlHf0Arn8Afpa6zdyJYf9jPukvkh/My3S6g1tScOLsHHs/wLYaJabTga1yquUuIVjjDNxOzJLeuRl+U+Mr2Jqr47wryxyfBetZhuHkq5B1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlFRbif4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlFRbif4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205201F00898;
	Wed, 30 Sep 2026 22:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805716;
	bh=yvXN0M26Rf+Y+cM9U2D1/uIzibZFIycm+P1TNTBVJKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PlFRbif4sBaoG/vsAq6HexKX3WzWJ6IppiQH+y77S8nIdUNwIcV6BUiAFJdSTbQ2b
	 drFlZ9VHBc9sjU1jAIQkkfoXp3SZKInOJWMD7eWg/oCMYJ/GJOFlnISPAfA2QamAkp
	 sLJvQYetr6wkF04bVixFRzKEXpaSk/xGJZZ3jRexG17zcgmw7cZOLMqN/wurz4Volf
	 9lGFOg9aERf6FlUp1xmLbtTTDCutkJKUoGyXm51wRlBv15SLPXFD7VXPaLoREOoOyc
	 667o2M4cta2grD46rPPpFAN32+0IoIHHD4PdfvsfrDs7uyh6EmZe3PXcAQ4NOY+bui
	 t+F+20vwrXhIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930213716.2633750-5-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 22:01:55 +0000
Message-Id: <20260930220156.205201F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one stuck in a
> loop, and there is no way to see where without attaching gdb.
> perf-stuck.sh samples a running process' /proc entries and its progress
> line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
> the perf-die-chain command) when no progress is made across two
> samples, printing the DIE chain a DWARF type chase is stuck in.
>=20
> It is a prototype: the plan is to turn it into a first class 'perf
> stuck' command.  The process name is resolved with pgrep among the
> caller's own processes only, as root an unscoped one would attach gdb
> to the first process of any user with a matching name.
>=20
> -i and -n are now validated instead of failing later inside the
> sampling loop, -x now requires -g and gets the same readability check
> as the default gdb command file, and gdb_done is cleared whenever
> progress resumes, so -g can fire again on a later stall instead of at
> most once per run.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213716.2633=
750-1-acme@kernel.org?part=3D4

