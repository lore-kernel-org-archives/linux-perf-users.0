Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B54334A5
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183090; cv=none; b=D4a6TirQiVxLUkUtQJPRB01R4lCCDd5E+HxoddQl7+MD5X6oO8T0TdblsT/AONoimQrF7aNMI/yxDGWdYDuXJEZ09F2ZEydCo0/p0/FZh0/O1JaXTSUjMYnQBfXQD7/p+3Zh6t6tXo5eJKSF/i4ab+sTOKS4FJv/Xv3/ZvG2bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183090; c=relaxed/simple;
	bh=hgwMUcDNmIVbib+RwNpnua7krdi03Kvov0tTlZ/slRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tAPuLsLOxa5ZMK2K0Q5Rfb3eHMwRzDQdvgeXKCbGu0vgtjhmCPDQf/4GL7iHk575rEdKchgZttR4kTVtHGx26DGqht33GWhHhELyg+IODRePoUupsBl18DERFfHpXZb4s3Fdw6BqQ0YyiVWUqjxoQk4IFoTDyUfqsV4rTwOpAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4nOy5BE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4nOy5BE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4511F00ACA;
	Mon, 31 Aug 2026 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183087;
	bh=hgwMUcDNmIVbib+RwNpnua7krdi03Kvov0tTlZ/slRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4nOy5BEp1bweJi/srku2BY6m9zNy10o4FYW4Ac2AOC6t/bZOOeVqj6skrzQcmwkr
	 7lYQMdzrhbAfvc8u3XJbeO9TPrUxS3b5uQKchbGl5WKg2gtNZziBobstrrXFRoGAB+
	 FvpJHo2GoZmjrvUT5XMQOwLzurBMD76svdvLZVTzUihJDt1KJJK97CxgnQZ1Bf9Xq3
	 HRvVmrQ8Wtpl5zhdCLOQ5e9XkAlwAuk6F2oZ8eTHdT9tbVzZXQOpvYjK+qdocXmmmZ
	 lmP15bOHRXnDCSCkSD4lX+5+NNTatPjFXJdUbgi5G9tck9LtUJmp+aicYSiMxDYOhT
	 xST0wDILxMEsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] perf jitdump: Validate sym string NUL-termination
 in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-12-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:31:27 +0000
Message-Id: <20260831133127.AB4511F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_repipe_code_load() computes sym =3D (void *)jr + sizeof(jr->load) and
> passes it to jit_emit_elf() which calls strlen(sym) via jit_write_elf().
> If code_size equals total_size - sizeof(jr->load), the sym pointer
> aliases the code blob with no NUL terminator, and strlen() scans past
> the buffer into adjacent heap memory.
>=20
> Add a memchr() check to verify the symbol name is NUL-terminated within
> the region between the load header and the code blob before use.
>=20
> Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D11

