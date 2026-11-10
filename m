Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349571;
	b=pi8njbOWgwmrIHClQUqFYuVY+NtsUp8M2hwSlcnkuAHS3bqZAfuEHb4/ObeNcqmk+arF
	 MwT8L6JiRdgi9BHSwsvIUM/hm/2e+Ef8CnQfBctLsBaBTI9k6ldJhAzbWs/41NwDX9AUx
	 qfITE9X9XwYywB4MPTClIGaUG1qEDCt2L0jROKi0lewWRmGXvZJ+XDRt5ZvJmRLrru2tU
	 ahEzIe1HO1whybNECYwpDufshGu/hLpod8WFXArndFhYwig8OONVIACWvbmBodVti4B5M
	 kFKVfUHnVO3RjppTUrvdi0OfbVF6jBEJ6Hbz/AjYWm41cIA4175UTL5TXDBUNqFevaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MxbJ4BZ3M7+XnuL0IL2PWbiXALFiygx81KtAFlqeNjs=;
	b=D+rwK6D6UXOX2QaTLbujjIR/Rv1JSnYYUtnAYQ4pz2llgU9UEsaBgGWtEWDU/YJPZvZg
	 D4gQEf9qswofpztidZyPOCC7/bvjM3RQqERlXQuDDughuDf8KGh3EB8ZgRl4wGESIoT4V
	 NVhtyd+AkqmQfvHlKJIMzd0shWJDE52iZnN00cFZEBeToyLm+gWknoQzBbxa6+9GiwiVK
	 34EeyDCVzjiLqPLKDZ4SxSHfi2NLR2agh/Z2xKB2GFDsB9RaLVryMsEXlX/rG5Rfn0Usr
	 B+fem3MX+he542miHWzTthM0sScokIeC/f6l410vKJB9omyfFi05CI5Fu19qfX92ONg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxPjfBO+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF64606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxPjfBO+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD01F008A2;
	Tue, 10 Nov 2026 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349570;
	bh=MxbJ4BZ3M7+XnuL0IL2PWbiXALFiygx81KtAFlqeNjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HxPjfBO+8wCL+0w0Y6OQLj3Q1g+LPzB/ArDbmhFfpw1lQTEqpS+0e/TsilQurNpH8
	 auPj+D71B9IqwulMpWZOhk9Q8jGdhTRlUBfo3cPxRFkoPrA+2rRrAKoXPhn8EivhZ2
	 eTKxBV0N+RQTqdqh3+WS2VTn5FOMen/Mo3WyTdE5/rCcXZatjrDaKD+PLFn6eAUETN
	 wHT/K9QXzEAA2ImwQiPAP/UZEHk3QzTgN9T74nTfU0iY4efij8T4rilQ8aGmiZIjB6
	 wa5sPlKfOj65V1kDJa+ABiHXkjOLYobJRLIe2tCCg1gNrqRzVqntM7pZDJ3+CcY+HH
	 crVCdWnZ0JBmg==
Message-ID: <sashiko-outbox-207827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/20] perf annotate: Move struct annotation to a
 hashmap and remove symbol_conf.priv_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-9-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:26:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, enabling annotation added sizeof(struct annotation) to
> symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
> even though only a small fraction of symbols are ever annotated.
>=20
> Move struct annotation storage to an on-demand hashmap in
> util/annotate.c keyed by struct symbol pointer, guarded by
> annotations_lock and tracked via a new SYMBOL_FLAG_ANNOTATED flag in
> sym->flags so unannotated symbols pay zero lookup or teardown overhead.
> If allocation fails in symbol__annotation(), return a static
> empty_annotation fallback so callers that do not check for NULL remain
> safe while mutating callers check for &empty_annotation.
>=20
> With annotation, TUI map browser indices, and db-export symbol IDs no
> longer using negative-offset space ahead of struct symbol, remove
> symbol_conf.priv_size and symbol__priv().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D8

