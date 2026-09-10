Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E963414437
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070335; cv=none; b=bkVaGhs38q5fROKBYSVDWNuYSfWcNrVbxiOTKWIR+LH5zsSmWKKXN17gnRFE1da3zwa/yEXY6/ZPMJ2cFzg9OQW0h5i8hu/sVCF0PB7CMRatxUQ3U+eHegMf8FLPvhaBDBK/EOUoGzZw7IKocjJuip+slLgIV6HabO35Ui0sg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070335; c=relaxed/simple;
	bh=UjY0TIWEBfIOaXlx8WAuqFkBaZWjQhWjGcRFRUH5Txo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=se3SvNooDOtq36O6zLEDMwIynLGk+Yj4VNvYrfVdxVvYVRyFsJiw3L1ImbO48iWdx+Qhi/u6Oup2YEgnW8heK7ilsHFHBOi0tFJ0lKEioCaRTkgY8r3GP912ZlsbkbCHCFzeN0hA3i9qJvHK7DWsgay1qVzldrrLNv0Kfkhae6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVObjUMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVObjUMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7BB1F000FF;
	Thu, 10 Sep 2026 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070334;
	bh=tOy5SBkvgCg1e0pTcFPaSrYC5crOPpT+eZzvz+VRcPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVObjUMmIj4EzpgBmq+IP/9L4XhmtCyaLG8cFu1tubxH3B7+KXZZT+mpKX7FR3yfJ
	 Rx+41Fme/AQjdixqLG2Ibq3hYvmYS/C0itdBdvUmtbjNnpDgjOBe2EuPgpYEQFfUJ5
	 qeEA/xtDex7Sd1e7F8wbNqKVqtYobd26fdcyl2gBSlCaibmNQYLRyI5sbLEb+4lyWc
	 XX4LI7xTP2egGFHYxBkU1fMStiw2h1wnGOZStQBg73G1cwZ1Rv/kdt8MQYpOq7qsFE
	 bfh8pIZ2wQp+WIrY1hsfRLtZF08oLH7pJuM+Ts++zlHugl+GUr8Fey2qZvkejB6lUR
	 YoAlLXx1Dqrlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910194324.98002-4-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:58:53 +0000
Message-Id: <20260910195854.0A7BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit POSIX header inclusion `<fcntl.h>` for file contro=
l APIs.
--

commit ae98e94438c4a105c55741f3c0be511c630d7250
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This commit introduces support for tracking memory ranges to monitor
performance and resource control for different memory types. It parses
data from ACPI MRRM tables exposed in sysfs and saves it in the perf
data file header under HEADER_MEMORY_RANGES.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
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
Does this missing explicit inclusion of <fcntl.h> for file control APIs
(open, openat, O_RDONLY, O_DIRECTORY) cause build failures on musl libc
systems?

Without the explicit POSIX header inclusion, this might fail to compile on
environments where <fcntl.h> isn't implicitly pulled in by other headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910194324.9800=
2-1-thomas.falcon@intel.com?part=3D3
