Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FE1DD889
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078666; cv=none; b=Z2e6c38NWY14qHEQpoPEEd53JtAfAXZNVCEzkhAFHo98gkOLsLrUJtTfBxvdsFxPnJC+zrGKUK8/jKcrOLUr3mOn99/CXkn+/d7WhGbvzQcMJo6yUuIe8HOqfrMz8T5bwPfAGrlmZx+zxfU0QMlZ/Zj8b/kqZoydydOCLMO4LrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078666; c=relaxed/simple;
	bh=nV7ezGfF9vLrpYIoIoxn36J1xCyseURp1WMV5vN/vZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aTat/ugPEVdhWvAS+tkaxB0r2C0uf/PT4eELeg4SI6UdG2a9MiRyCMAs0DM0qrzZ0bR70CVkfrDlXG0ZQZkyVOdwgAihfdmQhIe4NUAFUcOlYuIO8C6tWT5wWdlu7Riyjzjm6wEcHzPrYTHiHZ7uAu1c3Hh0A+rAJZGBwMM8mrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZDKjzJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZDKjzJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BCEC19425;
	Sat, 25 Apr 2026 00:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777078666;
	bh=nV7ezGfF9vLrpYIoIoxn36J1xCyseURp1WMV5vN/vZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dZDKjzJW1F1iSbPLkdNfFXRqIA4AxsiMG+kkrIPGA/CYYk80O+Hna3nupQe5DTZS3
	 rThH8Q9blhIF2J5Vk2dW5k+Ybk5oNSK74EHUgTAHkKmQg+19Hc7VefTrmUEhABKxG7
	 Is5mUJvGZz9ZBt5ZpfBkppJja2ZoamKVrhOmpyaRADPkF/IY4PrZbE8NlWjG3oZHav
	 cBSTO5Db2UmoyWkVm16vryS/OldCIfoqY6AVJTyK5gf3KYcHYuCCF0prV+z4gSEKaJ
	 lWG1WmlLmtZC06Fd9R/MTW2KinOFGdW6hcJkmYmMybEWaOLNGZk0o4ypHXs3AhET78
	 4/03+fvKNTQ9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: probe_vfs_getname add do_getname() probing
 fallback
Reply-To: sashiko@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260416125515.3481495-1-tmricht@linux.ibm.com>
References: <20260416125515.3481495-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 00:57:45 +0000
Message-Id: <20260425005746.36BCEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Out-of-bounds kernel memory read in `do_getname` perf probe due =
to unterminated string.
- [Medium] Missing user-space pointer fallback logic reduces test robustnes=
s.
--

commit 44caa018a80d8e3283b4eda7b6e0f0690afbe123
Author: Thomas Richter <tmricht@linux.ibm.com>

perf test: probe_vfs_getname add do_getname() probing fallback

This commit extends the vfs_getname perf test logic to fall back to probing
do_getname() if getname_flags() does not match. This reflects updated kernel
code where the getname_flags() implementation was changed.

> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf=
/tests/shell/lib/probe_vfs_getname.sh
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

Does this probe cause an out-of-bounds kernel memory read when the path exc=
eeds
EMBEDDED_NAME_MAX?

If a user provides a long file path, strncpy_from_user() completely fills t=
he
fixed-size result->iname array without appending a NUL terminator, while the
actual NUL-terminated path is dynamically allocated and pointed to by
result->name.

Because the probe explicitly instructs the kernel to read result->iname as a
NUL-terminated string, could the kprobe fetcher read past the end of the in=
ame
array into adjacent slab memory? Should this use result->name:string instea=
d?

> +			perf probe -q "$param" || perf probe $add_probe_verbose "$param" || r=
eturn 1

Is the user-space pointer fallback missing here?

The original probe logic for getname_flags robustly handles compiler
optimizations by falling back to probing the user-space function argument
directly (pathname=3Dfilename:ustring) if reading the kernel result struct =
fails.

This new block for do_getname instead retries the exact same probe string, =
just
adding a verbose flag. Since filename remains the first argument to
do_getname(), would it be safer to include the filename:ustring fallback to
prevent the test from failing on certain toolchains?

> +			return 0
> +		fi
> +		perf probe -q "vfs_getname=3Dgetname_flags:${line} pathname=3Dresult->=
name:string" || \
>  		perf probe $add_probe_verbose "vfs_getname=3Dgetname_flags:${line} pat=
hname=3Dfilename:ustring" || return 1
>  	fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416125515.3481=
495-1-tmricht@linux.ibm.com?part=3D1
