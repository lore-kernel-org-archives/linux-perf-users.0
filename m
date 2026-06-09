Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771F346FA4
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042564; cv=none; b=RuOyqHIZ8MaEpma5WxAfSkPWprWs1K3/Qggd/I6LYwsq/cOqwZ94F6AVOIBVfiEQF0ykFQQ5NSLopOOoQBa6T26Hkyfk1kZCiCfmFUToxa92pkrco7VqEd7EhhAfcSdJZBQ8yr9Hk2AO30XJf6xhB0wu/srDH5t1yq6uuc/DtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042564; c=relaxed/simple;
	bh=pID4ccK38kwRTE11knMFzoCBP8U7kkNOBm1eJ17HLAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gt67jLJK8RJ/MoKLYBsZ3PFQX0KYXRxGAnYTiNUEA5GZecvfXrh3C+eJPse77RWo5lGVaSAM/o4PwCqf2ZhQ0tIi8YYj9+9o4qjAAr/vzLbqWCiFiSVaJ71N/cRGmxpkUu/3WoXpMqe8GVjPhtz5SMEogp4f4bWTUGzRqHJAy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4R0/g/k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4R0/g/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B301F00893;
	Tue,  9 Jun 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042562;
	bh=u6X+QgPuJkyL03RS+k28J3YQ7kjfvxBRViuqvv+koPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4R0/g/kO9c7KjuOo+emd0cd8P3xs3Sjqt/M7/ZJnVF8YCA8FQmdEqtg/zyfK2OMd
	 awY7Iwsnte+3kIwmJ/FohqhzgOcSCaWrbD3h91eqQnxVWRu8/ZM93iSHQQBLdahUvG
	 tWchltQmVF7/IZ8F+MlPVTqaWz6ju+ob8khqYlxdoOnatSf+2xCiQjxfdaabJJwV2t
	 YsPD8rMICFBIDxxcjDt6aOhbSeUflpG2oj02Z1BKhP7w6wru/vpxdNAPKNH95gCXxM
	 czvGJNgIi0MTopZqhVAYiE+GGx4A+iuEm8oluNTEnTQXUBdY8C8ErNfxrX7BjkUuCs
	 MjtVa6BcCINog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] perf vendor events intel: Update lunarlake
 events from 1.22 to 1.25
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609215046.2391903-5-ctshao@google.com>
References: <20260609215046.2391903-5-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:02:42 +0000
Message-Id: <20260609220242.A7B301F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Accidental deletion of the UMask field for the BR_INST_RETIRED.C=
OND_TAKEN_FWD PMU event, making it an alias of ALL_BRANCHES.
--

commit 5c9c0d0a9a04ac6fce773f8ccf00f8df75a3f68d
Author: Chun-Tse Shao <ctshao@google.com>

perf vendor events intel: Update lunarlake events from 1.22 to 1.25

This commit updates the Lunar Lake PMU events from version 1.22 to 1.25
based on the upstream intel/perfmon repository.

> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> index d66eafccebbb6..a7467b2f291de 100644
> --- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> @@ -190,7 +190,6 @@
>          "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
>          "PublicDescription": "Counts taken forward conditional branch in=
structions retired. Available PDIST counters: 0,1",
>          "SampleAfterValue": "400009",
> -        "UMask": "0x102",

[Severity: Medium]
Was the UMask field intentionally removed here?

When UMask is missing, it is omitted from the generated event string.
The kernel PMU driver interprets omitted mask bits as zero, which makes
EventCode 0xc4 with UMask 0x00 an exact match for the ALL_BRANCHES event.

Does this cause BR_INST_RETIRED.COND_TAKEN_FWD to incorrectly count all
branches instead of only forward-taken conditional branches, potentially
corrupting Topdown metrics that rely on this branching ratio?

(This same UMask removal also appears to happen in the parallel Arrow Lake
update patch within this series).

>          "Unit": "cpu_core"
>      },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609215046.2391=
903-1-ctshao@google.com?part=3D4
