Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F88437451
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306917; cv=none; b=gBsxqOryO0QgFus7QNWsfbOnUt4e+b6PmgTDZj6hcxIlKy8yJyuyMFvMCljl3zhlbsbVVXLgMQbUcDqHmNau6uUPT2QiZjLBVXMgXoofOhTBy0oPsF9xynGhR52Khxk9i/j8aAIyFbDDuoSy9ZXtCgF6/UkWhFsRMFk4MjHOtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306917; c=relaxed/simple;
	bh=uodRr1v9ASSfE0lUEWlCGhz33J5J2BbD5Keh1MBeqiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dgbkGVMpL3/Q73FbQ1hArb+NGAfQZ5urSzdMKqXWiDFunIf7cX2DwMQFBlXfPK0kmQnyWGhy76XhRpdg0knFbo7+Inr+1QWk/MN57rC6IijhH9su9Lpx+4cL92GPiAuCi5AjOcHQu7fSiTL8MNs7l5G10NDHWgRErAg5b/s1YUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwYWkN4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwYWkN4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596BB1F00A3A;
	Fri, 21 Aug 2026 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306907;
	bh=uodRr1v9ASSfE0lUEWlCGhz33J5J2BbD5Keh1MBeqiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwYWkN4axGcnZuliaXy3E0aQk3RNY6uV8GHs4LRdiv4vEJeeIzhZ9uq920FqPmTdq
	 YZakvopk9gSWviULM3N7xBZjK6yKWwJ1oDnybHB3nq3t2KinFWlw64y3kURdtE9yDC
	 sWC1UvM7We4mghLxFZjKqiTWosqbTYsZKMB2BR/rkPiede/PSUvlb48mbej/04L6rS
	 bLpiMfr8sLhOzsSq8qUkZEGE3DIXtEJXnzOhzIIBp4kk9mfSxaRy2u+OlT+YfBW4zx
	 p+4OMBxzP25pUjO3oVOks6II7vAaqixR4yRFbV5NmDcHN6NK23XuKSn9/LhwNv3cqR
	 89hvDQneQGpkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf: cs-etm: Respect --no-itrace option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:08:26 +0000
Message-Id: <20260821100827.596BB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If there is a bug in decoding then Perf will exit early and you can't
> investigate by using the raw dump mode. Make the --no-itrace option stop
> Coresight decoding after printing the aux header so decode errors don't
> stop the rest of the samples being printed.
>=20
> pmu_type and evsel_is_auxtrace need to be set so that the
> unleader_auxtrace() behavior is the same as without --no-itrace.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-h=
w_id-output-failure-v1-0-9d532ddabcc3@linaro.org?part=3D4

