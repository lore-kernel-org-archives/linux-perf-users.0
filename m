Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7D1E5207
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765698; cv=none; b=FWv2TM+qn4ca8RKvSrqtYiLDeCyfKmUKkQsKNzbPedK3ZBzcV407v3R9xqvGWWZkZIHQuRYpgaLPORNqQ/TkqdTYLQ6j5Zq17CK9AGkUqeSb+ttvVAVqSneTaMDcklq9KdNVaXNdDjumoOJILhmxerzKPpBKNI2v3fgULJEpgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765698; c=relaxed/simple;
	bh=caDJXdgvIdpu8RiImwLcGrvoGAJXLNhddF4GFfr0PAI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=apr+PtHmQMJUJSUpSy2t2SwuwKitIVj62a/gF/zr+aENHMElYhuiLK5jA3a+pd6x5ACcxhRBhrj0WbHpslcLTanl5L/raNfuUY4eCgvtgozil0x7qr07fYRDVdX7mCShT+6dZPxJ81hCNIIsVl6TR+/msBmV8HLmXgvmwIpk+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDUKHu5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDUKHu5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBE31F0089B;
	Mon, 12 Oct 2026 00:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791765697;
	bh=XjbPtTdXsIprglmfp6OCFFPQyxveJp/o9U5v5In/swA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDUKHu5dd1y2co9llTGmrBk1GR2wG5+MgC8fSTbxKgisJuiruvzbMwatZ3ZRtGoRF
	 Z3ZfOefTYaG+ThO9qjgeImxZMzdnlAT2iWM0HT0fyxnjAkiU95AuGjFRJVeJDjxpOA
	 cWmN6rhcPJpxy5rry3JbX5E3bBNSmZYy2GTMy64Z5BskMQ6Co+Um8wPW7v/STeyHi7
	 co98Oe2FfhpeEHnEMTT+Ar1qS/iHNkmpc5D4UXO/uW2/fENLg8MreMVdg2nDtiVNJo
	 rdYVK7gNOd62MUGq/Ff581UvE5FptdY/M3Nssj3Nrw4Nulibolx7o8aLbYmjTuEDOf
	 vWHd+/STjGRGg==
Message-ID: <sashiko-outbox-167529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012003016.263063-2-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 00:41:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: dropped stdout error check causes infinite loop on EPIPE
- [Medium] perf: uninitialized heap memory read in __cmd_ftrace() strbuf
--

commit 0a06afad8e6a1e6bf21a4b8a3c19582ed3d99cd1
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming

This commit refactors __cmd_ftrace() to use dynamic heap allocation
for the read buffer and a strbuf to accumulate streamed characters
into lines. This reduces the stack frame size by over 96%.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6017493ff1797..d6604be593a34 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c

[ ... ]

> @@ -810,11 +821,19 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  			break;
> =20
>  		if (pollfd.revents & POLLIN) {
> -			int n =3D read(trace_fd, buf, sizeof(buf));
> -			if (n < 0)
> -				break;
> -			if (fwrite(buf, n, 1, stdout) !=3D 1)
> +			int n =3D read(trace_fd, buf, TRACE_BUF_SIZE);
> +
> +			if (n <=3D 0)
>  				break;
> +			for (int i =3D 0; i < n; i++) {
> +				if (buf[i] =3D=3D '\n') {
> +					fprintf(stdout, "%s\n", linebuf.buf);

[Severity: Medium]
Can this print uninitialized heap memory?

Earlier in this function, strbuf_init() allocates the buffer but does not
explicitly null-terminate it:

tools/perf/util/strbuf.c:strbuf_grow() {
    ...
    buf =3D realloc(sb->alloc ? sb->buf : NULL, nr * sizeof(*buf));
    if (!buf)
        return -ENOMEM;

    sb->buf =3D buf;
    sb->alloc =3D nr;
    return 0;
}

If the very first character read from trace_pipe is '\n' (for example, from=
 an
empty trace line), linebuf.buf is passed to fprintf() as a string before any
null byte has been written to it.

[Severity: Medium]
Does the removal of the stdout error check cause an infinite loop?

The original code explicitly checked if fwrite() failed to gracefully exit
the polling loop if stdout closes (for example, when the pager exits or
when piped to head).

Because trace_pipe provides endless continuous data while tracing is active,
ignoring the fprintf() error forces the tool to endlessly read trace data
and discard it, never terminating.

> +					strbuf_setlen(&linebuf, 0);
> +				} else {
> +					if (strbuf_addch(&linebuf, buf[i]) < 0)
> +						goto out_close_fd;
> +				}
> +			}
>  			/* flush output since stdout is in full buffering mode due to pager */
>  			fflush(stdout);
>  		}

[ ... ]

> @@ -832,15 +851,31 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> =20
>  	/* read remaining buffer contents */
>  	while (true) {
> -		int n =3D read(trace_fd, buf, sizeof(buf));
> +		int n =3D read(trace_fd, buf, TRACE_BUF_SIZE);
> +
>  		if (n <=3D 0)
>  			break;
> -		if (fwrite(buf, n, 1, stdout) !=3D 1)
> -			break;
> +		for (int i =3D 0; i < n; i++) {
> +			if (buf[i] =3D=3D '\n') {
> +				fprintf(stdout, "%s\n", linebuf.buf);

[Severity: Medium]
Does the lack of a return value check on fprintf() also cause an infinite
loop here on a broken pipe?

The previous code broke out of the loop if fwrite() failed. Without
checking the return value of fprintf(), an error writing to stdout is
ignored.

> +				strbuf_setlen(&linebuf, 0);
> +			} else {
> +				if (strbuf_addch(&linebuf, buf[i]) < 0)
> +					goto out_close_fd;
> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012003016.2630=
63-1-atomlin@atomlin.com?part=3D1
