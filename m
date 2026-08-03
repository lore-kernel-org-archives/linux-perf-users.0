Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AE1C5799
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764365; cv=none; b=EC7MAHzeB2A3lAj+SBmiYmj/5thaglNntfn9Rac0dO8yTKfj9f7/Xrw0jKF+3qDT9YpjsTyZ+8UHH9VotitOlCZ6XZHOy0nI3Gg0WgsFATNctMyFva0keIAsG3YNurnRo2+VzuIfztkyucjYNXWM392gUniGAraoSuPF5L7uRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764365; c=relaxed/simple;
	bh=oHufdLrEKU0yfKb5AqGkrg4lPat5XUuoNf/xSFQqMNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hKYRYIJgu3Wr+LvMSY6QkYnH7ORLiogXeQURPnE9YVix1gm1xZvuapElBGqklnbrwKCJM7+jbl6Ul243Pi/4jvDwMA0jkjsjfjpaiVaPFwGE8kapjL0pP8pqsf778G+sGm5bZtm97r3spaA5iAJDdh7owDD0rAyOLN4aSx5MUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAv+QXFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAv+QXFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7DE1F000E9;
	Mon,  3 Aug 2026 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764364;
	bh=kkCBhui7tiJ1lFnvFvMdlrSSF6vn7A07ciDCoUi/ycs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAv+QXFNIy6mqROS15YgAhgA5Jc0mjh8lsCzsWohLY5Mp5Sy/iVP8BqkcR5seXGeB
	 QcICQD3kRbb84lvnVL7mM/ULTj5EJvMd0mzcf564Y3a2HCzuaZ5tlf3fZtqb7nWZ0l
	 tNlzI5x6+cEaPEu++YG+9HoglqMuxODmpX57tESkXMBMOi8OS5ELp0BEKNZR2PXOjz
	 +6hZeM86A6pooeo8a4HuqIijCvK/eb5Ssf6d6MnFrhUtP3tcq9jbmro3DoC0OeBtmF
	 Vq+z6EiN93nXyxokgO2NrBOytuoohsZwEn+A22ju8rY6WyoMSHQML89snUpZmZuamd
	 iRbqN1TDSXh3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf tools: Fix double frees and memory leaks in
 cmd_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michalis Niarchos" <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803-perf-kvm-fixes-v2-4-1b337189fffc@gmail.com>
References: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
 <20260803-perf-kvm-fixes-v2-4-1b337189fffc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:39:22 +0000
Message-Id: <20260803133923.6C7DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes memory leaks and double-free vulnerabilities in `_=
_cmd_record`, `__cmd_report`, `__cmd_buildid_list`, and `__cmd_top` by remo=
ving `STRDUP_FAIL_EXIT` and the element-wise `free()` loop on `rec_argv`, b=
ut it misses applying the exact same fix to `kvm_events_record()` which suf=
fers from the identical bug.
--

--- Patch [4]: [PATCH v2 4/4] perf tools: Fix double frees and memory leaks=
 in cmd_kvm() ---
commit 0b9d8e748caa2edae90fe11689ed1a0bf618e63b
Author: Michalis Niarchos <michael.niarchos@gmail.com>

perf tools: Fix double frees and memory leaks in cmd_kvm()

This commit fixes double free and memory leak vulnerabilities in various
builtin KVM commands (like __cmd_record, __cmd_report, __cmd_buildid_list,
and __cmd_top). It achieves this by removing the use of STRDUP_FAIL_EXIT and
dropping the element-wise free loop on rec_argv.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 9504c83e20744..04cf9bd5b5959 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2018,8 +2018,6 @@ static int __cmd_record(const char *file_name, int =
argc, const char **argv)
>  	ret =3D cmd_record(i, rec_argv);
> =20
>  EXIT:
> -	for (i =3D 0; i < rec_argc; i++)
> -		free((void *)rec_argv[i]);
>  	free(rec_argv);
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but does
kvm_events_record() in tools/perf/builtin-kvm.c require this exact same fix?

The commit message notes that the fixed functions follow the same pattern
as kvm_events_record(). However, looking at kvm_events_record(), it appears
it still contains the flawed cleanup loop:

tools/perf/builtin-kvm.c:kvm_events_record() {
    ...
EXIT:
    for (i =3D 0; i < rec_argc; i++)
        free((void *)rec_argv[i]);
    free(rec_argv);
    return ret;
}

When a user runs 'perf kvm stat record', cmd_record() processes the argumen=
ts
by calling parse_options(). Since parse_options() shifts the array in-place
using memmove() to consume recognized arguments, iterating over the original
length of rec_argv (rec_argc) during cleanup encounters duplicated pointers=
 at
the end of the array.

Will leaving this loop in kvm_events_record() lead to a double-free memory
corruption when those duplicate pointers are freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-perf-kvm-f=
ixes-v2-0-1b337189fffc@gmail.com?part=3D4
