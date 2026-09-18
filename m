Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA197498915
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767059; cv=none; b=OO9k0FfpxBT2oXDoAaJdeMj1XKkVR2TTM5xn9f35TxJbtIYPbEw/rV8QUf64gU50FuCCJiiCjGg/XH47hMa5yoVWx+eAA4jweSwGRicSRryJUYCdOJQwd/rHkamS9Rwcd/sAVacIYoNjjNEQ4UrenuUi2Pr7mDRlfutKfPNs0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767059; c=relaxed/simple;
	bh=v6RtW61J9+5CnZdZ57GYFj8BjNElfwD6QcTz+AUTNEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4h4ZmSr/HAXppLtxRG+8FHL9/Y1lwuHzv9s7laI+gnzhd5uyUuowqvyxeQZRICBsqodwW7Y/pEIR+nX6EN2rfifPSoFqpEuGm8i5F2n5vI9t5CaTjw8VvDA0xZN0viOwr1BtN9+tKOOMUmlbT1yDgRTRpmUM4bamvV4I7IeDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZvU32Nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZvU32Nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5371F000FF;
	Fri, 18 Sep 2026 21:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767058;
	bh=PNpYdeQouxFzB50DM+iAPbKVOQ+VF5Ml10yxcC6m/Wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZvU32Nu4E9BdmvxqcxQJEgRyHNc7xlBi3m5vLd5dJ9L3aWCPPjKu547/ae0EAQww
	 k6K0FRM7V53jk6enEx6GcRYCiAHWYIvtOX1GT2sPbJjlgU0HHVd/7xk+lU1BE6/kPC
	 MU6smFQWaJHojUA6k87qrT6dPTFBDpYZOJLPZF4B39xmVEnuQSoIJ1l+Ws5sFEnwNI
	 kJbOzCwTINP5sSzn9FiQJ+wcEohCh+Te6t89QvufwncyRiwnBgFjhMOaujUYmEIz9r
	 2rSHYuyss3YzSIEii42QHS8PkeP0bypjfyo8SzM8CwlztBFaKKbKnUht9bsBGUcsw6
	 +r2rRfkY2YTOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/18] perf evsel: Report an allocation failure as
 ENOMEM when setting filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-4-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:30:58 +0000
Message-Id: <20260918213058.7D5371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> evsel__set_filter() and evsel__append_filter() return -1 when the strdup()
> or asprintf() that builds the new filter string fails, and
> evlist__set_tp_filter() and evlist__append_tp_filter() do the same when
> handed the NULL that asprintf__tp_filter_pids() returns for the same
> reason. In every case the only thing that can have gone wrong is an
> allocation.
>=20
> Callers all test the result with "< 0" or for being non-zero, so -1 has
> been as good as any other error so far, but it is not an errno and so
> cannot be printed as one. A caller that does, such as
>=20
> 	str_error_r(-err, errbuf, sizeof(errbuf))
>=20
> turns it into EPERM and reports a failure to allocate as "Operation not
> permitted", which is no help to anyone trying to work out what happened.
>=20
> Return -ENOMEM instead, which is what these failures are.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D3

