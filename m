Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607491;
	b=BQaVeAWJ29362KSN9pyv3Ys7P0Xr+0RKi2oEowPJOkhCtJ69nWr0PEnCvrC8AHEQtQGj
	 UD78p9dn219GpUHEerV93PiP8NqR3Q+6mYWh6G2VFbWxyQbIqngWGQc7FZ3YfsJ5G0n3+
	 EGRdcgFthFjI6VCkmhUzsm4HPgiLqtlKnBXWIDSBkXupfYpmsHUqRF7AUbwnAjiR3cQCa
	 W4+YS/MonJEZ0pjJZ3HfeqV/KTppm14VKzKxtcut4eT6qCtElJsLyKeCOpYRP27MHfPoy
	 o54cHImGYAtEmI4vb/QpupsC+/HIEDkiUsAZH4cARBsEEDq2qOKPle7n5NHVzqGuDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607491;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WC40OhXHcTS9h9XoMS3y9JEi4829qp5KuMFj+LXw3OM=;
	b=nKXt7t/3KcylMoVDMyhZmjV7BfvMIHlRqK9W2WOMpgpPyXGsn99DTa4Cq2qe+H4Nqr8C
	 SAuX5MaHPUnH9Ky+leKOLVRI1bgfQFAjHcZBFU1zFKMrc6I8H65EL4ft7uXcnGW8uaY5T
	 kJX2cCpwpEi2xFgAuP3dhNzDyeht+Rm/No9RacBUV/qJNdPsVFjmynkGeOgRmeMG1EgA4
	 5FGUPe/RwitCeYRwq2dio7h+Vn+6L0PXimqAkRJGlOzACjQHaKRaetXxhqM012TG8Vc/Y
	 pIHuFFREKH/woqxbbXSmIHrrASa1fspA+BxuBBMcLUP9Ot0GXaKvrEhx9u3J/UbgPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcK5Zx6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C22606A33B
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcK5Zx6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F741F000CD;
	Fri, 13 Nov 2026 22:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607491;
	bh=WC40OhXHcTS9h9XoMS3y9JEi4829qp5KuMFj+LXw3OM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BcK5Zx6UE360Rn442TvCJPI2w7/pcYhe/XRrQLT4toN6opXtBupxiHZsFC5vb9WIh
	 nzs17yv7a8FwW+hgvm7+gvP0zM6oUyp4+L/iK1xpj+aWaPvRbEJ9ghvbf48qNpEs4x
	 XQOa7K7/9MeWcJxXg+3iAkJbmFgmkhhwGhmk3ON2PbRZf/Eaca0QIc/1m122PfGWkF
	 TA74V/aEjXhdnPZO90ngX6T9JcnpKiseCKpvjP6Mxm7iEtYbZiq8+U6qZ5rwEld0M7
	 QOAqeIDSr6KjJqA9gLUHB/tkQamLHgpullbfqt1Ry5sWhnjJodCZ+XgysWCaWlqC81
	 0z81CiBYKRZzw==
Message-ID: <sashiko-outbox-213772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/26] perf trace: Use generic hashmap for
 syscall_stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-12-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:04:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert trace and thread_trace syscall_stats maps in builtin-trace.c to
> DECLARE_HASHMAP(syscall_stats_map, long, struct syscall_stats *) and
> replace direct struct hashmap_entry and map->sz accesses with
> hashmap__for_each() and hashmap__size().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D11

