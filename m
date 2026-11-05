Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864228;
	b=2xnJiHf2DX77StXSdp3SBEmF/8YyPn7l/0h3Ix/BPnYnO/zNl9fsb9XjmwRJggFm74KZ
	 cTFMeT/bg5XAUf5ROxYHTpCX7pkpMkTQSA9yUP7mgKOmvEUu1bnSOci+cCeGon/0MJwHN
	 XfuzELmp/wku5i1VtcRMKwjdgDu0mPpvJiZgFTrCywCC3Oy42CpwN9jz9FM1mzibOgnxH
	 86ILMzYuEHD86+PUiHubNrY5fCMPHKf0iflPXqv9VUDQWO2u6SRjMdPcgcmmf+iZetJPy
	 787O+siHEEV4BWnFjSN5uv1NvEFRPnCEndujlDMVEPX/tMBtYHcT7EPSYv2MOmZtWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8rc0xzBIqAZYvJqDO1Y//UYhKAdZfm13wephqsqYBkI=;
	b=nCNO16k8kVVxjnvF0DXzxLMWc+N6VEvev43vaxssUV64h/kaF2pzP/a7bRYrlIVCUs0p
	 v3dZWUh1g1esHHBm1vjwFkKVnJv6jjAulTl3W5pFwYmzDV6Q4/z773u4W0VGwqzdps1lU
	 XdANFKLsxiAxW8m0NEi0/ulYBudOFk1Pj6/j4pCG7uMG6MrVKOjaWAUnardIzzZRUF9v8
	 7RlEp5z3oTO4iZiwC0Q6xC459yuqPv379ZVHD1pQGBykpa79TJYNrOhHF7N/CGND8l3hU
	 NP9R5W5jOHsfV3X8Brlx/RqqL4EK9pNNNDeG9NnymaUJHs6xAeyWFmsSTsU9aOOrdqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeJ0c8Jz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88768606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeJ0c8Jz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB21B1F000C1;
	Thu,  5 Nov 2026 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864228;
	bh=8rc0xzBIqAZYvJqDO1Y//UYhKAdZfm13wephqsqYBkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AeJ0c8JznNsHJ5lhsTSAS0yaVrUrWj4sgcUdzDcth9kJceQT/kH2ndxrQCeHePE6z
	 v1ORhxLgRVQFjEM5BmsyUuDH6at4FG1L85txPhzAx40dHIg21+i/4/+TkZ1lE/MQfb
	 na37v3YyyFAhZAUPTtdD4+3vnJtemn3aHaIRMdFzdO62kma6e1ZsDeT6qnsPJh5Krd
	 OwaZF3sVrAmkn6go22UJQb1LQFWvEXFntIg0fw/veHGaE+FZpSWEL5xsF/siv1SSL8
	 +s/UQTrRdSq2VGvs2N0hcV4fdN1FvFHGXweEL9PHYYLEdQ7xiaMWpTQhVhjqadz0BU
	 btDXR8MGuAwwg==
Message-ID: <sashiko-outbox-198684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Fix perf probe testsuite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105071711.31086-1-namhyung@kernel.org>
References: <20261105071711.31086-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:37:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: skip_if_no_debuginfo() falsely skips tests when debug=
info is present
--

commit c8d75c8c4279c6a4cb8737397d31f026d6424692
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Fix perf probe testsuite

This commit updates skip_if_no_debuginfo() in
tools/perf/tests/shell/lib/probe_vfs_getname.sh to match the "Could not find
probeable line" message emitted by add_probe_vfs_getname() when checking
whether kernel debuginfo is available.

> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf=
/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f67..3a78f1d6eb165 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -39,7 +39,7 @@ add_probe_vfs_getname() {
>  }
> =20
>  skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path f=
or the kernel|Debuginfo-analysis is not supported)|(file has no debug infor=
mation)" && return 2
> +	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path f=
or the kernel|Debuginfo-analysis is not supported)|(file has no debug infor=
mation|Could not find probeable line)" && return 2

[Severity: Medium]
Does matching "Could not find probeable line" here cause
skip_if_no_debuginfo() to report missing debuginfo even when full kernel
debuginfo is present?

In tools/perf/tests/shell/lib/probe_vfs_getname.sh, add_probe_vfs_getname()
pipes stderr from perf probe -L getname_flags into grep when searching for
source lines matching initname, result->uptr, or result->aname:

    result_initname_re=3D"[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
    line=3D$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_r=
e" | sed -r "s/$result_initname_re/\1/")
    ...
    if [ -z "$line" ] ; then
            echo "Could not find probeable line"
            return 2
    fi

Because stderr from perf probe -L is filtered through grep, any actual
debuginfo error message is discarded and add_probe_vfs_getname() prints
"Could not find probeable line" whenever line is empty.

However, line is also empty on current kernels with full debuginfo and
sources available because commit 9fa3ec84587c ("allow incomplete imports of
filenames") moved initname(result) into do_getname(), leaving getname_flags=
()
in fs/namei.c as a wrapper:

    struct filename *
    getname_flags(const char __user *filename, int flags)
    {
            return do_getname(filename, flags, false);
    }

It is also empty when compiler optimizations omit probeable line numbers in
getname_flags() (which commit 92b664dcefab handled), or when vmlinux DWARF
debuginfo is installed without kernel source files on disk.

When tools/perf/tests/shell/base_probe/test_adding_kernel.sh calls
skip_if_no_debuginfo():

    skip_if_no_debuginfo
    if [ $? -eq 2 ]; then
            NO_DEBUGINFO=3D1
    fi

wouldn't this change cause NO_DEBUGINFO=3D1 to be set unconditionally on
current kernels regardless of whether DWARF debuginfo is installed, skipping
the DWARF testcases in test_adding_kernel.sh that do not depend on
getname_flags()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105071711.3108=
6-1-namhyung@kernel.org?part=3D1
