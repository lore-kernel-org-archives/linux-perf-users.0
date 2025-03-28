Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F6257D;
	Fri, 28 Mar 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165368; cv=none; b=cUkz5gLZCBULiZwSl+NvqVqF7Fyii5oBg6NhZbZMOEA/aKTlluvYowJI0FyW9UYIeNN7yXvHhnvfbHTyu+q1EDpNPPkK6+cRT0ATrrf9bvbIc0KwTHBoU9ciFTclVwLJD+hlAUd/AIpq/lFXTKByCrwqWk7xh8akPB71pf1ZF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165368; c=relaxed/simple;
	bh=ncwPq0ROfqoQk2dq3DxoujNWVU3Ft4uTR9Zwfn4HwAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uFqnQs/OD6KTQFU7jJ22bWc2JnWZz86szLDXPTB6ph9kfwPOiCyyjf7bJz47rWDLwaKeKZbyvFYa7xY9DKt56vyY4FltOQlGc2+JYuXdwlJfXeux5qe+8RJUvSpEektTTjfyE0jG3Q1jkhBuga6eYiyF311vVh76n0Ywvxq4spY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129DA2B;
	Fri, 28 Mar 2025 05:27:03 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C57B23F58B;
	Fri, 28 Mar 2025 05:26:56 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf build: Minor cleanup
Date: Fri, 28 Mar 2025 12:26:42 +0000
Message-Id: <20250328122644.2383698-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes two minor cleanup for perf build, with
using the GCC-15 (15.0.1 20250327).

Leo Yan (2):
  perf build: Remove unused LIBPERF_CLFAGS
  perf hist: Refine signed integer checking

 tools/perf/Makefile.config | 2 --
 tools/perf/ui/stdio/hist.c | 6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.34.1

