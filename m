Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D23750D6;
	Wed, 10 Jun 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121199; cv=none; b=c60u27VuOb0WoFK49KAaSmQALyvDkc+6YaPfqtu9Cwl3MljCQbmZXciABEM6siECZgmuhFbMEeMGsRF1Ulmq9UkZS4SFeIVDaWlW9kF9GyZ1BhugU74LF5dd0Ac06hGmzerrJDdRIRNfoufoOFbdPRYBk5U0f+yReAjQf3uff5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121199; c=relaxed/simple;
	bh=VuUv56tfc8o3tvHTP3XsvseeHvFF87RmN7cfjS6xjiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOD1YOXA7BuztPYM81q1jGagBqR61sqHDrqUQMIrJA/ADs8DMpGv+e0a2rR9f1BPeMfLS6u2Ac7MUm1sBCuXaYSQNPHoCUVj05ap1zym8YOAsq9kYpbrTLDihPKrEoJDnI/Edm1jayiQ36awvv+Ffe2wznGjZ/nSDE1ZGmkmbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Z2Iimj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6Z2Iimj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BC11F00899;
	Wed, 10 Jun 2026 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121198;
	bh=TPI4lcTF/Ad7mcGqGqraHw+fFAKGwPr0XI1FGHfajLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6Z2IimjOvw3vBdHBiJ7T+HQZVQHDHa97arSOmR3d4lMhbn2xINEV60QhmGoQYgns
	 /gS7jBjFDg0G43SDY1MgcGE9qL3UaQzFAQF7VbxZFuuWiimWJSGvFFAj4LjCYzyW9I
	 Aqf/YDYp/OZN1119fk2CHVczpp+FWALV2LRuPvHP5N2/V6x9zw+2V0BRCepIOW8UA5
	 7LKyHd9DlmECPHYsMwSh2AbYXzP+fnee+5z8DlSDDzL265N3lzR5gsjaW4PQGSB/Ex
	 qFaBFGQNJkq37Ll+tDn9Z7ffZWTxtgooTkOMvS62A/sMYNsixCqqb6DadOWqsnAFap
	 Vwg4emlpH3MXQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 14/23] perf hwmon: Guard label read against empty or failed reads
Date: Wed, 10 Jun 2026 16:51:47 -0300
Message-ID: <20260610195157.2091137-15-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hwmon_pmu__read_events() reads label files with read() into a stack
buffer, strips trailing newlines, then checks buf[0] == '\0'.  When
read() returns 0 (empty file) or -1 (error), the buffer is never
written, so buf[0] reads uninitialized stack memory.  If the garbage
byte is non-zero, the code falls through to strdup(buf) which copies
arbitrary stack data as the label string.

Fix by checking read_len <= 0 before accessing buf contents, closing
the fd and skipping the entry.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hwmon_pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index bdcbe887579a1f08..efd3067a2e591050 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -295,8 +295,11 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 			while (read_len > 0 && buf[read_len - 1] == '\n')
 				read_len--;
 
-			if (read_len > 0)
-				buf[read_len] = '\0';
+			if (read_len <= 0) {
+				close(fd);
+				continue;
+			}
+			buf[read_len] = '\0';
 
 			if (buf[0] == '\0') {
 				pr_debug("hwmon_pmu: empty label file %s %s\n",
-- 
2.54.0

