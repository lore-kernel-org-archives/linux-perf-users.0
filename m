Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F763B8D75
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185841; cv=none; b=NpQWeI4306SCANbIR/Ome9RWdk1klGOSx8/kTNsHT5h21PHgj15JeQL3rdi25N2ZlSodcrlT3c8ug43RYGXDjfyPZy3o4C2dZArQrgEU6cL411TOWGC2oJ16s0qujX2bPWrNsYI6ACVNnaagZfQ1mwCbwHRUoJ8VZEcH3r9JgRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185841; c=relaxed/simple;
	bh=eRZGP4t6DSCnRtF2/8N3C6g7bPtDWw07YAw/4XKbrvo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oEW/JI2Ov4CYWZ+MQKpghPlY/ULXlsEsT+GmeXW4RfMkRt8ZBTnm9nR47CMADfEt8hK3ztN39wLMYPXcFVFTtvhlYkwNOOvxID2J7J0w6ZMhFXO3DYsCvJQmmpJ1DdeMNX+2K2N326wapiMGe1X2pRD5PnoHzTEawPUGiXGhPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEKo31IT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEKo31IT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FB81F000C5;
	Fri, 16 Oct 2026 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185839;
	bh=eRZGP4t6DSCnRtF2/8N3C6g7bPtDWw07YAw/4XKbrvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEKo31ITF/6Q91Yl8xSJp55ucLGD2bYyQ3Tc/bgzLUEe/zQ4BTHywrgYCrJeOjosW
	 nm4LH7NFJXFBHxk9cvzM0RJGcvnB9XOxspiYg0UwY9CGig8rxH/aPL58QkoDPPH8VT
	 GcRQi0fdO3xYYOQb2UbKUjChaAzpKXVATrF8awngN3iM6Lv9aJ7lwL/bRdIZSM5X/R
	 vx8JJqI6mbOVP0TAuily3HOasyVHh28y+JrirVKTrkWD1KgY0/fcwDRnIN2tnn+nI1
	 +GD7n7bt9aDR4/ux6DNgkqKnlAurXFZn6dSvZyIP5JbrqDzuM4Esc3EZiHo+9ztw/9
	 YLzt+HODfq89g==
Message-ID: <sashiko-outbox-174954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/21] perf python: Free the parse error entries when
 parsing fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-3-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:23:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> pyrf__parse_events() prints the entries parse_events_error__print()
> receives with the details of a failed parse, but returns without freeing
> them, leaking whatever parse_events_error__handle() allocated, so call
> parse_events_error__exit() on both paths, as the other parse_events()
> callers do.
>=20
> The perf test attr core PMU probe takes this failure path on machines
> without a core PMU, where the leak then happens on every test run.
>=20
> Fixes: f081defccd93 ("perf python: Add parse_events function")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-173525@kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D2

