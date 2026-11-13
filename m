Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607069;
	b=cUSIuR/FKZscS0bkN6GcvrzFsGeBGNwUqJ3oBnhgxV6oHEcBwYkqzCHb6RioN2dvZ3ok
	 qXmotvd0e9nOPzNaAAY2SGQ8Cyn2kSznRaP25bE8mFktZz+e0k5WhcPwkRnj+IWBcT6Dk
	 Ik0PMC4JOy7/1IyYPEFNoKraipUX+5VdszsXelAIDs2qWrvC94W2k5XPoddKuBklBwtjL
	 hyryxb+fzEWHUKbqmmfsFtnl3ELuPPPy5vAgDwEejqFH+I+2IhmaRLKWzFDQBEhR4XDgR
	 ikjaOzxUB4g/Vw2OKlmxKFMVoVjPlAUq5o3bDjU5VbKRNfnt/FsBDQaBOPNoos8xmqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607069;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XN+XB+5j3SskkRp757xvkDGu+I/Zxku64c896OJFAPI=;
	b=GRjMD+eupaHS+X2uog0zBC5F9qRiYhd5FQ42G/BrDo/YlXpGPhFqms/AVKHoh84+o3wo
	 8zuKihocfkcKuMsAC8jFv+jynSBi+bYfUQ5BIAG0K/cCxgCys1i/jvhvdmd90iWGKCGG0
	 1olNcgzickozj7Ift1HoBfMThdDe8ZPYe3ARGiC38zA93Skgo6gca9hoc7ekGv0mP8Mbn
	 36keziVRzJK843nEzfQ4hz07jbkue2hcvJi6bRsBgHEptFZf3zMJJSGdHHA0rUOPzwTmn
	 gdbfWRil9WPXXlRXjIGl+54RyRcwADTi2I+LQHHGAjBcuOe1rcAyyyY7CDcpqdhELzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV93t7Je;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E2606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV93t7Je
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7411F000C4;
	Fri, 13 Nov 2026 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607068;
	bh=XN+XB+5j3SskkRp757xvkDGu+I/Zxku64c896OJFAPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XV93t7JedMjGgQ8M5vLSrfugykEerYTtGHjeNgmEhQpsrjJb5bNIADuOAXZbbVcOB
	 Z4m+wV6ko4llgZ6X0JAXtepMo3va2YIlXW4GFyI+ag+mOjPSC123y1W09yYQlg9iVN
	 0CUaxQseL795TcxatpE1HhJJfVJjyPOU3rK4l99/0IrfsKFE4rFTuvT/tOM82R/ySG
	 sEQKiR4FrvIXI99XAWDpudaLsCtR0+wAihJHGPoHyHTx57aDHfoY2JyL6N31N88a7y
	 r+HsvrVDTLmLeG9ONrB3PwxGdc0yQ9gd3lWoeR0u1MuHmfLrOJikH5Q9BwrmkKtg3+
	 jHCoKvVUkIMGg==
Message-ID: <sashiko-outbox-213753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/26] perf stat: Use generic hashmap for
 per_pkg_mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-15-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:57:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf stat: static variable corruption in
  process_counter_values() [1]
--

commit d021f4a2698725b4414de863610e7d415a7caa42
Author: Ian Rogers <irogers@google.com>

perf stat: Use generic hashmap for per_pkg_mask

This commit converts evsel::per_pkg_mask to use the typed hashmap wrapper
DECLARE_HASHMAP(per_pkg_mask_map, uint64_t *, bool) and updates its
allocation, iteration, and cleanup callers.

> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 097985da3dbb8..c502f4928f9d2 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c

[ ... ]

> @@ -364,7 +364,7 @@ static int check_per_pkg(struct evsel *counter, struc=
t perf_counts_values *vals,
>  		*skip =3D true;
>  		free(key);
>  	} else {
> -		ret =3D hashmap__add(mask, key, 1);
> +		ret =3D hashmap__add(mask, key, true);
>  		if (ret)
>  			free(key);
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can setting *skip =3D true
here cause evsel__compute_deltas() to corrupt the static zero struct in
process_counter_values() [1]?

When check_per_pkg() sets skip, process_counter_values() points count at a
local static struct perf_counts_values zero and passes it to
evsel__compute_deltas():

tools/perf/util/stat.c:process_counter_values() {
	static struct perf_counts_values zero;
	bool skip =3D false;

	if (check_per_pkg(evsel, count, cpu_map_idx, &skip)) {
		pr_err("failed to read per-pkg counter\n");
		return -1;
	}

	if (skip)
		count =3D &zero;

	if (!evsel->snapshot)
		evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
    ...
}

evsel__compute_deltas() subtracts the previous interval's raw counts from
*count in place:

tools/perf/util/evsel.c:evsel__compute_deltas() {
    ...
	tmp =3D *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
	*perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) =3D *count;

	count->val =3D count->val - tmp.val;
	count->ena =3D count->ena - tmp.ena;
	count->run =3D count->run - tmp.run;
}

If a CPU had non-zero counts in a previous interval and is later skipped,
subtracting tmp from count underflows the static zero struct in place.
Every subsequent skipped CPU then reuses the corrupted static struct,
producing bogus aggregated counter values for the rest of the perf stat run.

[1] https://sashiko.dev/#/bug/linux-d1692581-98d0-4148-a6ee-49bd64e01cec

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D14
