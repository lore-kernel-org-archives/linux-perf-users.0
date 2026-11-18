Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020178;
	b=shawr/y0qKDTJIgbtmi3+JD6SqqDyGcA7WpSVDHpsqiXcO8jdjSk0beTk+9ITY7PacFa
	 MmxlAsYgWdujI2Nmix/RVKQwaDrteR7QnMQnN8KusbeaChpSLx8n2jY+2HGgVez30ayo9
	 tajEVZGBfmHto0nuRaM6Zv4oFqodKSFoiUbrp0DaXzwVp8qHCbUTJhQTfMuvTI9ICQyud
	 A5kK3OT3IiEZdcNOqMvG29rAC2iZ1kuf59N71oXgVtEqwiKNj+aP6crjtMCOUmo1G/Pkc
	 Pq7mdnYKAKYk2yz5gYujQIyFfYHsaeCO2yNQIbS7/QxPYxNGsgL4tYvnggljx625wLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020178;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PfJ7u2Z0t/ydrJkFLpsM9T9QHNG/vAgfrtIaxcFAW8A=;
	b=AULEaPBf+xlW8+jVpfAr/iLxDfV0UUBDq2ic95B1N+czu9hoTrsyn4oJckUm2YYWVCeN
	 bdG9/EAra6PCQNk4EZfmdfw0tBr/kjM5qCdsS4TxRFL0ivTwoYo7QrSbadJfSRnKgFpQP
	 d8q15OtVWoGi6JE1lI/LLp4GIl1zye+2iRZXZuabo89xMWBg4cDXdZrrxaHcCKip0jG85
	 zi8cfnCyxP/ohSgUSKLqdDuQA/1xtcYgx/okGBoJp7wRr+Xj8D4y2lDbXC3kCB3Y1gE+U
	 B8+WoZ+PCw602oHnsfbQJk/ID9bJj2p1Tqq4zfYRpV6YWcK32Bb42zmm6y9gvXpAhhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhJzCydh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA7606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhJzCydh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C931F000C4;
	Wed, 18 Nov 2026 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020178;
	bh=PfJ7u2Z0t/ydrJkFLpsM9T9QHNG/vAgfrtIaxcFAW8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhJzCydh1Ic/u3YF+Qbe2snRJGE78QHRW95PNF8XqzYjLmahnN58XX6dncFHS0aMD
	 vzgx8YTFHenFo0AQY07csMWiv6DYkMo5oOUgjmO8gPDIiz+ibmV1h1L+vvbdcxTMIZ
	 HnQ4JLlgjDKdntwllXLBufmGEneVrtpBCy6FiN8kS8oodrH3DCK5nE7TyUWu9eFN+z
	 af+mPCufMgTw6+atL2rPh+NXJwwhZgXd1Bg2mnXF2oBBbsCpOTdg77yBafPMZlV5pn
	 52gTL8ASarWwxMUCknMMA8PsOzA8JZ0z74Ui6eKhZK/45Yoh+6zy+ldbh9re0VO/+H
	 bjtpgpCqVftZQ==
Message-ID: <sashiko-outbox-221538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/34] perf cs-etm: Split base and packet decoder state
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-26-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-26-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:42:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Separate decoder struct into members that will be common with the
> timestamp decoder and members that are specific to the packet decoder.
> Then the timestamp decoder can use the shared base struct.
>=20
> No functional changes intended.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D26

