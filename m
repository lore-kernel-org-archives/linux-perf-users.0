Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA06481FA5
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063864; cv=none; b=fga2mSQ05vA4191IzqRon4TDlih3r7MmtSSQ/9VeemcND9ecPx6LvVQVoz+jtPBpEvY1PIOQ6OfRTITdwEXwC2wzW01h+nARaXgdfTMs0nXK5+lDYVplC28RHdZU7dK/fm+We1auqUwSpah4EkYW8mNT+GsM1LszGVgIS3JVglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063864; c=relaxed/simple;
	bh=o93ZkszQjLDx/LfQQ2JXR7AF3I5tSpYLuAU9jt/67TA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oOQJVg91t78D7EHkqrwOJR6MO7APoEUdyqO5l9Lj7KwQLVHsKp+EOhI6rYGlcoKXzuY58OHY5QduAoPBpEVLBJkpdHWlQ2vhcdmeejnPyDJdkRhvyjT3AAsELXn2mLIJygEoZvhFx9jRvywuyr8/cYvDdMkdOrtj4DIfS07MLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WouTMCZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WouTMCZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A22D1F000FF;
	Thu, 10 Sep 2026 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063862;
	bh=o93ZkszQjLDx/LfQQ2JXR7AF3I5tSpYLuAU9jt/67TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WouTMCZA2lNOG0mqwkSkbtamYmsRmN0ufIKY61zn9mv4aUY/THKM+H1zdqQXAzIdf
	 3byx/VOddM+EiTSrRBmcRy4wSFjSR4E4yxSK8eqGRVNT4QDDV1pym7ts17pfbdi6Y+
	 Ft5kktB0emonNFmk2NzOJYr0VQs4ApI8ZJalQ6iUbwC2IUGgtyToISrVPly6EN7JLq
	 xSncUmkTijQlWH1CP68u05l6Czjf7a2PJMTVHMHqY8LWYn31MS4QgCqwGuo8niV5xs
	 +MYw4YU7s6u+kk4/szNF7DsHvWHUvLOPmfrGzIE6uhkgKvM4M8G7RJjY+ocd+sUAVi
	 f5OJddoR5xD1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf test x86: Fix missing __msan_unpoison
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910175634.3014018-1-irogers@google.com>
References: <20260910173715.2996571-1-irogers@google.com>
 <20260910175634.3014018-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:11:01 +0000
Message-Id: <20260910181102.4A22D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> __msan_unpoison may need the sanitizer header including for its
> definition.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910175634.3014=
018-1-irogers@google.com?part=3D1

