Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC640F72E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575339; cv=none; b=QMr6lholII6HUm/WMupgqMvazYwOKN7u/nF9H0f9vci7ebAhi7A2BYvHf4LBX16ZrVaUrRnoJP1Ti6tLjQsgngZnjI6TX5L9B7szOvGzpx77xsfmeqhjmYvblGSTreCKNBxNdtlwVQDjErOgaJomHrNuVIxOF7weZjQJfs19rpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575339; c=relaxed/simple;
	bh=RPOk0ToRsnEXxFhsqJid2hSw7J6+uoYWO4+mTLiRQ2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtOIyGxbOMy3PJ329m7A4f2O0zPzxOE5AubcaEVqfOWMj7ti4qfVwGxudjxOl1lYmrHqVRH0S1Byckj7kq4wvtK6u9PB/FcSAqu34heznT9FqXYFFDRCdKkrlMVEE9IwjoMuIn4HuLE3lahIBqK9nYRGHcGbg01GnfzYmnyXNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFGsPs1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFGsPs1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53231F000FF;
	Mon, 28 Sep 2026 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575336;
	bh=RPOk0ToRsnEXxFhsqJid2hSw7J6+uoYWO4+mTLiRQ2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFGsPs1nXncrBFIXmPj8negSpVOxsfVbvLvpTyNAEr/20RnFuaWe1bcqCwBhiIuFv
	 OL5HX+TSchLSpaRhUZZF7UfF+5oJ8RARNyq7IwuAE/yl8lAjBgJahW3AblxGdmeWqI
	 Ajx8wQHXwKo9YsiEb4dauELuMTFpsHu5EBrOBsDDx1zrIKTxYQTiBGQsXNa+9c4qHg
	 o4ecYFa5OcEk+h77frDGl1Gr59X8rJPQsf3dUKMI/7v6+dz45cY0VZVAK4TsEA6cbN
	 VJsyAxDtVihT+di1dpAbhm1ZybNxNI7u5P9L261lg3PjcUZG17U13N8XNDHpY18akh
	 lbjiZcGBH9Nyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/8] perf tools: Update debuginfo__new() to take DSO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-9-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:02:15 +0000
Message-Id: <20260928060215.C53231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It should be the common case to get debuginfo from existing DSOs.
> Now dso__debuginfo() calls it with its debuginfo type to avoid the
> unnecessary loop to find the location of debug file.
>=20
> Update existing function to debuginfo__from_path() for clarity.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D8

