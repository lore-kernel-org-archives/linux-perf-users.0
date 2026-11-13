Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601875;
	b=1Vn7rGeRoUQHZd0DF171BCJGQLtaFyeICfd3KhqNhB0KjFx5N/w8aycH1K7zU8NP/nZ+
	 85+mR61k5PPMFg6jy9BfT9eBLIybTEJmLnyUtgbdPXSh7nn0+MhCOd6uk/FNLzVqYWtXs
	 1n0y6cpbjUBQAqkp7Xr38dE19DvYYpDEHzH05WvNce1FvYR2S+e0OmVzVSMduJ98XX0TL
	 Pd3+t0obHSIy2b2gfy/qq7BKvG59UbiO/zEGLmpTaYejvBsgqDnEs4BOWrjk41MlQgaw9
	 b20qjCpj21ZSep4wL13qQmK9CoIb3crX0fbwJIfXDUeV0iteiNAbehz1SQzjUrmomFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MjVY1iX3pSnuqh39AJjkK9tt+BsF+GFJy6DzGaIo48U=;
	b=dAl0n1cAfeAexvw7Y0prancPd8a+dI1qpWbYs54whAi1q/uncc78/QZiDmTKqzwse0MJ
	 GQGbd2Xq6ePvnYS7S1BjviNwLAIKas6bK/UdwPXkqmRd3frxWNFFk4yOQENy5CfZIv8Ex
	 04sI8JELClePA123mIVds/pmlmtKRjBCRbtQAfFa82Mk2kbH7/QqrQsCEnTslWuQjN+47
	 xMIxqqZsGuC+roZedDpztB0zCBUfPIKakr3A1bbP8Rhp5hd4g+VyBHguof945DXDzZiaB
	 v8drCz7LClSDYRGHAzG2ldZ/1maRMhX9YyLeByqw/bTveScQsQZuQ67hp2iR9Vhie3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb6LGICx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1509606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb6LGICx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4768E1F000C4;
	Fri, 13 Nov 2026 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601875;
	bh=MjVY1iX3pSnuqh39AJjkK9tt+BsF+GFJy6DzGaIo48U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pb6LGICxl4PXjySaTMY/fM8lupYePmbRg52uW90pNp/+wKlNWECjC9cn7G+DtxAU/
	 xeJXO855YvpfpFYz1O+K8heK/GCVVyb3aFXTiitU476eWhpJzGnY8QKI3KHZdw3/Eb
	 PjrW7MM1zITW/Bz+gBiQSqfv/i34D08ghkiAbgIrdfZr8pt+4xTl4FCxXJIyLil9hn
	 /M2UmFYqlFZukxLmMj+BzB56lhvDeWMKqXUOhBwJrPw1P3gfQCIxrn2hEJ9SaefbrI
	 2JNIa2Hz+uMX6dqDKVx/T0XeHoke0qAMukKM0OaSTt0l3BrCSHcNDqPxgVmd6FnNEQ
	 h4R1o/Q6kKKvQ==
Message-ID: <sashiko-outbox-213645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/30] perf evsel: Generalize metric_id to a set of
 metric_ids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-22-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:31:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When computing a metric the value of each of its events is added to the
> expression context using the event's metric_id. When metrics are matched
> to events read from a perf.data file, different metrics may refer to the
> same recorded event by different names, for example "instructions" and
> "cpu_core@INST_RETIRED.ANY@", but an evsel previously stored only a
> single metric_id.
>=20
> Replace evsel::metric_id with a NULL-terminated evsel::metric_ids set of
> unique identifier strings. Keep the representation private to evsel.c
> behind helpers: evsel__add_metric_id(), evsel__copy_metric_ids(),
> evsel__has_metric_id(), evsel__shares_metric_id() and
> evsel__for_each_metric_id(), a callback based iterator. Use the iterator
> in prepare_metric() to populate the expression parse context with all
> metric_ids of each metric event. The metric_ids are freed by
> evsel__exit(), so make the __add_event() error path use evsel__put()
> rather than freeing the evsel's strings itself.
>=20
> Remove evsel__metric_id() as returning a single identifier from the set
> is error prone. Its uses either iterate over the set, test membership,
> or, when finding duplicate events for a metric leader, test whether two
> evsels share an identifier. Tool events without an explicit metric-id
> keep their tool event name as an implicit identifier, other events
> without a metric-id no longer have the identifier "unknown".
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D21

