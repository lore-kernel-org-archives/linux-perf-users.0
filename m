Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2673C3C16
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562669; cv=none; b=PzKImjzHykbl1XuM7xjUJC2SX0GHEuRjHe8fWjdtcNe/NzCzymGpAYDTMO45yjy5N5iJga84IPpm9kaFJ+31/HyYolwD4N/yJvRKmYiDwdqTZX6Eh/YV0mc+MHBAD3XDj8GuIlKktew1OHh1wiCL2dp7qhY1pjBlYkRDSIkDILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562669; c=relaxed/simple;
	bh=zlKNDRleksEo18Bo4F5pa1gJEu8ZpW4kHFgmWSCc7ho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XltJteDglMvl9PegPkVRaQwVmF5RbaccTOV4hL/Q2f0DxMAmJyi2jpY1QTnBmPQQDu5dwgNCKMwma3Wk/AbNWYSC5VTkenuqMF6PRFsWwgz8W0NLaImlnYTgiMNrOd0WdxBptBUFrgKmGXLk7HVsyJpEWv1+QrfmrX+B3r9bIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IC7kDu/w; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC7kDu/w"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-307fe856724so3101099eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562667; x=1782167467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCuiJ7cpJrvvup1SmgZEXA/C64pNGqrjRmbjWW0EDWo=;
        b=IC7kDu/wnokRXM/1lYL0CCSBTQfBJYgymPNmfNGp6vxw4RDaxkWZpqHgeycpVYQln+
         lsneQMRiLTJL2zbN7Kvs1xT5OoVpH03kCB4DyD6sLBPtpKmBizXiPD1fMp2HtMzXgqZ6
         h0gsrGB2+U2SnP31e5pSVf3Ipj+eXPZfVSo35jkAPTVA3S2qAD4YNF9FqMGTq8IFh8g4
         l5hqDWCztc4JyqWczRMIOhzxMPJf0Wv+kAumfGceTNkOTTleRs6ysjBEOcOcagCiyDIB
         /QkfLjTj/JBLJ+sKirOxdQKdn7NVOIcjCyIAzG1yExIaAjukCxYVCUuZpyRrnGL2AA4q
         bTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562667; x=1782167467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCuiJ7cpJrvvup1SmgZEXA/C64pNGqrjRmbjWW0EDWo=;
        b=jpywReROZYIzI3AUXwPdacgh2BeHqmL2eqJFwo+y/MEsyltffiAKL3Tf5m+XxhTyiX
         yie3LYp/6M9CU8e1QAPMjxUqh/+3C/7MHD+3RLqQZidST6a9X2gzU7lrAa6ckMdTqzTE
         SbrHkmmv5PGbz5FAqNSwsWQ5wgZY/HxPl9Oy+AMi8r1q3chrQJpksfArvV4q1l38k4O+
         ZV6+jLoQ1t7UQl/Ets8HcEwYF8kdqX/sLYpp3RAS3bT17wMdVIp62C0LDVmP+I17EyOR
         abiAMdnixDR+LRlcO8HH3UtwNF5RjHmpUn4ayTIX0SdftBmAup1a23GUWA4e7GNmQSgB
         rZkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GBK1fT9hT2XuVCP4b9bHqJuFDS2TBn72eNshHk2BQHOv1V1vE3uJP0DKQ9ROfIPNqcrjT0O8HSMdJyBG6t0ur@vger.kernel.org
X-Gm-Message-State: AOJu0YzRR4agyYcUQUGYk5QepcSJYzmQS8AGraoRofr1p0Rvo2favpiN
	A1Mp3gDfdmi4oSsa7SOruIKBC94v6KMHyOqj6hNQA2eoLOvdgGwhlbXIbE916kGywDUoIEbagRz
	zRLfzLdq6nQ==
X-Received: from dycou16.prod.google.com ([2002:a05:7300:dc90:b0:304:ed39:7b0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:aca8:b0:2d8:df01:d9f7
 with SMTP id 5a478bee46e88-30ba59d59b2mr671024eec.15.1781562666720; Mon, 15
 Jun 2026 15:31:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:30:09 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-20-irogers@google.com>
Subject: [PATCH v20 19/21] perf python: Add type checking for parse_events/parse_metrics
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The threads and cpus parameters in parse_events and parse_metrics
are parsed with the 'O' format specifier but blindly casted in the
C extension. If a user passes an invalid object type, this leads to
memory corruption when dereferencing the expected struct.

Add runtime PyObject_TypeCheck validations in python.c to safely
raise a TypeError if an invalid object is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4ec5a91d45c0..11e1f39c1bea 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3341,6 +3341,20 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
+	if (pthreads && pthreads != Py_None &&
+	    !PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "threads must be a perf.thread_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
+	if (pcpus && pcpus != Py_None &&
+	    !PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "cpus must be a perf.cpu_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
 	threads = (pthreads && pthreads != Py_None) ?
 			((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = (pcpus && pcpus != Py_None) ?
@@ -3377,6 +3391,20 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
+	if (pthreads && pthreads != Py_None &&
+	    !PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "threads must be a perf.thread_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
+	if (pcpus && pcpus != Py_None &&
+	    !PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "cpus must be a perf.cpu_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
 	threads = (pthreads && pthreads != Py_None) ?
 			((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = (pcpus && pcpus != Py_None) ?
-- 
2.54.0.1136.gdb2ca164c4-goog

