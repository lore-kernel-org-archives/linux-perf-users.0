Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AA223DE5
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209808; cv=none; b=a00FobxmS6VGH4cQjAYVl8NI+jE5FEnPpYDIM07W5AWb6952bElKHtWJtsegOZTMLql2ebUwld0r0y47bb+weewsB/3Qe45JYxx/5gxhO07NPZX2WAUXFTko573m37voI5946A4w1y8zvyMMlF/ctFNPYXixi7l9Y1tsUDsqnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209808; c=relaxed/simple;
	bh=JmVX/Xs0BiCWb3LXRiw/wbKZCpoz3JDbZ7Xpwt2iqUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPCL9ndLbI4AgJ1GMeRKn6uuIggLT8AAkOgo6d0JZuMAkkjniZNYoH+PBEeU7BZDRKETqD/vCTLT5C64CuaIH4YTKUFf+QVJrnO0hTDLyx8YD+RaE2GsPHrCG73Ze/djA5eM9t4kfKwy6zZCzlqyN0bLvAO+VaYS6uV2vQPAayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wff/HnJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wff/HnJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3721F000E9;
	Mon, 31 Aug 2026 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209805;
	bh=JmVX/Xs0BiCWb3LXRiw/wbKZCpoz3JDbZ7Xpwt2iqUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wff/HnJoZNetSgwu8Kk53YzhXfRf9FQZYbuL9yPG9LyHGhS01zzNm4GFGOSbbjLOy
	 m60UDTx2UTZYYw7WCeIxPtSRBiVgwFwtY1aiaFbzH65A3nEqbFZYHa0ls3juv8ppwk
	 JfdAiTulY2iNib9dtNu+DsrJXXYL4MISpmmsf78ElERErd4NZPCr9N88xnUdFgosc7
	 TbKAiSvgloxsdDBb3RJhRuh/FychlFvkXPPxxE9NG4pGcTZXKM2/LgEWYMMQd30G2f
	 wf7urAXIeU48enJBBX46gqbFrcZyWtOlWlYcBzxFX2PoUV755LfwiMQ3YmIJIQGqUp
	 kzIBS21bnnzXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf tool: Tidy up util/cache.h header file
 users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831182232.2959017-2-irogers@google.com>
References: <20260828222045.1314766-1-irogers@google.com>
 <20260831182232.2959017-1-irogers@google.com>
 <20260831182232.2959017-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:56:44 +0000
Message-Id: <20260831205644.EB3721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Use git clang-format to sort header files. Review header file includes
> removing those that were unnecessary or adding explicit includes in
> cases where transitive dependencies were be using.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182232.2959=
017-1-irogers@google.com?part=3D2

