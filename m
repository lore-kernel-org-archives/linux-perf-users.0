Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E5375F87;
	Wed, 10 Jun 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121178; cv=none; b=Sa4t9YxliT0Rhftm8bgJiJw0/oxlCgoe3r9YNueM8Sjbo5e/fWb0790b+bUI5KTKRYTtIcsmdKzc1N21j3yw20m30jrtl0JdZaimjm8MMy/fUtUc9jM8giQHTvmvnwQnit/aWFAJTKGGGUhqTM1UJttuSiPqQxVKnTWzz3o5wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121178; c=relaxed/simple;
	bh=fwUlUa0BZo2CWmVvKPJ8hmeG5MxCO2Qe09Wng0rifqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb9cSJzRiotYH2odElsgZLE/Gk/bv4tmrdcNVRFdxxMYQYvPO+B1IJmLLqTzTRl7LHO1Q0RBn3TWVLG7Q/zBLYkwPPgAb1Uxwa1nqCniJE40AAZ3I8irY+3bMlC2x7AAwN0WClvnmTHNDClzZVwREx7739Bp3qKf+6Y1gGxlXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJAaAaiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJAaAaiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B621F00893;
	Wed, 10 Jun 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121177;
	bh=Wf8USRQkL1Jyu2XI3HztawLMs9PU5Jt4NkCJx1nFiGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJAaAaiVkrvigpYTEjG3EB1cwIgS0wi9aofjvuF2NSWV+83VAaQy67IHGSjA8v8jy
	 Orvr7CPTeczxwxCrYRDfiobeWIu3W8Q2aOGHYH8wTmWpYvK8s405KwtOJgZDhzl7mv
	 fHbdAGN0mrb+L68y7GXJFSUAfcHCLtbS5PJ3UXECylU+YbuuL66P9laPLaBWqcY8uD
	 AZQ3cBiIpdoHAsjwbzvqAyrEeFCDysPKvf8I6L0/uqSeolz2NrRdYZV0sHlewpjmuA
	 HK4C5kGlINYU4gBpp54ii1CWRp2PoTKW49myjW2JX2A1l9urjwjWQcYPYGmWfARQs0
	 RjRj2BT61QDxQ==
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
Subject: [PATCH 10/23] perf hwmon: Use scnprintf() in hwmon_pmu__for_each_event()
Date: Wed, 10 Jun 2026 16:51:43 -0300
Message-ID: <20260610195157.2091137-11-acme@kernel.org>
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

hwmon_pmu__for_each_event() formats description strings via:

    len = snprintf(desc_buf, sizeof(desc_buf), "%s in unit %s named %s.", ...);
    len += hwmon_pmu__describe_items(hwm, desc_buf + len, sizeof(desc_buf) - len, ...);

If value->label is long enough to cause snprintf() to truncate, it
returns the would-have-been-written count, making len exceed
sizeof(desc_buf).  The subsequent sizeof(desc_buf) - len underflows
to a huge size_t value, disabling bounds checking in
hwmon_pmu__describe_items().

The alias_buf snprintf has the same issue.  Switch both to scnprintf()
which returns actual bytes written.

Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hwmon_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index d895cd74f2a05f9d..fbfb872ceb1826d8 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -514,14 +514,14 @@ int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callb
 		int ret;
 		size_t len;
 
-		len = snprintf(alias_buf, sizeof(alias_buf), "%s%d",
-			       hwmon_type_strs[key.type], key.num);
+		scnprintf(alias_buf, sizeof(alias_buf), "%s%d",
+			  hwmon_type_strs[key.type], key.num);
 		if (!info.name) {
 			info.name = info.alias;
 			info.alias = NULL;
 		}
 
-		len = snprintf(desc_buf, sizeof(desc_buf), "%s in unit %s named %s.",
+		len = scnprintf(desc_buf, sizeof(desc_buf), "%s in unit %s named %s.",
 			hwmon_desc[key.type],
 			pmu->name + 6,
 			value->label ?: info.name);
-- 
2.54.0

