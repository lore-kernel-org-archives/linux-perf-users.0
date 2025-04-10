Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3326AF3;
	Thu, 10 Apr 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243889; cv=none; b=V7S9KEbcrQt/AGOAXdR+Pt7V0OuS4WoqPqIwrO5VaQeOT9N3yCnZPliOsmPs+NfF7waAUH4A5bRdlRsrPbh081ByHCmCjmKgAGgt636HdZr0BJfjhPA+nLvueF59csFr47kfyqg1thVDKESI+HOeIT7Z0XwZBYk4ydseR+pqGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243889; c=relaxed/simple;
	bh=dsbGPVshCO+nHzc4NPbueKWHbW419n9zo+SvA0BkUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYzsw6gw8loCTq+LmWaf83id2pS+ER66xP0BJsql/Tmz+VPccQtE/u7Y0spjXPevKRnIijHu+jDJJEpVQLxcOFcEfRuMuiHjx6lsOnrH5fJxpB0TV2XnO+XV9QLGiVirMcv1Qh708ek9Q7XC1Ah3LX3REueDJF1UH85f5DvQnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIhH1Hth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIhH1Hth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572D5C4CEEB;
	Thu, 10 Apr 2025 00:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243888;
	bh=dsbGPVshCO+nHzc4NPbueKWHbW419n9zo+SvA0BkUZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIhH1HthBdpBOkM5BQKi85nnkacsGfoJpFWNqbDZEtsvrq4RfY3dS5IXT9Eagz13z
	 0vQtc7xd1YKGA+59SZvYSXRUAXvO6xyVBIjPG0s7GOVvWHLQjvk+A9sP3ZW8vzpfjH
	 ZrdK+Qk30oM5YuK0+z/bW+u5vyZqz5MhG3//X2matNN379A4Dk1EDDD7Zaq8pj/1Vw
	 sAts++cbQEcYESVh8ddbwN+YX7bQ14MvSmbnl/y/8FZdcVlJThDODb/We+Py0hcsO+
	 bi87EYghWjEynyFHWZR/lZFSTllXbhn8raPtECt4sNuquO8oEGvb9u4lJQW3ymFqJI
	 Rp/AmDkVJMM6w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 03/10] tools headers: Update the uapi/linux/perf_event.h copy with the kernel sources
Date: Wed,  9 Apr 2025 17:11:18 -0700
Message-ID: <20250410001125.391820-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  c53e14f1ea4a8f8d perf: Extend per event callchain limit to branch stack

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Please see tools/include/uapi/README for further details.

Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0524d541d4e3d501..5fc753c23734dfc4 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -385,6 +385,8 @@ enum perf_event_read_format {
  *
  * @sample_max_stack: Max number of frame pointers in a callchain,
  *		      should be < /proc/sys/kernel/perf_event_max_stack
+ *		      Max number of entries of branch stack
+ *		      should be < hardware limit
  */
 struct perf_event_attr {
 
-- 
2.49.0.504.g3bcea36a83-goog

