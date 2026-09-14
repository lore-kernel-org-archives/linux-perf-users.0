Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5482DF13F
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350107; cv=none; b=npKcJeSxkXQlB8lS4zWEBFgpTaxcgp/jo0vSBJB5ez/byP96JU6AZNgMAb76/KffnZYWnhYVJ2diAks4Q390/cbC5UiWu/+c5jLXA8smBMiD25BKflFPG6ex2bacDbBADZJbNOYBPKLLPWdOWKiLzwbOrfrM8lpw3v0LlgqybTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350107; c=relaxed/simple;
	bh=t8i08w+Epw2s/yDcJEz4/RrQs4kadeq0T/Rmxxd6Q/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AOwZIB7LTzJi8gDkNYXaaibDM+GCv6/U0GvbcDVgA0q3QUkBngAqd7x87XjS+kxa6SpEWVu+NAXHbvand4g+tC5+BAQpgWYx4b0XpxcRzk496XeHulWcf1vu12FaoNroN7EGn/GEpLMzckj51Z7wTnAOA9RW5ju9xkNcXvxBdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKkuoQkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKkuoQkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE481F000FF;
	Mon, 14 Sep 2026 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350105;
	bh=HGXSdwOcyeC8NZykOcaeY3pv3ON8xcatkU8FqCaDo8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKkuoQkpejoefUwX1Lxnt8y28pzQFobS6CtVm6R32sO6r2b+yussjdECAFEAXqpIO
	 GA8Sb4dhDhKNq2WIb/iJWm26+yr9HmIfJDxKURwZmdkKPD2IEDm5iZyDEVAN/tiLhw
	 ISg+kQTXgivemrPhQP3wRyQQKpBTE+2qQiArvVRJV4mU6RfjXRk0t8KytWeiQapv1J
	 RFseUCFfTKWv4yTI6aKVa8sKlq4xieRPhcIv64KeunQkTcy2wxkhuhVCuRzcj4eaWn
	 xlZeHagHQK00z4xYJ1wcflIj4D/yywSARw6amWjElQ4HYzTkHRNamqMH1E0STKJiJh
	 wL0e8uBJJhUfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-2-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:41:45 +0000
Message-Id: <20260914014145.8DE481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The test records with 'perf mem record' in per-thread mode and its only
> guard matches one specific message:
>=20
>   perf mem record -o /dev/null -- true 2>&1 | \
>         grep -q "failed: no PMU supports the memory events" && exit 2
>=20
> A PMU that has memory events but refuses them per-thread falls through
> it, and AMD IBS does:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
> [ ... ]
>   Pipe C perf annotate test
>   Pipe annotate [Failed: perf record]
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D1

