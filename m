Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005F317150;
	Tue, 31 Mar 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991202; cv=none; b=jljgiMvexeRtLQlRkZnt7TOtdcU8BAg+zpD7djFG6sxYFQMzD6oL6tepLsPx8G/hH6XLHsYzfRvgkjbaFQMCooEiSlFqnvUt/b/V0xyd/L8qAZNoJJpUzBpVf3X3K95L/KJ9Av2kKVAm5YlN6litC3REsQIifmhuBwTvwpPfZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991202; c=relaxed/simple;
	bh=oA23gcUOWEGpsIGzuR6kv7T0QPPrR2K5IJidWXhld2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZeI+dSGt22TItEwBmDJFxerVvnEXn3tOu9xnc6mT0gNuE1Skp1gSwQgWgxIIbanj2lFoNehj3dBtbo1vNrvVgpVY6fFBNLmoU4EPu0odYfz2b4axSRjAgygkILzY/Qym65K8aj47Vy7oLYEc4NQi7afkeZK2AjRA/LnLFq8Zjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWMa8TJI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWMa8TJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A95FC19423;
	Tue, 31 Mar 2026 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991202;
	bh=oA23gcUOWEGpsIGzuR6kv7T0QPPrR2K5IJidWXhld2A=;
	h=From:To:Cc:Subject:Date:From;
	b=iWMa8TJIKCkt5colXfxFmk5griUQF7h3j4gVZwRSFA2ah7GRRpwLz/2hafPRdb7JB
	 FmCEPqc2zfNgZ7+wal5N+wE7/taBJtfHGXxQvrV30gZ+f1Ok+TtcpV/Bh9oNjaEmVW
	 flao21A0tDCHplCLs6fyATLogEOx+nPnXWImreyZSbKuB0nuSbzzoJENieCG+KEd3p
	 YHIAiuYi0vzN71l9AjbtCYj7Kk2qYJ9n5QIbV9MwfnThBlWRqziqqbJO/izYph7cSx
	 9sKG8IZnDaU9yVRrFNPpm35Wr7/+7psiEEKu6PZ8Clsf+MctAIBM3L+EZDCGp8mtA8
	 WI2l6O50thRPQ==
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
Subject: [PATCHES perf-tools-next 0/2] Move some headers out of tools/include/ to tools/perf/trace/beauty/include
Date: Tue, 31 Mar 2026 18:06:32 -0300
Message-ID: <20260331210634.2126391-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since those are not used to build any tool in tools/, move them to the
directory where we just track for changes and use those headers just to
scrape defines and turn them into id->string tables used by 'perf
trace' (or any other tool in the future).

Best Regards,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  tools: Move tools/include/uapi/drm to tools/perf/trace/beauty/include/uapi
  perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/

 tools/perf/Makefile.perf                                   | 6 +++---
 tools/perf/check-headers.sh                                | 6 +++---
 tools/perf/trace/beauty/drm_ioctl.sh                       | 2 +-
 tools/perf/trace/beauty/fadvise.sh                         | 2 +-
 tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h       | 0
 tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h  | 0
 tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h | 0
 7 files changed, 8 insertions(+), 8 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h (100%)

-- 
2.53.0

