Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB593E5EE4
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181923; cv=none; b=Etepy4OP3+PWdbZEfVjIYjInWP1mEQI3hJ5rNQ4wqn7tvJdRz2dj80AXzqXfpW+yfDjP+9CNyTTGEM0g+2G1mHVoTsXZ+LuBY42rm1O+tzj5RYvCqu0w/tFWU5gVunA9EyimG0GNE/C3QHBN/5jGx2qXdGHPRw3qqLIaziqWfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181923; c=relaxed/simple;
	bh=zd5IgtfWT8NYlOXSFFpvLC5IdnN0Kg66EeWn7mnzMPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jz0HDiHxV1hPOhVO1YQ1BoIznT3iPyDU7JT5sbbIn9mFeHPj8H/dtMncLHjzV2FVIgW4l4wbWYdqky45QXjsyvfrpAcsdWwQrP+Su0Hk1kTsKGDu4OoF2xPi1gTWd0MWagQCg1jZKVWxen8qv9XdBh0WIhb7mDMAWj5kZF2tyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7ypcUxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7ypcUxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B24CC19425;
	Tue, 14 Apr 2026 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181923;
	bh=zd5IgtfWT8NYlOXSFFpvLC5IdnN0Kg66EeWn7mnzMPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d7ypcUxOHVK+yGDLmLW/2xNqqu9TZ07qYx9eLsZLliGUW9BPaBTmaDQEhAdHZCbAK
	 TJjRNbuOopzM9i08UqatYIC4DvxX5e3Ge7aBnY3e27hG2WYFmzIM7JYFYrMdN0hjSt
	 Ou2v/DoUVEWhDTVmHlWRM/W9pmC79R7EeSGfZDpdftilSKllKlB1vD+CDbhKnRaVbG
	 BZrN75q+5WybQIHFFWupYPxQJKBmvwWpi1bKC9TLeOdrI+Jhz5XnhJVTjb2vBtw1mg
	 S654i1TLwNQqEpS4c1uVpY1V7mCeE/VCQKlPH00t5ODgWBweuMVI9EcyD3/BHU+QYP
	 a/Ry9N/vKHmNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Reply-To: sashiko@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414-james-spe-impdef-decode-v4-5-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-5-1dd30783a33b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 15:52:02 +0000
Message-Id: <20260414155203.0B24CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The relative include path `#include "../../arm64/include/asm/cputyp=
e.h"` is invalid and relies on accidental directory traversal through a com=
piler `-I` flag.
--

commit 7fc153524fe60dc6d6f08fd73b7ea3f46e904e39
Author: James Clark <james.clark@linaro.org>

perf arm_spe: Decode Arm N1 IMPDEF events

This commit adds a framework to decode the N1 IMPDEF event for Arm SPE,=20
which isn't covered by the common list. It also increases the packet=20
description buffer size to accommodate more strings without falling back=20
to a hex dump.

Link: https://developer.arm.com/documentation/100616/0401/Statistical-Profi=
ling-Extension/implementation-defined-features-of-SPE

> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-=
spe-decoder/Build
> index ab500e0efe244..97a298d1e2791 100644
> --- a/tools/perf/util/arm-spe-decoder/Build
> +++ b/tools/perf/util/arm-spe-decoder/Build
> @@ -1 +1,3 @@
>  perf-util-y +=3D arm-spe-pkt-decoder.o arm-spe-decoder.o
> +
> +CFLAGS_arm-spe-pkt-decoder.o +=3D -I$(srctree)/tools/arch/arm64/include/=
 -I$(OUTPUT)arch/arm64/include/generated/

[ ... ]

> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 67ca356100e53..b74f887a48f2a 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -15,6 +15,8 @@
> =20
>  #include "arm-spe-pkt-decoder.h"
> =20
> +#include "../../arm64/include/asm/cputype.h"

Is this relative include path correct?

It looks like this file is located in tools/perf/util/arm-spe-decoder/, so
the relative path resolves to tools/perf/arm64/include/asm/cputype.h,
which doesn't exist.

It seems this only compiles because the newly added -I flag in the Build
file causes the preprocessor to resolve the include relative to
tools/arch/arm64/include/. The path then inadvertently evaluates back to the
correct file by traversing backwards out of the include directory and diving
back in.

Could this be made less brittle by relying directly on the include flag,
using #include <asm/cputype.h> instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-james-spe-=
impdef-decode-v4-0-1dd30783a33b@linaro.org?part=3D5
