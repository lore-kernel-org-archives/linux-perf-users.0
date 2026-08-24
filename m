Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C3427FB0
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578832; cv=none; b=gQrL0MhJXjQmwLvKoccOAJh+5NPVc+nrzcD1KNfjn9SzcEx/jfEzhPaMQJ6cj6YuaIuMIc0w0PfkbC6nALf62k9k5DZenPq72C3+txb72A56vYuSm1kbTC0mab0OFYqprP+j9R8/gwJv8hH12yNptv24mAVA7E9FJpLM5xr3S+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578832; c=relaxed/simple;
	bh=oqWJZfMRMb2tqlVm+H+tR/nWgV9aDiarwFhZzMkRc2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dSRwDU4Jd4U5rVLeLyiCMUqTzcTcFg1QYN3+ublH+jM3nt/IdZ3A3C4KHhmRW26jG1TbKFQhb92k5MapLDRI/D9mYqDXTh9J2pP6OiMxT1Xw7X6X4E2SM4GBcseT6YTpkQybai4MevV9yAeA8nujL/jXgoEfOR1fXd9JWtmK7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTmRZyDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTmRZyDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222421F00A3A;
	Mon, 24 Aug 2026 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578821;
	bh=oqWJZfMRMb2tqlVm+H+tR/nWgV9aDiarwFhZzMkRc2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HTmRZyDK0MGR0GwU9mEukuDlX2r4oiqFAW64lINuqguQY5eiAUD8KOtbaPoVycqo7
	 0nL8CyLHR1aIThFlWpEmlUEtJ6nGlHM8sW2KOlTVBGIEAB6KIxMHp/Tu6P+v9pCgis
	 HtNhpS2Hc+5qonVznks9sEsxMpwnMPOEOdH5tVuhurR8RJmpXO15rp9AuMbisqJiX/
	 EZjMz4TVnUWB73waihE0vnewQXe2JEhkU37S2RyWDZP4x5lvJYQoiAxeqn3EhQ4UOJ
	 nbwZmqBgEpEOlxx/qMvun2EjygYE9jQHQNB9C2jYLi94AYukHe8JofdrDwdT3cLfR7
	 goC6klld5rx2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 1/5] perf trace: Fix error checking
 in btf_struct_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824133122.751733-2-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:40:20 +0000
Message-Id: <20260824134021.222421F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> btf_dump__dump_type_data() returns the positive number of bytes dumped on
> success, or a negative error code (e.g., -EINVAL) on failure.
>=20
> Currently, btf_struct_scnprintf() checks if btf_dump__dump_type_data()
> returns 0. When a negative error code is returned on failure, this check
> evaluates to false, causing the function to proceed down the success path
> and advance arg->augmented.args past the unprinted struct data before
> returning 0.
>=20
> Consequently, when syscall__scnprintf_args() falls back to the default
> argument beautifier upon receiving 0 from trace__btf_scnprintf(), the
> fallback beautifier or subsequent arguments read from an erroneously
> advanced augmented arguments buffer.
>=20
> Fix this by checking for '<=3D 0' ensuring that on any failure or 0-byte
> dump, 0 is returned without modifying the augmented arguments pointer.
>=20
> Fixes: cb32035214b9 ("perf trace: Pretty print augmented struct args usin=
g BTF")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824133122.7517=
33-1-atomlin@atomlin.com?part=3D1

