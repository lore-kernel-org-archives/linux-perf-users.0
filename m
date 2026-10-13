Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954543DCDBF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930224; cv=none; b=EVADqMAPU+VvUZgJZk9Mc2EwHXZQ4LPcQReSwUv8athlruvL/oV6NqlngWuB9kt8M/4qE2e1opfztRm1krAAoADPJ+5RD1E0TvzAic7nnbAlfoqPmf/tjGA0TRQWX2ton8UHrMYZ2lUNqbfc/zny5vgRIBzuv0i4ja9Mz45VNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930224; c=relaxed/simple;
	bh=3Oxgcefb6VpPLGxFhUZ8qM+qrByfbz1mMpcAGBE28cw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eQjMzW1H2zaDKDe11NiNmN77WE9IVH3XCmG7oKuPKFDUYGRfnl/YxpbwCvL59N+709CDgel8CpMaeVWJRUFiMZDsc9cImYlZv4MLo8WYfpUFAXBiBv5F3pqNCTpNOrHzFTGAbllsh8LNJ1Bz+5gyPFpoSFpEVU5uc+AcQxfxkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvH86MAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvH86MAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205841F000FF;
	Tue, 13 Oct 2026 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930223;
	bh=3Oxgcefb6VpPLGxFhUZ8qM+qrByfbz1mMpcAGBE28cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvH86MARAUfhnxJrgkyc3yG2uYx4LFihFALaLQJ5isc4QTbLJb6My9gVGM7lAV2uc
	 Qm4OOFnZEBiFGoXyvPQ8MlTPn1cob+JMAzeawUHoSsqmU8nGDZ8HCZGcQy1HJ4Esx0
	 raV5gtXzcGyLGycy7vKqtn44+Lh8LSMSDgv00EmlYVcJHcOvSKX6zf18FgCJTA4b1x
	 bZTCr3Kar6ScDNkbsZmMIFqhKqbS7IkPQz3NAsQ6v6vSeGoFePsafZcHZNDykYFlEv
	 QRFl+eXWb1plaYOBVkY2woILdOrnRQDtoK+N84oW/PkjQ41/Zdpi2XMKfTDubl3w2l
	 IgvZ8aWA8zKQw==
Message-ID: <sashiko-outbox-170574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf test make: Add BPF skeleton build tests for
 clang and bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013221643.1815686-3-irogers@google.com>
References: <20261013221643.1815686-1-irogers@google.com>
 <20261013221643.1815686-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:23:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add make_bpf_skel_clang (CLANG=3Dclang BPF_GCC=3D) and make_bpf_skel_bpf_=
gcc
> (BPF_GCC=3Dbpf-gcc CLANG=3D) targets to tools/perf/tests/make when the
> corresponding compiler and BPF skeleton dependencies are available on
> the host. Verify with 'perf check -q feature bpf_skeletons' that BPF
> skeleton support is enabled for both targets and disabled for
> make_no_bpf_skel.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013221643.1815=
686-1-irogers@google.com?part=3D2

