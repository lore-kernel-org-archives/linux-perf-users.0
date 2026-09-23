Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BD4ADD9B
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179852; cv=none; b=X0FM4ITY/JdBA1txb9aWnJfVxq57+qjSS8/Z8bxinIUxTfCY1qOzaEFRuS1VRlOxGhiSb+eQ16/Z5i7bDUu3G3kfvigSJNvO8kHIxHtx/cTs9tUgzarGplgSm+DS7cD60Sxnt7CMaFmYt3z2c+3GZYPblW9YaLLLGjQ5Zhc4WW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179852; c=relaxed/simple;
	bh=xmQHi1bqDxgvVJpwG9APo7B5Q5JtW7BTJ/ePemWJm0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PEPwX773HRqrz0fLPRgmZUMB6EH5Dk4cW7OKULv2pkxlMKPu+PucvpT81jUpvum2IiwCNSuE9J3+BL4OLQn7jR25OsmMEGe9FoSWLNM/CInlEnQIfg6Qu22eUhrp/EFYqoowNAieKtqE45VA6HOZyJ4fXBP2yrPpR9ymT96tC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHm+SDLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHm+SDLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C171F000FF;
	Wed, 23 Sep 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179843;
	bh=DQYKnCutVstCQYo6p5yBr/cIZ8on8dDPRVl3i4bo8Fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHm+SDLQShKW4I2uSkEbg0FWZg7gUl9RFZWN37VP6qVdWqnl5A7rpPPxMBomcvodK
	 yxnNTqYcQplZbmulnXxTzmkUDs9VnRIxLAn5Wuq2w7ilmz9k/PMm/VllyljJWNw7+q
	 7JnyOaVa+FNcIFOujwQvPq4DjJTQAcEBVBJ7t9To9qW5O/j+wlf06shM47NEeAaKaL
	 G0KDGbxUnyOxCXVQZRB5vfI/+AskBu889NhRhZHIyvnigs7UDf6mQE+ZHttgtf+Xf6
	 EGaWfm5jMncM4mUGY+AXF8R4s6e2bMunhgwDrewd3DxGfDEyhRkEwkxY8zIKTGnmdB
	 agzlgnVsm58zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923155703.34814-4-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
 <20260923155703.34814-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:10:43 +0000
Message-Id: <20260923161043.95C171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf header: contradictory error message for MAX_MEMORY_RANGES boun=
ds check
--

commit 85df312c747d8e803c10425e475af0b3a2dc6e55
Author: Thomas Falcon <thomas.falcon@intel.com>
perf header: Support memory ranges

This commit adds support for tracking and storing memory range data from
ACPI MRRM tables into the perf data file header. It reads the data from
sysfs and exposes it to userspace tools via a new feature bit.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index ec2935c0ed04e..38f2da9de5f0d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> +static int process_memory_ranges(struct feat_fd *ff, void *data __maybe_=
unused)
> +{
> +	struct perf_env *env =3D &ff->ph->env;
> +	struct memory_range *ranges, *r;
> +	u32 nr_memory_ranges, i;
[ ... ]
> +	/*
> +	 * According to version 1.1 of the ACPI MRRM table, the maximum
> +	 * number of memory regions can be at most 255. Do a sanity check
> +	 * here to guard against a malformed perf.data file.
> +	 */
> +	if (nr_memory_ranges >=3D MAX_MEMORY_RANGES) {
> +		pr_err("Invalid memory_ranges: nr_memory_ranges (%u) > %u\n",
> +		       nr_memory_ranges, MAX_MEMORY_RANGES);

[Severity: Low]
Does this error message accurately reflect the bounds check? If a malformed
perf.data file contains exactly MAX_MEMORY_RANGES (256) memory ranges, the
check will reject the file but the log will confusingly print that 256 > 25=
6.

> +		return -1;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923155703.3481=
4-1-thomas.falcon@intel.com?part=3D3
