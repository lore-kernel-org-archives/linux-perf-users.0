Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE71A01B7;
	Mon, 24 Jun 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259909; cv=none; b=E7UwD///0M2Yz+f5YTHduKkiE0DXIrjlS6vqCfX86ABG0q4eMU3o+faUUm0lVyU6H89AfzMKuv6dliNqGzsUJTXm+CoetPexKSzt5G9VCzCXwp5PPkwL/S2AfHKze8Z4ZIngGU+dXu3qERJ2wph1W9bZ3gIlf2vZAJqXhQ+LOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259909; c=relaxed/simple;
	bh=lJDQr7DiyooZZK3jhe+NAZGuFKB0C3r+uajJJtqP2HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KitAKY+BROp5Ov4pSe+7fUvJW5jRe1iXlvhOJkvZYG/+xeMyCatLJ1TAFkwYWR62xc0OfxZyX81UZhIdo+SyGn5eZaVdo/pgO/nYqeKkZD7uRbVGwB2v3xTYTvaGaocgBLm/zOgYMdaFFtIDTPzsG2P4yEXERbi1jLisMBL+Mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URKDGUdB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URKDGUdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259908; x=1750795908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJDQr7DiyooZZK3jhe+NAZGuFKB0C3r+uajJJtqP2HY=;
  b=URKDGUdBWaupBgZ8dGEOnjlY5nwoKYLwcNzRX3VKK4bHTzJE4jTx4vJf
   UXjmuIPxH859G5sDsAfvjT4vW7I2iyaMD6qqN5M5RPUusRsySDXH1gSPY
   HqLSIaLVkhP2go4+KdQKMefcsfoTqN0tDhtTQzeeixZT/wXhyOHKuidlt
   NGyB8r6XAbWYNfWR+/RTG6lha8mzNSqMo4RfBgRETKNrJU49jJVT0v8JS
   lznSPHZCO5Vhr3VTUtvk5yqBpzmrYmUub5sDrpwWwi3ZlVrzrEFjNcgvs
   2+aN726SzuVNUxRyEK65BwbqkwhhPrCKpZqnuigPNqjK29s0KSvfmxUrW
   w==;
X-CSE-ConnectionGUID: FZ7Q4v4NQFWompmGH4j0ww==
X-CSE-MsgGUID: SYu5IC2LQguwlPeSrGcGJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16128089"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16128089"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:48 -0700
X-CSE-ConnectionGUID: +qSVkSmQQa+YbMfpKd+zLw==
X-CSE-MsgGUID: hZd7Lo62Tc25d5InSdJzwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387331"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:44 -0700
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
Subject: [PATCH 7/7] perf: Make rb_alloc_aux() return an error immediately if nr_pages <= 0
Date: Mon, 24 Jun 2024 23:11:01 +0300
Message-Id: <20240624201101.60186-8-adrian.hunter@intel.com>
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

rb_alloc_aux() should not be called with nr_pages <= 0. Make it more robust
and readable by returning an error immediately in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 485cf0a66631..8cadf97bc290 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -682,6 +682,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
+	if (nr_pages <= 0)
+		return -EINVAL;
+
 	if (!overwrite) {
 		/*
 		 * Watermark defaults to half the buffer, and so does the
-- 
2.34.1

