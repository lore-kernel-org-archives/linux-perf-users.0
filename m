Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C5389106
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269692; cv=none; b=QKzR8uj+AMUeqdO6jd9iy/GOvIq/57AQmZ0CXLWdsdNIP96EWEfXrbCo2JRNZ7dnyWWjDK+N9XTCqkcllb6x8F7gw9WayFegOwPG8PilnUKcFp15P+mRqbKXIrCrUUbfWDVXN+BoR0yglcR7YYQGeloquL3FshLmtmA6pyg2Hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269692; c=relaxed/simple;
	bh=uIum2N5Rts0q/ExfRjU6XssqHbLfZBG2INBW4SRWlMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VuQCMdGtMrkSafhMXAoEQjcLxVoyyHJcFAJ4ES7v+pEphjsd63eX7XKw7lMjlqJVa26lQHVwtqlindjUAvajKIwtDSsYO1u0cA5xHnxFxAjyFl3wgLGyuIqUZ4C0riI/ZIgZ5KZ2WgwTShaVGL/9L5bl29vQXYRdKFlHDs8x/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqG3702x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqG3702x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4201F000FF;
	Thu, 24 Sep 2026 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269690;
	bh=f0lhfd6k/nRPvDeoau3cr/zm/oWuLoQujze6Cb51s9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FqG3702xHKyYS2RsHZ3GLV5aiWdCKEMwHUbfrwIPY+m4WTwQs0SNoJzHvA1n3cA5N
	 Qn71cyCzsq8g65khw8tdxhwsUuTcdm+MOcl3MiLiT2wgjR/7jkn8vZJ33csuZJ1M9S
	 Q2mgLpRcwKu5NgSDcxVPr0pKqoUaLwkOZPEsygyyMsZTiR5jqiotIOV2jh7WQ/sKTD
	 C7BeuM+LcqhDL02ifLCek1PzPxZfSgSSLJj21NiE7B53QtGHYcz7dQjuQZi8XMJ+NO
	 zouvaDvzp8a5DHxfmoeXhHb8tfVJb+7giT3A2xRZZ/cRZ30SFu8WOy34O0gJ7zmXxq
	 DD10Ry4LkFvww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/26] perf vendor events intel: Update arrowlake
 events from 1.20 to 1.21
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-4-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:08:10 +0000
Message-Id: <20260924170810.AA4201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/335239ef9a63a3a6e198233678f8987=
61cba38aa
>=20
> Fix umask encoding when UMaskExt is used.
>=20
> Fixes: ba56a910635a ("perf vendor events: Add Arrowlake events/metrics")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D3

