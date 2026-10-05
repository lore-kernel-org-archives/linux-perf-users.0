Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5D3064B5
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221868; cv=none; b=MrIPI+bGHekLQAxDSW6Nn0EJsDsz/L0pVkvZN+DO5znvNemiiyWwcGs2YukcLwnd33INQtw1DDimXfhdrwndknc/RNlP8SNjdAQV3Q512esjiZW7bLfPq1HiQ/DG/kKG/1KuPdX8FY545ko+HaZKBOqqLNM3Re3IBDnk2miRVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221868; c=relaxed/simple;
	bh=6fC0St7BaJwUSuv4rXBERUVKhHhSZStI8Bq2n1JweDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bj7M2AIm3kb0rv+VYomDhjv3PVvC/53NrhtmRmKbIziq9GLRxsH3r9MGspgV0lQPKvR0cHTxhB0yKWF7sf6Ynec/s1EWdCDwc7QfRViIFGSyRZck1l1SrcBUqzxm8cWEDrpIeQyi7396PhyOqmA0SieAklVBf8qhFz3TmdmbXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWND7z9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWND7z9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4611F000FF;
	Mon,  5 Oct 2026 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221867;
	bh=6fC0St7BaJwUSuv4rXBERUVKhHhSZStI8Bq2n1JweDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWND7z9caYPM0Ra4jyttGfbsItBNUlsbe18cOZBKAq10mU2Vx7pa33U1nrfNaqJux
	 6vtZZt4IHy5bfCa6kqF9dBaLGk+X8vqQpaRfXkp3GxmPGdofG0eoCe0hFnSba8MxI3
	 WFcfF5E0+VeVLXHOkFrH/Pbs/vsYY8VyfgHaXIe5oKTSaGglxrlSHJblFqbRbEOju+
	 QRma3EqyrEUvapH5a/wE3+c0gOzbAM1aKpUAK8jtnYkZRXfU9guQfUzs886GydbNAM
	 Jl2I6E0sStpYsDsuNFIZRNEQX0Rh0Z7p8JOx8/+tOquL8im0E8JVyzdqq/DSEh0o63
	 7D9cKtygoMq8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] perf symbols: Factor out duplicate symbol
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005-perf-symbol-memory-send-v5-3-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-3-165dceb2b049@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:37:46 +0000
Message-Id: <20261005173746.DE4611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> symbols__fixup_duplicate() chooses between symbols with the same start
> address through choose_best_symbol(), which needs fully constructed
> struct symbol objects. The lazy symbol loader added later in this series
> selects among aliases from its index entries, before any struct symbol
> exists, so it cannot use it.
>=20
> This patch moves the policy into symbol__choose_best(), which compares
> the size, name, type and binding of two candidates described by struct
> symbol_candidate, and passes the same description to the
> arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
> that describes two struct symbols. No functional change intended.
>=20
> symbol__choose_best() is not static so that the lazy loader can call it.
> struct symbol_candidate stays in symbol.h because powerpc overrides the
> weak arch__choose_best_symbol(), which takes it.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-perf-symbo=
l-memory-send-v5-0-165dceb2b049@uber.com?part=3D3

