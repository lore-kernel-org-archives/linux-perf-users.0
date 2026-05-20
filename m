Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E1344D81
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305076; cv=none; b=kRubEU74PhNMrdJIbafYIZMq3q3fpB9sg3k6vzvzjy+kkb0XWKgECGEwvcGVKSI9QRy7SkOg4F9qaMR2y/bdgYDA/PEY3ibs0l08kP8l/VZdkUiEDA8CIe0ud2MOrfk3b0S2uGEaFuF5WuMFGlwRe+lC3MKNt1mq9u7J02vKISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305076; c=relaxed/simple;
	bh=zN0gS9Q5V3gMdI/OL4FD6h51yhb2So1CnIHKQ7av7iY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kFTQVD7rSJRnRMmb5xRQsh/bSMNWAQl4/4uyTsCRtv4L4qvSJhNN414YsHQSR7B54kMlNFqeTiBLOIDAOkVj+qy/YXY6dKIxY11ROZzdy6rRM6TAAvGDfxsU8kc0MTmWokIHfIUEBPQtHoRbwmKRuVN+vyXJYgITPuin0dsTmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QafUA84O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QafUA84O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3811F000E9;
	Wed, 20 May 2026 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779305075;
	bh=k02UEZOHcKbiQgWh+tcUdojmXoewGYddQAmBtx+6adg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QafUA84O5/5oR1MIbaZKPcg8NDr2xkRAN3yV0KRWu6MPJxz93x64/zBM57MTaeinP
	 eqghopndqVJ5J/4PCik3u3p39ZkeLb7isH43wE1Gx4xgY4Q0P33YUD32z3rBKXeLRm
	 rD/aT1aB+yMixOVQGot9NZlefg6Vfp6oiddV8JKCyIdM+zfW7mesJ805cQKIKCr9W5
	 nUuMdGWOUjjMrsVzv52LXZ/zEz+rh5W7bBL89DzANswUwAVhGAndE6mMr5vH49Yh8Z
	 uLU825duRbVgsSOXNlfXq56Ywm9PsYHTs//FSl03QWW3EdldeocqrY9XYNJtjfmsFf
	 c7PotPijgR9fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf stat: Use aggr_nr scaling for Intel uncore
 miss latency metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520180032.3045144-3-ctshao@google.com>
References: <20260520180032.3045144-3-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:24:34 +0000
Message-Id: <20260520192435.1B3811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused import `List` from `typing`.
--

commit 78c2e54794653940a1f0e4de31504f86f0809cd9
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics

This commit updates metric.py to support the new aggr_nr keyword in the
python metric generator. It also updates IntelMissLat to use aggr_nr instead
of source_count so uncore latency metrics scale correctly on multi-socket
and SNC systems.

> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-even=
ts/intel_metrics.py
> index 52035433b5054..50d5a20fa354c 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -5,9 +5,9 @@ import json
>  import math
>  import os
>  import re
> -from typing import Optional
> +from typing import List, Optional

[Severity: Low]
This isn't a bug, but it looks like List was added to the typing imports
here without being used anywhere else in the file. Should this addition
be dropped to keep the imports clean?

>  from common_metrics import Cycles

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520180032.3045=
144-1-ctshao@google.com?part=3D2
