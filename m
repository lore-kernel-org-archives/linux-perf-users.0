Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AA48D862
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916502; cv=none; b=BsQJbkLnoXXZVIjbM3z8M9nisWholn4Fe5INaSK0kEWdKt39N+ZFLP31zNtF/SaVs9FbK3x/kpsejwbZIbtRuUwlkXtBOVboaAZarfBE5XQzZhOGOyga26ue27JSHzdm6bVsETlw0oEueqt+EstiEIiisgH8bBa1zgGNBPuQpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916502; c=relaxed/simple;
	bh=4GAAc2kWp3VvKaQ0dKZj47TYLro3SH7yA2IbLwjYe0g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h3kECFcIe+rTqiJ0aJurTsK0rOkH0P4MZaji3FPJxDn089ZyQO8uQgL3pXmSpFBkldTiNuQkIUmTaSjWeMvC+WzP3iv39SOgEcK2t5DNhlDZueORNCyYCV2EB+IFLZAwdfoYStJJiAX2eqGGSd6wrqV3CpCGLikP8TjI+e+CRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/o4/pNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/o4/pNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9CF1F000FF;
	Tue, 13 Oct 2026 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916500;
	bh=4GAAc2kWp3VvKaQ0dKZj47TYLro3SH7yA2IbLwjYe0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/o4/pNzszYKw9kk+7ulXWKTzg5KJsNv+RfVaxoJvgPttqcluoIlCd1PXHH/nRn3p
	 KE3iQTWYekX/ZHCK4x3OCcpYZbGj7CdAEQ0/uMxXZbyZoIdcECO79ZPQrdmi51rEj5
	 klNc8wUehXSd86ZIbj9Z8KV+l/WaujaalmwQ3OXgwge349ZmY1sYBAdSi+dQ+DOuSP
	 c6VszNabOlTfUQwIsZLST86ULTmztVCgfsqnDC7WdLWvDYwwJgjhRzB9E6j5wlWYMK
	 kGxa5NnVkEJUJJw09zyFjDVneKK4/Ux2n8ajfRaRvtvt/3Qzn6lugSzeXnw82wES8w
	 hIOHxS9WYTyIg==
Message-ID: <sashiko-outbox-170337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/10] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-7-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:35:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D6

