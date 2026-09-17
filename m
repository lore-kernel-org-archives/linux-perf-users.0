Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8A34F474
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621233; cv=none; b=Bb0CSC8yVLnXYMqe2ZqFaxm2lfvhqOs64rjqad88PKOE/C1YSR7Rt+Ep2cLZ03Gpi+uW765cngqVR9yAgmckNEJlNLfMT/1ZHbCnbbovRrYgsfnMxNDZITZPV7nLyiN+Ha6cUKcHDcC75U4XMSRNn+ZvA9wczptOeICiR7STSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621233; c=relaxed/simple;
	bh=dtLttHf1uELeTaNaFX1ykOgLJz78ZaHl2xuKkyeIjJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FSKF/MxfhO2EX9TgOA83iqdgFQP6tvjUr7wpWIxHAlmb6+jeQvi802BsAEoiUoe0+laWqxNdjslH1VHyk3dZ6Z34cTRPt4yUyzY4mzYBvLGA7LlbgP4QJ2JkY4iMShVI1JtDlgLCDwcWB9NbTAAAGzrVkmcqCQQ9ee/dhfYCUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwV65wPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwV65wPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268471F000FF;
	Thu, 17 Sep 2026 05:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621232;
	bh=dpy2uMuHlFRp6ocd1blJBKPLaGCqqfq9tQIeejaLJQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwV65wPCgA5o6laG7SrBxfNaNa5TktZC4QFS2vcXmfUVoG4wPKvnsKK2bctKaTTRT
	 3nMd0yJiyZRLMBXlX9cY0Ghc6vojdkQzbQKR5qkoGUjCRr6nmywXBHZjdadhp3bXm0
	 BYKYZLNqyZ69p/thacIgL3KFjtumvsSsghX/mCSy1UCFes4dOBc6w/jkhMk9ITWDFh
	 7dUFyHFRKNZZ5BfTWh04aHpyn+sQwvKZzxHXmScQUPj5AdamMlX/xW/8/aUVfMnabn
	 EiRlpiNL4Sd3LN8cQuoPGnPmuE6vIr6UV/tg0jKgzGt4aQ70ig8tQthAN2yBujEp0f
	 HWeiw5XVEFz5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/11] perf ui annotate-data: missing explicit
 inclusion of stdlib.h and stdio.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-7-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:00:31 +0000
Message-Id: <20260917050032.268471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When compiling the Linux kernel performance tools (perf) on a system
>   using musl libc, a build failure occurs in
>   tools/perf/ui/browsers/annotate-data.c due to missing standard
>   header inclusions.
>=20
>   The source file directly invokes standard POSIX library functions
>   such as calloc(), free(), and snprintf() without explicitly
>   including <stdlib.h> and <stdio.h>. While glibc implicitly pulls in
>   these declarations via other included headers, musl libc strictly
>   separates standard header declarations and does not implicitly
>   expose them. This namespace isolation causes the compiler to
>   generate implicit-function-declaration errors when encountering
>   these undeclared identifiers, permanently failing the build.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D7

