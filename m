Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185707;
	b=FcKGx/jCqkZFzMIOEa7dFeNIVynr+1GNwC7zDyZOI0r6ez04Rlw+La72HG3C5EdzLBXw
	 khP95hvSS26Tuudf7RqB+7gruld1d8zfsFniXb9KgsC/y/WS4FqzeXXEgl5i126YdIPpX
	 M9VGkgPlHtIjZNg7bELgLcJXhlg/ScpO//ka0r6l70tfmY6Ul/iL4JyrFqNDwp8hPZ8sJ
	 hVCKTrsPyKLfPdomPtuNLdHTjd8sJlXpouLZxSkbvmJZDU3D7cEiinOikV9uEcIkfSuSs
	 jsKobRzjf7DYN9eY+T1twoHIuorwhmHU6VUmlwklNz0NlwWFtZq6yie23vGoalaxLBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185707;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mg5gZwP9qbz13mTvUZQG3RP+s/vPTEYwXZby+hIapJE=;
	b=n5uLgqXgO8SM1xohAKYdKRoPmG/NoZlaY9roEEk1HRHXiIEkLayk9hcW1Dp/ZCDdqtAY
	 XfWoMr3/hP46DrfuLCSfJYnouXZaB7YSJHZeqGTlz8y1tED7B4954b8E5poIsQ1xp3kaD
	 KQ/ndmdJG7slxOPKpg0wrsEL+G9CWxjXAjH8dh1K7McoZ0ibMVJvGVEbFQ1YqHcIqbgNM
	 QyDwZu/fEOLUjzhUDr1Ji+v+VkVgxhYAt6Hx2ltNXX/rV0yrA7WBkZAIQWRL0/cblicRU
	 8MwfAR5pBqGMK9khDW14LTKFjxAIOf9j65JxcSBcH2jqNSIP0UfTEb92OMLvKGzw89w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1JToISe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4C606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1JToISe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00EC1F0089F;
	Mon,  9 Nov 2026 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185707;
	bh=Mg5gZwP9qbz13mTvUZQG3RP+s/vPTEYwXZby+hIapJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1JToISeP5UQHoKSNksZl7lo9iY3CmO25Igdp292ztJKvVZQAzLXF5xWevBWZ38bZ
	 1uODbwrFGVhRciwb7RCRxtR+mXvTrhV6PC+nnhmFigYfpokmmFXZQUnGKlt3Wp8uKM
	 hYeGkAwCaU8IcWB8LZ1Co1gBIZcgnr5w3cGuDweZ9gZAYxIigkir1e0FiCj7sejlov
	 3oJpgqPQVKWqcWHt4voihcYpG+Wnkpnv5rV/x4vTI8aKHRwCsw1TPWwPjlnTpLGu1U
	 ov57Ie3ooLImCeKxUaeBUIq3ZfrqxPeZVK+m5yHQ0dSpnODSySqljMLHTp4iKbxSwY
	 WKNC5oEzIeLqQ==
Message-ID: <sashiko-outbox-204263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 2/5] perf c2c: Fix top-level histogram ownership
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109004402.1403713-3-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
 <20261109004402.1403713-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:55:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The function set_node_width() incorrectly determined whether a c2c
> histogram entry belonged to the top-level cacheline view by checking
> if &c2c.hists equals c2c_he->hists.
>=20
> This comparison is always false for top-level entries because
> c2c_he->hists is only assigned for lazily-created sub-histograms in
> he__get_c2c_hists(). Top-level entries are instead stored under
> he->hists, which points to the embedded struct hists inside c2c.hists.
>=20
> Add a dedicated helper, c2c_he__is_main_hist(), to check whether a
> c2c_hist_entry belongs to the top-level histogram tree and use it to
> update the node width accordingly for top-level cachelines view or
> per-cacheline view.
>=20
> Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address=
")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109004402.1403=
713-1-dapeng1.mi@linux.intel.com?part=3D2

