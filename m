Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AC3E3D80
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269732; cv=none; b=GCQahtV3cmMJZm/oduwbjzLbOZgQjMF9LtMlqzfDuzSB9qBh/H0ojiflXUwYHUMw69mgdUSmbQvqJieFPFbSnJ2Yxxz66bkt0Ep/0wobSLKryI+F0nowrntEKk4mJaw84n5yQ1pGtoXGFFvEfB1WoJj0zdzlWKecotHLbZS6cKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269732; c=relaxed/simple;
	bh=ATY3ECnAVtNpJmQ4EM8BGzci9+PDm1KmwCS+F/a1NME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2k+pDIJbjZlr1G8jEdGttSkbD8S5nrCqzAcsCDKM0Fnx1ODOdfs0Setr48ia7SEKAVS38amblvjJFXmrZm54/ueLvfAEG+1E8xhIY+x/01frtz6vjtPsH+sS0QQfRQapgT4Q1dXsnmsTuulTnBrLgHStdP/1FKoOExHO/BklNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibW6Y26o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibW6Y26o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C85C1F000FF;
	Thu, 24 Sep 2026 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269731;
	bh=2qhLYdpU114nZ/3FrmBLfl4kxZPvYFqZw56QLMpleMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ibW6Y26oGJHJxK+tExstIsycLam81Z4qOUtz5gGBqIWiu714Tkq7MKJx4yJxuof5o
	 L6iF4URMaYe5eI4X09vI3UsMjad4C1OuJ9ljHKx7FWBMSpl1kPmql0ANz5tFx6C1MH
	 +Cdn9K7PZI65i/C0ZISwLGI6EPJbCExI0QfUkJbAfdoztzpmDn/ktFh38YW7OdWlLz
	 X9nIO55DPR8eTUqmf/ryJsoUlaUbm5ch1ijttLwyLg7oWl4nFrb0Omko86lWhRY+bD
	 J4xLclV7Gfhsllx3SH5gvjo9EzI2Lm3sLwovigP8bu0kXVjes6z2JPlo5AxWSjF4ZN
	 rLVDNhQQ0ouDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/26] perf vendor events intel: Update rocketlake
 events from 1.04 to 1.06
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-18-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:08:51 +0000
Message-Id: <20260924170851.7C85C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/fab8d8848e1191e4a2ee57221cf3f79=
294f030c2
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D17

