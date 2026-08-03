Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C94219E7;
	Mon,  3 Aug 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778405; cv=none; b=PNqK9TmetaOZyeDFyt2BEL/wt7BDGE8da9zrOBzj8i6LZVCZKu61g32Hvsc/6amoo1Wqq6f6BEEzsDpX8RnuqGk354Kzg1QKOaJ36vJWJd0Q1K2YiZE+JZrfBxGkmleUD9JJRyTHJpA2LdqZcIbCrIha2bcdupFS/v6EeXHUyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778405; c=relaxed/simple;
	bh=9t29aeXVWABnhtHyD6OIKsvlZ29DOq1r+QAPGtQdrmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tXKGY8QclVpHRV95376YXRK0UqNHlRndSVL65pHfdJkzK5SahyS+3kVLMR2pT0c5fElNaQ0xpieqrSnZvENeQDcVSEUJQgG7/Vv0Ri63UYoHa3H2uHvqpIQuPVSItSKIDoDYUFryAyPCTCg6m8/wzGaqWjLWaeS3ie5dPWyyNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doz18Dfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doz18Dfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6DB1F00A3D;
	Mon,  3 Aug 2026 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778404;
	bh=GN6VumNrmcl+LQtiI5y81tJCn+YouM4KPsKz1A+49Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=doz18Dfnh5lyNUHWARnnalPAZ+0oz3c5IXiPjHsgpz0vn9m5APnwhBdjsvQMNSt/u
	 bLB+ZwS5VvVKdvb9Ami72OhJlCJHCRzJ/AzB4vJAHvyTqJzt2m8KDjaKWF/VHtXdgT
	 EcZWD21vIu01U+okgXnuP+NTux+1I/uFWCFu1BOq0PP3adRS4ghmeHThJbsaiih462
	 /SAn1/Dcdv+fb360BDPamlgHESYZQOUcVHKIaaMhLaeD5sWMbDM1ofbIHQc1QcZx4e
	 WwUiyisPokXSagaCnWyjLXE0JJqrZTfI8ANx2SqqkRDB/NiSdaN5A6SfweGywEA7B0
	 KUhRe6Z0He+Ig==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260730235946.618096-1-namhyung@kernel.org>
References: <20260730235946.618096-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf build: Fix a build error on 32-bit x86
Message-Id: <178577840379.2174330.3697546596918863933.b4-ty@kernel.org>
Date: Mon, 03 Aug 2026 10:33:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 30 Jul 2026 16:59:46 -0700, Namhyung Kim wrote:
> The commit d7507a94a072 ("KVM: SVM: Treat exit_code as an unsigned
> 64-bit value through all of KVM") added "ull" suffix to SVM exit codes
> and it makes the 32-bit build fail like below.
> 
>   In file included from util/kvm-stat-arch/kvm-stat-x86.c:4:
>   util/kvm-stat-arch/../../../arch/x86/include/uapi/asm/svm.h:137:32:
>              error: conversion from 'long long unsigned int' to 'long unsigned int' changes
>                     value from '18446744073709551615' to '4294967295' [-Werror=overflow]
>     137 | #define SVM_EXIT_ERR           -1ull
>         |                                ^
>   util/kvm-stat-arch/../kvm-stat.h:131:17: note: in definition of macro 'define_exit_reasons_table'
>     131 |                 symbols, { -1, NULL }                   \
>         |                 ^~~~~~~
>   util/kvm-stat-arch/../../../arch/x86/include/uapi/asm/svm.h:249:11: note: in expansion of macro 'SVM_EXIT_ERR'
>     249 |         { SVM_EXIT_ERR,         "invalid_guest_state" }
>         |           ^~~~~~~~~~~~
>   util/kvm-stat-arch/kvm-stat-x86.c:12:45: note: in expansion of macro 'SVM_EXIT_REASONS'
>      12 | define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
>         |                                             ^~~~~~~~~~~~~~~~
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


