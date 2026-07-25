Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EC2E7374
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007760; cv=none; b=SaTMtRpSm2ae9+hKgbchmcG31EuJA75oQ1YWAHEWoyO21HJgSR3aAZLYN+PQag80xbSzs6qD2QZo4wdAL0PXrtD8IAVbq+hUW5Eru7pnzFsqVe1FU5uPm7fBvMa8jNgaBLIxFzkRT8IeqvCKJJHM0Dm5gN8sFqfi4plr100LIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007760; c=relaxed/simple;
	bh=uuWVH/NUOFWFnpUpHMv8jeGLmsOML/fAGKchmhiXNlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HcsMmT1Id9fRMG1mscoUx4VIuaGQzvkFSSq/Lk4PIf+OqJRbh6CD1WsDPxYkOq//h3R4hVb1Jv2M8Lp1IYVAToeVD7T+m/WMpj8AJ6TwvRU5EPNrfc8NA3Q4PiVfVqK8J6rglgQFvMH90zasByZJtswFJyfB0KemfuzZIBurZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O62lPmVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O62lPmVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8281F000E9;
	Sat, 25 Jul 2026 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785007758;
	bh=SLG1MjxngEa+6zWD2bhQMT5H+pdhR3/KOS1TRQYw5KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O62lPmVSSm3/z3KQDTTVvruwGJEC9+Ts3XEczmWCKubT7LzT0SCxbKPwbqhuK8nJP
	 U4pY+8c97JtbrAWQx1XxDkwWESLb+L1sBwbRWYtoiYG2pYRT2CXK0xW9d7I1kWVFXq
	 uS590rZKL2Tl3VJ7DnDbl7VIA+xxdn2URJdVHfQBdBVbAbQVr+t7Kz/xwjnDUy7wBi
	 oqAvLUFt6qmytHIkX9DmcPImZF7RG1JBmdYdtVli3u5SXPtWKNLKroSpRa1A+54LAy
	 BxXOvvKLgFwguHH/azAh7n/s5k9yiTnsM8AazTLJZEeWaKqCOtZZHeZGRRNbjpP1La
	 KY2h7AijGzTqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] perf trace-event: Fix infinite loop in skip()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725184953.234759-6-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
 <20260725184953.234759-6-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 19:29:18 +0000
Message-Id: <20260725192918.8D8281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete fix for heap buffer overflow in read_saved_cmdline(=
) on 32-bit systems.
- [High] Integer truncation on 32-bit systems leads to Out-Of-Bounds reads =
during file parsing.
- [High] Unhandled lseek() failure and bypassed repipe mechanism in read_pr=
oc_kallsyms().
- [Medium] Incorrect PTR_ERR usage extracts error from NULL pointer in evse=
l__tp_format().
--

--- Patch [5]: [PATCH v4 5/5] perf trace-event: Fix infinite loop in skip()=
 ---
commit 3b2c19f9da89212b3fdd3fac1e4250b2f316409f
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix infinite loop in skip()

The patch updates skip() to check the return value of do_read() and break o=
ut
of the loop on failure or end-of-file. This prevents an infinite loop when
reading crafted files with very large sizes or when hitting read errors.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index 53f1920c3fcbe..db1622fc99c23 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -72,12 +72,16 @@ static ssize_t do_read(void *data, size_t size)
>  static void skip(size_t size)
>  {
>  	char buf[BUFSIZ];
> -	size_t r;
> +	ssize_t ret;
> =20
>  	while (size) {
> -		r =3D size > BUFSIZ ? BUFSIZ : size;
> -		do_read(buf, r);
> -		size -=3D r;
> +		size_t len =3D size > BUFSIZ ? BUFSIZ : size;
> +
> +		ret =3D do_read(buf, len);
> +		if (ret <=3D 0)
> +			break;
> +
> +		size -=3D ret;
>  	}
>  }

[Severity: Critical]
This is a pre-existing issue, but could this malloc allocation and subseque=
nt
do_read() in read_saved_cmdline() cause a heap buffer overflow on 32-bit
systems?

tools/perf/util/trace-event-read.c:read_saved_cmdline() {
    ...
	if (size =3D=3D ULLONG_MAX) {
		pr_debug("invalid saved cmdline size");
		return -1;
	}

	buf =3D malloc(size + 1);
    ...
	ret =3D do_read(buf, size);
    ...
}

Since size is an unsigned long long, if an attacker provides 0xFFFFFFFF
(UINT_MAX) from a crafted perf.data file, the size =3D=3D ULLONG_MAX check
will not catch it.

The malloc(size + 1) calculation would then wrap around to 0 on 32-bit
systems, resulting in a tiny allocation. The subsequent do_read(buf, size)
call would use the original 0xFFFFFFFF value, causing a massive out-of-boun=
ds
write.

[Severity: High]
This isn't a regression introduced by this patch, but does 32-bit truncation
of size in read_header_files() lead to an out-of-bounds read?

tools/perf/util/trace-event-read.c:read_header_files() {
    ...
	size =3D read8(pevent);

	header_page =3D malloc(size);
    ...
	if (do_read(header_page, size) < 0) {
    ...
	if (!tep_parse_header_page(pevent, header_page, size,
    ...
}

size is a 64-bit unsigned long long. On 32-bit systems, passing size to
malloc() and do_read() implicitly truncates it to 32 bits.

If an attacker supplies 0x100000001ULL, a 1-byte buffer is allocated and
read. However, tep_parse_header_page() receives the full 64-bit size,
causing it to potentially read past the 1-byte heap allocation.

The same integer truncation pattern also appears in read_ftrace_file() and
read_event_file().

[Severity: High]
This is a pre-existing issue, but does this lseek() failure break stream
parsing when running in pipe mode?

tools/perf/util/trace-event-read.c:read_proc_kallsyms() {
    ...
	/*
	 * Just skip it, now that we configure libtraceevent to use the
	 * tools/perf/ symbol resolver.
    ...
	lseek(input_fd, size, SEEK_CUR);
	trace_data_size +=3D size;
	return 0;
}

If input_fd is a pipe, lseek() returns -1 (ESPIPE). Because the error is
ignored, the file pointer remains unchanged, and subsequent reads might
incorrectly interpret the kallsyms payload as trace headers or events.

Additionally, using lseek() bypasses the repipe logic in __do_read(), meani=
ng
these skipped payload bytes aren't written to standard output, breaking
repiped streams. Should this use skip(size) instead?

[Severity: Medium]
This isn't a regression introduced by this patch, but does evsel__tp_format=
()
extract the error code from a NULL pointer?

tools/perf/util/evsel.c:evsel__tp_format() {
    ...
	if (!evsel->tp_sys)
		tp_format =3D trace_event__tp_format_id(evsel->core.attr.config);
	else
		tp_format =3D trace_event__tp_format(evsel->tp_sys, evsel->tp_name);

	if (IS_ERR(tp_format)) {
		int err =3D -PTR_ERR(evsel->tp_format);

		errno =3D err;
		pr_err("Error getting tracepoint format '%s': %m\n",
    ...
}

If the trace format fails, it returns an ERR_PTR into the local variable
tp_format. But the code tries to extract the error using -PTR_ERR() on
evsel->tp_format, which is still NULL.

This would result in errno being set to 0, causing pr_err() to log "Success"
instead of the actual error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725184953.2347=
59-1-tshah@linux.ibm.com?part=3D5
