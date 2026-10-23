Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783155;
	b=hYwl+mCoQXS6DVqs7Z7uKe/1C80Ucawti7JYuksMyhQjbL8mXkjVPmU1aFOHtBveEad7
	 c3NdxnuJbiDyORh3FXVyE5mP/3D3HNLsM96CvnLA52S3GjKzoUd8BVlbRRRN3ewmYHr0v
	 G7hoqUG4EFXOc2tx9chu9DMLy9iBXxOhuLv4/ONeNYkxKF8oSLCXtNrE6iPSYLjhV2W8B
	 m8PluWNS1W6Yls+F2th8R/DeCXTNFurXlDt0ipuZw0F5fkii4uNr6wADIKanhwOxxW+qH
	 4HvQ+vFgQxbKA6g9qXejhCNp8s86MaxOjZaOyOWS3at+S2vn5gPed7XUinPetatzftQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QNr9n43g1BCD0KMBddSA4OeVl4LEtg6GlLAFYFb9Glw=;
	b=0insmn6oTW1OhImJs/HsUqoASB+hkCJ0TXEaRwlrpmjRUf3tWQ/EazfoM96V8tczyj1K
	 hW6BZvBxNFMmLG9fiWNbJhOIzKsKITF/5MPtcIU5fVdHq+N+ZAjXdyoAgL9JIRHhcQ2Hc
	 prayNf8i4SAbY6rD2vVfvtlExf0srQNdMabRL7ADbYBBKPwJYohBq/Yds2xeQFhDYeEHG
	 qEt+XQf8hSOT8Aei03gpf8GrdGYBZkFeGuAHDKkYsuSJ2YbtWQLjM+3V8wtCXBQa8Ip8Z
	 dF0MjxNDCb8RUnQW/oZwVodw0T5plj+ZuIAf4vTW87HHaCWGMLCvMlHFx7y86homL+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTSHgR8t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E13606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTSHgR8t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B911F01825;
	Fri, 23 Oct 2026 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783154;
	bh=QNr9n43g1BCD0KMBddSA4OeVl4LEtg6GlLAFYFb9Glw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTSHgR8tHAjjPqIg40UpnYj0Jw83OftNqJ17dmQXlEwPhVbqod9fCrIFrx9GTET2m
	 VS398uXA+SsGtAC7Fq+XUJX2zi54oUfU8pLBS3Ml1l56wFNCStq9bJ779cXkHJInTx
	 Vz9XVvxJWbZyJDpmC2zRP6RkTxrWUubVv9ojUU/E1tRrIjvdLUL1zJGLHkERGhNibK
	 XaZO3EU26lroqdtJjz8NWBumGPvUEnHN2LvdTIWc1TgTFxOsPIq8bhs8OI8jtpfrHn
	 P5aNZFZD8zMs1ZCSMgtetWo8UTK1I4DDDzVshV4lFz9vlipmsXzB0p5j7GEd35RQss
	 /JMvq9tDwQ7EA==
Message-ID: <sashiko-outbox-183105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/11] perf lock contention: Extend get_lock_owner()
 for rt_mutex and mutex handoff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-5-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:19:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend get_lock_owner() in tools/perf/util/bpf_skel/lock_data.h to:
> - Support rt_mutex locks (LCB_F_RT) and CONFIG_PREEMPT_RT mutexes via
>   struct rt_mutex_base and struct rt_mutex___old, masking out the low
>   waiter bit (0x1UL).
> - Return NULL when a mutex has MUTEX_FLAG_HANDOFF (0x4UL) set on
>   owner.counter and is in the middle of being handed off rather than
>   actively held.
>=20
> Also add rw_semaphore.count and struct rt_mutex_base to the fallback
> tools/perf/util/bpf_skel/vmlinux/vmlinux.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D4

