Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5C1EB1AA
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792019291; cv=none; b=dnDuKhvlGyQciWq5wxFqGJK+XUwgwzMP9KB03CTpbChDV6HAxPcJNejTpgcDMzoCfioOhLo7QjnZVUD1ykaYQxp8ucV1spPUDgzOkPrPYIxUnqIsiQJl1V06MZ0zEDPwGV9vz+vHrNbQnsFFiOl1WcowMm45N+Qg1E/EyMvIELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792019291; c=relaxed/simple;
	bh=Q8vzAYOCPedRRVeG8P4Wpl7qrWkIObLuW5eSmPHiWk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXJB2tds8WJVQwOXQtghO2dd7Bmqpj3YLRdo3+8uKPf3BIRWjqHiPLyvwUGgqWxDtHl4VpigAKy2rl66puR8sUioKavZxatqPp0v8htOnrAr8NxwY4mw0yGfmuyMkUMZ9Pf53xZk7fjGxb8rh2xn3eJsSP7CHVitEsgwgdSk4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=condado.dev; spf=pass smtp.mailfrom=condado.dev; dkim=pass (2048-bit key) header.d=condado.dev header.i=@condado.dev header.b=GcT/zWZh; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=condado.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=condado.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=condado.dev header.i=@condado.dev header.b="GcT/zWZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=condado.dev;
	s=protonmail3; t=1792019284; x=1792278484;
	bh=El9SBpptuGCZ1LMXbmy62xr+IlsRl7SPP1Xmbz8/vrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GcT/zWZhglAJaFggjTaPtU445tXpZnDvvsM68ar8NJ2BYuYk7cCcBox4mEOe+0pjM
	 +njLGYVDzPTjdJqFq/vIfu1XUvi8fpoITC/qBttq8VhE07UMpIo8czGQKY6yxjSPrN
	 WOY0BdB/8WbyGCi8Kh7Jol8V1dJJpgQafZd9IPtupUQLm/KTp0F6RpMZcANJx7nQ49
	 OonYvxYisMEgn+RwlXj9VVUSlFw6+IqxXwL5ARmOrmLfITtdJeEKLOKds2y4bc51gW
	 GrBjhe03MSpw0n4ak4eyIXDGLUke5y1Nh6VlNX0RjJ0riGLD51IjPAfABAQdJLx1oK
	 /6PjSmNxeGQ0g==
X-Pm-Submission-Id: 4j4n194ZkTz2ScPL
From: =?UTF-8?q?Geyslan=20Greg=C3=B3rio?= <gg@condado.dev>
To: Hui Peng <benquike@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: =?UTF-8?q?Geyslan=20Greg=C3=B3rio?= <gg@condado.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: fix user->locked_vm leak on secondary mmap()
Date: Wed, 14 Oct 2026 20:07:00 -0300
Message-ID: <20261014230740.754550-1-gg@condado.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260921003306.426050-1-benquike@gmail.com>
References: <20260919221728.3707189-1-benquike@gmail.com> <20260921003306.426050-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 00:33:06 +0000, Hui Peng wrote:
> Fix this by only calling perf_mmap_account() when allocating a new ring
> buffer in perf_mmap_rb() or a new AUX buffer in perf_mmap_aux().

Same thing I found reading perf_mmap_rb(), and I tested your patch. It
applies to current mainline (0fcb05b72344) and I confirmed the leak and
the fix there.

Instead of reading it off an EPERM I measured user->locked_vm directly:
io_uring buffer registration charges the same counter against
RLIMIT_MEMLOCK, so the largest buffer that still registers gives the page
count. x86_64 defconfig under KVM, 2 and 4 vCPUs, each case on its own
uid. Mapping a buffer three more times and unmapping all of them, pages
left charged after the last munmap(), before -> after:

  ring, one process           195 -> 0
  ring, fd handed to workers   195 -> 0
  AUX area                     192 -> 0

The charge follows the event fd, not the mm, so a supervisor that opens
per-CPU events and lets a worker map them leaks the buffer size on every
worker restart.

Your reproducer covers the ring buffer, so I ran the AUX path too. With
no PT/SPE/CoreSight here I used a throwaway test-only PMU (just
setup_aux/free_aux, enough to drive the accounting); same leak, same fix.

Tested-by: Geyslan Gregório <gg@condado.dev>

Worth noting this is independent of Lorenzo's "track the perf mlock gift
separately" [1]: that keeps perf from starving the other locked_vm users,
this kills the per-buffer double charge. Both are needed.

The reproducer and test harness were LLM-assisted; the measurements and
this report are mine.

[1] https://lore.kernel.org/all/20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org/

Thanks,
Geyslan
