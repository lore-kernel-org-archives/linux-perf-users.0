Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2736F41C
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753217; cv=none; b=eY3USfueaTXPDbTjOU5PRoOo73WToLHjCRupNOW9dmaZuR3DyIGXz/HQmKGyv2AERxa78EwhOZn03n1Np5Nvlj4+AKk9ZjdbFYc/opcK+W0lPVWAp/D9eQPh53njcJF8vKEa6P4MENu+XpJqLuSmBWaJzWk5W3PYOoPFK7THUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753217; c=relaxed/simple;
	bh=YtAzhJ6efyVf2k/mx8QCSsxN1S/xihih6OIrLy0SgxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W0HmWfOM4/Oa+UF0hjl6xBNyYaDyd8RLODHwUvFfC9SH8sSL7JzNY8t0T4iRrQpq0JAABS9Il/whgnXdps+nJ33qXhwWLXjgeJ+pBl5uZpgUTXQIjEsETYXsrSaecipmbTNe97t8fmDBYMUbdg28P+YJ/1A2is/sZRmoTnZ2WHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHVpfxA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHVpfxA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C5F1F00A3D;
	Mon,  7 Sep 2026 03:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753216;
	bh=sCrbYympCUc9SyB5efrdIOu2xhgjmhm9tspkAlYg2Q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHVpfxA+XB5vozGtMWFMy+MHv38DNiZbl6Xs/YW94FHwUkdc2Y6DBySusQKt4WzLx
	 BJM1Jn5fy0As1BVW6Phx4TyilwdszZXsp2mmxNE3GqGzJuakbHQSid1T58G/8BHQYs
	 6rVDiiNvCn/KlPLwtwzzkmwuCJbqFMkv029u2nyHvMSJ3U1ElAf1Ioy88GtENnw/kW
	 UuN9FJsyOi2M1PAg6+N7mwAs7yWqDEAC4y5ZopdD2C7OsNu8ZikEDGFvptgoLm3Ov2
	 lnA1zZPvlQee7kaV5hKTOPoOdvLZXCYouaghJ8OPMIOSNdfaSj+ILwAPcydbAS9aw1
	 240lA9AKf+TbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf build-id: add shared is_valid_elf() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907034554.714-1-atrajeev@linux.ibm.com>
References: <20260907034554.714-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:53:35 +0000
Message-Id: <20260907035336.33C5F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The helper `is_valid_elf` is vulnerable to a Time-of-Check to Ti=
me-of-Use (TOCTOU) race condition because it verifies the file by name and =
immediately closes it.
- [Low] The patch uses POSIX libc functions and ELF constants without expli=
citly including their required standard headers, violating subsystem musl c=
ompatibility guidelines.
--

commit 61718d5b137531f7814b491a94911627f3ad9015
Author: Athira Rajeev <atrajeev@linux.ibm.com>

perf build-id: add shared is_valid_elf() helper

This patch adds an is_valid_elf() helper to build-id.c and build-id.h
to allow multiple perf subsystems to verify elf magic without duplicating
the check. The function opens the file, checks the SELFMAG bytes, and
closes the file descriptor.

> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index eb95ab90f9741..28b6b3f8d5d35 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -43,6 +43,20 @@
> =20
>  static bool no_buildid_cache;
> =20
> +bool is_valid_elf(const char *filename)

[Severity: Medium]
Is this helper vulnerable to a time-of-check to time-of-use race condition?
By verifying the file by name and immediately closing the file descriptor,
a local user could replace the target file between this check and when the
caller reopens or links it. This might allow invalid files to bypass the
validation and pollute the build-id cache.

Would it be safer to change the function signature to operate on a stable,
already-opened file descriptor instead of passing a filename?

> +{
> +	unsigned char magic[SELFMAG];
> +	int fd =3D open(filename, O_RDONLY);
> +	bool valid =3D false;

[Severity: Low]
Does this code introduce missing explicit header inclusions for musl
compatibility? The subsystem guidelines require that files using libc
functions or constants directly include the standard headers where those
symbols are declared.

While the commit message notes that elf.h and fcntl.h are already included
in build-id.c, this function introduces uses of open, O_RDONLY, and
SELFMAG, without guaranteeing that fcntl.h and elf.h are explicitly and
directly included at the top of the file.

> +
> +	if (fd < 0)
> +		return false;
> +	if (read(fd, magic, sizeof(magic)) =3D=3D (ssize_t)sizeof(magic))
> +		valid =3D (memcmp(magic, ELFMAG, SELFMAG) =3D=3D 0);
> +	close(fd);

[Severity: Low]
Similarly, read, close, and memcmp are used here without explicitly
including unistd.h and string.h. Can we add direct includes for these
to ensure strict header separation?

> +	return valid;
> +}
> +
>  static int mark_dso_hit_callback(struct callchain_cursor_node *node, voi=
d *data __maybe_unused)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907034554.714-=
1-atrajeev@linux.ibm.com?part=3D1
