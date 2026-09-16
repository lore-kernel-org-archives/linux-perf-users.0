Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72B52FE4D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602867; cv=none; b=SyVv3gwSmFO98BDQFkOWpHykVB/kc68vBW/YyLgrSfixD9GY8PxufsQpfOb82r318BCz1oI5GStGoB80691ZTIBqc0BxfKlkluF+NfZ7GopFBZAWA7ER6FYBw2TLqXiNzJtukskA9lg6OqYHaFzOxd8CQQm5NOvnhY1+ox290v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602867; c=relaxed/simple;
	bh=OhEh15jy+BG8H9rrQVK6LpPkip3PW9aMdUVvDDEMeHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tz8j+g2E21BvNds00vFUuSKgcDO7ZLJg8yzqidGtAz+lH0YQr4Sya3nskKojX9qRHJVKjCyWEUkkK3GPmRkI/UhRWjzzMEpJE5pf+xiUC2OgDY9/70GHhptlUk85o7IkaLA9biXMiveS7SWV5YE+EkyWpBI2Tzdu6m3MqezABDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJc0/9a9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJc0/9a9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEB61F000FF;
	Wed, 16 Sep 2026 23:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602861;
	bh=tcJq0OnFsfPqs5HQDqFTGccDmvSCNS602dSgKDkFvTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJc0/9a9u2GuXW8L0XjL6L4SnV6bHhcrObwevGas6gd8QpgVmxQa4pDbW3tjJD8Ui
	 2YYWwXigmE523efn69dHIkCSAoruhehQHRvrB0R2b1XUb0uo4KUsfR/X2gWCzCwk6i
	 NxmAist9WPoAkw5RyIcloRb8+h5XXrM5HP3Cz9Q4qSng2/NOjfoGyyJKtv0ZolNalV
	 lN0+IWikmWShtSM/1h1Lnutp0rTKvgDvXJt1tKSIJ50Cap5zkST1BIvetI9O5xw235
	 3iY3ssS/IRIXVEes6NAnDML0ncu85jYk0h40oks57uYm6GkmFOaKt67pmUH6Cg8yxj
	 xnuMPxKSwhOmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf libbfd: Report success when an address is
 found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234402.437113-4-irogers@google.com>
References: <20260916063545.3103314-1-irogers@google.com>
 <20260916234402.437113-1-irogers@google.com>
 <20260916234402.437113-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:54:21 +0000
Message-Id: <20260916235421.BDEB61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> libbfd__addr2line() only reports success when the caller asked for a file
> name. addr2inlines() passes a NULL file as it just wants the inline_node
> populating, so libbfd__addr2line() returns 0 for it unless
> bfd_find_inliner_info() happened to find an inline frame. addr2line() in
> srcline.c treats 0 as a failure and tries the next addr2line
> implementation, which appends its own frames to the inline_node libbfd
> already appended to. Every frame that isn't inlined is then reported
> twice, which happens by default when perf is built with libbfd but
> without libdw as the fallback order is then libbfd followed by the
> addr2line command:
>=20
>   $ perf record --call-graph dwarf -- perf test -w inlineloop 1
>   $ perf script --fields +srcline
>   ...
> 	    56051a994f8e parent+0x2e (perf)
> [ ... ]
> does, and clear the frames appended so far when appending fails so that a
> following implementation starts from an empty node.
>=20
> Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementa=
tions")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234402.4371=
13-1-irogers@google.com?part=3D3

