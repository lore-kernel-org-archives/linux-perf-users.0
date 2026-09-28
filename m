Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD6466B6E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582579; cv=none; b=rWVTC2mOyRNfxRtxOt8XoJ6iwyqx2vfgM7tIvle3zDEUIm8rtRhoriwPtR1z9ROihRDwlTe7QnDGfmzxHktjzELBB8Frg48+8GKlCOgV8QOMXYsl6qqFuNE+i7CyBgv83RK/dOHaoMmmxjkt9dMt75PU3ajYg+HerIo+Ls5lFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582579; c=relaxed/simple;
	bh=Oe3fWxfmUVsNGpkkc4JRd/Ztkd+RoooQbkofpaJZSqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwMLsqZUDZDagJy6AdugG7Wx0WD1MpIUsqsD7XAXqll0FYT5oK93xoBLV+mjSRpll4y7oAr1q16q6ZzSQtfT40VsKnoOG7UZILpODqbaeWmcmkZ1hY5Xb3/XJLaBZyQkqwQEhPwRbferpGfQ02HWxn4ozenE4GVODPwxHhXi728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCBZ9SvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCBZ9SvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1013B1F000FF;
	Mon, 28 Sep 2026 08:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582575;
	bh=Oe3fWxfmUVsNGpkkc4JRd/Ztkd+RoooQbkofpaJZSqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCBZ9SvGMBcxClMzs5gZcsMxEAIo3tl6LInsmwAUheFOUEnTv9EQApqZQys+znyIE
	 Di7JewX4tuPd/gxzCMzNJWYj8fRuNrds4HsgfLe5lfk3jivnu6ww2KPJRX8x5HeLzu
	 KHSISkj0V2tw3frhj8Ppm5PNRu5SPq61WucElE6Ba8vIMeDwwUiUiESk8BavYd2a52
	 sy9icoKG2Q/vX8glBeMISI4b+vxBrepYT7Vf++MSqijuD86K2zldAxtoDDU1xFld24
	 Ab3E8QIhnWsJeW1IMk/JC0q3Pm86u2YYGdLfF8FvqwySbUzZgANgReM8J9v7fsEYrO
	 FWsOhs7d51Pxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] perf/x86/intel: Reset active_fixed_ctrl_val on
 CPU teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-3-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:02:54 +0000
Message-Id: <20260928080255.1013B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cpuc->active_fixed_ctrl_val tracks the value currently programmed into
> MSR_CORE_PERF_FIXED_CTR_CTRL, and reprogramming is skipped when the new
> value matches the cached one.
>=20
> After a CPU offline/online cycle, MSR_CORE_PERF_FIXED_CTR_CTRL may return
> to its reset state, but active_fixed_ctrl_val may still hold the
> pre-offline value. If the next computed fixed_ctrl_val matches that stale
> cache entry, the MSR update is incorrectly skipped, leaving
> MSR_CORE_PERF_FIXED_CTR_CTRL uninitialized for fixed counters and
> resulting in errors in fixed counter counting or samplig.
>=20
> Clear active_fixed_ctrl_val and MSR_CORE_PERF_FIXED_CTR_CTRL during CPU
> teardown so MSR_CORE_PERF_FIXED_CTR_CTRL is always reprogrammed when the
> CPU comes back online.
>=20
> Fixes: fae9ebde9696 ("perf/x86/intel: Optimize FIXED_CTR_CTRL access")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D2

