Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232058;
	b=oimuOnFGhuddFGIkNrfsE5eboWpnhZpUVxMtss0NlYW4IY1FVbDVQICplSDs95wG2P0V
	 Id0AlPUqqi8/haeXIcph+f0P0zEdNGsPngN4VNhDlFAC19YrHPO6mPAnJ/7lmR6SSB9KU
	 De5+eNQyc4f0DNU4YD7za9FLS5VNz86Nz8Sq5GC4Bps8DrCLwzZyjNcNQlEXLlxR31j06
	 6TBQWhQrfbyrlQhTUpaKdMvW2J6wkrAqyqyAmRDzDbyfb+t6IjM6mFJ7iVDwxx33E3jWR
	 NUk0pASs2PbyA2Q/7OPpzHzkbxoQGpT9kUK+D9FmWIJwjuYUonpS40/5mnhGY1EkHTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232058;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FXVDMcscyy7EdwcolLjtEYWLVklnIsMJz8YX5VcMLBo=;
	b=v46wmoXMrahNxLTWSkzojYyJ4AbbNyRkpU9fEyPYLddnJE4r9V2God4Ucr/+RNiM0ojE
	 E8RLgzqtaqrWs0QwA7MjFYPU/0ZdS7ZpZaXqhvHuLyhnw6cCcl7N5lnE8yPWbbXmwD/z+
	 WKF532T34QUGz+D9Bzi92GAarTZnjg9eaTK3upO7+/8QN5h4DMWX/Q0zyvYRxRj5WAe2X
	 cI0mKITPMmbujRh94H3KEG3NUwuPtWaE2TPb0vMcn0ziiKI6Q9yvia/t/o4ghgW8HF57Q
	 w5dfGMLCAgMysBD4sjOw6O2UGhWNJT/q80hmJmGjskd1SaFAnOmZehnFy0K9Az3Y6aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at79NJN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF801606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at79NJN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579D31F01825;
	Thu, 29 Oct 2026 00:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232057;
	bh=FXVDMcscyy7EdwcolLjtEYWLVklnIsMJz8YX5VcMLBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=at79NJN4ZVksXq3pX//EbCmED00OOej+BMXiNcQKMJeqkmKPZe7BdwiqL1H4wOI0k
	 g613/8iRbTTgeXPmR0L4nKDI+/VdcegZ6Oga39uJx3JJ72I/QJFHdOoGNqr5buwjNP
	 06g5GlzxDo8VlHs5kZfIINDMDB3D1M+cMRy9S8RVSBg6yvhckiYvh5A7ON3J9ay1D+
	 inLK7RZ5qt/4G6cAhojx9aoBZ71W6j+3nt1ZwwtrHdrdBsvzjHI1cMjidzloe+ObTb
	 zPgpqk0f4mViqeI8oDXri8kEUdk+3sX08CV8kUcX5tG7Zb2i+fFJPaBW6JQ2JHw9gY
	 FYB+6K8ajqaqw==
Message-ID: <sashiko-outbox-188553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] perf script: Add --lazy-load-symbols to load
 symbol names lazily
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:00:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> This patch adds the --lazy-load-symbols option to perf script. With this
> option, perf reads the name of a userspace ELF symbol only when a lookup
> returns the symbol. Eager loading remains the default.
>=20
> perf script loads the ELF symbol table of every DSO that appears in a
> sample and keeps each symbol, with its demangled name, until exit. Most
> of those symbols are never sampled, and their names take most of the
> memory. On a large profile this makes symbol loading the main memory
> cost of perf script, and in a memory-constrained cgroup an OOM kill.
>=20
> With the option, the loader still creates every symbol, so end fixup,
> duplicate selection, PLT synthesis and IFUNC marking work as before. But
> it keeps the file offset of each name instead of copying and demangling
> [ ... ]
> C++ service, where eager loading creates about 1M symbols, lazy loading
> reduces max RSS from 341 MiB to 154 MiB and time from 3.2 to 1.5
> seconds, with identical output.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-symbo=
l-memory-send-v6-0-7e90415f0101@uber.com?part=3D4

