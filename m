Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427893;
	b=OGYQm7MbBPqcWhCV183voqZFfTwNzvEBqi7iPX8U7wKM2ABTp+2UCYLw0IXoHui+K2G1
	 e4YCwtchBvDWrzoNh3rxN4slQ8m9OfOtzlQkmCqAagNOSyRnzxSKI6B36+Rr/24LVe7vC
	 EM7MsFA7TLTfKb1STzj0erHycQwxlA2XbhhXqSNiYKFASz+I60P+qaw3dVg6cei02dSyT
	 yOk2UDeM73dgZInvjJcM1axabIrgHWfQIAw4JRGiJj5nz+U/DgflskqFVanahPGImb7Mr
	 RpOHC+FnporH+3U226pUTIi+y9/IzWHRT+2wnKITGtrihczoc7x50xWxzGQ8AJPjtHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5/njl6c8h3BcypnpWlm9oLPqhst+7U5d9QjWg0Jd1Mo=;
	b=5TpN+vVsO15igAdbQF3qgQMB2tvHVv6triV7Or0zwBtNua31eaOZ4+kK95Lei9gwy9gw
	 cXZ1/O42Go9pwaDfSaaq2qDuVuKYPDxEtfuzbxNf4a6hLH+fSKzT2VoOlL+zjKfl6gw6c
	 Jgoh0HPBPu7aOne5uf1TeK1SUdCWptFTH5zC8s9g8D5f71BtIYxbZZkrufSzjjjkmimDS
	 aE6RVVmYdHs3uIumiuCkAukDUdJsrkoyblxKJ0wWCoZvB+55fbD+JABt79FgRcea9yHK0
	 DIbyLWgjIViD+1d/oKJEff54QsG1fPTPez1zoKGfYrONtRmfcQ4i0WNfQJ6edJMwxqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpK6UhLT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CD606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpK6UhLT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B981F00A05;
	Wed, 11 Nov 2026 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427893;
	bh=5/njl6c8h3BcypnpWlm9oLPqhst+7U5d9QjWg0Jd1Mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpK6UhLT/6hCnoUwvk5H7vleJT8EhJDGqOEv9p8l8TbX8pMQJlxVRnvBTY+BnX9i9
	 ZvmvR/o+tFH/n9Bpvf13+RPZ2FL3HHSRxITsqE9GokctfllMG39NCysnOiHexViIdq
	 0ThPWgOi3EoeATkMDaUNsATiW7ubVb/LgzdFglKSat9IjVmF8vijEkgyrd6EGBMAqQ
	 Pn2dSjyAQRQHkzNe/jU5WMpDgb5llb/EnaI2AE9mVDsI3QVerJiqW+VB8ryhQhEK/h
	 inAX9plAU0KUZ0FQxaqhlbEhP019Mr9myxOBUQTjFEs1OyRl91RbOj3/VkuqAJuRQH
	 dCYj5ldbos5uA==
Message-ID: <sashiko-outbox-209616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/20] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-10-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:11:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D9

