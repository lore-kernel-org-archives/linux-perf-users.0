Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939031DDFE
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272083; cv=none; b=Ccqdd7syYQq/eq/I5TzAHJYur/YFNCfzZdLo2Q54BUO9NUZbDsP447XMKlJFKafHGlM7wsdOVOoejmFJjsyX7j6ziX/tlZUQNhS1Q7/YVjROGznYCr9T9bcmQOF5rZuxHUyp8iflD1q6GvPAVu0VkXF6y48xDb13CMX5QEU+MtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272083; c=relaxed/simple;
	bh=pgixI+fIpFrX4LEednJFcxkiaXuC/+o2a9/7ymBEEmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCGuTf3u00BFmHNBsUV03XK9/aOsJELc+49JIy3SiPMBUtRgRP+MQD9rCePy4Mc0VvH1QrTiFtz+ImC+PowNMIyMEtoajeUSBeq8mGVFXPr22MrODI+ay5J1BjnuY7mihgQXM6Ia355zsicvZttkxqe5aTOH8fIYq8yvdAziN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXzP4AHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXzP4AHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1483F1F000E9;
	Fri, 21 Aug 2026 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272082;
	bh=KtdtRqPKRm7UnmhsXtyfO+to9RqB/Cvc40r2po1VLbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXzP4AHUfxx3JMxmFDwQ2YZ3fyj7yWqZiMUx7WWTvoT779YPcwfXbU+e9nN+QA7fl
	 5ECAZSiMaLII4ehUkAL/HLbH95OpkjYPG0exMqZUtwI76qzaeP4iUFJfVBRGNOxlGw
	 gWEwWvakMbhuy98fvrmXR5/BHEF7nQKRDkZuYog2+wkWxDs2Ptnsl47l/3Kuw3qPlA
	 E6oojcv4B6F/NqfVzHyhg22/LIK1ILcaUAQ7ETj+4HAc/w8XZ764mpcP+pFlPi9ZP7
	 5ZUkIgWETUi+cZ2Lfk4NbBAaTRAucN7RE0C98Ehsw9xqvUCHGAMwzS5dVHw8LjbCqF
	 6dN+jgr9LMofQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821001819.162277-4-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
 <20260821001819.162277-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 00:28:01 +0000
Message-Id: <20260821002802.1483F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing explicit header inclusion for <fcntl.h> when using POSIX=
 constants (O_RDONLY, O_DIRECTORY) and functions (open, openat) in tools/pe=
rf/util/header.c.
--

--- Patch [3]: [PATCH v5 3/6] perf header: Support memory ranges ---
commit 3413492c0a2a11d41de6c16475e806b307c1b825
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This commit adds support for reading memory range data from the ACPI MRRM
table exposed via sysfs. It saves this data in the perf data file header
under a new feature bit, HEADER_MEMORY_RANGES, and adds support to print it.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 091d8f7f6bd2c..a81a0f42bb0f9 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -1891,6 +1892,132 @@ static int write_cpu_domain_info(struct feat_fd *=
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
> +	if (dfd < 0)
> +		return -1;
> +
> +#define _R(name, dst, conv)			\
> +	fd =3D openat(dfd, name, O_RDONLY);	\

[Severity: Medium]
Will this compile successfully on systems using musl libc?

The code introduces usage of POSIX functions and constants such as open,
openat, O_RDONLY, and O_DIRECTORY without explicitly including <fcntl.h>.

While glibc often implicitly includes these dependencies through other head=
ers,
musl strictly separates declarations. This missing include could lead to bu=
ild
failures in musl environments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821001819.1622=
77-1-thomas.falcon@intel.com?part=3D3
