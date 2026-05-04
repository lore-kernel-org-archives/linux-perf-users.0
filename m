Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA043E3159
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923212; cv=none; b=XC0ZDv1vWEIHD9TYRJDljbMA4ZsALyQzW8uMVRxwqGfJBlgqTabk+p/dKAk9Y13UHoWwvfwCqH526ZSFY7vVpmheMfQd07sp5RRi4nP1lxHxdtGpAjJPKMaRavs1eqEUgrLfgUM7fuHZRlQ9BkiM1EXfTs3FjyUDYBVe3uQEhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923212; c=relaxed/simple;
	bh=8FEzGr4VQzfkHV0kzeJUjryfQe1D2sQQxo5bSfm6szg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CpP+63liJxeyCWi18s8N9Kje7WX751GR8dEecMTuIfkWY8GPW+wVWyP7ch9Lc+G/x/Kav7PORDN7EJCyd3nD01xSd0vKn8B8sBm5TuW4LNN3cQAX7xIdnz//OZoFyqnFaiiS62a05eXvFHR4uJ2N0eKLstdVpau6C1JhheGCEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmZD7xUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmZD7xUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC6C2BCB8;
	Mon,  4 May 2026 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777923212;
	bh=8FEzGr4VQzfkHV0kzeJUjryfQe1D2sQQxo5bSfm6szg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AmZD7xUSFeUnzOuHfhNHAMCufyHSAX5m7J9K2gGynduOVYM6oiMF6AukFna0aidaQ
	 63xsga2044YQrPkGeFJNzFJG7B5mt0yNymrvSFgXg38CNVdCKhLTKHZIijzpIrA0TQ
	 +cN1t8X/GbYjwLBkB/04AE+SAfT0wBgNi+VP0k70kdiRP+XXKT2a5Y8PZdPVQMqxk5
	 IZZNYpieJCQMXFQRW88OiyBvChxYzKdXnGnQsd4w/zX/czQ8QerVwpMFMLz2j7JQ03
	 wiX8nPPaOh1gd+o3ic3nHTdhg+yfejldcDgOr7KObRnIo8Wc0wlnr/kOu1rAA2NaGg
	 rDhWUQ0CE0sCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf trace: Sync uapi/linux/mount.h with the kernel
 source
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503193137.27465-4-namhyung@kernel.org>
References: <20260503193137.27465-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 19:33:29 +0000
Message-Id: <20260504193332.01FC6C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit syncs `uapi/linux/mount.h` to pick up the `FSMOUNT_NA=
MESPACE` flag, with the commit message explicitly claiming "This would be u=
sed to beautify mount syscall arguments". However, unlike `MOUNT_ATTR_*` fl=
ags which are automatically parsed by `tools/perf/trace/beauty/fsmount.sh`,=
 the `FSMOUNT_*` flags are strictly hardcoded in `tools/perf/builtin-trace.=
c` (`static const char *fsmount_flags[] =3D { [1] =3D "CLOEXEC", };`). Beca=
use `[2] =3D "NAMESPACE"` was not manually added to this array, the new fla=
g will not be beautified.
--

commit 41bba49a1df4092fb9de0814ee5b9c785fd42578
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Sync uapi/linux/mount.h with the kernel source

This commit syncs the uapi/linux/mount.h header to pick up the new
FSMOUNT_NAMESPACE flag.

> diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/p=
erf/trace/beauty/include/uapi/linux/mount.h
> index d9d86598d100..2204708dbf7a 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
> @@ -110,6 +110,7 @@ enum fsconfig_command {
>   * fsmount() flags.
>   */
>  #define FSMOUNT_CLOEXEC		0x00000001
> +#define FSMOUNT_NAMESPACE	0x00000002	/* Create the mount in a new mount =
namespace */

The commit message states: "This would be used to beautify mount syscall
arguments". Will this header sync be enough to beautify the new flag?

Looking at tools/perf/builtin-trace.c, the fsmount_flags array is manually
hardcoded:

static const char *fsmount_flags[] =3D {
        [1] =3D "CLOEXEC",
};

Since [2] =3D "NAMESPACE" is not present in this array, ARRAY_SIZE(fsmount_=
flags)
remains 2. The loop in strarray__scnprintf_flags() checks up to index 1.

Does the FSMOUNT_NAMESPACE flag also need to be manually added to the
fsmount_flags array in builtin-trace.c for the beautification to work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503193137.2746=
5-1-namhyung@kernel.org?part=3D3
