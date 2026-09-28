Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC946C4BD
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582552; cv=none; b=QYZdTwMnrQmJM4Mk9nQhuEhSqdP4W5zQjF8L7EX2lONP7H0j37PDIbg6ydg/5SSUhiKHTfcAY+vaNjThMuRqOuaMyOYR/OkaNWREW5mW/fABrm4yWPYWCBYrsPZlPkYaD+s3OGqu6fmMh9O5SuRvoCwOhwJc5J5breUChhDzhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582552; c=relaxed/simple;
	bh=d2ELdT1bUVQiAvfPNCffQmpOcYX0vDRK5iyF5GnS154=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dUl0xwsw1QxSV2pLonra+ge8o75sRJSr2m8UMAp6enreg6jalZu+lmgwPO9K/8UhmJKbYmruz49D9yy5xLzK7wAuFgea/ktgAhR2K6C22aC3sZPuQLuwwEkzoZaU9AEBtLYEd01qFEIrrQcm8M8nppXix/eRcoPkLHHl3QVJkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8s/XAY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8s/XAY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03881F000FF;
	Mon, 28 Sep 2026 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582543;
	bh=2QNyj4Dl5WOmgsSi0sRZWeyoh+c4XNh/gGUh8SDZdWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8s/XAY9vJEfh2w8+LapvLt7Nqnvdrab24BSEdSi3H1vFm1KJ810v0690la/pmK+L
	 38WhCceIUGXXIIVc4/bPkilC5X6WB0mBTMnDEF/PgKPcSKxw4i9j5awaWFRqKt9Lkw
	 LEwS9yoFcQr5e/Ri2LeyKSjCcoROFOSjC4oxi0DpSdc2CXj7XW3pN7gy9sQHTMt1Sc
	 PCG6fF7c8fAsH4UWqT3ELMvxNfVr2K9/cqI13b5bkxlSPqG9Mj3lO1J8yBtZTLiUGL
	 SmH3dfFLvhMz78sH6+TDlBI85cENWrpGYm788fjS8lZ2/nXAWt9QBs3gvdnWRvFi8U
	 kNVJSK1bIiJPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] perf/x86/intel: Fix stale PEBS count without
 counter-group support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-9-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:02:23 +0000
Message-Id: <20260928080223.B03881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On platforms without PEBS counter-group support (for example, Sapphire
> Rapids), PEBS group read samples can report mismatched counts between the
> precise event and its sibling, e.g.,
>=20
> $ perf record -e \
>  '{cpu/instructions,period=3D100000/pu,cpu/instructions/u}:S' -- sleep 1
>=20
> The invalid event counts are seen,
>=20
> 1st PEBS record:
> .... group nr 2
> ..... id 0000000000006189, value 0000000000000000, lost 0
> ..... id 0000000000006269, value 00000000000186c1, lost 0
>=20
> 2nd PEBS record:
> [ ... ]
> perf_event_output()/perf_event_overflow(), matching the non-PEBS ordering
> in handle_pmi_common(), so group reads report correct PEBS event counts.
>=20
> Fixes: 3c00ed344cef ("perf/x86/intel/ds: Factor out functions for PEBS re=
cords processing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D8

