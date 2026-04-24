Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104063E639E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049319; cv=none; b=MeATvicDJ/aKkpxVdfj8BF+gp2QGzWEnb9JVWY3JYz0sbwIWW5AiTQijvwjDBFUBu+6r335DZqtMHGbMZ5MRUVy329A0qfOp0jhKFRixRuL9AvPULnCeMUsWpkgOz8p+ArSgDqdMxtEkENlKAI6AWkaxNwLjxScDsXaZuFNgcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049319; c=relaxed/simple;
	bh=SnKrcJxliFXo3tLE/HBbq9jytcjpkiJHYWCdfKfnVg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YQBqA7YLUG1ohzvA7YDxY3ZyPHHSoR90iv+rl4xthuUYJK3TLdtcIa3J1PaZYozHx2g2EZ9CduxSaoNwdQPxOJkzffhE2DnEC+wMwOADRyO5LSAkBftcQZ0b4JLOsS285aBvJhWxEqOWGY9tUM8jFqCpS9i1eYU2KbVnmM56EQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3F+hDhn; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3F+hDhn"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so29135568c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049317; x=1777654117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hOCLgpusdDNvj2grWCv+wASuKS65SLc2xpNZEUUXpk=;
        b=I3F+hDhnenype7YSFLTFEDxEafzKF49HdaynljokcCE8KL2FjTTVueIKp4W04LLmAW
         8agNBV0ypykEAPtJjt3iNsVSo3XxU7xnWActs4XmFSFnUZiighczgdTnqp/Ue5k904zi
         tiuEqOGkdNlnqyzPbs39cvvKkHkoXi0eAKdjSlL92uKNUGxhar0Hh0YPRfgVcrhrb2DU
         RytF09NXR/Ha8q1vBljwwj7VomFoF3rfZgdJvCfudj+rQRl7NuYOx2H5BCPylEHD3iJQ
         0QoyUu+bg52sF1xX0RItPA4U1IJ8BXUxl9Wro4YxLdSn03mgsyjUmH7iGGv0zkYfAW1x
         svNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049317; x=1777654117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hOCLgpusdDNvj2grWCv+wASuKS65SLc2xpNZEUUXpk=;
        b=QqTaM2TPX63JY+AHvIEMBQk3pxGDrO8vvql3fesTE5adCn+UUbBXCKq+qgEmgiMtpR
         ZpxCEzJwtgYShn1L5d5c8mJGGskO8PmIFFgKH8LIA3kksC5uvGd10uQwjd+DuMhOM+rg
         qvD5IV56dUFOj58fBJ2ikbXOaa3m1ziGa+1sY8GsZsoppNibUgiX7ThTc1kZvP64xtqR
         TX8X7dowkbQR3qqkDtHMeQkVUmFME+c1X9HbS0dBmH1OxYkQqAWdOYgqqGEsG8571AAH
         2izFqvlDVd6U+Y6f63mM09QEGNsb1HJI5s2HYiPlgDsTpAgRobAwXCmGuwm4/PUfWGJK
         upLA==
X-Forwarded-Encrypted: i=1; AFNElJ9tP3BJpJ5WIJ7rwSS2I7ta8sUNZf70TQrOG5PcHDnBoWfWntknsd2NS9DRd9fP79TgN15g4R9bSQ+gQqx/Pgm4@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEZByl4Co2hHDnXL3blvuO2JuE5RY0PHVx9VVnVIybEZRciao
	YraTksNBPEzCudPGk7FEK1FNWo/RWW6Rf+t/AD69BZ/Vf5uxd+Co3GsfuSyEBGeU1MSbenNiz5r
	VG+PdEUCjog==
X-Received: from dldoa8.prod.google.com ([2002:a05:701a:ca88:b0:12a:77b3:9893])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4199:b0:122:2f4:b24b
 with SMTP id a92af1059eb24-12c73f9bfebmr16411373c88.25.1777049316967; Fri, 24
 Apr 2026 09:48:36 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:46 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-25-irogers@google.com>
Subject: [PATCH v5 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

These scripts are standalone and not using the `perf script` libpython
support. Move to tools/perf/python in an effort to deprecate the
tools/perf/scripts/python support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Updated exported-sql-viewer.py : I updated the comments at the top
   of the script to use the new path
   tools/perf/python/exported-sql-viewer.py in the usage examples.

2. Fixed Test Path in script.sh : I updated the path in
   tools/perf/tests/shell/script.sh to point to the new location of
   parallel-perf.py at ../../python/parallel-perf.py .
---
 tools/perf/{scripts => }/python/exported-sql-viewer.py | 4 ++--
 tools/perf/{scripts => }/python/parallel-perf.py       | 0
 tools/perf/tests/shell/script.sh                       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/perf/{scripts => }/python/exported-sql-viewer.py (99%)
 rename tools/perf/{scripts => }/python/parallel-perf.py (100%)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/python/exported-sql-viewer.py
similarity index 99%
rename from tools/perf/scripts/python/exported-sql-viewer.py
rename to tools/perf/python/exported-sql-viewer.py
index e0b2e7268ef6..f3ac96ada1f5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/python/exported-sql-viewer.py
@@ -10,12 +10,12 @@
 # Following on from the example in the export scripts, a
 # call-graph can be displayed for the pt_example database like this:
 #
-#	python tools/perf/scripts/python/exported-sql-viewer.py pt_example
+#	python tools/perf/python/exported-sql-viewer.py pt_example
 #
 # Note that for PostgreSQL, this script supports connecting to remote databases
 # by setting hostname, port, username, password, and dbname e.g.
 #
-#	python tools/perf/scripts/python/exported-sql-viewer.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
+#	python tools/perf/python/exported-sql-viewer.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
 #
 # The result is a GUI window with a tree representing a context-sensitive
 # call-graph.  Expanding a couple of levels of the tree and adjusting column
diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/python/parallel-perf.py
similarity index 100%
rename from tools/perf/scripts/python/parallel-perf.py
rename to tools/perf/python/parallel-perf.py
diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 7007f1cdf761..2051c6e05569 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -76,7 +76,7 @@ test_parallel_perf()
 		err=2
 		return
 	fi
-	pp=$(dirname "$0")/../../scripts/python/parallel-perf.py
+	pp=$(dirname "$0")/../../python/parallel-perf.py
 	if [ ! -f "${pp}" ] ; then
 		echo "SKIP: parallel-perf.py script not found "
 		err=2
-- 
2.54.0.545.g6539524ca2-goog

