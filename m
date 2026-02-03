Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420A214204
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098963; cv=none; b=GuP/OhpatRsBVFfoBTIwJePwN9CsL8Cptzw8fsg/9Qjvi/xGjtdOvWDiiDLfB3roLRmuWu5DbpiHYoRMzpfkPelpVFIk8hkNgtkqgB8SAXHlzU7Esq41CAJ2vQi4o/WWaqH7bg75d78/l954dSYyZs6ctnst1qhE+qpuwrZ7vVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098963; c=relaxed/simple;
	bh=jSfnoCnzLXrW68gVDdcrx18At7c4NufTA7M7mgDXxek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=IjLKCD5BscSm39KfaZUszaMOPFnSd8x7zOoudtVkKR6jD/SAp+9xMx6/rysOdBRCzAsbScSgTFm38udu4H6gPZNMTWQAXTdS5CBqQ9mTcQMkzM57cNxlDLG1VCi/F5qABt1RbhIFwL8dcDK1ZfCv0YpNXF1v6xj0JSveYUbmPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ul2o3B/p; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ul2o3B/p"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b94abc09dso7899692c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Feb 2026 22:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770098962; x=1770703762; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7XJWEI6627pGRvY2rwUuLOXp2BZneyQzwXYXx4SgrrA=;
        b=Ul2o3B/p6n1y7b45RdfFp//Tsl0OBqSrUOJfVac0dksJBN8MRLtOl5zlV9epYMEWEe
         JnHS6xFBJx9OcgknO9TQJ4hH+tDaIqCNc/DoquJVqyGQRfPU+H483kOz8VclZroU0LSa
         Am4opIvINuGdThUcfkiph5i9gxwKqkD305c5D56qcjAZW5deCgYH6BuOIunvHVc5O4vg
         CRjcpawJGSxXgZzebI3fhaav+CDMIiEDKol59Y8YdG1Eob+OEH3q0rCcOylv93uzxNK1
         znEcwaHVMhaQcGQNDb9Q3ZiSy0GMgixAajAzn2Z1fVjNr09A2wSZ+dRV0CCOxNx6Vjil
         suZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770098962; x=1770703762;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XJWEI6627pGRvY2rwUuLOXp2BZneyQzwXYXx4SgrrA=;
        b=WVbXvL3DtJvY/ICZtQ+EhteKojml31jwTOnjqEs2ha7vLSH8q4KtK88RMYR/muCqk2
         Q/F7qP4ubW6gJmWnAl7cZ6qr0y/4YgVA775Qck84sqjq/s/FnjoYJ0TVhuJHVl0BYE4u
         YdqjHRFBs9lVXuIsiTt2L11Q8yAXEO5XEQmnLBOYdZ8IYslGbGVeIUeMjBaebuRZtMQ8
         x2ztjJ8YKn7wvfLgFl+lTLfTxqyOe/SD2XKudb5ReFo1X/xzBI4LSmFBSEQ0je9X8hxO
         wXWWoZxq44oEUpn8TDzo+biulJwARHq4MuXIOzLjD6Cekv9gMLDSJusLE9ZQOy7DdJas
         GfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5gdCrHCY1H09ccHlwy65Hs2dML2C0ERkJS1rDvbJf/9+VgHrLfd43QI2idn0hj0lD29wT7//1F0TCkYfSkTsX@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeDq+Bqq7SBVirMSMiMmPmxssVt0QtdmUBZ0o+LZDht0TFDl0
	nd4IuAXno5UMIxm6KJvURZs9YOLCe/MstC7jmCnNFL4zdKQ8ja7Jha43rLTYQn52RW5bZhbxrrM
	BhtwCSqpr0g==
X-Received: from dlj30.prod.google.com ([2002:a05:7022:51e:b0:119:78ff:fe10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:602:b0:122:2f4:b251
 with SMTP id a92af1059eb24-125c0fb4ad8mr6580986c88.21.1770098961549; Mon, 02
 Feb 2026 22:09:21 -0800 (PST)
Date: Mon,  2 Feb 2026 22:09:18 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203060918.3137059-1-irogers@google.com>
Subject: [PATCH v1] libperf build: Always place libperf includes first
From: Ian Rogers <irogers@google.com>
To: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When building tools/perf the CFLAGS can contain a directory for the
installed headers. As the headers may be being installed while
building libperf.a this can cause headers to be partially installed
and found in the include path while building an object file for
libperf.a. The installed header may reference other installed headers
that are missing given the partial nature of the install and then the
build fails with a missing header file. Avoid this by ensuring the
libperf source headers are always first in the CFLAGS.

Fixes: 314350491810 ("libperf: Make libperf.a part of the perf build")
Signed-off-by: Ian Rogers <irogers@google.com>
---
I started seeing these build failures in build-test post
commit c3030995f23b ("perf sched stats: Add record and rawdump support")
which increased the number of libperf header files and their
dependencies. It isn't correct that this patch fixes that patch, the
problem has existed as long as libperf which is why a much earlier
commit is in the Fixes tag.
---
 tools/lib/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 9692d0742ed0..32301a1d8f0c 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -50,9 +50,9 @@ INCLUDES = \
 -I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
+override CFLAGS := $(INCLUDES) $(CFLAGS)
 override CFLAGS += -g -Werror -Wall
 override CFLAGS += -fPIC
-override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += $(EXTRA_CFLAGS)
-- 
2.53.0.rc1.225.gd81095ad13-goog

