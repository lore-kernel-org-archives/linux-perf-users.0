Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E738757D
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424293; cv=none; b=Tb211zCrv2PBOeDqBaih2SQ4tAaBknqEdIF1QoesAEbyIvmYkcOeu+oXrW9J2ASE28cYlnePILqJdSszXQ3LpgTaRHZNMkZh2jEVy4sYAiIaeR/jahk8qTRNjTGdbawkWKtkBlfDGDPG9JjeR9WF2rRsA3at43fFh/pTKVNr69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424293; c=relaxed/simple;
	bh=Hh8C9MpeAC3qJ5dQ26ANMA0RCBwT6GtUgNg5VsNwM7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ixYvUUZeSry3SM7aXZgcIxxHc4dxMX4UPxZ03j4oT4kdpP2rZLGDleRAJ8bMTwUjcOZ4R3+eoKpk4NyRrXYiNHUbW1XuWEgsCKVQFCkENMSkwu4CRaOtCj0gahO4puy372lFH8h2ZEDcyzmk5qWVZdKFVQkEvhpeIhic6Wxd3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW3SVb+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW3SVb+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E6E1F000E9;
	Thu,  3 Sep 2026 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424291;
	bh=myO6qgsW1KT9rhNb7O5Q7wtxlRqxRwV2VR1fEzvlvTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HW3SVb+DPlHW8VPifAsU6VQzQ0vgxCp+VfGu1xnIvLuMFm34Oth6HcvdO4Q2fkPjT
	 thtkAP/zMIEYDauM3TceOz7CzJY6zPfDCYT62zqYG5G2hGVtQ58lRXyuNUCfFjMGgH
	 6x88Bi6tX+GTe1UZY++F1ZgwcEtmSdqO37LVaSuxG/WE5w+HEzl0aZHxxeBCbHTzAP
	 eIcoEf1ggxzhdYH4rUuv+G5jucjCdWrP34ZB7uOi0uhKBptnR1DJw03z8qHcbqmC38
	 jeokWqnr1OlPIeCX3vuIdePy1mFWIfpDebx5KUorRHGCMcpSR+tJjsH6wWhqKoy0o5
	 UWjzYyOth/eYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf arm: Fix memory leak in find_all_arm_spe_pmus()
Reply-To: sashiko-reviews@lists.linux.dev
To: liujing <liujing@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903082128.4972-4-liujing@cmss.chinamobile.com>
References: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
 <20260903082128.4972-4-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:31:31 +0000
Message-Id: <20260903083131.71E6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dereference of NULL pointer when `find_all_hisi_ptt_pmus` fails to=
 load a matched PMU.
- [Medium] Critical allocation failure errors are silently overwritten and =
dropped, preventing the caller from detecting OOM states during tracer init=
ialization.
- [Low] Missing explicit inclusion of several POSIX standard headers for li=
bc functions and constants used in the file, which will cause compilation f=
ailures under musl libc.
--

commit 4dc56b9f02f41e7883231eea2dbc58e300bd2970
Author: Liu Jing <liujing@cmss.chinamobile.com>

perf arm: Fix memory leak in find_all_arm_spe_pmus()

In find_all_arm_spe_pmus(), if sprintf() fails, the function returns NULL
without freeing the previously allocated arm_spe_pmus array, causing a
memory leak.

> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/ut=
il/auxtrace.c
> index 27bb14c8b8800..dd3e1f8189a5c 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -39,6 +39,7 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_=
spes, int *err)
>  		if (ret < 0) {
>  			pr_err("sprintf failed\n");
>  			*err =3D -ENOMEM;
> +			free(arm_spe_pmus);
>  			return NULL;
>  		}

[Severity: Medium]
This is a pre-existing issue, but I noticed that critical allocation failur=
es
from find_all_arm_spe_pmus() and find_all_hisi_ptt_pmus() are silently
swallowed:

tools/perf/arch/arm/util/auxtrace.c:auxtrace_record__init() {
    ...
	arm_spe_pmus =3D find_all_arm_spe_pmus(&nr_spes, err);
	hisi_ptt_pmus =3D find_all_hisi_ptt_pmus(&nr_ptts, err);
    ...
	/*
	 * Clear 'err' even if we haven't found an event - that way perf
	 * record can still be used even if tracers aren't present.  The NULL
	 * return value will take care of telling the infrastructure HW tracing
	 * isn't available.
	 */
	*err =3D 0;
	return NULL;
}

If memory allocation fails in find_all_arm_spe_pmus(), it correctly sets
*err =3D -ENOMEM and returns NULL. However, auxtrace_record__init()
unconditionally executes *err =3D 0 before returning NULL when no tracers a=
re
loaded. Doesn't this overwrite the -ENOMEM error and falsely report to the
caller that HW tracing is simply unavailable instead of warning about resou=
rce
exhaustion?


[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference when find_all_hisi_ptt_pmus() fails to load a matched P=
MU:

tools/perf/arch/arm/util/auxtrace.c:find_all_hisi_ptt_pmus() {
    ...
	while ((dent =3D readdir(dir))) {
		if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < *nr_ptts) {
			hisi_ptt_pmus[idx] =3D perf_pmus__find(dent->d_name);
			if (hisi_ptt_pmus[idx])
				idx++;
		}
	}

out:
	closedir(dir);
	return hisi_ptt_pmus;
}

If perf_pmus__find() returns NULL (e.g. due to sysfs read errors), idx isn't
incremented, but the function returns without updating the out parameter
*nr_ptts to match the actual number of valid pointers (idx).

Later, the caller find_pmu_for_event() loops up to the stale nr_ptts count:

tools/perf/arch/arm/util/auxtrace.c:find_pmu_for_event() {
    ...
	for (i =3D 0; i < pmu_nr; i++) {
		if (evsel->core.attr.type =3D=3D pmus[i]->type)
			return pmus[i];
	}
    ...
}

Will this unconditional dereference of pmus[i]->type hit the trailing NULL
entries in the array, causing a segmentation fault?


[Severity: Low]
This is a pre-existing issue, but while reviewing this file I noticed sever=
al
missing standard headers that will cause compilation failures under musl li=
bc:

tools/perf/arch/arm/util/auxtrace.c:
    #include <dirent.h>
    #include <errno.h>
    #include <stdbool.h>
    #include <linux/coresight-pmu.h>
    #include <stdlib.h>
    #include <api/fs/fs.h>

Functions like sysconf(), sprintf(), and strstr(), and constants like PATH_=
MAX
are used without explicitly including <unistd.h>, <stdio.h>, <string.h>, and
<limits.h>. Could these explicit POSIX header inclusions be added?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903082128.4972=
-4-liujing@cmss.chinamobile.com?part=3D1
