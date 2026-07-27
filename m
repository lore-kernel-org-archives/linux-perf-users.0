Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B1409638;
	Mon, 27 Jul 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169037; cv=none; b=rH+ARsgEGuG2v09TTC07U20j6MGbihcKd6JPauO0x0psCUbLJHn1y1DvAQRr+9E+Rm83QkcDBuxmHp255ML7L7Tulgra1Z9cuMBfWv7lqQZuSK1S9nmY4ji6MMUSyivfaSD+BRW6lhFO702UsB4MKP9ZDc4D3iHdzJbS4b/fLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169037; c=relaxed/simple;
	bh=cR9saTWVkp9xgrcBGwZB+LeHwJwek3tjcTFMgL7PbSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F9MvzlMlx6PZgltZY8bAwoAN9MB4Hr0dtOtgXOExGvNl53eW5F90qX3RhnOVyg4DFdR7q5NkyTYY2diZS4Gf25UORGNcfVBxt8JCFeUj+0kzSaXG9iD3bmtBeBAc4daAD/h77dx75eTz48d1cRyUqAKk3+jlyet8asu0CMd6Yug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY3U/Uv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY3U/Uv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BAD1F000E9;
	Mon, 27 Jul 2026 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169035;
	bh=1gGPNqYU9eOF24Zrj46devJx5jF0ve11MXOvEIHIrHg=;
	h=From:To:Cc:Subject:Date;
	b=oY3U/Uv9ozYf0FlVXgm5tSZrC9YVdaZAox0gOc8mGQRdRS1F6dTLOoA/qm6Pj791V
	 ACsfo2iitpdcNpRoyK8bcdangPoNXW8jSPMMsUKokJPbtfzFI2oWYp4sFfGusRnQrQ
	 NVLKgLtwK7jiBCVZiBELpuHE8pPa9FSw072JWC4uJ+L/793aWWjCV8+XpLY3uoRHRc
	 dLegf35GPCjj0dWE/iydYNffS3+Pcyor3fg4CdT6vnyQIBBqbHodQYfdcZQMvMeVMA
	 y3JyuAodfebCMrrWa0mnU5oAvZIHHhIBCnt/Qn7PuN5Izbb2JgEg5jlnVlOuTb4z99
	 FlHfULWq90tOA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 0/5 v1] perf tools auxtrace hardening series
Date: Mon, 27 Jul 2026 13:17:00 -0300
Message-ID: <20260727161705.64807-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Please consider applying,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
  perf auxtrace: Fix queue grow overflow and old array leak
  perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
  perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
  perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero

 tools/perf/util/arm-spe.c      |  4 ++++
 tools/perf/util/auxtrace.c     | 15 ++++++++++-----
 tools/perf/util/intel-bts.c    |  2 +-
 tools/perf/util/intel-pt.c     |  2 +-
 tools/perf/util/thread-stack.c |  2 +-
 5 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.55.0

