Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2E13F458;
	Fri, 19 Jul 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396331; cv=none; b=FAojtHEgMZvRBxVF1MT8zKU3c8fy9HPYXEwtjO33wi2jPgbLsRZWVL2tpiTqCv6fjsOA8m37PodpHdHLBD0qfSKPDu8aE6qnVTyvZ4iwv5kBnrFJTmlU3oMFwl/hebLTmFCOWKHwTfW1I8NWhiMrX2xzmPA8DUsFizLsX1R/a+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396331; c=relaxed/simple;
	bh=hYm0+Gc/4820hUi3b/qjBW/E/nlsvhfdp460SR6KPfs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mtFj9gUB94c2RM1crXVg0VSe83iXyV+YIOCLIYe82MrdIClyHJDYm3HELuHQ9A3r04Jr+s+6TlVRVdOD61WQDXsXAHMTRLvkXpoaO4BoUcdUH6aB9O4HK3e3e4SAnhiJd83LtftOVP3O4FrJ9Wg9P6kMP1+FX6br/tNEm1cUDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iK1P8Lv0; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iK1P8Lv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721396297; x=1722001097; i=markus.elfring@web.de;
	bh=Nvp33d300YqX0N1vR8LPcXTZPzXdHadX2ynJNuJ4AJM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iK1P8Lv0vRGyQhWaZp4lqZN01zBuTF+XKFjc1dH1fufRyCfWCUE2hUXQng5poy8T
	 fvQohhNtYL3ZxscNonGHDW67pIaydWuZ7EA0zuBr+Ejsur39c2BJ/ErdSd4+GWH0j
	 mkWK9q6uUzgZMtKmWRiWOBlOtm0kRs2mPpkKesAGLM/5I8c5IjiJBB4GgnUgf9q5m
	 BakvAxS3rOnCHVKRZUBnC+AyIy0morloPiyrCursnwMg8SQO8t/4cS67P9uF7pnJC
	 rbUkt9GgTdGK6oORV0o/mpacHZ61wCwrdGt2w9h2383X9+aogR1C8AklPtqUa176p
	 KUzZnj8JNfuG9aa6cA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1sKNRX21ra-00yI1m; Fri, 19
 Jul 2024 15:38:17 +0200
Message-ID: <fcc9ebe9-e4a0-4395-b3f0-8c6d5fba56f2@web.de>
Date: Fri, 19 Jul 2024 15:38:14 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] perf: Optimise format string selections in three functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JRd9oP5K2pJo4gOj2zTHo1CxRuaY9GB517rk431Il04gVRO6ctk
 JFNLg7HSapN8h1kSqwqwzZWN1uV1yPL4e/KlJeSa90qQMSpj7Ft8lc/d2YUQsto0Uv98Oab
 ikTINY1n/GvYhkO278y/478UrM6JiYkVQsvLURNKrEjtXrszNHEXdbggtoSEZ88W8c7aC5+
 peZnt+x8D9vj0eVrvXosg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0vVQUbzDQ0Q=;9EiJVL6xEZcbkBJj0Vg2qvbTk5v
 qjqZ/aUD6OQl3W27o94QWV+wvnm9WrI1nANnUM+hZV+VNn83FVzDjCBYZLzZM0lQFTHjypiws
 bco7BrhbNd7e11lT28A8hLyVWhenaCIv2SkC1cAovxxSHIDdeRZU92DjBzWnybbOeLMgexiIn
 KXM+SIVEdJR/1Ln+A6//JLeaIEw4BQvsjQnGMgNZsgvXfb8SpAx7HTlA+eKlNEXPiRL6UJJmT
 Y30vzcxpQKOblwLCVkIlm47OoJhvCR1kfu9Q3OaC/sco5ttkd2bDuLEA6b6/MLfo4zHJaTRoD
 Aowi5nTfqw5KNVoefwmps2qpp+NGNR3kn/V94x5cSbtRn61odsgU9yr3v2KUa8aZDOF3O/awg
 ejSmBvuLapHFaNFgsgVqEDhYrEVMNVJQfuwqwsNkt+ABT94xt8uFyAHb8WqbBdL4yL3EEBhkT
 zYSLhVIPXSgqockYzbXf17hZafLTzTAHDE8VagOWQyx/U6F8nUumHgeGzhMGbKBDOeESCaWPD
 NqZr0PpeSN/iys9TGAliQ0ySnF9g+kVUxBRtzPL8wsGPztcczvmprMX/8loUDaajkLpnebTRK
 dphwANuoVMCtlX15uF8hYU+QG1dYoZhDuoojL3g+KxitU3xo8+hDpMg9JiCdGUU/bppLzlUDR
 51VOffalgEpsVHe7vnq3K0HaV9sjprvXXi/9/birzPzBG9j2BRA/cD3aHovXxyjdpAkzq24yk
 sPi07WE+O/INs20GX/YrT9022XvgGgWFBgtpe7f4ubb1uX3EgTVzkElvRwOuX8tkXP2NoGM7p
 mwj19Elh7rkcIa3arq+4+a5g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 Jul 2024 15:30:26 +0200

