Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFC374A16
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042476; cv=none; b=Y3w3ntqqw3DPcXx+dN0YkvAhQ0cMtnpAoe/QLQSLK7uxUgvcFpXRo2eiVddqrzwH0Mn8jBEYo47WQMZ6nJmA0VjG8Ah9O2tHepcAkPe0tmsRLiWm+RCKcMdU32GDDJWAc4pIb8BbWSZwlHQVzZVzHrWgPasa14g+CX5Ks4/Fzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042476; c=relaxed/simple;
	bh=hYTUmR/1mYiAC2Trz2prXtnqob/jJo9j4IZOOhKWaYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KOxIsU2Y7kr3BobFKs8a0HbNmIHIKLVcKrCG16+6ZiTFDD5ITjikPd/qRy7IHlHge0K9/gNvINrV1Iojynmpm2JuXNasdKhy64DE1M7twFKRxU39tJ+sRRVnNdH0YKKoCUQrqy1IhRZhC58emzzSmytPlkTRgNHz6ScUk7fZ0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMHis/UA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMHis/UA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C531F00898;
	Tue,  9 Jun 2026 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042475;
	bh=To42CLKEHrWh9HU3iqyn6NXJYfhjeb9iJipP9ciZElY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DMHis/UAeJ087EisSf4fvf6vnGfYxqCcPdfT942mU8GIlUQpEJD97+FzVQmpj83I7
	 dpD/WN7xMhTn5kbaCMITsHjEIz1JFT1WWc26p7QsQqz7VjJMUhczXG4YVvzEh2MsFC
	 4jtPzMPOaTV9k/BVaTyFjSNLoS6KkzuuD+fHtq5S5VqVgfl1KcOfjjD7bPXN3VHVTT
	 P5yhLwZbgdYAlclrkdPOp+otMAkh6fa+D3IQ4J+AIKW8e3H6qCYUYl90Xmpvh9Ysqc
	 fNhNc8v9EvSE5SuQQqtF0+0hFOBsaLN1i/PvdjcsI5wAbT2XfZuayxKyHeWuyQ79h5
	 QoEW+ZFUlaCtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/6] perf vendor events intel: Update arrowlake
 events from 1.17 to 1.19
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609215046.2391903-2-ctshao@google.com>
References: <20260609215046.2391903-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:01:14 +0000
Message-Id: <20260609220115.43C531F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `UMask` field was erroneously deleted from the `BR_INST_RETI=
RED.COND_TAKEN_FWD` event definition, causing it to silently alias to `BR_I=
NST_RETIRED.ALL_BRANCHES`.
--

commit a0347536085c6d8e17e90fb1536ff53c3e33e1ee
Author: Chun-Tse Shao <ctshao@google.com>

perf vendor events intel: Update arrowlake events from 1.17 to 1.19

This commit updates the Intel Arrowlake performance monitoring events from
version 1.17 to 1.19. The updated events were published in the upstream
perfmon repository.

Link: https://github.com/intel/perfmon/commit/b84e75626ae78558b8f526a276e45=
97c5ca6c429

> diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/arrowlake/pipeline.json
> index a0fd63cace220..bdfee0347cc5a 100644
> --- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
[ ... ]
> @@ -209,7 +209,6 @@
>          "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
>          "PublicDescription": "Counts taken forward conditional branch in=
structions retired. Available PDIST counters: 0,1",
>          "SampleAfterValue": "400009",
> -        "UMask": "0x102",

[Severity: Medium]
Was it intentional to completely remove the UMask field from
BR_INST_RETIRED.COND_TAKEN_FWD instead of updating it?

When a PMU event has no UMask specified, the perf event parser defaults the
umask to 0x00. Since BR_INST_RETIRED.ALL_BRANCHES uses EventCode 0xc4
without a UMask, the BR_INST_RETIRED.COND_TAKEN_FWD event (also 0xc4) now
perfectly aliases to ALL_BRANCHES.

This breaks top-down microarchitecture analysis metrics that rely on it,
such as tma_info_bad_spec_ipmisp_cond_taken_fwd, as the metric expression
cpu_core@BR_INST_RETIRED.COND_TAKEN_FWD@ /
cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ will erroneously evaluate to exactly
1.0.

>          "Unit": "cpu_core"
>      },
>      {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609215046.2391=
903-1-ctshao@google.com?part=3D1
