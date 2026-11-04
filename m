Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762237;
	b=0DhxK1UjWAGf0XKEWNPuRYN83hDcioFeO9aryXqojd/qc5acdSqZ62glN93IvH/AqhRv
	 JxzAem1jBGN3irMjt/WnjyP31biQGHH4iZrks/VHCjUlCmWur1I1eLoBdm0RC8Xh/RNnY
	 cNmq3DdaBNqU5/Sgf7CqrSwTGdzWSEuUJBRBy0xD84We5ONg2b8ksqEyXq3++tFfI3liO
	 1Z533q7OCQ9dIYmZXSu5tyMJ+dl/JuMhB7rume8vRlf9GVVzRxhHs0mB4hPPAsHp4LEH9
	 0pUFYcIPoLsVIrRO7uC5zYO2/cjwh+/B31pih1ITvewUHUcX2xOlkr8UULfgDYmyDWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8P8/zys7o5ASa7h1+b8xPzod0mj3KkxZZ3ZtD5/d4Fc=;
	b=fqkV9uSM7fYKA2mHYlYMYmJuyxCN4AwFLm2+TVx7ubFUBOazv+2yOzZ8EDcOBODlUTY/
	 iB3c2CN+7zcNVsKswh5MOwqtk7ORY1KwwjguUIzw6MU5GNVEP56hS2xUiOMaIzWRDv1VC
	 jZw0FS/GqT5YSQP0d6LOOenqQNxQWcYblqjKswhqhYekWkqcfDg5UHC3MmWujk6z1bL/5
	 n0yNwIBkguvv2LXudIoQzlW4G7rWjFv6Eg2tiZucANliAzURH8rL1l923VGHjbXR0cFDG
	 UjQdB47bkkgl2/m7d/ouWgctgdASZnyRLoRB2dKr9LH2kp7frhJlhUPgTMpN2OWfzLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqwTaRtK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2150606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqwTaRtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F951F000C1;
	Wed,  4 Nov 2026 03:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762237;
	bh=8P8/zys7o5ASa7h1+b8xPzod0mj3KkxZZ3ZtD5/d4Fc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oqwTaRtKM/GMolwqJJJ5/ST3NT4eh7f1dwHFxdy0RG1DN1/B9Ia4KYP6Z/7x7lOGy
	 78p2jlqWmZqzZW7ioHaBsVpD6ZcQXgI049owSKcoHg0YW2eJJF5x7BdrmdmCq+Vhqi
	 o4fDB1mPk7cA0T+4UDIQuPP3Yz9uoZU0zy/c767Vb3+z4Igxj0lgxRjIv02IuBjCkq
	 enY93MMronLAyuEybTLv1ofvGKOj8ooV5JfGsjG5fCrMZd0Sc7ixRatomqB8cWxVa+
	 8vbBgyxa6HO3QBf6YUshppqPobBDF2U/MXn2nY8EAx4IWYMgkEEAUVSeKVGukbdRvk
	 0CCNfikLa3Kbw==
Message-ID: <sashiko-outbox-196593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/41] perf evsel: Generalize metric_id to a set of
 metric_ids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-18-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:17:16 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D17

