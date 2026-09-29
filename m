Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3B28690
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644756; cv=none; b=hy6JUnCZiIUeq874NkaUmMPGcdup0Qz0HzUpvqkho4fAXy1gP+nxJ7f6D9nEzh2CrAqq9iygpsJy4YjHfNKOVq46j7kR+6g4fgV1e5XQV+NpGGImqDprigCK0bCJyu9OxVjJn7uZ+YrJH57D6n05Fyu6HoMorq5ZR8vGM1LmiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644756; c=relaxed/simple;
	bh=09W1HiGJeepcdqcH3zHNdiRXRWyhBJRwvNoFCFFA/gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Guqkzo4uY+O7nYDegywfRSRTu3+3HzY3OBBsKGdjdmWZ4gvIle3bviroLv3pAUuoOid0DsuAd8SsKyQacvLALnNlyfT6jpoxmZucCj4hwnHcDuzHbgpm4NYSwtqCyx8xElflxLgUW4T9KLpF2nEtoAKW7uAPKbgvoUBbvRayCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd1NE+s3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd1NE+s3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2C21F000FF;
	Tue, 29 Sep 2026 01:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644755;
	bh=IHEqJ3ToYehx7yFq3lPliU4rg+e9rhNrJwpA57dI9vI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pd1NE+s3Xa/9oaBcZd6BndqFkCDJZNboKYPSQPwYZnxVXy7RSmrEqHEYeRt0KI2XI
	 E4hp06D6ucSGThvSmCLTiWjC8VNP6VJe1YPm2KM+5Vu0Lh0eVvwjYeezT5E9/6lLcm
	 ZR2py3kazUc9FocpKr5mG4VaOAK2w+p31Xq1s99c6TihaIJbNBQAw4JA2nEvF1vGvD
	 KJIQfwxQJDiVDeT+35FZlesqSBvXxJIQDllRTouxCIoqqeTC4SogvuCWw5uxJ78mTc
	 3ioS9IqYi1NZcByw4BW82vUQa7S6kEBBeGo1cMBRtkVcUtdSy437RQR044tIBUcNix
	 Z/sxWgvPUTFhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] perf tools: Factor out dso__find_dbginfo_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-3-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:19:14 +0000
Message-Id: <20260929011915.0F2C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It tries to find a file with working debug info by checking all possible
> debug types.  It checks if the file has one of known debug info sections.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D2

