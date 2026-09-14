Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56519436361
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427680; cv=none; b=iAJrkWHAGaEQlSsn03qdl3qY77aF+7pkrdtGCbzibLFXBShiVhUON2SB73ISpqRmnO1E2nh+GgWqQkQ5UBaen5/xJcsQyYqgYFM3fJq9YF+Qhfg3xmMZTIhCDncSUej/LVPuA/L+Rk1F+HKZCyqgzBOT9CUz/lDV4GsJ5WLD+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427680; c=relaxed/simple;
	bh=RoPoBOjvY6E7a8wfnNqkHVaSgqQpMEHciwyH7NPnuYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIgVs/+0c6xAJ3fNU5kvhM3NGKYjDZbGPcCJXLn4NfCZHYeoxUNQ3NQA6gdNHBZHohNAFl+c9NyUlPHdBZAOUQYb3LZjT29GPoRkHjuZixfzZiYe4Yl3Z/0Tdl9nnjrhyrVjpoQmEU7M/aGgQ6WBxNESQZGppUDRq16hnONnYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYJzguDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYJzguDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810751F000FF;
	Mon, 14 Sep 2026 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427672;
	bh=/lURpaWILukwFPZ5KxpSe0b7hzaN9pswMSKQWMhas70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYJzguDoQUbtHwwdcUC0swpNIy6mob3isqlCbdVPFyq6wih76K2D5wADVgOaPsf1c
	 hRvfivxEAlTaEtJGu1msG3XIuTRJclw/Xh5YBtjEmfkwQQsRArWKEOKX+L+8zeR1nt
	 C6R9hDzK01eLQPpD58FG2ZoyiIeywlxbtcbGGP7XTLGVuDbQHieWRJzqu4DhrLfokG
	 TPXh39XomZJQ0IYeisAUbYBkOmJAq/kyjJp6G8tCdtR3UbeP2t4rweNSWDEu901lrb
	 bp8dniI7KL3Z1YrSVZeEvNfQIUFGWvH+b3x5JjY7Eg9P4Vq4bckyqw08LpkUmTK8LL
	 8ywpnciJ2ze3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914224650.52982-4-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:14:27 +0000
Message-Id: <20260914231432.810751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing <fcntl.h> for POSIX file operations
--

commit 3d29383e185965a287c0130b763ba9ba19b03791
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This patch parses memory range data from the ACPI MRRM table exposed via
sysfs and saves it in the header of the perf data file under a new feature
bit. Memory range data can then be viewed with perf-report and perf-script.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 7db7da090a1e0..83416ce395d7c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -1892,6 +1893,132 @@ static int write_cpu_domain_info(struct feat_fd *=
ff,
>  	return ret;
>  }
> =20
> +static int memory_range__read(struct memory_range *range, const char *pa=
th)
> +{
> +	char buf[32];
> +	ssize_t n;
> +	int dfd, fd, tmp, ret =3D -1;
> +
> +	dfd =3D open(path, O_RDONLY | O_DIRECTORY);

[Severity: Low]
Should we explicitly include <fcntl.h> for these POSIX file operations?

The standard strictly requires <fcntl.h> for open(), openat(), and constants
like O_DIRECTORY. Because tools/perf/util/header.c does not explicitly incl=
ude
it, this can lead to build failures in environments like musl libc that
enforce strict namespace separation.

> +	if (dfd < 0)
> +		return -1;
> +
> +#define _R(name, dst, conv)			\
> +	fd =3D openat(dfd, name, O_RDONLY);	\
> +	if (fd < 0)				\
> +		goto out;			\
> +	n =3D read(fd, buf, sizeof(buf) - 1);	\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914224650.5298=
2-1-thomas.falcon@intel.com?part=3D3
