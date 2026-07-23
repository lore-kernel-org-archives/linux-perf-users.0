Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5841687A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800709; cv=none; b=Xad4UuTznXoi/IUiHu6mW9Q6w1ygHeY11G1HBUhTF1lgHFK+0LSK34kueIL9kTIeZ5dlbAseO2/xdN5FZw5bPb7xBdsyByU1YCt35bLJVSx2fXX8Wn89wOYvf+6PIEKL6imi25lJeoy+RB1NxlAScnTANaBnDv8/cBQcaLE83hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800709; c=relaxed/simple;
	bh=C/9h3LnVEpkXTqe97W2bbJ6gn4oqOhlka6XOjD95uVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJ2oP96aDg0HlayWRgLLPT4mI4mPOiesBvRNNnNQZqk6jJpYDwLRtPeuVdKRK62mBMSY0B6MK99FrvL2Dgu88BjumxrdU0AgIICmPKJR2Q66d8Zmf8jPF4EB00DdzqHWOBGp3Dk6aG4Yfs0frqTHNS/rTgBdCMsIL1paNeDZx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6IUZ0XE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6IUZ0XE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659211F000E9;
	Thu, 23 Jul 2026 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800707;
	bh=RNtQjdQymwkMRjaBrzYBjdLpd7aGYV2iOcWD7vGyotc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6IUZ0XEgH+xx0tNHtJckHUqTU5LdsItjg1ianP/HG8Gk3xiA2Ka++SRenKy2P2PU
	 u1uXr7x4YvSls4PvNwmKitsgjMUbDONIDeH0EJSvd0nn+13/t3ioGD6fatbHNiLNSD
	 0gj4uTIKJdGwq+PXgGd+4AIKGbd+0m9W2ZB40vaEG6XI7pCB6KRIpd8vtlN2RIHB+y
	 tuSM0HDlYFkmVpnkt6EMeu8ix4/5bTksFsZOcoAssJ/o63ZjMlt3nTFae31AWFKPbR
	 L49YNJOnQnjUh6fabOHWW/SDOVa7/A3+Gvrqhm7FBIWoACD4hHYA+73vknX5wC4MLo
	 rFQcT0hey0/NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf trace-event: Fix buffer overflow in
 read_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723093958.416650-5-tshah@linux.ibm.com>
References: <20260723093958.416650-3-tshah@linux.ibm.com>
 <20260723093958.416650-5-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:58:26 +0000
Message-Id: <20260723095827.659211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error path in trace_report() leads to a double free of tevent->pev=
ent when session initialization fails.
- [High] Integer truncation in do_read() allows a malicious trace file to c=
ause the parser to process uninitialized heap memory.
--

--- Patch [1]: [PATCH v2 1/2] perf trace-event: Fix buffer overflow in read=
_string() ---
commit fca4f0cc3071265252215647838a7b30c9c0baaf
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix buffer overflow in read_string()

This patch fixes a potential stack buffer overflow in read_string() by
adding a bounds check before writing each byte into the buffer. If the
string exceeds the buffer size, it logs a debug message and returns NULL,
matching other error handling paths.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index ecbbb93f01853..afd458cf1387d 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -127,6 +127,11 @@ static char *read_string(void)
>  			}
>  		}
> =20
> +		if (size >=3D (int)sizeof(buf) - 1) {
> +			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
> +			goto out;

[Severity: High]
This is a pre-existing issue, but could this error path trigger a double fr=
ee
of tevent->pevent?

If read_string() returns NULL due to the bounds check, the error propagates
and trace_report() jumps to its error path:

tools/perf/util/trace-event-read.c:trace_report() {
    ...
out:
	if (pevent)
		trace_event__cleanup(tevent);
    ...
}

trace_event__cleanup() frees t->pevent but leaves the pointer dangling:

tools/perf/util/trace-event.c:trace_event__cleanup() {
    ...
	tep_free(t->pevent);
    ...
}

Later, during session teardown, perf_session__delete() unconditionally calls
trace_event__cleanup(&session->tevent), which will attempt to free the same
pointer again.

[Severity: High]
This is also a pre-existing issue, but does do_read() suffer from an integer
truncation issue?

Functions like read_event_file() allocate memory based on a 64-bit size:

tools/perf/util/trace-event-read.c:read_event_file() {
    ...
	ret =3D do_read(buf, size);
	if (ret < 0)
		goto out;

	ret =3D parse_event_file(pevent, buf, size, sys);
    ...
}

But do_read() takes size as an int:

tools/perf/util/trace-event-read.c:do_read() {
static int do_read(void *data, int size)
...
}

If a maliciously crafted perf.data provides a size larger than 32 bits, the
size is truncated when passed to do_read(), causing it to read fewer bytes.
Since read_event_file() only checks if ret < 0 rather than verifying
ret =3D=3D size, it will pass the large, mostly uninitialized buffer to
parse_event_file().

> +		}
> +
>  		buf[size++] =3D c;
> =20
>  		if (!c)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723093958.4166=
50-3-tshah@linux.ibm.com?part=3D1
