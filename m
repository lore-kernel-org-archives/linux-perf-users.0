Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604293;
	b=f3HgSDkuosdtVVKJHaY1MhhJ4vL+bZFw/F52fNvtKsszk+kwEducvhNQgOfX31w7QIWP
	 OqB/jVXD0cl7jMa1+MI6SuuvZlPmeFr24UJxHy+9zL3nJl+8cCK56lotvSPzMyynlOPiU
	 YdtBQMnjM9qrXfTglmj0HCgLyUTJu4WpvOb2jIUSrxGNS6c0PV7NL5LvsO/Y1YLc3fU7f
	 jLqJKG0Bsj7Lqi/Yb6Q54ucbadctwgOqHRSJ45Ub1fyJ0oiujVAbdE9wiyR4QCsJfPZa+
	 qBQqdfIX1z4oOYCb6buDHOUP5U19jwlqYkgdwS0n/MrWg3SvA8FH8QWdMN3JxzpsjVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=csIZWQbfmfXCf+hoR4Bc71Ry0e4Z7c4/ohP5tccwi/8=;
	b=i11dq1Z/yOrgN9NRjqYKypQLa8Fnag5vYNa148dPLZi2pewnKq2eU41hDklAMizQmNCT
	 pWGFPFI/JyF9fGsVC6vIR+7f+H88xpgjlMn2/27RGho2mM1a6uk/Q9Lv1137CvzzBmekR
	 qwFRZW2H0/RWr+xpYaDbYUBt7WTQ/crSO2+f2UnjMw7KK/uyaHBu1fACZlKJDg8uXmOOJ
	 SwmRbfdrEdzIoZT3Uxork+3Ue2mSe8yldvNBJPE8j+Xqj1YsUZwzzsr8VXtHqHUwdkjBN
	 kDCqECTrXzLjbGWZrY126P1y9y0eL7Ziz/cvhfucjkPeMjyfblW2otMYGnSZYLhWUpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hgt6ZNSa;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFD60A262E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAFD60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hgt6ZNSa
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36d1353fdcdso6124194eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604291; x=1795209091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=csIZWQbfmfXCf+hoR4Bc71Ry0e4Z7c4/ohP5tccwi/8=;
        b=Hgt6ZNSagPUdtAIPj/aS+nKkrfPsseXNR9W7WEUVr7v/lKU7g7+7AKUfF4e3g4wWKj
         WUfgTGLs57wHBr8htMIA0HCb5yXoGP7MXJ1o1/dZdin99uRzgnVjHrXcXULPqFeIT2hN
         HwluUc+4klbpgCzn6Jv8zNCgsJvFDlvRsJFjoLObxIB2tjDVnYOk2DCyMi92rEpL+GZr
         Db/jiAZRNRv7TgBWHfzJA76jFguAiH0pQ6v8dAyv7xx6N9MAmK2eHrNi00bo39HG9qUs
         PyBplH+Bfvu+HNetjta4lglf+B8xBceZtZW2WHJb/XfMCdLEFbQiFTqH+W5FzrwXx8o/
         RNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604291; x=1795209091;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csIZWQbfmfXCf+hoR4Bc71Ry0e4Z7c4/ohP5tccwi/8=;
        b=mKozjx31AFPoSteM2qfUlO9ZBMxU4uD2CYOLluouk4bn2rPtHh4E+rlIsXHJ2I/9Av
         RwkpRX8jw46kn+REaiR4uVUsBHUZh1BHPVzJ/Oph8xsUP4U0u43uf5q3e3zAOYLdchlN
         2dwyDHR4WLFXMoY/7Zoi0wzKnCwItM3gv9+XXxWrwtTuWRClOfyxLrCERHoXBpHURrjq
         c6PYPCTRAUGPh0scmoyXNpu8Bv4J48RIhm/28XK28PWsFfZkk1ktuw9Y6kan5sivrNJT
         pFzBqf9+45Sch5MFRyQlTkIUZdfXcoza72KFeP2UhWBWuXjqSDitfie/ZnybEQ8yvK0P
         m7dA==
X-Forwarded-Encrypted: i=1; AL+hErGeXcodd9FXUmRiYXdT4+GyObEWJugCO0ugoPXzHvWdGY0oL+kBS2ep8M69lkIM5UYvv8MurO1aY3GwWI7rtqj1@vger.kernel.org
X-Gm-Message-State: APuU4Z9+7+pIJ3gPUMm1j23Tylg+WN1Oq2r9Q3/yeSDA0CJ2VY6yQpGU
	2kbs9DyIhdm4LhVZlSo6nsB+Q68XIGRuFO1CI5UeE+QZvKQIzLi8WuFrzpBRjPDf7bd3vvdSg9d
	YCv/WUvNECg==
