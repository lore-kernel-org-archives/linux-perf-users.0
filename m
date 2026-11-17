Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884590;
	b=J9UPcOdiivJJzynPhpf0sLnQgvrkC98uiSPG8O9PLXxR2CAkEHngssY43LkQ4Do6MFJs
	 qi3iZ62IvyZsihZmup4csZjGWlPaeNN5uIcwJWnVXESCO3sO3+ElOal4EDJrveMSCr5jX
	 fAvQpqalTRtVm5m/nBB14VsCSJNhvqj0DulBar7KMds5lyue2uQz0RajZUe6D/yAuHSI5
	 JG/RpwlYuADWr3VKDaVn9wCmCKPBykHKS1Ycaro3MzRPlnbax8a357oLnRcGPoz5oboyt
	 h+xJNVTBmW0u2MPxqAnVztwYGUebBocag92FH3ri9e9+Ag2qqWJxMd+Dy7NvvZze0hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wvRMg5GPMLgniDAHMY6AmqSG+NrRnQuk/Oltz4R6rYw=;
	b=UqXKuO55MK+cNupeiRPClnU08Yl3K/dHzNMHdbqbTy7rzAHZr7jZCq7KSlNcs2HGXG3Z
	 jFM8fBcwZVuL4++B/PknTQ5ekJpT9NGB9vQP+znubfLlJ43co0ET+4BZWKD4YkvePKU0s
	 XEMhkJ6nTWZi7PLGOZ37yiThtXZ98u4QPIkABpQH3nIj1Rvs7yuUCLC79IrI/ladLoiFy
	 c0sulS5Md4bE7boRPId7tNGikGVigaATE1vrKGeZBPgEF5OYLjccMg4qdesGj4qQpsFvW
	 XPldtGx12HdRs3sgTUOVxdjZ6hCLFcQNceBpOPwoFHKFabZWhq6zZhYytufEYyzDUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKGJb8rb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B3606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKGJb8rb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC491F000C4;
	Tue, 17 Nov 2026 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884590;
	bh=wvRMg5GPMLgniDAHMY6AmqSG+NrRnQuk/Oltz4R6rYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKGJb8rbGiFjLLkWHog78Z5EKzOlpnrfhpXrdKQqjLs6wBEVj6fBzPEaq+Kjd6dJD
	 CLfSJ9RC4RFcfH+oUdfEoEcA2A4ETDvJH5Kb0fYWF+8pF6M4tir5Hej4vbfD9o1dWg
	 mqgJFca4ZhCPKkEkYLG4+1V4uSH0VPrzAdoUcX3DRP7ey5r6NBDFk2z6g68xWg1agk
	 S7e5JRNp7yNi/Jd8WSba7tymP6drwwS5hJ0E1bjpw4RAg56L+6Cfw97jWyFnhLd7CR
	 AdX1ft86Ss4esR6RgY6SUvhLmvotkHrSWG7+hYdtpqrRu4fS99Y/4lWaodeWbGORX6
	 fnGqKgpXrpuQg==
Message-ID: <sashiko-outbox-218113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/12] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-5-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:03:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member.  The test skips
> on 32-bit PIE builds, which load globals through the GOT.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D4

