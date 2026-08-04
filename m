Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF73F3264
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870743; cv=none; b=Wgwct5eDLIqYCWY7haTh3VRaZnmO7ilJcEAWXP41rGGogJZRB+FB/iQQYinH8j50zXQYUmI2rQkRd5WJczt1HWnWQijcDJ1HQ/xiUpqNl9ebrFQuwAcNg2J2WC5yCnpdGUdsHFkKn5jZZ1+JNoQfWJN4warGykMDuwWn6z3HmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870743; c=relaxed/simple;
	bh=KeL5yCOn4kWebsfV/ME8mE7jONYYv2ThmurTZW8eoXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z0zAgY/nyYrYT7Mt0EI6LV63N+c4rvBbWgURRXTchI1+0tdgGp6SbFZmeVUKBY1xJRLO8AFMjMKHJMK41Mp8zHnlVO5txLG7y+JrW76HMDN7+k5enbIjhM0Ljzhc7lgc9dmmy4O+/IqW5q3tyoHXx8pokxv19q/bKjO16y5IT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLsICt4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLsICt4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C921F000E9;
	Tue,  4 Aug 2026 19:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785870741;
	bh=ZHaK0bh3uGq+2K8fZw5UQtuXh7rkefra/HMuVTO8gNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLsICt4GvHmsTxHWXWeb4CpQgcwsM5Q5eBQJLorFt7xQDL/6Xd1JlkQGZ4+OYb0gg
	 gtF6fAb/PMFEQI1EX2hmQ3XTjKt+UksHVDCZDC8nxkCwLOhz1TNEp465zN4L+zuG15
	 J4wmOrEWexLlkp8gjrmmlu2qiSFm7ru4TIvdAybpLLe1+xnI4MDu2/kX8/02kQMof7
	 uOGghYErmTvvOKWWx63Sq9bkpEpyCH6Tug/IARPVr+LB7Hw21voULtN0tJ5O2hItyV
	 RxEEoKtU//I+Fc3cP/zLp5Wg/czcrhSW6PO4XQF8C89v91eyZvTm4moz9+to309P34
	 yntLtIDWPdunw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260804185830.228763-2-acme@kernel.org>
References: <20260804185830.228763-1-acme@kernel.org>
 <20260804185830.228763-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:12:21 +0000
Message-Id: <20260804191221.84C921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent error masking and inconsistent propagation for -ENOMEM du=
ring sort and output token parsing in setup_sort_list() and setup_output_li=
st().
--

--- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked =
caller errors in hpp_list__parse() ---
commit c1a9e4a1694a477755b6abff539aa40b1fed31e1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__=
parse()
   =20
This commit fixes three bugs in hpp_list__parse() by checking strdup()
return values and adding a cleanup label to preserve early errors. It also
converts PARSE_LIST to a function, changing called functions to return
appropriate error codes like -ENOMEM instead of -1 on failure.

> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 005e7d85dc4a5..616a583e3d4d6 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c

[ ... ]

> @@ -3869,8 +3877,7 @@ int sort_dimension__add(struct perf_hpp_list *list,=
 const char *tok,
>  				    strlen(tok)))
>  			return -EINVAL;
> =20
> -		__sort_dimension__add(sd, list, level);
> -		return 0;
> +		return __sort_dimension__add(sd, list, level);
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(memory_sort_dimensions); i++) {

[Severity: Medium]
Since sort_dimension__add() can now return -ENOMEM, could this introduce a
regression where the callers in setup_sort_list() and setup_output_list()
fail to handle the new return value?

Currently, setup_sort_list() only checks for -EINVAL and -ESRCH:

tools/perf/util/sort.c:setup_sort_list() {
    ...
		ret =3D sort_dimension__add(list, tok, evlist, env, level);
		if (ret =3D=3D -EINVAL) {
			...
			break;
		} else if (ret =3D=3D -ESRCH) {
			...
			break;
		}
    ...
}

If sort_dimension__add() returns -ENOMEM, the loop will not break and ret
will be silently overwritten on the next iteration.

A similar issue appears to exist in setup_output_list() which ignores
-ENOMEM from output_field_add().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804185830.2287=
63-1-acme@kernel.org?part=3D1
