Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DD33EC
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784629; cv=none; b=RLhLP1fd24FlLXkoxN+QOcvr6oJIhXxoboIEKCYc1+3oyZzvzLp82tFcE9kvr011CcYTBmAo5OzwduAHaPlLKW7+AGL0bs/Q2dIZ7Lwx43FfkEYeGYUoG38aVNVEv1aepPtQToHp0ozQ8KzNsEFfY3wYGAIdVaw6s9s2PjM5374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784629; c=relaxed/simple;
	bh=zTJgz+/uMaOpDXg7JUi3dOl5Dtufrt1FjToEf2+l6xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NR0jPk5VfE07hpwrwIYVNuc+5ZaSVRilSHL9mXFYNj315FQKKEl1Fp5jk3JK6pM0hq6foRDP+8JY3spc5duuhRnZkqCqh6NVQEltkQcY/3QqPK//CjsAP9ZrCeRpUb7NsOu2SUv2TdWslpb2uImh5e0my47/a00ClT75BWzkOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YswLxiBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YswLxiBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B28C4CEF7;
	Fri, 10 Apr 2026 01:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775784629;
	bh=zTJgz+/uMaOpDXg7JUi3dOl5Dtufrt1FjToEf2+l6xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YswLxiBnKWL1pX5tuHt355EXSdCL5AG7qok8az+7gjeAPyjzCvrpkqwCQmbxmXkCD
	 M3EObgPYitMt1F3L3+OdJT6/BPb+GtQSdGWg0bUUHIZukp7GiVtRqKLIcgfBfMeHDe
	 h9jSWHN/7Tw/iVHoip7C48juMlSqXNgK8GG0cNOoZETKYSFX2SOTC/Q3JwJkmmCxhh
	 Php4ATQ6o8LqSyJkg2g+bR5BJYyuRyKExjsHA4TC9GwL8jWD0rRW1hUVWoBYc0yRd0
	 67+z/dZg1coa1wn8nhgS/NfBNs/fNjrWUUIuP0nCS9uMPCOZzt9vM+MbVA0iTuCkNz
	 p/LdFHrZrV5jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] perf header: Add sanity checks to HEADER_BPF_BTF
 processing
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-14-acme@kernel.org>
References: <20260410004000.148138-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 01:30:28 +0000
Message-Id: <20260410013028.F1B28C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Brittle dependency on macros defined in another function's scope.
--

commit 2ef335810a8ef7ba04bf003c542540f62231696e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Add sanity checks to HEADER_BPF_BTF processing

This commit adds bounds checking for BTF entry counts and data sizes
when reading HEADER_BPF_BTF from perf.data files to prevent excessive
memory allocations.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3619,6 +3619,17 @@ static int process_bpf_btf(struct feat_fd *ff  __m=
aybe_unused, void *data __mayb
>  	if (do_read_u32(ff, &count))
>  		return -1;
> =20
> +	if (count > MAX_BPF_PROGS) {
> +		pr_err("bpf btf count %u too large (max %u)\n", count, MAX_BPF_PROGS);
> +		return -1;
> +	}

This isn't a bug, but is it safe to rely on MAX_BPF_PROGS and
MAX_BPF_DATA_LEN being available here?

Looking at tools/perf/util/header.c, both of these macros are defined local=
ly
inside the body of process_bpf_prog_info(), which happens to precede this
function in the file:

static int process_bpf_prog_info(...)
{
    ...
#define MAX_BPF_PROGS 131072
    ...
#define MAX_BPF_DATA_LEN (256 * 1024 * 1024)
    ...
}

While the C preprocessor allows this since process_bpf_prog_info() is
evaluated first, would it make sense to move these macro definitions to
the file scope or a shared header? This would prevent hidden dependencies
and compilation failures if these functions are ever reordered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D13
