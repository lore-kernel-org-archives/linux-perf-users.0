Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB050276C
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740462; cv=none; b=Kb075XrIRYw/7Ri/tKIOx1xyCELoA2n1yPQH3qtKBPuWfKp4bj4ZAvjCBVjzRHGIDn/pejW8QAvNbIK4eik+I2hqz554JR7ublxx4FTzZgD0K93Zb64Y+lVjf9PSyC0ctwtOggB7QLz4H+1IhO952jfz1ydPKRmOvNTlgZenb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740462; c=relaxed/simple;
	bh=Ndq3XZzi/EfqSQhUKNfVgunzhKMGpjb6wAnuZVaabKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PFFt/HkfBIiONI+bNlywvJQDP/LilLR9CuDnrDkDC/lnlA8s6/as08nUeseLSjgxYE2eo6cLVL2LuUTiRVhYiGSXfVaMfPLzeHOWfvUo0NY5Ymw/kN7x82M4nqa9c8zTVXSSe59A/pZkzfKt0CBZxi7wMsFy4O1PhGETn7xsJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEnT4zhd; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEnT4zhd"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so1212709a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740460; x=1790345260; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=JEnT4zhdVuaRpjqeQft6w+SkuBYStHDYKWjSbNt9nsm1YMLBnczIYBhMH+zN++TcHy
         p+PSvWFWat/4k84g5x+Fih6kixbFV/ITxYQPrO73vEc0Snt6mxLBOeDjzP6lIeweKK4Q
         HmmJgAAdwUTGXxNpxOvClj5K2autWMEQKqGHuz8+KJ3ADPKHQlSD33st9PKxYwhAiN3z
         3a2SUIEfzEeXTwbzc1M59133IPLvSyg/j6FWY2q86wvG0jhCzds2UwsMvlhCqom/thbT
         fjeSSlcxO3SJ43HJR+T/ieIERVP5kwqV7i00z/SQ8HHrWDUugp1NPjWssKpWPYjid3E/
         Xzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740460; x=1790345260;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=h/Ev5Itf+9xHmNPKEUimQqcIjHIr/InKL7n20deGHQkcf+5/gctYs5olNU1epM98wt
         blXC7RSwDGz3w2rudgCfv1tFz2Zmon/CKFlYCFoMw+SR3D7cqW4T30PEks6eE7Vi5N+C
         WWpDC/qZ/0MKHudUPZmuAWFolZkCNe5eSrlJoGo9L87wsCsBnbyk8ZWiF0bxoSFEYVIF
         yyM1YYlmn6c9ZM58GUsA8bIuDKnnUbvvVTJGcGXwC9yK9hvZEoQqAPgi01vAH+IHbGi5
         9eaolmq1KAsj0u2PS6sj92vwCqd7UD5fc84hzNRU6jUPrve+zmAhLYQYIBI5fs12WJYr
         ZGZg==
X-Forwarded-Encrypted: i=1; AKwUvBwgad1BHbu36wUT5S3sHRCglQwbLnXVaJkKLRv1a8dBfmB5tkI/SSZBvTptFuSOz/UzipCs4n4k0QzWh55GNaIz@vger.kernel.org
X-Gm-Message-State: AFuF++leetR61/0rD3ENQIPBIHWHJH/Xpr9hiiJdG1B4EXe9q2wZeBSi
	yT7TriMGnQY/ZMk2fPu+1IB4djh1ApL28BkY7tuServnVllhS04d3JUd181uNrAt94sV1QT9NRM
	xZZwuW1pZnQ==
X-Received: from dlam3-n1.prod.google.com ([2002:a05:701b:2083:10b0:144:cc99:5883])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28ce:b0:39e:6a80:dd9e
 with SMTP id 98e67ed59e1d1-39e6a810c6bmr61147a91.37.1789740460008; Fri, 18
 Sep 2026 07:07:40 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:59 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-17-irogers@google.com>
Subject: [PATCH v3 16/16] perf test uprobe_from_different_cu: Scope probe name
 to PID
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The test builds a binary in a per-run temporary directory and probes
its foo function. The directory name is unique, but perf probe derives
the event name from the probed function and the group name from the
binary's basename, so every run registers the same probe_testfile:foo
event.

Running the test concurrently with itself, as 'perf test -r3' does,
therefore fails in all but one of the runs with:

  Error: event "foo" already exists.
   Hint: Remove existing event by 'perf probe -d'

and a losing run's cleanup goes on to delete the winning run's probe
out from under it.

Name the event after the pid, foo_$$, so that parallel runs no longer
collide. This lets the test stay in the parallel pass rather than
having to be marked (exclusive).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/test_uprobe_from_different_cu.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 7adf9755d6de..47c99d93436b 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -18,12 +18,19 @@ fi
 
 temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
 
+# The name of the uprobe added and removed below. The probe is placed on
+# ${temp_dir}/testfile, but perf probe derives the event name from the probed
+# function and the group name from the binary's basename, so every run would
+# otherwise share one probe_testfile:foo event, and a concurrent run would
+# fail with 'event "foo" already exists'. Scope the event name to the pid.
+probe_name="foo_$$"
+
 cleanup()
 {
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo || true
+		perf probe -x ${temp_dir}/testfile -d ${probe_name} || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
@@ -84,6 +91,6 @@ gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
 gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
 
 perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
-perf probe -x ${temp_dir}/testfile foo
+perf probe -x ${temp_dir}/testfile ${probe_name}=foo
 
 cleanup
-- 
2.55.0.1082.g2b9226bbc0-goog

