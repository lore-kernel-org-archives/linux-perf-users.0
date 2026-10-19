Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447952;
	b=3hNN3ypa8o/v55oNsYRL/4TN1QcCmtpFWfW7h9ngCpjyhhlmoRRwEV4e0xAF7K3amQzA
	 Klp2ubzRcNsuewUYyythcr/PvEJYRCnm9eC1mba/OPcSivIPO9uzZ/ghF/yz3GWYnCCA4
	 ynynFFUMzifOWqzu7z1w2p6S2AGtRv4yD67SoudZ3LQuZ1BKlM8sFV8eonHxwRQOb1HW/
	 F8pdChdivuGseP6UwtrU/JQzeZGIwJuFMw30gJ1wXQWL+NLmJ9cCrl8fwPvTzTaOdFVRa
	 lFaARf/DmA9YaV3Ix5zB++hFQfde8hCQRDZpQZtUsB727J37cuVYfO+E40sPWIgTfBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447952;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kjJMjDd5e3o28jkCqGAoLpcPzEEeXNhZp932avRhjFQ=;
	b=X3SzMtstBa8uRde8t0kpElw23FlE+L09t4MJxajF+9rDGcWNXcxEnpIWrcKG5ipDi+Z3
	 5ILHa2d1RqYHWCoE0MaM6yU/yf2qgoZ0oMGRpYeWBLEUHw50OFUGdCfnn52MSSw/TaUgc
	 A8J934OV7USixU62TdGuV/2wkwT7wjCRBRUAe69Q7YsG07jjZPG+ZbF4fncI+u6c2fXaS
	 djpMTYTUL2Q0Utgq3nusEYIpZg3HNlqe69XLxPyr4rMiFVH51MkFt6YKroJgbfMsgUqdF
	 3ZNxUH75sC6/lZaTqmaPEH+rosAiZc2k4ODpbDKlQjintVE9QjItMLNwUyOCP1mYuVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqL8jgVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70395606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqL8jgVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D21F000C4;
	Mon, 19 Oct 2026 22:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792447952;
	bh=kjJMjDd5e3o28jkCqGAoLpcPzEEeXNhZp932avRhjFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QqL8jgVEYhyalD3yEzo8sYmaSufczSl/P5mjCpkmDMVtcYGUEC3trusF3u4Z75Zlb
	 feaT7ypkyNmVxwZ/I0Fv0xOGGvelL5BkWqrh3lbrk2r2s7zABdUcsNtx0ontJyINQ9
	 porkSYDw6PBd4Te0un/o85L/ntvfNt9qALvQinEFemL3ExZOy/uLCjFiOkQnB4bweX
	 nsk7PQ5VG1KFyhQMG0JYdMTBgYydSijOWZvp8JVHSeb1qTFuUHWk/QYtsJfYnsCWip
	 CMk0I/qQNpuUvgKjxJAO8UjGB80I44hHAM0ssatPQXtvuWB4BV0NFSGx5cskgdm2AQ
	 GyhRNmKeBYq5A==
Message-ID: <sashiko-outbox-178298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] perf test: Add tests for lock_held() BPF sample
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-6-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:12:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D5

