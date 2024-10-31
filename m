Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D514B092
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339048; cv=none; b=EwIzTb2Y8834JTDQVgwwxyueSrR1OnkAH1DRD5gOrYd50QRP8n7Ar88nIBJm8AlqwWLHWR9DAnNrW+rCgdPXFkPNyAUcc1ujuwHYBx4M0HYlHwr6iko6ujojJBJy3FnX7X2yROTmUfjMHK9S0o+TKZmQLumu3YIka4VNC5XTasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339048; c=relaxed/simple;
	bh=RYBqniKAr0HDr9QavuDpVba3HWcJbNfezQsIwVzha5U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HxFwooNDiu2YyGLmXu6IFUeEhTWfvCZqdrdWM6LUi7bZqn8Yaq8DnP1cuFvtL1mPRCezIcUaOYixJ3tEeURF7S6RqlUALi0xbOuPgtjV8pYsBtpFjeiFPBdx28TONf/l4ujMTceImttlB4YJRkwtjA2RDCbS4SO+RDPu2MHAVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tl3VYr0V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl3VYr0V"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso751056276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339044; x=1730943844; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=tl3VYr0VG/z41np86ByXhPDaDNrJDPucKRf1t3DWIePa5TRdoidlpmMvanCKZ46Zmu
         Ibd3NK5u24IJ3LyHQU3t2h13DivgdANPjzPwON0i5W+08Vr6zddoV9JmHr8K10FDns5r
         27Z+u0oB4i0RguEjNwlU7pPRZceYcvftfGisVcaJwT1BrUk+sFkOxOJVhnp1NCyXtAam
         EgtS79ctM8kfA4SLIS301zoz7NiYoiCb7JdcMcfXKhpr9PLOFzPQXQ5g9cV2kQ7+0pU0
         lxCjtlPzpxb1oEnOmkzhqO2F5QDLyCGEsddyxZNLw+AbwnBQHfXCCN3pbbgzrQGjXum3
         7VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339044; x=1730943844;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=ZqGxZTzUE4CA4CPlvXJxXX7dYQ+FMQnBo8j44e61q3ynCLW14FRlgCggoS1NEBloV+
         kqXDLH3PL9LNgzvBR6midja/t0YkkKxpHPbd6tSHs+y9mWx35820u6O5eIGoasw7J7lT
         6LWGP5DHR/l6MgOOPZAYdKWJ3Z5N3SOduo8I5yomqRwAETeU2YJL9hpWcl0I43FIo06c
         PmBH4AC0WbUJ/gBLG6MlcG3q9YSx8SU69jsaAW+5ZpKrUeg7UAbCEXsvD80d8z/Z68XX
         rQC/7pJ5F1Sd3ur131aYYqoMDG0UQnI8yc1Rgkt/WK0rh8INnXjAq93+ma/6hMtjqU2h
         IlyA==
X-Forwarded-Encrypted: i=1; AJvYcCVkZ/pAGGZAUsat07II6Az4hzN/NiMgjLpVQOGLL7Z5uCEtwtXzrPSbavDIEEX8J8pyPqP/CvluE1EpOsERSRgf@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKZrcMC0ay0r+o3gWO/JPnPd7NyqXYMv/Z38vnCNj2w9GiMGQ
	EuMmFJeMQKe5PD93mYZjMzoDb7xCSpPNPmYsKkArrrKAZ19h2IyF1Gy8eSqibGmaobKmSkpiqw/
	EQrgC5g==
X-Google-Smtp-Source: AGHT+IEkY0kwA61fgb8QWJVjudJLWMNOihPx9Kn6+kS+DP+smb+Lv/r7Eh0Y0JtgYpuC8tIFBhpKYAanEiLV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:308a:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e3087a704f3mr11572276.5.1730339044365; Wed, 30 Oct 2024 18:44:04
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:52 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 21/21] perf python: Correctly throw IndexError
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Correctly throw IndexError for out-of-bound accesses to evlist:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles')
>>> print(x)
evlist([cycles])
>>> x[2]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: Index out of range
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0d71ec673aa3..25114dcadd21 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1071,8 +1071,10 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	struct pyrf_evlist *pevlist = (void *)obj;
 	struct evsel *pos;
 
-	if (i >= pevlist->evlist.core.nr_entries)
+	if (i >= pevlist->evlist.core.nr_entries) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	evlist__for_each_entry(&pevlist->evlist, pos) {
 		if (i-- == 0)
-- 
2.47.0.163.g1226f6d8fa-goog

