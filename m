Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8821991CA
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133154; cv=none; b=UN7kLGGkB/aIeYyDEuu/6rDejFe/G0ZZ0GmZjbhCFKv3Y9mOzGANZAMjqMioREboJTAidl649TAa+A8zF5bHAn7q4NJKc5O9Bdrl5e0xvQ0ODC30YXs8M0nLMgchwdr6L3En+xfnxupZC9PK/2AeEININYtXlxHQTHAOP6PDm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133154; c=relaxed/simple;
	bh=cdFXS6YbU6dHLZsfKNNJ3CV8t/rR/3/1BmnroI/EmI4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=bBOHkRp9Dmu7TF/m5TV1AIbWXOf89nsdpS/JlMWQ+YmDnZ2R+dL9dOPpOswXTBnMYhrGMcf7s88zjLf/z9ByPgGPoLiaOddSUhduKyZ3Pq8n4he/+JWDC4VO8FdQYFVQAAdqyk0j7tqmgVcP/ZHBYAVS1GDuGMqH2BDs18z9zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LINTWF0L; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LINTWF0L"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so4456040276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133152; x=1731737952; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m24ezova7J3GENnmHxuIJrSil1dVDJzqrtZznCoBSNI=;
        b=LINTWF0LAIkda7RAlnxKvdOE3C7bfMMXN5ShsIeQUoXQpCo0iqUk8x4o0umNVtMzqc
         HBCrCrFxfM8N4MD/xVpLflfSujsLaW+BRXmnU3iJao8YYb8+J0KCved325i9xfROA9/v
         XnFuI6OROMHXm0N7NYvTOtxbNzbP47oC7hX2Dwg3hbMQAEoDgo64Wi1waTBxRmtvF6Ha
         vIfVm9V90k8vXQ8qutwwUyHGjaC9lOuPwI6PxCYq88mbCUjnzOebf6CBXNPLfrs2X3vn
         DeiDoKSPHLAgLsX67ZXGnXEwjBFQtkVjYjGcuPQiywIDdW34MYVfd/ncNhwlw6XdpWYH
         tRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133152; x=1731737952;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m24ezova7J3GENnmHxuIJrSil1dVDJzqrtZznCoBSNI=;
        b=T1oRS9i6hPgDvHR3t2f5sZepd4DZgnNe/d1SZSZQGRHsrYOEcsxiBoxEwfHFMrY3rC
         DhWQ+epdjQNVG1OEmfiwDKfgRfw4HDdeIzcOvCs9LxXrO3exYZDKUC0FQwLO+yEoBh0U
         /wrscJ71PNPJJLC29ETfGJhCxXiXGdtgIIMrLpG9YfHrMLbK4LGkB7MrrkU6z+IWqqZ0
         pNhk8IfE7xpjo5W4cR8TJIySwrKwHItya547NzVfhm3DFNco7SuJyeRiSd55zgLa1RZ2
         L3yhGkQlpkkppKck1h7l4aciEE1b/VXR+892vyznlaPeYK8IoOa4lOvOcxHUJ2Q5JXIN
         8bXA==
X-Forwarded-Encrypted: i=1; AJvYcCVVYIJ14KoTfO8qUXxVQxEp5sfE8nkTbUihlJFzi9jAmcWsYWQsq9axovVEFj4xldOy/X1G13d1nZ6k8WVh/UiD@vger.kernel.org
X-Gm-Message-State: AOJu0YwoP2zxicSquRSh+KpNi0j2f3jnhN6iicJgcM1NRiEOKaQ/vGS2
	jX3oknbOOQYsmB+IXkKpjs0Rh7Ti3XR3fw8X5qC/nmu9f/A3IaxFP6f0KvSaO3ASGEGwbNixwwA
	U9aWuBw==
X-Google-Smtp-Source: AGHT+IEjWicK5LpMHUtvdfgpqNM6nhMioZKKQMcNun1xBlhB3GtyO6nVCSa+gmCfKwcqfavz2sH0Ixj1poWJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:8b81:0:b0:e2e:3031:3f0c with SMTP id
 3f1490d57ef6-e337f8d41a3mr4031276.7.1731133151533; Fri, 08 Nov 2024 22:19:11
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:09 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 22/22] perf python: Correctly throw IndexError
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.47.0.277.g8800431eea-goog

