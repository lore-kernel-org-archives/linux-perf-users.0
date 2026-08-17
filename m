Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06B3D1CC5
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960197; cv=none; b=QJvBS0xdqCTlsEln6aHRPe0oF8P/BMxKHs1TYRmXtEjUfX+Okkyd2+KqXyZc1NnP2KRdjlYe6r3Bf+2LZ98G5skP4ieYM044vM8aoDZv7NUMYCNvscDv1Jmx2JdCjZ9XmjtXQSzYuqnAawq8s5gFuNbJ4LPTIOZP3wD+emB9N+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960197; c=relaxed/simple;
	bh=fTE6JM6JsJhvErHC3RmDnABslUBo2OQoE21e0bDqamI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gr0ORlHyoi+TEpayzh1CMpQtxApV9bbZ5/Xe9EG7CbuCSp9u8/41S5/nxYB0FDM6GH+0xKuFsV2ihfNRQwm+Vxc2Z2ixmvkcIWMCRKSd9wR/Bwi8jjDPN5gAjIua/bUnQNVF/f++W5leqx9pzf7XgBGhwc8yQK7ReBLyUMXJ4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7x7yWmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7x7yWmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEA11F000E9;
	Mon, 17 Aug 2026 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960196;
	bh=fTE6JM6JsJhvErHC3RmDnABslUBo2OQoE21e0bDqamI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a7x7yWmFOmr2RFLYidre+evFPBMwyQis4LKgzFYbM/NctHjQG0IV5RP396eleBiJL
	 vJ/w+pxCHrqVqLv2qA56a4dvbjeDpRtm1ieKrdaxu1uUTRxsPhgbKpJutxq7rhIuAd
	 /rfgM7jvcCem3c1xhU2ESnGNqoJ4BORiu0hh0lS7cTYOa70mmnNNRZXNryq1UA75xS
	 iBombdUdPxRWCA4LuEgraeiAVErQVqBFqCzOmz1hr2vbyRl/adwvsSy5H++Odph/Be
	 SJwtGkn04Hrn+gkF11ObtwKZKZYCIdk3T5CDeyqoefref4LjdzKYtmijaEG/QeBAhh
	 JrGlvu829mRVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] perf c2c: add function view hierarchy entry
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-7-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-7-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:49:55 +0000
Message-Id: <20260817094956.1DEA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the entry-creation layer: owned-reference child allocation and
> insertion, and the level-1/2/3 lookup-or-create functions keyed by
> function symbol (level 1 read-side, level 2 writer) and by the source
> cacheline's existing index (level 3).
>=20
> Give synthetic children normal entry operations and acquire their thread
> and map-symbol references. This lets the hierarchy teardown use
> hist_entry__delete() for the common fields while the function-view free
> callback handles the private child tree and containing allocation.
>=20
> Reuse cacheline_idx to preserve the source entry identity without adding
> function-view-only state. Add c2c_function__find_cacheline() to locate the
> original cacheline entry by the same index.
>=20
> These are driven by the hierarchy builder in the next patch and are
> __maybe_unused until then.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D6

