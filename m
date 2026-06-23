Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB559397E8E
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249608; cv=none; b=i0KuZLW9g1SY0hDuH3dwBdsPZg3wXdZU/yKhT7DHxNun+Z+SDT3f5N7OpmY5Ls2/UY6x4k/jVcv8xXiL3lJVO8uR5alP58bbBrW7FXGBXviAwJk7ubVl/AaeU/sBCdrYfvZlC4A7wSovvrXuxmJkNVue7XzEoHCT14SVuQdpmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249608; c=relaxed/simple;
	bh=HG/7c+MRz+16iwpVXO3/ELN/u/o6Fmrwadd1XkeHEvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a0eJOyuYCQn5qICFB6JXHpKqDcbnLIBUt0ValZvAgFDiwVcOyQaije28vdN8Ji/5J6sO2W5zzBu7sxKnJBGLtFWxrMVNOTBbFfa+NdLtIPgocaIYRgKTnCs66zeFaeBE2dS0tIalCnf+/d4Rb2albXqN/sXZ1JAhxn1K69NnQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGL7Ays9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGL7Ays9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4085D1F000E9;
	Tue, 23 Jun 2026 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782249607;
	bh=UfIaSFGz9/8Fg3ABiyb9JIkdAq94HFW9MPLq98JTkoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGL7Ays9cDKUyIIjo/k3A0L8B0OOrQxmw4B38n++iLZYNMEg1Nd2HXCzz+dUpda4e
	 FNDik/J4E06zAR27DfNTFwYCJ/YgnYYunNymU+oQ9d4g6oTO4NlNINO0waWNEwj1CN
	 iR2nslgQFGCO5voVu2Fx5/mMGxmPMoZfE4/+3qeaA1FiGZsLCSRl7TxB7CGKhPDxZx
	 7R1/ZFy2CD7MECZoin5DZmh1gqUTWcXotJImjOSwM2G3FTzpAKfL9FJTHc4H+k5P7M
	 FJPBFj1HIP55yecns8mahga4hQ6hdEAR85FmXAEu74jKgi8rcfabyPzN4c7kWsOUIc
	 EuYluot6gAuhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] perf kvm: Factor out
 kvm_need_default_arch_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623191439.3621593-2-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
 <20260623191439.3621593-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:20:06 +0000
Message-Id: <20260623212007.4085D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Silent error suppression on memory allocation failure in kvm_nee=
d_default_arch_event()
- [Low] Missing POSIX standard header <stdlib.h> for calloc() and free() in=
 kvm-stat.c
--

commit 79c29a62706a76c9c3a62f6592977712a8f8b5fd
Author: Namhyung Kim <namhyung@kernel.org>

perf kvm: Factor out kvm_need_default_arch_event()

The kvm_add_default_arch_event() has a similar logic in each arch to
check if there's an existing command line option for events.  Let's
check it in the generic code and remove the duplication.

> diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
> index 755ab659a05c3..c571d2ed711a8 100644
> --- a/tools/perf/util/kvm-stat.c
> +++ b/tools/perf/util/kvm-stat.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "debug.h"
> +#include "env.h"
>  #include "evsel.h"
>  #include "kvm-stat.h"
>  #include <dwarf-regs.h>
> +#include <subcmd/parse-options.h>

[Severity: Low]
Should <stdlib.h> be explicitly included here for calloc() and free() used
later in this file?

Relying on implicit inclusions can lead to compilation failures when buildi=
ng
the perf tool against musl libc.

[ ... ]

> +	/* parse_options() may change the argv, let's make a copy */
> +	tmp_argv =3D calloc(argc + 1, sizeof(char *));
> +	if (!tmp_argv)
> +		return false;

[Severity: Medium]
Is it intended to silently swallow the allocation error here and return fal=
se?

If calloc() fails, returning false conflates a memory allocation failure wi=
th
the logical state of the default arch event not being needed. While the cal=
ler
might fail on a subsequent allocation, would it be better to propagate the
error so memory pressure conditions are explicitly caught?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623191439.3621=
593-1-namhyung@kernel.org?part=3D1
