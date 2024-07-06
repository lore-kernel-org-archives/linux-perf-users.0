Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14254596F;
	Sat,  6 Jul 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720308606; cv=none; b=Vif7POnNvJqIU7mXDVP31xfBWoaJsgzwDFoBUvEeyKDwzQbkSBTPpJg4dl3GZ2sBmD1PBE3IzA+JwkpBlKxIXhCuIm5owRhMEJQd+rKFG3a0j6JXyMx9L36rG6G2XJeWy7BXyVEYuZPGQDk7lKm3BA9nHgXO/+5WlWcJ8OPMOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720308606; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz6DC8+KWCvgTaNHA0+YN+3RvGxlzSKjDWZ8RCIUoiHBt+i1nitjTW1rY142IInWZlF3NyoEhl2B2i/Gyx1hI8KJhBEkz4yRwC6iCIugfDP2SfpLDABIhzvFnBqw/+uKlpRRkrwmQ1s1ilZ8kLOxL2oP4PxNd+0SmM+k858CT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ce/YW5mg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ce/YW5mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720308605; x=1751844605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=ce/YW5mg7MVOxPfyMqqfmg295VJ57ffmQh5JfytjIfR6w/4CqTg0WI0D
   EwtT5Uxxiez7nMPaa6Xs/IFAHJEpC0pMQgDtjZyr9/Tcm4ywUUTNFddTh
   lYhAcYZNYPzzBOQx9IkAXPjLMyBMlwmEQLMXleM8SoprIuo2z/sM6HXrA
   XbXg50nGKnX9D6rXON4C69nmaUz+wcfGtc4s/S9pMsqtM664KZdr+9P7q
   RJCr3K2b1+XoCgIT1oSZZvDoZx2a5qRfdODJFTU8NKsHW0KGxtBxsplur
   wD2gao5bZtL8mmA4/u8nO7y/WKQ95EgpME6lvcTC6V0u6nMW6RiIsgQNN
   w==;
X-CSE-ConnectionGUID: /GuaF9eXRV68AyttgTRoQw==
X-CSE-MsgGUID: ZMLKwKwOTA2L7gKKHKAWWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="42971640"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="42971640"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 16:30:04 -0700
X-CSE-ConnectionGUID: jtAsK1pBQfqQy2px8EocUg==
X-CSE-MsgGUID: KAQ8FBmXRN+4Tcft+Y1NCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="78294760"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jul 2024 16:30:03 -0700
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
Subject: [RFC PATCH v16 2/8] perf data: Allow to use given fd in data->file.fd
Date: Sat,  6 Jul 2024 19:29:49 -0400
Message-ID: <20240706232956.304944-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706232956.304944-1-weilin.wang@intel.com>
References: <20240706232956.304944-1-weilin.wang@intel.com>
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

