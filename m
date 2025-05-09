Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6825F972;
	Fri,  9 May 2025 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826220; cv=none; b=G1boOfBIEhViryduWYMoxjuo60e4sBW0yUZWKNq73mtVlGdiFUDirftCuV94AE5YCR7lRavgesQ4RweY9p27ofBXwtd0y8/x4HLGRG4u4/qW6qsni1ZHsNM97/K8601mx/iqRRRCDRXdk7amaUpOQl5kpG/rcVK15riLthRzMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826220; c=relaxed/simple;
	bh=k7aoIsLV3BF4vRFYtw+AgV3VQ/BY3u9sOY7ixkiXnOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZs2SypY9sBewH1D8jgkT7ZjZYoppP2Yo5Hoo9Syvr0fn5MsSBQNyA4O+uVvNi5WXy1K5MXdBwF/bvtTjJU8yHA2cbl2LFgVDFYm5FbVhmWlJoI5MHchjCX4DcqyacciPcNygRmjDWHPTVYqDLwpONuNYckBzsH6rwkPtkvG3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ/DC7Id; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ/DC7Id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048C9C4CEF3;
	Fri,  9 May 2025 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746826219;
	bh=k7aoIsLV3BF4vRFYtw+AgV3VQ/BY3u9sOY7ixkiXnOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQ/DC7IdyA2WFYBUvpZLFhIiHZRI/Q6n2zuL3DkODWN7oTcSPnJu16QyjaDfzTomY
	 NVbM+kkHYng9urUQWhjfUoCQARBNBqLjhVivc0Nl2STmbWKf7V65x64MjBc9O321m3
	 1XZnDxJlimepu+ABkwxhmZkqEGYOwuhv2q4eYVHX0wG7tvYw2kg8ScX4+n+JHENMr7
	 AVvsxl7Kd4HBC1f8pt1aqTWufq21vGT70jqCVBQS7tjSmUI7pGyMzX8o4ZQ2GAsaEi
	 euoovJ/44Dl6la4rqMWWqOLhRAQ+wtRZvS5AlnTen73m6K+vIyoEvOBqmv2ER66AVx
	 4aFUWdKSXAE1A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf test: Update sysfs path for core PMU caps
Date: Fri,  9 May 2025 14:30:17 -0700
Message-ID: <20250509213017.204343-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
In-Reply-To: <20250509213017.204343-1-namhyung@kernel.org>
References: <20250509213017.204343-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While cpu is a system device, it'd be better to use a path for
event_source devices when it checks PMU capability.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_lbr.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index afad02d0180e023c..6fcb5e52b9b4fcf6 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -4,7 +4,8 @@
 
 set -e
 
-if [ ! -f /sys/devices/cpu/caps/branches ] && [ ! -f /sys/devices/cpu_core/caps/branches ]
+if [ ! -f /sys/bus/event_source/devices/cpu/caps/branches ] &&
+   [ ! -f /sys/bus/event_source/devices/cpu_core/caps/branches ]
 then
   echo "Skip: only x86 CPUs support LBR"
   exit 2
-- 
2.49.0.1015.ga840276032-goog

