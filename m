Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793429277;
	b=pKdGHeteqhQujZ0szdg0HcBWzaa7U/jrZperl6UAthRj2+Umh+0JxMUL/hD2iZuHHkFb
	 fIrtibQsRFh290O7Zgv7rWp88rC85Lon6M6/4+QrHCRXrfh4XsJq652Ob8mX+q1TINZer
	 Tb0JLRvDwox5uUYOOvp1/1uXMuEBfnmYkKJZ6GupfglSHRhYt2UoWFipHxXBtvOc+SDfP
	 cBLFVaX66ii2o5liRc1NyqkZp9+Ndps10J5gFZKATKXPpTEb/4jSchxvzfqYpFnnQs3Xo
	 LG/0PJBpF1PckRpBM7Hhzv94HndAzB8wjFI87Qoypy2KeVCXYYK9UMBIMyOEIzGIjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793429277;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h95MhR9alvhdxilcOEZ8piXsFg81gn9JoSoPeFkZVyM=;
	b=XTX8OKPf2456iRfcEREUvqpV2awXxr3Oeu4QpSFPahCs0bDyFwgQ75TIqPPmEO6tU3d7
	 Onviqs71OkVTAKhJt89mxeSQiHlqqXeASz2wUz47R6zLazoBAg7EGI+NL7nuog6AVG2Ub
	 E1AkDevJSTW/2KtaD9H+vV4lucztxEmdxExMHXcFit9xVOdj1M+Tfe+KM1WePP7aEcghl
	 LHNtDdMggTLUuL+akcR+0PK81Bg8bWDvjFQ6pn34DboFTdB90DEIqhMg0fSn1M2jWYoJS
	 L3XZ87hUkixUWGih+cNzXsZa6bwNlhMapG/48nc5L37SPcfAcij9lkwjxCPIHEwu4UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alZXnmZF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C0606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alZXnmZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDECF1F000C1;
	Sat, 31 Oct 2026 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793429277;
	bh=h95MhR9alvhdxilcOEZ8piXsFg81gn9JoSoPeFkZVyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=alZXnmZFdbeVaO8uVmWYmNRRFu+kGPmHCq6R1Tmr4szcfnpeibQE2uGxlFaTbSbdH
	 I54Xx7PUmFxBUwlcwSQGdfOpJwAB6wvBtbbQF+JmchGsQBrNq9HmSom4BoeQyADNEv
	 t/UeWorUTamaPR661OPxH+/1NtNU6b+GfBsnlXKsJNNzNFd+aI2YIcYBeDv3D8Id6z
	 PE6p5rY+bxyBE/uTYryZ0usu4wLPoA/3PDbSreBvpxdYUHcp+RE+JplWihdBzBveZk
	 VNuAFFiHjijKv+36eIe94gf3dgreaZzExPC/OogOE6EuY2XbA5hzZ1hBGjRMGzxIeO
	 uo+r6elc7UPeQ==
Message-ID: <sashiko-outbox-191788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf annotate: Fix block_range symbol loss on split
 and leaks on exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261031063549.1281324-4-irogers@google.com>
References: <20261031063549.1281324-1-irogers@google.com>
 <20261031063549.1281324-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 06:47:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When block_range__create() splits an existing struct block_range entry
> into a leading head range (entry->start < start) or a trailing tail
> range (end < entry->end), it copies coverage and branch statistics from
> the original entry into head/tail, but omits .sym =3D entry->sym. Because
> the returned iterator only spans [start, end], process_basic_block()
> never revisits the split-off head or tail range, leaving its .sym NULL
> and causing block_range__coverage() to return -1 on instructions in that
> split range.
>=20
> Additionally, the global block_ranges rbtree is never freed on exit from
> cmd_annotate(), and process_branch_stack() frees the resolved
> branch_info array without calling addr_map_symbol__exit() on bi[i].to
> and bi[i].from, leaking thread and map references acquired by
> sample__resolve_bstack().
>=20
> Preserve .sym =3D entry->sym when splitting head and tail in
> block_range__create(), add block_ranges__exit() and call it from
> cmd_annotate(), and release bi[i].to and bi[i].from in
> process_branch_stack().
>=20
> Fixes: 70fbe0574558 ("perf annotate: Add branch stack / basic block")
> Fixes: bffb5b0c0976 ("perf map/maps/thread: Changes to reference counting=
")
> Suggested-by: Alireza Haghdoost <haghdoost@uber.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031063549.1281=
324-1-irogers@google.com?part=3D3

