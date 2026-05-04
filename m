Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2237318B9C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882355; cv=none; b=IG0YCzSKb7ozvwm0wmMDTmlbzOWoH9Oc5wv0941Mr/hsNWjDsY2gUo1B2MCh0iit6CDno6+EZXuAHuYKA3R7pZfp/bE+gkEVtfu/EM7qs39olKB9F8VTaruDqoSlJn5IqDbmfV2BrgchKVzqcDGgcr30YyC1bWnUp0jodK34FVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882355; c=relaxed/simple;
	bh=qWejnIMm6SGpNgMAh2FmPG7YcywmGnAtRzccL89xZ6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=itsGHndIUXwsPp6CMrRG10FuPe7N1RnGuFgVDLKfwyD07RLfd8ra5sdHRDo3spIyheVyjwTfqoG7wJ4xRYWXAtA3ZcFjnpLr5ZntZf7BbOewlhKI4tyAH2olHUL/Hzf5D/Q4BSOmfDBP5ff2pagDOL1BL3xcpEdtbyKRA+WAqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aen9MNeM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aen9MNeM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4055so6371030c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882353; x=1778487153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=erij+Xqxc7AeSkn19u0cNMoeoEosbzTWZIDeVfWID9E=;
        b=aen9MNeMrbWJ5gBu3EYyMbf6PGpLYCjpCD+gMFwAbua6jHZCMPLke1WG9CQMKFwn21
         QAz/EEKcEEvoxKf5A6eJgKanigeegO+rOBYyAZEudzDGRmqO+zE3y5c0JmLEXw28sl/u
         10OQUyGpnuLtc5olREK3U6jct0DpUKrxu6QzowvDMfmHova9krsIcnY/OsfS/HOeSkKW
         jg6DSI1PzWdPBAe5WKP8FtGUG9L2UAdJ6ogda6WN1+AbvkDhVnZefLpKNKQdYxcy/tMa
         afUFsu1AbJYUr48OkSEAiNib8tE/SzHdaf0TbyzFl5JcRszPHjBRG5F/VeZZ5bloIqOE
         lzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882353; x=1778487153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erij+Xqxc7AeSkn19u0cNMoeoEosbzTWZIDeVfWID9E=;
        b=Fd6nmQYKcl4YsKQ+la9cjhRKzi1cKB4X+sqR3BbSAO6hB02Him3IJBRJvjYmEHbsyu
         DGxXnWTj89e82NJhglUsQlaCNGV7cI27YDJuZOcdqiKKVLbzRoPwtNLhpZ9wnrgHrJOH
         tKP9PbA4no/u8tONVLtjw5HOiOP42X4BSrEMh4ekEVu9pEWyGHW7Y1fJyvtAmRd87dUK
         hqF3pdCEhZI2L1YXRNRmZ0n0vdqBvbTZfexwrPzgH6X0oW213GiPExf9T7s+khbS/XQ5
         jZWy/yKm459K3msrrGaUSuVBN30t4XWjBeTahcbnliyJ4AEFUBlk6xu5bjWLh27tg1pU
         fl1A==
X-Forwarded-Encrypted: i=1; AFNElJ+WUjS5xAzZgquiW3uNY7UXUHiwFdBZldoVqiIYnp1pacjLxJeaJHAv0pMaOq/x5sskNp10spbwJaQ3SyhGSTrz@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsDDeMQQpHKhyzHP4Qm3yLDW7LUZ/cbF9t6wPwbES05mkFnbo
	4CoyyD9+oLPRwIVAnFc10JOI/TvXnFssNCSXqh3dDspPaOE3FnK21fkc24HSmxhL8ZL3szFpVNY
	CkS6qm6K4Sw==
X-Received: from dlbpn4.prod.google.com ([2002:a05:7022:5e04:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68aa:b0:12d:ed19:e6c3
 with SMTP id a92af1059eb24-12dfd843600mr3222555c88.28.1777882352462; Mon, 04
 May 2026 01:12:32 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:18 -0700
In-Reply-To: <20260503171032.1559338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-1-irogers@google.com>
Subject: [PATCH v5 0/9] [PATCH v5 0/9] perf DWARF: Fix libdw API contract
 violations and crashes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses a number of DWARF/libdw error-handling
bugs and contract violations, preventing several real Userspace
segmentation faults and memory/FD leaks.

In v5, the series has been extensively restructured and polished based on 
comprehensive review feedback on v4, focusing on history granularity, 
bisectability, and defensive styling:

 - **Commit Splitting for Review Granularity**: Split the previously large 
     libdw contract fix patch into 4 granular commits to cleanly isolate 
     independent improvements: introducing clear_frames refactoring, fixing 
     ORDER_CALLER parent update corruption, adding line 0 support, and 
     consolidating core contract/leak cleanups.
 
 - **Bisectability & Correctness Hardening**: 
     - Fixed an unused variable compilation failure (-Werror) in the split 
       history to guarantee perfect git bisectability.
     - Fixed a line 0 fallback regression to ensure that if an optional call 
       line is missing but the call file is valid, we fallback to line 0 
       to preserve the filename rather than discarding the caller info entirely.

 - **Style & Robustness Polish**:
     - Standardized all newly introduced C++ style (//) comments to 
       preferred C style (/* ... */) comments.
     - Implemented explicit safe string duplication style fix in annotate-data.
     - Corrected CU DIE propagation context inside probe-finder.
     - Enhanced the Patch 2 commit message to explicitly detail the removal 
       of strict optional attribute aborts (decf) to clarify review queries.

 - **Tags Collected**: Integrated Acked-by tags from Namhyung Kim for Patch 1 
     and Patch 9.

v5:
 - Restructured series from 6 to 9 patches by splitting the libdw commit.
 - Fixed compilation bisectability and DWARF line 0 filename preservation regressions.
 - Standardized comment styles and applied safe duplication formatting fixes.
 - Updated commit messages with detailed optional attribute justifications.

v4:
 - Localized and squashed robust error handling, memory/FD cleanup
   paths, and safe DWARF printing.
https://lore.kernel.org/linux-perf-users/20260503171032.1559338-1-irogers@google.com/

v3:
 - Minor formatting fixes.
https://lore.kernel.org/linux-perf-users/20260503003552.1063540-1-irogers@google.com/

v2:
https://lore.kernel.org/lkml/20260502155656.478642-1-irogers@google.com/

v1:
https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-irogers@google.com/

Ian Rogers (9):
  perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
  perf dwarf-aux: Fix libdw API contract violations
  perf srcline: Introduce inline_node__clear_frames()
  perf libdw: Fix callchain parent update in ORDER_CALLER mode
  perf libdw: Support DWARF line 0 in inline list
  perf libdw: Fix libdw API contract violations and memory leaks
  perf probe-finder: Fix libdw API contract violations
  perf annotate-data: Fix libdw API contract violations
  perf debuginfo: Fix libdw API contract violations

 tools/perf/util/annotate-data.c |  27 +++++----
 tools/perf/util/debuginfo.c     |   9 ++-
 tools/perf/util/dwarf-aux.c     |  39 ++++++------
 tools/perf/util/dwarf-aux.h     |   5 ++
 tools/perf/util/libdw.c         |  72 +++++++++++++++++-----
 tools/perf/util/probe-finder.c  | 102 ++++++++++++++++++++------------
 tools/perf/util/srcline.c       |   9 ++-
 tools/perf/util/srcline.h       |   1 +
 8 files changed, 179 insertions(+), 85 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

