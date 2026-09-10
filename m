Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321B493D3C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075369; cv=none; b=AqniDvkA/a+IxYAzQoaW7muYlItKTSz0gJfMIl+vOTXgoDrVmM4JVFuPHkD4/zCTlSbU7/rlWy4E3C46vxpxG7Br5A3Yh26bQokMZVVFI09v8umTjzz+xhY33fvGeoBEL0k13faGD9yBCd4vCWn10T/p7RjU4BEQGzaWMGJ2K1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075369; c=relaxed/simple;
	bh=KbZB66JjAhRvPW1TO49h2f/FP1CeqdqCbqYu+8Dgw+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mAJkcO4HgioEUdYvf9A/e6wahtH8pwjw/+h8a97DOIu37gQbJoRPH3pcxrIeizEUJ7Khe8+x49dbZlnYnSmh7qQBxTBY5nXDaCBZk5gkyEM7VmHUr5WAGibN7+bXvYbH7/agT68LF0NvXd/VOy18kCO5PcokjEHIrncBMwdo4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ6bv1Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ6bv1Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7181F000FF;
	Thu, 10 Sep 2026 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789075359;
	bh=KbZB66JjAhRvPW1TO49h2f/FP1CeqdqCbqYu+8Dgw+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJ6bv1Dh/vdI2NvJVt5KHv86u0Nl5R7JNT0kVTjSTntfrjhqnQd01pjxWGlb72ZAK
	 NPXJZFk/hjLKkUUZn9a8wSXmKW30IdHDghSh2jvcyeVhwvC7Hb1hLR+vVGcA9iUgug
	 qMJhaNelInuHhlj6UevZPLTgJjq0KG6tJYg5Dsk7Fe8Azsq7IJLHiWBxzh0R72m5fQ
	 +xmrVeLBfarg9ieIMfBV5TXAy+FNdq6jHpoNB97nSSHMZoH5Qwt2f2yUpjelGuBZ3d
	 Iq6BKRIFldHtldas8JhodQzQcjsWtL2HJTGVu8c9f0Sao5SfH1vbRZL9m8qqWLpZtn
	 2dyoczEBiF1Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf header: Fix potential memory corruption in
 cpu_cache_level__read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910211221.3154261-3-irogers@google.com>
References: <20260910175634.3014018-1-irogers@google.com>
 <20260910211221.3154261-1-irogers@google.com>
 <20260910211221.3154261-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:22:38 +0000
Message-Id: <20260910212238.EA7181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> strim may advance the pointer assigned to cache->size which causes
> later frees to crash. Fix by performing the strim and then memmove-ing
> the potentially shifted string back over the original string. The bug
> was introduced by the transition from rtrim to strim, as rtrim
> wouldn't move on the left.
>=20
> Fixes: 13c230ab6e56 ("perf tools: Ditch rtrim(), use strim() from tools/l=
ib")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910211221.3154=
261-1-irogers@google.com?part=3D2

