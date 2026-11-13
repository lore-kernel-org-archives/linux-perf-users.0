Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607295;
	b=pjrDqN4hrAB2+FvIw+lZZsGqqQu4QLfZsZZc7RgUB7097wtAXqh13u8BHeWFUmk9He/x
	 0wGeZb6ZIJtYTKB6tkn5kj/DvPSldX832S7MrpafxyFxSSoinFfdCKqzCJm/tBYckk1rO
	 NbJMXAMQ3u3BD8ar6B4CLjdhJLr7seDo85TG1JhVBHUB9fldxMRDv2bYmSO8VziYb4WfQ
	 PnT2a9bNyTLHboNGHOBg6PQlGUTMYOY22HdRtgzvcA7dNaWuP9h5kg/rQhEkHEnvOCd8E
	 oZBEJ4eClpFulpmNrvskLLAN1YRdi/Tkn7kkFXx/0+OWmy9gv+UIj7Wrn56l3BVYXmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tZJmFt/y74kPM3Mv8g7Q2Z79te30DzCPpnNrqfyJVc0=;
	b=LrOf0VcR+ck5NNtMIoyYY2R/29cX2H/h9n2OHZsjrg5qYctbsq6kDAowNlE7KL+Y8hUf
	 HtYgP7hXAv1VjCOR4Xbek7yNkg6OgoXH3uxMsWz1s+AHMgyFlhsHB4+7xkSemL3H89fax
	 vHXFZ82Pl8R6l76ONnw6rf+rNE01njh9R/0f/QwKF/lievTGmWJhK+Vx9JYSuEzESfEvV
	 2zRDEZfytZsPrVFwHfZh8rOcX5589Pu1zUlgRB0JjEj5xdNZZqUq9Rh3ANGf9e3ubSa2o
	 APsDBR8hN6YBp+NJo7muFvLmOYe5aFMPtqJ2aa5cGazmkpwELQ/gceFeUxX3w0qNGfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBkkzFC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53447606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBkkzFC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74161F000C4;
	Fri, 13 Nov 2026 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607294;
	bh=tZJmFt/y74kPM3Mv8g7Q2Z79te30DzCPpnNrqfyJVc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBkkzFC6EK7eBkdLz1DkariasXlhWUBF5k+R0k9xzZTkuJ5BBovXEhaB9XkdyldXF
	 HYcQhQCsNGX5mzI/CxK8Cp8azIGrgmVmMloSaWND6I4Ec7ZWK55WuXC2iBJDTZenkF
	 4lRfzXVYOSeWdAih9TzZsxU/+veGbh+YoAd1RS8SVSFYTYqRacNkE4VhbQP2gdwc20
	 aE79R+n64sjguU43fzLYghRoPqFddQjOV+dSD1haX1/TYGagst9avFrxAh1xo9o162
	 MzgeATfiiwAYMdsM+R04fnJP3Wjoqu8+R1+lEiD5Pdxdnxny1PKADUAfR8YaUiUems
	 O+8CrpNO+iZRw==
Message-ID: <sashiko-outbox-213766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 19/26] perf threads: Use generic hashmap for thread
 shards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-20-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:01:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert threads_table_entry::shard in util/threads.{c,h} to
> DECLARE_HASHMAP(threads_map, pid_t, struct thread *) and replace
> hashmap__for_each_entry{,_safe}() loops with hashmap__for_each{,_safe}().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D19

