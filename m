Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC893E6DE7
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172438; cv=none; b=WxqbPG4zYVE9LBl9pYL0SMU2ZoAJsmG56siIQE/buDCJtRUE9sDdGHjRzzHfDWVjRBr0rynsuFWWsX/l3og2b/qVr7j7hPVkaBaj9GeywoYcDzZjtrFW0Tqcna3+I5h1P3WdQil0tU6ot74Vxw2Bk6MZEJ7xKBnQO/nwPV8cVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172438; c=relaxed/simple;
	bh=LFnjbzMAUdeOKXBnJk1Hda37um56zu2mvcltRiPLSHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LgTPRhSUvQhp9heAoVwMMzUEC6d9AMh9tVD+sUfhWVYjSqNs6/95SAZQ4xmGqQibgmyAJE2t1llKwvJr3PlTmVGoOnDQ1YxVwYogd9RjlishoNFv/fxv9sxMuwy7OkKa4IN2VxJ2T4Ca8kGwy7kSv/AdhM5FpywW0YBwBwedHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd0hx5oj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd0hx5oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A328DC19425;
	Tue, 14 Apr 2026 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172437;
	bh=LFnjbzMAUdeOKXBnJk1Hda37um56zu2mvcltRiPLSHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Gd0hx5ojT9EMeR9iFHmX89AHuj5u4Rfd/ZurfzQV4m3bpQXj/JwIJstFk5hBiCN/p
	 spIIT4yMmG8cz9IeNyW02nIKPkIkMrax5z1KRyb3ENJDojMUHMHJJWcbLPhePFToDG
	 t5SGMA12YkyGlct1aTG41KhA5JBKW5zsOOqgSDA2TlfylnwAzr6iW0/10ttl5PYM1z
	 e1MOQp3Jzii09BUdgc2awOgIH9YvtRu51HdeUZ7cG3wP1TcVEYVzeNYguO0XSah5W/
	 +u982H+TFkVKCCXZO7rE+54PNtLLNdqZchpWi1flQ0yeCuUn+kMiCos/SH0Ob7XnBb
	 vj+mX8FfEWx5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
Reply-To: sashiko@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414124241.490185-1-tmricht@linux.ibm.com>
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 13:13:57 +0000
Message-Id: <20260414131357.A328DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Bypassing the kernel IP check on architectures with split address =
spaces (like s390) causes kernel IPs to be duplicated into the user space c=
allchain.
- [High] Unbounded and off-by-one array writes to `inject->raw_callchain->i=
ps` cause heap buffer overflows. This problem wasn't introduced by this pat=
ch, but existed previously.
--

commit 26481cc9533f02e4ba0dd0fa26a4b3d91969b29b
Author: Thomas Richter <tmricht@linux.ibm.com>

perf callchain: Handle multiple address spaces

The patch modifies perf_event__convert_sample_callchain to handle
architectures like s390 that use separate address spaces for user and
kernel memory. It prevents incorrectly dropping user-space functions that
happen to share the same instruction pointer values as kernel addresses.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f42968611..4f07e90431546 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c

[ ... ]

> @@ -439,7 +439,8 @@ static int perf_event__convert_sample_callchain(const=
 struct perf_tool *tool,
> =20
>  	node =3D cursor->first;
>  	for (k =3D 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {

This wasn't introduced by this patch, but does this loop and the preceding =
code
write past the end of the inject->raw_callchain->ips array?

The raw_callchain buffer is allocated with
calloc(PERF_MAX_STACK_DEPTH, sizeof(u64)), which allocates 1016 bytes
(127 * 8). The struct ip_callchain begins with an 8-byte nr header,
leaving only 126 elements for the ips flexible array.

The first loop in perf_event__convert_sample_callchain() iterates up to
sample->callchain->nr without any bounds check against PERF_MAX_STACK_DEPTH.
Since sample->callchain->nr comes from the input perf.data file, a
maliciously crafted file might cause a massive unbounded heap buffer overfl=
ow
when perf inject processes it.

Additionally, this loop iterates while i < PERF_MAX_STACK_DEPTH
(i.e. up to i =3D 126), which allows a write to ips[126]. Accessing ips[126]
writes 8 bytes to offset 1016-1023, which is strictly past the 1016-byte
allocation boundary, causing an off-by-one overflow even for well-formed
callchains.

> -		if (machine__kernel_ip(machine, node->ip))
> +		if (machine->single_address_space &&
> +		    machine__kernel_ip(machine, node->ip))

Will this bypass of the kernel IP check on architectures with split address
spaces (like s390) cause kernel IPs to be duplicated into the user space
callchain?

The cursor populated by thread__resolve_callchain() contains BOTH the kernel
IPs (resolved from sample->callchain via thread__resolve_callchain_sample())
and the user IPs (unwound from DWARF via thread__resolve_callchain_unwind()=
).

The first loop in perf_event__convert_sample_callchain() copies the kernel =
IPs
and the PERF_CONTEXT_USER marker directly from the raw sample->callchain in=
to
the newly injected callchain:

	/* copy kernel callchain and context entries */
	for (i =3D 0; i < sample->callchain->nr; i++) {
		inject->raw_callchain->ips[i] =3D sample->callchain->ips[i];
		if (sample->callchain->ips[i] =3D=3D PERF_CONTEXT_USER) {
			i++;
			break;
		}
	}

Because the kernel IPs are present at the beginning of the cursor,
the original code relied on machine__kernel_ip() to identify and skip
them so they wouldn't be appended a second time.

By completely bypassing this check when machine->single_address_space is
false, the kernel IPs in the cursor are no longer skipped. Instead, they
might be erroneously appended to the raw callchain after the
PERF_CONTEXT_USER marker.

This duplicates the kernel callchain and incorrectly classifies those kernel
IPs as user-space addresses, corrupting the callchain data in the injected
perf.data file.

>  			/* kernel IPs were added already */;
>  		else if (node->ms.sym && node->ms.sym->inlined)
>  			/* we can't handle inlined callchains */;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414124241.4901=
85-1-tmricht@linux.ibm.com?part=3D1
