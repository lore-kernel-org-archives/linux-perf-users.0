Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA40339365
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574998; cv=none; b=gZBppp6aq+mTiGPSA4C1gQjP2XUpNRO55alMr5LCqu8w6NJ+eIGb9VO8d5VjLhq7MDnuf/i5ySbH2Ffz1Am1Nn+mbQXqlDuPl0NM+Ro8hcshgqNgpuS3BKbci5YcSYpEOmKhvzor/3cAfxEje1XLFMTCnCkFOGkFLM9sjYYjQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574998; c=relaxed/simple;
	bh=mg3SZkcTYc9ovurO28mhWGrwe8+qUSIkeu1s4hh5n3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GeDl5BmBxUbTsSqOl4eIpukk9cEnel48NkFzMI/nWDOCz6L7cCcnkFHcMhnmmRS0RhlHx9w3R4Z0hLGXfOclT/KWgaOuntVpB9unbbGh6KgrtOyYsGiBvtkIZ6cffVe954xr6knItx++4AQigy4E1Xdseio2tXx93oMbG6nxgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DruBieBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DruBieBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE81F000FF;
	Mon, 28 Sep 2026 05:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574997;
	bh=KgjYSpBQbZYqY+cDdr32KC/kjxsOGSDVZM3kqtsJlro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DruBieBIvNgWVBgaPa5/oP8hWrG1PoFxHhYt8P7oc7C/dzEl56vZcwRgTqQ1SdQr8
	 OhnL4gsh/41SHBS1WezyeQy43oE05Ify/dC1UPNBl/dvCMN18AI3cmGL9rnq7K/daG
	 XmlwJ15RZNe2+XnNfquVBUso9JJIXN7QU0LzTuYhTdkH65m8Cr1PYQky8DEMK5RqRi
	 S1g0ThjXp4CVbZIIy9E9C7RdmnFkLZTObuCCMQ07lUKbUd3NWjxP4GHvADeBcf4Ej8
	 FQ5X/cpef5GAYczlp/nKyN+oAbeAur7SKItnQtcQDWiT5RZ+TK5rMeXrUpa1pORvgj
	 poY96Dt6IOQag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] perf tools: Add dso__put_filename()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-6-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:56:36 +0000
Message-Id: <20260928055636.ECDE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It's a counterpart of the dso__get_filename() as the returned string
> should be free.  Optionally it needs to remove a temporary file if it's
> decompressed on the fly.
>=20
> Currently the dso argument is not used, but it's better to pair with the
> matching dso.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D5

