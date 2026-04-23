Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7013BE630
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960733; cv=none; b=F2pwinwEjlmD6+P70/+xIY02YSOOzmwwpkqAuSs56EK8l0NJTFghCL81C7AElOXouX/bUWe++F6tll/TkqAFXbI60JRq5VQtwyXKO3i2Yh77c0+WLpPRaSCTmN06w+tJuibPTHlaRaq6tDMOTUEvlSSTfLwf3v1W0lWvs24BVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960733; c=relaxed/simple;
	bh=oLmids3gD6ifmfHzg0TAULp5F95WyDv/fq5Ld79iy3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abduC9hL+Q4rNsSYguP+gKVWhIwh85rBUGdyTE6JyZYfjl35EGYW+3ikWVeUpi5zGdCZZlOqEdaGMW767w5LKPpAZO3mLPBi/6g7lQ+h7HGygK6230RggZMQ/dcxwvR9SZi1eDlwox8pdbVpFkY/szZNBEoW6vxFsWOcfElKVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtPh/2RA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtPh/2RA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so4251059a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960731; x=1777565531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=51tv1kwvNNeUiUVUvoF/vpQTWzqFLeoxyYSybwf38qU=;
        b=NtPh/2RAeYkazFF9cVvdYbtUvb9IgoDCst8rHmCrsSghyyaZxEWT0UFzXneftD7VdM
         hhAQcj9pxrZo++0SDICc7BIfvuAX3653qEo/gmEFT3Yn/IHNK4SWqjmdhkIrGgGWtMBf
         Re2gZSJpoNU93JzgCNokv4/pqY0t3lGZ06A1aScosIQm1LLxNim/GQBOvjX6J9e1JwNH
         o5edBQuMXNMtc1uxSA83dvxj8tkcr3JPHvWC5Cg445DPWXJn8zhjouJTz1aD+i9cYaAV
         Ku/xeEg5Qrzh+aiKHf0rYXmIgJ0FA0qfbAb8qrZIPs7cqAaiBGolbVU8bPqX47s6KyX8
         kFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960731; x=1777565531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51tv1kwvNNeUiUVUvoF/vpQTWzqFLeoxyYSybwf38qU=;
        b=rOZQHPpZApO4vfqR0P1PEYzQNityN3YGReyehfsAVI1fMlNmpaxpWP10VYuEboJ995
         ghDWOKEPQhdFdEK1TE2jUvRnrIYzs84+XqfKzMUYO+VOzEMxP815jP7u0tXbg8K/COpp
         q/YJD9oZsYHiSCnIOIvnl3AvJAeCgRqSPE3cNVIS+0U8uKqqcdPnVE7oVbr0rSCizJyb
         BYlTKHuNzgufRFtd0LnLeUnz/SwGlJdcMjDu7pdM8AYl8JOahlzCDjV82ccVzZ7aVzld
         bgnbhhEqTWLrx3XGv5+5RNneZ4BAR28dOMyNkkq0vRrhu/T8CK7w5UTmT6qCJMKgF8MX
         JfOg==
X-Forwarded-Encrypted: i=1; AFNElJ8SiDsbKORHEB0OeUiv7gQhUu6VDeCVxBsstibRKh6rhC/RMAIndZySJg8CHzq8sAokigeLY0RlV1bPSzbj82pW@vger.kernel.org
X-Gm-Message-State: AOJu0YzRP4gMsCr8Q6yDk3iwfNTaHCITaJEBY85en7F1aAbS9FKQYMZI
	6DIOV04fcOqnPaJEQliQctIGjh+WEH+51Ui0gwmir3jWXxOrgSsjRqmfdavVKQQBzbPLsRP3w2w
	3z9seScdAzg==
X-Received: from pgcg6.prod.google.com ([2002:a05:6a02:146:b0:c79:5e23:6aa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938e:b0:39f:2af3:e8ee
 with SMTP id adf61e73a8af0-3a08ca73726mr23254564637.13.1776960730723; Thu, 23
 Apr 2026 09:12:10 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:10:05 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-59-irogers@google.com>
Subject: [PATCH v3 58/58] fixup! perf check-perf-trace: Port check-perf-trace
 to use python module
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

---
 tools/perf/python/check-perf-trace.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/check-perf-trace.py
index 4c05540bdc05..2e8a40306c78 100755
--- a/tools/perf/python/check-perf-trace.py
+++ b/tools/perf/python/check-perf-trace.py
@@ -49,9 +49,16 @@ def print_header(event_name: str, sample: perf.sample_event) -> None:
     """Prints common header for events."""
     secs = sample.sample_time // 1000000000
     nsecs = sample.sample_time % 1000000000
-    comm = session.process(sample.sample_pid).comm() if session else "[unknown]"
+    comm = "[unknown]"
+    if session:
+        try:
+            proc = session.process(sample.sample_tid)
+            if proc:
+                comm = proc.comm()
+        except (TypeError, AttributeError):
+            pass
     print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "
-          f"{sample.sample_pid:8} {comm:<20} ", end=' ')
+          f"{sample.sample_tid:8} {comm:<20} ", end=' ')
 
 def print_uncommon(sample: perf.sample_event) -> None:
     """Prints uncommon fields for tracepoints."""
-- 
2.54.0.rc2.533.g4f5dca5207-goog

