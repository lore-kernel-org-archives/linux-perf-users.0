Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CF1A01D0;
	Mon, 24 Jun 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259879; cv=none; b=jSlLP70+Ub8Dz0IzoqhDPpI+plnUdecC7I7NFDxBqp97wDDRMEbgoNkhXtCbvt+G99MHhDQjgVN9mkygRF9YuYwAMBEKYPJXOJiDRk4T3HfRANjiVLNYluFQ5mM/7gl2WO/h68A5qoEyMvVRUpZ8GggpWAJ27HZJl5a20m6TWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259879; c=relaxed/simple;
	bh=TbEKbDJ/ZjUziE9xkUnuTlXoBMKO5tvT0ihWYvPGHnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLNcHcDXwyzLx4Kl9yx5WWauetXa+ej05+D2G+dj2LxfyGunqkuKfQMJj3P7VINAr0MBipXEDBKi8sY2739Gtg3ecSC1Z7X1ldeL56heCozV1ErlCTKJLBeoVBz6X2hS4ppQ9O9x/ETO5paL88Z54ABMo+RV8PQtw4zWvCRbzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOIcq/wC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOIcq/wC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259876; x=1750795876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TbEKbDJ/ZjUziE9xkUnuTlXoBMKO5tvT0ihWYvPGHnQ=;
  b=ZOIcq/wCDuaisMyxoD1M1GfaX+0qkdQRio/CsKB8hHIPCh68WRsh2JQb
   2EyL3e2K5zqdAt0qk4LtP4ghySlivnyL1HRnoYW5Ey05hJQ6dQ2n6zbX/
   qkZjMAaj0cBphpm1kRqW+Xs54Bgor9vZ+W4j3ytcpl8laT3LkkhpI6srj
   L4hP/LrpX3QxJZFPNosIdUPbFm1sh6TCxY5KvMWgU0ck/GMD0/LiNHFcd
   Tt1lf+qgYpKMQ8ZSt/PBW9YpAmF48aVCuccVdCT1EftY8pCSAfduiEpHU
   HtcgceuBQwKd33HdEldVX0JCxauQm2qk0zT7/qB52JrT6s+jRsY+A3+9e
   g==;
X-CSE-ConnectionGUID: d3CjHIZKRxSirjt3U2VxkA==
X-CSE-MsgGUID: I5X0/rUqQlaiHQJG0ARvbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16127983"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16127983"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:16 -0700
X-CSE-ConnectionGUID: /4BSYLjrREGqlQrK6hRjjw==
X-CSE-MsgGUID: G6J1CdrwTFmI3oJiVXmwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387260"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:12 -0700
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
Subject: [PATCH 0/7] perf: Intel PT and 64-bit AUX area size fixes
Date: Mon, 24 Jun 2024 23:10:54 +0300
Message-Id: <20240624201101.60186-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here are some fixes.

I have taken the liberty of re-posting Marco Cavenati's patch from:

	https://lore.kernel.org/lkml/20240618110617.22626-1-cavenati.marco@gmail.com/

with updated commit suggested by Dave Hansen.


Adrian Hunter (6):
      perf/x86/intel/pt: Fix a topa_entry base address calculation
      perf/x86/intel/pt: Fix pt_topa_entry_for_page() address calculation
      perf: Fix perf_aux_size() for greater-than 32-bit size
      perf: Prevent passing zero nr_pages to rb_alloc_aux()
      perf: Fix default aux_watermark calculation
      perf: Make rb_alloc_aux() return an error immediately if nr_pages <= 0

Marco Cavenati (1):
      perf/x86/intel/pt: Fix topa_entry base length

 arch/x86/events/intel/pt.c  | 4 ++--
 arch/x86/events/intel/pt.h  | 4 ++--
 kernel/events/core.c        | 2 ++
 kernel/events/internal.h    | 2 +-
 kernel/events/ring_buffer.c | 7 ++++++-
 5 files changed, 13 insertions(+), 6 deletions(-)


Regards
Adrian
