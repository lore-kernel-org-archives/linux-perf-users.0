Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941770;
	b=vpkaZ/IX/V6Nm6aiKDPFQP2+LKSHWCWt17Ft0ZQEyYZ8NEjQKX1cukFwxEU4eLrmpdZ3
	 icrl73+Wlfg/pLVcIyzsYDM17PTl4GIOrTZRQI/CvlzVdWHZkz0oOLO+YPFstvZg1RS9G
	 imAAKEYhmjh794mWFL7pUqtk2OnSySPn3Dq4xdTBuFohGwRfGg+8TBq5xkpmKX73R1SPL
	 frrjOK7OIuttg3gmP62plFB4IV2t4TfMJFm/z/49PjAPN29TiCyTUfiy+FvdiWYfB+2g9
	 G4OGZuwDO4l47RKmoodAx/82Tx0zvMlZ71zfDR5UjeNgttPsS2NMKEwO9iSRKfF42wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941770;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uTQ2YrcbiQPXct9kdFmiU2IsEtETbJgJP+HW1af4sWM=;
	b=Dgndgn8s8/pOx7zOFV8pFpLLbMBr0jlDPA+Y/bPgDnebSwOQ5IfQVW/xH12iXaX2M7Bk
	 pD0S/GkhQ1A8f9lB3xR1PEgLCenzMHTGcf4b/hS6awNpHqkcw+1wxRTc8Cd8l07w8VRT0
	 zZqMIrC3xIZmVAMSx+bpXqdLP8mRwxLbEkQPtxzAEUAW3j8xw5M+oC6SYZEW6Qf0Vgj8O
	 fLTgtXYP2YOleXRQLnyyDKrHJu1aBUx89MljMGD0nobEOcaQ/wz1ZP2d5gNP32V9p6VY6
	 6+fyJS19MZiVMQvLhg9geR0E9EbdOv+6wjGtBFJLvARA7DKyUK35pMxstNKkEXWXjOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBRwQlcq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6A606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBRwQlcq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100E91F000C5;
	Tue, 17 Nov 2026 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941770;
	bh=uTQ2YrcbiQPXct9kdFmiU2IsEtETbJgJP+HW1af4sWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EBRwQlcqhI+r1AO8ebbIH20FWs2d7SzhQTJpc/uth0bkE8rCKpKVzmyT05o3GQgep
	 vrOt/2RqKeoLkdKvN3GjK6DvjAOZ1k9uiJEwPHjFuFlEIGyqE+ZNiV414Ag47Yq+/U
	 qzQy+RYMpPY3ZHdsAlvvvzvRXzYxU9Q2h3bSsPrUYHuTWMnV14Nxy5m31C23y6QYM6
	 7f2616LUvezMjnSqGIqA3VKsfpXpOEOvNyXZxou8leAJnJ3nHb7+B1phGHESsbm9Jj
	 tmjYPcQ6LC90sSQZ8jQfwaGT3YUwTEDeyLrJuc9xUadTBTZfSkY7LQgxhH5naKR0dK
	 3ZL74im3ZlqKw==
Message-ID: <sashiko-outbox-219410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/23] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-3-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:56:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D2