X-Received: from dybnj40.prod.google.com ([2002:a05:7300:d0a8:b0:36a:de0:d28a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d718:b0:36a:12c1:3adb
 with SMTP id 5a478bee46e88-37966b52740mr4621734eec.20.1794604290824; Fri, 13
 Nov 2026 13:11:30 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:59 -0800
In-Reply-To: <20261113211105.3118281-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113211105.3118281-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113211105.3118281-9-irogers@google.com>
Subject: [PATCH 08/11] perf list, jevents: Add --export-dir and --output-dir
 sysfs-style exporters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add two complementary sysfs-style directory exporters so inbuilt or JSON
PMU events, metrics, and metricgroup descriptions can be materialized on
disk, inspected or edited, and layered back via pmu-events.dir:

1. perf list --export-dir <dir> (host-direct layout):
   Implement a struct print_callbacks backend in builtin-list.c backed
   by pmu_layer__export_{event,metric,metricgroup}() in pmu-layer.c
   (keeping struct perf_pmu_alias and struct perf_pmu_metric private) to
   materialize the running machine's active PMUs directly under <dir>/:

     <dir>/
     |-- cpu/
     |   |-- events/inst_retired.any{,.desc,.topic,...}
     |   `-- metrics/cpi{,.desc,.group,.scale-unit,...}
     |-- tool/events/duration_time{,.desc,.unit,...}
     `-- metricgroups/TopdownL1.desc

   This layout targets quick host-local inspection and in-place overrides
   and automatically inherits perf list filters (--unit, --cputype,
   --deprecated, and event/metric globs).

2. jevents.py --output-dir <dir> (portable CPUID/sys symlink layout):
   Materialize tools/perf/pmu-events/arch/ JSON trees into canonical
   model directories under <dir>/models/<arch>/<model>/ and expand
   arch/*/mapfile.csv CPUID patterns and literal uncore Compat IDs into
   relative POSIX symlinks under <dir>/cpus/<cpuid> and <dir>/sys/<id>,
   plus cross-CPU arch/common definitions at the top level:

     <dir>/
     |-- cpus/
     |   |-- GenuineIntel-6-4E -> ../models/x86/skylake
     |   |-- GenuineIntel-6-5E -> ../models/x86/skylake
     |   |-- 0x00000000410fd490 -> ../models/arm64/arm/neoverse-n2
     |   `-- 0x489-0x8000000000000007 -> ../models/riscv/sifive/u74
     |-- sys/
     |   `-- 43401 -> ../models/arm64/arm/cmn
     |-- models/
     |   |-- x86/skylake/{cpu,uncore_imc,...}/{events,metrics}/...
     |   `-- arm64/arm/neoverse-n2/armv8_pmuv3/{events,metrics}/...
     |-- default_core/events/...
     `-- metricgroups/<group>.desc

   This produces a self-contained multi-architecture directory tree with
   no runtime mapfile.csv or regex matching required.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt |   8 +
 tools/perf/Documentation/perf-list.txt   |  31 +-
 tools/perf/builtin-list.c                | 212 +++++++++-
 tools/perf/pmu-events/README             |  19 +
 tools/perf/pmu-events/jevents.py         | 375 ++++++++++++++++--
 tools/perf/util/pmu-layer.c              | 472 +++++++++++++++++++++++
 tools/perf/util/pmu-layer.h              |  11 +
 tools/perf/util/print-events.c           |  29 +-
 8 files changed, 1109 insertions(+), 48 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Document=
ation/perf-config.txt
index e81c33717688..95181ebfca23 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -300,6 +300,14 @@ For example, to layer local overrides ahead of a share=
d directory in
 		$ printf 'instructions / cpu-cycles\n' > ~/.perf-events/local/default_co=
re/metrics/my_ipc
 		$ printf 'Custom instructions per cycle\n' > ~/.perf-events/local/defaul=
t_core/metrics/my_ipc.desc
 		$ perf stat -M my_ipc true
++
+Overlay directories can also be populated from the current system using
+`perf list --export-dir` (see linkperf:perf-list[1]) or from JSON event tr=
ees
+using `jevents.py --output-dir`:
+
+		$ perf list --export-dir ~/.perf-events/local metric metricgroup
+		$ python3 tools/perf/pmu-events/jevents.py --output-dir /opt/pmu-events =
x86 all
+		$ perf config pmu-events.dir=3D~/.perf-events/local:/opt/pmu-events
=20
 annotate.*::
 	These are in control of addresses, jump function, source code
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentat=
ion/perf-list.txt
index 17e582998474..dbad98da3899 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -52,6 +52,14 @@ Output in JSON format.
 --output=3D::
 	Output file name. By default output is written to stdout.
=20
+--export-dir=3D::
+	Materialize matching PMU events (`<dir>/<pmu>/events/`), metrics
+	(`<dir>/<pmu>/metrics/`), and metricgroup descriptions
+	(`<dir>/metricgroups/`) into a sysfs-style directory tree suitable for
+	layering via `pmu-events.dir` in linkperf:perf-config[1], for example
+	`perf list --export-dir ~/.perf-events metric metricgroup`. See
+	<<EXPORTING_EVENTS, EXPORTING AND OVERLAYING EVENTS>>.
+
 --tui::
 Rather than printing the events, interactively browse the PMUs, events and
 metrics in the terminal using the 'ilist' python script (see
@@ -364,6 +372,27 @@ other events in the group.
 However, in the case AUX area events (e.g. Intel PT or CoreSight), the AUX
 area event must be the leader, so then the second event samples, not the f=
irst.
=20
+[[EXPORTING_EVENTS]]
+EXPORTING AND OVERLAYING EVENTS
+-------------------------------
+
+Matching PMU events, metrics, and metricgroups on the current system can b=
e
+materialized as a sysfs-style directory tree using '--export-dir', edited =
or
+extended in place, and layered back over the inbuilt tables and sysfs via
+'pmu-events.dir' (see linkperf:perf-config[1]):
+
+  perf list --export-dir ~/.perf-events sw metric metricgroup
+  printf 'Custom wall-clock duration\n' > ~/.perf-events/tool/events/durat=
ion_time.desc
+  perf config pmu-events.dir=3D~/.perf-events
+  perf list sw
+
+Architecture JSON definitions from the kernel source tree can also be expo=
rted
+directly into a self-contained directory tree (with literal 'cpus/<cpuid>'=
 and
+'sys/<id>' symlinks and no 'mapfile.csv') using 'jevents.py --output-dir':
+
+  python3 tools/perf/pmu-events/jevents.py --output-dir /opt/pmu-events x8=
6 all
+  perf config pmu-events.dir=3D~/.perf-events:/opt/pmu-events
+
 OPTIONS
 -------
=20
@@ -408,6 +437,6 @@ include::intel-acr.txt[]
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-top[1],
-linkperf:perf-record[1],
+linkperf:perf-record[1], linkperf:perf-config[1],
 http://www.intel.com/sdm/[Intel=C2=AE 64 and IA-32 Architectures Software =
Developer's Manual Volume 3B: System Programming Guide],
 https://bugzilla.kernel.org/show_bug.cgi?id=3D206537[AMD Processor Program=
ming Reference (PPR)]
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 53e1834233c8..85de0bd73e32 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -13,6 +13,7 @@
 #include "util/print-events.h"
 #include "util/pmus.h"
 #include "util/pmu.h"
+#include "util/pmu-layer.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include "util/pfm.h"
@@ -25,9 +26,11 @@
 #include <linux/zalloc.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
=20
 /**
  * struct print_state - State and configuration passed to the default_prin=
t
@@ -540,6 +543,141 @@ static bool default_skip_duplicate_pmus(void *ps)
 	return !print_state->long_desc;
 }
=20
+struct export_dir_print_state {
+	struct print_state common;
+	const char *root_dir;
+	struct strlist *visited_groups;
+	bool failed;
+};
+
+static void export_dir_print_start(void *ps)
+{
+	struct export_dir_print_state *eps =3D ps;
+	int ret =3D pmu_layer__mkdir_p(eps->root_dir);
+
+	if (ret) {
+		pr_err("Failed to create export directory '%s': %s\n",
+		       eps->root_dir, strerror(-ret));
+		eps->failed =3D true;
+	}
+}
+
+static void export_dir_print_end(void *ps __maybe_unused) {}
+
+static void export_dir_print_event(void *ps, const char *topic,
+				   const char *pmu_name, u32 pmu_type,
+				   const char *event_name, const char *event_alias,
+				   const char *scale_unit __maybe_unused,
+				   bool deprecated,
+				   const char *event_type_desc __maybe_unused,
+				   const char *desc __maybe_unused,
+				   const char *long_desc __maybe_unused,
+				   const char *encoding_desc)
+{
+	struct export_dir_print_state *eps =3D ps;
+
+	if (eps->failed)
+		return;
+
+	if (deprecated && !eps->common.deprecated)
+		return;
+
+	if (eps->common.pmu_glob &&
+		(!pmu_name || !strglobmatch(pmu_name, eps->common.pmu_glob)))
+		return;
+
+	if (eps->common.exclude_abi && pmu_type < PERF_TYPE_MAX &&
+	    pmu_type !=3D PERF_TYPE_RAW)
+		return;
+
+	if (eps->common.event_glob &&
+	    (!event_name || !strglobmatch(event_name, eps->common.event_glob)) &&
+	    (!event_alias || !strglobmatch(event_alias, eps->common.event_glob)) =
&&
+	    (!topic || !strglobmatch_nocase(topic, eps->common.event_glob)))
+		return;
+
+	if (!pmu_name || !event_name || !encoding_desc ||
+	    pmu_type =3D=3D PERF_TYPE_TRACEPOINT)
+		return;
+
+	if (pmu_layer__export_event(eps->root_dir, pmu_name, event_name) < 0)
+		eps->failed =3D true;
+}
+
+static bool export_pmu_glob_matches_metric(const char *pmu_glob,
+					   const char *eff_pmu)
+{
+	struct perf_pmu *pmu =3D NULL;
+
+	if (!pmu_glob)
+		return true;
+	if (strglobmatch(eff_pmu, pmu_glob))
+		return true;
+	if (!strcmp(eff_pmu, "default_core") && is_pmu_core(pmu_glob))
+		return true;
+
+	while ((pmu =3D perf_pmus__scan_for_metrics(pmu)) !=3D NULL) {
+		if (pmu->type =3D=3D PERF_TYPE_TRACEPOINT)
+			continue;
+		if (!strglobmatch(pmu->name, pmu_glob) &&
+		    (!pmu->alias_name || !strglobmatch(pmu->alias_name, pmu_glob)))
+			continue;
+		if (!strcmp(eff_pmu, "default_core") && pmu->is_core)
+			return true;
+		if (perf_pmu__name_wildcard_match(pmu, eff_pmu))
+			return true;
+	}
+	return false;
+}
+
+static void export_dir_print_metric(void *ps, const char *group,
+				    const char *name, const char *desc,
+				    const char *long_desc, const char *expr,
+				    const char *threshold, const char *unit,
+				    const char *pmu_name)
+{
+	struct export_dir_print_state *eps =3D ps;
+	const char *eff_pmu =3D (pmu_name && pmu_name[0]) ? pmu_name : "default_c=
ore";
+	char key[NAME_MAX + MAX_PMU_NAME_LEN];
+
+	if (eps->failed)
+		return;
+
+	if (!export_pmu_glob_matches_metric(eps->common.pmu_glob, eff_pmu))
+		return;
+
+	if (eps->common.event_glob &&
+	    (!eps->common.metrics || !name ||
+	     !strglobmatch(name, eps->common.event_glob)) &&
+	    (!eps->common.metricgroups || !group ||
+	     !strglobmatch(group, eps->common.event_glob)))
+		return;
+
+	if (eps->common.metricgroups && group && group[0] &&
+	    !strlist__has_entry(eps->visited_groups, group)) {
+		const char *gdesc;
+
+		strlist__add(eps->visited_groups, group);
+		gdesc =3D perf_pmus__describe_metricgroup(group);
+		if (pmu_layer__export_metricgroup(eps->root_dir, group, gdesc) < 0) {
+			eps->failed =3D true;
+			return;
+		}
+	}
+
+	if (!eps->common.metrics || !name || !name[0])
+		return;
+
+	snprintf(key, sizeof(key), "%s/%s", eff_pmu, name);
+	if (strlist__has_entry(eps->common.visited_metrics, key))
+		return;
+	strlist__add(eps->common.visited_metrics, key);
+
+	if (pmu_layer__export_metric(eps->root_dir, eff_pmu, group, name, desc,
+				     long_desc, expr, threshold, unit) < 0)
+		eps->failed =3D true;
+}
+
 /*
  * Launch the interactive textual based ilist python script via 'perf scri=
pt'
  * that finds the script and sets up the python environment. Arguments are
@@ -577,6 +715,11 @@ int cmd_list(int argc, const char **argv)
 			.fp =3D stdout,
 		},
 	};
+	struct export_dir_print_state export_ps =3D {
+		.common =3D {
+			.fp =3D stdout,
+		},
+	};
 	struct print_state *ps =3D &default_ps;
 	struct print_callbacks print_cb =3D {
 		.print_start =3D default_print_start,
@@ -588,6 +731,7 @@ int cmd_list(int argc, const char **argv)
 	const char *cputype =3D NULL;
 	const char *unit_name =3D NULL;
 	const char *output_path =3D NULL;
+	const char *export_dir =3D NULL;
 	bool json =3D false;
 	bool use_tui =3D false;
 	struct option list_options[] =3D {
@@ -600,6 +744,8 @@ int cmd_list(int argc, const char **argv)
 		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used int=
ernally by events."),
 		OPT_STRING('o', "output", &output_path, "file", "output file name"),
+		OPT_STRING(0, "export-dir", &export_dir, "dir",
+			   "Export events, metrics, and metricgroups to a sysfs-style directory=
"),
 		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
 			    "Print deprecated events."),
 		OPT_STRING(0, "cputype", &cputype, "cpu type",
@@ -629,22 +775,59 @@ int cmd_list(int argc, const char **argv)
 	argc =3D parse_options(argc, argv, list_options, list_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
+	if (export_dir && (use_tui || json || output_path)) {
+		pr_err("ERROR: --export-dir cannot be combined with --tui, --json, or --=
output\n");
+		return -1;
+	}
+
 	if (use_tui)
 		return list__tui(argc, argv);
=20
-	if (json)
+	if (export_dir) {
+		export_ps.root_dir =3D export_dir;
+		export_ps.common.long_desc =3D default_ps.long_desc;
+		export_ps.common.deprecated =3D default_ps.deprecated;
+		ps =3D &export_ps.common;
+	} else if (json) {
 		ps =3D &json_ps.common;
+	}
=20
 	if (output_path) {
 		ps->fp =3D fopen(output_path, "w");
 	}
=20
-	setup_pager();
-
-	if (!default_ps.name_only)
+	if (!export_dir) {
 		setup_pager();
=20
-	if (json) {
+		if (!default_ps.name_only)
+			setup_pager();
+	}
+
+	if (export_dir) {
+		print_cb =3D (struct print_callbacks){
+			.print_start =3D export_dir_print_start,
+			.print_end =3D export_dir_print_end,
+			.print_event =3D export_dir_print_event,
+			.print_metric =3D export_dir_print_metric,
+			.skip_duplicate_pmus =3D json_skip_duplicate_pmus,
+		};
+		export_ps.visited_groups =3D strlist__new(NULL, NULL);
+		assert(export_ps.visited_groups);
+		ps->visited_metrics =3D strlist__new(NULL, NULL);
+		assert(ps->visited_metrics);
+		if (unit_name)
+			ps->pmu_glob =3D strdup(unit_name);
+		else if (cputype) {
+			const struct perf_pmu *pmu =3D perf_pmus__pmu_for_pmu_filter(cputype);
+
+			if (!pmu) {
+				pr_err("ERROR: cputype is not supported!\n");
+				ret =3D -1;
+				goto out;
+			}
+			ps->pmu_glob =3D strdup(pmu->name);
+		}
+	} else if (json) {
 		print_cb =3D (struct print_callbacks){
 			.print_start =3D json_print_start,
 			.print_end =3D json_print_end,
@@ -673,7 +856,7 @@ int cmd_list(int argc, const char **argv)
 	print_cb.print_start(ps);
=20
 	if (argc =3D=3D 0) {
-		if (!unit_name) {
+		if (!unit_name || export_dir) {
 			ps->metrics =3D true;
 			ps->metricgroups =3D true;
 		}
@@ -685,16 +868,17 @@ int cmd_list(int argc, const char **argv)
 		char *s;
=20
 		if (strcmp(argv[i], "tracepoint") =3D=3D 0) {
-			char *old_pmu_glob =3D default_ps.pmu_glob;
+			char *old_pmu_glob =3D ps->pmu_glob;
=20
-			default_ps.pmu_glob =3D strdup("tracepoint");
-			if (!default_ps.pmu_glob) {
+			ps->pmu_glob =3D strdup("tracepoint");
+			if (!ps->pmu_glob) {
+				ps->pmu_glob =3D old_pmu_glob;
 				ret =3D -1;
 				goto out;
 			}
 			perf_pmus__print_pmu_events(&print_cb, ps);
-			zfree(&default_ps.pmu_glob);
-			default_ps.pmu_glob =3D old_pmu_glob;
+			zfree(&ps->pmu_glob);
+			ps->pmu_glob =3D old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") =3D=3D 0 ||
 			   strcmp(argv[i], "hardware") =3D=3D 0) {
 			char *old_event_glob =3D ps->event_glob;
@@ -780,6 +964,8 @@ int cmd_list(int argc, const char **argv)
 			zfree(&ps->event_glob);
 			ps->event_glob =3D old_event_glob;
 		} else {
+			char *old_event_glob =3D ps->event_glob;
+
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
 				continue;
@@ -791,15 +977,19 @@ int cmd_list(int argc, const char **argv)
 			ps->metricgroups =3D true;
 			metricgroup__print(&print_cb, ps);
 			free(s);
+			ps->event_glob =3D old_event_glob;
 		}
 	}
=20
 out:
 	print_cb.print_end(ps);
+	if (export_dir && export_ps.failed)
+		ret =3D -1;
 	free(ps->pmu_glob);
 	free(ps->last_topic);
 	free(ps->last_metricgroups);
 	strlist__delete(ps->visited_metrics);
+	strlist__delete(export_ps.visited_groups);
 	if (output_path)
 		fclose(ps->fp);
=20
diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index de7efa2cebd1..b95d47e7a492 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -150,3 +150,22 @@ where:
=20
 	i.e the three CPU models use the JSON files (i.e PMU events) listed
 	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
+
+Sysfs-style directory export (--output-dir)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Instead of generating C tables, 'jevents.py --output-dir <dir>' can export
+JSON events, metrics, and metricgroup descriptions directly into a sysfs-s=
tyle
+directory tree suitable for layering via 'pmu-events.dir' in '~/.perfconfi=
g'
+(see perf-config(1) and perf-list(1)):
+
+	$ python3 tools/perf/pmu-events/jevents.py --output-dir /tmp/pmu-events x=
86 skylake
+	$ python3 tools/perf/pmu-events/jevents.py --output-dir /opt/pmu-events x=
86 all
+
+Canonical model directories are written under '<dir>/models/<arch>/<model>=
/'
+and 'mapfile.csv' CPUID patterns and uncore 'Compat' identifiers are expan=
ded
+into relative POSIX symlinks under '<dir>/cpus/<cpuid>' and '<dir>/sys/<id=
>',
+so no 'mapfile.csv' is needed at runtime:
+
+	$ perf config pmu-events.dir=3D/opt/pmu-events
+	$ perf list
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index b32344e7eb8e..8c2f6531b0c5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -8,6 +8,7 @@ import importlib
 import json
 import metric
 import os
+import re
 import sys
 from typing import (Callable, Dict, NamedTuple, Optional, Sequence, Set, T=
extIO,
                     Tuple)
@@ -2087,6 +2088,298 @@ def _init_worker(std_events: dict) -> None:
   global _arch_std_events
   _arch_std_events =3D std_events
=20
+
+_SCALE_UNIT_RE =3D re.compile(
+    r'^([+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?)(.*)$'
+)
+_ENUM_AGGR_MODE =3D {
+    '1': 'PerChip',
+    '2': 'PerCore',
+}
+_ENUM_EVENT_GROUPING =3D {
+    '1': 'NO_GROUP_EVENTS',
+    '2': 'NO_GROUP_EVENTS_NMI',
+    '3': 'NO_GROUP_EVENTS_SMT',
+    '4': 'NO_THRESHOLD_AND_NMI',
+}
+
+
+def _encode_filename(name: str) -> str:
+  """Percent-encode '/' as '%2F' for POSIX filenames."""
+  return name.replace('/', '%2F')
+
+
+def _write_text_file(path: str, content: str) -> None:
+  """Write a single sysfs-style attribute file terminated by a newline."""
+  os.makedirs(os.path.dirname(path), exist_ok=3DTrue)
+  with open(path, 'w', encoding=3D'utf-8') as f:
+    f.write(content)
+    if not content.endswith('\n'):
+      f.write('\n')
+
+
+def _export_event_files(events_dir: str, event: JsonEvent) -> None:
+  """Materialize a JsonEvent into <pmu>/events/<event>* files."""
+  if not event.name or not event.event:
+    return
+  enc =3D _encode_filename(event.name)
+  base =3D os.path.join(events_dir, enc)
+  if event.event.startswith(('legacy-hardware-config=3D', 'legacy-cache-co=
nfig=3D')):
+    _write_text_file(base + '.legacy-terms', event.event)
+  else:
+    _write_text_file(base, event.event)
+
+  if event.unit:
+    m =3D _SCALE_UNIT_RE.match(event.unit)
+    if m:
+      scale_str, unit_str =3D m.group(1), m.group(2)
+      _write_text_file(base + '.scale', scale_str)
+      if unit_str:
+        _write_text_file(base + '.unit', unit_str)
+    else:
+      _write_text_file(base + '.scale-unit', event.unit)
+
+  if event.perpkg and event.perpkg !=3D '0':
+    _write_text_file(base + '.per-pkg', '1')
+  if event.deprecated and event.deprecated !=3D '0':
+    _write_text_file(base + '.deprecated', '1')
+  if event.desc:
+    _write_text_file(base + '.desc', event.desc)
+  if event.long_desc:
+    _write_text_file(base + '.long-desc', event.long_desc)
+  if event.topic:
+    _write_text_file(base + '.topic', event.topic)
+  if event.compat:
+    _write_text_file(base + '.compat', event.compat)
+  if event.retirement_latency_mean:
+    _write_text_file(base + '.retire-lat-mean', str(event.retirement_laten=
cy_mean))
+  if event.retirement_latency_min:
+    _write_text_file(base + '.retire-lat-min', str(event.retirement_latenc=
y_min))
+  if event.retirement_latency_max:
+    _write_text_file(base + '.retire-lat-max', str(event.retirement_latenc=
y_max))
+
+
+def _export_metric_files(metrics_dir: str, m: JsonEvent) -> None:
+  """Materialize a JsonEvent metric into <pmu>/metrics/<metric>* files."""
+  if not m.metric_name or m.metric_expr is None:
+    return
+  enc =3D _encode_filename(m.metric_name)
+  base =3D os.path.join(metrics_dir, enc)
+  _write_text_file(base, m.metric_expr.ToPerfJson())
+
+  if m.unit:
+    _write_text_file(base + '.scale-unit', m.unit)
+  if m.desc:
+    _write_text_file(base + '.desc', m.desc)
+  if m.long_desc:
+    _write_text_file(base + '.long-desc', m.long_desc)
+  if m.metric_group:
+    _write_text_file(base + '.group', m.metric_group)
+  if m.metricgroup_no_group:
+    _write_text_file(base + '.no-group', m.metricgroup_no_group)
+  if m.default_metricgroup_name:
+    _write_text_file(base + '.default-group', m.default_metricgroup_name)
+  if m.metric_threshold:
+    _write_text_file(base + '.threshold', m.metric_threshold)
+  if m.compat:
+    _write_text_file(base + '.compat', m.compat)
+  if m.aggr_mode and m.aggr_mode in _ENUM_AGGR_MODE:
+    _write_text_file(base + '.aggr-mode', _ENUM_AGGR_MODE[m.aggr_mode])
+  if m.event_grouping and m.event_grouping in _ENUM_EVENT_GROUPING:
+    _write_text_file(base + '.constraint', _ENUM_EVENT_GROUPING[m.event_gr=
ouping])
+  if m.default_show_events and m.default_show_events !=3D '0':
+    _write_text_file(base + '.show-events', '1')
+
+
+def _expand_char_class(spec: str) -> list[str]:
+  """Expand a regex bracket expression body like '0-9A-F' or '56'."""
+  chars: list[str] =3D []
+  i =3D 0
+  while i < len(spec):
+    if i + 2 < len(spec) and spec[i + 1] =3D=3D '-':
+      for code in range(ord(spec[i]), ord(spec[i + 2]) + 1):
+        chars.append(chr(code))
+      i +=3D 3
+    else:
+      chars.append(spec[i])
+      i +=3D 1
+  return chars
+
+
+def _expand_regex_fragment(pat: str) -> list[str]:
+  """Expand finite '(a|b)' alternations and '[...]' character classes."""
+  for idx, ch in enumerate(pat):
+    if ch =3D=3D '(':
+      depth =3D 0
+      alts: list[str] =3D []
+      start =3D idx + 1
+      end_idx =3D -1
+      for j in range(idx, len(pat)):
+        if pat[j] =3D=3D '(':
+          depth +=3D 1
+        elif pat[j] =3D=3D ')':
+          depth -=3D 1
+          if depth =3D=3D 0:
+            alts.append(pat[start:j])
+            end_idx =3D j
+            break
+        elif pat[j] =3D=3D '|' and depth =3D=3D 1:
+          alts.append(pat[start:j])
+          start =3D j + 1
+      if end_idx !=3D -1:
+        prefix =3D pat[:idx]
+        suffix_exp =3D _expand_regex_fragment(pat[end_idx + 1:])
+        out: list[str] =3D []
+        for alt in alts:
+          for mid in _expand_regex_fragment(alt):
+            for suf in suffix_exp:
+              out.append(prefix + mid + suf)
+        return out
+    elif ch =3D=3D '[':
+      close =3D pat.find(']', idx + 1)
+      if close !=3D -1:
+        prefix =3D pat[:idx]
+        choices =3D _expand_char_class(pat[idx + 1:close])
+        suffix_exp =3D _expand_regex_fragment(pat[close + 1:])
+        return [prefix + c + suf for c in choices for suf in suffix_exp]
+  return [pat]
+
+
+def _expand_cpuid_pattern(arch: str, pattern: str) -> Sequence[str]:
+  """Expand a mapfile.csv CPUID pattern into literal directory names."""
+  if arch =3D=3D 's390':
+    m =3D re.match(r'^\^IBM\.([^.*]+)\.\*.*$', pattern)
+    if m:
+      return ['IBM,' + x for x in _expand_regex_fragment(m.group(1))]
+    return []
+
+  if arch =3D=3D 'powerpc':
+    return _expand_regex_fragment(pattern.replace('[[:xdigit:]]{4}', '0000=
'))
+
+  xdigit_cls =3D '[0-9A-F]' if arch =3D=3D 'x86' else '[0-9a-f]'
+  pat =3D pattern
+  if pat.endswith('-[[:xdigit:]]+'):
+    pat =3D pat[:-len('-[[:xdigit:]]+')]
+  elif pat.endswith('-0x[[:xdigit:]]+'):
+    pat =3D pat[:-len('-0x[[:xdigit:]]+')]
+  elif pat.endswith('[[:xdigit:]]+'):
+    pat =3D pat[:-len('[[:xdigit:]]+')] + f'({xdigit_cls}|)'
+  pat =3D pat.replace('[[:xdigit:]]', xdigit_cls)
+  return [c for c in _expand_regex_fragment(pat) if '/' not in c]
+
+
+def _is_literal_compat(compat: str) -> bool:
+  """Return True if compat is a plain PMU identifier without regex operato=
rs."""
+  return bool(compat) and '/' not in compat and not any(
+      ch in compat for ch in '*+?[]()|^$\\'
+  )
+
+
+def _ensure_rel_symlink(link_path: str, target_dir: str) -> None:
+  """Create a relative POSIX symlink link_path -> target_dir if absent."""
+  if os.path.lexists(link_path) or not os.path.isdir(target_dir):
+    return
+  os.makedirs(os.path.dirname(link_path), exist_ok=3DTrue)
+  rel_target =3D os.path.relpath(target_dir, os.path.dirname(link_path))
+  os.symlink(rel_target, link_path)
+
+
+def _export_arch_tree(
+    output_dir: str,
+    arch: str,
+    sys_compat_targets: Dict[str, Set[str]],
+    ftw_fn: Callable[[str, Sequence[str], Callable[[Sequence[str], os.DirE=
ntry], None]], None],
+) -> None:
+  """Export a single architecture subtree and its CPUID symlinks."""
+  assert _args is not None
+  arch_path =3D f'{_args.starting_dir}/{arch}'
+  seen_metrics: Set[Tuple[str, str, str]] =3D set()
+
+  def export_item(parents: Sequence[str], item: os.DirEntry) -> None:
+    level =3D len(parents)
+    if level =3D=3D 0 or level > 4 or not item.is_file() or not item.name.=
endswith('.json'):
+      return
+
+    target_root =3D (
+        output_dir
+        if arch =3D=3D 'common'
+        else os.path.join(output_dir, 'models', arch, *parents)
+    )
+
+    if item.name.endswith('metricgroups.json'):
+      with open(item.path, encoding=3D'utf-8') as f:
+        mgroups =3D json.load(f)
+      for mgroup, gdesc in mgroups.items():
+        enc_group =3D _encode_filename(mgroup)
+        _write_text_file(
+            os.path.join(target_root, 'metricgroups', enc_group + '.desc')=
,
+            gdesc,
+        )
+        if target_root !=3D output_dir:
+          _write_text_file(
+              os.path.join(output_dir, 'metricgroups', enc_group + '.desc'=
),
+              gdesc,
+          )
+      return
+
+    is_sys =3D 'sys' in parents
+    topic =3D get_topic(item.name)
+    for ev in read_json_events(item.path, topic):
+      if ev.name:
+        _export_event_files(os.path.join(target_root, ev.pmu, 'events'), e=
v)
+        if is_sys and ev.compat and _is_literal_compat(ev.compat):
+          sys_compat_targets[ev.compat].add(target_root)
+      metric_key =3D (target_root, ev.pmu, ev.metric_name or '')
+      if ev.metric_name and metric_key not in seen_metrics:
+        seen_metrics.add(metric_key)
+        _export_metric_files(os.path.join(target_root, ev.pmu, 'metrics'),=
 ev)
+        if is_sys and ev.compat and _is_literal_compat(ev.compat):
+          sys_compat_targets[ev.compat].add(target_root)
+
+  ftw_fn(arch_path, [], export_item)
+
+  if arch =3D=3D 'test':
+    _ensure_rel_symlink(
+        os.path.join(output_dir, 'cpus', 'testcpu'),
+        os.path.join(output_dir, 'models', 'test', 'test_soc', 'cpu'),
+    )
+  elif arch !=3D 'common':
+    mapfile =3D os.path.join(arch_path, 'mapfile.csv')
+    if os.path.isfile(mapfile):
+      with open(mapfile, encoding=3D'utf-8') as csvfile:
+        for row in csv.reader(csvfile):
+          if not row or row[0].startswith('#') or row[0] =3D=3D 'Family-mo=
del':
+            continue
+          model_rel =3D row[2].strip('/')
+          target_dir =3D os.path.join(
+              output_dir, 'models', arch, *model_rel.split('/')
+          )
+          if not os.path.isdir(target_dir):
+            continue
+          for cpuid in _expand_cpuid_pattern(arch, row[0]):
+            _ensure_rel_symlink(
+                os.path.join(output_dir, 'cpus', cpuid), target_dir
+            )
+
+
+def _export_directory_tree(
+    output_dir: str,
+    archs: Sequence[str],
+    ftw_fn: Callable[[str, Sequence[str], Callable[[Sequence[str], os.DirE=
ntry], None]], None],
+) -> None:
+  """Materialize JSON events/metrics into a regex-free sysfs-style tree.""=
"
+  os.makedirs(output_dir, exist_ok=3DTrue)
+  sys_compat_targets: Dict[str, Set[str]] =3D collections.defaultdict(set)
+
+  for arch in archs:
+    _export_arch_tree(output_dir, arch, sys_compat_targets, ftw_fn)
+
+  for compat, targets in sorted(sys_compat_targets.items()):
+    if len(targets) =3D=3D 1:
+      _ensure_rel_symlink(
+          os.path.join(output_dir, 'sys', compat), next(iter(targets))
+      )
+
 def main() -> None:
   global _args
=20
@@ -2115,6 +2408,9 @@ def main() -> None:
       if item.is_dir():
         ftw(item.path, list(parents) + [item.name], action)
=20
+  default_arch_dir =3D os.path.join(
+      os.path.dirname(os.path.abspath(__file__)), 'arch'
+  )
   ap =3D argparse.ArgumentParser()
   ap.add_argument(
       '--compress',
@@ -2126,14 +2422,21 @@ def main() -> None:
           'blocks indexed by (block_id << 16) | sub_offset (e.g. zlib,none=
)'
       ),
   )
-  ap.add_argument('arch', help=3D'Architecture name like x86')
-  ap.add_argument('model', help=3D'''Select a model such as skylake to
+  ap.add_argument(
+      '--output-dir',
+      default=3DNone,
+      help=3D'Export events and metrics as a sysfs-style directory tree in=
stead of C code',
+  )
+  ap.add_argument('arch', nargs=3D'?', default=3D'all', help=3D'Architectu=
re name like x86')
+  ap.add_argument('model', nargs=3D'?', help=3D'''Select a model such as s=
kylake to
 reduce the code size.  Normally set to "all". For architectures like
 ARM64 with an implementor/model, the model must include the implementor
 such as "arm/cortex-a34".''',
                   default=3D'all')
   ap.add_argument(
       'starting_dir',
+      nargs=3D'?',
+      default=3Ddefault_arch_dir,
       type=3Ddir_path,
       help=3D'Root of tree containing architecture directories containing =
json files'
   )
@@ -2143,6 +2446,45 @@ such as "arm/cortex-a34".''',
       'output_string_file', type=3Dargparse.FileType('w', encoding=3D'utf-=
8'), nargs=3D'?', default=3DNone)
   _args =3D ap.parse_args()
=20
+  archs =3D []
+  for item in os.scandir(_args.starting_dir):
+    if not item.is_dir():
+      continue
+    if (
+        item.name =3D=3D _args.arch
+        or _args.arch =3D=3D 'all'
+        or (not _args.output_dir and item.name in ('test', 'common'))
+    ):
+      archs.append(item.name)
+
+  min_archs =3D 1 if _args.output_dir else 2
+  if len(archs) < min_archs and _args.arch !=3D 'none':
+    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
+
+  archs.sort()
+  import concurrent.futures
+  tasks =3D []
+  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
+    if len(parents) =3D=3D 0:
+      return
+    if item.is_file() and item.name.endswith('.json') and not item.name.en=
dswith('metricgroups.json'):
+      tasks.append((item.path, get_topic(item.name)))
+
+  for arch in archs:
+    arch_path =3D f'{_args.starting_dir}/{arch}'
+    preprocess_arch_std_files(arch_path)
+    ftw(arch_path, [], collect_json)
+
+  with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_work=
er_count(len(tasks)),
+                                              initializer=3D_init_worker,
+                                              initargs=3D(_arch_std_events=
,)) as executor:
+    for path, topic, events in executor.map(_parallel_read_json_events, ta=
sks):
+      _json_cache[(path, topic)] =3D events
+
+  if _args.output_dir:
+    _export_directory_tree(_args.output_dir, archs, ftw)
+    return
+
   _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
 /* THIS FILE WAS AUTOGENERATED BY `jevents.py arch=3D{_args.arch} model=3D=
{_args.model}` ! */
 """)
@@ -2173,35 +2515,6 @@ struct pmu_table_entry {
 };
=20
 """)
-  archs =3D []
-  for item in os.scandir(_args.starting_dir):
-    if not item.is_dir():
-      continue
-    if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.name=
 =3D=3D 'test' or item.name =3D=3D 'common':
-      archs.append(item.name)
-
-  if len(archs) < 2 and _args.arch !=3D 'none':
-    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
-
-  archs.sort()
-  import concurrent.futures
-  tasks =3D []
-  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
-    if len(parents) =3D=3D 0:
-      return
-    if item.is_file() and item.name.endswith('.json') and not item.name.en=
dswith('metricgroups.json'):
-      tasks.append((item.path, get_topic(item.name)))
-
-  for arch in archs:
-    arch_path =3D f'{_args.starting_dir}/{arch}'
-    preprocess_arch_std_files(arch_path)
-    ftw(arch_path, [], collect_json)
-
-  with concurrent.futures.ProcessPoolExecutor(max_workers=3D_parallel_work=
er_count(len(tasks)),
-                                              initializer=3D_init_worker,
-                                              initargs=3D(_arch_std_events=
,)) as executor:
-    for path, topic, events in executor.map(_parallel_read_json_events, ta=
sks):
-      _json_cache[(path, topic)] =3D events
=20
   for arch in archs:
     arch_path =3D f'{_args.starting_dir}/{arch}'
diff --git a/tools/perf/util/pmu-layer.c b/tools/perf/util/pmu-layer.c
index 2c60fc1e3285..35a816db3f4f 100644
--- a/tools/perf/util/pmu-layer.c
+++ b/tools/perf/util/pmu-layer.c
@@ -2391,3 +2391,475 @@ const char *pmu_layer__describe_metricgroup(struct =
perf_pmu *pmu,
 	perf_pmu_free_metricgroup(old_mg);
 	return mg->desc;
 }
+
+int pmu_layer__mkdir_p(const char *path)
+{
+	char tmp[PATH_MAX];
+	size_t len;
+
+	if (!path || !path[0])
+		return -EINVAL;
+
+	len =3D strlen(path);
+	if (len >=3D sizeof(tmp))
+		return -ENAMETOOLONG;
+
+	memcpy(tmp, path, len + 1);
+	while (len > 1 && tmp[len - 1] =3D=3D '/')
+		tmp[--len] =3D '\0';
+
+	for (char *p =3D tmp + 1; *p; p++) {
+		if (*p !=3D '/')
+			continue;
+		*p =3D '\0';
+		if (mkdir(tmp, 0755) < 0 && errno !=3D EEXIST)
+			return -errno;
+		*p =3D '/';
+	}
+	if (mkdir(tmp, 0755) < 0) {
+		struct stat st;
+
+		if (errno !=3D EEXIST || stat(tmp, &st) < 0 || !S_ISDIR(st.st_mode))
+			return -errno;
+	}
+	return 0;
+}
+
+static int export_write_str_at(int dirfd, const char *filename, const char=
 *content)
+{
+	size_t len =3D strlen(content);
+	size_t off =3D 0;
+	int fd;
+
+	fd =3D openat(dirfd, filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0)
+		return -errno;
+
+	while (off < len) {
+		ssize_t n =3D write(fd, content + off, len - off);
+
+		if (n < 0) {
+			if (errno =3D=3D EINTR)
+				continue;
+			close(fd);
+			return -errno;
+		}
+		off +=3D (size_t)n;
+	}
+	for (;;) {
+		ssize_t n =3D write(fd, "\n", 1);
+
+		if (n < 0 && errno =3D=3D EINTR)
+			continue;
+		if (n !=3D 1) {
+			int err =3D errno ? -errno : -EIO;
+
+			close(fd);
+			return err;
+		}
+		break;
+	}
+	close(fd);
+	return 0;
+}
+
+static int export_write_sidecar(int dirfd, const char *enc_base,
+				const char *suffix, const char *content)
+{
+	char filename[NAME_MAX + 32];
+	int n;
+
+	if (!content)
+		return 0;
+
+	n =3D snprintf(filename, sizeof(filename), "%s%s", enc_base, suffix);
+	if (n < 0 || (size_t)n >=3D sizeof(filename))
+		return -ENAMETOOLONG;
+
+	return export_write_str_at(dirfd, filename, content);
+}
+
+static struct perf_pmu_alias *export_lookup_cached_alias(struct perf_pmu *=
pmu,
+							 const char *name)
+{
+	struct perf_pmu_alias *alias =3D NULL;
+
+	if (!pmu || !name || !pmu->aliases)
+		return NULL;
+	if (hashmap__find(pmu->aliases, name, &alias))
+		return alias->terms ? alias : NULL;
+	return NULL;
+}
+
+static struct perf_pmu_alias *export_find_alias(struct perf_pmu *pmu,
+						const char *event_name)
+{
+	struct perf_pmu_alias *alias;
+	const char *slash, *end, *comma;
+	char buf[NAME_MAX];
+	size_t len;
+
+	alias =3D export_lookup_cached_alias(pmu, event_name);
+	if (alias)
+		return alias;
+
+	slash =3D strchr(event_name, '/');
+	if (!slash)
+		return NULL;
+	slash++;
+	end =3D strrchr(slash, '/');
+	if (!end || end <=3D slash)
+		return NULL;
+
+	len =3D (size_t)(end - slash);
+	if (len < sizeof(buf)) {
+		memcpy(buf, slash, len);
+		buf[len] =3D '\0';
+		alias =3D export_lookup_cached_alias(pmu, buf);
+		if (alias)
+			return alias;
+	}
+
+	comma =3D memchr(slash, ',', len);
+	if (comma && comma > slash) {
+		len =3D (size_t)(comma - slash);
+		if (len < sizeof(buf)) {
+			memcpy(buf, slash, len);
+			buf[len] =3D '\0';
+			alias =3D export_lookup_cached_alias(pmu, buf);
+			if (alias)
+				return alias;
+		}
+	}
+	return NULL;
+}
+
+static struct perf_pmu_alias *export_find_pmu_and_alias(const char *pmu_na=
me,
+							const char *event_name,
+							struct perf_pmu **out_pmu)
+{
+	struct perf_pmu *pmu =3D perf_pmus__find(pmu_name);
+	struct perf_pmu *fallback_pmu =3D NULL;
+	struct perf_pmu_alias *fallback_alias =3D NULL;
+	struct perf_pmu_alias *alias;
+
+	if (pmu) {
+		enum pmu_kind kind =3D perf_pmu__kind(pmu);
+
+		if (kind !=3D PERF_PMU_KIND_DRM && kind !=3D PERF_PMU_KIND_HWMON) {
+			alias =3D export_find_alias(pmu, event_name);
+			if (alias && alias->name && alias->terms) {
+				const char *alias_pmu =3D
+					(alias->pmu_name && alias->pmu_name[0])
+					? alias->pmu_name : pmu->name;
+
+				if (!strcmp(alias_pmu, pmu_name)) {
+					*out_pmu =3D pmu;
+					return alias;
+				}
+				fallback_pmu =3D pmu;
+				fallback_alias =3D alias;
+			}
+		}
+		pmu =3D NULL;
+	}
+
+	while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
+		enum pmu_kind kind =3D perf_pmu__kind(pmu);
+		const char *alias_pmu;
+
+		if (kind =3D=3D PERF_PMU_KIND_DRM || kind =3D=3D PERF_PMU_KIND_HWMON)
+			continue;
+		if (!perf_pmu__name_wildcard_match(pmu, pmu_name) &&
+		    !perf_pmu__wildcard_match(pmu, pmu_name))
+			continue;
+		alias =3D export_find_alias(pmu, event_name);
+		if (!alias || !alias->name || !alias->terms)
+			continue;
+		alias_pmu =3D (alias->pmu_name && alias->pmu_name[0])
+			? alias->pmu_name : pmu->name;
+		if (!strcmp(alias_pmu, pmu_name)) {
+			*out_pmu =3D pmu;
+			return alias;
+		}
+		if (!fallback_alias) {
+			fallback_pmu =3D pmu;
+			fallback_alias =3D alias;
+		}
+	}
+	if (fallback_alias) {
+		*out_pmu =3D fallback_pmu;
+		return fallback_alias;
+	}
+	return NULL;
+}
+
+int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
+			    const char *event_name)
+{
+	struct perf_pmu *pmu =3D NULL;
+	struct perf_pmu_alias *alias;
+	const char *target_pmu;
+	char dir_path[PATH_MAX];
+	char enc_name[NAME_MAX];
+	char num_buf[64];
+	int events_fd, n, ret =3D 0;
+
+	alias =3D export_find_pmu_and_alias(pmu_name, event_name, &pmu);
+	if (!alias)
+		return 0;
+
+	if (pmu_layer__encode_filename(alias->name, enc_name, sizeof(enc_name)) !=
=3D 0)
+		return 0;
+
+	target_pmu =3D (alias->pmu_name && alias->pmu_name[0]) ? alias->pmu_name =
: pmu->name;
+	n =3D snprintf(dir_path, sizeof(dir_path), "%s/%s/events", root_dir, targ=
et_pmu);
+	if (n < 0 || (size_t)n >=3D sizeof(dir_path))
+		return -ENAMETOOLONG;
+
+	ret =3D pmu_layer__mkdir_p(dir_path);
+	if (ret < 0)
+		return ret;
+
+	events_fd =3D open(dir_path, O_RDONLY | O_DIRECTORY);
+	if (events_fd < 0)
+		return -errno;
+
+	if (!strncmp(alias->terms, "legacy-hardware-config=3D", 23) ||
+	    !strncmp(alias->terms, "legacy-cache-config=3D", 20)) {
+		ret =3D export_write_sidecar(events_fd, enc_name, ".legacy-terms",
+					   alias->terms);
+	} else {
+		ret =3D export_write_sidecar(events_fd, enc_name, "", alias->terms);
+		if (!ret && alias->legacy_terms && alias->legacy_terms[0])
+			ret =3D export_write_sidecar(events_fd, enc_name,
+						   ".legacy-terms",
+						   alias->legacy_terms);
+	}
+	if (!ret && (alias->has_unit || alias->unit[0] !=3D '\0'))
+		ret =3D export_write_sidecar(events_fd, enc_name, ".unit", alias->unit);
+	if (!ret && (alias->has_scale || alias->scale !=3D 1.0)) {
+		snprintf(num_buf, sizeof(num_buf), "%.17g", alias->scale);
+		ret =3D export_write_sidecar(events_fd, enc_name, ".scale", num_buf);
+	}
+	if (!ret && (alias->has_per_pkg || alias->per_pkg))
+		ret =3D export_write_sidecar(events_fd, enc_name, ".per-pkg",
+					   alias->per_pkg ? "1" : "0");
+	if (!ret && (alias->has_snapshot || alias->snapshot))
+		ret =3D export_write_sidecar(events_fd, enc_name, ".snapshot",
+					   alias->snapshot ? "1" : "0");
+	if (!ret && (alias->has_deprecated || alias->deprecated))
+		ret =3D export_write_sidecar(events_fd, enc_name, ".deprecated",
+					   alias->deprecated ? "1" : "0");
+	if (!ret && alias->desc && alias->desc[0])
+		ret =3D export_write_sidecar(events_fd, enc_name, ".desc", alias->desc);
+	if (!ret && alias->long_desc && alias->long_desc[0])
+		ret =3D export_write_sidecar(events_fd, enc_name, ".long-desc",
+					   alias->long_desc);
+	if (!ret && alias->topic && alias->topic[0])
+		ret =3D export_write_sidecar(events_fd, enc_name, ".topic", alias->topic=
);
+	if (!ret && alias->compat && alias->compat[0])
+		ret =3D export_write_sidecar(events_fd, enc_name, ".compat", alias->comp=
at);
+	if (!ret && alias->has_retire_lat_mean) {
+		snprintf(num_buf, sizeof(num_buf), "%.17g",
+			 alias->retirement_latency_mean);
+		ret =3D export_write_sidecar(events_fd, enc_name, ".retire-lat-mean",
+					   num_buf);
+	}
+	if (!ret && alias->has_retire_lat_min) {
+		snprintf(num_buf, sizeof(num_buf), "%.17g",
+			 alias->retirement_latency_min);
+		ret =3D export_write_sidecar(events_fd, enc_name, ".retire-lat-min",
+					   num_buf);
+	}
+	if (!ret && alias->has_retire_lat_max) {
+		snprintf(num_buf, sizeof(num_buf), "%.17g",
+			 alias->retirement_latency_max);
+		ret =3D export_write_sidecar(events_fd, enc_name, ".retire-lat-max",
+					   num_buf);
+	}
+
+	close(events_fd);
+	return ret;
+}
+
+static const char *export_aggr_mode_str(enum aggr_mode_class mode)
+{
+	switch (mode) {
+	case PerChip:
+		return "PerChip";
+	case PerCore:
+		return "PerCore";
+	default:
+		return NULL;
+	}
+}
+
+static const char *export_constraint_str(enum metric_event_groups grouping=
)
+{
+	switch (grouping) {
+	case MetricNoGroupEvents:
+		return "NO_GROUP_EVENTS";
+	case MetricNoGroupEventsNmi:
+		return "NO_GROUP_EVENTS_NMI";
+	case MetricNoGroupEventsSmt:
+		return "NO_GROUP_EVENTS_SMT";
+	case MetricNoGroupEventsThresholdAndNmi:
+		return "NO_THRESHOLD_AND_NMI";
+	case MetricGroupEvents:
+	default:
+		return NULL;
+	}
+}
+
+static const struct perf_pmu_metric *
+export_find_pmu_metric(const char *eff_pmu, const char *name,
+		       const char *expr, const char *threshold)
+{
+	struct perf_pmu *pmu =3D NULL;
+	const struct perf_pmu_metric *fallback =3D NULL;
+
+	while ((pmu =3D perf_pmus__scan_for_metrics(pmu)) !=3D NULL) {
+		const struct perf_pmu_metric *m;
+		const char *m_pmu;
+
+		if (pmu->type =3D=3D PERF_TYPE_TRACEPOINT)
+			continue;
+
+		m =3D pmu_layer__find_metric(pmu, name);
+		if (!m)
+			continue;
+
+		m_pmu =3D (m->pmu && m->pmu[0]) ? m->pmu : "default_core";
+		if (strcmp(m_pmu, eff_pmu) !=3D 0)
+			continue;
+
+		if (!strcmp(m->metric_expr ?: "", expr ?: "") &&
+		    !strcmp(m->metric_threshold ?: "", threshold ?: ""))
+			return m;
+
+		if (!fallback)
+			fallback =3D m;
+	}
+	return fallback;
+}
+
+int pmu_layer__export_metricgroup(const char *root_dir, const char *group,
+				  const char *desc)
+{
+	char dir_path[PATH_MAX];
+	char enc_name[NAME_MAX];
+	int fd, n, ret;
+
+	if (!desc || !desc[0] ||
+	    pmu_layer__encode_filename(group, enc_name, sizeof(enc_name)) !=3D 0)
+		return 0;
+
+	n =3D snprintf(dir_path, sizeof(dir_path), "%s/metricgroups", root_dir);
+	if (n < 0 || (size_t)n >=3D sizeof(dir_path))
+		return -ENAMETOOLONG;
+
+	ret =3D pmu_layer__mkdir_p(dir_path);
+	if (ret < 0)
+		return ret;
+
+	fd =3D open(dir_path, O_RDONLY | O_DIRECTORY);
+	if (fd < 0)
+		return -errno;
+
+	ret =3D export_write_sidecar(fd, enc_name, ".desc", desc);
+	close(fd);
+	return ret;
+}
+
+int pmu_layer__export_metric(const char *root_dir, const char *eff_pmu,
+			     const char *group, const char *name,
+			     const char *desc, const char *long_desc,
+			     const char *expr, const char *threshold,
+			     const char *unit)
+{
+	const struct perf_pmu_metric *m;
+	char dir_path[PATH_MAX];
+	char enc_name[NAME_MAX];
+	int fd, n, ret;
+
+	if (pmu_layer__encode_filename(name, enc_name, sizeof(enc_name)) !=3D 0)
+		return 0;
+
+	m =3D export_find_pmu_metric(eff_pmu, name, expr, threshold);
+
+	n =3D snprintf(dir_path, sizeof(dir_path), "%s/%s/metrics", root_dir, eff=
_pmu);
+	if (n < 0 || (size_t)n >=3D sizeof(dir_path))
+		return -ENAMETOOLONG;
+
+	ret =3D pmu_layer__mkdir_p(dir_path);
+	if (ret < 0)
+		return ret;
+
+	fd =3D open(dir_path, O_RDONLY | O_DIRECTORY);
+	if (fd < 0)
+		return -errno;
+
+	if (m) {
+		ret =3D export_write_sidecar(fd, enc_name, "",
+					   m->metric_expr ?: expr);
+		if (!ret && m->unit && m->unit[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".scale-unit",
+						   m->unit);
+		if (!ret && m->desc && m->desc[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".desc", m->desc);
+		if (!ret && m->long_desc && m->long_desc[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".long-desc",
+						   m->long_desc);
+		if (!ret && m->metric_group && m->metric_group[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".group",
+						   m->metric_group);
+		if (!ret && m->metricgroup_no_group && m->metricgroup_no_group[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".no-group",
+						   m->metricgroup_no_group);
+		if (!ret && m->default_metricgroup_name &&
+		    m->default_metricgroup_name[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".default-group",
+						   m->default_metricgroup_name);
+		if (!ret && m->metric_threshold && m->metric_threshold[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".threshold",
+						   m->metric_threshold);
+		if (!ret && m->compat && m->compat[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".compat",
+						   m->compat);
+		if (!ret && m->has_aggr_mode) {
+			const char *aggr =3D export_aggr_mode_str(m->aggr_mode);
+
+			if (aggr)
+				ret =3D export_write_sidecar(fd, enc_name,
+							   ".aggr-mode", aggr);
+		}
+		if (!ret && m->has_event_grouping) {
+			const char *cstr =3D export_constraint_str(m->event_grouping);
+
+			if (cstr)
+				ret =3D export_write_sidecar(fd, enc_name,
+							   ".constraint", cstr);
+		}
+		if (!ret && m->has_default_show_events)
+			ret =3D export_write_sidecar(fd, enc_name, ".show-events",
+						   m->default_show_events ? "1" : "0");
+	} else {
+		ret =3D export_write_sidecar(fd, enc_name, "", expr);
+		if (!ret && unit && unit[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".scale-unit", unit);
+		if (!ret && desc && desc[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".desc", desc);
+		if (!ret && long_desc && long_desc[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".long-desc",
+						   long_desc);
+		if (!ret && group && group[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".group", group);
+		if (!ret && threshold && threshold[0])
+			ret =3D export_write_sidecar(fd, enc_name, ".threshold",
+						   threshold);
+	}
+
+	close(fd);
+	return ret;
+}
diff --git a/tools/perf/util/pmu-layer.h b/tools/perf/util/pmu-layer.h
index 5d8a33481410..183bed9cc10e 100644
--- a/tools/perf/util/pmu-layer.h
+++ b/tools/perf/util/pmu-layer.h
@@ -173,4 +173,15 @@ int pmu_layer__load_metrics(struct perf_pmu *pmu);
 const char *pmu_layer__describe_metricgroup(struct perf_pmu *pmu,
 					    const char *group);
=20
+int pmu_layer__mkdir_p(const char *path);
+int pmu_layer__export_event(const char *root_dir, const char *pmu_name,
+			    const char *event_name);
+int pmu_layer__export_metricgroup(const char *root_dir, const char *group,
+				  const char *desc);
+int pmu_layer__export_metric(const char *root_dir, const char *eff_pmu,
+			     const char *group, const char *name,
+			     const char *desc, const char *long_desc,
+			     const char *expr, const char *threshold,
+			     const char *unit);
+
 #endif /* __PMU_LAYER_H */
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.=
c
index eb44026972b9..e6f6d8231ce0 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -210,6 +210,18 @@ static int mep_cmp(struct rb_node *rb_node, const void=
 *entry)
 	return strcmp(a->metric_name, b->metric_name);
 }
=20
+static int mep_cmp_pmu(struct rb_node *rb_node, const void *entry)
+{
+	struct mep *a =3D container_of(rb_node, struct mep, nd);
+	struct mep *b =3D (struct mep *)entry;
+	int ret =3D mep_cmp(rb_node, entry);
+
+	if (ret)
+		return ret;
+
+	return strcmp(a->pmu_name ?: "", b->pmu_name ?: "");
+}
+
 static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const voi=
d *entry)
 {
 	struct mep *me =3D malloc(sizeof(struct mep));
@@ -231,19 +243,26 @@ static void mep_delete(struct rblist *rl __maybe_unus=
ed,
 }
=20
 static struct mep *mep_lookup(struct rblist *groups, const char *metric_gr=
oup,
-			      const char *metric_name)
+			      const char *metric_name, const char *pmu_name)
 {
 	struct rb_node *nd;
 	struct mep me =3D {
 		.metric_group =3D strdup(metric_group),
 		.metric_name =3D metric_name,
+		.pmu_name =3D pmu_name,
 	};
+
+	if (!me.metric_group)
+		return NULL;
 	nd =3D rblist__find(groups, &me);
 	if (nd) {
 		free(me.metric_group);
 		return container_of(nd, struct mep, nd);
 	}
-	rblist__add_node(groups, &me);
+	if (rblist__add_node(groups, &me)) {
+		free(me.metric_group);
+		return NULL;
+	}
 	nd =3D rblist__find(groups, &me);
 	if (nd)
 		return container_of(nd, struct mep, nd);
@@ -267,9 +286,9 @@ static int metricgroup__add_to_mep_groups_callback(cons=
t struct pmu_metric *pm,
=20
 		g =3D skip_spaces(g);
 		if (strlen(g))
-			me =3D mep_lookup(groups, g, pm->metric_name);
+			me =3D mep_lookup(groups, g, pm->metric_name, pm->pmu);
 		else
-			me =3D mep_lookup(groups, pm->metric_name, pm->metric_name);
+			me =3D mep_lookup(groups, pm->metric_name, pm->metric_name, pm->pmu);
=20
 		if (me) {
 			me->metric_desc =3D pm->desc;
@@ -292,7 +311,7 @@ void metricgroup__print(const struct print_callbacks *p=
rint_cb, void *print_stat
=20
 	rblist__init(&groups);
 	groups.node_new =3D mep_new;
-	groups.node_cmp =3D mep_cmp;
+	groups.node_cmp =3D print_cb->skip_duplicate_pmus(print_state) ? mep_cmp =
: mep_cmp_pmu;
 	groups.node_delete =3D mep_delete;
=20
 	metricgroup__for_each_metric(/*table=3D*/NULL,
--=20
2.56.1.703.gf848ed807c-goog

