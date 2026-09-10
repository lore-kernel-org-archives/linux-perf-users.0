Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20E2853E0
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063697; cv=none; b=mNfudr4wSowQy48AdWgDRuTWTETRk6TGBGGbmlME76I8CWlYt86Krmap8V8vfO087wlDbyvT+LXfSOAT6dHor9K5vtAN2KFzVB6JNgK2Q1AzhIfvwF4w9p7rhqsF00hiTqi6Fc+GuvP/g0P8tqogr+hR144hBEtiu/4UY6nCplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063697; c=relaxed/simple;
	bh=lliYTDcDWFXIOovXV/GnzYLKDNgyZq3aHEx64HFQIkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W81NEaOtvqIbiOUZ+bwosUx0mOU9AjzEJL+cP4pSfyWiaU3fXj5Y0icw1Ujel18YIYoApu+kfmyqXshCbiryPB42i+IUG4HI/BzvGOOo09SU0qTykGw1qADRiYhiHSEpf/FFMQDL6hr/MXqA+UUInDcO1/ka5NjxyMU/gR8oa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix+YDVBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix+YDVBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F041F00893;
	Thu, 10 Sep 2026 18:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063695;
	bh=lliYTDcDWFXIOovXV/GnzYLKDNgyZq3aHEx64HFQIkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ix+YDVBSkQf+r91Oz/ehXi80ggefF801WXUd60lWcPGy+059n3ELKqPmoaUqXKqPm
	 AOmPQh0ESDAX9XgEnffJ1+XrUZK3e2+S/a7jsWgLn5ijkO40NAg5DWOXTEU1sHjMhX
	 FTCM7d5nD/WQbPXuGfoFAnx1v0UxbyIe4rFzrSUBN1mF/z68jx2ML/tMeEv3vtTp0E
	 nS5OSZpFre2EJd6lsWACt9duI5K8ocj4Jb8G8l2dBLaRq2yj7kXtFnpcIXg5+W3c/O
	 MYu8mMQBMbIKmizeAw6L9pasXaBpXSgnKvJ2dD4H9k7V7sVxFlMbpmWaKGTBWb6dWN
	 CoOAP8f61QiSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf header: Fix potential memory corruption in
 cpu_cache_level__read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910175634.3014018-3-irogers@google.com>
References: <20260910173715.2996571-1-irogers@google.com>
 <20260910175634.3014018-1-irogers@google.com>
 <20260910175634.3014018-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:08:15 +0000
Message-Id: <20260910180815.87F041F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> strim may advance the pointer assigned to cache->size which causes
> later frees to crash. Fix by performing the strim and then memmove-ing
> the potentially shifted string back over the original string. The bug
> was introduced by the transition from rtrim to strim, as rtrim
> wouldn't move on the left.
>=20
> Fixes: 13c230ab6e56 ("perf tools: Ditch rtrim(), use strim() from tools/l=
ib")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910175634.3014=
018-1-irogers@google.com?part=3D3

