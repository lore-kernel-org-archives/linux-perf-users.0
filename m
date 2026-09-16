Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5513EDE59
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541253; cv=none; b=h3QFsHKCUsnnmXCog2HmkOESZmd8oAQxENAblSH8gzGj5Rxwvx34l5bn/R6lUyYzhNJ78OnPD9fuQ3h9QrNpomdI9sUNBFfU3vNtVhvqRddyhB8sIll0VoSb7GaCgb/+v40QNRfl7EJ7dMiFvohN5s1VomkMvszmbmT0Y16Hemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541253; c=relaxed/simple;
	bh=yOecCktOFLbaXcJIfyYsRkltk8DsASG+nnR2wO/0oRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YlV/ZnWKCA11N4Si0iTjm8ug/YgpdQtxs36tQgJp9jXO7fpQol817BcdY9MGWumvQXDBJe1EAV5olPgcZTXliY64JD22URZNZimgtSwc9PlxG+MhJUu52OcxRp9OHqqmp7wfWSy7hT4Z0tdd53oqji8hVpZGzDh4/hqCL7HMcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5xqm9bf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5xqm9bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C11F00898;
	Wed, 16 Sep 2026 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541248;
	bh=yOecCktOFLbaXcJIfyYsRkltk8DsASG+nnR2wO/0oRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5xqm9bf4w0p+urn9DXwUB002nlvEjh1HOBX+hVbutJq9HAfmKGb9FHltCNIYJAv0
	 ZG02MMwVKyN0IcaFj6lg0IM5s0zSDHLkFNSaMtuG2lgj3hifRLZJhTl1LB/PbcEivm
	 foVPIgVGU3ApRhhpt4rnFG4QE2urjjIjw/rsOhWoES0hlcZX6qle24NrqeRrar4P7T
	 TaRf9w5D4mf41ykRW5wDj2KAhsNFJIKsAkDqIOPGwwBVsEavB347sNEBL4oRlPcflg
	 Qhk5/0Vw978aCw3KgiFPfm6WArptIBG3qm2TDZ5KN0IkzZL1m0uxplbfVvkKDP6Brw
	 d8tzD9v5Acygw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf dso: Separate libbfd and cmd addr2line
 caches to fix confusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916063545.3103314-3-irogers@google.com>
References: <20260914170759.1992947-1-irogers@google.com>
 <20260916063545.3103314-1-irogers@google.com>
 <20260916063545.3103314-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:47:27 +0000
Message-Id: <20260916064727.DB2C11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a dso executes addr2line via libbfd it instantiates an a2l_data
> pointer. If the DSO later executes via the command-line fallback due
> to an inlined bug, the a2l pointer is unconditionally populated with a
> child_process process wrapper. If libbfd is queried again, the offline
> reader attempts to cast struct a2l_data into child_process, coercing
> random arbitrary instruction addresses and causing silent aborts. This
> cleanly splits the caches.
>=20
> Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementa=
tions")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916063545.3103=
314-1-irogers@google.com?part=3D2

