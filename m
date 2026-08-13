Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC53E49FD
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657314; cv=none; b=qI7wNF4y4TSQxNSvyG+EjHrocJOzSsIF7gZrDXtdnDtmvZCaGCrC48HGes8lmooIu4E/jtiXX7lxcFTUqJUS96d8B1D1/J/1VCGkWX7q0Z2FN/Vurwq+pnGzCUiOUMTg2X2sIgaKV4g7IQxdK65skNkEBGcxD5mPf1Vz/+UsKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657314; c=relaxed/simple;
	bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXX0v0GYXHRz4obtzdQgBW8oCmciVlW1admamL5ud4DGHOFiG6MeQjHyijCC10RqAvzoTtmIvzG7U/SPbJ+phijt4mZo2K5rK1MKeYcsKpnqXfMScF6EWxBqexE2Z8uR7pLvyur2S4fkkVLblZYKJJMyQZejFeiFrAfoWfWXMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpiyW0HS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpiyW0HS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786657312; x=1818193312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fEgXKovIZOW4WfqZh+snAL8qnNOxXFUCVlAbVCbteOk=;
  b=QpiyW0HSuTV54JCcfH0MaG4LJMm6ZbvosViSIV0WLaQvb4zdcC7/9bZB
   3P1lfJqg7D4/Lxj8Bj2kHBDSOgRq3DvVl9XVb8m/HOQoV4qvJInKQMB7a
   e03jwDFvSM8+5dFMcRUzP3sAY31RXNjbA/UL6UvFacczkbW+3Wjmcn+sB
   KFei1EO2Sps0AhVIhPmlVrp/VVzwRS7AIUdCo47K0zDq7wi5syyRXS5bx
   OL1RbaKvdOlWPj+rko5irrdwvWDvEOCE0QdokDsK7PWP+wc9i/hu386+C
   oxE11r41/eXPqHryfT/wV8wPWqvNRXbKPQyJRnWMgqBEh+xTBIIkuR53W
   w==;
X-CSE-ConnectionGUID: I3ZlKen8TEaZaXBkDgH0jw==
X-CSE-MsgGUID: 4inRBj9JR8WyKQY+6glFhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89761871"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89761871"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:49 -0700
X-CSE-ConnectionGUID: 4k4BB5LHQIylgVrEMzHuYw==
X-CSE-MsgGUID: HSTLZj4+RdmXsDDoxjb6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267909909"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 1/4] perf tools record: Modernize -W man page
Date: Thu, 13 Aug 2026 14:40:56 -0700
Message-ID: <20260813214143.253418-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813214143.253418-1-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modernize the -W / --weight description in the manpage to cover more
cases that are supported now.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 178f483140ed..2c6510c5a87b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -480,9 +480,11 @@ Note that this feature may not be available on all processors.
 
 -W::
 --weight::
-Enable weightened sampling. An additional weight is recorded per sample and can be
-displayed with the weight and local_weight sort keys.  This currently works for TSX
-abort events and some memory events in precise mode on modern Intel CPUs.
+Enable weighted sampling. One or more additional weights can be recorded per sample
+and can be displayed with the weight, weight2, weight3 and local_weight sort keys.
+Possible uses for weights are memory or instruction retirement latencies.
+Support depends on the PMU and the event, as well as its configuration. Typically
+it requires use of 'p'.
 
 --namespaces::
 Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
-- 
2.55.0

