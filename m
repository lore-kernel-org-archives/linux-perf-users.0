Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BB3A29C;
	Wed, 15 May 2024 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751894; cv=none; b=C8S0EUCjIiGSmZPUkEkMx8DuCSTlhxr3FO50O5UnW5KMi3IT0Mc8shnYrz8sYbmm0yL7/HuF1SmmfTH4iAbFEdAlsvbhLO4Erm2C3e5+vFnZJ02AcUwqp6C2yixWihONsqRdXb+4Wb/QDrIGOravw5zyn+sNXgStX1E8ImwqkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751894; c=relaxed/simple;
	bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIK/ZkqzsrSwHg4+0MvtuaV8yN51yO6VIzsZKWiSEXHT+TSJHzCwZ3Js6Jqy4QluOIDc/e9VGQwQY+EgIDaIWdQuUetPt0MeFr2bnJvEpQ0VIdDwsCLjOrbkxDNs0dk39edyVdqnVpllWpgYmlg/Ul23nELE7+FDGRD+PKQNWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNj3oJd+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNj3oJd+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751893; x=1747287893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El3YDeqjczhekPR1W+uyDSK2dsNIh5KkIWwOCQU6c88=;
  b=XNj3oJd+1b3Sa0FFwduk+d3h0ldNhg7NR62rOiGCcVbD9HUZyCI50Z+1
   LwcZMujxZDYEfRydharfN9Sw+qvJsqxf0pWQHUa1t30Zs5MyuKMihjS+q
   zY+odL0oF8S7HxTVwLM/PQnHWblfK5Ty9jT1SqmCC5yoXZKhuTAA8Oi4E
   cpZGu4HeHJZCs21kKGKYfEIuNQhPK9axLzhOZnmRbvOe70Q/KqjTsFoJy
   5sSy2ItvCKbvKh95uTETAnIQHi1KKd8W5g2hSt/cJIfUSIHDWvVw6RFIw
   fpbvbyW96aKcUt6KYH/ZF3mZ/mBtZI4MsBmMWdRg2sAwLLL42PPJ7pbzh
   w==;
X-CSE-ConnectionGUID: C05+YnMmTq+6XhRrv9oWvQ==
X-CSE-MsgGUID: 9Us7zIwFQYisoi3XyzsafQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298025"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298025"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:50 -0700
X-CSE-ConnectionGUID: TuBgUl9HRf2kdIWgXytw+g==
X-CSE-MsgGUID: 96ocs0epQNWlhDdoIHhmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469200"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:50 -0700
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
Subject: [RFC PATCH v8 2/7] perf data: Allow to use given fd in data->file.fd
Date: Wed, 15 May 2024 01:44:24 -0400
Message-ID: <20240515054443.2824147-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515054443.2824147-1-weilin.wang@intel.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
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

