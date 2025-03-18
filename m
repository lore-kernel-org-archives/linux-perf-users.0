Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD04189F57;
	Tue, 18 Mar 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337662; cv=none; b=BqNZxIl7Wou0DxMIa7OwrElycB7x7ndTquZ5D+70Uf69KcSlK7RP5NcIMt2AcsifXve1u870IBx2Ok8Pj2XYin15Ml5xM6q/zknt3KHRCE7DF2eW3ks8gcTobDBmnj6kiRKn6bDDAhoo4Cjtia7nyVVr5CzKoUlEMBCo8K16jBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337662; c=relaxed/simple;
	bh=trHfhfucaH10fQOscDcdHxOaR8cjVs9diP3AaaGq+mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrYVYoNUvYMHrnE2ugAtbfO+VJOYEzpdlGL838oE67NnlsGnJlmwJed6Do+sns+wAmmsu7SxAHI1eB5SNXCiN0gtDSg0P0u/gXhWwGjXzmuoz9qPAfZAqQnCZ1qVDQ44N6KFOeR1juDeE9eh5s6L3Ot3CJN7yRnqM0s+CaaGDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWe4zeyK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWe4zeyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742337661; x=1773873661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=trHfhfucaH10fQOscDcdHxOaR8cjVs9diP3AaaGq+mg=;
  b=NWe4zeyK+CuQozung+TyJ8AkcA4A7aVk/1fCJ7aXPCzFIvYT++tA2rAi
   geirj3bNXVTjDrVgQqmCyYfeXoybMJr0FCWdoT7lxMQcyBe0Jr6IzuZI7
   URrcFJ617GLRLQhtzDibhO4ehzJ4QqjN0CnE9YE1xa5drOQo6ng8jw9A9
   LBAW8Z6MuH5zHQut+sAztFzMPwvnCNUXm+A2SpQKoc5krJ/WP0jgYCl4K
   LBRbV2Mgh3gXcSGHGwsT8hFPzc5a3D724P8CkEf2mBVS1Nu0X1KOJLyXa
   ZVB7Ue4KR9uDgi4Et+E3bwpKZ+ApF4H0DD+s2m8PH7LmtBkIW25hPv3Ax
   A==;
X-CSE-ConnectionGUID: XzZjUArlSeaK4H3tBqPI0Q==
X-CSE-MsgGUID: 8Ph6KUmBTWOC4gpeXQ8t6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68860944"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="68860944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:41:00 -0700
X-CSE-ConnectionGUID: d3QHm6IISf2of9K1TmXzDA==
X-CSE-MsgGUID: uE/B449bQaOzE0Ym/uMASg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127069849"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 18 Mar 2025 15:40:59 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] x86: Prepare for new Intel Family numbers
Date: Tue, 18 Mar 2025 22:38:26 +0000
Message-ID: <20250318223828.2945651-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---Summary---
Mainstream Intel processors have been using Family 6 for a couple of decades.
This series is an audit of all the arch/x86 Intel Family-model checks to get
ready for the upcoming Family 18 and 19 models. It also converts one of the
last remaining Intel-specific x86_model checks to VFM ones.

Most of the patches were picked up from the v3 series and applied to tip.
This series contains the remaining perf/x86 patches rebased on tip:x86/cpu.

---v4 changes---
* Addressed comments from Kan Liang.
* Picked up Kan Liang's review tags.
* Rebased on top of tip:x86/cpu.

---Previous versions---
Refer to the v2 cover letter for more background.

v3: https://lore.kernel.org/lkml/20250219184133.816753-1-sohil.mehta@intel.com/
v2: https://lore.kernel.org/lkml/20250211194407.2577252-1-sohil.mehta@intel.com/
RFC-v1: https://lore.kernel.org/lkml/20241220213711.1892696-1-sohil.mehta@intel.com/

Sohil Mehta (2):
  perf/x86: Simplify Intel PMU initialization
  perf/x86/p4: Replace Pentium 4 model checks with VFM ones

 arch/x86/events/intel/core.c        | 14 ++++++++++----
 arch/x86/events/intel/p4.c          |  7 ++++---
 arch/x86/events/intel/p6.c          | 26 +++-----------------------
 arch/x86/include/asm/intel-family.h |  1 +
 4 files changed, 18 insertions(+), 30 deletions(-)


base-commit: 08d9bb5b0d89826fedc5204c8bd2463220465996
-- 
2.43.0

