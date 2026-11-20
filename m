Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188660;
	b=sjbGgq3UsGfF5RcEbZjq246gkD8oTobitSGbqgUblp84lq73SVqsErj/7ze+I0w1+huL
	 KrjpUZtLa1pjAZk9DIA9Y9vYCbNVeiSxfcnwrIoRX/YhgKuVRdyf0kGLNBbH4VSnaMI8z
	 1AynergDW/Q7cgoWZ4hvkA04UE9MXbV3tgK3CpYVsDrRPVY8Wu0S5FonRz7kvFzfdKdKz
	 tCeeDgOocS2YQ3qHLCWRuxxejqiMPKl++liulNfMhFYPtOzz9+At1StIFwgCjAaZIMblR
	 0/5nzf0ptf93G4DGE6lcSWJ6I1u4z8YlYNScpEPXle0m+MU46nPFbGptuPOF+5W0T3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6AC1OIv21f/RJKt3wdvF6q4kFa2PnbXeFb5yeoHcL70=;
	b=3Vqjv8EDlLDUl9PoL5UZx9Uplp1XOd4Nt2vjnRs425tEMRSMw5nijyy9qtrCjCudvfVF
	 /BeQq6uV4yQet/9FcwWomHBy2TnwF4mxS5gLnk5zZE7YT8RMEtI563wWCpccjdnRsZUgM
	 IhHLV/0NlR69Lpx52Z+bziAmQqB6UsCy+AyTKAj3lBqTdl+B1nEX3lIJwwOB0lqPnFzvB
	 yyPk7gEjg4saQ2zpws6cK2yMcYeik6zSLSqIs6uMJ7L5eV3Ss+DyEzkoO3odPqR8SoP6Y
	 c2rZwhy3Ty3Hgs/Qq6Jf4kdKtf133dqncsXbNOcPubOLYzLfZbYnngd7qUCy6qhqGVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBbGRMwM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4814606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBbGRMwM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40061F000C4;
	Fri, 20 Nov 2026 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188659;
	bh=6AC1OIv21f/RJKt3wdvF6q4kFa2PnbXeFb5yeoHcL70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBbGRMwM0epIIoWqG2ZE6hfqMMmKQ0iRnJHAZIyUCVfALEFySxmB6Il+UpeXn4Ehw
	 3xfHBxbVgTcpl+f0D037M/xI6xd/zrh8nw0xxr3BQEZl5LDUuhYrck9zizfRoKJvOA
	 2HZOIqKeCkV1ECVMxB7Qn/colnvgEaW1JXZzNIvt8HbGgNtf2JkeuHhYnyb12xol9Q
	 /csoC5vqEnAlEUF1SBJ820+FB7xubh/LvUaj4EkgEmd/oEIEetpUrH5hU87WNMPTCc
	 QRUHZ6mNaqDrAPEHULpMHoOho1C+LPybGxCbzkH+thGHdC0NwdS1DUYwQzPrrso+wb
	 IzwOutPM/9scA==
Message-ID: <sashiko-outbox-225463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] coresight: etm4x: Fix event count decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7dbbb1306371bed56e3af4dabf88d3c18f471dd8.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <7dbbb1306371bed56e3af4dabf88d3c18f471dd8.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:30:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Leo Yan <leo.yan@arm.com>
>=20
> TRCIDR0.NUMEVENT normally encodes the number of events minus one.
> From ETMv4.3 onwards, including ETE, a zero TRCIDR4.NUMRSPAIR instead
> means that no events are implemented and NUMEVENT is zero. The sysfs
> event controls currently interpret this combination as one event and
> allow writes to unsupported event fields.
>=20
> Decode NUMEVENT after NUMRSPAIR and store the actual number of events
> in nr_event. Use the decoded resource count so that older ETM versions,
> where a zero NUMRSPAIR represents one resource pair, still report at
> least one event. Update both sysfs event controls to use the actual
> count and clear their event fields when no events are implemented.
>=20
> Also correct the instruction event enable mask for the single-event
> case to use INSTEN[0]. The existing mask uses INSTEN[1], preventing
> event 0 from being enabled.
>=20
> This change depends on the recent driver refactoring. With no reported
> failures, it is not intended for stable backporting.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D1

