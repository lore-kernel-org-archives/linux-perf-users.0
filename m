Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2138C2BF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662981; cv=none; b=V6taeAjIvGt4l8UgGmSvxqiFH9hpvO0XWyntuURPgfknTjJa1wRzb6RnfTCCbyOBnXXBPqoH+n0zlMoTlSsmUlgkFyLcCPXE9bofGYSLOqSEZvUm8rdXqrhR5WpOTovwDUucHAmI2Wn52QmMhpukkWPn+9i5A2RmWdwDE0Tqg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662981; c=relaxed/simple;
	bh=qgzOm9cppt6UGcUdhjgLR3tBqRm9h5Xat8df0OqYvFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cLJZQ6NGMSa24pN6nOMR4O7MmrL9BVJc+oUyPqx2g3e0J6wyTkovfBs+N7hIeBRkuqZog1FfTwA92Dcj6AaQODMtNFMT2AxI0bM4p0VXJU1DcOkLl/Hpnr+RbPHIvLGnWooNVgeMWehkQ8070VokMEt0sfQqBQ7OjllBlse9sTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfPJLMY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfPJLMY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0FC1F000E9;
	Fri, 10 Jul 2026 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662980;
	bh=F1Qb6aE4mhuVsxAzc//JtIOKkASsyhU7tnhpCsPwhbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfPJLMY9OmnG7lrOvz0X60sHgUq2c2dCxl9SCsV9+MpKqxPPABoVb34WMAKUVxiCR
	 VWj7PrttbZMvMX6Q40ZjMeSRp3dCx9rshOVfuVMjDh0xYwPJFyOQy6GyoBcqtM6wv9
	 4zlaaozwbjG9+dvquHuCOKnr6BkgULn8RPlxph/weYyJ3HT7/1Zlu9DTR3rpCgJX7p
	 F3b0BIuTW2Hh9dUl3r+8KIGRYNqjg+xZc+YeyWebIInzwWLbOehI0X3p1gS8a2Xwam
	 9jxe2UC2vcYp3wdhHX5bhuNdzIBRkQy4gV51PWNShvms1SK92OrHWcqJhtUy6JU8vT
	 KS4Wp689lNFyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf record: Fix teardown hang on system-wide
 multi-threaded sessions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710053927.1864021-1-irogers@google.com>
References: <20260710053927.1864021-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:56:19 +0000
Message-Id: <20260710055620.3B0FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch unconditionally skips `fdarray_flag__nonfilterable` file=
 descriptors in `fdarray__filter()`, causing a memory leak of `perf_mmap` r=
eferences and an infinite busy loop if a system-wide event or other nonfilt=
erable file descriptor receives an error (e.g., POLLERR, POLLHUP).
--

--- Patch [1]: [PATCH v1 1/2] perf record: Fix teardown hang on system-wide=
 multi-threaded sessions ---
commit 6940fed42e3ec7ba75ed80d3ab8c1cc4f0aad35d
Author: Ian Rogers <irogers@google.com>

perf record: Fix teardown hang on system-wide multi-threaded sessions

This patch attempts to resolve a hang during teardown in system-wide stream=
ing
mode by adding explicit evlist disables. It also modifies the fdarray filter
logic to bypass nonfilterable file descriptors when processing POLLHUP sign=
als.

> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index f0f195207fca9..3bfcd2aa7c07f 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -115,6 +115,9 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  		return 0;
> =20
>  	for (fd =3D 0; fd < fda->nr; ++fd) {
> +		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> +			continue;
> +

[Severity: High]
Does skipping the filter logic for non-filterable file descriptors here cau=
se
an infinite poll loop if a system-wide event receives an error?

In tools/lib/perf/evlist.c:mmap_per_evsel(), system-wide event file
descriptors are marked with fdarray_flag__nonfilterable:

    flgs =3D evsel->system_wide ? fdarray_flag__nonfilterable : fdarray_fla=
g__default;

If one of these file descriptors encounters an error like POLLERR or POLLHU=
P,
it seems this new continue statement bypasses the block that clears the eve=
nts
mask and invokes the entry_destructor.

Could this cause poll() to continuously return immediately with the same
error, leading to a CPU busy loop and leaking perf_mmap references since the
destructor is skipped?

>  		if (!fda->entries[fd].events)
>  			continue;
> =20
> @@ -126,8 +129,7 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  			continue;
>  		}
> =20
> -		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
> -			++nr;
> +		++nr;
>  	}
> =20
>  	return nr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710053927.1864=
021-1-irogers@google.com?part=3D1
