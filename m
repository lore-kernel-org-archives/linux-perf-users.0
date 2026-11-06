Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949308;
	b=oCPnIv6lIovYcRxOEGpKMLIaumo69kuoKvI6Kb2jHGDJqrXTPBsTWXZt9wyHxkjJY6mt
	 85Ehw88v9qmY1yrxEAd/dByQq/AJoytAttfBCF0PeDmJPHHDenvyJxAG4VtcuCvDGwOfB
	 xlm9OduTqAXYCjYyNPA8XLkQ3mZR8tttXf/qb5bU0vs5zexEiSCFkLBskg7pQpQyiZCY+
	 HqlMfMn1qKYQf0pUCVQ+cNLefi59M5CYTt2P7pjoBr+c83NL/IK1BT/SHgFOGLCsnWzzT
	 9E1HqFNGXBLWLliODfBIdhD9Zb5lUTM0wbUNCvGPEGMu+yfDc+++8Jw3ydEXGCHH0Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z0IejGJrkRhOOfVbbW65UQnqOh6d5kEY7KIQkpAhTRs=;
	b=TJyqRQD/eOBVfwiQ6C0lnuGcII2GKHPMn23qvQJHxRS8jLdiiVtX7HQBVLJDBKBkY56u
	 CVNfpwa4dbxXWg0/RB7CBsxNHvs9NO2Ge+QQlyEW2xUah1568TOI/JXtlUkhC7udt6gca
	 H/7sPNUkMfLsmsgwNZqS9JmvmC2TcmwAKVl+3P66IUGpjwfse4Lt/930NOHcWes7c6qbR
	 iFiviGS1sdUcfP3g8zPWI5Z22oyBhsJvKoqTKYp4ji5rK5GZaP9OzuWCwTpyufkpB4RP1
	 plV1vd4Ry4YP5Tw3Qgvq/hK+M+3Tja/aqP5MD1YRC7FmKnZxhForIjOnDxS4sPHRNqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKr6awjT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37E606A33D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKr6awjT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649881F008A1;
	Fri,  6 Nov 2026 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949307;
	bh=z0IejGJrkRhOOfVbbW65UQnqOh6d5kEY7KIQkpAhTRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKr6awjTY3t6Ja3RMx0IJtl9vRGV3udcmDKBNt3wvb4gSQRGdJOfihpbkqLhfVNgA
	 bPkZMOXc+svjxD4c+HZ54GK9r3e5ujXhaHVRw7gAbnwA3WR2MxPTy9TillBibj017K
	 Mgp6DmunzT/P/Fkv9xEOkPsQuHQ41QQAIi6W1jfh10jysNcT/8IWAe9RyIMQl0y9AW
	 JCzZp8XXqg/C7pxfV70QQBRfSiZ5Gh/1h8BPuTDaw3JR5N9kydL2q0QXNoNI+I3F5+
	 zjmz78R8Gol6hkarMIfwVcKPs5URTXap9YXYXXJ4c6znXxv865hHseGiVGF5anKZw9
	 waV/gS8hM4BbQ==
Message-ID: <sashiko-outbox-200980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/20] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-18-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:15:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D17

