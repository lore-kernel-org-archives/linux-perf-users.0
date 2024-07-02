Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B3191F77;
	Tue,  2 Jul 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958088; cv=none; b=l8dCqzDCNb7GSJQZ8aeVxPluTw7ymrFjCdakmB4ukmq30Zt4KiUb4x71B0TBnNOxYlMG9mfalHNxPd/cO1xsx1XM0BkAe/RIh6b/HhcX0lST3EuWRelEu2FyJJg5Wzsize5TyRMePUDRjjfiB23cN5CdLF7HzQiyHxrqoH4YLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958088; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2KFb/j6AYKdCU/0zdQi1giOL3R0gwdXrYtKf1o00cm93o1hEN9+Jruh0BLL8gFNbQTlvleVlZCFnJK0Z53Ej1CKAlePO8i+BsKilMND6hIuOzwqtcuirpTuqgR0Jna9R5WPpLEfIP5vEJG3cm20TJJsTorXcDMpeeqfRkHDACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RClkiNmx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RClkiNmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958087; x=1751494087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=RClkiNmx9+aHH4FsDd7UtwXKETPsVsWZV1D3rAGhTX/7N4i0kTxQYYHP
   271nBbzlIb+AMf3kmH/Ad2ipycDaO4fA2fo6NYhR85KLfNpduLGMY9alY
   9MDn6sp4CA8VVTnZHOevRMdSkjoqRN8X+B7vge9AfSc5rjDXLxBnVkWk6
   UHISV8eZTiUuU5RJocs3j7GsOoGOSML61+3muoxnVuhTb7faMSX//Vxi4
   92dtdmat9F1MaQzPqcAD+D0n0YtGbTNsuTONOvV0VXKIBXrnbtmxh9H/0
   mX3Brs4M5Scui5zFJ72lKv4kSsNf4pFIfBUpVTPvYhPksNrZr5tmPqHFF
   Q==;
X-CSE-ConnectionGUID: 9wuB0gpDSOKEtbaStvwtJw==
X-CSE-MsgGUID: LoiVZ7K3Qu+KJjj7tB/O2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17296897"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17296897"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:08:04 -0700
X-CSE-ConnectionGUID: o/0PvyvhT7uDfgnausskWA==
X-CSE-MsgGUID: WDE5P2DGRROiZpELmwDHfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50888195"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa003.jf.intel.com with ESMTP; 02 Jul 2024 15:08:03 -0700
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
Subject: [RFC PATCH v15 2/8] perf data: Allow to use given fd in data->file.fd
Date: Tue,  2 Jul 2024 18:07:49 -0400
Message-ID: <20240702220757.262825-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702220757.262825-1-weilin.wang@intel.com>
References: <20240702220757.262825-1-weilin.wang@intel.com>
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

