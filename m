Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FB3CDBD3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882491; cv=none; b=ISpHOAoz4kY1MjmGthN2O7LAeNI4VLbiiAtqlV1I1bIKVq3jRYDH/wERsXoZNN9BW6eMzLod0CBHC1cZrwgHoxb55VWSxhVYJbr1qTJM1KZvhjFV9audgfRINE6A/lGQGE8lNsgMuW4JmdZBHepsJJmvlaYuwmsrcSjeueLwAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882491; c=relaxed/simple;
	bh=VEuHDqgpdd280ERysUOM235XAE/kHJj7iiI71ioGEZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D+0eT3EpcNtyCHFzc+unO8eFyHa3+Id+GHIstRucsbihT+abwBPhpzC6isoqgiwh/dwHPvTcBmy5IHkH/gpUip4t60GWndgHs50375VJa5srV8sovRnOPWgFHO+faHrODBxVRKOv7Rv1oc7Qm6I8941Sjcdh7gzkeN7bG0POHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjZTYsaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjZTYsaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9EB1F00893;
	Sun, 20 Sep 2026 05:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882490;
	bh=Mk3AhpQagRHvAKy5qmAiu/3NJYPVSs5D8id6wg0u2JU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjZTYsaPVJjYY2fl4OfPjUI9dY3v8H88cyBDEnoD1gSUH2C5szTAfPA035+Z5wJyo
	 EEzWdZB795VY21J+UOEgFkUBrDn1Jd7Og8eGkcYTRi1pns82Soft8FHLvK5cAyR6Bx
	 /ZgxeRfUz0CzQ50nGgJkHajvZnKP7s9kWMF6rTe0ne3UCqqot0s1aMYwLRZX3aHda9
	 hht4c9IRvxavZtY4vKSupHF0e8A0HpfNC0C71qYFcAFxbirjPHDaN2TaFEe5QVFwtk
	 WC2OHHxNgbwj3XhAwY3mq9DEiABeCxexSLzpB6jn/wr8GVLkdODr2QSMi9sc5KCWJW
	 +68NVMn0DLzpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/49] perf python: Expose addr location,
 transaction, and context_switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b8e1b4ae6cb475a56bcd2c48130ac1f8ca036ddb.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <b8e1b4ae6cb475a56bcd2c48130ac1f8ca036ddb.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:34:49 +0000
Message-Id: <20260920053449.CB9EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: incorrect python type hint for srccode() returning (None, 0, =
None)
--

commit 8f57fbf429042a11c8af6cec00438eccce96b9f8
Author: Ian Rogers <irogers@google.com>

perf python: Expose addr location, transaction, and context_switch

This commit exposes additional perf sample fields, branch/transaction metri=
cs,
and context_switch callbacks directly to the Python extension. It also
populates sample machine_pid and vcpu when perf_guest is enabled and updates
the perf.pyi type stubs for methods like srccode() and insn().

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> index e5259e9b61dd3..7f747eed3eda3 100644
> --- a/tools/perf/python/perf.pyi
> +++ b/tools/perf/python/perf.pyi
[ ... ]
> @@ -206,10 +208,18 @@ class sample_event(_sample_members):
>      symbol: str
>      sym_start: int
>      sym_end: int
> +    sym_offset: Optional[int]
> +    addr_dso: Optional[str]
> +    addr_symbol: Optional[str]
> +    addr_sym_offset: Optional[int]
> +    branch_type: int
> +    in_tx: int
> +    flags: int
> +    transaction: int
>      brstack: Optional['branch_stack']
>      callchain: Optional['callchain']
> -    def srccode(self) -> str: ...
> -    def insn(self) -> str: ...
> +    def srccode(self) -> Optional[tuple[str, int, str]]: ...

[Severity: Low]
Does this type hint correctly match the C implementation?

Looking at the C implementation in pyrf_sample_event__srccode() in
tools/perf/util/python.c, when the source file is not found it returns
None for the strings:

    if (srcfile) {
        ...
        result =3D Py_BuildValue("(sIs#)", srcfile, line, srccode,
                               (Py_ssize_t)len);
        free(srcfile);
    } else {
        result =3D Py_BuildValue("(sIs#)", NULL, 0, NULL, (Py_ssize_t)0);
    }

Since Py_BuildValue with "s" formats NULL as Python's None, the return type
here is effectively (None, 0, None).

The type stub asserts the tuple elements are strictly str. Should this
instead be Optional[tuple[Optional[str], int, Optional[str]]] to avoid mypy
static analysis false positives?

> +    def insn(self) -> Optional[bytes]: ...
>      def __getattr__(self, name: str) -> Any: ...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D8
