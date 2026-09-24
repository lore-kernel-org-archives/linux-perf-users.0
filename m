Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02E3563EB
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285688; cv=none; b=bS2bn5D2PagLLioJNaHkMBEuCBHh+6Y+jlZKjwGGYTaeQWb7cWO0oAvFFbI2ryVstrZwSWqgxbU8hhGyeGEzpMoScxt1zChoGWFa9yDa6df2bLHSicrJtKgvfml1C2K/2dzZTBRq5OAipRTiJicjX1PGL0NzZTYS9qtEWwjUx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285688; c=relaxed/simple;
	bh=7hunXseB4cntmyRMQqPx0yC/dZSny5maRXAt3bi41Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YNgqXiz8HVmz3E05DAbh2a266gNqfwglkzWGpv1W8iOmfJGv6wGh6zE7DYfSYDVIM8Eb7vXeufNku3Ktl0hyYZ0ozD9quctNR0dPSjrTv2OMGM52aLoNmOhm3WimumNsRRVr1jcaJ2Y6kE7DMQ2ayLIQqqLbwGnj3pG98jVzSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FALOW1x9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FALOW1x9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4844A1F000FF;
	Thu, 24 Sep 2026 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285686;
	bh=7hunXseB4cntmyRMQqPx0yC/dZSny5maRXAt3bi41Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FALOW1x98YSruM1Zj/XaOhZ38oMp+cV8DTpUe/pgC/JrWgYyt1fN0Gr50qWU+mD3w
	 +ajdmS6GjwvuvLtY2syt5h9O8Y5X7ZzTgjtB1ht18/AQURHBYyygoME7p6lFMTXcCz
	 dUevD1gukwM8csKNQU4y+ACeQzDB9DXYFTgzXRzsJuwkV0aVNzEShFzitHuYdRLo0R
	 15BvqO7C57mruYUwmLAKN5OZr2ayHWbGr3KOMJbS+tB2oqrIO1BCEKpAxo0EsFJ3DF
	 NV/7S4se7Xt3RaLJxaTG+Gqzk9hdnJI5MglSr05h46QMctMpPs0vZ/gmJ+DEyIvxY3
	 EgfVXwpbcE5Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924212809.1733663-4-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:34:45 +0000
Message-Id: <20260924213446.4844A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> 'perf report -s type' hangs burning CPU on the dwz compressed debug
> info of libz.so.1 (zlib-ng): die_collect_vars() saves the
> dwarf_dieoffset() of the type DIE, which is relative to the file it
> lives in - the dwz alt file for the types shared by more than one CU -
> and update_var_state() resolves that offset in the main debug file,
> parsing whatever is at it, here a typedef whose DW_AT_type refers to
> itself.
>=20
> Record whether the type DIE came from the alt file and resolve the
> offset with die_get_type_die() in that file, with no fallback.
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924212809.1733=
663-1-acme@kernel.org?part=3D3

