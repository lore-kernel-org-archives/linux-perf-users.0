Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B42765F5;
	Fri, 10 Apr 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781622; cv=none; b=cQbkWqkqd6MZoO28E4eLVMeYjttEK/IPgTbQ3WJvA8X9Bn5/SzjVez3ixOyRIijit+/xDI4agUA5NlfVVYopBMkKEi3cUnHn2BztMuvRxxfruVRZAZ6XftMoVYnDpLS3bSxhuvRnJ2O1KB9ezTcOTyG+piwcFx12uFry8XlXvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781622; c=relaxed/simple;
	bh=VCq3bOsYCM9BcnYJbWR2KntvzEnSM5cFyCtHri5v5eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKDs7euIZNx2ZzfR1ub6cPfGcZ/7ZA2uEAUHIIC6P48YLu0MeKyQT5PJ+5ymldS0htRahhGIbPS4KVHJfM0PPaYDbhIgOSwlAlNeOUVw1qocxKaSNEOkHP/eCCBJk0dXuP1T+srhTRh2mRRYMFYIdn8R+8rUMZOKyC5pDqt3BJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCxsEFxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCxsEFxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD23C4CEF7;
	Fri, 10 Apr 2026 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781622;
	bh=VCq3bOsYCM9BcnYJbWR2KntvzEnSM5cFyCtHri5v5eg=;
	h=From:To:Cc:Subject:Date:From;
	b=tCxsEFxly4p9R6P1XqXayDU5OqHFqUzeq1YxLCvOAWNRs8YsymL//dKDpZkdEVb8M
	 Bf4kht262PNIFvqcVNh0ATvgvE0SM82DLjEwiQIshCttM252yEYMrJBQ1fhlmS9Lvo
	 9HZzu0JiG6Vq1Qde1MIBiHNCsdOEAsOfJ5GuweU/2G7twfX0+Wcts2+ZRn5dcDK/jc
	 ayA0JtTDumY+XE2pnGWVbAPNjqk2xJkaIXSu4SEEedOmgwGMGDrN2hu5FvFwQIPSiQ
	 NduzKkrF1OcU8mgpBPNerT0FOGm9p6PEaGxQqluWSNIo+K19gwR8OVnXdmtcwV/vF5
	 M1ELSEL81lJRg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES perf-tools-next v1 00/13] Sanity check perf.data headers
Date: Thu,  9 Apr 2026 21:39:47 -0300
Message-ID: <20260410004000.148138-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	Sashiko recently mentioned the lack of sanity checking headers
in perf.data files, that with a fuzzy or maliciously crafted file could
make processing a perf.data file cause deleterious results.

	Add sanity checks and some arbitrarily generous upper limits to
headers, if some are found to be questionable, lets tweak them in
upcoming versions of this patchset.

	As registered in the Assisted-by tags in the patches, this was
done using Claude code to speed up development, hopefully no
hallucinations are present.

	I'm also trying to get some of these checks into review-prompts
skills, some of which were already merged, for instance:

  https://github.com/masoncl/review-prompts/commit/2bb2159893ea926e120105416e95629b9ef1508c

Thanks,

- Arnaldo

Arnaldo Carvalho de Melo (13):
  perf header: Validate nr_domains when reading HEADER_CPU_DOMAIN_INFO
  perf header: Bump up the max number of command line args allowed
  perf header: Sanity check HEADER_NRCPUS and HEADER_CPU_DOMAIN_INFO
  perf header: Sanity check HEADER_CPU_TOPOLOGY
  perf header: Sanity check HEADER_NUMA_TOPOLOGY
  perf header: Sanity check HEADER_MEM_TOPOLOGY
  perf header: Sanity check HEADER_PMU_MAPPINGS
  perf header: Sanity check HEADER_GROUP_DESC
  perf header: Sanity check HEADER_CACHE
  perf header: Sanity check HEADER_HYBRID_TOPOLOGY
  perf header: Sanity check HEADER_PMU_CAPS
  perf header: Sanity check HEADER_BPF_PROG_INFO
  perf header: Add sanity checks to HEADER_BPF_BTF processing

 tools/perf/util/header.c | 219 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 6 deletions(-)

-- 
2.53.0

