Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54247DFB2
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189958; cv=none; b=nmE2SODSZb5Od2qq1bar+OSiiLakt1FPIRf3iIsxufz53qxyZPfkQTWfZHYoXK/w/m5Czg0Y6xqI52Hsy2jlJrZenIafQNuAWMCRe8tKHGe/tzdmz+d9nfCtXBJjl33wEyETdsDajKgndcI9nOBTTwThPfrJpZPNhXPCNcnApfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189958; c=relaxed/simple;
	bh=wPf3ukW3BwjSCr8/g2mCDB+huSanh8MAItPtDcuVKo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rYACUVjAGuADi4BfcKlh597E9r+8DmAUmvuWNGgBk9Qt/7BVTR3T9dEgM+ydWsWjexCFVYMlXLF8+oV/d9SpEeUVSA8SaQZJgRgPU7lCQe+YxxGEVAzO4fzO8u0SZG708C75K1pHhNtB8BRwEZFR0Bfy8nN7ctTI2GdDncyCsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdPADeEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdPADeEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F588C2BCB3;
	Tue, 19 May 2026 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779189958;
	bh=wPf3ukW3BwjSCr8/g2mCDB+huSanh8MAItPtDcuVKo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jdPADeEVOMS9aPk4574wqz8rgaiw54lsHidnS3hYtwcSfuWvwOkHDBMpX1+xZlMro
	 pfXFkTzC27JuscW7zsu3JTomsOafbWTu6abb52xelYfqo0zFHAV2KLehfNZNTKrcIC
	 ifIgbkiiYVAqpgYMqzCs7hJqcMtqstlFqK1193b2x9E7keo8RQNtXtB0mS7KzMCg/k
	 g7yjUrvGcsjh9wB1Z+5hlaCpmMPgmj5iWGuskOp+r/+C4bdFgeR/XiCZbC9WQVD8Xz
	 9kD8lHsAeAnIkhmYFZbL60XhqjFJQ7d+GpNUpIf47SjAX3astZ2VTG40D8Ho94lxO0
	 dQRoErdjb2zdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH ping2 linux-next] perf test: probe_vfs_getname add
 do_getname() probing fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519110643.1424411-1-tmricht@linux.ibm.com>
References: <20260519110643.1424411-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 11:25:57 +0000
Message-Id: <20260519112558.5F588C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The fallback perf probe uses `result->iname:string` instead of `=
result->name:string`, causing out-of-bounds kernel memory reads for long pa=
ths.
- [Medium] The `do_getname` probe registration drops the reliable userspace=
 string fallback (`pathname=3Dfilename:ustring`).
--

commit eda643d967c95ab86fa0ef1c44c37f4ff13cc45a
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: probe_vfs_getname add do_getname() probing fallback

The perf vfs_getname test skips on some platforms because getname_flags()
no longer matches the expected perf probe format after kernel changes. This
commit falls back to probing do_getname() if the initial getname_flags()
lookup fails.

> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf=
/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f67..9156a79212b9e 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh

[ ... ]

> @@ -28,12 +30,24 @@ add_probe_vfs_getname() {
>  			line=3D$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re=
" | sed -r "s/$result_aname_re/\1/")
>  		fi
> =20
> +		if [ -z "$line" ] ; then
> +			do_getname=3D1
> +			result_iname_re=3D"[[:space:]]+([[:digit:]]+)[[:space:]]+initname\(re=
sult\);"
> +			line=3D$(perf probe -L do_getname 2>&1 | grep -E "$result_iname_re" |=
 sed -r "s/$result_iname_re/\1/")
> +		fi
> +
>  		if [ -z "$line" ] ; then
>  			echo "Could not find probeable line"
>  			return 2
>  		fi
> =20
> -		perf probe -q       "vfs_getname=3Dgetname_flags:${line} pathname=3Dre=
sult->name:string" || \
> +		if [ "$do_getname" -eq 1 ]
> +		then
> +			param=3D"vfs_getname=3Ddo_getname:${line} pathname=3Dresult->iname:st=
ring"

Does probing result->iname:string read out-of-bounds kernel memory when pat=
hs
are longer than EMBEDDED_NAME_MAX (192 bytes)?

In fs/namei.c, struct filename uses the flexible array iname for short path=
s,
but dynamically allocates a separate buffer for longer ones. When paths are
long, iname is filled without a null terminator, and result->name points to
the newly allocated buffer.

Reading iname as a string might record garbage data or cause a kprobe fault=
 if
it reads past the end of the slab allocation.

Would it be better to use pathname=3Dresult->name:string here, mirroring the
getname_flags behavior?

> +			perf probe -q "$param" || perf probe $add_probe_verbose "$param" || r=
eturn 1

Does this logic inadvertently drop the userspace string fallback
pathname=3Dfilename:ustring?

The original probe logic gracefully falls back to probing the userspace
pointer directly if the compiler optimizes out the result pointer at the
probed line.

Since do_getname() receives const char __user *filename as its first argume=
nt
exactly like getname_flags(), could we retain the pathname=3Dfilename:ustri=
ng
fallback here to improve test reliability across different compiler
environments?

> +			return 0
> +		fi
> +		perf probe -q "vfs_getname=3Dgetname_flags:${line} pathname=3Dresult->=
name:string" || \
>  		perf probe $add_probe_verbose "vfs_getname=3Dgetname_flags:${line} pat=
hname=3Dfilename:ustring" || return 1
>  	fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519110643.1424=
411-1-tmricht@linux.ibm.com?part=3D1
