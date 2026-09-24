Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94C3ACA64
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228799; cv=none; b=fSi4sfIQ54n+PkYmCNs6GPQfazk5U1qk0dFBSGhDb6A4Rkw7G4ydevu4+WItukGGbZmCDlXiFUQLpmuMIjNgi9HNtYvD8BWoJd3SbnjSVlzOkH83+nhI7WDofK8Y9az91+Ra6xo8dBu4gbdACT++rmJcodtXCejk7x/I1wsWtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228799; c=relaxed/simple;
	bh=efRqH51Ai1W6tVbiBRmAgYAEieXIOsbNZaaW5sXm6tQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccOnCa0Xtp/NItANl06Lw5XU6mM2A/ORj6+TeRi5UDXqpR+NM9VYFrxGFHUM+X/4UKJvSXhdh1x71L8qMqYmbfBjHmlqvFZC/XDA92T3hVUjpWyCk3uneJg8Idd5bC+YvN67tb9iOk0k9YErNbocIUCf7K6lLEJLwqgF2ftbkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFh4dRKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFh4dRKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F55D1F000FF;
	Thu, 24 Sep 2026 05:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228798;
	bh=UC9r0sM8SbWRYVKgdMLrtgOTr83Lb26D+KeLFtdjSjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFh4dRKfkqw/H8/ORUmNdXNO0KaAWRpSnoBCWmfl3nUwf+Q1cQ01lq1hBz9gqkTcE
	 pTX/9p6jtlATSuVCi8AG4LpPbwmWGVQu5JDcsuUilweY2iV6NYaDJ5ZgEl6Zhvhzmq
	 kfQQMoHMiqHWCSN7qOrWkog51gqM9xHUEkrgQfkSnMR90gefmVjP9FCiArRWR4K9fR
	 rU+I4dM8K7zbL+PbfqqjxTZWX/YBca6woTRMffGG7MJRIU2UuSt8ZM3/rczQwPYTFG
	 IE/n8h6g3jSSpB9Y7upGa5XFvUE37anwB0lGcRQa0m5HO26lhrESyKTmArLMVHroyu
	 6kr9hy918Hs4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 21/21] perf vendor events intel: Update tigerlake
 events to 1.20 and TMA metrics to 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-22-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:46:36 +0000
Message-Id: <20260924054637.3F55D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/228a83d851e8908aa09fac00a96a694=
04f2d3107
>=20
> The updated TMA 5.2 metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D21

