Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2C20127B;
	Wed,  8 Jan 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354358; cv=none; b=LeiXWZH+Jzae8GbjejmcqQWfkglr3ugxHtzqVZ/zp1RNmhhKcoAm9KKJ3N79a93SQId+O8sJyeLk0WUEp6CUYqN+FcWU19wVLIK/3pBI9tl07mdvxV14TnX+0l/anMYhHpWWHADMW2J4sVh2CCKW+EK1+LTaw3uLK8f1wB3J1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354358; c=relaxed/simple;
	bh=pHHDNO2lVRgEOPV/9MwhlvJnypTONAp5ptF0bxP38iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AlTlyxySj8p6t9NLRtXkP5EeEwDAhm9Hcj6K3ulhDZRsjHaCBFsY3AL+J8BD8dCvpPizFb8GDbzvICBc2MtVK7Q8aOVSkLNuTnuMg+Zxo5q0o4clSInFOvkdSFVSp9l/ZtsgUhI4hpeyocbshIjACha3ktDb93ve6HJhUxD7e/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jcix.top; spf=pass smtp.mailfrom=jcix.top; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jcix.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jcix.top
X-QQ-mid: bizesmtpsz9t1736354322tb4og8b
Received: from jserver0.. ( [111.193.138.203])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Jan 2025 00:38:40 +0800 (CST)
X-QQ-SSF: 00000000000000000000000000000000
From: Jiachen Zhang <me@jcix.top>
To: linux-kernel@vger.kernel.org
Cc: Jiachen Zhang <me@jcix.top>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf: Fix a wrong help message
Date: Thu,  9 Jan 2025 00:36:57 +0800
Message-Id: <20250108163658.1793072-1-me@jcix.top>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:jcix.top:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NOOb8KFV1wSYyrERW3khw+cMVBDLHFD//Np2s6y4OO/MAoRuCJ9R9JTg
	EUyJnN4vdr30MJmMRXsbTNnxKJkGU8WjgUhicfy4GYgeAbbt66NOW3n84f+iPqZt96mMiZc
	AnMvSQkk7dNjI5XzG8g8SNoHWL98Ktf8sJ+vyyEVyhrM+5693l55ML05pi6JV7911qKGqNP
	JPgHAiPK4kfzPTR0uc8XqvikpMLsTY9t3YwPiP9/6bZ7TcO2brlCCkEeu+Gg4o0fSCvfsxY
	E1eJr2UFPSVIpOAKjnD2LTHntujXhLhaRLEKaPh64FLn685uz0bc1zNjnqyfjwltaGowiVN
	tNpx3CyuWe7XMGr+rd9A0aZcGYQCYepQZBvv2zre/Z5EuW3M0XfMNnpk4zXWhbhngAmWfYl
	g4nsqCqwBDhXzR+0T2X9wXQKmWAW7bg+EXPBGS6ZUx+I40tbM/KkPt/c5iCdMoWiRMbw0Kq
	/SMvqvUwa7PeZ+UyoLGkfs/iZt1AKlK7pWmFgsxs/1pInmWqWPI9BEvRcgJu++OFoP7pzky
	W5Cyw4OvAfeaYdvf94P5R0LjacgdpWWsf4SVy/zD1RCfyDFEBjOFQjpbYGe9nnA/NVloFhY
	NmG3WZVvupmm+0qnUX+hyTv8E8aGCqZ6RY0nhGZAbH20t/sY55lfFK4gEQnXKGHOoFyw2d9
	ClQmixK2N2b4gQIvrSpELIbseb9+/wkFqCTZ5i8JV7bPbTWV4doLuH0Gccu5eFO42sm/ERN
	HSuyk5qiU8RR3tXam2+1DyUekcdYwjtbAQvT6KuI7CCQBM9zIC06liwsVLWGzqjlJJCfAem
	A27tpjnWLF7bX2gDi0Pg7v9PNOduUJWMa/k3MmLU6GHMSSS5I3JkRvBVmvgHsZq9oymQTN0
	H0/gIp/Fx++LbzcI06+bau8jfVJhVr2lhHmjHTnBNUR8neW6R/H+ShtyjvbZae3+hGbKvOZ
	EUbc+LZbUJeXApnymr/d3nnAPtv+M9MeI3yLaiEBiESwk8gur94VFx5O0
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

The wrong help message may mislead users. This commit fixes it.

Fixes: 328ccdace885 ("perf report: Add --no-demangle option")
Signed-off-by: Jiachen Zhang <me@jcix.top>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 048c91960ba9..a286d156510a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1422,7 +1422,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
 		   "addr2line binary to use for line numbers"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
-		    "Disable symbol demangling"),
+		    "Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
 	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
-- 
2.34.1

