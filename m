Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F793D522C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882355; cv=none; b=UeIJlSZt0SqjNjuVpYQeYLNMlqShgPBg8a0TshlrkNMtPIOhDHaotmbkg92ZDjjBVccRLVimKobCFFcJ65ZcIWKjtlHCS1u+e484/7vlO/6xgWQbbDp0sk9UFmj01YqTnGMR65eMMM/5a2hFuoQ39BuyYlcgpsMAmi3PuAyj0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882355; c=relaxed/simple;
	bh=PlT9VnfvGLWMjSJqUDfJbsAH19b1pt7/n13pay4LNkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DbMhEo2ABpWh47cpYVNr6C36fBIDeFYar2T5ppvkvc35TZElAhQcLZZw2/opDXPpJIWhsD4DSV3qxXSnczm8Ep/eJjZzEr5xRAdJasv7onhXSdlDzBM80g/dLDz+r4WnWu+g19PareQk3xBGjPCmDy0px73Oc63J9RH9coVgQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqOoeV0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqOoeV0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E141F000FF;
	Sun, 20 Sep 2026 05:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882351;
	bh=PlT9VnfvGLWMjSJqUDfJbsAH19b1pt7/n13pay4LNkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqOoeV0bcASTGwW/0HUbBIRaZm7+7EE5yDoLjQ/oL+0RgV1KzY+pdCUj5nZhg8QWG
	 QojqRFBhnmLNZWjfafMNNisID2rQzq4ytpt6gRY0GM1iPV9bnFcbSUzLJhD7b0J735
	 PV/Ud4adw1Znuwkw1zWzT7OgELbNdZCbS63Uv5p1kry47cmtvLpohC1sFEJiDfPAYZ
	 0EFsUegeu2KSxcg9p8I2l7OEEd1BouypjApceynkWeGIyvPquaQTkt0s98lB72mQwm
	 WcCHK6B/C/rVWVZBHtOrWFoHU6OqG0yHwff+2Tq1zXzhkp3r5HFO8lpqLsWInBJatS
	 xZqUkw46uh/uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 15/49] perf Makefile: Install standalone Python
 scripts during transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f8600b666480094589f38b430cbbd0519d1d539f.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <f8600b666480094589f38b430cbbd0519d1d539f.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:32:31 +0000
Message-Id: <20260920053231.87E141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Install the newly ported standalone Python scripts from
> tools/perf/python/ alongside the legacy scripts during the transition
> phase so that newly ported scripts are available in the installation
> directory before legacy support is removed.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D15

