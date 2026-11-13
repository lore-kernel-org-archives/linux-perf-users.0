Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603587;
	b=P6jOb2k4D6aKeJjXqYyF0FE/YRcEf1DwjeaKUoUsFeaQalQBjjdT0rbJHHz3gjelzcmp
	 HA3ootXgrrMuFOidMybQPtFYSnSMRDkh3JX6klarewgJOipSZysFVGFRs5OGEeRhcqOtY
	 Olwp0S6RJq3sKtuAdrjFXGZZZoMzF5Epk2caC+lhGqt8U/FAEbolVO/aIip7X6bINjPDV
	 ixQ4okIbbW/HYTRBVS2Ukqo6qNn9ILbpr7VNJdt7B5htjwKsJO2AtqtxUactedOZ7A/7/
	 H9CfZjC7BuglEUXMn3pwwziIoCRX9BktGQZJz1tvD+f/88yEzsncclQM3unUZOQFzRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Jb/vZedaFtzv+cV3H3oTn2yESNzCCCNa0fucIDTzEg=;
	b=lVjkfXk1ZFeAhkScT9VnuDL2f+B221qXo5aDwFThJgsV8Wq62FuIZlUMLJiaCsL6e6H7
	 yBQswlSDP/xfQ1QiB9J7vtAHXwHf/KfCENx4UOGG4NYw2/lgKfxUlzQgfvpaACFEycU8Q
	 ariPRmTxzOXoRomLlyRBnrKQY07HzELBGxVcxMxpqG5hJ8ZQYQ3EVPtS8vrtoAs5cegta
	 /9ESnQhaUu4yPBus3PWZtasb5yMUZIDD9FvF7OzsA+buvUAYyXyQBhsoeqyHmibZWEonm
	 G4lioWGr+NM2yeNy3GqwBXZVbpaSjIrtaZAi5o+eI3oTiG7ZgICp1xt7Z7pRLPzWklQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jMUULD/h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD3606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMUULD/h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7241F000C6;
	Fri, 13 Nov 2026 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603586;
	bh=1Jb/vZedaFtzv+cV3H3oTn2yESNzCCCNa0fucIDTzEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jMUULD/hWvOyMNVam4yPu46SVBBHt2nJZy7HFL11sWhXZTJjWo5Y3Es1UXtmZbSW4
	 BFmrGe/mLDwutSa0Szxjqub5VLRGIhCBpA7uQlKVcVQVaRlJfoyng588gkMwquX7z1
	 zI/o03LVC5BCG782qlbH0ttxWLTVEsBKE+P6LL6PqbQz5i0C//yUYYf2E2Obd4TBbr
	 xjKLpV93w/2Z3tvdDb4JRyR5KHoRRxiIIJ2Xi54HNmGQm6kOdA0Q+bwXHy/SXR8WqR
	 PXmXoQkKIuyw79co6fZ1GihKlM/DIhBP2o4VJpGjVCLiHE1S8/8cOMTvOGqUVFkhS3
	 uOcS6RhQYZanA==
Message-ID: <sashiko-outbox-213688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/30] perf metricgroup: Move matching of metrics to
 recorded events from perf script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-20-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:59:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf script finds metrics whose events are all present in the
> perf.data file's evlist so that they can be displayed alongside
> samples. Move this code into metricgroup.c as
> metricgroup__add_matching_metrics() so that it can be shared with
> other commands, such as perf stat report. No functional change.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D19

