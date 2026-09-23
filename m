Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A834AB1D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148394; cv=none; b=mV9bbZrClwF9JdVrI2UeXfoCVGihegA3K5r68tHfkX9x1cK4E94oXSQ0Klj9NzSdLdZ6T2pN2a5BmtllKF2Yb40yxl0do7F8PsqXGVLM1xhGbCqqf97XaDAIbJ15wBdHj8aeQ1vSIs47Mw7P9pLREnszHXe8S+6Hyadvk9tqEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148394; c=relaxed/simple;
	bh=JibxxGysB7BAxDe/SXGt53RjDEGjUJlWNsg7Tt5BWgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B8nwOrCaINGA2FeYITUYIRyPYy/wzKLO6VaeXHYadaXFDlxEpf8xHI2+hAp8ozw2zMG0obTwL43D/l8LoKLDaTK74BHKzc3G2T5Nb3iZ7pa1a4vdQzOET5/EXs215I7oOOAD1qCE5l+SZ0WWHT6fNt5oSfrfdyRSC/zBrSCzg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWJviiNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWJviiNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B77C1F00893;
	Wed, 23 Sep 2026 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148393;
	bh=qI1NgcOAUNuSd0m+WzAmNZDlh8hOa+xFzhd99ZSefP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWJviiNyXvUIX5t4+hO8gPeL2a0MUbxy7WC/lgG02c36wooyGG3p78pHPQDleXTKH
	 H6dSgjiZl2RT04tJyH97NWYmpL7EGVKEM8Ob1A7lQEs0DxI8lX+qgtRAm3io4yWgtH
	 R33u4q/YpfCgyjinV9OL/6nf4sQb+G4A9jW5eV9p/Xy7JuvB30OHuK7lIxRKPhwvaa
	 0joslNYDOhgonOtmg/tzBSjKWDuve6tW2jDsPih56tBLDpiaKdsHPOlBRKnEvafcoG
	 HOLBYrNw6kMhhpsRNpSTyOrp+toxBDhooo6eztoJ2YJB398TlpvusF4j2+nGw7bnB8
	 gSR7hpkjzdjPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/23] perf trace: Bounds check augmented arguments
 before reading them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <99ab722ef23fa269a0c6a95381a7493fcd5d6e0a.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <99ab722ef23fa269a0c6a95381a7493fcd5d6e0a.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:26:33 +0000
Message-Id: <20260923072633.7B77C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Augmented arguments are length prefixed payloads that the BPF augmenter
> appends to a sample: a struct augmented_arg header holding the payload
> length, followed by the payload. arg->augmented.args points at the next
> unconsumed one and arg->augmented.size says how many bytes are left.
>=20
> Both the length and the number of bytes remaining come from the sample,
> but syscall_arg__scnprintf_buf() takes the length on trust and loops
> over it with no bound at all, so a bogus value walks straight off the
> end of the static argbuf that syscall__augmented_args() copies into:
>=20
>   #0 0x73104f in dump_stack debug.c:366
>   #1 0x7310c5 in sighandler_dump_stack debug.c:378
>   #2 0x7f749ea66fb0 in __restore_rt libc.so.6[19fb0]
>   #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
>   #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
> [ ... ]
>=20
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D8

