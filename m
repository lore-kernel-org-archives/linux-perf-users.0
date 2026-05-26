Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D036212C
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832837; cv=none; b=jLP/A1vvvpIY5+nc+19PyUEAPVOzyhiNQvSjTjs8l0fGZlfSLcVhM0Fr7lZb0xiY3M3Ox11S7BB7oo4Q3TuME+0wl0JfM7CUfzRuQGMATbe4q5wODPj0FKZTTkw//AeFofC9di0W4szLIoWiMAdzKNSgpGJcTWtIHzjh/jHWMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832837; c=relaxed/simple;
	bh=J6q6O0cXPJxlqsNabJHNFQKVcABINOLM/QArM2o6wyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sX3KP0ijQWT/+MUs7PHJXNfKfOxpkTfPTXMDelG4M6pXaH64EL7TkGzvYM4u3n8qRll6mCHWgvXbKkwh8sxZy8W0ixc1jzAgIwVb9kBF43D/K1ywTRzaCadFr5Mh4MdsMG/0r7fqKb1XDBVkVP3iZCMGA0t+6JYcIc8w1HkW2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNTi4tKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNTi4tKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADB1F00A3A;
	Tue, 26 May 2026 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832836;
	bh=mFeY9c7if+ivlDzsrThAKYwc5y/6LoFHAaRcYmOJ86k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNTi4tKAqTCnHKWpIt+XE5CuJ4r9Eo7f19K1LRiL8fG/p3BrKgCLkgoYinfMsF57X
	 h6uZB64jbUAPZvCVNJe8aq8YBdxsi33/EeW9+fO80xNnLsMwh6C8jGQ0cAL3U1/O6M
	 YBdEwBGLukDCsvENGjp9zD8lHzCZPuVm8gnRjhY5jH09JqjNXyZLKD0NKSDeE99erM
	 zKxlns06cIX9mmkwzGhrVaIzZg2l3+2rP/UI8I7ijqzGDLJt51rfn64CIXokH3TdCM
	 +8HiEj5hZJ8CVpMVVVjoqC78t12ewEgG1MNqg62UUexF4K999yCUzwPjQyiEUSL9nR
	 2bNAGnion/+lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/29] perf session: Bounds-check one_mmap event pointer
 in peek_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-3-acme@kernel.org>
References: <20260526211806.1193848-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:00:35 +0000
Message-Id: <20260526220036.26ADB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Flawed session->one_mmap_size calculation leads to integer underfl=
ow and bounds check bypass.
--

commit 748b22cbaf335af84a4611fd76fa89c066f02a10
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Bounds-check one_mmap event pointer in peek_event

This commit adds bounds checking to perf_session__peek_event() to ensure
that event pointers computed from file_offset fall within the single mmap
region. It adds one_mmap_size to the session struct to track the valid exte=
nt.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0523fd243e02c..c4cd8ad6d810a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -2560,6 +2575,14 @@ reader__mmap(struct reader *rd, struct perf_sessio=
n *session)
>  	if (session->one_mmap) {
>  		session->one_mmap_addr =3D buf;
>  		session->one_mmap_offset =3D rd->file_offset;
> +		/*
> +		 * mmap_size was set to the full file extent (data_offset +
> +		 * data_size) but file_offset was shifted forward by
> +		 * page_offset for page alignment.  Reduce by page_offset
> +		 * so the bounds check reflects the file-backed portion
> +		 * of the mapping =E2=80=94 pages beyond the file cause SIGBUS.
> +		 */
> +		session->one_mmap_size =3D rd->mmap_size - page_offset;

[Severity: High]
Can this subtraction underflow if a crafted perf.data file causes
rd->mmap_size to be smaller than page_offset?

In reader__init(), the size can be calculated from an unvalidated header
as rd->data_size + rd->data_offset. If a file is crafted where
data_offset =3D 8192 and data_size =3D -4096 (in 2's complement), the sum w=
raps
around to 4096. Since 4096 is less than MMAP_SIZE, one_mmap mode is enabled.

When this reaches reader__mmap(), page_offset becomes 8192 (from
data_offset). The subtraction 4096 - 8192 then underflows to a massive
64-bit value for session->one_mmap_size.

Would this bypass the newly added bounds checks in perf_session__peek_event=
()
and allow arbitrary out-of-bounds memory reads? The new validation check:

    if (offset_in_mmap >=3D session->one_mmap_size ...

would pass for arbitrary offsets because of the artificially huge underflow=
ed
size.

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D2
