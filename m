Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E0259CBC
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Jun 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276800; cv=none; b=KNNC43VBHwOgn/3+QLNkgvM7FMDR4eNztoHnsC2YKZ7bJM5wCHMeMTLd6D0IYY6AQprkPXt/3SN6WE7/Vj1fUTUF5hxeUFeEF21lTka3YrI8ZWNCNfWprXG5xkGnFNF2xdyGC+4EFNaWbO5uV8m66l/4F54VlP5EOFFpTPlX9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276800; c=relaxed/simple;
	bh=4kJkBveRo8+jJBj/O5cyr7aCXtsfSX3e7ZSPO9xVk7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W5oPfSrhhE9+CzHi2SMog8RfjptjGLf61ID7R3ITwPJEO+RTIofR0IX+GTz+2ey72BlbINATiETD3m4Dw2ysxD9idrk7RmI5wdguxo0HAjxMk6P2UvHXSh/AuuSmxku6BdC3bvRFpeAxpw9F5Rd843J1YvHcdlEme/y2X5cFyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gv/ymN+m; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv/ymN+m"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2cca2c52dd9so2129577fac.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 23:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276798; x=1749881598; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0pn6/0s/p+lc/1tabk3JfmDY0UTcINJzaOZVvvQiEw=;
        b=Gv/ymN+ms///njd7lfEFxd6y3PMXyMxx1eUc+GjvwJBuXkjV00qpq4gJcsLBJjBOh2
         ZtXcRwZaGStoj8yuMgx6iJSLqSgWLDViK4Zzxdh+INIlAbr9lkYV9aU55PLxmF4RMLVW
         Ot4vo6soaSscR6VfaBRW3Y3Gj8plmKZhOMEknsJohffzWycdGThgi+GU+Q4X8hbfAh6e
         QKU6tVweeF/ZWbufR/S3tHlagPmQih32gMerq7b4Fq/YO3YHp0G28I3ZveUF8xV3Tros
         rWUIfQFUSRt/onRQb1RY7oHoRBmc/8Wzd/e38C5MiMYdtpmszW4grmtpDFvurm/sBKyz
         wPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276798; x=1749881598;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0pn6/0s/p+lc/1tabk3JfmDY0UTcINJzaOZVvvQiEw=;
        b=Rfnq4cneoiY/unp5Ha/92jN/9Vl3flBc4VRSLF9Z8vTzQCYyUAHOeH8ooZxLWq/x2E
         LMSDdDECwtsX54M3T6kWNcYfGyHZdwslaV2/+j9mchlF8CjSW7DoFDr3gS0NAdGhdr0t
         8Ajx64JQOxwCpHOuysihR9pc1Bz8mJBXdFJYwam85XXXfB21HlJmQvDyYiVrcutXgiUr
         VFLGJn+UIEmntGLWCXcFg4IayuICLjb0WFcSeYNg4pn/HrWUzR3zIOUCYSzyBizstJ1d
         jQODq0q0WeYMkPmyPl09I1fX3vi9XHpe9my94RlG1TVRGIHDAPvZkMObCkY9YS5C4MGn
         myvw==
X-Forwarded-Encrypted: i=1; AJvYcCXRLlX8us7nRHbJIAYVcfVpsS8xkbCXgym35WxfGo6xx00W32Yim/r7LjckfU/wlgB4umTTBNsWnKaBft9t0DyL@vger.kernel.org
X-Gm-Message-State: AOJu0YziHoXWFPAgHhvodzh3VybUV8kNLFJIf4QBRGcI/2QG0zW8qBhN
	r95FNk4SyRzVI8zYGoK7irve/4k9THc2Nd/TCY2jU2Y7E+WKV0NZmIgUbl6s9W2tXVh41QiROk4
	qIFE8HE1AzQ==
