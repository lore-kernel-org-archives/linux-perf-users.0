Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382B4EBAC5
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633573; cv=none; b=CNaE3c//jnIUi9EJtr1yFOnVudm7FpyGFTE1X0qoyrNB/6j+jSIVSuBro4C49uXEcMvZ2x3F/GDy3QeG7sLHsXc06J1p/2sEPFzVtqAX938e46hFBx5Zdg3Qt5T6wDNkexa3tGzlT6Bkh4BrHZLtgQStGXv22zZCNX+YuHkwZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633573; c=relaxed/simple;
	bh=Ncq8wJQxdpNvUDQOo7CvvTSMqfZwcK1X23kruFmZI5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jpP/SZNY27ReKsdtz6dPdWR1buaarnGAijVuZ1i+nGqk2h+Ad57xRqqnZBnQSMXpwvkyJJuB0JobnLOZB+KOi8zGZu29BgCGWA7auj//iTnaSj7nNAilT5YbjlUm/TIQKcjT/XpDRTVqTex7lsNeeaawze7qz8wy9u/VEorWnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0WH2pvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0WH2pvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8A01F000FF;
	Mon, 28 Sep 2026 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633572;
	bh=fc7KKdxYnk8FQTiUhPUkucEdQsMZOg3S8MixI9IW3l4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0WH2pvEhZYMwlXPmeAzl5Z9gtwSX1uPW5rB3CWb3tZJS5aphhgKCkAJ69lDHhuEq
	 DkC8ioW7LPQ/wP+3ApzauqPItnCo0gx3pkV8AeiBlb97Gt19lzWP2Q3JSvJvo62w9Z
	 rmcSH82BSIJflOPItuFH+OGw21ZR7zio4xS5pSKMERglhdtOKAGDMLz+QVW/uw2cgH
	 aNG0f8PQ4HBeNx83Gjbrp/rqbNCx3HLmP1wiDsfx6tOzQDF83OApzDIRsuhKjHyAOF
	 JVRyQN+M/QOyvoaX7tq61xMwKGsyD2eq2nnLoSK4sy6CC6SEaYSAZAzFtx9gvJG1sv
	 m7HizMBTfa5bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928220634.2451784-3-acme@kernel.org>
References: <20260928220634.2451784-1-acme@kernel.org>
 <20260928220634.2451784-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:12:51 +0000
Message-Id: <20260928221252.0C8A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928220634.2451=
784-1-acme@kernel.org?part=3D2

