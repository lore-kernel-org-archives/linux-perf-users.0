Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9103AB286
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575808; cv=none; b=fxUN8XqlaktzDbY7D39UuLEWkXIQsm0adQ+q8qZx5EJEquA8RqMw0yTQynMAOEnyD3gnkNYiDRCaWS9JdT+4lEnzi8oSATy7DD2ZuQYmJwAdnDnxGl82kKv+apYZRabFcZ83QONaI+MpRrKuz+bmuTGccvX1mEBWjWhw1FDH5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575808; c=relaxed/simple;
	bh=uu5r4/HhcoOqTe3K1ttr05mezK8u0L7iW37Hsncnpws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sAn8affuQcU6zLtSc+6IkhoJYcZ9ZiKuqdnLNWyjuZ3rwxZrVdmmO8vipspbDFCd9NSfkXRYD+xN4MoGQ9Kgi9akbpSGAuT/XwItK4jke9c2CwGh2l27AaUtNcuhrJbMMdkyKhHa1Ai7wRZF2lI3PHr3LFPLZ66QPC30fM/VaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUCYQO3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUCYQO3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC1C1F000FF;
	Mon, 28 Sep 2026 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575805;
	bh=Dh72OB0OAY482fAK249I3nw+6fnH4gajDkXmg7gQewM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUCYQO3x+6ZE09J4XEYyJbVh+BSXk6ULPZmJ4qKd/1PW71zHpheiIP8BDxkonQIQe
	 c9ficyUTiBik7PehWMTSzSP8eR3wIpBQWMEvWCEyxD+xSCdH9qzfWXBwD/DWHpKMYE
	 mhLY8+qICDfmd0FlGFAoJwLeySklD6B691HjUXPmyE7kMEGma2nqyaitgwCO/VcReR
	 T/3BHgvUaPCO6DFWn9UYfaQfR2YnSLk3Dtw7nKc2d0ewzLojcjZG9Up7KY9SxR5fj6
	 X1E5JaoTln4vTOXvyEy5gwepYy+hwQv4AY9te2y7PV7TyK8VKt2eDfSZ+YFeCcZfRL
	 bJyzdpDW94R1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/8] perf tools: Looks symbol file first when check
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-8-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:10:04 +0000
Message-Id: <20260928061005.6BC1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> There's a high chance that the file containing the symbol table also has
> debug information.  Let's check that first before other locations.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D7

