Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53374437467
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576044; cv=none; b=dvjjMgKtFksERKu2q32lXRpZmFwL+jtL8npT3hMathpaGL7oe4wzVsMaVyUVppkUSXcZ0o+5kiVyVCDd2s+dOupqIhH5rVABfTTN0mqbvxG5PI1gDnl4pOJD/hBT1CXQe83LnkDcC2eoHyx9a5imXWgzSyKmzlE+ZjIMsJ+tX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576044; c=relaxed/simple;
	bh=6Xbv94ji0RzLsO6i7w3bvT16shSbdRyvk0hvHib58ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eARl/tplFroAi60VNNexejnZuA3MwjvimVpnStL9ijclXnqixKkPaV+AoXuKigFsXPKX2CEDFVP2eGO4S8CF8gHnHWadNfGTjX4XlT+uChqEjS2OpCUrevR0DEQaEyzMNtGTK4+n/JfsR8XCreF2FwIvWNMf4lUYgDcX/fU79Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8sy8iwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8sy8iwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0190F1F00893;
	Mon, 28 Sep 2026 06:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790576024;
	bh=FZfEjxd7gECRc4JfEZwyYQJMFUzyZTQ7Y9r5BPFCa1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8sy8iwf4UzNGO2uZm9F9L7X+NEhsQaJRMYXA28rvhFtmW5XDyJRZdyuXW2E7jGAh
	 Kh6NkIjKTRF1MHOZB9qTGbSKrPos4uCZlO5KqDX4yIFiOhuZoEcYVBl3GAnFhEiTFb
	 KzlA3XcVsp1YH1MYIbjzNmgoiQDG1P/0xI0w8oAWpWoWyBh5Zb6sMECvI2qJb6rqse
	 xge1+0LcHYwwPW63BxldyCgJq0uIB3+I2F3BHv6wESeDCRT2jZp/TX5jb+YtGAPM7O
	 wQoa53BeViVLEU0RMPRq+wYJSVg9aBqMF0K24vF1J/zWA0qg5tVNMjbfl9v5K6mJVh
	 f1rksZmZPn7Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] perf tools: Export dso__get_filename() with type
 argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-5-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:13:43 +0000
Message-Id: <20260928061344.0190F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The dso__get_filename() returns a new string of filepath for the given
> binary type.  It handles chroot and decompressed kernel modules so that
> callers can read the file contents.  Thus it'd be better to use it to
> check available binary types.
>=20
> Add a type argument to handle a different path for symbol or debug info.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D4

