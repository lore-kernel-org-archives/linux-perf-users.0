Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6D3911AB;
	Tue, 29 Sep 2026 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653235; cv=none; b=OP4pvjIEogwJzasmkjy4L5eDcBLWhvBrpK13Is19zSBxQTSxd4fN+o8R4J4Yhq7sRBFsNGU7tA+5SxJLqjyB3uAiImxbRE15MWH7p2aRn6JAblt0KYA2xcx0Vz0fmtvOxlzu6Q3H9ES+X6i1SCN8Hx58NU8pOEdtq2RFI5gMPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653235; c=relaxed/simple;
	bh=qXy2sRf3UPjdIHWylaXPiQGMJd9HqpbGIqCOgYXTgM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfrBLg/z5R0jfHMIQiyYDP1eMt746WSJ7NC74+xK0RFuJV6hm6V+sYdmH5H3ISkg5JL8+ciptaH7NMpcXhR42/gA8GxIND3Q9PE1uv/7pzwIms8h3+FEl68MCvtj1LW5S/u5bdr6HbKpvQNTWxUjO5U4M1aI4mHS14JC3GtKl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h5wUwGlF; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h5wUwGlF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790653223; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qXy2sRf3UPjdIHWylaXPiQGMJd9HqpbGIqCOgYXTgM0=;
	b=h5wUwGlF8mWNI5ZH5ykL/+1H/DUmkkV+XsPE0kCcNwcVye+wBwp11KLUkyo0feRXJ1VVAYdiwDTTH4WGLuABi4QhkCH7JRMJhWhOmmokaMe1llqGPvrse+Qg6PZt/XsrwcfcpgWQ56X+BhYwcqLZZYk8HGBzmJ2ACdCQD1r0BYs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBrsUfB_1790653212;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBrsUfB_1790653212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 11:40:21 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Leo Yan <leo.yan@arm.com>
Cc: acme@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	john.g.garry@oracle.com,
	will@kernel.org,
	mike.leach@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	guoren@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tsc: Replace the compile-time TSC support check with a weak hook
Date: Tue, 29 Sep 2026 11:40:11 +0800
Message-ID: <20260929034013.2110-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928163442.GG14479@e132581.arm.com>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com> <20260928094739.2605-3-cp0613@linux.alibaba.com> <20260928163442.GG14479@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Leo,

Thanks a lot for the review.

> Just a bit on refactoring. You could refer to the implementation of
> PERF_HAVE_JITDUMP in arch Makefile and "CFLAGS += -DHAVE_JITDUMP" and
> do similiar thing for rdtsc.
>
> Seems to me, we can just use build system for configurations.

Makes sense, I'll change it that way in v2, thanks for pointing at the
existing pattern.

Best regards,
Pei
