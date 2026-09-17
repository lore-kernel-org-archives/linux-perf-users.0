Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AE43DED2
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627928; cv=none; b=L2Cbcf259m9exjiCEnqu6G17esA0D2eOgWY5umw1df0nk1js8iXfdCIe5/31ntrhXk8nTlo/t9TzH4aHmFInkkuRDaxDKVd1yO7DJrLCqaKJz2LcfbFvLh9iTmxLin5xssFhEaU74spVJ9R85s9kENoGxO5uUSPsvmXiO1pacYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627928; c=relaxed/simple;
	bh=p/46i1VNA0cC6pXe15up9soLBYZOJnu6dRwErc2ucyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pAfo4L9EfE3eoATbUmpD5cRBPQayM/Mtn8eyVlTw/8vL9ynJzhMPKeTn5uj+i+ffjodIR7GM6mWP764Ztf5ApKaDzmNaylBKLb8+1GPwe6Q6tu7nhWEy33ryfJ1CuiJwjGXYhKp9Xc6aSTO6hv1tGuDk898KZh2wEE0kCT/fzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6HOne0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6HOne0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E73A1F00893;
	Thu, 17 Sep 2026 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627927;
	bh=p/46i1VNA0cC6pXe15up9soLBYZOJnu6dRwErc2ucyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6HOne0XqEoJPW0qztkJdpiDU2qKf7xJG/22BFq9RXq+vnm50q/QZrJi0JNkJSyN9
	 FO+xhGVwC3wEToMx9jZ2oQl8mxQjh0m3DXYNYgettRrbawsg2Kj/u1p/MQabfDjI2O
	 aj7wt206rMTy7brUOszQn+IQyLYG+oZj4Fb7roXxRjO/adlLe/GxPdVP8sp+oXxo3M
	 Yge12ng1yksUrSr7pPBTw7/rpygSM475LeKtKrwEwgxX+KOFfY5WDd3UcdlOCCTs8P
	 bYK/ZSIlSpGZv7ZaBv9vG659aBnwJN304LVByWrm48eAKekFTB02Bww1IS0ibsa+hD
	 LlnGh8AbR8pwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/13] perf test common: Do not globally disable
 tracing events in clear_all_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <390cfc25923c5be2636ee0bd59a0b33d29ba0e71.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <390cfc25923c5be2636ee0bd59a0b33d29ba0e71.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:52:07 +0000
Message-Id: <20260917065207.9E73A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> `echo 0 > /sys/kernel/debug/tracing/events/enable` disables tracepoint
> events system-wide. When running tests in parallel, this kills active
> tracing and recording sessions in concurrent tests (such as perf trace
> and perf record).
>=20
> Remove the global event disable from clear_all_probes().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D7

