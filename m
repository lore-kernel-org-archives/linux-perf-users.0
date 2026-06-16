Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29737AA87
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573909; cv=none; b=KzLOFB+fETQRbhGlsTDAPxltZZELee7wSQjiqzOC5H404uzPEsLXu2MGYEUIEKeAAGOJgvMf+IR/usAj3yKxA7cn1EXccmGifPrfBI7u+R3jvqvRU9yRMqqk7o7+7Kq/qX14NCLGzpK7AoadO06FTEsWy9PlqCrWh7Vh6s7o7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573909; c=relaxed/simple;
	bh=s+Ke+5LNMF/fA3rOrO/IusfGOyM+M9VSKh1bX4SCwdE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=otnooBNHFPcErTAqVN/QEHPo1+UHrXxgft3mVTWRJOBkAVGVGHVbp4uyRy7r+P87grnF2bk9dyMtkjwfWQnwL+eCyby8ebmYaE3iAFX+ev+JCERMhITHCNu7t5XguJCMtZX9VBXX2EO0zd7r9mrjAvwsEKb82lIk3uUEuovf0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC0vwbfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC0vwbfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15C11F000E9;
	Tue, 16 Jun 2026 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573908;
	bh=6KvP1cuhUk0He4jVTQkDrAxg8bvBRjaTWT9tJ4bPICo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QC0vwbfGeJVXKkIEoYfb69JmKKZC6E5kRQT7cIIMd1HyLKTnwza0m5Rva7XOXGOge
	 /xkIGNPZnFIEbvxkExxICj/Qa0nd0TBZfw+RzhycciwtRuqzFd5Iu7sdDa4+1Q98Fa
	 T+/XI0au4YPzGFQpBTMH33HlSFZFLNXK133nv0smONVfDDqIPNxrP3sWhFXn14yi0+
	 py8J72Bw7yytSN9CuXPfpi64oqAWVRhJGnHkjwZ86mdzJwoBAxLau5uthQhgfjzQBC
	 Z5AcJDz/GSGc5N0lY3D6DZZt2l52uF/zIXGiqLZV3l1hydkkws2/AkFYKwWEEg3WuZ
	 Ch0QBKZqfvgJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] perf dso: Set standard errno on decompression
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616010834.37618-10-acme@kernel.org>
References: <20260616010834.37618-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:38:27 +0000
Message-Id: <20260616013827.F15C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error paths in `dso__get_filename()` and its callees fail to initi=
alize `errno` before returning `NULL`, which causes `__open_dso()` to evalu=
ate `fd =3D -errno` as `0`. This mistakenly hijacks standard input (fd 0) a=
s a valid DSO data file descriptor.
- [High] An integer underflow in `dso_cache__memcpy()` can occur when readi=
ng after a short read, causing an out-of-bounds heap memory access.
--

commit edef5ff69168425f269de2888a6e30ebd8c6891a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Set standard errno on decompression failure

dso__get_filename() sets errno to a negative custom DSO_LOAD_ERRNO
value when kernel module decompression fails. This commit changes it
to set errno to EIO instead to avoid producing a valid-looking file
descriptor.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c

[ ... ]

> @@ -600,7 +600,13 @@ static char *dso__get_filename(struct dso *dso, cons=
t char *root_dir,
>  		size_t len =3D sizeof(newpath);
> =20
>  		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
> -			errno =3D *dso__load_errno(dso);
> +			/*
> +			 * Use a standard errno value, not the negative custom
> +			 * DSO_LOAD_ERRNO stored in dso__load_errno(dso):
> +			 * __open_dso() computes fd =3D -errno, so a negative
> +			 * errno produces a positive fd that looks valid.
> +			 */
> +			errno =3D EIO;
>  			goto out;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing how errno
is handled here, I noticed other error paths might return NULL without
initializing errno.

For example, earlier in dso__get_filename():

    if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
                                root_dir, name, PATH_MAX))
        goto out;

If dso__get_filename() returns NULL and errno happens to be 0 from prior
execution, could this cause __open_dso() to accidentally hijack standard
input?

__open_dso() computes the file descriptor as:

    else
        fd =3D -errno;

And then open_dso() treats fd >=3D 0 as successful:

    if (fd >=3D 0) {
        dso__list_add(dso);

Would this result in fd 0 being registered in the global dso__data_open
list, causing subsequent pread() calls to read from stdin and eventually
incorrectly close(0)?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential bounds
checking problem in dso_cache__memcpy().

Is it possible for cache_offset to underflow in this sequence?

tools/perf/util/dso.c:dso_cache__memcpy() {
    ...
    u64 cache_offset =3D offset - cache->offset;
    u64 cache_size   =3D min(cache->size - cache_offset, size);

    if (out)
        memcpy(data, cache->data + cache_offset, cache_size);
    else
        memcpy(cache->data + cache_offset, data, cache_size);
    ...
}

If a previous read of the file chunk returned a short read, cache->size
will be smaller than DSO__DATA_CACHE_SIZE. If a subsequent read accesses
an offset past cache->size but within the same chunk, cache->size <
cache_offset becomes true.

Could this cause cache->size - cache_offset to underflow to a massive
positive value, causing min() to select the caller-provided size, and
leading to a heap buffer overflow during memcpy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616010834.3761=
8-1-acme@kernel.org?part=3D9
