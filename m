Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA43803E1
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570116; cv=none; b=uW7A2cBUbizongVzQ0FBHOnHjLTgE8LhWTaVcxpCqJtSS66GWvHexpDSWvgj0eF0zQmsj3iUFUgK1VjVa0i7SuyLzwjRcg0hUdNH5HEOvnFCPEz+ObPrnj6DK7JT2Cr+e1trD3LVYI66wMAUJnYdlzLo/2ulA465fXR4UBi+120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570116; c=relaxed/simple;
	bh=yjB7ri51sRv8a67LTV4PcAIOS6YMv6zzhISrqstsl6s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Ta7+tQaGeIaVjgPruRxolTNqW5ZQV9HbFsto03qw67v5gPt6HDcstsOgrDCCPzWHKDn+2LvWR+0ASJU+AksYn17jt7YKWWI7THFwh8QTalUVObHgw1zEVnNJG3FF7EbyFIuz1tr7Vn7H2lubo+oK5mlmUQ6z149CwFSVvS49oRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quzWoZ8m; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quzWoZ8m"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso6737333a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784570112; x=1785174912; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0dzLHwHhvSPdtzi9CiI47Fmz7JMUGgBi8NSrYJQVh48=;
        b=quzWoZ8mP1m4VUGjEIR/hkl7+XYsAORNh+zFTamWwgciTyw8dqlaF002rGB6itskJp
         GRHBFPlv6HQJX+yjrtcIguWgibxoIzHdoQeoXDYBQiTwdNKqG784wwM3hsqs+nWzODT+
         d8SSUxmgz9eIPgYQPhl7/ATnqn9122TqBT98w2OKUgWbJDAo8eNfbpmRmrqJmosoPllZ
         ZGIS8WzjSonC+Bu7So7HtKZO2S3Et7SmL+TY5oghp+7LF7bWEsR2THYeCgL0Rr13OP5l
         suOLRiILdcGss9szrV0pVQ9LIPBDC+eObOhmyDm+RVHSl021FK/gVE3JlxxZZhEdyy5f
         2eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570112; x=1785174912;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0dzLHwHhvSPdtzi9CiI47Fmz7JMUGgBi8NSrYJQVh48=;
        b=fC7gUPEiddW9ekyaIqDHHE/jZWx+oka+CnDnHmRU4rKnYYpVxrT+5WlKuF+su8Xov1
         MIyZ81rzUL5ROgMUbFBxXOoPCfuFrt30ePO3E+UdS4TGKyBYSxfktjwiP5bbNS6zFpb4
         EwNdA9h/EnAiocT6gwEzpPlcjSCNm+BaJ0A/O/dFRqISAAyHrI+HQ9OvhjLdUO0rRSmk
         Eh8eeguWbarg2f+JXn9DLsYQdhirb5lV/1hEauKYNh3Ei9zLfBETj06aaOC+kRwofxV2
         xmW4H0jDRdNoNMJ7HvWDIhcIePj6lgFsucG7n4GAqUNAxXkxm3X63PffqLOiK19XGO92
         cWUg==
X-Forwarded-Encrypted: i=1; AHgh+RrzDSsgGPNxIlNbJNcOyf4HqhkP2zAiZ+0eOERC1C2vJCMt0DUKm3Vt/vyJAb0puQ26MD4T3pogTN/UJvdWFqCR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ALWHgSWxdegmqOD6WdUdFeTQqJzXS3PyZP+Zzf1nF2LsT4HL
	zSv7qBKP6b9eRx1sb9HbtsyAKXWcmZ7uysUR5CcRjHKDpTD/tgnyK7AZG2HimLs0I5YvwfL6CjF
	twBPy1uspqg==
X-Received: from dlak16.prod.google.com ([2002:a05:701b:2910:b0:13b:9a32:b2d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f8f:b0:36d:689a:cb27
 with SMTP id 98e67ed59e1d1-38e4b538f90mr15448710a91.24.1784570111397; Mon, 20
 Jul 2026 10:55:11 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:54:51 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720175455.3645946-1-irogers@google.com>
Subject: [PATCH v1 0/4] perf: Fix and optimize maps parsing, boundaries, and
 bounds safety
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It turns out that PATH_MAX is respected by system calls but isn't
respected by file paths in /proc/pid/maps and /proc/pid/smaps. In the
kernel "//toolong" is placed in the filename of mmap/mmap2 events
where the filename is longer than PATH_MAX, do the same in the
mmap/mmap2 synthesis code to avoid overrunning the event buffer. With
Gemini's help try to address other correctness and overrun issues.

Ian Rogers (4):
  perf find-map: Remove PATH_MAX 128-byte stack array restriction
  perf synthetic-events: Fix line synchronization, bounds, and
    truncation bugs in proc maps reader
  perf synthetic-events: Fix bounds, stale state, and misc flags in
    kernel module synthesis
  perf synthetic-events: Fix bounds and union member access in mmap2
    build_id synthesis

 tools/perf/util/find-map.c         |  11 +-
 tools/perf/util/synthetic-events.c | 271 ++++++++++++++++++++---------
 2 files changed, 196 insertions(+), 86 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

