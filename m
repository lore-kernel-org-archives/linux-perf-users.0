Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6443A8745
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962100; cv=none; b=Bg5ZAG2NV8KJ7yt/06gx3DObPnW5e7M3Nph5nEohymiLzfyjhM8tbtfbkIbxDzKGWrimOlQR/+NC2KVIQMzBnjjdV+mUkgqywUx9WUsk2+zhg4XxZEn70y5nRhh3togKDs5bRouXn6z9eJu7hZj6255EW/YFjy9OpLqpP9fAGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962100; c=relaxed/simple;
	bh=QHx1+jP8Xoa+KpULosdDawvIN5XPNfXuSXgd9EFaHR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RzHUTdEIuzSko1a2LPxG6LWQFu10XbYhnixabe/28cc1xT/SrnKcubv3PJbH8wz1+8pm9dp3ZWvKHLJhJc9bb6opLZnJYrvwk4YBVfoAqNau8Uboj2pCdCXvwysh2Fau62BfIhXtQOU8K7LOw28qLr3kZJBbgHZZ++9n2EQC42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBjcXlvT; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBjcXlvT"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso9032911eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962098; x=1777566898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqWbWwttWazbhBwzSy9FYV2WLXqz3OOopag/c+5+FWQ=;
        b=WBjcXlvT2tO85k5Oz0j7+NOKQb1PiqkixJG1oFcai+LK55NDjJjM7PuBvjt3mfG54W
         gceAQ9Z+DaAVVcJTaw9piRUvmnhsE6HG5p8pHCMOb1gT0KwMturCiplxx9K7Ol0oXlG+
         HcokSdK3g4pArGuQBuAvKlNvF5W1rZ2ib0gn6daIgQD2cvK0HyaGgj4P8WlSMSKiD0NN
         fDwOVKNO1K+S+llzDTG75a3JiCxK9BzUDe8CCHYNULYbdH21dI5+wjl78zYoMsVK6lmb
         mkybMGEPvG5uIIAVSFa14ooXWmg+Hszjr8qkOHlO2voWUHxh01xCEXXrsQm/gkfZIf/b
         w3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962098; x=1777566898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqWbWwttWazbhBwzSy9FYV2WLXqz3OOopag/c+5+FWQ=;
        b=gzg9VU8XxOSovJmeUOYm+FGV8Oxv8gaCE30Gh+BLAe+O+vHxYK1uNNDRSd6AAhEX9+
         7oFECjAFbzPd1k6QAaBleZk5LcWTRBcn2Lcp9AVK6PCbPmqYTbiTCD6w+TfdCQ1b/N+s
         yLsiITy8eHqL1IUyL0r8ew5xDUUh+iLA4Uo6XQqZJLKOQEd6VAz3/EHrvwaltGUpX4Cg
         Q4BhS1H9WGYgPZO6S6RJcBRlYRhmmxyg6hOH90YetBR6E79OZHrtu4UqOR/4vWOaa27K
         zSskW3574zbsa4OVFFrUmQQUNeQqqlFE3/5r/QyRSC21KGjabAoTb/Xz+fAxJ//fi842
         O4Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8rAcK9XeLWIvR8xxAzvzqp/3h3EnhPJDHXL4Ki9Fc9AUibHHG2Ew+UfhkUjXpn2Pj0DQoKPhRG0g7ufnn+0oQM@vger.kernel.org
X-Gm-Message-State: AOJu0YxAuiniMP7tsIke5mwzq/UyDN7M+Pf3T7+4qBiLWZSY5RvBeFI0
	BAvDb13SRVBYwAta4SMH90sQ+WFWF6zT5OlVkAZ+ng9OltoJwGMKdmnHVMwf6FrTL/a/5vuT/JT
	fPjNlU/krnQ==
X-Received: from dycal20.prod.google.com ([2002:a05:7301:1c94:b0:2d7:ab9e:d123])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c84:b0:2da:44ac:6d17
 with SMTP id 5a478bee46e88-2e47873bd2cmr16433960eec.17.1776962098110; Thu, 23
 Apr 2026 09:34:58 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:27 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-20-irogers@google.com>
Subject: [PATCH v4 19/58] perf python: Add config file access
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 28961ad47010..dc10d8a42d92 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3230,7 +3231,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
 	return PyLong_FromLong(id);
 }
 
+static PyObject *pyrf__config_get(PyObject *self, PyObject *args)
+{
+	const char *config_name, *val;
+
+	if (!PyArg_ParseTuple(args, "s", &config_name))
+		return NULL;
+
+	val = perf_config_get(config_name);
+	if (!val)
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(val);
+}
+
 static PyMethodDef perf__methods[] = {
+	{
+		.ml_name  = "config_get",
+		.ml_meth  = (PyCFunction) pyrf__config_get,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Get a perf config value.")
+	},
 	{
 		.ml_name  = "metrics",
 		.ml_meth  = (PyCFunction) pyrf__metrics,
-- 
2.54.0.rc2.533.g4f5dca5207-goog

