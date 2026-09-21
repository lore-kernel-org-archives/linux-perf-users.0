Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B035AC3E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969180; cv=none; b=USesq2T7d6bPdKd+GA8lMhbELdOgw+ToDLlL4swZRsw+8yMMPqAGy9wypevAg21QiaPxPAOdbnO0x9lfaVYxvuhU1U2ZTQiNiUWglnPh0G/p3izEBf0uPm/7ezH+p6jFObiP/WlvfzcfUE/c6xdCat/LP7pROiyjHMo0ib/ZHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969180; c=relaxed/simple;
	bh=EqEi7vGWYdKjJrfvEUvt6ckYHsZtTKyHg2n5RS1cOqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=puZXyUFZf9f3esQhKdJMUPd2F4O2WN21PIG3RjfKgzHvVIWU/4KyTtQeMTIgkom2UrDANPI5To7U951ztJjCs4tLHwG74ZGcDmb1UCdDM+oeJxK+Mk7hsLVDzRAK8KnJm5CiWEtLeV8BBIFiq4mI67fgOql7ieuaHBwXa9zESf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaH/88C+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaH/88C+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C781F000FF;
	Mon, 21 Sep 2026 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969179;
	bh=l6vE7/P8tbNJdEtdLhOY0gwuujQkb6FoJBby/lK/AKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BaH/88C+RkZA59gr7INyo5PDwrjX0FjphtwoAVyI7M7slFmtlwUWjkTPXm7TuUTGQ
	 DYLuUKgYqygyxt8/cGy7R6jzQ5yWjKPT/5tozj/oRQbieT32OGpLcTeeKpNl3PCT1l
	 v5FV51sN1CT0tuAYGzcdGWD+fRJJGm7vXjn25EPWRepRvnPL4S/zA/3pK9o5NtGXHj
	 bMM+q6W/C03huVf28EsVRZeehk+wWiuUx7FQasgdX3eMgFe5+/jnFkBmUzvfWplq4c
	 BiQy/6VFiGqZ+QwileGEAeI1EX7+AtMaPc2ZlnG3F73ox206f8L4tsEJIkzUl1BUvr
	 Tdf0IuELyRpOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 33/49] perf python: Port wakeup-latency from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <59486d9f5b83ad06a154ed3cb164d36106009df7.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <59486d9f5b83ad06a154ed3cb164d36106009df7.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:39:39 +0000
Message-Id: <20260921053939.70C781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script wakeup-latency.pl with a standalone
> Python script in tools/perf/python/wakeup-latency.py using the perf
> Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Guard print_totals() when total_wakeups =3D=3D 0 (printing 'N/A' instead
>   of dividing by zero when a trace contains no matched wakeup/switch
>   pairs).
> - Add argparse CLI options (-i/--input) and full type annotations.
>=20
> Add a shell test
> (test_wakeup_latency_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D33

