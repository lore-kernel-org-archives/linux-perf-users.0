Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5D41443D
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070038; cv=none; b=RrzjewBX2oMD0DAlTVbOcEVfyibK7YiULOm/msm+Pei4yCOGmIta8EA2jb5yhzXQdDo0bf1D+RzXH1QLcxyNnhtmgw31pqQF1ZQlMZKk+D8m+R774pe8gq34pLP1fghv8ivuOJRYO9qaBvqXv5VKDkbeLyL+x1QPo6jG4qtpr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070038; c=relaxed/simple;
	bh=kwStv1rTOvfSi509m1Cd14lGpIdE9wnRyLccOQJeCak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZbLkZ732az7LZBYNjgDYWEy2vQvxXEGK/hUYwixwFlQa2afHTtwZkXfLDcwKi8EsLN9YgjIc5b2iqDYd32aVGPPuyDns2aCBbXePQUwi0RPfbv3Tt69Eg354mfaYaoKs815pmUUFpHu7ujlh3bFsXT5+J2qBSiRJaUWSuHqESZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSm/5jkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSm/5jkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B651F000FF;
	Thu, 10 Sep 2026 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070036;
	bh=yt6KzvwDu+TmEQsKk/GRRDzHYzaSXLf1j84nuUqhcEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSm/5jkLHgsj3uWalHjphhGStr5glt1d8KhWBHxgFwFu4nxARF7sCJboSufolCAlV
	 9RiIHD7/CEKOkKUwerU0Lg0emG2R9xh8PlyvK48r/HuEkxufGkjAT6eC/GKU0M+0DG
	 YkgoGtzP7LPy+8+n+ariCER2Fx9eOGW7JGArUaySruzeM/w+STrKpZJ0us5/QrGxpo
	 lI648GHIJOr59pxAJwg0VSZClXJnIAtjNebkYiR8xIJDnaOn7Elxd6SFqkemFd6zEV
	 dadctTD1qjhmNjuTcLIrxLjOvwAloQ1qzahGAFfdyWpkhxqecJzerInX4zXFj5eWbo
	 iEVtVKBtfHIew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910194324.98002-6-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:53:55 +0000
Message-Id: <20260910195355.D6B651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unnecessary full header inclusion of `session.h` in `mem-events.h` =
instead of a forward declaration.
--

commit 40386f8d2abdbd20961af3746935e85e6ef1913c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

This commit adds a new memory region field to the perf-script output, sourc=
ed
from the mem_region field of the memory information data source. It also
incorporates fallback logic for pipe mode scenarios where feature bits might
not be available.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

[ ... ]
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index daa22748f9fea..4ebb8109fc3c4 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -4,6 +4,7 @@
> =20
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include "session.h"

[Severity: Low]
Does this unnecessarily pull in the full session.h header when a forward
declaration would suffice?

According to the perf tools subsystem guidelines, it is preferred to use
forward declarations (e.g., "struct perf_session;") in header files instead
of full header inclusions when only structure pointer handles are reference=
d.=20
Since the new perf_script__meminfo_scnprintf() function prototype only need=
s a
pointer to struct perf_session, could this include be replaced with a forwa=
rd
declaration to reduce header dependencies and namespace pollution? The full
include can then be placed directly in the .c files that dereference it.

> =20
>  struct perf_mem_event {
>  	bool		supported;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910194324.9800=
2-1-thomas.falcon@intel.com?part=3D5
