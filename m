Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B19411A12
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109649; cv=none; b=iYag1avl5gnAZbFoDbBjI9EfTChPpZhMMkudXTMjiHFN1HUtag2apbHWjchWzkW6Bj5kLYZSk5JkSpd9xuBTL9r0aRhsXfQ/bikASIQpPHac2PE8XMl5Re/qRNDH+nVzIlb5hwzsF9/dTPApmv0MbH+viTFb6mRITzrViWQ0os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109649; c=relaxed/simple;
	bh=oa2emghJ9orV08SC0k+enQIYedOPezrXb52pY/ONpWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cr8ftmRKS6ylFICv/EtZnpfFv3WWzz/wv1X9/WE1IicZoOCQJNaV3igQhAm6sLRIdZpuzBgToNV9HURK4oP6BB777brBwWnZ45KpvYqMt1ZLrsqnTdE/mwA7yq7A3JjU6FRHVvTBLjboSeGC2jv5nsxAwmnwXetW0FQ3ea7jX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+zcXv6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+zcXv6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B678D1F0089A;
	Sun,  4 Oct 2026 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109647;
	bh=O+vuH7TniKlk23XlP6ka+ka6R1Lzvz2TYknNPAlSUbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+zcXv6TdiFSHbQdvGEle5JLYaGkYRjQ7MWllXKTe0UIlFnHHdeL6PARGafZp+YDb
	 8j2n5zBB6vO8S+4qtaE6h67KYbM1bRHqzAKOXY0FAfGEsla1pz5LVg3aTr106KAhzP
	 rA1a0PK8MjMBB3FqgjZFEdgfjbYWWznSY2vsroarllRzgiK3VMS/akacBVmMzE1efC
	 NObR6HJvNIEUA6I/x47hSdR+idXbbM5F7EjfNKCZmCTXK/WwfvcCgp/EsxEOkEG9wc
	 9qdI31taH9e59R/r7O9mhMkRlP/YIk2HjRICuUH904ula9g+QlTiwsUfqSXK3ddW2Q
	 ePIoEciyD8X0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 9/9] perf test: Add false_sharing workload
 exhibiting cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004102133.26392-10-acme@kernel.org>
References: <20261004102133.26392-1-acme@kernel.org>
 <20261004102133.26392-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:27:27 +0000
Message-Id: <20261004102727.B678D1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> sum the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Data type profiling of the workload with cacheline info:
>=20
> [ ... ]
>              0.00%   0.01%        struct folio +0x34 (_refcount.counter)
>              0.00%   0.00%        struct folio +0x18 (mapping)
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004102133.2639=
2-1-acme@kernel.org?part=3D9