Adjust source code in three function implementations so that duplicate cod=
e
can be avoided for a few format string selections.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/builtin-script.c | 29 +++++++++++++----------------
 tools/perf/ui/stdio/hist.c  | 11 +++--------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..ec6807f00c54 100644
=2D-- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -796,16 +796,16 @@ static int perf_sample__fprintf_start(struct perf_sc=
ript *script,
 	if (PRINT_FIELD(VCPU) && sample->machine_pid)
 		printed +=3D fprintf(fp, "VCPU:%03d ", sample->vcpu);

-	if (PRINT_FIELD(COMM)) {
-		const char *comm =3D thread ? thread__comm_str(thread) : ":-1";
-
-		if (latency_format)
-			printed +=3D fprintf(fp, "%8.8s ", comm);
-		else if (PRINT_FIELD(IP) && evsel__has_callchain(evsel) && symbol_conf.=
use_callchain)
-			printed +=3D fprintf(fp, "%s ", comm);
-		else
-			printed +=3D fprintf(fp, "%16s ", comm);
-	}
+	if (PRINT_FIELD(COMM))
+		printed +=3D fprintf(fp,
+				   (latency_format
+				   ? "%8.8s "
+				   : ((PRINT_FIELD(IP) &&
+				     evsel__has_callchain(evsel) &&
+				     symbol_conf.use_callchain)
+				     ? "%s "
+				     : "%16s ")),
+				   (thread ? thread__comm_str(thread) : ":-1"));

 	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
 		printed +=3D fprintf(fp, "%7d/%-7d ", sample->pid, sample->tid);
@@ -814,12 +814,9 @@ static int perf_sample__fprintf_start(struct perf_scr=
ipt *script,
 	else if (PRINT_FIELD(TID))
 		printed +=3D fprintf(fp, "%7d ", sample->tid);

-	if (PRINT_FIELD(CPU)) {
-		if (latency_format)
-			printed +=3D fprintf(fp, "%3d ", sample->cpu);
-		else
-			printed +=3D fprintf(fp, "[%03d] ", sample->cpu);
-	}
+	if (PRINT_FIELD(CPU))
+		printed +=3D fprintf(fp, (latency_format ? "%3d " : "[%03d] "),
+				   sample->cpu);

 	if (PRINT_FIELD(MISC)) {
 		int ret =3D 0;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 9372e8904d22..899019e8aab8 100644
=2D-- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -37,10 +37,7 @@ static size_t ipchain__fprintf_graph_line(FILE *fp, int=
 depth, int depth_mask,
 	size_t ret =3D callchain__fprintf_left_margin(fp, left_margin);

 	for (i =3D 0; i < depth; i++)
-		if (depth_mask & (1 << i))
-			ret +=3D fprintf(fp, "|          ");
-		else
-			ret +=3D fprintf(fp, "           ");
+		ret +=3D fprintf(fp, ((depth_mask & (1 << i)) ? "|          " : "      =
     "));

 	ret +=3D fprintf(fp, "\n");

@@ -60,10 +57,8 @@ static size_t ipchain__fprintf_graph(FILE *fp, struct c=
allchain_node *node,

 	ret +=3D callchain__fprintf_left_margin(fp, left_margin);
 	for (i =3D 0; i < depth; i++) {
-		if (depth_mask & (1 << i))
-			ret +=3D fprintf(fp, "|");
-		else
-			ret +=3D fprintf(fp, " ");
+		ret +=3D fprintf(fp, ((depth_mask & (1 << i)) ? "|" : " "));
+
 		if (!period && i =3D=3D depth - 1) {
 			ret +=3D fprintf(fp, "--");
 			ret +=3D callchain_node__fprintf_value(node, fp, total_samples);
=2D-
2.45.2

