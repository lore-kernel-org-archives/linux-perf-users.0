Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB233ADBF
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904432; cv=none; b=akxQ6LcQlULcXcV7pvs3IjcgQtAffjTHGjoAzvj9e2fql3YzsYAjHM1QEFXJ8g+0s/qh9Rq/2+u4CLN8VO7j1Ikx4FOK2i6OsEs/efSVAKen5lo2MzzGbjqDR3tP3YgKuFzvQezdzKkvlPRLL4BrSp5fyBO/31Bo8PVmZJFkcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904432; c=relaxed/simple;
	bh=FFcGZvYfmmgOKd1sw1JCLSCazhjuKkXFpsK7gqIM/qs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2xYCfifImh3L1ioyzu3qbJ73cEip1lCaE6Q9e9EOzOp5auEfyIzKECJTEKZ3FQTfgNcTv1syP/ttG6TtnLhO/haiS7Yie8hUTT8JaumOYB/ZyiEPk2WrsjYSk19Osn99tJHw6yMT5AL4IdW1a58iMBRzfsnGI3Vm+LeCPLI1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbIdhHgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbIdhHgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7180C1F000E9;
	Fri, 24 Jul 2026 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904430;
	bh=MuINYGApjZWg/u7pKpWex7L2FUhFlhR5lhRVKYv9Mgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbIdhHgHGsOYY0vXS3edE9DZML7P3ZKVyqO5hZ6mRopudJ4mBYRDNBkfVq6OZb5nA
	 pApJycNNVwFppGa4sGp6JCEk74+1vRHSXCe6K5pIBmYhXVUf2LEQ3HzkxTNJjUTZuD
	 yOSgcfctfQEKyYlN6sRfl8sdcZ7TK3sjUVjOBFgAT/Rb8YI9ype298tKZJK4PLc0sn
	 l7siySi4AdGC9fe1gpgVhfDBCSIvkryD+GnZBazdg2ZkWDFTvGRJX6jwFM8UCduO0F
	 72HWpwr6TGh69a3xwLaaBH/2OGGFIrBmKvrsm0ZRcf9LPoFDKbDeRhq+r6GydjH+gN
	 42S1uzbFL6+uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] perf trace-event: Fix buffer overflow in
 read_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724141316.99507-2-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:47:09 +0000
Message-Id: <20260724144710.7180C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer truncation when passing 64-bit sizes to do_read() and skip=
() leads to parser stream corruption and potential out-of-bounds memory rea=
ds.
- [High] read_proc_kallsyms() attempts to skip the kallsyms payload using l=
seek() but ignores the return value, breaking parsing when perf.data is rea=
d from an unseekable stream like a pipe.
--

--- Patch [1]: [PATCH v3 1/5] perf trace-event: Fix buffer overflow in read=
_string() ---
commit 933d8da6e80dadef6bdc3760f4e01eb9c825faeb
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix buffer overflow in read_string()

This commit adds a bounds check to read_string() to prevent a stack buffer
overflow when reading strings longer than BUFSIZ from the input. It ensures
the function returns NULL on overflow, matching other error paths.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index ecbbb93f01853..afd458cf1387d 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential integer truncation
when passing 64-bit sizes to do_read() and skip().

In tools/perf/util/trace-event-read.c, do_read() and skip() take an int:

static int do_read(void *data, int size)
{ ... }

static void skip(int size)
{ ... }

But in read_header_files(), a 64-bit size is passed directly to them:

static int read_header_files(struct tep_handle *pevent)
{
	unsigned long long size;
	...
	size =3D read8(pevent);
	...
	if (do_read(header_page, size) < 0) {
	...
	size =3D read8(pevent);
	skip(size);
}

Could this lead to silent truncation and parser stream corruption if a
malicious perf.data file provides a large 64-bit size (like 0x100000005)?

On 32-bit systems, malloc() would allocate a small buffer, while the parser
uses the full 64-bit size, causing an immediate out-of-bounds read. On 64-b=
it
systems, skip() truncates the size, skipping only a few bytes, which might
desync the parser and allow arbitrary data into subsequent parsing stages.


[Severity: High]
This is also a pre-existing issue, but does read_proc_kallsyms() properly
handle unseekable streams like pipes?

In tools/perf/util/trace-event-read.c:read_proc_kallsyms():

	lseek(input_fd, size, SEEK_CUR);

This lseek() is called without checking its return value or providing a
read-based fallback.

If a user pipes a perf.data file into the tool (e.g., perf report -i -),
the stream pointer is not advanced. Could subsequent parser functions
(like read_ftrace_printk()) interpret ASCII text from the kallsyms payload
as a 4-byte size header, resulting in massive arbitrary memory allocations
and tool crashes?

This appears to violate the subsystem rule which states that pipe streams
do not support seek and must be properly handled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141316.9950=
7-1-tshah@linux.ibm.com?part=3D1
