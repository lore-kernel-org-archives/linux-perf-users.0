Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6D53C3AE
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663196; cv=none; b=h+H5ZaB1nmyvqX0X1IhM/Cx3+4jW1p1uNSBYScUvRb/kDFScD/eLZz6LkJqe8xg7vkg962sIvtLxtVT/CH+OcryZjRtfD+tKwweF/tcPJ6iB2PD08GVwNesqJioCra+Rj+Sl4XG0Es65nYDSZoQV12e7Ghk3a88QywRXb+hcm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663196; c=relaxed/simple;
	bh=Ndq3XZzi/EfqSQhUKNfVgunzhKMGpjb6wAnuZVaabKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7fRdy+5kTdKdL9zlCEP4M7uywyHJSVBqnWhuLk2yIBL2Q0gC5Dn8tJRH2czB8PCc+eRPG/hwTYFWyfSJBwsE9ma+LaV/VOELP1NfOtuiYRGzTVfd8JPSNflNitVXlBGyJZsrQuMwvEQy3CxwkBNa2/np6hfx14w8wJzbgoDKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHzX9xhV; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHzX9xhV"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1365802a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663194; x=1790267994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=RHzX9xhVNHNVX2s++iFVt+KvQuAy8OPdlerN5GJ0jjH/g0VQzcoGxRHDiqwTZwXaRW
         Fo6284tKyjgicCQy75wlEm38mlcOi6XdOQgrRkQL9WQ5y9rWXFZ7Ioa3ilvYXKliah5Y
         5ylI8ojZoLk67lyiLcfCGBlaYslBgSfh0ova+xXt4HqQsyrLLRvznQP1gF5SOhL1mByQ
         9Br4zpPtXammQVpx31S+JRiPdnhi5Uecnul5NOK710BtYYB7TpwXbA03eu4ihG6ETqhg
         jHfAje26p9svQwMnmihPgTGzK+X0t6HmdxFl8sOzJHgYrhsnCbbrZbEodhRvaBT4GyyV
         61+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663194; x=1790267994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtkpF+2hXoqnckm+Z523eWfhpUjaBTRb2bRSM1mpO+k=;
        b=UQSQZOnguZG7fMwOTWZwqMIQHCVkaeUakolGr3OJudWzFPoe39V3rklsBaNJmMypbx
         MOA5kf904toUCW50qXLlwyeiqn1IB/oC04QQU9f5dgrkW0Zbn6mIKXw+k/7DoVfxDnYh
         jkQ8xNith8s4LvptErKBVwYQg+f3zep1zANd6AvroPa8L/kZK1zfZCGnabiaNbmtxPFb
         wt1ZkRT8hqyxbRpXWpaGjI7qVYla/eIragQLVkVsVtVXefnOfUwENwqkuwG5YUI1tpU+
         sVP3Xi9wCK/gXkaW/NpP1lfRUeRod8Tp0JZTt0ucysqV5fQVGwOgAP/MP2GW8YULgIMO
         OQyA==
X-Forwarded-Encrypted: i=1; AKwUvBxcm99DCR6G+L1yZgOZdAjipiwKKHa9445JIv+G4bZZlvP7hhGEkvg1TPiL4Muq08MicKxWNiLVj56pJZyl6ZrQ@vger.kernel.org
X-Gm-Message-State: AFuF++k9nmB6QfJAscwQxUYIMWFwFL7c9gz95jXvl6s6frajqXwYjbzZ
	46HnH/My/RxJzPyPtdKEHztqnOjKKTVDEZo2JsnToGHA7njqtV6QKZptp3RpejCGQlu60RCnqmD
	xe7FYhroczg==
X-Received: from dybpl11.prod.google.com ([2002:a05:7301:430b:b0:339:75cd:ba34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b83:b0:39d:f7dc:61e4
 with SMTP id 98e67ed59e1d1-39e1e2f52eemr15685508a91.9.1789663193870; Thu, 17
 Sep 2026 09:39:53 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:39:02 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <5a3d268b240f34ac4ac230a630c641471a333bbf.1789662556.git.irogers@google.com>
Subject: [PATCH v2 14/14] perf test uprobe_from_different_cu: Scope probe name
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

