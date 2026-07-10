Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBC3264C8;
	Fri, 10 Jul 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720129; cv=none; b=TF85MscD/E1Duukc6AhqPaPa8PiNLo78fcrNKKB58uLiwAxiMIhlOTjpsy4H5Jbo4G7OcvV8bpzG0t9KzQ5REzd6nrXpigE4RrHA6qJUYHT53BYFPgbtp8w6T6TJjX4mmE2XCVArrZtUfyTSNmw3bbu4tlNQUxHc63V6SGVGPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720129; c=relaxed/simple;
	bh=9k8+8VktFmq9slk2BfXCp6KhCyEuRj8Jah1IEnvzdTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oiCanRVA4l8iXdVsk41bZmTrZQ0EMOkMTzjgpNM8MJDZBy0Q8Ym6wqGJHQ0Yz5U0HmV1Nt1W/uyA+RCgJRAaWgEmLpQq+Ohdy6Sdn12kIi3vahkjPBOtL96zYrwgHkQZIZqUGVzqqnN0u6CXEttPomS/gyxj8gbR15/Pilz+9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC9GUto1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC9GUto1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C446B1F000E9;
	Fri, 10 Jul 2026 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783720128;
	bh=mUJmwV8f/lcRMkaxeinQRkwwZgWzunBc+qqAC68KObk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RC9GUto1UTBVCFk/VHocOXzt1FG4U3xd/pZVZGJ5BgIL/ANVEHS7EQ8gpgM2yscwk
	 Mb8BXkkkB1zfSP+NQHOozCgSRYuP6zyKdI4Q2WbyypvRFP1l0E8KCiwSAIAamBxnO3
	 FFW2h4ABPjwpbLAFGALjojJRqf0Yv79acZ5mgTM7E1xep02CGkpKjDz2yY8rhzQWiO
	 PneUVtaXSoyNibRjdhv3yytSQsBvf2szmawJrCDmnxwdc3sVT4O3OSH/kjpMXeUncA
	 Zhd7OUOsAVHNVF2mxZSzKbgWwEjByjCz+BfMOqAQNXTKo/+DqlHhaG4abenuyzfmAD
	 hrl1gNBTI5zTw==
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jan Polensky <japo@linux.ibm.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260708175311.858850-1-irogers@google.com>
References: <20260708175311.858850-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests: Restore -p flag to lock contention test
Message-Id: <178372012775.2171589.4852450488832656362.b4-ty@kernel.org>
Date: Fri, 10 Jul 2026 14:48:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 10:53:11 -0700, Ian Rogers wrote:
> Commit ae42a2a2a3ae ("perf tests: Speed up lock contention analysis shell test")
> in linux-next heavily optimized the test runtimes by switching the workload from
> the default of 10 process groups down to 1 (`perf bench sched messaging -g 1`).
> 
> However, this change inadvertently dropped the original `-p` flag, causing the
> benchmark to default to `socketpair()` instead of `pipe()`. While `socketpair()`
> still generates some lock events on x86, it fails to trigger enough samples on
> architectures like s390, causing the test suite to fail due to lack of captured
> data.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


