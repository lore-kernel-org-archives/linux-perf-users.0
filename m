Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57A3B47C3;
	Wed, 11 Mar 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215768; cv=none; b=HKbJ98t1AWNcBQQZ5my912R4k58CgpMvmnsrmCzV78EsV/GOnifSf0KFQlhgMp0dlLQNWGfSKV5gC/HyfHzqUF1rLItTU9aISRlKa8qSIZrX6CYt4f5Hr5Y6XBJL9N6UDmR7SquaTKwbBlfMGfN5JkdrC6fy6+az/K5qavuEd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215768; c=relaxed/simple;
	bh=GusrOGppIaZSoEBz6N8FIyC2At0Cyconu34IEWa9nNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RARG7vaVRlIVvhHYX93Uw5yAA3bSrTQEI+L80tBItsk7jlOBFzquk09DHomCsyzgsb87AkE03u0uMeg9TDrGdT9j+vhUisFPS2VGbDG2StBBECy99PnVT33ozLKlYvvs9Fwao9Sbt3ENKQ9B/TNwvil405GkPzwdHTeIX/dPz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mE3hMPHB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE3hMPHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773215765; x=1804751765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GusrOGppIaZSoEBz6N8FIyC2At0Cyconu34IEWa9nNc=;
  b=mE3hMPHBKmRYFE+XCdqI/9Nux7JQ5YLdJoXRaN4TrAbcIc8u8fKfO2pQ
   nSFfgWue5z/YTzq6G3qcLFPaivKwL3tGMffCq2nYm9TLKdnHjnFhNtCaa
   Gocp+q/aMBRENzw7scR/Rhg6RaosNZHPBa/WvGk3LF1pNIHmJ2/taoKG/
   5EbHpt6Uii6IHntoJqi+tdFLwU/8jzewiQRLHnz4con3ALKybqjaiRUF/
   8MmWiEABgGw/wMPOoDGCctD8R7zapqkO8OxCrAgiLPEdPSvtjkQU90MR+
   mjdli2MUXcS+KxugZxImGkL1yChsaIXoHp9HuZhNE6mAhETjIEuP5nqy3
   w==;
X-CSE-ConnectionGUID: Z1vPePqER+mOM9+zEXHj+w==
X-CSE-MsgGUID: Kp2AmviZToGbcd71XARBNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73298901"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73298901"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:56:04 -0700
X-CSE-ConnectionGUID: qS/bw11YRzqQlWb6BTlGYw==
X-CSE-MsgGUID: kOyYa8YeSE2xWuAVMBAotg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225081261"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 11 Mar 2026 00:56:01 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel: Fix OMR snoop information parsing issues
Date: Wed, 11 Mar 2026 15:52:00 +0800
Message-Id: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When omr_source is 0x2, the omr_snoop (bit[6]) and omr_promoted (bit[7])
fields are combined to represent the snoop information. However, the
omr_promoted field was not left-shifted by 1 bit, resulting in incorrect
snoop information.

Besides, the snoop information parsing is not accurate for some OMR
sources, like the snoop information should be SNOOP_NONE for these memory
access (omr_source >= 7) instead of SNOOP_HIT.

Fix these issues.

Reported-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/all/CAP-5=fW4zLWFw1v38zCzB9-cseNSTTCtup=p2SDxZq7dPayVww@mail.gmail.com/
Fixes: d2bdcde9626c ("perf/x86/intel: Add support for PEBS memory auxiliary info field in DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5027afc97b65..7f0d515c07c5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -345,12 +345,12 @@ static u64 parse_omr_data_source(u8 dse)
 	if (omr.omr_remote)
 		val |= REM;
 
-	val |= omr.omr_hitm ? P(SNOOP, HITM) : P(SNOOP, HIT);
-
 	if (omr.omr_source == 0x2) {
-		u8 snoop = omr.omr_snoop | omr.omr_promoted;
+		u8 snoop = omr.omr_snoop | (omr.omr_promoted << 1);
 
-		if (snoop == 0x0)
+		if (omr.omr_hitm)
+			val |= P(SNOOP, HITM);
+		else if (snoop == 0x0)
 			val |= P(SNOOP, NA);
 		else if (snoop == 0x1)
 			val |= P(SNOOP, MISS);
@@ -359,7 +359,10 @@ static u64 parse_omr_data_source(u8 dse)
 		else if (snoop == 0x3)
 			val |= P(SNOOP, NONE);
 	} else if (omr.omr_source > 0x2 && omr.omr_source < 0x7) {
+		val |= omr.omr_hitm ? P(SNOOP, HITM) : P(SNOOP, HIT);
 		val |= omr.omr_snoop ? P(SNOOPX, FWD) : 0;
+	} else {
+		val |= P(SNOOP, NONE);
 	}
 
 	return val;

base-commit: 73cee0aad1ee2479fde2c9b753a1b66acb7d1b9a
-- 
2.34.1

