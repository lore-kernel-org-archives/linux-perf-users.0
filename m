Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D61415B8E
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182534; cv=none; b=DrpkM+eC1IJwWMK51V5ExBkB5XkMcDQftvrz8bWznhmwDPTxSnTUUqegIceTB37Cq2ZZFfi1uCv7VRVHUkWU1nSJlmInRxXhVL2q/0fevcn1VXV/BZ8sdkLL6G81WLgFtvSJM82I47iw4uTMkkIwextWt5qhoVI0HDwjksPbQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182534; c=relaxed/simple;
	bh=XanbYCHirQ++m+0C0FjW673lRcrXJxQQQ8TgV5Q/pe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HrhSCLi1FpRcP0qeSJ9dkMCoy7WQjLSB7qpv+KlffBoqw00505axlxYDsThhI9bXJgUruPT1XjwnrR9qEupKgs2YzOVN1rHg6r2wgmNdrVqirt0RpQf01k0JX3qYwZ8vjtBpOGLECptn98DFzJukP689euq8NKBJzH67fV8CJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMc5aT9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMc5aT9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7CD1F000E9;
	Mon, 31 Aug 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182533;
	bh=EvzahLOd6sWEhVkHMU6ICfe4P/xJ/UiDN4W37iZJ3pM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMc5aT9o1Hy2BHsz4dXkm7afU5n4Jw/RnKuRB8i+wMs/xCu950H5j+ZMXYgaIrj26
	 iJT3IbbH9IRJq6oEBYwToq+w1MLhfPHV4X/9Kn0oFYX9n3QRI6iFENLXeSelqVPkOd
	 to8DHSfk1qWkXQHSzAIdZNZerXbcF+++qdzrUXDWeSoYl6f8wX8vV0GXgPIcATv9wl
	 c/NVXUNHeyhwTTcNLoyyB0XnVpmGLeX3L1/KO24Q0EbKBoqvI295Zb/EylyCYsaoFC
	 uoVLyJQmkdgdNBHszXtpM06KZ+b1kEdwvx43y7pvlFUfDkmqgGCWwo/+rGjdtyDLVe
	 aaGgr921m2iEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf jitdump: Prevent integer underflow in debug
 info size calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-5-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:22:12 +0000
Message-Id: <20260831132213.3D7CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_repipe_debug_info() and jit_repipe_unwinding_info() compute payload
> sizes by subtracting the fixed header size from total_size:
>=20
>   sz =3D jr->prefix.total_size - sizeof(jr->info);
>=20
> When total_size is smaller than the header struct (from a truncated or
> corrupted jitdump record), the subtraction underflows to a massive
> value, causing an oversized allocation followed by an OOB memcpy.
>=20
> Validate that total_size covers at least the fixed header before the
> subtraction in both functions.
>=20
> Fixes: 598b7c6919c7 ("perf jit: add source line info support")
> Fixes: 0284fecd13b6 ("perf jit: Add unwinding support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D4

