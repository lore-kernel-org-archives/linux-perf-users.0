Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD044199FD0;
	Tue,  5 Aug 2025 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354858; cv=none; b=Ztdx1YIIv6bkGwq7pul2y1LFGjRlP9ZzYBFkpFdkfBxinBeUs8mrtFYaWuOkII0Pvk7KuaTiumpLmoslVT6gwBkkBPd0N3qx7DcgomXf31OpR6zZWL1PconmbC2CRN61kbZjx4NqlNMXMN7tfY0evEEo5APFqpBr7KM5zOO/N+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354858; c=relaxed/simple;
	bh=LFNMs8BpbsfIMOfxw5NsEpbTqWjwwtGwi4G+miimsa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JadXd0takdAzbSQaHJqJLzNtz6IJWySmmePreROpuzKGLbjh6y/5DXFpfRVCGWGaN1z6HyAI5pEepggZNIKX5X4cipb0Upmzr1n4ee/GxhePQEmYw8xd/QMO7y6kVbxTH8EAm830sxxWkfKgSrTGVbMbHoWbyo+KRbpkE0unPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdGSBosI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdGSBosI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754354857; x=1785890857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFNMs8BpbsfIMOfxw5NsEpbTqWjwwtGwi4G+miimsa8=;
  b=UdGSBosItWiogvtwtMBqSA8BipV/yz+T4/vPbLi7p0JIy3l46F4HrQoR
   Hom4zYobcDKWCtkIhWYotT5yqmNEMMJyquTSwe0dS6YrxBYSxh7MtNdbU
   PZNYuBpHDggGdwUMxGJOFNOrNzcy7MBxqc08VCMFTKW+VZKra38Ow93sp
   Bp1C1FiEiyXFnUIlFxTV+HrQQ6fQ/VNLfh7pKLfaqWhfUTn0+kPupsJy3
   wyW5W1i8gP51WA8EQAJMvTpXpM9Xd04g2zwyfwYyNFBKqeN7STBd4FRXh
   NhzX7dX+X6BpE6BTiEbzNH3fHDeQpQtdYz9ZzeRhKRlp68PpMMS+nKBWK
   Q==;
X-CSE-ConnectionGUID: eacq8WfXT8i0ref8wTK08Q==
X-CSE-MsgGUID: E1V8ZEbWQN+Alns5YarZYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56523834"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56523834"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:47:37 -0700
X-CSE-ConnectionGUID: Rfzg7QqeQEKaDwD/nG0IDA==
X-CSE-MsgGUID: zgkGw/7vRM2spB53FdrLHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169605451"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa004.fm.intel.com with ESMTP; 04 Aug 2025 17:47:34 -0700
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
	Kevin Tian <kevin.tian@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/5] perf tools kvm: Fix the potential out of range memory access issue
Date: Tue,  5 Aug 2025 08:46:30 +0800
Message-Id: <20250805004633.135904-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_add_default_arch_event() helper may add 2 extra options but it
directly modifies the original argv[] array. This may cause out of range
memory access. Fix this issue.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-kvm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index f78a67a199ff..7e48d2437710 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2002,12 +2002,12 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
-	ret = kvm_add_default_arch_event(&argc, argv);
-	if (ret)
-		return -EINVAL;
-
 	rec_argc = argc + 2;
-	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	/*
+	 * kvm_add_default_arch_event() may add 2 extra options, so
+	 * allocate 2 more pointers in adavance.
+	 */
+	rec_argv = calloc(rec_argc + 2 + 1, sizeof(char *));
 	if (!rec_argv)
 		return -ENOMEM;
 
@@ -2019,6 +2019,10 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i != rec_argc);
 
+	ret = kvm_add_default_arch_event(&i, rec_argv);
+	if (ret)
+		return -EINVAL;
+
 	ret = cmd_record(i, rec_argv);
 	free(rec_argv);
 	return ret;
-- 
2.34.1

