Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CF484255
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912876; cv=none; b=o3wzAmHEb6Kf9n6UdC7H7JQ/SgP5TxDDlATVdL66KnQMztCSCQyOxKTmD2w3D3k7JAoBhm09pGIdhJ6Fw6F8uXxtmnzNv1JPUOjqWmojRi55Sf6Bpg43XD86f8WeVC4nq35RZKAXiAhGlHOe2ZncSvgHLu3pkiNCe7giJmFNOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912876; c=relaxed/simple;
	bh=PhtbcMOWK6KLy7uA7siLAwhwexXxcn3GU5syEU1OzJc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e4bpJBmG/YHsYOyLsV0onHIS9orvA9FXkoFtYpnpGofFBq3PM82eIADySpiZhjclaz4hVDqzo+Ljvrc4D1MR8A9P8CIqLzaVcu1aSx42F6s83oZx/6q+Nxu6wZcRkqmiM5PygLkBj05NThUWsh6cpH4njlZOkO7s0LBmrqdCDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXVJoI/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXVJoI/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F21F000FF;
	Tue, 13 Oct 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912875;
	bh=v174cnFw4iNyKltRg4lI+K/Re3fxgPGXgLOiRqL7BuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXVJoI/Z95fW6mdmuvTIycMETBdZxquYgRpN88tzUpzKpd95ptIfZlXu7vCZk4tOg
	 NAZDIibuvto3BlkisXyyC1gEX02x8Cy05WxIKmkoqrqv7NT0s6Xq1wzK7VRsTF+XGy
	 p0FLJKEOyRiyOfahJdLx+LCMk0Wh/qI8YAHvSwiR/DvRqfdsMWLctTTLAEBEnFYCjJ
	 +w9h4Dd1hddYjCbNvw7ePU1Ntyij0MvTlH2ve2VQeGo5hLmfPOKZiliLoh3uhxjGCQ
	 VZz4rnh+8eXYmKU2Jb8z39zelRFQwVgeZKL93rqM7RMOq1MCVVMBW1vMBDLCb7INir
	 hZYp7b5C3ocvQ==
Message-ID: <sashiko-outbox-170238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/11] perf tools: Try linked debug files for DSO
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-4-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:34:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf tools: DEBUGLINK debuginfo resolution fails for containeriz=
ed binaries
- [Medium] perf: Uninitialized stack read when parsing malformed .gnu_debug=
link
--

commit 58954c9ee50dda18b6aba714c1a631c8845bc3e0
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Try linked debug files for DSO debug info

The dso__find_dbginfo_type() should try DSO_BINARY_TYPE__DEBUGLINK so it
can follow the .gnu_debuglink and find the debug information in the
separate file.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index df03f84c97235..913877b84b2d4 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -2111,6 +2111,7 @@ void dso__find_dbginfo_type(struct dso *dso)
>  		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
>  		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
>  		DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
> +		DSO_BINARY_TYPE__DEBUGLINK,

[Severity: Medium]
Will this break debuginfo resolution for containerized binaries?

When DSO_BINARY_TYPE__DEBUGLINK is attempted, dso__get_filename() calls
dso__read_binary_type_filename(). That function performs an early check
on the host namespace:

tools/perf/util/dso.c:dso__read_binary_type_filename() {
	...
		if (!is_regular_file(filename)) {
			ret =3D -1;
			break;
		}
	...
}

If the binary is inside a mount namespace, is_regular_file() fails and
returns -1. This causes dso__get_filename() to abort early:

tools/perf/util/dso.c:dso__get_filename() {
	...
	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
		goto out;
	...
}

Will this bypass the subsequent dso__filename_with_chroot() fallback logic,
causing the tool to miss debuginfo for containerized applications?


[Severity: Medium]
Could this lead to an uninitialized stack read with malformed ELF files?

When resolving DSO_BINARY_TYPE__DEBUGLINK, dso__read_binary_type_filename()
allocates an uninitialized stack buffer:

tools/perf/util/dso.c:dso__read_binary_type_filename() {
	...
		char symfile[PATH_MAX];
		...
		ret =3D filename__read_debuglink(filename, symfile, PATH_MAX);
	...
}

If libbfd handles the read, it copies the section directly:

tools/perf/util/libbfd.c:libbfd_filename__read_debuglink() {
	...
	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
				      section->size))
		goto out_close;
	...
}

Since BFD does not append a null terminator, if the .gnu_debuglink section
is malformed and lacks a null byte, could the subsequent snprintf() in
dso__read_binary_type_filename() read uninitialized stack memory?

>  		DSO_BINARY_TYPE__NOT_FOUND,
>  	};
>  	const enum dso_binary_type *type;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D3
