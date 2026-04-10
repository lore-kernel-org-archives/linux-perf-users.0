Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B421ADB7;
	Fri, 10 Apr 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858958; cv=none; b=QhJlElKqVRes/rpReGPLO1O+lpvqToUxpirZyGmRdlm6vkVvBSo8oiS5Fu/Ph6g7iyrJl45BMA0oxV8pYnjbH1lQqXz0lxrRnoxTXSyraifj4BqJbbS3NLFS/dAs+4f7pjn9XyIlvH7vGIBoLou6gSvOHSMwZi04g2wg+fL0rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858958; c=relaxed/simple;
	bh=tZF48dGgF0GosxMj14ySV1goRj1R6i2nX/mDUzoqA4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnFgGmuq9isK4BFA6iOvyFd4/tfGbkyIov4GOaWPCC0fA7puHQAjqT3lxBTPngZZdps2z/4BTOB5Mb5HegRVDwCE67BrXtnEF5yc5NAn3OTyGPfOdKQLiAy76NRKeXxE8UQfCwsdoAFd4THPnP+zgOlvQpya0n4TBxIuluWARB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHwG3KgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHwG3KgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9025AC19421;
	Fri, 10 Apr 2026 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858957;
	bh=tZF48dGgF0GosxMj14ySV1goRj1R6i2nX/mDUzoqA4U=;
	h=From:To:Cc:Subject:Date:From;
	b=iHwG3KgHhp6u1a4gMsxpynIA8zB875SdAk8vngvHfWzBL+6v4HZdp+4AKxIeM621+
	 xbavzH2AzgTyv8dY4UTgRorRd+llrASbrWME0vOHjFXfGXhrOybStuqTS8VtkS8SUe
	 PrlITiE2UYP0QbcI61ObJYLw8qrxs7iLO5SoUSDw3vo/gXyK4Wp4v2t+I/GVmMBFDY
	 OuE0hcsnUHyTFCZ5pqVr//rc6VfdM4TVPpMjvS/1be+XrW11J1MCYrgAhhLg3NP4Pe
	 UUr6X+9oIm2vhTtqdlVJHaW1WyzOGPFF4Sn2qbRqW+I/ja74BAf71GmHjdCHh7IfmH
	 dwpIFNrAZXBwg==
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
Subject: [PATCHES perf-tools-next v2 00/13] Sanity check perf.data headers
Date: Fri, 10 Apr 2026 19:08:52 -0300
Message-ID: <20260410220905.200051-1-acme@kernel.org>
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

- Arnaldo

v2: Addressed some Sashiko comments for v1, some are valid but not
introduced by this patchset and will be addressed in a follow up series.

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

 tools/perf/util/header.c | 220 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 214 insertions(+), 6 deletions(-)

-- 
2.53.0

