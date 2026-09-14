Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA534718CC
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391922; cv=none; b=BDlmrUdJKUjlaEBQLgLa0cUDFIGkeAEIzPRJ9JxIUPrQ0WqGy6CWbnVBPXHVD0Z46lpGxBn1k+dQhqqudP4xiMhsgdGEFnEY1NmtN+QCRn2y2hOq6jzI6ibknRuyIQKlLgK7+1RfJeaVk/jS5bsUlE0aMy2OlA6lFtbDKU1U4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391922; c=relaxed/simple;
	bh=6yZ3CHEQEVrQ2XFRUX7AWwCqzgMTh2RBZxfkQ7UG8gw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3CKDj8ceGfSgCdn1IqYOt2lIMX+gUv5IZz2aroiupvK7qicqBnXDqFs7syt8jdxpRYDk9kUThcMLe3HhVh0AgnYkUNB5ZhMclI/92TqIoGDx1STnhI7qK64PuPIpSCOUUXM/v1Qe5kupfiwziOg2hJPoN0hBZcD/Yx+O86PTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZb2H4q4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZb2H4q4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE25A1F000FF;
	Mon, 14 Sep 2026 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789391921;
	bh=zKLZ+gACH4abMd8vj+t0xgfXz/6LTM8e2YN8Uc0ujz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZb2H4q47kVyDaBnocEpS5Box/s8g4NNQwn7UHC2RRy8bBPYRvuaOfvNmwure9r26
	 eK2mpa/Mo8JBiQ90xoVGDGAaaSt4X6bMrQJTPUeWeTh/MhKE4SiiMy/ARjnE49QhM+
	 J9Va1vttlhHtxFw0U/ciff/S0slmKhGMkoS56dtHArnqfywi2a50VRe6bVBs0wC+xu
	 R40EeIvGAKc58XMf+Up4c5TqPKUuIYYv+VHBFUKmL8c6PiOJ59KLvduNET78sLnEXN
	 Y3ICEQEL+qlKDPYO3pNUj0QaQpFWOzDouQWwshKJ7L2KqQ1bGT4Bgujq9Hw3bRttWG
	 zicA4PbASZ7uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf symbol: Fall back to fetching the vmlinux by
 build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-4-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:18:40 +0000
Message-Id: <20260914131840.EE25A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A profile recorded on a kernel that is no longer installed, be it
> because the machine was rebooted into a new kernel or because the
> profile is being processed on another machine, can't have its kernel
> symbols resolved: /proc/kallsyms matches the running kernel, not the
> one in the profile, and is refused when restricted, e.g. with
> kernel.perf_event_paranoid > 1, while the build-id cache may carry
> just a kallsyms copy with zeroed addresses.  With no kernel symbols
> the kernel samples can't be annotated, so they all end up in the
> '(unknown)' data type and the kernel is missing from the data type
> profile JSON "dsos" entry.
>=20
> As a last resort, when the kernel symbols can't be found locally and
> the user didn't specify a kallsyms file, fetch the vmlinux keyed by
> [ ... ]
> struct tty_struct, struct qspinlock, etc, with the kernel DSO, keyed
> by its build ID, appearing in the data type profile JSON.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D3

