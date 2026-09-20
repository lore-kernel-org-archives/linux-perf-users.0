Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F44304BB2
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882790; cv=none; b=ft6iWuUnANnyuFy+SR+vVTDq/l0YpRrqBNxhfrjoc2KnBYmXsruQ1l1Ra+H/hM37yt31FGIzYpwtk2r0IQ+q1Dxg+sKeN4ddL8LYFwAkamF2cA5ZSZA1vhKf76MXtHOSbRE46nD/nR53TIvBw7lNRrCK4h6tb2BubYSfTavQob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882790; c=relaxed/simple;
	bh=3U922KcbswQ1Q+UnknSZbDqGL/L5Kge4mWLGfL+Kxjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmFFQmYJm0BRBtaLaiUj8QX4QwVB6ZZ+p3P8reLZDhHbrG9KiHobsVuonHp581bSinuCPo4Ejy2LsCeGemBamKoGwdsCQkLqqgKMpZsCn9JhNPXL/Ckaa+BVoD5n0lNQ9HmG2WUguyksZfZbfSPpMfsUqchKjiX3EtC4CexAoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPBaDQjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPBaDQjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B0F1F000FF;
	Sun, 20 Sep 2026 05:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882789;
	bh=yYtu8KaqWA7pRHWV/9JPrN1UO7lsj6z9uq3VklzSA3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPBaDQjpPiaAFlIt1YHhnzeIeIFtotd6ABxlouu856YBCpo95pFf8A+YhY6S7r23K
	 76mYnldRncvyyQKuGCDhaaWlV3cnoC8ueEb2cK47v8UFGuP7OuoWxDfHs1o51u3YXg
	 kXvxA2sujsudZfcqNqDX5TvNhcAOJSypfzW4wn/e/JsXZwpcMPVpHIqvCg6sBcyfdJ
	 Lvm4P7ZuorUQZKydtQj2w6DDDsZ5tDzWCJgIqy6cOIYxkiezXgrBDtiRTjnvp1l3rG
	 rkxn7iyefGvZV28aQVtmyOFVZh9NyPFPbkE1yL0ye2RERVW3tudgxx/RIMGFcu1kEa
	 cOG7v/vSKVTFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 22/49] perf python: Port syscall-counts to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <53614f9275f1b75f3ed26a36d36805bb2053001e.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <53614f9275f1b75f3ed26a36d36805bb2053001e.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:39:48 +0000
Message-Id: <20260920053948.E7B0F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port tools/perf/scripts/python/syscall-counts.py to a standalone script
> in tools/perf/python/ using the perf module. Avoiding the embedded
> interpreter and per-event dictionary allocation overhead improves
> execution speed by ~4x:
>=20
> ```
> $ perf record -e raw_syscalls:sys_enter -a sleep 1
> ...
> $ time perf script tools/perf/scripts/python/syscall-counts.py perf
> ...
> real    0m3.887s
> user    0m3.578s
> sys     0m0.308s
> $ time python3 tools/perf/python/syscall-counts.py perf
> ...
> [ ... ]
> temporarily during the transition to maintain bisectability and are
> removed once all scripts are migrated.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D22

