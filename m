Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F1216214
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877002; cv=none; b=dyJzWELeL1f+/bNicpM8eyUCN23pETOlrMMv5Fh3icAGEibDMxSMrMovL843aR3/TLNKKmWnY+z+EhpVNfA5IJ8zhKk7XEjLWVioV+Zgr3rzjGMH5q/EdHfwoClFID/wZITKRJB0cnuqhsup/v8I3Rs20xcOSj77MaMD4PVD4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877002; c=relaxed/simple;
	bh=GBM4ZicRscGoqeRG2umNjcjdQ21UpmRmU+k4VWUF7rE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=R/w26020Gki9D0zTHp6XDCs6KZc9t5+Jo55q729ifwmSIrff1VwSNViSeqfCVETjA7fyKICOTsBepFPrliaB4OI9vunXBwKE+4y8bmx+yhJ/xZDr8TZ8/SFdQLknT4mkGJlqmL1g0cKxQ2WlRA09hEC1fyyFNYHf71pNab6eVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQERRMzy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQERRMzy"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3231725c9so49438887b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876999; x=1730481799; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tDa78t8ycfTpXeP4Xg4vb+EbbxD0z0lIJ18k3gRsWI=;
        b=hQERRMzy+dcJjFGP7GY2FUYLOhBxAL6ApOUvoabDJpNlj9bjqEYvSzBa+4yaHlaSnc
         fvHD9/XKdCzZ2jSFI2wQcSzh/lzRAcDaEBDTfPeN5smpZh3QXB5T8q7OklkZ7kOvZPhi
         tvGSDu7Ah2SiYGqNxuFElCeFWvdN/vBHQtH+lW+a260+hQAhArHaMTDw0Oyel8n00v4J
         cQuZPJ+sgsAtiuEwqVSaOBmCBJlFgogUBPAbn11hvY9/8+atG7dNCfRNzfLYzUYeK9M3
         LG7LiXU9EFVlTupwAfCIVj3aAJSDr3xywWezbud57jLzcKzvIzXKQyNVdecDx14PY7wM
         75AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876999; x=1730481799;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tDa78t8ycfTpXeP4Xg4vb+EbbxD0z0lIJ18k3gRsWI=;
        b=PMxoDizzry31GKfGxi2JbQIIYFpM6kmjVh6WOJBhbAaR89K5RAFvFOuW5bJv/3rgN3
         Fefl393nWJiAcixTArp9jQpUDLhhIKw7dlmYGuY+pFsV4UemTK9jtMlOLfl7G5vSA4Bo
         Ygn2F/Wr3E4yGEiEmb+RxtLITxHY+j3BaLk5oYB7YfCb6zu98ta9dCPbxrxgatC5gtWg
         JrPkOCkSJg/EFNqenCvInpRmOckPNt79We6mjZq9RssPhv+w/ESPhBFgtvHcxroEuRbW
         /6MmiJ91LMUnLT0srjkVhUtFrusfTww2ySPKz8wozyPPamoN9m6jGDAy76PIXxgzKH5W
         OK2g==
X-Forwarded-Encrypted: i=1; AJvYcCWK3z30Ik4F5Dj6xbdnb2VtozaZqS4XJSz/r7ZlDVFGzh4Fmj2kC9ibgRx+y9k4ZG0NvOa7ks7ifH0b+dZ7fNKd@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUCW4gZT8IyvnrSL5wjxm2gkLE+2cT8ADXXYek8oK+6Osh5bj
	vSZVjEWf7W8b1hhc2A0MRCtj5iq2kMJf5k7jx5GakI5/2+Tq93KKO8VDJXZYjhDIOs7GkvHTUmI
	klni5Pg==
X-Google-Smtp-Source: AGHT+IEaZf1v2yI9/Za5ZHqS0DAFR3/KKmYp+kS4oGJPHqjPKFClcc6w5G+qVcN+YOlSFNHhya0UY86aEUKp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:f:b0:6e3:6414:80c5 with SMTP id
 00721157ae682-6e9d87b4522mr10297b3.0.1729876998917; Fri, 25 Oct 2024 10:23:18
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:02 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 5/6] perf test: Address attr.py mypy error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ConfigParser existed in python2 but not in python3 causing mypy to
fail.
Whilst removing a python2 workaround remove reference to __future__.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/attr.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 3db9a7d78715..bfccc727d9b2 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-from __future__ import print_function
-
+import configparser
 import os
 import sys
 import glob
@@ -13,11 +12,6 @@ import re
 import shutil
 import subprocess
 
-try:
-    import configparser
-except ImportError:
-    import ConfigParser as configparser
-
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
     a_list = a.split('|')
-- 
2.47.0.163.g1226f6d8fa-goog

