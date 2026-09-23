Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453194248C9
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188536; cv=none; b=BBEF9XAIj0nbk7t/wa8tcLB862Y7r2twMjGHDi6kPnDYpZ+nB4l5wzHePMdWO0b1W1SQsfcbDIog5MPm4YXEgo6GEJr24ijxGpn0esu2B8W3YYbo5zimDoUrvGPEHL2lg6WTnL2M5dfjC+4eRHudds2fBPEGGRCBxfyOD3W8LrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188536; c=relaxed/simple;
	bh=t5ya3zm8B99QuYs9sIavm27i1zu65iSDZhXES1hFHL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEf4hKT2ag57THXI4NyQqemC6dZnxucMjLGESVe1wgunO+gWVwDw2y/hxouoMBGah4HhPz6XGCBszNTtSPMZ84Dd9P3qvtWCHHhj67jTTcSBFhjZ0sZWhZu9qgU2Qi6z30PUd8JEXQtgsjrb5ZYNej4VQCZ/LwuFEnGcZdD+ksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPmZww9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPmZww9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909691F000FF;
	Wed, 23 Sep 2026 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188532;
	bh=UK7KfcS1uv8kByLJDcavrcozSE6NvFgl2fY8b1EwWew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPmZww9jQKKXwoR4U8hT8ZHsApEvfUtCcm4j1a/fWeYV/aejUrvO9YbuHWfbu5gUs
	 UaPqCSCHJxO//gVWO66imX3ccfB8LcQwDo9vTlaFyBNYi9QqXWlD46wnGeOZTLY8zb
	 Z+EV9TALV/5UXIQazHcL7V+UDBblK6tdRZE1mWj5RnkYqC2l/x1xFDUbIIG7ZlpVQm
	 QIajE7a6jUZ6OJNFcFB6SCmKVEX2Wez2S3T9v/DBC37O48iPvRHuncQYmnc5Lg1r+t
	 3IXIiwHZE0gSBjodPvMBGMoPIAHe/wqKa11DasUu+e+rsuCFqVwTLSmiWdzHCovz9r
	 szJvXOt8B7hKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/49] perf python: Port rw-by-file from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-28-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:35:32 +0000
Message-Id: <20260923183532.909691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-file.pl with a standalone Python
> script in tools/perf/python/rw-by-file.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Encapsulate per-file-descriptor read/write byte and call count
>   aggregation in an RwByFile class using perf.session and resolve thread
>   command names via session.find_thread(pid, sample_tid).
> - Add argparse CLI support (-i/--input and target program filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_rw_by_file_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D27

