Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2B2080CC;
	Mon,  7 Apr 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043013; cv=none; b=o+B8a9rDL7H29QZC/I2CMiaMdbO5vQFbqpWViTbJJ3RAdqimLrzU6tbzvdX/gvirXFURCDXPItZvjLuzzNW95Ib3ijQDDHwYgmEWBL31giWjDyQ1gWUCyiFUmLVhPgbdZgs0q5EqvO/dqR6sIaqp9dxy5L7Qn8vVvgwoUXRrKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043013; c=relaxed/simple;
	bh=WBiJvbGqxCNb6hayQAL6CBPwsQpt9SuDs5jNLubjhtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/J6GYHmZ0aGov/fyRlP1eOKsZhlWajmf4fewqSoaN0CQa41IU/3iYB+gRtad3PcixnOgJv65X+N0aKpzFLTxIxhewd5lgTJO76DtGCH3/YhyXy8+aLqfcopFsETZFHi5+wmwAt8HY4ZlHpIF9bXp27y8q1dZu/9kTT+A3xK/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw47LBix; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw47LBix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744043011; x=1775579011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WBiJvbGqxCNb6hayQAL6CBPwsQpt9SuDs5jNLubjhtU=;
  b=Iw47LBixcsQf757DKwug2CpF9KrEwV5u99oPfiTvsM7rblCq8wH2YdIR
   3NgsSpx+6byy5e635wHyNoeAdudSJir2DIt252uP/5Gp8ELC4E5opmEZm
   /HjJyyzet0K7NGRbHH5SVAUtvFX7n23WdG+fSg/8mAwGp5QIYYmjp5e/y
   R1cUd1Gyc1RE091JyeWCFOdfhbsJLsTHZ3xs/fXt0TyvaBMQdCQGkyDKb
   1zU7p5egH24ArqdLBsX1F0i6jQhb1VxtHEv8sgH58VfNZNR4n7Fxe2/Aj
   wPHmPxXyPwAD8Yfa8ujyR9qAmjSOfRqvI1Z6TgLvk+33me00tALahJl9G
   g==;
X-CSE-ConnectionGUID: aWZPktNPQdCUtVkL5zKihQ==
X-CSE-MsgGUID: m22pR+joRdaKQi4AO4eUxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44687167"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="44687167"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:23:31 -0700
X-CSE-ConnectionGUID: lCnb+lksRCeOm4kXMZonJQ==
X-CSE-MsgGUID: HoFbWlYlSVWdPOMq/8Hedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127761629"
Received: from johunt-mobl9.ger.corp.intel.com (HELO localhost) ([10.124.223.249])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:23:28 -0700
From: "James O. D. Hunt" <james.o.hunt@intel.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	"James O . D . Hunt" <james.o.hunt@intel.com>
Subject: [PATCH] perf: Fix JSON output crash with intel_pt// samples
Date: Mon,  7 Apr 2025 17:22:11 +0100
Message-ID: <20250407162211.172951-1-james.o.hunt@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current behaviour:

```bash
$ perf record -e intel_pt// true
$ perf data convert --to-json /tmp/perf.json
Segmentation fault (core dumped)
```

With fix applied:

```bash
$ perf record -e intel_pt// true
$ perf data convert --to-json /tmp/perf.json
$ jq < /tmp/perf.json &>/dev/null && echo ok
ok
```

The crash actually occurs in `intel_pt_process_auxtrace_info()` where
`session->itrace_synth_opts->set` is unconditionally dereferenced. This
platform-specific code could be changed to fix the issue, but this patch
fixes the problem generally.

Fixes: f6986c95af84ff2a76847910b4322f542b793bbf ("perf session: Add instruction tracing options")
Signed-off-by: James O. D. Hunt <james.o.hunt@intel.com>
---
 tools/perf/util/data-convert-json.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index d9f805bf6fb0..b0aaa23659a0 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -326,6 +326,10 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 		.force = opts->force,
 	};
 
+	struct itrace_synth_opts itrace_synth_opts = {
+		.set = 0,
+	};
+
 	perf_tool__init(&c.tool, /*ordered_events=*/true);
 	c.tool.sample         = process_sample_event;
 	c.tool.mmap           = perf_event__process_mmap;
@@ -377,6 +381,8 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 		goto err_fclose;
 	}
 
+	session->itrace_synth_opts = &itrace_synth_opts;
+
 	if (symbol__init(&session->header.env) < 0) {
 		fprintf(stderr, "Symbol init error!\n");
 		goto err_session_delete;
-- 
2.49.0

