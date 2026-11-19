Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046727;
	b=dD8TR5NKLHKGwrSEw2s1kkgF46zB7mooSAMf8pI+Va15teAJUe7kMb2LfqQiniZ5vXwn
	 ln4eXSwxuW1H2cxJr4kkk4MM5wMUFlwA9zLRD3nOAj+KfH7AUdYo8BUiB9+B0j6Fo06iU
	 5HypFJEIhpXbeeTzHJ30pg7INE1Dopilv05QB7arYbWyPVrzhTs5eJWaOrACJWuiDCdt7
	 cYVijIePy/jR1ZthkZJ5/RTvWOp7IKMDv2GFMRRmx3K8ngvoWYwUd8KM+EmpLtzB6frhz
	 ThxRdNcllgv/Ol1GFexkN9tfbLlLbi+HUQ0Fx+Asr5aSvpt2JiWtfxPpt+aKyXsJTIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046727;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GLsFM5JDyzlTt6+VZcfC178OnTFIbeZHjabAs6dyAB8=;
	b=aydIrajhrJD2dwOcKt0kporgla8w91R6EjaZOrOzCJIYO/ZTST0o4coUzxBwH3Tkf651
	 rvRynDvRpwK9FoCoKqHG/0sHM/SvARv7ZZb+Us90f++xQfV4kBh8g9hQRRdq6BwEm+Z0s
	 lTdgnRb48U62oYMxEc5Qf9tIywRaciK1StQs50mL04vkNOo0r26pEGyIyuwn2qhI5dlru
	 NGh8vFdQqSJ2urfcVwhycUXMZT/JLEAVqbFqAwyrvNeoz87C+0sOiY0+oyMJtES2IvrN2
	 jcNcn5tgzrPug65+anXbLQC8iqlkJk0CKM/DxRncdmnbX5TpLV5VF8Q7fqDClEs4obA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0rQqKh+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A0606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0rQqKh+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B061F000C4;
	Thu, 19 Nov 2026 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046727;
	bh=GLsFM5JDyzlTt6+VZcfC178OnTFIbeZHjabAs6dyAB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N0rQqKh+gmRp7R+iEbGHkP01wHF3M9D6df2ZBGXfpF9ou6yrH0IrID5bsE98OGmgR
	 K93lqB/2tfMehRCUPIwKQsXfQ4xuUjzdOlTo39urH8kAJx3AOz0b4ucq8zECReDpxU
	 nOw3tIIQ8RHN+zW+xgDTouzoTHib6WggYjvq3l4I2iNZIkbeP+lSaZm3ScaYF10s2e
	 +KnfIIIl6EJcS2SdgqpbOGrUUe4myT02+LKLtchtGXDprpDA3IWh04+wMCTI5UTywB
	 UPEIPEttOq9XeE10oaA0ti8d3rj5cRjKb8Ko+wWnFOFKOI75nUc9Fbyhm7nIPmJQ8d
	 UNkOnULqWiB+A==
Message-ID: <sashiko-outbox-222227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Run stacktrace_ips
 raw_tp, tp and fentry tests on arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119000112.2377949-4-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org>
 <20261119000112.2377949-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 00:05:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The raw_tp, tp and fentry subtests check stacks unwound from
> perf_fetch_caller_regs() regs. Now that arm64 perf_callchain_kernel()
> skips regs->pc of such regs and no longer reports the caller twice,
> run these subtests on arm64 as well, where kernel stacks are always
> unwound through frame records.
>=20
> Leave the kprobe, kretprobe, kprobe_multi, kretprobe_multi and fexit
> subtests x86-only: on arm64, kprobes at function entry miss the probed
> function's caller, and fexit stacks have an extra entry for the traced
> function. The kretprobe subtests pass on arm64, but don't use
> perf_fetch_caller_regs() regs.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119000112.2377=
949-1-andrii@kernel.org?part=3D3

