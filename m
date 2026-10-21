Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560661;
	b=S/hpcomlPzYvykIbN3kaCr4lDER2gQoy1BJ6J+8Vn36LuFLjeyoxxSi7ooEcizlQE67p
	 lQ1RkCq+Li4oi/hpQYg23LfXAl+JH+XU0lOC4UI9dhIByry9w3BqwjXMBlTBigEfN63Nl
	 ZkoQtXqLMlZ9XuQu1psWQmb/4vlW5MdcJGNKqT22vwLYRvmXCYovkiNbMKrxBzda54Xks
	 keYgB0vNfQNdltJ6yCUiF8Dy4LLBYC/JLYbjO5tLxwngpywNZu0E76HOMoQ07YI6DD6pc
	 3IZisNAvVNGNSc5WLf3Qt11r0gzYSys+ZVaBbd1MoqPBKhfW1zyYCBQB6aE6q30d1TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U+g7h2juA7dAlMAf1gOHT4E7BqjnNC9/hlvwsTUO0KU=;
	b=DWyJI7Nf4TWZzEpEnGPPJzLrqKTtauAm+V5S2ygS93LBG4p63VOWSrVfbtMKQyOwLHHG
	 DIy769mTHtYqutaZ25BlF7gi/8kVA0MHopvVe5rWrxih6suQEGb39x99qAdYfIwCVZOaz
	 lKt/xyuOwsPh2bAZ7d/kwsKWbXhyLKy6YDBsdt8X1NQ3Oz90yZUcwqLNsWWjH+dZ4OW6K
	 rV0QisWT81kbk3xviuhIjt2J5HD3nydpGeZs1IPklXttM9jUKJrv5uHG/siHZCP59aUML
	 WOcoQ3CbAeFvcZlbiOGGjeb8hZ/5KzL2Jq/SCQnPL9jifDJsm9nGrnP1ds/ef2iGhCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCj0uL0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD38606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCj0uL0B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1431D1F000C9;
	Wed, 21 Oct 2026 05:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792560661;
	bh=U+g7h2juA7dAlMAf1gOHT4E7BqjnNC9/hlvwsTUO0KU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCj0uL0BdZilxRuL4L2+dJykItSsxzsynHFG2FzDexX3HnFLkXbhUbBkZVwqZ0PpM
	 Yl3T51j5TCDKCa5nLeax/Fq39WmMrv0vDObcoHKUFT42+2eeysIMyIf9Mrm9jBSgVE
	 a3FtIj5l38pd4daMnzBWTCOYce+Aass0v5zHszRAXLOjMv8XXlWl32e0jrWyMqZ2mo
	 WHS8oKA19ZPeOJUFonttpG3WsA+5HJU0rGYBrpiqPQ9wzpppUzV95t7hW+8E8ePmPM
	 ohTZJKee6CKzmaZIj68l7y3BgX3ykkoZNxeD+gLveulJXcGkgjOCVrHKOqz6bp63iG
	 WVBK6eF3TrCFA==
Message-ID: <sashiko-outbox-179805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 2/5] perf/x86/amd/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021050711.4043703-3-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 05:31:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Sandipan Das <sandipan.das@amd.com>
>=20
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021050711.4043=
703-1-dapeng1.mi@linux.intel.com?part=3D2

