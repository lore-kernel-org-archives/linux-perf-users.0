Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783595;
	b=gL3zMYB/lnXnMIYrBr2M8J2TZMUcU0XZsxuB2hllIAmCFkoYQ6EX/rixMRfnUuRCDpfz
	 Lbum2UPDlS9wF6GfZO2NImrJQNr5dGbsGez+DBS0mxNDXw9/5ToCNp2E4NwgyBH05yoC/
	 qk94lQ50WI0oBMA9K9NuNtLT8frcFu+g0IsRizXHQycPoyF9xBUnD3HLsmc1GolcFeFXM
	 G9/QcGUDw5lb8mscnbKNSM20E+9UZPnQRSaAZ+M7rHqkE/0yijFylHXI/0uiG9Kl7JM0Q
	 BSK63Q2Be1Ki2kV3TuDSYVQwmjwthA82R3Yzn5pHv7jWWzD+WvUJg4mkXLKwl4Zn8DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/NxTEchY+zOdklGokOpY0DS25Ousv1FbrgWrizI7wPM=;
	b=tOxhJRGkog966PZsw4xwJKgx3RKpfnxrevNnnBz8DmzUNxOoRSQzGiFUjheB8icuy/dy
	 0SHxgsFl763IOj0HQkmYCWXwa7lj43Gmwlm+Gx3526uHZ3nuQz4+3wSD/EjYeSa5hSO+A
	 GwghkOPLtUo08ZL9Cn4VE+3ebPBE2FguDcpg2Q7ZBJ8qHSlpoWsCluG8laNpcDFiUHwW1
	 fC6N1G/SUTQorgwDyVUEm6uXpV0wHk7IPp7yFhQf6fUqGIlevqqA50a6ej+gwgB0S8qCD
	 xfD2bDKkFFYJCbBxPsTyhp+1cL+cgHMxHyNA2FJu/cMJcQE1LXW8/v/w9OGpJP+9Abw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOmZ0FLA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC93606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOmZ0FLA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647571F01828;
	Fri, 23 Oct 2026 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783594;
	bh=/NxTEchY+zOdklGokOpY0DS25Ousv1FbrgWrizI7wPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOmZ0FLA7pIfIXeuowSh4Ry5OVSnv2MA4LIQYFueIqtowhKFVde7LVt05XT2TL3c+
	 TCtHVdaT3ZcSn8AdsR42U+RWvESQki+kTmHsb8mWlaSyQ152aL6rTVEFJk33b+LEBD
	 rMuPpafjKTD5LZ7LHSu3TR4JEJ6DpW0iux5UBmvgBzT1/jkF8OCnH5zaADoSRhBQz6
	 8nWCpiODR7BvpWI/+2mgPKhB6NLuXLTpzK7dQ2uRe7USQIn++GaPjvaz+dWv80vH2h
	 E0G1j5sPcvWlGCi/GnU7M+aSyKz6huT5Ml5zWeGfxry0B/hEOoy4igHh1xjorcDUHy
	 7zYZgDzlvgGDw==
Message-ID: <sashiko-outbox-183113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/11] perf bpf-filter: Extend lock_held() to other
 kernel lock types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-7-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:26:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the lock_held() BPF sample filter beyond global mutexes to
> support:
> - Other global/static kernel lock symbols (rwsem, spinlock, rwlock,
>   rt-mutex, percpu-rwsem, semaphore) and hexadecimal kernel lock
>   addresses.
> - Lock types and flags: mutex, spinlock, rwsem, rwsem:R, rwsem:W,
>   rwlock, rwlock:R, rwlock:W, rt-mutex, percpu-rwsem, pcpu-sem:W,
>   semaphore.
>=20
> For rt-mutexes and write-locked rwsems, perf_sample_filter inspects the
> lock's owner field directly in kernel memory. For locks and modes without
> an authoritative per-task owner pointer (spinlocks, rwlocks, semaphores,
> reader-locked rwsems, percpu-rwsems, and lock type filters), attach BPF
> fentry/fexit hooks on kernel lock acquire and release functions to track
> held locks in the held_locks BPF LRU hash map.
>=20
> Use classify_lock_sym() both when selecting which hooks to load and when
> resolving the filter, so the two agree. A '*_sem' suffix may be either a
> semaphore (console_sem) or an rw_semaphore (namespace_sem), so hook both
> and allow read mode.
>=20
> Note that counting semaphores (down*() / up()) do not enforce same-task
> ownership in the kernel: when a semaphore is used as a cross-task
> completion/signaling mechanism, fexit/down and fentry/up will not pair
> on the same task ID. Semaphore hooks are therefore only enabled when
> 'semaphore' or a '*_sem' symbol (such as console_sem) is explicitly
> specified, and held_locks uses BPF_MAP_TYPE_LRU_HASH so any unpaired
> cross-task entries are automatically evicted.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D6

