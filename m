Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787366;
	b=RTX/xB8QowM1b9BGRE+rqYER9495hlvgQZRsyFTduhKopAR6fQ5K6dhS+ukePW5xSqnc
	 zwqzzGpvLUD9YcXew+fHsPGvdrMh+jXwNYPm2tzZ0G1SgEafhW2gBMFuF6KYbrjs52mg4
	 FyTkx1jnfze8O7ocKdQn0+HHAf4TqR+HdeRrhNfKqZST257AOubbNerTpBoJkmq7YoDSb
	 9iRUmQV8ogbWAvgHvFYWk5QGrVi82LxcQdLLOBg9Hpm9yYqD2Jg4ihOh4JLNLPpQJkypz
	 vsPkRVeEspVgwPs6DFw0QEuF/okfDY2Zg/XS8cy8Ohf6/8BrUfF8Zujt40A03DaRjxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aUote8vutm9I3ZuMfjnRXhB/J81Yq4Abaw4PTXD4we8=;
	b=K2njOVx2hNNNmLAU+/KVS8BmKP7dr6ItXQtOmqzpKn3TpTPLn/1GUpIZQ2LdHZr6/Dto
	 BTS/D+9d3R52bkaMJeJuCi4lwgP4pW7RTT78AXtzXoWYIpmd04xZeHktRZSlq+QeKQzNL
	 jDA3UGV2ND1ZVl+51XCebsgOdJCrz5Q8121E/Lld7+jfo5go8x4M02R3sy+b3ACWV+sNO
	 1jwHP/HBNBC8UwWAIou4sjkAfAx/TwnUjFQMFAN7ByFWu6X6tiJBa6RKohxBZiWdyGZ0y
	 q71lnQwBqnsRGDHauER4DYpJxhYQPBcPpn16Tq3LSh8Oqjhdkb50iWIpco+xq6PAgGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6mzbsvY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F135606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6mzbsvY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7C81F000C1;
	Wed,  4 Nov 2026 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793787365;
	bh=aUote8vutm9I3ZuMfjnRXhB/J81Yq4Abaw4PTXD4we8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6mzbsvYw1zgXaSC7lGQylmQOAYnHwplgi4DQgud1RS8i46ddCtyz1LJW0A5HzHz+
	 czBBbkyw2UANKm/oedMto7n5Rq5VYWmZgFrqqMbRvLcJ2hZ+kuNLRkUAJhrvGEdpSV
	 8Oqw+ed/UtCjp3lYq7koHEsTedrYkrnxF0zIIUpzfXy8oOl8eHSK7K4m88mc8MrwCk
	 kacgOv9dC0AzwbAN3ZTZvyKbP2zmlUN/no8dP/f5WZje1iZsYjBtqBwYe2wuE2+XPF
	 QbpscqSrcq6l3jLNn53XUhpQdiHWCMmTxqy8lTxK44WVU07HNbu8L7nIClyPHchX2j
	 B/DURfy2K9YdA==
Message-ID: <sashiko-outbox-197072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf: do not call list_for_each_entry_safe() on
 uninitalized list
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104100802.539266-2-jirislaby@kernel.org>
References: <20261104100802.539266-1-jirislaby@kernel.org>
 <20261104100802.539266-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:16:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf tests: uninitialized err list in test__pmu_config_helpers()
--

commit 779f6d6b7e775ad26417497420edb0cda7bafa6c
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

perf: do not call list_for_each_entry_safe() on uninitalized list

This commit adds an err_out_pmu cleanup label in test__pmu_config_helpers()
so that an early evlist__new() allocation failure skips calling
parse_events_terms__exit(&terms) before parse_events_terms__init(&terms) has
run.

> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 13e8d7fa80af2..be984e1385df2 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -223,7 +223,7 @@ static int test__pmu_config_helpers(struct test_suite=
 *test __maybe_unused,
>  	evlist =3D evlist__new();
>  	if (evlist =3D=3D NULL) {
>  		pr_err("Failed allocation");
> -		goto err_out;
> +		goto err_out_pmu;
>  	}
> =20
>  	parse_events_terms__init(&terms);
> @@ -295,6 +295,7 @@ static int test__pmu_config_helpers(struct test_suite=
 *test __maybe_unused,
>  err_out:
>  	parse_events_terms__exit(&terms);
>  	evlist__put(evlist);
> +err_out_pmu:
>  	test_pmu_put(dir, pmu);
>  	return ret;
>  }

[Severity: Medium]
Should test__pmu_config_helpers() in tools/perf/tests/pmu.c be initializing
and cleaning up err instead of terms?

Looking at test__pmu_config_helpers(), both terms and config_terms appear to
be unused remnants, whereas err is passed to parse_events(),
parse_events_error__print(), and parse_events_error__contains() without
parse_events_error__init(&err) or parse_events_error__exit(&err) ever being
called:

	struct parse_events_terms terms;
	struct parse_events_error err;
	LIST_HEAD(config_terms);
	...
	parse_events_terms__init(&terms);
	ret =3D parse_events(evlist, event, &err);
	if (ret) {
		pr_debug("failed to parse event '%s', err %d\n", event, ret);
		parse_events_error__print(&err, event);
		if (parse_events_error__contains(&err, "can't access trace events"))
			ret =3D TEST_SKIP;
		goto err_out;
	}
	...
err_out:
	parse_events_terms__exit(&terms);
	evlist__put(evlist);

When parse_events() fails and records an error via
parse_events_error__handle(), list_add(&entry->list, &err->list) and the
subsequent list_for_each_entry() walks in parse_events_error__print() and
parse_events_error__contains() will dereference the uninitialized err.list
pointers on the stack, and any allocated parse_events_error_entry objects
will be leaked.

Instead of keeping the unused terms variable, should terms and config_terms
be removed and parse_events_terms__init(&terms) /
parse_events_terms__exit(&terms) be replaced with
parse_events_error__init(&err) and parse_events_error__exit(&err)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104100802.5392=
66-1-jirislaby@kernel.org?part=3D2
