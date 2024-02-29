Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BA36135
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188382; cv=none; b=b8KxfudC6ZhfMkMZet4zuA8cWg/ZEM8HOpdHsbprMjwQkAYgYMNANcmTECKwd2RxGraSteQq4KSbBaAE/U2U0S+p9Y8O+BHCgWJjOP3oXlw5gyp0uFhDpfBsiNiPx/8EdXGkXRSB7JGU7gSlCBccBM49BWNH4T+QEUtExoDvfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188382; c=relaxed/simple;
	bh=dFZ2GSzmiKOQGB2rUKRoS+qE2/AFOzCta5z98wxR/38=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rFajXaUJChfFEd02HGUr4w5AzhLWj6S8Hs8VEG7Y0AHnP7A3a9fY3FXkqvedRL/OEE1lAhjzbeAiXLYKv7j10kXKMxbJS6tT1xPhSh2C34nPmHbPTOK72XQ5wPycUb4+cxlcM1UJ5twGQ5htVkc5QnYAQce2UDvSnQdw8O9scEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuJxVrNt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuJxVrNt"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso1186009276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709188380; x=1709793180; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FMG+g1RkoAeOPaJke1hkXlYl72J+qtVpVOKOhfjNYSk=;
        b=CuJxVrNt32UxA02WYQ5u5YLcpxiLfLpq239ASU4EmQgY4IWpoN198ncgK3Tu5y4xLR
         Ei8yONrgOqh8K5tegakx9UuLVZRNjMAXlCKA+kaO+l/Ap1chVMIh3d34pqyqBGB3VWgn
         PN87IKeaVe3cq5geSgXgy4LkaTQ1DP0MjiWhVeefbSLfKN3a8wvTIeRNLsRUmlc1lMox
         KRLt1GzKjmQXQVkQzyFW9pBbgp8liNJShsRq7/CBUllEwoLYHXebFCvW/BMEVpgXEIOH
         EnV5KAf9xzVuPJ79aJTCjwE1VmxDO2SAX0vLXj9cKsbNguO5279z2HF+FwbE6/oYoF6h
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188380; x=1709793180;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMG+g1RkoAeOPaJke1hkXlYl72J+qtVpVOKOhfjNYSk=;
        b=d9Rf7yBwzTgdu5n/qL1FOprec8TZ9+7uVbZcRebJ/zA/i/DdqvVm1QAnkkaa3VJAeH
         u+MDqWcYUJPaG1chSxDSjJSQXEtdKVfZVJQEnu4Ic/39XnwDG4iYfer3Kn3jX/XqoBcN
         ar7bVj9F96W7T+DvcY8YPNROOjSoNCD7Z+8M1Js08Q4MmM9j57iOROAKKYJ+iZ8OldxY
         OYZGz3heJotqzmQxqFuTGuVA/wp8k/kVN2kMFsmJU2pZHFMHhZDN3cjeNcS05SyV7R3/
         A/8OGuNbGYzW5QVGplW//8d14+0DRjdI9OV0oQvjaZo1oXgCgGmk2QBsvVIwYI0PPVZY
         CHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlSwT8mpo4vOCQottJtcE0hQ8sC9O/QX5MCNdDesMrsZpGj2Z9oCxJax3OWxjCjMpdnEtzWwDqPSKQgAiV6gOKGFVwM6GfZUNiIH4e0MsvRA==
X-Gm-Message-State: AOJu0Yz/QEXSEqbolkqko6L8lPuLHI8z+IotRsbVjuivcLL45ecEXJjN
	VLKzrUznHBINMHnbk/IBB29yQTp8dW53IP6Id1HWBz7QbL5iiCKpMoIgJTDHZ5RdnbFcWVfIIB+
	tBUPcGg==
X-Google-Smtp-Source: AGHT+IF7rj4lUoHEesPzPUsnC4lJMMcXYg7gdHw2rz+BXHrmFkj7JWeUq42USj3bBpAEhwaiJ1Gz8ldQnGer
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:abc5:0:b0:dc6:eea0:1578 with SMTP id
 v63-20020a25abc5000000b00dc6eea01578mr346976ybi.13.1709188380051; Wed, 28 Feb
 2024 22:33:00 -0800 (PST)
Date: Wed, 28 Feb 2024 22:32:46 -0800
Message-Id: <20240229063253.561838-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 0/7] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches (now 7) from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
now the initial maps fixes have landed:
https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/

Separate out and reimplement threads to use a hashmap for lower memory
consumption and faster look up. The fixes a regression in memory usage
where reference count checking switched to using non-invasive tree
nodes.  Reduce threads default size by 32 times and improve locking
discipline. Also, fix regressions where tids had become unordered to
make `perf report --tasks` and `perf trace --summary` output easier to
read.

v3. Factor threads out of machine in 1 patch, then move threads
    functions in a second.
v2: improve comments and a commit message.

Ian Rogers (7):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf machine: Move machine's threads into its own abstraction
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 217 +++++++++-------
 tools/perf/builtin-trace.c            |  41 ++--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   4 +-
 tools/perf/util/machine.c             | 341 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 186 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 474 insertions(+), 394 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.44.0.278.ge034bb2e1d-goog

