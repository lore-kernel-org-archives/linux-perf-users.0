Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943076;
	b=S2/NYMPoiKkCUSLe90alduWD1Qds+sJG8xroHul+9oXawkummjAe1/bIjg0Pv/QumwkT
	 WNw/hSsMQPyVNhQcyOrQNF98QV0W/C6Oh7RrUnfwJmLiQr4+jCqv9yMj0kIaLvmg0vjSK
	 66WmY+ii4UXmYpaWCZPiifw5ssltQqz7xhtprLdrks7+3VtcDwPHmYeYTEMRUfJHSvmGA
	 x3GDITMUWk54Afc8FbwGwtK3kdq8uVDjnIVSjaAfpA/5Q34NPpvGYZ9sD+cVRKQrMAnnR
	 c2aih8pPEcUqxphVKPj18HJHYXcQa432FugfdRsRZ3WYznnrrlSYPvDK0dLaqCAkF6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943076;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jWQdQQtanvswmQl+RLrIHvtuQXEWzwoFyjsol8JU8a0=;
	b=mW4WFLQ8rWBUMGwwWJIRW5a4/ZwHDOrngtqZYYD+Fe24mnSMq8nKqoL2vv8UE3QYpHom
	 +KdH7pCJB4uHZxq/+TJRiTtF4LP4XZKz9ehowuZX9OPyEsl/3LNEHiukJM/pnpXbvPKIV
	 lXlFZ2jPS9/Ok+FFPZa8IZL32ltNxeumBOUybP+tdHq0EwICATq6bx0GYNg+e7yDXvriO
	 KMXTWehq0Bkg/YouZRxVuvJEqrdee7phpIdYznA1e2siHnAInbrMIMB0kHAbMZkx6khcq
	 JoVTI9zJLdwB0d2lJE0X8aVlyYAc1gN2QDD407HgCTMNr/rQ38TdG40F6cuubUUVnzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elsdMpFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF23606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elsdMpFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E84F1F000C4;
	Tue, 17 Nov 2026 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794943076;
	bh=jWQdQQtanvswmQl+RLrIHvtuQXEWzwoFyjsol8JU8a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elsdMpFZfSqELleaaoRYGMQP9FQu3DG/CDIVwfRgE09QqGEw5Rn1uzG6jOCMR87JT
	 lluyMdi4y7NXKl9nKYqOF+O9sijc4TVxIvh5+rdLf6Oe58FqM9+LnOJvpYWu1o9eFs
	 i9aghrflU0QyR5ybcApTX9XBPSzBMDpTpF+dCj64zPPaMlyJ1FF/SNyEOUPgIQgQsQ
	 IgF+JkVjpHJlWwubVV+MWp7nLyh294PWKbga5sZh4WmoOtI5A2/FfkcKEl98IfUOw6
	 nIAR1zIQo2b3Vy6O4io7fSYQkKQLI/nhR3xhRVL8bppUEjMvcthHl5feRQUjMIqZI9
	 ibm1IMbKD5OxA==
Message-ID: <sashiko-outbox-219456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] perf symbol: Switch backing storage from rbtree
 to struct symbols array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-6-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:17:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, DSO symbols were stored in an unprotected rb_root_cached
> with a 24-byte struct rb_node embedded inside every struct symbol. That
> design had three drawbacks:
> 1. Embedding struct rb_node (3 pointers, 24 bytes on 64-bit) accounted
>    for nearly 40% of struct symbol's fixed header size and scattered
>    symbol lookups across non-contiguous heap nodes.
> 2. Unlike struct dsos and struct maps, the symbol rbtree had no lock
>    protecting concurrent lookups, sorting, and insertions.
> 3. Deduplicating symbols, splitting kallsyms, and trimming excess symbol
>    container capacity under memory pressure benefit from operating on a
>    compact array under a lock.
>=20
> Replace struct rb_node in struct symbol with a locked, lazily-sorted
> pointer array in struct symbols, matching the design of struct dsos and
> struct maps:
> [ ... ]
>   After (libLLVM.so.21.1, -22.3% load, -8.1% memory):
>     Average DSO load + sort: 61.074 msec (+- 0.236 msec)
>     Average DSO memory usage: 8755 KB (+- 1 KB)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D5

