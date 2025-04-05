Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317A1DDC21;
	Sat,  5 Apr 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854528; cv=none; b=SZEuk/RF0spM9USoGwnMQsuFqpMOwkl9ni7VufXRofJHT1OtxB+5EeZ5M2dMknsVQpcGKh/TcjIEiJVZwZSV/c67tFLgQgbzDbqTy+8jvyxjUcnfO/0Lwf2o3x3RH6DiJyQa9Php6T8iWgR7T+sBzdDz4MPkKo5+ynm6X01vnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854528; c=relaxed/simple;
	bh=cAeUkTQSxujYJX0D5/oYS0ZVbCeuTzbctnL36Pt9XE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbOa1iz7qLuXFv2HXAhuI5BbeWQFMZIuTiJfzdHxSjqrILAWPKjy/cwHceKtMakr9VTHiHLdXyyrFkFZ672EaXfMjKByXBBXb2ABEzfWzHIWZONrbZ4wXYubLG7/qOZ5f/e5C0oSqPQvHZXNPD9INgO7ZOpgZxLGo0nHwfbWlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=H8dEemsY; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="H8dEemsY"
Received: from localhost (ip-109-42-179-132.web.vodafone.de [109.42.179.132])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 535C1BdN022427
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 5 Apr 2025 14:01:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743854472; bh=cAeUkTQSxujYJX0D5/oYS0ZVbCeuTzbctnL36Pt9XE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8dEemsYXW//K90iHf1PeiwwngPUNPg9jUcuvsNN3D2ouPbgO8svh22bpquWZjmNf
	 2AL8Km4IRr1+L5zRgNmnyqXzWxlTYJsxHxRISnGSLcMPAN60EcicrVuA/DmqeMsqW4
	 ikWPgK9FFiErMOTgV/UVhLCUuYzfPzFklR1Kvb0s=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Dirk Gouders <dirk@gouders.net>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/3] perf bench sched pipe: more processes, additional worker, multipliers for -p
Date: Sat,  5 Apr 2025 14:00:05 +0200
Message-ID: <20250405120039.15953-1-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250402212402.15658-2-dirk@gouders.net>
References: <20250402212402.15658-2-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm very sorry for the missing cover letter in v1; it was me giving
git send-email one wrong answer.
That cover letter explained that I want to share some changes I was
experimenting with, maybe something of that will be considered useful:

1) The possibility to run more than two processes (new option
   -p/--nprocs).
2) An additional worker function that sends tokens in a complete graph
   in contrast to the original worker that simulates a ring.
3) Multipliers for -p so that a machine-specific multiplier 'p'
   meaning "number of online processors" can easily be specified.

I'm sending the v2 with fixes for issues that I noticed myself, so
that something more correct is out in case somebody finds the time to
look at this...

Regards,

Dirk

Changes since v1:

* In v1, I completely missed to finish the handling of the new option
  -p together with cgroups (-G).  I now kept the restriction of two
  cgroups and just put every process with an even index in the first
  one, the others in the second one.

* Don't explicitely cast u32 to unsigned int (a parallel discussion
  in another huge series was about something different -- not such a
  case).

* Don't put the start of the thread_data array inside it; all workers
  know their indexes and can thus access all other data.

* Merge create_pipes() and create_thread_data().
  The result isn't that complicated, no need to split those.


Dirk Gouders (3):
  perf bench sched pipe: add -p/--nprocs to run more than 2 workers
  perf bench sched pipe: add complete graph simulation
  perf bench sched pipe: introduce multipliers for number of processes

 tools/perf/Documentation/perf-bench.txt |  46 ++++-
 tools/perf/bench/sched-pipe.c           | 244 ++++++++++++++++++------
 tools/perf/util/string.c                |  58 ++++++
 tools/perf/util/string2.h               |   1 +
 4 files changed, 286 insertions(+), 63 deletions(-)
