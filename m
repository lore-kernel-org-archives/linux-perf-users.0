Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537373;
	b=48PkWYnvCn5ZjHPedc20aS5wgQ0xLFS1vVfgnudCy7+mlXfHJEvhT1HsQel+y8Tu3/qq
	 Ovo956BO3is7KJ2cFm96Jzt+c8De5SAtfRFrs4Jwe6VwFqXMRzzBVjQ6/gPgBuTluXJn2
	 r99zL4DwfaqHWS2dwhOjCghiIICrlBYHQKY8wHee1T56XrO2xl5ZE+YPFSCp+qSTiiVMv
	 UGjPg8M4wpMFS/8YQnECc4V0MIDmlc4x8PLP1Enc50Xby4m4ePOu/CT4Dgm49szHjxELn
	 3kQK/6ZqzYAJMnyIT7+/0fq4I6cuogdT+nZVzvedEQqtlbemu+9L9X6TCrHgUHDkrCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FCGpcbxbtcZCLI7o8NPl3sCZLT6XVPDUsfAfmaOz9O8=;
	b=D79wk3LtgnhCY+P9JzDOQG+MFK9LsNAgm+d3N02e/gdY8+eUPwvL+tBCtr7XJSd7/zSJ
	 bPpR1ZySMLj+PoyYh0wSFFPCQ5imKxV4nXSmySjWrdg4Ra1vXp/hCb9sCc2kdoDF6gD0i
	 q2/a4RRNkC3wAvWTUG57o/3UfOquA7dHJwREpMGAgz6NDtaoWyjucPY5lTvcJJTHJub8J
	 EglCx4Y5sSw1mZn1qjIBFqerJBmpWOgt5nIT37HbzsylNKc37anu0gGYQfDE9Ppf4dltB
	 p5NJSGd+M/a8v7P0441JMQ4jjoxEdZROK4Ht+iO7mkDPF47CBPSvZ14M5Ymob3qCxgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha3focwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25388606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha3focwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8781F000C9;
	Tue, 20 Oct 2026 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792537372;
	bh=FCGpcbxbtcZCLI7o8NPl3sCZLT6XVPDUsfAfmaOz9O8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ha3focwQmdZ0MT9KPWdouMRg3JzSsLwQ+G186/BEu9yqhVCxwuf2qs7ITxUXQyKB5
	 6tjhj6vNJjlptsfupj3Xwo60y7ch+ro3S83NbLpgrKuWluLf3fEeGK7fzna1V60gJc
	 aDXfvDxvBPyQU7ocRzAE0+eLKpVDOp59VWV2ib9a4kdFyknuQ22i/oEBYzFpAP+gxN
	 HK6XPFyHOzG4XXWZf0gJRGXT3Pk5uBWBkRRlf2lWE2pqDKP4YPQSrdg8Py9Vp1BFTR
	 xh31i5DwVwJcPmKbZL/TJQEq70AOVMZwbn8JzkXq9t9dtn1aJ8j1yyWwBIv6fvzp1y
	 BdxSOytFUhAOg==
Message-ID: <sashiko-outbox-179590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] perf lock contention: Share common BPF and lock
 type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-5-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:02:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
> (get_lock_owner, get_current_mmap_lock, get_current_siglock,
> get_lock_addr, check_lock_type, do_collect_zone_lock,
> do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
> tools/perf/util/bpf_skel/lock_data.h so they can be reused by BPF
> sample filtering.
>=20
> Also add rw_semaphore.count and struct rt_mutex_base to the minimal
> vmlinux.h and extend get_lock_owner() to support rt_mutex and check
> the mutex handoff flag.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D4

