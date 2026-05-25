Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B62765ED
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676794; cv=none; b=MpK5YWn/XEMrkyRp6JnGlKAFE8PQelsUtUPRP5GE1Pn1s0PHuVN3dZ/DpHD35DVA6SHAaGfZMKdkiLERmQaEoqn0/o/UTFmqdsLJSEg2XtfyaHuUQiQ4g0q/Zwee5WsKk0lZpNlEPy3EahjnYyy2Oir9MYZ/M1/YE2wvT3pvzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676794; c=relaxed/simple;
	bh=RIPyfr1pNw9DHYI8neekB+fJ98M0Z/URZgDK5bExtvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eGaV3tsV38gwSP+KttGDj0EAa2vTcrFzGAD5s2xMr+r9hh6l7uS49O1X8cWCIxLxSZ1Ld5NiGK6MyDYuX1eg6DLL9SVoKqNz9alwMszD62be5LgF7Kk6crm3VI7wl7LU0qBPMZ3eV6h7XdSNKtqjkzO1OmOf21RNIEAQf3BFN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY0oUdcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY0oUdcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A142D1F00A3A;
	Mon, 25 May 2026 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779676792;
	bh=g7a2gD6fBBWi7RTALCgt8Fms9qEuU94GIQyqh6s/Gns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QY0oUdcdsBUaG26BoSZSMdl+jeHSD/YPvfEwg2QWlrW4RVYicO4h/zwDK9I/OZKfA
	 oUw+Mn+3PY1aR3OOQ8Sp6ErGTpFgaPox33pk55Qf9XkzenwI+xctCofVNpc0KTO2LU
	 MGtvdMk7L4Iux5kgR0A0YIoyfyNc4IKCi6wiM8WRYGli+t02h9qQshkqcy3Lc0ut5K
	 pdtL9gQua/8ha5D5x0u0RIOe66tiJNzrUq4hCEc2kNTlxQkaJSSWvA+dNgYxCRU+JJ
	 PN2GZ5Cpfaz65/RAf6wQrXcXDgmNrNKLKtsr+mWvZRx6j8mW/YdqE53znLFfOSfKPU
	 lFbXwDghwjRPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/29] perf header: Validate f_attr.ids section before
 use in perf_session__read_header()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-20-acme@kernel.org>
References: <20260525010550.1100375-20-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 02:39:52 +0000
Message-Id: <20260525023952.A142D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Resource Exhaustion Mitigation via Overlapping Sections
--

commit 98460cf9f3f3f8baecca5e5d0f70e5a6af424baa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate f_attr.ids section before use in perf_session__read_h=
eader()

This commit adds validation to the perf.data header reading path to prevent
heap corruption and integer overflows. It caps the number of attributes,
ensures ids section size alignment, and checks that ids sections do not
exceed the bounds of the file.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -4967,6 +5003,45 @@ int perf_session__read_header(struct perf_session =
*session)
>  			perf_event__attr_swap(&f_attr.attr);
>  		}
> =20
> +		/*
> +		 * Validate ids section: must be aligned to u64, and
> +		 * the count must fit in an int to avoid truncation in
> +		 * nr_ids and size_t overflow in perf_evsel__alloc_id()
> +		 * on 32-bit architectures.
> +		 */
> +		if (f_attr.ids.size % sizeof(u64)) {
> +			pr_err("Invalid ids section size %" PRIu64 " for attr %d, not aligned=
 to u64\n",
> +			       f_attr.ids.size, i);
> +			err =3D -EINVAL;
> +			goto out_delete_evlist;
> +		}
> +
> +		/*
> +		 * Cap the ID count to avoid int truncation of nr_ids
> +		 * on 64-bit and size_t overflow in the allocation
> +		 * paths (nr_ids * sizeof(u64), nr_ids *
> +		 * sizeof(struct perf_sample_id)) on 32-bit.
> +		 */
> +		if (f_attr.ids.size / sizeof(u64) > MAX_IDS_PER_ATTR) {
> +			pr_err("Invalid ids section size %" PRIu64 " for attr %d, too many ID=
s\n",
> +			       f_attr.ids.size, i);
> +			err =3D -EINVAL;
> +			goto out_delete_evlist;
> +		}
> +
> +		/*
> +		 * FIXME: see perf_header__process_sections() =E2=80=94 block
> +		 * devices bypass this check because st_size is 0.
> +		 */
> +		if (S_ISREG(input_stat.st_mode) &&
> +		    (f_attr.ids.offset > (u64)input_stat.st_size ||
> +		     f_attr.ids.size > (u64)input_stat.st_size - f_attr.ids.offset)) {
> +			pr_err("Invalid ids section for attr %d: offset=3D%" PRIu64 " size=3D=
%" PRIu64 " exceeds file size %" PRIu64 "\n",
> +			       i, f_attr.ids.offset, f_attr.ids.size, (u64)input_stat.st_size=
);
> +			err =3D -EINVAL;
> +			goto out_delete_evlist;
> +		}

[Severity: High]
This is a pre-existing issue, but does this adequately prevent resource
exhaustion if the ids sections overlap?

Even with the new MAX_NR_ATTRS (65,536) and MAX_IDS_PER_ATTR (16,777,216)
caps, could an attacker craft a 134 MB perf.data file where all 65,536
attributes specify the same ids.offset =3D 0 and ids.size =3D 134MB?

If so, the tool would allocate approximately 1.8 GB of memory for each
attribute and then read the IDs from the file into this allocated memory.
Because the subsequent loop reads into the memory, it bypasses lazy memory
allocation by forcing physical page faults, leading to approximately 120 TB
of physical memory being allocated and reliably triggering the system OOM
killer.

> +
>  		tmp =3D lseek(fd, 0, SEEK_CUR);
>  		evsel =3D evsel__new(&f_attr.attr);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D19
