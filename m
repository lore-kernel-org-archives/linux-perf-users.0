Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536C274658;
	Tue, 15 Sep 2026 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437272; cv=none; b=EaBPZc27eart9l6oM4ohtK/eZTRQeYj7pSdFLY9d65YH2oTB3EuDEFWDz7IQzOrW+HZAsJRXEuo1njFqVjnKUrt8Mrh0McGUYGw6qldMZbSWI5L23ZZJKDioj5LLY4m+4FP2zPrnpiKjz5W+W2MT8kHacED/wAS7+mUXBAhediQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437272; c=relaxed/simple;
	bh=6WuoFIRFdclRpjmrkgo4Jm1GL0OXC8785WmB5hHzxyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeGmDDfpQYKV8+45BHaRsGbEaUbx1DfJrNT7anAh/e/PLTmJjtsRVrEMmz05/mwvDnmw3bjPeytw8TsewLby/g0PCeKn392SdKgKLTsUg2KiV2D5+8ioz+3pRy7AP5CLw1uVL655uc8V4WgpBTLn6Ba+x4/DDYW1DfxE6HNbC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IG/rUgra; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IG/rUgra"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789437266; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=6WuoFIRFdclRpjmrkgo4Jm1GL0OXC8785WmB5hHzxyM=;
	b=IG/rUgra2bE/slqq+szS8NYmPdPzD+XJ7gusIyttGDeC1wy5LY4a3pdssOCaCRx1vQoJojifbzr2UwsfZYOw5ICAss2XspoiOOO/dZw5+H3lUuLaTfsn+GfxQ108gYYk2X01BRGNcuU3iGSEIa0JwhQCli8SRCG58Yell7tHs6M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0XB.Sw0u_1789437260;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XB.Sw0u_1789437260 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 09:54:24 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf riscv: Add perf_regs_load and enable the dwarf unwind test
Date: Tue, 15 Sep 2026 09:54:17 +0800
Message-ID: <20260915015420.818-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914125814.C92251F000FF@smtp.kernel.org>
References: <20260914124145.1257-1-cp0613@linux.alibaba.com> <20260914125814.C92251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Both items checked. Neither needs a v2 of this patch.

> Does this file need to explicitly include <stdlib.h>? Since musl libc
> enforces strict POSIX header inclusions, missing the declaration for
> malloc could lead to a build failure regression on musl libc systems.

It is not missing. "perf_regs.h" three lines above resolves to
arch/riscv/include/perf_regs.h, which has #include <stdlib.h> and is
also where PERF_REGS_MAX comes from, so this file cannot be built
without it. arm64 relies on the same transitive include. Checked with
riscv64 gcc 15.3, where an implicit declaration is a hard error:
including only that header is enough to call malloc() and calloc().

> Can perf_sample__user_regs() return NULL here?

It can, but that is not introduced here and cannot be fixed from this
file. arch/x86, arch/arm, arch/arm64 and arch/powerpc all dereference
it the same way, and tests/dwarf-unwind.c:118 does
zfree(&sample.user_regs->regs) unconditionally, so an early return here
would still crash in the caller. A fix has to cover the whole "Test
dwarf unwind" path, or the contract of perf_sample__user_regs() itself.
Either is a separate series, which I can send if wanted.

Best regards,
Pei
