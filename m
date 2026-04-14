Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B53845A9
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201864; cv=none; b=ERjWS6zNX49fg4zGvN92GV1I/rgpaaCivYLY3T4gXTDytIUBHDQik6vqsC46MvF8l2U6PdFgXWp3pKKiwijxRfIe40SsLK83ctivtkIOufmcMmwSWaJBuSBTduBhm+p3KBqLapJ4+49Q0nj0aKewXLfZiNtLtWFQPobrgc0SiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201864; c=relaxed/simple;
	bh=soCzq8abzI3tbVtXAKjuyXhzk7L9GNArPqjAJ7u7N38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dN0x0+Ri3ibPoibWHqqBS8dgpO3IMB53Z20qGsB0TctFGiOZ9/YPtHDoAtRz6V6i4r3sezfz3rTXqns2CGNCrh4LeOizI4u/on4tijf/ZkhPtV0QLsfoX3U0YNU7l8OTH81ec3hygsbi6sTuSgWjbTVSpJbMDygEitSA5n6mVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF5h3Gv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF5h3Gv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289B1C19425;
	Tue, 14 Apr 2026 21:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776201864;
	bh=soCzq8abzI3tbVtXAKjuyXhzk7L9GNArPqjAJ7u7N38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eF5h3Gv7nISuP7mpQQU+Jzc6bVvOHX8saoqfmVNqMBWc8PuljKarxdMVzYdGAAEcK
	 qpXyOb+Sqd5CKwOpryZGdi8VI/CkvVvXvrM4Xb3QvtpmzsNX6WNlSalw8LunD51+oR
	 4nQKgxfKhsnPuvBwskn/prpQuvK9t+pvW24uxbbFc2xSteYUvtW87Et2KN+i2H++ox
	 XMv8aomMk7FSAZ/kE+FC37VnVBpqGmFAqcu3X7AAzWSN3D3OFrkKO9BzN2lii2mbOT
	 I6kFNH1k0W2EOFLvP1SHsfNkSr/f0bQwU36CiZje5SyB/uGf4p5I0QgANY25RB3d7j
	 eB6M4lyBEyE4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf header: Add section bounds checking to the fd
 read path
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414204847.293557-2-acme@kernel.org>
References: <20260414204847.293557-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:24:23 +0000
Message-Id: <20260414212424.289B1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [Critical] Pre-existing: Stack buffer overflow and integer underflow in `=
perf_header__read_build_ids()`.
- [High] Uninitialized `ff.size` causes `perf report --header` to fail sile=
ntly.
- [High] Signed bounds check bypass in `__do_read()` leads to heap buffer o=
verflow on 32-bit platforms.
- [High] Pre-existing: Information leak due to missing null-termination in =
`perf_header__read_build_ids()`.
- [High] Pre-existing: Heap out-of-bounds read due to missing null-terminat=
ion in `do_read_string()`.
- [Medium] Incomplete fix: `process_build_id()` bypasses the newly introduc=
ed bounds checking.
--

commit 557f37ee3d214171c6512a20a7fd8580d9ddaad8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Add section bounds checking to the fd read path
   =20
This commit adds section bounds checking uniformly to both the fd and buf r=
ead
paths in __do_read(), replacing the previous check that was only in
__do_read_buf(). It also updates perf_file_section__process() to initialize
the file offset to 0 and changes process_build_id() to use lseek to discover
the file position instead of relying on the offset.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9142a8ba40195..ca0c9e80345b2 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
>  static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
>  {
> +	if (size > (ssize_t)ff->size - ff->offset)
> +		return -1;
> +

Can this signed bounds check be bypassed on 32-bit platforms? If size is
derived from an extremely large unsigned length in a malicious perf.data
file, size might implicitly cast to a negative ssize_t value. The check
would evaluate to false, and the negative size could then be cast to an
enormous size_t during the memcpy() or readn() operations, leading to a
heap buffer overflow.

Also, is it possible for ff->size to be uninitialized when called from
perf_file_section__fprintf_info()?

tools/perf/util/header.c:perf_file_section__fprintf_info() {
    ...
	ff =3D (struct  feat_fd) {
		.fd =3D fd,
		.ph =3D ph,
	};
    ...
}

Because the struct initialization omits the .size field, it will be
initialized to 0. This seems to cause __do_read() to fail silently when
trying to print features like HEADER_EVENT_DESC, which could break
commands like perf report --header.

>  	if (!ff->buf)
>  		return __do_read_fd(ff, addr, size);
>  	return __do_read_buf(ff, addr, size);
[ ... ]
> @@ -2655,7 +2655,12 @@ static int process_tracing_data(struct feat_fd *ff=
, void *data)
> =20
>  static int process_build_id(struct feat_fd *ff, void *data __maybe_unuse=
d)
>  {
> -	if (perf_header__read_build_ids(ff->ph, ff->fd, ff->offset, ff->size))
> +	off_t offset =3D lseek(ff->fd, 0, SEEK_CUR);
> +
> +	if (offset =3D=3D (off_t)-1)
> +		return -1;
> +
> +	if (perf_header__read_build_ids(ff->ph, ff->fd, offset, ff->size))
>  		pr_debug("Failed to read buildids, continuing...\n");
>  	return 0;
>  }

Does process_build_id() bypass the newly introduced bounds checking?

Because process_build_id() calls perf_header__read_build_ids(), which
reads directly from the file descriptor using readn() instead of utilizing
the __do_read() helper. This seems to bypass the bounds check added above,
allowing reads past the end of the section if the section size is
understated.

While looking at perf_header__read_build_ids(), there appear to be a few
pre-existing concerns.

Could a maliciously crafted perf.data file trigger a stack buffer overflow =
here?

tools/perf/util/header.c:perf_header__read_build_ids() {
    ...
	char filename[PATH_MAX];
    ...
		len =3D bev.header.size - sizeof(bev);
		if (readn(input, filename, len) !=3D len)
			goto out;
    ...
}

If bev.header.size is smaller than sizeof(bev), the unsigned subtraction
could wrap to a huge positive size_t. This would then become a massive
size_t passed to readn(). Alternatively, a large user-controlled u16 value
could result in a large positive length. In either case, readn() would
write significantly more data than the 4096-byte stack buffer can hold.

Additionally, does this lack of null-termination leak information?

If the file payload doesn't contain a null byte, the stack-allocated
filename buffer will contain stack garbage at its end. When passed to
subsequent C-string functions like strdup() via
__event_process_build_id(), it could result in an out-of-bounds stack
read.

There appears to be a similar pre-existing issue in do_read_string():

tools/perf/util/header.c:do_read_string() {
    ...
	buf =3D malloc(len);
	if (!buf)
		return NULL;

	if (!__do_read(ff, buf, len)) {
    ...
}

Since this allocates a heap buffer of size len and reads exactly len bytes
without appending a null byte, could an attacker provide a string without
the expected zero padding? If so, the buffer would lack a null terminator,
leading to a heap out-of-bounds read when manipulated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414204847.2935=
57-1-acme@kernel.org?part=3D1
