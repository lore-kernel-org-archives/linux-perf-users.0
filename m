Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2C274241;
	Thu, 27 Feb 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693316; cv=none; b=l0PoVnOvZOO/tRkeb8C4K//kRVgIvoE/CEqTNpdn3kK2LHE6Hd4byIexAi5mF9vsYzZvr2+p2rUVBCcxly8Zag/SD2BwyAcGJ7hmt+o5lhRhaYkSEcfj2fA/LIiArBI3Aop3LqbBsNQNbWw7Z925k2RzA3YjtIH44kvFfqCof6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693316; c=relaxed/simple;
	bh=ueGo8XkhznNg4CshYONjwSCM1Qeqz26OnW+FSkMB/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtcoBYBgGWIcgA+0squPaJYAV17IztdTy7iX03gAY/jSW0lFbtduefjm7tO2AenyXvdKFSr/8GmbzPUK22ONkqoYLtTYzy6YJkxmXOGN29xDRn8yx9p3sQFj8t//RCqUg3A98WSqvBv9N+9en5vugVfsDksoTdFXEGRExJ3JlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFAFTc1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFAFTc1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5C5C4CEE4;
	Thu, 27 Feb 2025 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693315;
	bh=ueGo8XkhznNg4CshYONjwSCM1Qeqz26OnW+FSkMB/ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFAFTc1ZZi0Mgw9Vf+nZOR/YFSINbee+O5lugR60mhMGRTGgTOoD02HA5U2CeIp37
	 lul1D4dWxLuJwgqBBbhkyzK3kiqQudtKeLuBNgfsDVRWnvhPWqFwOroiPkPJ01bJAP
	 gPSXl0dcWpytPsKXHbDIUwIIkwx3c35oLT9/agayN+veEQOerUi1rBOrzI1cB586fA
	 MSACm39//ewCH7WVkq3/6QdPKLTeOmbOG7xuygAoa8Vdfj/4Mugaua4EKlfS01o1kx
	 +LWyjl6Q8l76Acn/L8Ehej6ALVjnQaL6SkMwyBX85bWFkdfsVm0zKOiJcpuzXyeIWB
	 TUaD3iQTemIJA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/6] perf machine: Fixup kernel maps ends after adding extra maps
Date: Thu, 27 Feb 2025 18:54:52 -0300
Message-ID: <20250227215455.30514-4-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215455.30514-1-acme@kernel.org>
References: <20250227215455.30514-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

I just noticed it would add extra kernel maps after modules.  I think it
should fixup end address of the kernel maps after adding all maps first.

Fixes: 876e80cf83d10585 ("perf tools: Fixup end address of modules")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/lkml/Z7TvZGjVix2asYWI@x1
Link: https://lore.kernel.org/lkml/Z712hzvv22Ni63f1@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3f1faf94198dbe56..f7df01adad61ceea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1462,8 +1462,6 @@ static int machine__create_modules(struct machine *machine)
 	if (modules__parse(modules, machine, machine__create_module))
 		return -1;
 
-	maps__fixup_end(machine__kernel_maps(machine));
-
 	if (!machine__set_modules_path(machine))
 		return 0;
 
@@ -1557,6 +1555,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		}
 	}
 
+	maps__fixup_end(machine__kernel_maps(machine));
+
 out_put:
 	dso__put(kernel);
 	return ret;
-- 
2.47.0

