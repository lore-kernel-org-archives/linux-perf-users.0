Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662321C173
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776306340; cv=none; b=INRqkg1ih6sAyXsbQQXTbG0LEaKKhGvwueiRhSsn1yZpLXzN3tPewQ6HkWAyoZF44ye4HVgadyAqScHdIEnOjuUgayRlcvgrsMfEoIyxPv3a8PQGwXfYaiaq29KMUsVPl964MAffWdk3pMtKlk1Hkt+gCtq62LV6X8iyOdH+ivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776306340; c=relaxed/simple;
	bh=a0r+4bny3Xncu61CYPAtYZkUz0RQLuasG3P1QGgs9ps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OLn1MwMe9xlXbZ0/+d8Agrn2SHfUuzu9O1St/um0a632MtITLzteSMimyTkZgQvsHItFIwfaoTFqYlWJT9csBEcAelNmab0sXjXMoS51Qu+4T0whWVEY9Ayq1WSmsDvdijTSJb2MVExUlOw0uDLirCPPWEXMd0EtoSTmWog0Dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRgFXKL0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRgFXKL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287E3C19424;
	Thu, 16 Apr 2026 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776306340;
	bh=a0r+4bny3Xncu61CYPAtYZkUz0RQLuasG3P1QGgs9ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bRgFXKL0CGdahHghJrtuWXSUFhwXtJpJR8609b6eBI8I9KcJbPlLwrR83fUBXi86W
	 neCqYSjDS1SNHp+cX8xQ183Qp8lqjl41yJX9rXLsQr50SvjIbhRi0DyHKsO/mKshjU
	 BngTjwEKUzGMHlHTe8kE++XhMIf4KAlH/8Xn48ItcBuImwM/DCPwmGBtDRWf4WSEid
	 fB3Pod8PGpF7/jSveaoCvlXsuI8pcM8D2Ali/kxTi5C1KKhmKU+ZLoccQnjrWQnn4k
	 TDTzIMKHl4Zh8JYfV4vD08lxkQ6otS0/bK4qYxyW2f1La9LE87b9HxzGsmUj3FLgH2
	 URWJBt6iWcKeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf header: Validate bitmap size before allocating
 in do_read_bitmap()
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416001424.362797-5-acme@kernel.org>
References: <20260416001424.362797-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 02:25:38 +0000
Message-Id: <20260416022540.287E3C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Integer overflow in process_mem_topology() leading to heap buffer =
overflow
--

commit cc7a509cea916b4f4ae9c056c5eb0517bac22dfa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate bitmap size before allocating in do_read_bitmap()

This patch updates do_read_bitmap() to validate the u64 bit count read
from the file before allocating memory. It rejects sizes that exceed
INT_MAX or exceed the remaining section bounds, preventing potential
large allocations or truncation issues with bitmap_zalloc().

Link: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425@s=
mtp.kernel.org/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 696f19739074e..89697aec914c9 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -290,6 +290,11 @@ static int do_read_bitmap(struct feat_fd *ff, unsign=
ed long **pset, u64 *psize)
>  	if (ret)
>  		return ret;
> =20
> +	/* bitmap_zalloc() takes an int; reject u64 values that truncate. */
> +	if (size > INT_MAX ||
> +	    BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64))
> +		return -1;
> +
>  	set =3D bitmap_zalloc(size);
>  	if (!set)
>  		return -ENOMEM;

This isn't a bug introduced by this patch, but since the commit message not=
es
that do_read_bitmap() is used by process_mem_topology(), does the same miss=
ing
validation exist when allocating the nodes array in process_mem_topology()?

tools/perf/util/header.c:process_mem_topology() {
    ...
	if (do_read_u64(ff, &nr))
		return -1;

	nodes =3D zalloc(sizeof(*nodes) * nr);
	if (!nodes)
		return -1;

	for (i =3D 0; i < nr; i++) {
		struct memory_node n;
    ...
		nodes[i] =3D n;
	}
    ...
}

Because nr is an unvalidated 64-bit integer read from perf.data, could a
crafted value like 0x2000000000000000 cause the 64-bit multiplication
(24 * nr) to wrap around to 0 during the zalloc() call?

If zalloc(0) succeeds and allocates a minimum-sized heap chunk, the loop
could iterate and write beyond the allocated bounds when assigning
nodes[i] =3D n on subsequent iterations.

Could this overflow the nodes[] buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416001424.3627=
97-1-acme@kernel.org?part=3D4
