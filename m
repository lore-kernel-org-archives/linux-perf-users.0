Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A292DCF6C
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330888; cv=none; b=Vt+OqK1iI2vs1QMGN+5eGvnQOUg6HrZATdmNW7WFliI/aBfmvHXRvy4LgstZWxjG4m8QzolWXqDtaZIHh+6RdjPvXNplnPAI6BEiZbH36i0SbX/yiSwitXJquFGLlik4s1leK5FJuYQz9T8Sf7UVWSTR9I6OnCdNGYAa+viYOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330888; c=relaxed/simple;
	bh=k7ySbyvD0GdGlyn0qsxM3SOfdu/I3kZH64zLCoeIHlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLQoQxVX4SUmlc5A4K+KG0drHYbAETXen++zjBMFhq2x4oDcyOlTjGQpcPym5groe7/8TXQyYD2D38/YhoM6DEwfeAX3vZnO8TcWYLhERmIlsgYKARg5V6iMEM6EN6hi6I/KobYXr6vjuwgGa4k7nwzsOPuQJ5ifkRIwmIw6xNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVkHsapG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVkHsapG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BE91F00893;
	Mon,  1 Jun 2026 16:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780330887;
	bh=DAnkqnhw02xqIlImT7HHuv2sZn79opikAIAgCo0S6F4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVkHsapGyJXI0lKdlcR9NWjM11y8pWv9Ndry3Cj/Ob2/MhQozRDVKphh/3R8XTd8+
	 YybWwdg/ab/qB0eznjWKtwmq0MALz6lryvDFx959EfHrQe3eiIXWbTxsfpAW7f6l2Q
	 2nwQJ53tpB4yRon4XOfQn1N/ZpBxdlidKizbHWlJAJ4GChRhwmWnBX+AgIr0WnKuz8
	 wO905C7c+AFtfm+stwhcSBs4lCzKHG+/4Y/nsC6YiYcpMIRY69IrqDDRdhYzK0jglZ
	 7TEsdu8m2fuoZZ30XgLssLAinLjTGVBmA2dMDf0zLGukLgF5qTQrhxE81BQahbKXpx
	 VuVzhfVDM8eJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf vendor events amd: Update Zen 5 core events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com>
References: <f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 16:21:26 +0000
Message-Id: <20260601162126.D5BE91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect description for the newly added `fp_ops_retired_by_type.s=
calar_logical` PMU event.
--

commit ec579a038d59c44007350888149b4dd94c5079db
Author: Sandipan Das <sandipan.das@amd.com>

perf vendor events amd: Update Zen 5 core events

This commit updates the definitions for Zen 5 core events by adding missing
unit masks and fixing descriptions for several PMCx events.

> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b=
/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> index 9204bfb1d69e0..39bd720f95414 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
[ ... ]
> @@ -179,6 +179,30 @@
>      "BriefDescription": "Retired scalar floating-point blend ops.",
>      "UMask": "0x09"
>    },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_mov",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point MOV ops.",
> +    "UMask": "0x0a"
> +  },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_shuffle",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point shuffle ops (may =
include instructions not necessarily thought of as including shuffles e.g. =
horizontal add, dot product, and certain MOV instructions).",
> +    "UMask": "0x0b"
> +  },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_bfloat",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point bfloat ops.",
> +    "UMask": "0x0c"
> +  },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_logical",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point move ops.",

[Severity: Low]
This isn't a bug, but there is a typo in the description for the
scalar_logical event. It currently reads "move ops", duplicating the
description from the scalar_mov event. Should this be "logical ops"?

A subsequent patch in the series (commit "perf vendor events amd: Update Zen
6 core events") fixes this identical typo for Zen 6 architectures, but it
appears to remain unaddressed here for Zen 5.

> +    "UMask": "0x0d"
> +  },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f16d1391366762dee0d=
49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com?part=3D1
