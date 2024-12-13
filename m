Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDD18E025;
	Fri, 13 Dec 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119462; cv=none; b=qZNoQw1icO7+sjIzDBhvqAv3mHTyDYA1fCxdRlDsM8F0dGg6ZH1NqH450hG/fsD63VkIlvUJd1ZaQf1wi2z+YZUC0ZxA8QTBvblc8DdX5dgrH1XLZrQXN276/iEaIA1To+V9Nk3lOlJImrev+lHGJec1Iqp8X69Thn4MM0ycpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119462; c=relaxed/simple;
	bh=D4ty3KTWrdY1iGiiAvl+AEtUmSaGSlalL4VIymbfebc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRI6Iu/jDehY01ZIaSSDMU/EvtO94OZ2HzzT6CLmR8PA29ccskOjRbfG2vJjR8m7IsF2Jtak9RwtYCekcAQaEQaniYom8PhJl32+ZNTX+e4FhXYHyPntctwSpFdnGs3AlnxJKIElnH+9kvLCEttPu7oFYd4yY04u+hj9TX4Pj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDrF1Yqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDrF1Yqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D2DC4CED7;
	Fri, 13 Dec 2024 19:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119461;
	bh=D4ty3KTWrdY1iGiiAvl+AEtUmSaGSlalL4VIymbfebc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDrF1YqjD6jUtnj3ad1nphxx5I390sMAOblihHoys0hdSEt46N48LCor/+9+3n8MU
	 bhGgtwP88kzi9Ob0xIN4gWBxXdgmxle63UYDjvgUWywtPEJ9QZXMD8Q8EQh4yaFL93
	 fhZB+leNUuwv8VhuQpA1mhUQoXx9OgrszBvu/cBtgsRm/VlXI5GqF6V4ZrngHztcVt
	 6/S3yQX/4P28z+pbSslBqe886E6cK9Tuv+LK3VIBhSGnxUMy4bvTsXWFCHPBdkEeit
	 bb2LawMF/H3u/AkC68hRZLO7F4ApP0WwsQuDGVEEO7cXnsQGTc0Wk0F6kUoAfHpejC
	 Vg2PAEQfiM21Q==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/2] tools build feature: Don't set feature-libslang-include-subdir=1 if test-all.c builds
Date: Fri, 13 Dec 2024 16:50:51 -0300
Message-ID: <20241213195052.914914-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241213195052.914914-1-acme@kernel.org>
References: <20241213195052.914914-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is not really included in tools/build/feature/test-all.c, so any
questioning about this feature should really try to build
tools/build/feature/test-libslang-include-subdir.c and not set it as
detected when test-all.c builds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index e25cdb7db40e3f3d..16c3194c3a5c42c2 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -82,7 +82,6 @@ FEATURE_TESTS_BASIC :=                  \
         libperl                         \
         libpython                       \
         libslang                        \
-        libslang-include-subdir         \
         libtraceevent                   \
         libtracefs                      \
         libcpupower                     \
-- 
2.47.0

