Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D43DBD4E
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960270; cv=none; b=X2XmLL2JVASCjn9F9nk7qsXADVu39YLhiSH5zsVbvrvYtvVzgkCUxq1MNj9G9se+im4O+vGL4cw09BZY0q9A1xZ9zuWtaEyATxpaf/vAahl0AVtwZV4pcD/+Wn8EkW4bbVJuPfIEUfD5w86Slf3RDTM5InWkXKhan6+0ZlUnDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960270; c=relaxed/simple;
	bh=JbnY5ZYuqOOvaSyC3LR/bQpf1RlQB9uY3ePWqJ9UWto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uhYswfOn3K5NpgqA+i7/+4w57EeVxqLU34zHaQPHqX0l3GLBDFdfxSyl62COeRoPY+3tDK3mhAayBfJHdeTDv04FMI727Gl6munp9kN25JCd2MCyf+F+WCFiXUw9yK9lQPJMbyXPPubg0AQ7py8Q9nOVbbnwoEzlubSuDLVFLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2nX48RB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2nX48RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF151F000E9;
	Mon, 17 Aug 2026 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960268;
	bh=JbnY5ZYuqOOvaSyC3LR/bQpf1RlQB9uY3ePWqJ9UWto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G2nX48RBZ/UXjhH12sp2CeSqoelAcuQ72GubSwK+1o1alQ6gb2Ho4sdVDOal4VEby
	 tOg8l63hncfmPgfeAVJLDgvUyZp1sw4mKnQKDRHQbCb2+JRpJo2DP2kwn9km45rO2R
	 FOB/eEWZZshfkMgQCYp1KenBil5LSccaQhELNLFGHhFh40hpIhMPmgi8IPjC9kJRza
	 QgDECkoqEHSViombeN/ADduBotPyiytC1wamwPFiycoJEMIO40G2s41tQKHxouZYCO
	 xrM9G50muIWXlvwnj15I9GmySnS51o4JT2nGLLcteMJErFqi/4l+hFnltyv2YCc+B4
	 usVIFY64tgAgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] perf c2c: add function view browser UI and
 cacheline detail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-9-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-9-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:51:08 +0000
Message-Id: <20260817095108.ADF151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the browser front end: create/run/delete the hist_browser and add the
> title. The d shortcut opens the existing per-cacheline detail view for the
> selected level-3 cacheline. Level-3 entries retain the source cacheline
> index, so the shortcut can locate the original entry without relying on a
> potentially ambiguous virtual address.
>=20
> Report a warning when the common model rejects a cacheline coalescing fie=
ld
> list without `iaddr`. Without it, the detail histograms may already have
> merged samples from different functions and cannot support reliable
> function attribution.
>=20
> Keep visible-row accounting local to the function view by wrapping the
> generic browser refresh callback and recounting the currently reachable
> hierarchy before each redraw. This keeps navigation correct when a level-1
> row is collapsed while level-3 descendants remain expanded, without adding
> C2C-specific hooks to the shared hist_browser. Also handle Ctrl-C like the
> other function-view exit keys.
>=20
> Keep callchains hidden while the function browser runs, restoring the
> user's setting while opening the cacheline detail view.
>=20
> Wire the builder into perf_c2c__browse_function_view().
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D8

