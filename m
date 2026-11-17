Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884544;
	b=k7zzeARVLvJBw+na7XFOzSQ06X99d8y5u8Yt8BxOO58m1h/6WrgTHfmFAqWXOezV8bS2
	 1tpD34lms7Z36zmqm7p5gJiw7beHCHvaHF5O6hT2/8cl3dVGPFdWnMBcE/adNph0zxQR4
	 /YLzMlJev+p4yNbICoMmcrZDx+BldsKk2UYqjE48FbAPGGNIelIMwz05gid7773Pg6GHV
	 rdxX/iR+tax5vzli297dAOvtLzI7m8mXOtwfo4KJP0hq72Jm0E0Vjup495bs7RBt8UfC9
	 5S8rb81bkJZmj7qBRHx9RABrvRP4HZ6dSt3ciEIgenWj6nBbycVfVyQau7SSFvirK0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hOg/JxkMVSRQN9XbJZ5sncJZJkFWQSksvWIv6908ywY=;
	b=CfR0/u/4+AndNWoC3w2PnUhvDZDtaN864/GcP3DBHYptBN3QhIjrOGsx02ERZU3fPQwW
	 C8t9noHcs098FXSg0YvoQHxz+9AixiStXkWhnF+x/vZdyvGhcZ4PefcQ+8dmib1tn5YAk
	 eVNK+wWgqLG2ohoX2royDow3gvLf9n2Zv3KfmAjT63AS28AB7/UVHSSpsgzRrRlZgUBZ7
	 A/5taoNUZw2vW9Xtau5dYlI4d7+MX0MVCrPLIM3h+gZ0gePxbpSlXzKjIUZAc7+dbSsKd
	 y7DNqsRSc8Ss1FvzGEBytmN/csXUJKswEzI7esEVZnGtPr6quAf/G426qRqplDvMazQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtZkOHnZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C1606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtZkOHnZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55A1F000C4;
	Tue, 17 Nov 2026 03:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884544;
	bh=hOg/JxkMVSRQN9XbJZ5sncJZJkFWQSksvWIv6908ywY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GtZkOHnZ8aqJpx6vX/8KjSok+MbWtN5uN0qNlJnVFVMIWoCdboeaDY87RfZ0mPnQ0
	 8EQZnwmyQuwDAfLMxJgBHslZphqT4EQpkh02mxxNi9rg/Xsu0TLx4AOpuOnqB1GgXa
	 Q0zXnqf65V/5uaWas6YehgsMKZoU+LbnC3O/4KY2FkqnPoJ/x0O8UDYr5UO5Mn7yJw
	 7UfyZW3s2SnXkVlP8b3JDydsp9VDBDhg7E+FAPSjGvTvMSY3FHWx1cKdBxXyRMXP7n
	 i7hOEhyYhoitQfZZMLtsy7IBuav3Y9AixSjomXcKydCOoBq6S7AkjhgTNru+4MX3cH
	 5r/oz6F53damQ==
Message-ID: <sashiko-outbox-218112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/12] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-12-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:02:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>=20
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D11

