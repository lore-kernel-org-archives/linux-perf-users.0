Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C5258EE9
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567620; cv=none; b=Oij6VZXKnHBcjxrwg1ou+fSFwBpoT/D0gBDkubuwOKupsIWbLrjoBNQ1uDwQIs41s7m8jRUefH/xOqfthhye7WTzCuzdOY9/4DtNf88mZvGRH0N96eE1Fg1ghyLzYo0zLRv0RXLiqhzvgm+1rJvJDWpruoUt6f23n46HJ6NP8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567620; c=relaxed/simple;
	bh=A1O7CYuDIwfrjpf5HTHYJpAdjlrhkvSWHPKIw6QihHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L95NDG5zMoi74A2yazejeIrvyNfM8DwuMocbjYmxNVtS6zY/lM57dkZ/DnHw+iv6ftN+DGB6VeY/6WSX2XE50e8tfvP028xbPujyX6PNOAvtwbkoqjdwkyHAbFlYgVDAyOO1pFRjtp0WxgZ9hoKTHTT2m9snfWgUl3TAxZK1lEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTaR1MKG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTaR1MKG"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581ce388so109135875ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567618; x=1756172418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxi/JCK2BLKzi0/ZyhjF6rPP5ww+d440SIzuUKydzxE=;
        b=aTaR1MKGj+9xp9Zz15ryyFUTDa0jv6U+JNcXnn68JspVpvd39rdUcaR49Z3HnQsrKM
         dAKQ2Xo1XCEjTGKjq63+m4Imt0374ALfp8AAih8VqREwGLxhQEtseCRU7Q4Yco5FvyiO
         kEd1zThaXSwFUdVxmNO0kVtPpwtijEpAlTlftJtjH4eENNZyTyA7G+kDCh6c5NZNUM1W
         pzF2lAljph2HCMExtKgOdOR1+jsyHxa3sZZFFm5KobSatS1XJ14jL85w7ZVTIDYA4YE6
         Meq9r6VpxEWh2VbUxdPF+LfCk/wNP5pKRsDunMqbz8zDsMVF+c9ES9nwmP4TNBrPZ1YU
         dlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567618; x=1756172418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxi/JCK2BLKzi0/ZyhjF6rPP5ww+d440SIzuUKydzxE=;
        b=mxFnp8oIFelnBQkKDLUShzyxQiV4LKoGGbImckJhsJTvwhqX01fMeEZ2DmJ70ThY9y
         RzYtpKK3UwtizmbrQz3T/VRd0NIPrq0SCVTRqRRRojH9IJOVvw3dowaZL0RVGOO45qQM
         5MWADeR3RaU/NFD+aLP+zJBkIdvFfQXban6RuqAmXp1NfHm7vmadWqModKRv5MekCwFm
         dHY4F4z5v/PD7gyi3P8xcp6mQd5/bnwAalYSHRJAvly9C8P9fUGn2J2fB4fBXefu3R42
         QqZXdbJG6HDEiSQ5LLv2mpjUnNJOWimFuGwM3fuV8xhkb+1IuL5CwDCSVjYP7qe4psA0
         n/EA==
X-Forwarded-Encrypted: i=1; AJvYcCXoacfhzVRMRMUhSLBoRcBsOCkwssg9IIRkH6ZORkCJNRga2HI41L3/2jKNv+dv82ji6nFE/Dbe9j7IFQvE6lrA@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXZBtNMQt0TsB9bAWubzZGklCPmKu14HWZI+nSVDKUvrApzrY
	ZQip+dFOt61Id0s0LHt6uW+bJtvwpMVvOMh8hCmdfqPUk/Cy7+xYW1F3s7SnBMx5AlrJiRRpb6F
	3CWqSsRTTMA==
X-Google-Smtp-Source: AGHT+IF9CeNDcjJLIvg9GhN428Ve6XepqE0wjzKqZf+rotfr+pXMiqOqhylx332A3+FEYRDbtxPeRMI5Z64H
X-Received: from plij13.prod.google.com ([2002:a17:903:380d:b0:242:7de4:ef6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1447:b0:240:79d5:8dc7
 with SMTP id d9443c01a7336-245e04d50eamr11330215ad.46.1755567618413; Mon, 18
 Aug 2025 18:40:18 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:31 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-2-irogers@google.com>
Subject: [PATCH v10 01/11] perf python: Add more exceptions on error paths
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Returning NULL will cause the python interpreter to fail but not
report an error. If none wants to be returned then Py_None needs
returning. Set the error for the cases returning NULL so that more
meaningful interpreter behavior is had.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ea77bea0306f..d47cbc1c2257 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -485,13 +485,19 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	if ((event->header.type < PERF_RECORD_MMAP ||
 	     event->header.type > PERF_RECORD_SAMPLE) &&
 	    !(event->header.type == PERF_RECORD_SWITCH ||
-	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
+	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)) {
+		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
+			     event->header.type);
 		return NULL;
+	}
 
 	// FIXME this better be dynamic or we need to parse everything
 	// before calling perf_mmap__consume(), including tracepoint fields.
-	if (sizeof(pevent->event) < event->header.size)
+	if (sizeof(pevent->event) < event->header.size) {
+		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
+			     sizeof(pevent->event), event->header.size);
 		return NULL;
+	}
 
 	ptype = pyrf_event__type[event->header.type];
 	pevent = PyObject_New(struct pyrf_event, ptype);
@@ -1209,8 +1215,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		return NULL;
 
 	md = get_md(evlist, cpu);
-	if (!md)
+	if (!md) {
+		PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
 		return NULL;
+	}
 
 	if (perf_mmap__read_init(&md->core) < 0)
 		goto end;
-- 
2.51.0.rc1.167.g924127e9c0-goog

