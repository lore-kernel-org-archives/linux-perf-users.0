Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FE3D8135
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165273; cv=none; b=PB3CL81XiOXgKpCahEiyVopQ6q67Z4eLkFRviYhLbaA6vZf41iWt1LgBKHBSVM7McGpYEDv8ifPZQSw1sQdfKpBdRx4TDvb/pGeUsufJKmBxIN0XAu4tV1BWe5/pxC5YHn/AGhNj4eUsfCmpxDFd0LuB1LV1Y1Ec0sj/y0XeB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165273; c=relaxed/simple;
	bh=t5Elm/eraR3FTf3dnFwyY9Qduib7qUCHYwu3Gz5Kc5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ibKUua1cTwkwAZMVsysprTxT2uCwXo+WuCdwC3rgAuN1PZDeqtzR1oU3VlxZrKLfT5SOd+erwXiwWCGMXc+UGy/lqzNc90OcKrsK45JIZeZLRXXEtUolzI6FGCPyaIzbh4OPNU8+7XD7IeHQqX8B9yqAGzUaG0n+DfuoWcrTCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un+asTQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un+asTQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19889C19425;
	Tue, 14 Apr 2026 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165273;
	bh=t5Elm/eraR3FTf3dnFwyY9Qduib7qUCHYwu3Gz5Kc5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Un+asTQx5OszsGcxNNm23Cvu3OxO7C+CrrPp/bCJKYAvJh/HXLRwsl2TxYW8Z3e/d
	 ZyNEtG/uQrc+cAgV2lXFDHq5AORRmiYN6QJinXmGCs/b4XM5DkQiI3E9F/JBFwv3NV
	 fV8+0rNEFxKtWuyYJCQgofeAJZ7cnZ2BhA0eYkFd2+jYa6Tslrawv8W3YhxmdloyYy
	 EL67oqqddX+jDAIN7PzC9S+Y2lqEJkEmEX6XYuetI5Cl3j7MAiVP70vD6DDQ1Tg2++
	 snmbOlb+mF3kLcf2m6xxEZWxBxLqCDIyxXdpIlNzoM8dE3T8Q68G29Iy+tR67IzlHZ
	 z0qvXAbO6SFrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf arm_spe: Make a function to get the MIDR
Reply-To: sashiko@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414-james-spe-impdef-decode-v3-1-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-1-63baf9c893b1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 11:14:32 +0000
Message-Id: <20260414111433.19889C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Missing NULL pointer check on the result of `perf_env__cpuid()` le=
ads to a potential segmentation fault in `strtol()`.
--

commit 6dbdbd9b51f99a0d48fd13fa50acc79faa59bbb8
Author: James Clark <james.clark@linaro.org>

perf arm_spe: Make a function to get the MIDR

This commit extracts a function to get the MIDR, which will be needed to
dump IMPDEF events in later commits. No functional changes are intended.

> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
[ ... ]
> @@ -987,15 +982,28 @@ static void arm_spe__synth_ds(struct arm_spe_queue =
*speq,
> =20
>  		pr_warning_once("Old SPE metadata, re-record to improve decode accurac=
y\n");
>  		cpuid =3D perf_env__cpuid(perf_session__env(spe->session));
> -		midr =3D strtol(cpuid, NULL, 16);
> -	} else {
> -		metadata =3D arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> -		if (!metadata)
> -			return;
> -
> -		midr =3D metadata[ARM_SPE_CPU_MIDR];
> +		*midr =3D strtol(cpuid, NULL, 16);

Could this cause a segmentation fault if perf_env__cpuid() returns NULL?

If reading the CPU ID fails (for instance, when processing an SPE trace with
old metadata on a machine lacking the expected sysfs CPU ID files), passing
NULL to strtol() will crash the tool.

I note this behavior was present before this patch, and I see it is address=
ed
later in the patch series in commit be72d9e89c04e ("perf arm_spe: Handle
missing CPU IDs").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-james-spe-=
impdef-decode-v3-0-63baf9c893b1@linaro.org?part=3D1
