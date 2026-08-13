Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54447FB19
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628825; cv=none; b=btDKN9FhNLa/yPJFQPQJnry8eJIlbcZtDjGM8svnOxtLRVmIChPsZe01ZpxTY70bahZNpa9LPz7aaaUU2WhO4zLDaAPZcuVHFw4nwrO3KElR8kFq9o4L3Pba5FbStij+ZBrs/5VG6Nb/Q2++LJnph9lW4K3fznieYktDt3YU9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628825; c=relaxed/simple;
	bh=q0kf2tqNSQHHtay2Gb2bdvNe1GGpZPMXNfff8Lf9PZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJ9OgTZWr1OTF2Rx8moMjX1+3kAi3uyMgj0yfMlCVEqmw2hfC9loFM4EbyS47FHCf0YWHEyFuL6k+iwNmU8yYc4Bk9nC3+NHelR9PWemsgsnRat6DuREk0TFHaQjWU/4K4D4G5EDZgO1LhKs1wbbWTWOtGLQ+HClcir7ZnomhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWVnQvJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWVnQvJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C80E1F00A3A;
	Thu, 13 Aug 2026 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628822;
	bh=yPR5CNt9DYdcV3iL23E6PWWXMC5noUOWo4IJBisnAhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWVnQvJPwIFf2hM4GSuWbU1zCVNZpyC7slvXgjN3UGWDAZLqiEyEPvxSrGjGkpfI2
	 dRaYWR3toyVQBVNZ6jrQ+uFBciGi1kkBQ0oDN9PnWcuZGVdExVtn7sCuxs1PtYLPxl
	 FyZ6EUWtsbB5+DqZoGz2ZiwBjkvYwRJZCWBNkYY93biKMow9437d3go2QXvo45QGZH
	 LTvDDWdEp1DVStgQEdlXAy8DCA1k3na107JWReHf3fqn3niMljywuKtPh4kSuYykIH
	 pHUurFLhPQ9p5p7CEurz8GqOooatn/hhCRGNfmNeXoZqqgzJfp5bj1xa9hir8roNvk
	 LZ0nbG2BzKjNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] perf tools record: Modernize -W man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813132907.50738-1-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:47:01 +0000
Message-Id: <20260813134702.4C80E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a double space in the updated text for the `--=
weight` option ('weight3  and local_weight'). Additionally, it propagates t=
he pre-existing typo 'weightened' (which should likely be 'weighted') in th=
e same modified block.
--

--- Patch [1]: [PATCH v1 1/4] perf tools record: Modernize -W man page ---
commit 3b23df9a5d2c30f9e6db8d77004cb5c3a03f441d
Author: Andi Kleen <ak@linux.intel.com>

perf tools record: Modernize -W man page
   =20
This commit updates the -W / --weight description in the perf-record man pa=
ge
to cover newly supported cases and configurations.

> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -480,9 +480,11 @@ Note that this feature may not be available on all p=
rocessors.
> =20
>  -W::
>  --weight::
> -Enable weightened sampling. An additional weight is recorded per sample =
and can be
> -displayed with the weight and local_weight sort keys.  This currently wo=
rks for TSX
> -abort events and some memory events in precise mode on modern Intel CPUs.
> +Enable weightened sampling. One or more additional weights can be record=
ed per sample
> +and can be displayed with the weight, weight2, weight3  and local_weight=
 sort keys.

[Severity: Low]
This isn't a bug, but it looks like a double space was introduced between
weight3 and the word and.

Additionally, this is a pre-existing issue, but the phrase Enable weightened
sampling should likely be Enable weighted sampling. Since this block of text
is being modified, would it make sense to correct the typo here?

> +Possible uses for weights are memory or instruction retirement latencies.
> +Support depends on the PMU and the event, as well as its configuration. =
Typically
> +it requires use of 'p'.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813132907.5073=
8-1-ak@linux.intel.com?part=3D1
