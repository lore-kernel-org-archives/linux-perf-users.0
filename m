Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19362353A83
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968822; cv=none; b=B/kQ+u+4HYpZ6M9AqQP4T2Ac30B8U/953BNlfE8b1NKKF5o06b95BuiY/z/rWu9suw7oEMFEe/mwNVUmDRZLO0khAgqFcSFONdpE3TfA1wopjDABugCCL9BIa82rcx7M2Jl7mpgi5DJnLCOC8Q6MF1H9B64gB9aMKeBSQeJLOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968822; c=relaxed/simple;
	bh=1fLs93P3MhEqonbI2CSLC3r1ccF3ryxJCvf9jZdchfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OZlJtTMPKdvdlRUqEnLKUQ9PWQKiK4uOuPJOkE215iiLp8Yc8SIWtfs4n1LfIvketLWvh6OgrwGiYb/LPkyS8Hm718aS0il224qwK9wAhuUmjH3yguibGf2oZ9XKkgnie6L5WuKU1ENxUhofCn7ch7aTbjrl80CN6OlsCRNLJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB7/WsUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB7/WsUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF001F000FF;
	Mon, 21 Sep 2026 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968820;
	bh=cjaTI3TGxweFrIwmQ/jlCzClJhGF2FWJaoXjH96lxDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cB7/WsUzgZfbvpYiE3yTV3jMj8joa99H8U6Rll48ffybDay75c27HX7O6EfRT+cc+
	 ZGbDANXXxfrRIx2h4gYwVn9ruvYi7w0Z3ee/Re9DlqkaED0OU8IdDXMR50dm3piTLl
	 +KDJBiipq8Xx92dEmsk1zj9xjl7DPC5rjIxdjp/zbZgPAbfbmW3ufHY3UzWvh6h0CX
	 18hC+4BgkOYON0GIYojHXuM+ItmW9fpnTbbqE90cXM0Enu/+QDircdDEPw/bd0vMSj
	 HRXCT/nmyJiTXSHtKzMGkP/BKBvkDOqkvxGvy474li/aPMTToCxQArMmh4j3rhhOHP
	 EG1tGb9Wd2Y5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/49] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1b18a2dd4cf8d4dd3af7cf61d841c59e75c07ade.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <1b18a2dd4cf8d4dd3af7cf61d841c59e75c07ade.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:33:40 +0000
Message-Id: <20260921053340.7FF001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add module docstrings to counting.py, tracepoint.py, and twatch.py so
> that 'perf script -l' displays concise descriptions for all available
> standalone scripts:
>=20
> ```
> $ perf script -l
> List of available scripts:
> ...
>   counting
>     Example for counting perf events.
> ...
>   tracepoint
>     Example showing how to enable a tracepoint and access its fields.
>   twatch
>     Example to show how to enable a software event and track
>     context switches.
> ...
> ```
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D7

