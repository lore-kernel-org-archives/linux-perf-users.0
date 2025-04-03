Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEF74E09;
	Thu,  3 Apr 2025 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644709; cv=none; b=eodkXz6PvPsMx6Crq9KNiRmtTato/TTrMWEDLB72jWcENgJJFYQs/LSSaXBeDt4H/Ws7Z7u6O596mkHkvvuXbV12njJb3l1zVowHqmmuBfwDtsdGJphAFyQdzgkKJTQdvev38oUpdmGvZ44Nd76cNr6Duws8QS93JCLwSMewYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644709; c=relaxed/simple;
	bh=su+mNSMtgXzI+Fmgk4ZUci9vLOX4EVeLf1sbpfbqXb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYg0Ax+drZ3k9Uo8YBVB1qMcZiGLBLt/FYksehPMxdtcJhKQQ+yz9zWWH3jRee6vHbNeoaN4N5qKEGDgiSivp8zf8p+78iuivAuCMBfcTD2Azk9TgmY8LK96lBBU8aJhFSpEVUDDLhbUovN7xysGbby8dyVGBqMivjVDXmU55TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVFf6ifu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVFf6ifu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743644708; x=1775180708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=su+mNSMtgXzI+Fmgk4ZUci9vLOX4EVeLf1sbpfbqXb4=;
  b=RVFf6ifu7VUtXzoq4URCsWQSruDWBWlNcEGyDLCFNnhXKZmzs46gNwBn
   GdUifVvVg+RORtyrh2oGiCIDkZx6cbQvchizIoS/b9jR1aSzu1lpUMWxN
   EULNAu3tDtKYml69VCuMk1gvMNfFbC4kXSjh711imWFvpUcCafl2c+WKt
   Yf8PxMy26JW8XRg0DIABlbS1cIrvFnbc3uE11e2dPwBncHUfTUOtxwBlT
   pfkmYV4VxREgMN2/ZZ2S/DcyjFK2eV/q+7C+w8mPFOiPZpqK49UxbF5nI
   m4JtvfPb+6KhFPksvPitptYb0BzNpOADXGhCeUaO+OBlNMmJ+2eNtqwM4
   Q==;
X-CSE-ConnectionGUID: +ufhPB0ZQaGkHG+/UHJX0A==
X-CSE-MsgGUID: wQBSLWSVQwOAQQwX4y+CSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="32641385"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="32641385"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 18:45:07 -0700
X-CSE-ConnectionGUID: ATZV+vayRk+lTcbrbo1i8w==
X-CSE-MsgGUID: NK2q+WKLSrOpTboRPZ4hGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="157858370"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa001.fm.intel.com with ESMTP; 02 Apr 2025 18:45:04 -0700
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2] perf tools: Fix incorrect --user-regs comments
Date: Thu,  3 Apr 2025 06:08:10 +0000
Message-Id: <20250403060810.196028-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment of "--user-regs" option is not correct, fix it.

"on interrupt," -> "in user space,"

Fixes: 84c417422798 ("perf record: Support direct --user-regs arguments")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..d56273a0e241 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3480,7 +3480,7 @@ static struct option __record_options[] = {
 		    "sample selected machine registers on interrupt,"
 		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
-		    "sample selected machine registers on interrupt,"
+		    "sample selected machine registers in user space,"
 		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),

base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
-- 
2.40.1

