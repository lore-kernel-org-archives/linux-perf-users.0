Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E667377A93
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622196; cv=none; b=ecrKvqFC5WmpHeSdVpzu38QxGPSBr86fjIySw/Sgj3RbmoQCJ9reevjGs6M3KL0AbgEoCUMvivoS/DIuHFYsPP0rwpIbkpXMnZNwtT0gXdz7FaXg1n3a/wV4L3yIvu0Jds+/5ZpiPjKUfJLphy0/pZfG2Jveu5jq9H/XBPL8rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622196; c=relaxed/simple;
	bh=OtWUFQ6X+wSNfe0+7uY/DJOUFrc84BPFc5azH7Q0q8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9sKyMpq6rcVzwjQ4gssJqSLMDKDbIHkVbQycAKYzL+dkXmBWGwzFBR0dV8Ddv2xgn4Lzb/m0hkhaQKgd3mPqZRJfnBCfEYFkeNRQ7pPhqkQ17GZ76suF6DlUOztyCs08LOpUya595qtTYw1adn+OU8H0EjjWVm2EzLhNd2mKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFurW7r1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFurW7r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8927E1F000FF;
	Thu, 17 Sep 2026 05:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622194;
	bh=k0mwV3X5EZEbEfjmLyOiXzfdUltAswcP5k/s36wrniA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFurW7r1W1u3Xg9PHsK5txbyaNZzQEZ8E7fmp70/a0dUhQpaWoxz6+JEU6GL5mnmS
	 8VImffG+IC9+fZzrIHy1dGp6O/jMSR51xlhbYPpbc5dQI+mWBYNP+UqPxL78lDO7EA
	 bk22Z1m3X7JEdldpG/+le3n+G3D+bOWa8mJYG4GrvJgjgr0r3SPNq6yvVGMEZEHzlg
	 Fj9MlgAeS+JszSGKJgjuO0C9JXbRstrwsjAtcKRN9LKUSjzYDm48Db2IMNE1HGFanW
	 Zkxn8cQ9eEeuP1RM12E0WCHlyN681U9FYrFOJUUCbqZWlLUc7yB8nrUZX5TYveo71O
	 25mPnrnlSkSOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf libbfd: Report success when an address is
 found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050450.703018-4-irogers@google.com>
References: <20260916234402.437113-1-irogers@google.com>
 <20260917050450.703018-1-irogers@google.com>
 <20260917050450.703018-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:16:34 +0000
Message-Id: <20260917051634.8927E1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050450.7030=
18-1-irogers@google.com?part=3D3

