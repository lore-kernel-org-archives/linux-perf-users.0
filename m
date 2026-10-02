Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1946F4A7
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932393; cv=none; b=YgxbQptnBvB7lr3WTOetS+4O16lV3jGaTPpmHHn6c7rUymNK7H5tM6FOezdQSyOutl483LmjUkcpQbg+pjCkyFrWldlriqHp9CsVhhLgZSR7WyaSYRczXeAtX+aHtKB70d7Y7MTWcQhMO5UY8S+15WSE2X6XrViE4/OJq8cyqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932393; c=relaxed/simple;
	bh=xkQbA3fbx1lWsHMqg/ik/x5I8aXeEjCT/utoyuJSrEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LWGp1xfqH4ICMS37vo/GTNNmnJXgeObTl9hdf4BdYuR6seBL3m+C01DDOiiZ1QDHPLZAkflTWa0Ek2ckLct6ehQiSrG4pOfwEKHWa6Q0yVROUTwQIhqXdfAGW30PX0mcZfNl6icNAUat3N4JrTBBsqcMXEJrPpAq69XvjM8r5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ9kHaLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ9kHaLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64211F00898;
	Fri,  2 Oct 2026 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932390;
	bh=IoBmWjo/Bn2o/Cf3Ueb78V9fCtOeycOiwvfrv/swgQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WQ9kHaLkngUjPdAjNfTOVO5hdrlCK3yC4gNnGuNf1pVwECXzqy/nKceDTlSrZVs8d
	 bKw5TK96NpajwezD9/RemWEHemAJZul/KjuajsZ4BfIYQaogDFPG3Oxrpy2JUJjGBJ
	 EnEKlkRDD4LKxFdulX/lb3f/t6phaNaOjK3sdB+eYt3ULdmd/lTLyag35Fqe27/S0g
	 wB+d64otKA+ZZVy+zLNJKA5jaICwrBT5ZfFUmpa85k1qFlq+jn0UWsmF3Bfuua/561
	 FKeXyi2jF+eMbFefJAV7jM+AH7mpdnn/ugRc6q/wE4Bo7o2WdpjJGVeQOT04VvLsTU
	 6W9Z+weOkHeSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 9/9] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-10-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:10 +0000
Message-Id: <20261002091310.C64211F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> sum the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Data type profiling of the workload with cacheline info:
>=20
> [ ... ]
>              0.00%   0.01%        struct folio +0x34 (_refcount.counter)
>              0.00%   0.00%        struct folio +0x18 (mapping)
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D9

