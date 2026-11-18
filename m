Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019988;
	b=1vngq5yRn/97jCyf5xc5ocMv805nJKz9w236TNQGGarShnT1SLgukMeCq208WoN48P4B
	 6MXe2kVzwgQ5cm+x8iXS5T0MLxJriof+/Ib5g9NH8Hpa/loh1GUAHbe76miV7REn0lQt+
	 0BhhwVzSHfUQWpJyNP5rQbiUE9kyAib36mRhNY5eoQiWUjLglJrqfO9RU2TAxalBSuNTC
	 Jcz0rS5bmX9H5U/OTBiuz1XVt3Y19GvTnjppd45JG0mRrWXzmhaN+EKA7OU43U6FkYZho
	 yKwjJuUzewXGmzUh5raXvlttAykLeIOBCE2JQsBrGA4XViVnrXarp6Yp05DSV82YGtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2e4yHb0BNh6dDeg8Dy/b0HiFz6RdYSESxVPvZNqAff4=;
	b=gc404PDhCTQ6I2mhQODX+9bTn6CRF3mgeqK2lWS7/7lPd+VxDBEJHfKRuFC9V7EqB/0G
	 bwl2lET9FTfosmhgFPc9uQkg9djLE+42qhcVWhlyejVmGtQfEr7Gdlbf9X1HuSGxmtTF0
	 ubCaD2573bfT6WhfYqjT7II+N0jDUNrx+PKsUpSgg8pLp3T/Aad8O7NetcrR81Ez1gV48
	 akweqbScI0bCKsfQxIEaxhYAcWFGpt0SqECMg1dpD8CpPIhKpseNev7L7nVBPWWN6dvXS
	 WOaSpJ2iKFeIvJHw/NLie9NFWTOY27gUEdHsvqZwoieqngKp+dix0hjYH0YsDPxX2uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWZ1q7bf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402A606A33F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWZ1q7bf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAE41F000C4;
	Wed, 18 Nov 2026 16:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019988;
	bh=2e4yHb0BNh6dDeg8Dy/b0HiFz6RdYSESxVPvZNqAff4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWZ1q7bf5t6u/v6BdJlJzmSZRr9AZOgHQm+sISFzSDo3j6Jut3DJNZzOiuj4CPH45
	 2/MZShV7kA2qRwYVg0Bl7X5TnPLZPgZ/AkJwEtR6NVaDFXScdKrPDMw58V1dpyDPJG
	 q931vLMja6+zDRCR73S82KUopZ1ZY5xwBrn/p0SWZgHAHXecqerjLC++mguuFnbkDz
	 1cAYFR7iENp3mig0nLcFdqZL5D9knw1M1WLEQHchzDu6d88W7zVGGB3mXB1JUyeJdF
	 r6wN3uq7IrR+92BAFpEB6bulD7JuV8heSHrEMCvpmclw3RMHGS0avBP2QwQI5EVQ+4
	 TWc+SFq6sxHYg==
Message-ID: <sashiko-outbox-221520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/34] perf cs-etm: Decode one packet at a time and
 don't estimate timestamps
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-19-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-19-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:39:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Stop decoding after each packet instead of buffering packets until a
> timestamp is reached. Give each range the last known timestamp instead
> of estimating time using instruction counts. This makes the interleaving
> of ranges between sinks less frequent, but that can be increased by
> increasing the timestamp frequency. Timestamp estimation only added
> complexity and was probably more misleading than useful.
>=20
> Until the first trace timestamp is found, sort using zero. Only use the
> AUX record time when trace timestamps are disabled.
>=20
> packet_buffer[] now only ever has one packet in it, but keep it for a
> later more mechanical removal in a later commit.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D19

