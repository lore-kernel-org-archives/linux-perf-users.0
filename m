Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783243;
	b=b9ifn9tfXMKx+DE7WItCWGc3IyZ+I81MlftMXnXJMCKWeF8CRVHqampnq5oyHJUO5s4Z
	 XxAnQuXfqqX2q0ooczL6ag942AStxGhsqKFYh+MCrK6suMu1+g8h89C2DnskNYpOOorts
	 h3uhjOxn8ez/lUXMWiYDO+2mzF1QYNbNiCLIxtluylbNDWGumkJ6E/bYrpO7aGdKe1LJX
	 dSTpKTGxafBZu/yrCcVH47Xi28qCmQ79r1SY0BBS+nVoS2+9P0igLmsF9XJ4+SD5Ssp7S
	 K4SZmrRC0rLBKMmHTiLF8dWcowbHAI/gjRiqzoOOcNB8g78d9wik34pEozCJrq+v29Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=as20kn05iDIAjaLgdf9FNMTAMW2SjvrDTV62TvnXEVM=;
	b=fi08xxJL+JX+dhl1PP9U+zDSiDxBGkm7iZ5hEl9HLTYhd/3CtpPaDS8dY+9YwLXTT0ys
	 AWFh1P0+9B2TihR5O+Y8cAWfSXuAUS/eSkfZodPns3/x93SgR2MnyL7ME1jCl10eJTpFm
	 NQ3RLTo4Ltn5by5o4KVxwsa17aKRv/qJwjovYRmtvorG1wb7gd/DWhc3g1CXGuEnwxX70
	 FdnBzkqC0+faVHhIh1uX1BzKzdRpp9ss4i0hzD9iPaKqbNRCsd8DgqhgYSqMuF8mcb1rd
	 SJEw6ud8Tw+EOf9qX2ejnmF7iP/hBVAGJt03uG3CqalGLbi7cQ4qpgQwxSvQSBMnhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4D+5qZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEE606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4D+5qZh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A83F1F01825;
	Fri, 23 Oct 2026 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783242;
	bh=as20kn05iDIAjaLgdf9FNMTAMW2SjvrDTV62TvnXEVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4D+5qZhvWPzuLH6enNNwoUlfhXM36TK07R4Rn2g58ImwQz51VhAIRWUNUeXKu9T8
	 cgnazHxjRTtd1Y4o+xsIJKwrPnZR4FfzpS1wJWw3KUSwqs7sOD04FdNVAgsNT9qn8W
	 MdGbf6b5HfH8H984/PEjFSjRTZLEbnl7HSM/DESfarRxNiJEY7cCr94P0VCCBALkiZ
	 r8tYI1T+cNHZffjEJtdov7Mdi4A894/Gn0SB8MAT9gHlWMVQ2axdV9z0S76u6+hsnT
	 lqNF3YMnb1VRydiECXLcv62BLMdorDIoXDktiRmUngT+N2IeSAEhfoJmRYzyJ+3NnN
	 H5MiBnv+PPp7w==
Message-ID: <sashiko-outbox-183107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/11] perf bpf-filter: Support per-process and
 semi-global locks in lock_held()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-8-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:20:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the lock_held() BPF sample filter to support well-known
> per-process and semi-global kernel locks:
> - mmap_lock (or mmap_sem): current->mm->mmap_lock, supporting both
>   read/shared (lock_held_read(mmap_lock) / lock_held(mmap_lock:R)) and
>   write/exclusive (lock_held_write(mmap_lock) / lock_held(mmap_lock:W))
>   modes. Write ownership is inspected directly via is_rwsem_writer_owner()
>   without attaching fentry/fexit hooks.
> - siglock: current->sighand->siglock.
> - rq_lock: per-CPU scheduler runqueue locks.
> - zone_lock: memory management NUMA zone locks.
>=20
> For rq_lock and zone_lock, reuse do_collect_lock_syms() from lock_data.h
> via a raw_tp/bpf_test_finish program run at filter setup time to
> populate the lock_syms map with each CPU's rq_lock and each NUMA node's
> zone_lock addresses.
>=20
> Only zone_lock needs NUMA zone data from kallsyms and sysfs, so fail filt=
er
> setup if it can't be found rather than attaching a filter that can never
> match.
>=20
> Example usage:
>=20
>   # perf record -a -g -e cycles --filter 'lock_held(mmap_lock)' \
>       -- perf bench mem mmap -t 2 -l 100
>   # perf record -a -g -e cycles --filter 'lock_held_read(mmap_lock)' ...
>   # perf record -a -g -e cycles --filter 'lock_held_write(mmap_lock)' ...
>   # perf record -a -g -e cycles --filter 'lock_held(mmap_lock:W)' ...
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D7

