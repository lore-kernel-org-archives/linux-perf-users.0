Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503B372EC0
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267485; cv=none; b=sji57arx/yVJDZMQ5t5+ZiEJ6pfpFZkbBII7TM/E6IQpnl0LMOhhviaicuJU8GssHZeK3HDEYZJXUMNu5MDDErR+uDayVq1LNjhPMA6KaXdKQm723UNuyGJiJVZmeaOz77RcDjknGvQPCVg2CNub41bMmRaIbZLRfqjg24vQopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267485; c=relaxed/simple;
	bh=HORQz/kgMWqONj0JROVqFNYg11G7IKdjBD6LxbuKpNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPZsz07BJ3Hr2Nok8R6dH9e14Exgog50rRAdm/8JB+AoJk5+KsudLDUJBgv+aSesQSDw3aTqOcpts7h0yAa/tld74iakqrCPHTz+mb7267IfHAYlq/k6QWvC2enETv3QmBzwnhHp/4UCgx0CClQmmBFC3VtPJqP+ezMIhWEpKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACvcf5dR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACvcf5dR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE281F000FF;
	Sun, 13 Sep 2026 02:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267484;
	bh=mHK8KIdYGV5hsItniCJ1MnvFsxj5mgB2Irbimqj+pow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ACvcf5dR2aARKGylJeKVi1UlJ9FkJLFirizyjbykJ0gE9FODptJ5Yn6Oobhr41SkK
	 G5t1UQk0or2So2Ns/JtIty0KmH2k+OUtuKmXq1nLKdYKx9rpmy6rceKCtB0ydxXxbD
	 EFgcCX0XHvxDgrpB7ly2gAeLxumwx9gRouWhaAWVjSvPR2+GDcShHEkQZ09EwtS4ki
	 7hcrkAY3Z8T6YghcAHZ6hVQZsvBp3OXWYETZ0Zj36Di7IAvWrJAZr3Ej77wl1sW1H6
	 0E9TaLf3cveWe1YXqrvNEjIjeUrR0+zrlxTDbx3R/UuXupOM7yEkBybkLVgeX7UZDH
	 qs6c2hOoYbwKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/8] perf annotate-data: Resolve type DIEs in the
 debug file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-8-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:44:44 +0000
Message-Id: <20260913024444.9AE281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A 'perf report -s type' on a 783 MB AMD IBS data type profiling session
> hangs, burning all of a CPU and producing no output:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf report --progress -s type=
 -i perf.data.ibs > /dev/null
>   Processing events... [100.0%] 746M / 746M
>   Merging related events... [ 58.0%] 293828 / 506686
>   Merging related events... [ 59.0%] 298894 / 506686
>   Merging related events... [ 60.0%] 303960 / 506686
>   Merging related events... [ 61.0%] 309026 / 506686
>   [ ... nothing else, ever ... ]
>=20
> It is a spin and not a slow path: with perf-stuck the CPU time used
> grows by a whole interval on every sample, while the [stack] mapping,
> [ ... ]
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D7

