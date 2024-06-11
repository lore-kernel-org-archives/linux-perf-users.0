Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A416171083;
	Tue, 11 Jun 2024 05:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083447; cv=none; b=VQS/oF740ObHbPJX3DcbY+AcGE1dAFrr5oB44tMzMCSkCve2iVhcYQyICqueha29nA5T04jQ8ImhDfq7PdOyJclaGazjBtuQee+7JGUYYb9xpBaF9hprqyYXZUSf7tvw3MHzw7WWmgrcCMfLv5HKX9ob17B6+vezCYI50A6yj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083447; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNzmaRQNVgBXP/obVs3d94usDy8N3Fh3HVFeR4qRgIbPGoXTX5dO6iZaA2jA34YGnMYaaJ9Efb3ZTXVjUmsjEWbsh5djH2NZxwdhS/8psVdfgLlmvcFYBuwSdT1hqTp4BfSUEaTp/iegMZDELN3IABJcBxX54cvzfjUw/OOL7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAFD7Oet; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAFD7Oet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718083446; x=1749619446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=nAFD7Oetu7Dm5ajokMMWV9MMq2R4J/Kteq2AjSUFOzOp1mGRJ1dcM4U4
   SpO8s1Pi79ZfYpY/vIJaaqtZ5IGVZ/9aL8lWoU2fRwLQ81cp9hcznNoHk
   NY+S//Xay7SAhXyEnBJydge0GjAuDu0MYS9t3VHTJeKWVeySTXiCig6UG
   pyysF1wdhFiNDCWvMZzCK1JsEIpaPRE3r91oAQuaAzIDBVJARHVR4HC1s
   Aw/qoVwdQ3JtHx3othkkFhVNkgdS6qyyp5yCjLBOXAJPWL0jhpOl9k1iM
   eY6vb61qPNyaWhVyW0wYJGh1X2OIdYd+v9tjSMNkFVZP76q6IgZJU2udm
   g==;
X-CSE-ConnectionGUID: 81SOgoYiS8iQMZGXuOLPvQ==
X-CSE-MsgGUID: zBPGSJ5sQ0OX3ftaMdOqlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14651129"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14651129"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:24:03 -0700
X-CSE-ConnectionGUID: D3ikHP1PRfORkEaAFvxAAA==
X-CSE-MsgGUID: d8AeygDfR1esrYkukERD2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="44441192"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 10 Jun 2024 22:24:04 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v12 2/8] perf data: Allow to use given fd in data->file.fd
Date: Tue, 11 Jun 2024 01:23:21 -0400
Message-ID: <20240611052331.85715-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611052331.85715-1-weilin.wang@intel.com>
References: <20240611052331.85715-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When in PIPE mode, allow to use fd dynamically opened and asigned to
data->file.fd instead of STDIN_FILENO or STDOUT_FILENO.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 08c4bfbd817f..98661ede2a73 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -204,7 +204,12 @@ static bool check_pipe(struct perf_data *data)
 				data->file.fd = fd;
 				data->use_stdio = false;
 			}
-		} else {
+
+		/*
+		 * When is_pipe and data->file.fd is given, use given fd
+		 * instead of STDIN_FILENO or STDOUT_FILENO
+		 */
+		} else if (data->file.fd <= 0) {
 			data->file.fd = fd;
 		}
 	}
-- 
2.43.0

