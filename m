Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA12DEA98
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111059; cv=none; b=UmnN6VVEizTGZzEGnrNsQAdhFlAy8GnXSqciGXZld7jgWNh0mgWoETey61WugWyrcfcsOqY6FuyAMt+cgvbqpVhMVkGAFi3984o8Rx/4Hvj9OEsWcBZ7JZRBSIcAXZS+V2pS5WKh94Mh1s+Y65pPF4Zh7xbd/BhLg32BCiTcb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111059; c=relaxed/simple;
	bh=+9JhMNx2c3rQhoIeSYfsBxlzlFYyLKHajXqUWPXeOv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ADvl8VUSJOSDQPOf9xSptF5efwn4twsViQRThRkXI/bX3zgD0iEQaNQ/KhDlfle9qEe61l4mGVCqAvBGpNPXpwJPF6f+Jw/rPcWCRn3ScFsH0W9yy8jXGfMQHdHZ/AMtgD2EC+vX/Fd1OPKW6X8GLb6sxqogWxKzFUuIxHHXoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn99eYJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn99eYJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F49D1F00893;
	Wed, 10 Jun 2026 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111058;
	bh=LH8bpNpacRBOliiTawse8L5F+YJgLVmy+bAiTQwSAls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jn99eYJd1F/5+QMF+EcQlAtUcYdX4vvnviozevndC/7sMXxtcJGozlj7ZUt56Pfcw
	 hmKWP0FtYHtlYLRQB9x3Hw9ZMgC/3wBUNFfimt+D4o8H++/UZL9WWYbXmGiYQoeOP7
	 vn38Ow1yKOa1t4TjHyuYNVTmpZX2i0vrK2MkG3rlvmb5kVsUZiUn8+9W0EFbQCA0ep
	 0TgRCjNZ0PxYqGdVbmC9tDrJfiQs2L8Gc3GexJzT82UIaCPclF1YbgRHAQPsapkhBZ
	 KbF7GuULsSzA9fu+agRYaBOeyp2it4XkcJTaDd5kXdRuTaELT7d0rjPbUDEHTmngps
	 ldG5NXz7fDtrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on
 empty sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-2-acme@kernel.org>
References: <20260610165207.2077258-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:04:17 +0000
Message-Id: <20260610170418.0F49D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] size_t underflow in pmu_id() causing an out-of-bounds write when r=
eading an empty sysfs identifier file.
--

commit 9effe935b669b19aeff861c043c4e4e8a534bfab
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix get_max_num() size_t underflow on empty sysfs file

This commit fixes a size_t underflow in get_max_num() that occurs when
reading an empty sysfs file. By adding an early return when the read
length is zero, it prevents the backward scanning loop from reading
out-of-bounds across the heap.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 21fa781b03cc7..1fab00ec4a59a 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
[ ... ]
> @@ -448,6 +448,12 @@ static int get_max_num(char *path, int *max)
> =20
>  	buf[num] =3D '\0';
> =20
> +	/* empty file =E2=80=94 nothing to parse */
> +	if (num =3D=3D 0) {
> +		err =3D -1;
> +		goto out;
> +	}
> +
>  	/* start on the right, to find highest node num */
>  	while (--num) {
>  		if ((buf[num] =3D=3D ',') || (buf[num] =3D=3D '-')) {

[Severity: High]
This isn't a bug introduced by this patch, but it appears there is another
instance of this exact same empty sysfs file underflow issue in pmu_id():

tools/perf/util/pmu.c:pmu_id() {
        ...
        if (filename__read_str(path, &str, &len) < 0)
                return NULL;

        str[len - 1] =3D 0; /* remove line feed */
        ...
}

Does this cause an out-of-bounds write? If the sysfs identifier file is
empty, filename__read_str() returns len =3D 0. The str[len - 1] =3D 0
assignment then underflows, writing a null byte to str[-1]. Could this
corrupt the malloc chunk metadata located immediately before the allocated
buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D1
