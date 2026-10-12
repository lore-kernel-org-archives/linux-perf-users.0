Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5930ACF1
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783431; cv=none; b=NHfJgBhnd3txPk5zpPafUe6lKWpgneGzEUGCnJv3iJq2ofl5wd7Gz6VUlwk6toN3CQPXxjUWHgqMmMNbLad5fFNbd1wkf4x9J7Jebw3avm99I1d3nigtdqC+dY+ni/2ExqbeZP5dfils6hcV6TdR578GVbO34plxqE0eU/RhYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783431; c=relaxed/simple;
	bh=XQNwFnPFDH1XnFQefk485+TQoZuEBZBqKXGag+DfNhQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s//E7ne9AIsUsWTXMWE9vtFsslbGHdGosl2hf7fEQRBg1jjfHpetUZFP9zIH+N/1BzofzaAZMgCJW1va0FEq+nMLnJMGjMVfXKhvreUCi4nf1lGwZGSiCqV972dWxeN4m2AKyMdrOA7mUoMNqLkLMx1EVTx20Dd+On+YhVxf4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHyoheDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHyoheDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8021F0089C;
	Mon, 12 Oct 2026 05:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783429;
	bh=gk4KilkV4s9VomvGeQyP7beGds69+TVgkO/qLDlq/Ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHyoheDIC+fLhq+SvaPE38BerdIG0WzCWy7eZaIv9/Kt+F97XUyk6z7v2dbe7kaTq
	 +aWcro1cApjE0M24uPA1uw9767M026PIDB0l1OxWRwbR9R+aR+zTkZFQ7nyP0kXgy5
	 5vDwgEPHrnnlnFmV2z5ScUjQYWhkcUaHjCTCTj3dwgrvV3PKEICR9FWI4qFmfc2zIJ
	 E0iTrGDDXK3/ONqREyFRHHrv6btrlqsoGz0dRFeH/J+eMFKrx08GvXG9tRGc0s7whB
	 cgT+WxUlXvfNLFhFlnFeUgWRXgyn+G0F1D1VW9SosFmxo0K1rXos8k0Ga8nSc/dpM6
	 oLP86Vx95UE/Q==
Message-ID: <sashiko-outbox-167677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf symbol: Fix symbol loading from libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012053013.14378-1-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:37:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The dso__load() should return a positive number (number of symbols
> loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> only returns 0 and it's hard to check if it actually loaded symbols or
> not.  Let's return the value of dso__has_symbol() and check it in
> dso__load() so that it can return 1 for success.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table wit=
h libbfd")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012053013.1437=
8-1-namhyung@kernel.org?part=3D1

