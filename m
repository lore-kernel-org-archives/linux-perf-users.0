Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25A19ABC6
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990322; cv=none; b=K6I3UrOOpMQmyUFBJkBDZNqUnz11QctpROPmwHQnKU8VntKrUkrWZIOGtM3a97dDPylZETPLSp8BW8sPWVmAbjN2t9CsEYj2GKNUkrVY8UkC54Yx/3bK/0X1TfIqlU7kfVjW+tMtdYoXRI4/6DxUxvt9VjbOll3RnotIUIADLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990322; c=relaxed/simple;
	bh=nZjxT+z8TchrsfWGLjwv8EpkRKG4TA3kpOcQCOCTZC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLv9J+oYA8rJUKByEqA0m4akQTqkCzUdMeprfu6vOfJXWzPF2j12ZN1UHnEO6MQycFOpHejZNx6Ut8a3fdq3uPyQJuNOMOVYJiQ+vqlfBj/mS86VVaPDt7/VokCxcTK58aFHr9EKlwXPivHwPocBq5gStaXBTixfQimnaiAZv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV7TtzHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV7TtzHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E5E1F000E9;
	Tue, 14 Jul 2026 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783990320;
	bh=5AMyhJKDsJw/8ic+Q050Qv3rs8vKM2/8hqmN7MkYqik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZV7TtzHOvc69QbVEjy3BT3KozL+uyKHkevwrnhQV47rsnN+91y4BNTott3xjB0UBE
	 CJFJymcqtvgtOkHnqHCXFOvjEJ9dHGjK5OWG6YmDAcLng0fjEtr90+e3qU9sWJfYZN
	 DWgb0lAaBy8G+beqR3a9cpMOd+nWBwVnmbHuh7r5OmLnYSMTMCxak0uRAcnCtZVdaI
	 sSVzeg5eajpGgW4+bpAyLTep9B67aK0KCmYSWCkzc8Bt+vLvo6gnq/BCgfO/f9P/if
	 +63d1g/qI811Clwi8GvbEE/GAt6I6GhgHe21CGbt2AlUXgKsDPy7BnKiToWMHRiYGj
	 YXd6dLDSndm7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714004359.179451-2-thomas.falcon@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:51:59 +0000
Message-Id: <20260714005200.80E5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Severe pre-existing stack buffer overflows and integer underflows =
in `perf_mem__*_scnprintf` functions due to unsafe `strcat` usage and missi=
ng bounds checks.
--

--- Patch [1]: [PATCH v2 1/6] perf mem: Fix size tracking for mem_lvl's in =
perf_script__meminfo_scnprintf() ---
commit cf8f02c307060f141740bb3567a69f77761e0f5f
Author: Thomas Falcon <thomas.falcon@intel.com>

perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf=
()

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fcc..4e490f9cd3488 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D scnprintf(out, sz, "|OP ");
>  	i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -	i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);

[Severity: High]
This is a pre-existing issue, but does passing sz - i here risk an integer
underflow and stack buffer overflow in the callee if the buffer is already
full?

If previous fields exhaust the buffer, sz - i can be 0 (or wrap around if
i > sz). If 0 is passed to perf_mem__lvl_scnprintf(), the size decrement
at the start of the function will underflow:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
        sz -=3D 1; /* -1 for null termination */
        out[0] =3D '\0';
        ...
        strcat(out, "Remote ");
}

When sz underflows to SIZE_MAX, out[0] =3D '\0' writes out of bounds, and
the unbounded strcat operations can corrupt the stack if a malformed or
untrusted perf.data file sets multiple bits in data_src.

Does this same unsafe pattern also exist in perf_mem__snp_scnprintf,
perf_mem__tlb_scnprintf, and perf_mem__blk_scnprintf, which all start
with the same sz -=3D 1 decrement?

>  	i +=3D scnprintf(out + i, sz - i, "|SNP ");
>  	i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|TLB ");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714004359.1794=
51-1-thomas.falcon@intel.com?part=3D1
