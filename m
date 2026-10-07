Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EF3793D3
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417460; cv=none; b=kPf9kq1YAefpaiVPVpaKvETzzP8xYJTjhfMaSbdxCCHwbpVjGb79DsvUt8OjIbFVY9Mp7Do4aqaqyROneyTyXT0h7GaQ4egYdSguZpWSywvM+9tq4gugBokYp3dLoPl2AiBgk+RZmfpPyhGc3b7lYo0ej9ygWXD68KHnQq6SJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417460; c=relaxed/simple;
	bh=j+DMxe7PTqMGNAqhrnEKRRKLpqm7fgwKAcGyKMOcla8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IG67wVFmzEW0OG2l+gM7/JVBJXcjwUyb4nYw0I8mgZyas2xRPvEKt6YRISnwJUJ+n7fywaDiPjVbifRnQO1luviOfqXCb5+1kfgSXrxah3BNiIJ4rAHziEH+VhuVbSqPHHeVtn4QTVF98iJXcGiTFeWFc9+FX+BYMXyX8D1P48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToWeEZ47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToWeEZ47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837671F000FF;
	Wed,  7 Oct 2026 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417459;
	bh=+26pYvrMWXQUMEHOxZCgx6rZ3vD7liSsyRy4gTvrfIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToWeEZ47eVwrARL67aAMfN2cSE+tW/modeADALnGeBlgJCQGLfmC0QensF3clrLUP
	 tnjURilACxPlVkX6BtUIsLiAWD/X6TdPr7uC4ASHI5MJojh73Capv3wvlF+LjCG7iE
	 NPqYFpKKQokPWcLFKU2F1S9BzgS03pHLJpjYGbzJ8buIDThOfdkG/SqeQptEog16r3
	 /Vevi4F/fL7LoMrwCNOF5P8lybx0Ja2gEzqLX135Y9hRwHglxYB0I3yGcCMNsFPmjV
	 uH+w0Z3l3O55X64pnJCWbm81kKzP51COK69ZyDFZOSwVtIXdjSi7dAbmaUdCxdHNXL
	 MDvljMCg5GBBg==
Message-ID: <sashiko-outbox-163444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/amd/ibs: Clear stale IBS_{FETCH|OP}_CTL in
 perf_ibs_start() with CTL2[Dis]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261007234815.4026028-1-jmattson@google.com>
References: <20261007234815.4026028-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 23:57:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 1b044ff3c17e ("perf/amd/ibs: Avoid race between event add and
> NMI") makes perf_ibs_start() reset IBS_{FETCH|OP}_CTL before it sets
> IBS_STARTED. Thus, an NMI from another source that arrives before the
> event is enabled finds Val=3D0 and does not process a stale sample or
> enable the event too early.
>=20
> The reset is a call to perf_ibs_disable_event() with config=3D0. A later
> commit changed perf_ibs_disable_event():
>=20
>   commit efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to=
 eliminate RMW race")
>=20
> When IBS_CAPS_DIS is set, the function now writes only
> IBS_{FETCH|OP}_CTL2 and returns. It does not write IBS_{FETCH|OP}_CTL.
> On hardware with IBS_CAPS_DIS, the reset does nothing, and the race is
> possible again: CTL still holds the previous sample, with Val=3D1, when
> IBS_STARTED is set.
>=20
> Clear IBS_{FETCH|OP}_CTL explicitly when IBS_CAPS_DIS is set, as
> perf_ibs_disable_event() did before CTL2 support. Everything in CTL is
> stale at this point, so it does not matter if this write discards a
> Val that the hardware sets late.
>=20
> Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to e=
liminate RMW race")
> Assisted-by: LLM
> Signed-off-by: Jim Mattson <jmattson@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007234815.4026=
028-1-jmattson@google.com?part=3D1

