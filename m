Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0851BA292;
	Fri, 13 Sep 2024 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204891; cv=none; b=dJXH/czE4qRL1IwAtQoc5DrAP+Ve0nNfoJG3z0QD8AcZqcvgjiJ5JUOXs16d7sqM/V7FCwuYW4ScJGB9HFFgRujgj/V0XT9bHuZgFLee83w+NJqaYN+ZI5sPKnd5io+1WBut/IrHeKrIX4xnIwdjnPofwb1MakA0uOKUzWjvtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204891; c=relaxed/simple;
	bh=ny5tsc2816HdyNr0QPIRAAn/tx+IdHcJgx2i9LCmDBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OB7dWWj0WadsQrnoYAFmNXmERQXIh9MOX+YX3ceb6MqrpgnJUlN41a9AcXmnTj1+31f9RYEccPnBVh6OobzUDEe/qEmqGHEpedZMeU8KTOspMG+1jPH6ZdLZQr9Wm0f9CpHOUlUYajL5MCDnhYlSBtvgBud/MB/qj3wBvjwfi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnFMqbIg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnFMqbIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726204889; x=1757740889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ny5tsc2816HdyNr0QPIRAAn/tx+IdHcJgx2i9LCmDBI=;
  b=RnFMqbIgqLrAaYyvB2wts0xbn4u62/z5edeYJ7pEgkgJFRKJjIlWUTHQ
   nD8gK6uNyJ/phe0uwSPkM3gBvGndC5oLzbxBQyuycM11A0h61hbJWimIT
   vlxHpm50EWt62QlvtE+YwxAE+uCScQBP+hqVIg69E3b4WgQeou3nWrbd8
   hG8yNWdbbFTOchW0kwYpEGAUR6RqHJwqe3pOmVAXpToe2SiOdFQ95vTr1
   QUp9SltzS7K1vRZ5BHm1P22zPhLLbcPo4CnfL2qXhDNHr1pF/b6fsWhhy
   baIMS+BnNCkwZgASyFy7KVW5a38y/nsyNQKVT4U4L2NGrWQt2s9YPf0Q8
   A==;
X-CSE-ConnectionGUID: 0VhMEptZQwyPoirmIPhYRg==
X-CSE-MsgGUID: NbRCJxekR6uZcqkQj8KJhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24967804"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24967804"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:21:28 -0700
X-CSE-ConnectionGUID: QGYorN4IRdGBxti6yYYZJQ==
X-CSE-MsgGUID: imzeAYHDTHODh8WURfGkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67900648"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 22:21:25 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 6/6] perf tests: Add more topdown events regroup tests
Date: Fri, 13 Sep 2024 08:47:12 +0000
Message-Id: <20240913084712.13861-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more test cases to cover all supported topdown events regroup cases.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/stat.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 092a7a2abcf8..85897898a1f4 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -73,9 +73,27 @@ test_topdown_groups() {
     err=1
     return
   fi
-  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | grep -E -q "<not supported>"
+  if perf stat -e 'instructions,topdown-retiring,slots' true 2>&1 | grep -E -q "<not supported>"
   then
-    echo "Topdown event group test [Failed slots not reordered first]"
+    echo "Topdown event group test [Failed slots not reordered first in no-group case]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,topdown-retiring,slots}' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed slots not reordered first in single group case]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,slots},topdown-retiring' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed topdown metrics event not move into slots group]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,slots},{topdown-retiring}' true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed topdown metrics group not merge into slots group]"
     err=1
     return
   fi
-- 
2.40.1

