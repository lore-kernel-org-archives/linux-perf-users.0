Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E02D0C8F
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302062; cv=none; b=a+av0iM96KuH1TaWRJ7SD+eE+OhAsjJEa2wYXoNGO01TYEsnJD0sIp22D0wCPUT9ySbJzVP8AZCBQXjpOQORch4KwAADOqtoLH+vlT4uVpM1JidO90AjRUQM/+xSz/1UNTKd61DAGDcH9NmNlR1Ox7cWgedCt6XCsfIkLbX7kuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302062; c=relaxed/simple;
	bh=/LCrDfhKgPXPf3/4FMjwFmTMXNTyVeR0UuJHNxzWQo8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Bvo+u46GEmrXrq3jOuBG41C9Y5Td1NdIVyP5FH0R5lKmdnxnrnlvvf/pvC+Hxsa7Lg2E2XOsLy9dmvNDC9uuG/Lfd0Xwe8dH/9vFmSdH8Dncr9CfHRkbDj7X5Yq1WdagfsovrXvjqCa3silIpu7HERh8DaXDc7yisMiD1CKNM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlepXn7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlepXn7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9371F000C4;
	Sun, 18 Oct 2026 05:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792302061;
	bh=IRrPaELDGoU2/VK4SQhhlceIh4eBY0MnEX1aUADTT2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlepXn7pUocPJct0EmxYg2BRdlsXdue9AntUBX6/rmtFz9/EyioNM9tTRQ6Wmkvz9
	 r441Ik4KDFt7vUKocjcLCR5opZi8o3zo4HKKgWytLi5IoEEOWFKrIwnitEtcujSgcn
	 pIv+72E8szCS1j4HDHp+jxVMskzsyvb5QQMuH+KtnblazGpeVUdLpkoC9VYagC7vpI
	 KtTVL31RwGWztO5voSE146XQtMfWHpkSjExYJ47MMT8/Jck8xyIAwWWlOGjYDyECa1
	 7N5eBppeDd9sTKfVlmLlyN6SsuedTLv2IAkILdBoy5d6cnR48q34kJkxS+nbLmGkli
	 hsUTE6zNYf+tA==
Message-ID: <sashiko-outbox-175949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] perf test: Add tests for lock_held() BPF sample
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018053710.2572636-4-irogers@google.com>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
 <20261018053710.2572636-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 05:41:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add unit tests in parse-events.c for parsing lock_held(),
> lock_held_read(), and lock_held_exclusive() BPF filter expressions
> (standalone predicates, negated predicates, and compound group
> expressions) and extend record_bpf_filter.sh with lock_held(),
> lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.
>=20
> Example output:
>=20
>   # perf test -v 'Parsing of BPF sample filters'
>     5: Parse event definition strings               :
>     5.7: Parsing of BPF sample filters              : Ok
>=20
>   # perf test -v 'perf record sample filtering (by BPF) tests'
>   112: perf record sample filtering (by BPF) tests  :
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Group bpf-filter test [Success]
>   Multiple bpf-filter test
>   Multiple bpf-filter test [Success]
>   Cgroup bpf-filter test
>   Cgroup bpf-filter test [Success]
>   Lock-held bpf-filter test
>   Lock-held bpf-filter test [Success]
>   112: perf record sample filtering (by BPF) tests  : Ok
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018053710.2572=
636-1-irogers@google.com?part=3D3

