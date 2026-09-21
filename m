Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E3353A73
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968443; cv=none; b=SjMsGss8FDxaYjyNmrt1RmM985SGDWGMBEgDo32JglmNLK1dk6HsOs7BtqsxHMzsP3/QNCYeYGXk7fKpad6m/rbjajERFxBWUXZYRAGxmdJwaz3RPq14UiQUrD8GahgpsJ7+q1VGMkG1FhKSFbtb+AuBIEU7H7vCFB9+5y7lYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968443; c=relaxed/simple;
	bh=VbWky2aCYRIy1Ou1Bv8ADl5hzzR4+mhbii8lkmOc5v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Touz4gdm6WYVOGWyHyWtfZxOdoL7OMd0FNmKTRasac3WSqXu+qfrmHXfOefaVoaTAuk8fs4qJGYCXqcjYjfuxVRVBaxL4f9EJC6x5IV88qyjskrkUsL6uEK//Ffr+Nb0M3K7/9hsIXchcMulWt3YcnMUjm1o3iK75nO40FcLiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvNSzNvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvNSzNvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D21F000FF;
	Mon, 21 Sep 2026 05:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968434;
	bh=VbWky2aCYRIy1Ou1Bv8ADl5hzzR4+mhbii8lkmOc5v4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvNSzNvtCxXk8oIX+/4dMAlEU07H9fb9fEeyPp4nknWnxfm/+pZcxTvxc5zUGBlY8
	 sU+gb6Fx75apOW7GhekLNZuMuJkWS/C5pwLtfAwsmFRWVP/AUUb0pyxwSHBNJDoWFl
	 7CAQ3smvqct0Nzx7ZUm0xApcA1n3AwtM2pdTlWcSz7JC7P13Es7E7sJZGRJPQmGB2D
	 i0Et94Q6tH8Op4OszsV1IJ7/1V1fdrFYdG3Gf6qd4mFEFHfD57n+dNsWDFRfOB1+lP
	 p5qWcsnGGqAAKn+kZarsWKGS/Z6dgyGhS80xfXM5K6a8jUTmz1Jg5847o/oo7z+ZUr
	 2Me+83YKTbsAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/49] perf python: Allow KeyboardInterrupt to
 propagate in LiveSession
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f23fef97cc4532fe1f6729ad6533d4a3f2716bf3.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <f23fef97cc4532fe1f6729ad6533d4a3f2716bf3.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:27:12 +0000
Message-Id: <20260921052712.E76D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> LiveSession.run() synchronously blocks while polling evlist for events.
> When running interactive tools or scripts from the terminal,
> KeyboardInterrupt exceptions raised via Ctrl-C must propagate so the
> caller can break out of the polling loop.
>=20
> Previously, LiveSession caught KeyboardInterrupt with an empty pass
> statement, swallowing the exception and preventing calling scripts from
> detecting the interrupt cleanly. Remove the empty handler so calling
> scripts receive KeyboardInterrupt and can perform clean teardown.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D10