X-Google-Smtp-Source: AGHT+IEPNdqZpO1gLTs7JEkZH3S3RDHk1Uwt3ike1JWM5wGerMEXftFaA85V/RQLYGjlu5uopkscFTOMyk8p
X-Received: from oabop2.prod.google.com ([2002:a05:6870:2dc2:b0:2c1:c983:48c1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:1782:b0:2c8:361a:da77
 with SMTP id 586e51a60fabf-2ea0118d3afmr3628225fac.26.1749276797716; Fri, 06
 Jun 2025 23:13:17 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:36 -0700
In-Reply-To: <20250607061238.161756-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250607061238.161756-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-3-irogers@google.com>
Subject: [PATCH v1 2/4] perf header: Allow tracing of attr events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In pipe mode attr events capture the perf_event_attr. Allow their
dumping as they normally start the file.

Before:
```
$ perf record -o - -a sleep 1 | perf script -D -i -
. ... raw event: size 272 bytes
.  0000:  40 00 00 00 00 00 10 01 00 00 00 00 88 00 00 00  @...............
.  0010:  00 00 00 00 00 00 00 00 a0 0f 00 00 00 00 00 00  ................
.  0020:  87 01 01 00 00 00 00 00 14 00 00 00 00 00 00 00  ................
.  0030:  01 84 05 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0080:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0090:  91 08 00 00 00 00 00 00 92 08 00 00 00 00 00 00  ................
.  00a0:  93 08 00 00 00 00 00 00 94 08 00 00 00 00 00 00  ................
.  00b0:  95 08 00 00 00 00 00 00 96 08 00 00 00 00 00 00  ................
.  00c0:  97 08 00 00 00 00 00 00 98 08 00 00 00 00 00 00  ................
.  00d0:  99 08 00 00 00 00 00 00 9a 08 00 00 00 00 00 00  ................
.  00e0:  9b 08 00 00 00 00 00 00 9c 08 00 00 00 00 00 00  ................
.  00f0:  9d 08 00 00 00 00 00 00 9e 08 00 00 00 00 00 00  ................
.  0100:  9f 08 00 00 00 00 00 00 a0 08 00 00 00 00 00 00  ................

-1 -1 0 [0x110]: PERF_RECORD_ATTR
0x110@pipe [0x110]: event: 64
...
```

After:
```
$ perf record -o - -a sleep 1 | perf script -D -i -
0@pipe [0x110]: event: 64
.
. ... raw event: size 272 bytes
.  0000:  40 00 00 00 00 00 10 01 00 00 00 00 88 00 00 00  @...............
.  0010:  00 00 00 00 00 00 00 00 a0 0f 00 00 00 00 00 00  ................
.  0020:  87 01 01 00 00 00 00 00 14 00 00 00 00 00 00 00  ................
.  0030:  01 84 05 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0080:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0090:  5c 08 00 00 00 00 00 00 5d 08 00 00 00 00 00 00  \.......].......
.  00a0:  5e 08 00 00 00 00 00 00 5f 08 00 00 00 00 00 00  ^......._.......
.  00b0:  60 08 00 00 00 00 00 00 61 08 00 00 00 00 00 00  `.......a.......
.  00c0:  62 08 00 00 00 00 00 00 63 08 00 00 00 00 00 00  b.......c.......
.  00d0:  64 08 00 00 00 00 00 00 65 08 00 00 00 00 00 00  d.......e.......
.  00e0:  66 08 00 00 00 00 00 00 67 08 00 00 00 00 00 00  f.......g.......
.  00f0:  68 08 00 00 00 00 00 00 69 08 00 00 00 00 00 00  h.......i.......
.  0100:  6a 08 00 00 00 00 00 00 6b 08 00 00 00 00 00 00  j.......k.......

-1 -1 0 [0x110]: PERF_RECORD_ATTR, type =3D 0 (PERF_TYPE_HARDWARE), size =
=3D 136, config =3D 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_f=
req } =3D 4000, sample_type =3D IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_for=
mat =3D ID|LOST, disabled =3D 1, freq =3D 1, precise_ip =3D 3, sample_id_al=
l =3D 1
0x110@pipe [0x110]: event: 64
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 8 ++++++++
 tools/perf/util/header.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 84879d7fdffe..7798435ab5d3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4414,6 +4414,11 @@ size_t perf_event__fprintf_event_update(union perf_e=
vent *event, FILE *fp)
 	return ret;
 }
=20
+size_t perf_event__fprintf_attr(union perf_event *event, FILE *fp)
+{
+	return perf_event_attr__fprintf(fp, &event->attr.attr, __desc_attr__fprin=
tf, NULL);
+}
+
 int perf_event__process_attr(const struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
@@ -4423,6 +4428,9 @@ int perf_event__process_attr(const struct perf_tool *=
tool __maybe_unused,
 	struct evsel *evsel;
 	struct evlist *evlist =3D *pevlist;
=20
+	if (dump_trace)
+		perf_event__fprintf_attr(event, stdout);
+
 	if (evlist =3D=3D NULL) {
 		*pevlist =3D evlist =3D evlist__new();
 		if (evlist =3D=3D NULL)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 5201af6305f4..d16dfceccd74 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -175,6 +175,7 @@ int perf_event__process_attr(const struct perf_tool *to=
ol, union perf_event *eve
 int perf_event__process_event_update(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct evlist **pevlist);
+size_t perf_event__fprintf_attr(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)=
;
 #ifdef HAVE_LIBTRACEEVENT
 int perf_event__process_tracing_data(struct perf_session *session,
--=20
2.50.0.rc0.604.gd4ff7b7c86-goog

