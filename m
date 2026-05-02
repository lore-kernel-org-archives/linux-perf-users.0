Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC337FF6F
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737441; cv=none; b=a+8WZd8puxZAjDASL7K+aA+0cTJ9sfiYadfwuizrkpQ/Lph1X7Rb97hvjH8gdG93JlODNuMaIwlm79ftzgjXQcwEZkrpgWmrn1GbuxEB/rpcEcZPLRGK5A7t/JyjnqjelTgacUUSk/dHPC1TMQKptk9EZpp1cZfeichGLkdkgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737441; c=relaxed/simple;
	bh=93ecjXkBy1vYbm6ooKh+//upj1elq+MRQvphDDnqr1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KrnybBqDxwex3Kbs9Iy1GsZgBetW9G/NKCbQEipnoffRol7DNw6pRwOcpcKuw2nEOM6MTzMjZutxLNLTqOF3/cwr7D5lQnJWZSMQEPNAwh34vZKoBKCesOpRgXi04fEqVJ7nGm3WIbqBYofZZRKec9RNdIKToFogcF3cRY/7EZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnkOu+Eh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnkOu+Eh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24a00d12cso30687465ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737440; x=1778342240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yssubBeeNHZhm6vpt8GtVdB0ZLvQj6TWW02S/Y3qd0=;
        b=DnkOu+Eh+1SSZgja7bHs4hr8ibzqLABKp6hHVN7R7g2JmL+LmHtvhRKeoFa4yE6iMR
         1RGkvGHfu8igWWeuSht1b0bvWYsLpNFNg2LrOqu/WF5iqB2l1Yuvuxj6AGJOSkRxB1cU
         yMdXfo2XM66Q6QFnF+JZbtLJDwfxo9OgAXvSeaNyxWmbb07WhbLVQATqaukU2vF2LTKY
         8dWHl9T62DMq6Rx6ClflzF/EDJpUjuhYuTmbTduSZU3/SEZBgWLMbR84hammTeoz88ME
         hH7J4k4aBYgzy/skc6WopBDUyca18vzkn5quSp1BzPGj1TUXTLHbCuTfWpzch28Sol79
         gmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737440; x=1778342240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yssubBeeNHZhm6vpt8GtVdB0ZLvQj6TWW02S/Y3qd0=;
        b=CMXYcv9MHzcjrSH1mpiMkRmt/bOKtuXQUSUT0tJtkk/Q21/iJ2XY7EAKvdPmLaYm9y
         vhIWQ4+s8okYRVFqMpLxcknzXX20xlmEbXaliBUhAhXgmIc1sYoolLbKDSLuoLuDaoOk
         QqwS9WQM1AkyxUEY4Cq2brjfFEU4s7ADVDCkH3SBUZ+DstUNNWcXN+USNQ7o8SYn3hWL
         tvh+CrN8c/EtUyNdbJmYpTG+KvB+qdg3+s2f4HOkXsHHzg/PcHh+XIzatd/ttzpH07ZI
         ViqEo4BmKZjxN8HggyIaVfNmNXMjpXPm7A3WC4iANvz08XJP89wocmMDbhWo+YZvVFGd
         ngrA==
X-Forwarded-Encrypted: i=1; AFNElJ8ahmB6Cwc8KJ2dtIk1YWITjXwa+0osKTKQgO/Xqerpnn86tqtQHAq/omsPG/aQ2V6/aVkZ8ocPCJEYCVXmuCvv@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlkUjNIkL15zHcFXuJVHb42IOCzXD6dGhVlrJtLPNQOQBDa6I
	wogiQCVCTIF7jeSNy8RpZ4FVSLFrDcX5XH6PriT/iom0/HHKcGzGWf/hUBgOLZ5VOqDGyn97V7L
	eZWeK06wTwQ==
X-Received: from pgea6.prod.google.com ([2002:a05:6a02:5386:b0:c79:76be:ec04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914d:b0:3a2:fbf9:d823
 with SMTP id adf61e73a8af0-3a7f1a1e008mr3695300637.8.1777737439785; Sat, 02
 May 2026 08:57:19 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:50 -0700
In-Reply-To: <20260502064839.282422-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-1-irogers@google.com>
Subject: [PATCH v2 0/6] perf DWARF: Fix libdw API contract violations and crashes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses a number of issues related to improper or
incomplete error handling when interacting with the `libdw` and
`libdwfl` APIs in the `perf` DWARF processing code.
                                                                                                 
The first patch fixes a real segmentation fault observed in `perf
kmem` (via `dwarf_child` and `dwarf_diename`) caused by
`dwarf_getfuncs` returning `-1` on error, which was not caught by the
previous `if (!dwarf_getfuncs(...))` check. This allowed uninitialized
stack memory to be returned and later dereferenced.
  
Following this discovery, a comprehensive audit of `libdw` API usage
was performed across `tools/perf/`. The remaining patches proactively
fix 28 additional instances of ignored return values or unchecked
pointers that could lead to similar uninitialized memory propagation,
crashes (e.g., via `strdup(NULL)` or `strcmp(NULL)`), or silent logic
failures.

v1:
https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-irogers@google.com/

Ian Rogers (6):
  perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
  perf dwarf-aux: Fix libdw API contract violations
  perf libdw: Fix libdw API contract violations
  perf probe-finder: Fix libdw API contract violations
  perf annotate-data: Fix libdw API contract violations
  perf debuginfo: Fix libdw API contract violations

 tools/perf/util/annotate-data.c | 17 ++++---
 tools/perf/util/debuginfo.c     |  5 +-
 tools/perf/util/dwarf-aux.c     | 41 ++++++++++------
 tools/perf/util/libdw.c         | 24 +++++++---
 tools/perf/util/probe-finder.c  | 84 ++++++++++++++++++++++-----------
 5 files changed, 113 insertions(+), 58 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

