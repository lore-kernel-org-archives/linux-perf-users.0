Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C913B71C0
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364402; cv=none; b=rDj4D4Zys4lHQP+ILO8oEZdLm7FFb6qE8zszD1nPCXvJU1dBVIarDtjx0LAr3Vl11wc77o5+WRbQzrf39sextkccWc2yfii4+xPr3Jmvvtb2gbnnOVCvIinAOLuEvg9q01KnCT7pbSuqQQXpxqi2jUGxN+YoElC/gE6qkCB2xGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364402; c=relaxed/simple;
	bh=MUjsRx/AZFHaoC22cb8DvY60+adwzS1GeUA1X6OXUgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpxK5PHbM8piUULgpRYI7nqP2uFgpdK4bThjkCI7AJMDNIyM1ZPWxjdGPNkHNec3r8EK/LYWfsgDB1ib662Svk5Uxq7oBQLYg9OIKBQUBEbspoOMDducH7yc+wt4LJJAqXsRiWboYjgpxN6uklTNWHqW6V/cpVQsbZazG8/fRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwqbfOp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwqbfOp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D91F000FF;
	Fri, 25 Sep 2026 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364400;
	bh=MUjsRx/AZFHaoC22cb8DvY60+adwzS1GeUA1X6OXUgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwqbfOp0xtj6t4g42Fwg7TpZwdA/G/KkW8ctfZgVApikjcz+34TdEXvgFQeeWZJQK
	 RsP6At6RNrRiCHooCiIvKLtg5Am5uLOguj6I+x6jARPp1zOKCZHsDBte/Dy3ponoAE
	 Rwspnzv1/wgp9HmnL79lv2LVxbLD8rDM3WhhILiYRgWhv5d/WZ8DyzEtokAlj+SWrA
	 F6T3XoCQcVZ3VHIlIVCxaYuDq3hvctflPcvwoI8bafLtufjno+cV+zlLEmiea3l6pN
	 8YMEAG9/+Shsmr/o7mwjltbM6CizFyxXdytyO5ib05rsQ5L7SVmRHs9nI+YfU8HocQ
	 OkKw+TDzwn5zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] perf test: Test lazy symbol loading and symbol
 memory limits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925-perf-symbol-memory-send-v3-6-3e4e234c363b@uber.com>
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-6-3e4e234c363b@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:26:39 +0000
Message-Id: <20260925192640.498D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Add a perf script shell test for --lazy-load-symbols and
> --max-symbol-bytes.
>=20
> Record a small callchain fixture, require evidence that the controlled
> perf DSO built an on-demand index, and compare only extracted occurrences
> of the controlled test_loop symbol. This avoids coupling the test to
> addresses, diagnostics, or architecture-specific symbols for which the
> eager and lazy loaders have documented differences.
>=20
> Derive the constrained lazy budget from the unlimited run's
> index-reservation peak. This gives a deterministic boundary where the
> index fits and later materialization reaches the limit. Also verify eager
> limiting, malformed size rejection, and one-time warning behavior.
> [ ... ]
> function section is NOBITS in the debug file and has no PT_LOAD in the
> runtime file, so both loaders must fall back to the runtime section
> header.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-perf-symbo=
l-memory-send-v3-0-3e4e234c363b@uber.com?part=3D6

