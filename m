Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0436EA99
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991209; cv=none; b=gv1+pksOqlqE6o+kWTB7l81tidnZja7jgdAEJ/A1DTeerqtEa31+vt5aIUUhpa2eqYOwJ5SKjh0ZJmXbxaZSOO4F5ZwrlydRqk+PAqfcz5fzOnVtCeMu6xJczgC5XTi+SuFH870q2eOoiGAFpLOd+cJAmNlj12RwHEpBaqyLYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991209; c=relaxed/simple;
	bh=7G9k4we8nxqM5sAdMFJtsGpeUgo9+zcyc+mMQkRx99k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=okY5oDyPY3L8TbIR8S1ZXkpr2gLYh5gaW/+1h4bPmz9V2878IcyfekJc5BnZ8X6ML2oRun7ERdEF0juqTBa1vh7eM6xuz63SwWFhCGAIhzGlELy6eHy5QHnqrMQUrKIzdrsgsg640398KuDfkDFW0OY2tKV2IzXNd9wBWZO7xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4Vy+hfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4Vy+hfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DEA1F00898;
	Sat,  3 Oct 2026 01:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991208;
	bh=7G9k4we8nxqM5sAdMFJtsGpeUgo9+zcyc+mMQkRx99k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4Vy+hfRBSmYiOmUNBVG3OApkoBDPwZ6abrXgHAlXuXSP75HNlAKnohJ0/qTCnCzq
	 cMO1FOLswvxAw3nBfWp4CHkeblNfOgdRyewgaLOxv35ynE+TOFugRJDQNtrf1J0w8S
	 c19VEJJXDO1D8uIBBpj/6XZi5gi9bvj9f19OoeEj3/le0Nnw0X+D2WC5HKmHjhUmaU
	 9RP9UZCX+9n7hBaQkxnr4Z0AssHEFE3oSAzqBrLdCRfDzp063cOE3+i+lO8v6U/cpC
	 sKyP7NmeO+sB+Bn/hDxbN2qqbuRo4RLgHgOdawSbCtVTOpm32Hr8DCEOK7Z7CagvBX
	 18QYn9RFgWnwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/13] perf test: Add a test for perf timechart --tui
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-12-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:28 +0000
Message-Id: <20261003013328.85DEA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Test launching ttimechart through perf timechart --tui, the error when
> there are no scheduler events, the --dump output with the -P, -T and -p
> options, and drive the textual app headless exercising the views and
> key bindings.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D11

