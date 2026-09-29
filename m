Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7541189F43
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648818; cv=none; b=BzECOxcLY8U3Gkayuh8Bpq9YfXkAGOmEQpbl7qms7AzDjaNWeQbmfwYYIFvCS5isn57RTkaSe5tQf31n09Rqhp5DOyBTo9ZUQ+XZwM7WZm9pBCX9GEeUhEJIXWau9Z+QKMv6hG9M/4f8kc6SZEQvZQsljPO+4gloVWnnqlyqE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648818; c=relaxed/simple;
	bh=EmoLLKBgSAh6GOfehlTb7NVK4VCymz1P6Oe/MfRVdUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aghVRm8FTnSSzAU6ia4L9tng8kX3B9fIN8hVxwp/NvIRfix+Y0EDVvjI8b+QNa6hI+2OkKUss1rt5+OdyRJsH780aaC6FCGv6suncIpPBxGac7hV2a0mOAqNgGibkkAG4bp6w7ShQmVbQbryTUmaunV9+Mh8BjgFjFtmNnli8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb25ejbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb25ejbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388411F000FF;
	Tue, 29 Sep 2026 02:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648817;
	bh=+b6l+Krk7K+HkgEZDJKTo2wBNZvwE5AKM7KFVHpObuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mb25ejbiKkcm9L1ZZOMewouPv2iA8A9DbjSs29nZodKt27QUnXR4N4jgiEBYU3EQc
	 Ik3eQVF8pPtMphQPapK9yu3rLaUJLiKLq9bHI1PpwON8gHs6fvxNKoqCbundjOLpqT
	 jwatANWWQSXUoV9+uCMKZkikQqG2vhRS22+KAaG4sCOrbUbSOllj9u0yl1qojeWldx
	 RluJOAbcyoJUcq7VMwgq8aE+vfJnVFdcE9JhuNFIoKCzpR8+b8s9yyf+yP8zAzffGr
	 jP3qZFxtYViIjlh4wSbCMkS0kqvwIJWYpMqoumkqYS4gQmwXpWyv26PGMdUpbJDiSU
	 Roq+F3sD9ZJgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/9] perf test: Reduce overhead and contention in
 Python shell tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-7-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:26:56 +0000
Message-Id: <20260929022657.388411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When all Python shell tests run concurrently during 'perf test' under
> heavy load:
> 1. Unfiltered 'perf list' initializes all hardware PMUs and metrics in
>    each test process; use 'perf list tracepoint' when checking for
>    tracepoint events.
> 2. Running 'perf record' without '-B -N --no-bpf-event' synthesizes BPF
>    events across the system and caches build-ids into ~/.debug; add
>    '-B -N --no-bpf-event' to all Python shell test recordings.
> 3. Drop '-a' in test_check_perf_trace_python.sh,
>    test_rw_by_file_python.sh, test_rw_by_pid_python.sh,
>    test_rwtop_python.sh, and test_syscall_counts_by_pid_python.sh where
>    only a single child workload ('dd' or 'sleep') is tested, avoiding
>    system-wide /proc synthesis and ringbuffer contention.
> 4. Add '-W 1' to 'ping -c 1' in test_net_dropmonitor_python.sh and
>    test_netdev_times_python.sh, and narrow 'compaction:*' to
>    'compaction:mm_compaction_begin,compaction:mm_compaction_end' in
>    test_compaction_times_python.sh.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D6

