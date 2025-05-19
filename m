Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B6219A7D
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684349; cv=none; b=WvUt1NB4CO5wfBZj0YdUwoZqZAkwKQulPxK4MNpy3ygoVWrzbPdWR0Zd43+rJ1Kh+e6V0xunihi6P09wMrWLf6ZFw3FJS6xXLMVFCOhC2W+VijFGuKrEMhyeO1ayqsroJTBy5awzdExqzdAkfJK2zsCDHdIiR+7Z8FgeA72PqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684349; c=relaxed/simple;
	bh=mNCo31KbwnmdJjCA4qZp2lBVW7ruAesrY4qBvEuiy/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRbSq6+/ArWhoZrTLdKymPMFACnSaNS/BUMaXWzGPsC2s/rvEOPVCHyxK4DuN86cztDgYoRvsOtf3xLezbUOOpDVj5YObEyKBNrC/yhHmUzxLZQcrEJlbszfSV2cU+WbWlH0Chh/S3yemsc5G40Xw9DD0HkTBSRi8Rfe0IPRpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wihdMMWC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wihdMMWC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2322a7b0735so25832195ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747684347; x=1748289147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7/0sX/Y61rnGl/g+i/reJXtElM4CHskgtvkgIXI1mc=;
        b=wihdMMWCRU3hUoRBS+pIvbJWPfnPkwPm8wv6nvN7o+AlXNOy2SNRVSjT02rOnXFnVi
         MguzJRDvpYW5nhD/uoVS9lR6kcKjDXawcJRMwJCl4Euq3nrPp5G/hMcGEOZgWp+p8Pn/
         xh8NRgx7PFRtvfzH6W8XznEAUm6e6vnrNhfmYGB4ggOS6t91xUNdkpznykRiDNV7tGdv
         WTVvFGqT+0lqYehkIONSQbm5O+RSWh3uzlE+M2RGYstTCcZRkQNbIu1GgRmHJpK8Uvtr
         SaQqSN+O6uqpMhtT6iQWM0AsAWzP9yhB9d0vGQdfKRY5Crrfd11dvkrCPBXRC3E0y3C4
         zdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684347; x=1748289147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7/0sX/Y61rnGl/g+i/reJXtElM4CHskgtvkgIXI1mc=;
        b=tn0ET21+dMAfoMiH1ic7M6aJpDsFjxvRE0d6yyshJNnrWL8QyPVoR4+iY18faFML3M
         rNWtHTgYbTyyG2qrrZOnCRqVn5Bezr0QnFwKJ/ENNWp2Lw/MNepsJhNUQgjQFAM4tbQL
         aWjd/wtYD8sEZWozwxT9zhoaX7qG5t7fNiv2GXXXK1/bz22RfNuYjq8fRbjulqc9gr31
         HWScLp3osKaNw2UhIp8zXaX8PoW4mTcY75nJDnBpDCAgpEYg7Djp083nqby2fKnQKdb0
         oTeayYFwGGbnv9GX0yvbKbOdX6wErCslHp4znYo/OruSdQsIkQ0KqOUrDaTdQgfKQlwH
         1VAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcs0onH76OIaUWxFa1eRpbkbz4nOKHJgiIGTD/B0lFfcHZgV6xr+IZw3RLsPtYR8MbSsIRNjh+UD/0ZuDarlRa@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJHwMiyz09YSnTpuML59UEAGXHU3H6Vrn79kVYdBQlJSCSqll
	SUl/25oFqAjTOPfQS8seATxv4kK4AzeYdRzdoo+ux+auUymL9XIAM55JCj+Q7nbchGCnR8GsGbm
	32NgTWcHnXA==
X-Google-Smtp-Source: AGHT+IFLI7mAtH2Z1AHGEe+OQpXKXOTpuCyCJ0Oj3c60Cd5aBMySKeRs74b/H9+pDg9fA2EKKIqnEv3BZ+m5
X-Received: from plbjx1.prod.google.com ([2002:a17:903:1381:b0:223:8233:a96c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5d1:b0:224:8bf:6d81
 with SMTP id d9443c01a7336-231d45ac8ffmr185503845ad.46.1747684346958; Mon, 19
 May 2025 12:52:26 -0700 (PDT)
Date: Mon, 19 May 2025 12:51:43 -0700
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519195148.1708988-7-irogers@google.com>
Subject: [PATCH v3 6/7] perf python: Add evlist close support
From: Ian Rogers <irogers@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

From: Gautam Menghani <gautam@linux.ibm.com>

Add support for the evlist close function.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/python.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 281e706e102d..cca744d51349 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1210,6 +1210,16 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
+{
+	struct evlist *evlist = &pevlist->evlist;
+
+	evlist__close(evlist);
+
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
 static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
 {
 	struct record_opts opts = {
@@ -1268,6 +1278,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("open the file descriptors.")
 	},
+	{
+		.ml_name  = "close",
+		.ml_meth  = (PyCFunction)pyrf_evlist__close,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("close the file descriptors.")
+	},
 	{
 		.ml_name  = "poll",
 		.ml_meth  = (PyCFunction)pyrf_evlist__poll,
-- 
2.49.0.1101.gccaa498523-goog

