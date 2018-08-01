From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/21] perf list: Unify metric group description format with PMU event description
Date: Wed,  1 Aug 2018 18:36:44 -0300
Message-ID: <20180801213648.4814-18-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

PMU event descriptions use 7 spaces + '[' or 8 spaces as indentation.
Metric groups used a tab + '['. This patch unifies it to the way PMU
event descriptions are indented.

BEFORE:

  $ perf list
  [...]
  Metric Groups:

  DSB:
    DSB_Coverage
	  [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  [...]

AFTER:

  $ perf list
  [...]
  Metric Groups:

  DSB:
    DSB_Coverage
         [Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)]
  [...]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
LPU-Reference: 771439042.22924766.1532986504631.JavaMail.zimbra@redhat.com
Link: https://lkml.kernel.org/n/tip-mlo850517m6u1rbjndvd1bwr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 96eab4ec34ff..a28f9b5cc4ff 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -326,8 +326,8 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 				if (raw)
 					s = (char *)pe->metric_name;
 				else {
-					if (asprintf(&s, "%s\n\t[%s]",
-						     pe->metric_name, pe->desc) < 0)
+					if (asprintf(&s, "%s\n%*s%s]",
+						     pe->metric_name, 8, "[", pe->desc) < 0)
 						return;
 				}
 
-- 
2.14.4
