Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AC33ADB0
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991201; cv=none; b=VEhlIEnX6i6svnGlarE47/MSeeABgXdPBw886G4tarrCsk5WC4Sxpa7nhfpDcT8YA3zMWRHfSQaztBl2V2CCXpd+ueAZywnA+8FvHw7LS6E+kNM+yt7MGAewxrTxd2+HYD1yfi9K3FfQwO8ZEZJQXUc5tURbwAaTmVM2F+Wvcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991201; c=relaxed/simple;
	bh=8+D2XWDVz9xPcuZu1sv6A4l4kf8u2bqQ/405pyZVROs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RjRN7LROuNCPvSL5Ym/Z+kJbs+v7jLbej3K5CGdQ2xwX4enjMqLzKGoYx+fUAPt3syJEFG2kj/zp4c0oPORhAPNI/xlW+ZvuW/CWxoD1mrKUDBcSzO5Hr4gYKXYeQGq6aA7W/nEgISetjeoAoc4Q2q4xdeOnQbvy1ALJwjbY/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAhpE/FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAhpE/FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F131F00893;
	Sat,  3 Oct 2026 01:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991200;
	bh=8+D2XWDVz9xPcuZu1sv6A4l4kf8u2bqQ/405pyZVROs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAhpE/FIKrp8reHppdEvuznHo7rsk/+ZFvgFTMVhlv0fb38b9iQd3BeW+9q8xPgTQ
	 9uoApg2EfA1yMYUNdyUPbpYEoIPo5IzNYCD3Wkii0cEHSnKrhiuUpfgW8AyRTsPv0q
	 meZTC6QjdIWOWWqe81P4KBzhBg4u3tp3QOti3oP+ivWATDN1rp1XObJlFbySkat+nD
	 Y+UvvGfyCciQ8o6agCSpB6oM4K3bk3LeClGOyulcUtsY91wUdEdRICRftMtIroUZ0p
	 y7hEUHUNiotY7MaYE24r/B6qjFPphvo0UE/q0/CVP1TcEQu7U0TLceQxKBrHMrTib0
	 JbOLDqtJlsW6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] perf: Refactor thread map and symbol APIs to
 take perf_sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-5-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:19 +0000
Message-Id: <20261003013320.43F131F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Refactor thread__find_map and thread__find_symbol family of APIs to
> take a struct perf_sample * instead of cpumode and addr. This prepares
> for looking up symbols using build ID and offset, which is contained in
> the sample payload instead of the address.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D4

