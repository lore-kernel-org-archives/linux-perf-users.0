Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700676;
	b=QefNHLeespqLjMtX9MxjhpvbN4MuoZvx+zW9kHFT8+qMapjtBv3KZl7k5rsBN+qCRUyt
	 9iPlIx7tDkA7vgeQhxb1d1auwu0IwiCa37czYG9xLq19gCNxDECVTi1RDMyJSxBr2FmzY
	 89ElPRGnc0xFloo2ZjCeKt8vv2gh2zQk4ByrAdTr6RITVdo/4Y2gjTKNXHLhTkBRYTOad
	 cyGo4mVW6eFxfg/N6rJVIceR2NlEGS96QIny4oHR+WgfS+RU7grB+2gks5armkTgqS5aQ
	 uNW6OBmnwHtrAPvJZP6P4Nu6GYvrxH5RL5M8w87CAAy+SOD1UuwjBXTSrW1Glkt7v7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l3S112asDUN/QGwUY4Glzpg/ceiRTBTTSiVR2Jq7mGI=;
	b=cnJM6t7isIgn6H+WNsYVU2D4nyBw2tB/TG8Cu9C6W4RT4yHCPPQMFyxshgiPa8CFpUWp
	 dQTwZyb+Ur+O8GtYoSoVtR3mq29NwIvW6O/4gNmn8eSSA6zZ7VyMDg77i700CE9eqHamd
	 iROO/qY0uQ7h+1tLqSrow34YdpJ9P2g2QZOIVeuGU93b7i0vPnvgfd4m+h4rIAKmQlmDX
	 11v0peTPGljIieNJxp0dm/s0UO1pMWmVy4cd9S3bMiGSoGV+UqOUwei++yfHv2hRhBK5r
	 m4vh43ztOClsKhQgEHZcKpg6WoLIaKpG26Y1SSCVL5toOkvHqCqSEq5yU3HtOLXBaBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUxFskYh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5C606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUxFskYh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615D41F01825;
	Thu, 22 Oct 2026 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700675;
	bh=l3S112asDUN/QGwUY4Glzpg/ceiRTBTTSiVR2Jq7mGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUxFskYh4ChnsQ8xr657uYqnBhhkgVW+Se+gtZrYvM4K40m5VYR0PSn83Dn/StCRi
	 Hz4LP5+1zxh4a//f4gGiImjWAyyUAUTI8F7IY+rL0DIlFeGx8vraFyzHhFQ/ofrJnQ
	 qj0GEi5/4NyTUJThDwuP5H89auBhIChedPtDwfAO1Q6JKY6MqR7nGy0IgzldU90V7n
	 45iYXylSnhx71lX8/lF175G+CxZ7f7Qcn+0J3LQBPmAtJ9N2LqfWgMhYGa5HbiO6m6
	 FlOvKEv3ZUXBOC9sZwigYdPyFbY7uQJQmSf6aTBHODS/Gab1WCqBUKKeuvy5FECbfb
	 QloUuGgjjYihg==
Message-ID: <sashiko-outbox-181994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/19] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-14-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:24:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_=
open and
> fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
> tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
> exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D13

