Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4628642B;
	Thu,  2 Apr 2026 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145897; cv=none; b=ZLMK74mjTFhSB9MWLrY9tCMbWCe3JDBXO8qEvfTd2+Qf94eRWnzkFyxos5En0vhDTRc98saZxazg7kkJdbKVp0jfkAz0SK/VQH+DkTrrw5qAWY/MS9hvB8MNiPbrYXisYHY/PODdzPXIffwam7TICHYQ6851hP/D+ghgQEv48PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145897; c=relaxed/simple;
	bh=cmAOWbFY9GvPrEenpcTy8SPt6Lqw5urRw0Ho2dHEvhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ji24JweW5axrWco693arVzREs+PT0H1hx+jxm8EpyJFpirE/BYXf5v9yPPu5b/pKAcTXnwNDTXVhbBJTFOJ9o8y+I1TCIO7hQQZwp4fgzdpgw0Onp9MsNjjJezCSRMR/jQeLlt8n+7Nvtb4InzKUT3isfPC2BFvTfwFifOtvtIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HtDwTNWR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HtDwTNWR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60C6419F6;
	Thu,  2 Apr 2026 09:04:49 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1B473F915;
	Thu,  2 Apr 2026 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775145895; bh=cmAOWbFY9GvPrEenpcTy8SPt6Lqw5urRw0Ho2dHEvhE=;
	h=From:Subject:Date:To:Cc:From;
	b=HtDwTNWR1TeVad/AFwwLX+sLSdsD5/rjBJGyiKsUabuNO3v+Jj+cMt+YkSl2cG5uJ
	 R65SY3k+5GUvLY51GgM2twN0BGDPeiFtKomcwMVULfIWyevgJS9m8YjAAA29ATb1Bc
	 IK/2LodyCfO0dAUVI12nMaZF9dpmY+2oPyY2GGso=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/3] perf metricgroup: Fix segmentation fault and refine
 logs
Date: Thu, 02 Apr 2026 17:04:46 +0100
Message-Id: <20260402-perf_fix_metrics_group-v2-0-1f9427a5d763@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ6TzmkC/4WNTQ6CMBCFr0JmbU1bfqSsvIchBOoAsyglUyQa0
 rtbuYDL7+W97x0QkAkDNNkBjDsF8ksCfcnAzv0yoaBnYtBSVzLXN7Eij91I787hxmRDN7F/raI
 YsCwHnVejqSCNV8ZUOsWPNvFMYfP8OX929Uv/KncllCgMFkONaHpZ33t2V+sdtDHGL3eHi2a6A
 AAA
X-Change-ID: 20260327-perf_fix_metrics_group-4be55b236f96
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775145893; l=907;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cmAOWbFY9GvPrEenpcTy8SPt6Lqw5urRw0Ho2dHEvhE=;
 b=ZiYgjKS74AcDAtx+8SkIvYQi/D8mauy/1RT+ShRWRwQuLDp4c0DcXOS6E3uFo8yfNVFKnNqB5
 Uyxl8WsHjQxAzMEYytZBNHiIOTi//A7776ZK3sLSMjJOPM4jMn2dDQ+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The first patch is to fix segmentation fault if there have syntax errors
in metric groups.

The last two patches are to refine logs to give users clear hints for
failures.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Added fix tags (James).
- Added before and after logs (James).
- Link to v1: https://lore.kernel.org/r/20260327-perf_fix_metrics_group-v1-1-49e4b8ee9a08@arm.com

---
Leo Yan (3):
      perf expr: Return -EINVAL for syntax error in expr__find_ids()
      perf expr: Add '\n' in literal parse errors
      perf metricgroup: Refine error logs

 tools/perf/util/expr.c        |  7 ++++---
 tools/perf/util/metricgroup.c | 11 ++++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)
---
base-commit: d9db9c8db56c3e378aa5c91637664f77ca5a6f72
change-id: 20260327-perf_fix_metrics_group-4be55b236f96

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

