Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F533A4F50
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849014; cv=none; b=I2D0W5ylRluzTN3k581sU0oFRdfYZSh8rqwJFJpR1OAZ5+V9aHq3upPpQNrhrXfTGPic5wFPOLiUyMjLrnhStYAVdVv1Us/ABNw2zvloaIdpfidGKBeMEsuOAeupW+qvTVloy4iNdnt7f5y2z3WZH5e/DksfzW+0wnuv3HhG4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849014; c=relaxed/simple;
	bh=FlREecz8k3+VtVrNNvpMJEOu9Brpn6oWFyuNz9ypXw0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CpQXXokkqnPlF02Xs5iLYWSNM3OIbWcdp8VhKVDGLXqBqlaqT0gIhR52iiw3v2RkgMdqXb3Co0/GJ+nnnllCmFjqh18hpDMPMryGAX2U1v6EG0KKGAYiFpbP1Gu775BjzTCKOmoqqOuodtDlPw5n+5JMKb++BijzvQyVeFlU2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCjXIso7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCjXIso7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E181F0089B;
	Mon, 12 Oct 2026 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849013;
	bh=FlREecz8k3+VtVrNNvpMJEOu9Brpn6oWFyuNz9ypXw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCjXIso7Xv8+koy7uIWTBp6UUPiNTKmXAF5AWVvwsEaPOuL3z/dKe5+qVAK93pc58
	 XwndceGX5nGnR2+pEp74VTXLWZl66JaabuLJdyJ+ls+KylsC23rqnNwOE6Sl3u5JoK
	 obYaCWz/QULSUJ7yr9Ih0YxVf3sbwvctOz+eJA7JIsu9qQYC4Na9dxEL0HV73b4cGD
	 ceqKmD2k9ACvl/qXLCZdXtRtwbrel+kySp3b1yKLpyuqsCzEAqysxO3nTt7Ar02WvF
	 0QwhiwWJ2nE4OiNANiZshftvSmBldfIl/xX28ANXSmpZvZCBLmTnV2KDPTMOYdLL4o
	 nZ4liy5Do3y6Q==
Message-ID: <sashiko-outbox-168738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] perf tools: Remove redundant dso data init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-2-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:50:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The fd and status are initialized later with cache.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D1

