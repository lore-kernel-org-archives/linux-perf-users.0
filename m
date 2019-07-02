From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/43] perf jevents: Use nonlocal include statements in pmu-events.c
Date: Mon,  1 Jul 2019 23:26:16 -0300
Message-ID: <20190702022616.1259-44-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Luke Mujica <lukemujica@google.com>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>, Numfor Mbiziwo-Tiapo <nums@google.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Luke Mujica <lukemujica@google.com>

Change pmu-events.c to not use local include statements. The code that
creates the include statements for pmu-events.c is in jevents.c.

pmu-events.c is a generated file, and for build systems that put
generated files in a separate directory, include statements with local
pathing cannot find non-generated files.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-prgnwmaoo1pv9zz4vnv1bjaj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 58f77fd0f59f..a1184ea64cc6 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -841,7 +841,7 @@ static void create_empty_mapping(const char *output_file)
 		_Exit(1);
 	}
 
-	fprintf(outfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
 	print_mapping_table_prefix(outfp);
 	print_mapping_table_suffix(outfp);
 	fclose(outfp);
@@ -1096,7 +1096,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Include pmu-events.h first */
-	fprintf(eventsfp, "#include \"../../pmu-events/pmu-events.h\"\n");
+	fprintf(eventsfp, "#include \"pmu-events/pmu-events.h\"\n");
 
 	/*
 	 * The mapfile allows multiple CPUids to point to the same JSON file,
-- 
2.20.1
