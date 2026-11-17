Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873962;
	b=0/vN9LjJH5tja7JMYAaWu3EZRzvcSlKxWmXWCMOXCgpt+cLcjh7RNdioCtogwacdBgtQ
	 fhp3Se0r7UqM1iU/dgEWtYkY7FFp+wOf7nfMMhKfRFb73s+x0yJhdJHdkdIot/GtlJdmq
	 UL5GNklwPhD6NbzwEwvzHfYfyhWgbkkewzVBkaW7/hOdHqmasV9SKCMpGoJO5h/vDnI9E
	 oRYA+/9LY5X5dnlC8AyQDiPkb/Fc/yLOLmJmE9jpJ+BkvEP6P6AhYTvdqvcRi0Fhj0yOn
	 ySg2G2w2L9kepAUiL3Zicwjr6dBJ3NcdqdeRUCorhZ06oEqrzJ4L5g35cElWeywKIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BbVQ26f4+oliR9JfKmP6T1McAVneoU5Viuas5Ip7tSs=;
	b=CXsmeSKV1+HvGomzGnIFRqrKAtGvKY2xJ8lHxfokTo3PoOYjad4QlN89O+zXgmDogFqc
	 GEZMlfTboggcXzabqOdW/9peufV9fIOKE0iSkQ27L/oMCp+9KiW1zOEMAc+4a6aWzg6Gz
	 FP9VhHM77LhJN3DE/qr7Ve96PrL+1IBFwdJe6dBOUecpQ2rf2bxLHCBXUzViLf1H3mEwc
	 7X0MCtY0kwCOi/6ZbdiAgg8bDfitaXpQUYVe4homquXkRKhov+B4wGysIqx1G3wgJH1bk
	 BX5U9vALVzw0nxor4pTWVQOZlhBi5Dh5CDOQ75qedELDmPQOzYB6Bm3x3uxpJ1zoyCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5vhSZin;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D243606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5vhSZin
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ADC1F000C4;
	Tue, 17 Nov 2026 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873961;
	bh=BbVQ26f4+oliR9JfKmP6T1McAVneoU5Viuas5Ip7tSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5vhSZincscvBdU6q2Nhe33niofEXvYwyhZMmKknJON1zl3pYBvJpyfPckNFmKjv3
	 Mk6fp72z3vtrqxFydGFk50Pi+pDVtwtT2oiwvDbTIhu7Zphu18lJN80NhT1h1t3sa5
	 TT13BTliwS+ZTWxNWNkTg/GJslRrp/x2bqP7XQFXNA7ngheqZKTVUSBFL4Y8iOnYCp
	 a3m+9YgdgDP/7EWLUGD+OeGzYevb9GHn+EnEH9V22Is06WXp/DbonCUW9k2rNUoML6
	 dzaoZG9RjR1QfWBs7IftsA6K734YQl+kV8hFKMrfkk3ilU3gitUic12SmsiyTVfbwV
	 N0XIZVorbNfOA==
Message-ID: <sashiko-outbox-217975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/12] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-11-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:06:01 +0000
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
> The record this check uses writes aux samples, and with the single data
> page the other tests ask for they are lost:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> so no branches are decoded and the check fails with "Failed with virtual
> lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
> decodes 64 branches and still fits the mlock budget.
>=20
> Require the python perf module to provide session, not just to be
> importable: a perf whose python bindings are not found can pick up an
> unrelated module and fail with
>=20
>   Error processing events: module 'perf' has no attribute 'session'
>=20
> instead of skipping the subtest.
>=20
> Detected building perf on fedora:44 on the runner with Intel PT hardware,
> where the subtest failed with "Failed with virtual lbr" in the container,
> and with the python error when run as root on the same machine.
>=20
> Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D10

