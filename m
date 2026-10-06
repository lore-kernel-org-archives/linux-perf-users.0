Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EC389459
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330888; cv=none; b=cZRGvqdd8QbDnxb9ratSOf8JNqphgp8walmXzA3ocpumRBEDQVOhE8biEcI5HDcYm6vUQwRL734nwkojHoRndCbNAz+GZDptNC2qDnhNXKYxAHrGr9RgZ5V5PcwJ+NT0XRSrYx7NNvefyHdSmwYYLTLbzP739XhyB9ilqJ8noXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330888; c=relaxed/simple;
	bh=RzNMGL1jqnimq802k0LYAMT23jo+Zy42ZYZz3W1ClVk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OGZsOZs3UriOKSi3/Vf3zii1mxGS9hJD/w0dkCU6fFLkEVsWIcH3OADU1dYitErekDKKXsXaW/48Ign6TtQRvmhYClYYqSTxpYDMF9uhdBhlGfR/zgzpTNbAKIVA59JBLdpfeQkaz72njIctnDSrokYFUbUva59cbBJ0SzbOkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJx9m0rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJx9m0rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFF01F0089B;
	Tue,  6 Oct 2026 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330887;
	bh=HGdNbZibCB14ySv2mM7jEY6syrS2Us7LPgB0UX8hNO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJx9m0rpHQxX83C6gj/Ln8MliFNXEMoFO2RzN16mUqQkv7sWanasd6/BRN1IwPHtI
	 3FrjKrGv/dDR7B+oOs50kHjFa7VBM/ff51NAGuLcIIiv5Ztq0qfHCozSeauWf5MnNH
	 3XvIUx8jzE1wV9vcBEMe0mYxqGN/IeGGRcDqPWzk3gQ33a6dL8/LZiP5+3570rOxZm
	 wv6ANMpR3CZBTImYT82+9QM/Ki4+9VUvKQM7Iune3E1hWZXg6ph5zqIsUasGHpgEoT
	 mX95x0X4qrSsYuW7ws5YqtyyHHuI01kV3MlLMyXbLt4rhM16KoQSH7+yrlvBcqr0QR
	 3y/yuagUlnyVQ==
Message-ID: <sashiko-outbox-162537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] perf tools: Try linked debug files for DSO
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-3-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:54:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: DSO_BINARY_TYPE__DEBUGLINK bypasses mount namespace fallba=
ck
- [Low] perf: Incorrect path formatting in DEBUGLINK resolution for local f=
iles
--

commit 8a09d3bb34892b4472de63b4949a0752ebfa1103
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
Will this addition bypass the mount namespace fallback for containerized
workloads?

When dso__find_dbginfo_type() iterates through the types and calls
dso__get_filename() for DSO_BINARY_TYPE__DEBUGLINK, it performs direct file
I/O on the host path:

tools/perf/util/dso.c:dso__read_binary_type_filename() {
    ...
		if (!is_regular_file(filename)) {
			ret =3D -1;
			break;
		}
    ...
}

If the binary is containerized and not present on the host at that exact
path, this check fails and returns -1. This early error return causes
dso__get_filename() to exit via "goto out" before it can attempt the mount
namespace fallback logic:

tools/perf/util/dso.c:dso__get_filename() {
    ...
	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
		goto out;

	if (!is_regular_file(name)) {
        ...
		new_name =3D dso__filename_with_chroot(dso, name);
    ...
}

Can the early file existence check in dso__read_binary_type_filename() be
adjusted so it does not permanently bypass dso__filename_with_chroot()?

[Severity: Low]
Does this code incorrectly format fallback paths for local files?

In dso__read_binary_type_filename() for DSO_BINARY_TYPE__DEBUGLINK, the
directory component is extracted by searching backward for a slash:

tools/perf/util/dso.c:dso__read_binary_type_filename() {
    ...
		last_slash =3D filename + len;
		while (last_slash !=3D filename && *last_slash !=3D '/')
			last_slash--;

		strncpy(dso_dir, filename, last_slash - filename);
		dso_dir[last_slash-filename] =3D '\0';
    ...
}

If a DSO is specified without a path separator (e.g., a local file like
"vmlinux" in the current directory), last_slash remains equal to filename,
leaving dso_dir as an empty string.

Later in the function, debuglink_paths[i] evaluates the formats:

tools/perf/util/dso.c:dso__read_binary_type_filename() {
    ...
		for (i =3D 0; i < ARRAY_SIZE(debuglink_paths); i++) {
			snprintf(filename, size,
					debuglink_paths[i], dso_dir, symfile);
    ...
}

When evaluating formats like "%s/.debug/%s" against an empty dso_dir, doesn=
't
this incorrectly generate an absolute path starting from the root directory
(e.g., "/.debug/symfile") instead of a relative path from the current
directory?

>  		DSO_BINARY_TYPE__NOT_FOUND,
>  	};
>  	const enum dso_binary_type *type;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D2
