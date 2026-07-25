Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1F2D8385
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007785; cv=none; b=AmO+jY/eBKdeEGFfkxhH3h9ht2ME7nkULbho1ridytHqx40POFSh5L+mgXWOYUNkpBnEaby50Z7ErdO4X0SJZALNoFD2gsNru+FOm5Uey6Ppi0qIb3z496L6XkftMfHldK2CQZS2hpy9G+p3uB/kmT668NOMPoMDf6an0F5dVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007785; c=relaxed/simple;
	bh=qtFkkuNeq/fRDxOB5ESErJShG/WPh9aq5cMhI9HvwkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ls8DKnBG+TDinnYrnNznBnGnexrLHQWX+2WuJOfSNdNv1HMwY8EYmf7LXIRObSwxMhZGEsyQQfQ4w1O3+mCVw+7ZSlGCq+HLJgVQiI8/uwwH27dw4wmSx0+9AcWDYx88iQF8gf4eQ06c2pqLGLqvd9Bd7OVIONW/b4f4IehXJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJlv6Jii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJlv6Jii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506B81F000E9;
	Sat, 25 Jul 2026 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785007784;
	bh=RN+xDC1sdohpIttAlgxSe49HYJxIiWKobfGBdxa6+Vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJlv6JiiCMKRRRkuDGIWb+IE9IQ3B2mjT/+Z+ZeQjb3W0lSfFjeLiCZvX/kSqQVwK
	 gjb94wtoMovn5LF0Hm5UHHTbhrXLdjM54mZocJYhyl7Lfu1yfL8yxkvNjDxOZtdPH/
	 Ouc7sciwq4fJLmHzugmlkNb+ED2sD1TuwKBtLvMfkI9dBJGLT3ncgCRnhQ6xYhcwuB
	 S/fPKMr+cBjTsfrYHerqLgX8T6FOskxfKd8IrQkrvkRiKvNQRQ3ZEXnQqPxskR0cVo
	 y7pQdXbvdhfPP7nDGJd1Y0ltrys04fTlIt9nt3InUwGb6vJ5+lg4QVci4HVMaETJ4Q
	 KopVYINHIGAIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] perf trace-event: Fix integer truncation in
 do_read() and skip()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725184953.234759-3-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
 <20260725184953.234759-3-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 19:29:43 +0000
Message-Id: <20260725192944.506B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in read_saved_cmdline() leads to zero-sized a=
llocation and massive out-of-bounds heap write.
- [High] The skip() function still truncates 64-bit sizes on 32-bit archite=
ctures, leaving the file pointer misaligned.
--

--- Patch [2]: [PATCH v4 2/5] perf trace-event: Fix integer truncation in d=
o_read() and skip() ---
commit ceab52608d4a89e2c3da800798280df9bb428d4e
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix integer truncation in do_read() and skip()

The do_read() and skip() functions use int for size parameters,
truncating 64-bit sizes from callers. This patch changes do_read(),
__do_read(), and skip() to use size_t for size parameters and ssize_t
for return values.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index afd458cf1387d..52ed496d92c3b 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
[ ... ]
> @@ -68,10 +68,10 @@ static int do_read(void *data, int size)
>  }
> =20
>  /* If it fails, the next read will report it */
> -static void skip(int size)
> +static void skip(size_t size)

[Severity: High]
This isn't a bug introduced by this patch, but does skip() still truncate
64-bit sizes on 32-bit architectures?

Since size_t is 32-bit on 32-bit platforms, passing an unsigned long long
from read8() into skip() can truncate values larger than 4GB.

Could a crafted perf.data file providing a massive header event size cause
skip() to truncate the value, leaving the file pointer misaligned?

>  {
>  	char buf[BUFSIZ];
> -	int r;
> +	size_t r;
[ ... ]
> @@ -350,7 +350,7 @@ static int read_saved_cmdline(struct tep_handle *peve=
nt)
>  {
>  	unsigned long long size;
>  	char *buf;
> -	int ret;
> +	ssize_t ret;
> =20
>  	/* it can have 0 size */
>  	size =3D read8(pevent);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this code overflow
size + 1 during memory allocation?

If a crafted perf.data file sets the saved cmdline size to ULLONG_MAX
(or ULONG_MAX on 32-bit architectures):

tools/perf/util/trace-event-read.c:read_saved_cmdline() {
    ...
    size =3D read8(pevent);
    ...
    buf =3D malloc(size + 1);
    if (buf =3D=3D NULL) {
        pr_debug("memory allocation failure\n");
        return -1;
    }

    ret =3D do_read(buf, size);
    ...
}

The size + 1 calculation overflows to 0, causing malloc(0) to return a
small valid heap chunk.

When the original massive size is then passed to do_read(), could the read()
system call overwrite the heap with out-of-bounds file data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725184953.2347=
59-1-tshah@linux.ibm.com?part=3D2
