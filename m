Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB551A254B;
	Mon, 24 Jun 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259900; cv=none; b=g6v1MXEdQW3DkL5WjtJ0Nu3U0PNJZw9dnPJLSl31aSzmhC2De0eS4yBizA5b8kL4f/qSlTWz9kSlIqJjG7EjYRb2794ioRJT43iS2xuzHgtY5MpcYdjYXYvcsdiatcrhzNVxnW84dXNgl9un0bxH0mSUgKF7O0X40jt/yKvZHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259900; c=relaxed/simple;
	bh=5tyGEzcLM213Aoq8ZAQ5zeDTSSEdl1hZQJ3Ev38A+Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7oR/jhXDADgcC5sr5C9ATZRH+5YAw9fyF9pfTcbEdp2p3ySkycaUO4y251utKlonhswxr2ADYmHKqEaeTGMpkKf+ZjTOiTbc3fj4MeBzfbxzfMRFy6kTUYj8cS1LBwxGAM1nCVxpbi/2mSnFeav8z22t/5TjjTvkVDnOfa+QHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7x8XUU6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7x8XUU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259899; x=1750795899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tyGEzcLM213Aoq8ZAQ5zeDTSSEdl1hZQJ3Ev38A+Co=;
  b=D7x8XUU67sVOSF47PmV/7jMPhq0F+0AqLB3f2vYqdeKS+wu5slzooJbi
   4POSexnMjmkK2MgdCrD5ucAfCikPliB5/tOYpYbiiS/S8Agk5GMg0YLWV
   vEN+WDs9auTYNuQRwJlLAJF99cTWGUk0pvXyZp+cUj9RpY6B9DpzDyt5k
   4QNEN12mos5OvBb1yWpl03ef4fOtF2lK43g8ymEETC6XBUD1Z1oQ8RnLh
   +f2mYarq91TcdaAX49oCXB7SN3Ybi4DPBhzXnm+wAAi9BjWjCmBthzZ/H
   9qgqrczkuFjGxw54PbbJsgN44QGaml17muyEHb9jiRvRTUAlrwekpnLbN
   Q==;
X-CSE-ConnectionGUID: Rwz59dyCR2KRpWBvVHSkww==
X-CSE-MsgGUID: 1lPV6rnsRjuK5ILI17I2DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16128058"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16128058"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:38 -0700
X-CSE-ConnectionGUID: EoPfsTZjTAyX3VU4/zb8yA==
X-CSE-MsgGUID: rMnlrkeeTAaeds2ZvWekJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387309"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:35 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Marco Cavenati <cavenati.marco@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 5/7] perf: Prevent passing zero nr_pages to rb_alloc_aux()
Date: Mon, 24 Jun 2024 23:10:59 +0300
Message-Id: <20240624201101.60186-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624201101.60186-1-adrian.hunter@intel.com>
References: <20240624201101.60186-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

nr_pages is unsigned long but gets passed to rb_alloc_aux() as an int,
and is stored as an int.

Only power-of-2 values are accepted, so if nr_pages is a 64_bit value, it
will be passed to rb_alloc_aux() as zero.

That is not ideal because:
 1. the value is incorrect
 2. rb_alloc_aux() is at risk of misbehaving, although it manages to
 return -ENOMEM in that case, it is a result of passing zero to get_order()
 even though the get_order() result is documented to be undefined in that
 case.

Fix by simply validating the maximum supported value in the first place.
Use -ENOMEM error code for consistency with the current error code that
is returned in that case.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..053e546d5bf0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6509,6 +6509,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		nr_pages = vma_size / PAGE_SIZE;
+		if (nr_pages > INT_MAX)
+			return -ENOMEM;
 
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
-- 
2.34.1

