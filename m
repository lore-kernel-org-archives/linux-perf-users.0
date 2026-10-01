Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6D43E4BB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833291; cv=none; b=WozJWQVdiet+Hv7y5aa6d+VqY6cxKUYebv3+beA/UxzqrsDr1bHSdVF8SZhkLCtijuczDQ6wJDUnYanYrflzOGxeRPzrWHA9cRJYCJSf2LEj+1DuKecdi6kmqNZmbRL+R2ZgxYnWC1AIMXsx/EUXfzlLcRGzvEc4Uc/HWAgI3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833291; c=relaxed/simple;
	bh=sstgEXSFn/y+E7lEpfJqi2b/iKW5a75TSesEOfWmKqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r4mbUg2OeoO2t2olsaDgT8aP7iJP3UOnsRr3qlI5HUtLHyxQ+NOeGO3N4npxwJPea9uPkGKQiuR9k4EorXho1W71wXBktmIKnOA8LPpaYOytWIJ5m5oCn7slKTBLEtsw7A7It+iiPEbo8MsAp6V/+Bc6+9QW4OEHNH02XgSJqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBzSKdpO; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBzSKdpO"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14318be7d79so2550675c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790833288; x=1791438088; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpd3X3DRhauoImJT/i9YGSWB1evMCCVDDfsnm9T7Z/8=;
        b=BBzSKdpOLo0N0xOiw7xKqGso7NeFs6NJOCWcLoz//u3MGCI2RSyraB54xOhxkYhEpQ
         +/B86sgsFy8u7NAf9HZ3uDhsCwV7GbkcKWyDHZk9Sw7Nu08sVgY92PpqVt6JimuHRFmn
         zEIlqqq+DazaEByIXAMycXV/3vu4S6Wai0g1ylKnQn0BWbWAjttL1AivvICJ8+qdGvgQ
         HYAgpG4avFie3icJ6JxTsCzE0aRFkFRtGOOHGk6darx//7YG7NX011RlYysJrXF3Ulxy
         IV0lB7qfRBskSRdHzid9LkFxY0htOWpIzyjGDT7iu8PRxKsXlT0AcqnBKkczFZVk1tdY
         p+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833288; x=1791438088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpd3X3DRhauoImJT/i9YGSWB1evMCCVDDfsnm9T7Z/8=;
        b=eXSmGsD5GIg3W7t8jB/j4N3ZK333iVn7vvBsBpvdoYQqQm2Cz3p2+i1pWBIDkggrRG
         TuGlkw3pPj2rb+60/socKzENdvo5ay5cmMuU5EmvEy7UVf5/j60QUNhwajjgGjUic9vy
         /jwLfZ9DqgGPlO8wlVgRKBBotPGgK0ANJ1kwI/h2u3Ai1XPkVnkaiqp33QJZpUbFNyOv
         b/KTR0hO7ll6F8d5ifNrnsxC9OLFkwVxn8gsqW92sogKfNzXl57RSmWgNJVEw5HHGmpk
         apipc/z2HdJfdAovz9oy6Cvy3T4V1uJ7V85EPN6ss9sk8OWFOLSpbVSu7kKvu7EwPmHw
         /o2w==
X-Forwarded-Encrypted: i=1; AKwUvByH8ddlIt22ka9B5+2DABDVmniU1+w11jKX0avwuURq8ItzfmEoVUUsCt7QOSAUGjPGcsF+uz28MNWM+0oUl9EV@vger.kernel.org
X-Gm-Message-State: AFuF++kQgc63ddN3BCk95/JN3ysTy34Knia01IOlKdns+T+E5SmVtK2+
	9j4JRP0bGMS/h5naweVkxJAIFnQgelzhkeDi4LyXAZdeijO0rms3i8lTWTPazzAxa+AKiqeGmtI
	DO15e29Iz4A==
X-Received: from dlg7.prod.google.com ([2002:a05:7022:787:b0:14e:12ff:7c1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2505:b0:146:606e:2117
 with SMTP id a92af1059eb24-14d2f7e6e77mr4141934c88.5.1790833287738; Wed, 30
 Sep 2026 22:41:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:41:17 -0700
In-Reply-To: <20261001054120.1570943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001023423.1225713-1-irogers@google.com> <20261001054120.1570943-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001054120.1570943-2-irogers@google.com>
Subject: [PATCH v2 1/4] perf test: Update attr.py to use argparse
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, leo.yan@arm.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

optparse is deprecated since Python 3.2 and triggers a pylint
deprecated-module warning on newer versions of pylint. Replace
optparse.OptionParser in tools/perf/tests/shell/lib/attr.py with
argparse.ArgumentParser.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/attr.py | 37 +++++++++++-------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 7f3d5b64b00d..68f06df9565a 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -4,7 +4,7 @@ import configparser
 import os
 import sys
 import glob
-import optparse
+import argparse
 import platform
 import tempfile
 import logging
@@ -426,29 +426,20 @@ def setup_log(verbose):
     ch.setFormatter(formatter)
     log.addHandler(ch)
 
-USAGE = '''%s [OPTIONS]
-  -d dir  # tests dir
-  -p path # perf binary
-  -t test # single test
-  -v      # verbose level
-''' % sys.argv[0]
-
 def main():
-    parser = optparse.OptionParser(usage=USAGE)
-
-    parser.add_option("-t", "--test",
-                      action="store", type="string", dest="test")
-    parser.add_option("-d", "--test-dir",
-                      action="store", type="string", dest="test_dir")
-    parser.add_option("-p", "--perf",
-                      action="store", type="string", dest="perf")
-    parser.add_option("-v", "--verbose",
-                      default=0, action="count", dest="verbose")
-
-    options, args = parser.parse_args()
-    if args:
-        parser.error('FAILED wrong arguments %s' %  ' '.join(args))
-        return -1
+    parser = argparse.ArgumentParser()
+
+    parser.add_argument("-t", "--test",
+                        action="store", dest="test", help="single test")
+    parser.add_argument("-d", "--test-dir",
+                        action="store", dest="test_dir", help="tests dir")
+    parser.add_argument("-p", "--perf",
+                        action="store", dest="perf", help="perf binary")
+    parser.add_argument("-v", "--verbose",
+                        default=0, action="count", dest="verbose",
+                        help="verbose level")
+
+    options = parser.parse_args()
 
     setup_log(options.verbose)
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

