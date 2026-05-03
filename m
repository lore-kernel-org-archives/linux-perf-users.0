Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2922F74A
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828245; cv=none; b=OdcpCZyWiaghB7VxzBByrhdy0qZXJdIKTyHd5k7Oz+fSkGswtBoy3jI6UBERz7IhcYS9QavaJCE3PlC+Fk3eN0kuqgY8hDmIXv7TMwfeHk5uA62RjmF2/28CTTh/oZ7zWRh1fTP49CY59Pf7uUaUinHvtg3nmO/Kcso25shaEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828245; c=relaxed/simple;
	bh=+y+XoSJ2H50k21P/clhLk2ZQ4f0vhD5k5M3eLocD7qY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIlqDnYADq+0MnjYrpKJVxpp2i/+fdl2gm2Ozs6Ukc79NSW22n06HoottDrzF5KG7mDX8Cqb3KKbJlyhid9j4DpRwB27yqCaurUKnlS5LPyvzuORzX+8tHxClmt80Bk4vOOUOGG1Om9tfj9Va+UAIT/fzxylMqmGJu5njCqouy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFLdWRKz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFLdWRKz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dc3d81736so2023763c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777828244; x=1778433044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZpnAeDqj38/YOqlUFsicrMJq8jdvEN081sZMPxMOo0=;
        b=RFLdWRKzTsOqtq2ParNWUlgg5psXZ8oveVo0UNM8dC7j5A7dT/HUVLCnpAMkKsQzL9
         h7KwPu3bhfvDWl8j7gUiWDe5NvGOJUa8owNchWkK6OT6+ImRBZhe8UMz8acO/4JXFkmY
         +CGwtRfxvRcjxvHKjaq9N1EYTOx+kC598iWmUilpJbyyYa15OX6RXy+0wsRZnxZv881+
         WGuR3erLQjKbbCYuIB39vgw0yjRn4ee6nKLP7k+F8/y7YKfXpAoTUEeQmRaUdoZyucfe
         rtNzFqCdNOtqiF35W/Ysry3H+DKjodYwDrxhwIVd26Es2Gk66jOrcOMuRRVwsIRCkWyV
         yyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777828244; x=1778433044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZpnAeDqj38/YOqlUFsicrMJq8jdvEN081sZMPxMOo0=;
        b=TrHRIGKr02INJCdZrj0PzIbrGgdhKMfZngCmz6agnrLHPvSYcmTBso66Ry09lDPfSp
         NouhgmgPGQGK74xN17uaLFCUarstIT4J/vMeU1ulHpeIJhqsk8/20FdCZy/+xrv9Vn1m
         BfgN6BKMusBG9hxlvOu1tIxJtVeSJgieFNpYxB8g1+UhcsuDiOB2HCNlJowX4634zWCe
         Gagi9WyZ3axeD7gcT5IIgB2Nbg0IoX8VenN6feTj87IFMadGsY1TpXpt3T4roNYfqDAS
         0y/hBIP2xRUaXrGPilgBvHRAJ+WqOkFokamoOBbhIdVD6Z1CcDbvffNRVBE9WUWproxJ
         3FSg==
X-Forwarded-Encrypted: i=1; AFNElJ8+a2mmsV/f0Pr4RoxNGYhz7W+DZXy6Gc3LIjhdyv9UrDToSpZOxspDgacK10VDUv8jL8X/lT2TRMOvTbHofrTQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfCzvJpk2mCo9fqjSNNM7W2SQB4P7Ye+NiAVXzU8NBelsk7uu
	ffciv/WtgyQnHiRn5sS/exYks8xuBR441dkU1Qx5jFcUCAUbBDe7qN+2s2iEsFyF3RYdQfOLG6u
	u9cXWlUT1Nw==
X-Received: from dlbur22-n1.prod.google.com ([2002:a05:7022:ea56:10b0:12a:c265:1a7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1b0e:b0:12a:72af:83d2
 with SMTP id a92af1059eb24-12dfd7c3c48mr2612525c88.14.1777828243425; Sun, 03
 May 2026 10:10:43 -0700 (PDT)
Date: Sun,  3 May 2026 10:10:26 -0700
In-Reply-To: <20260503003552.1063540-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503003552.1063540-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503171032.1559338-1-irogers@google.com>
Subject: [PATCH v4 0/6] perf DWARF: Fix libdw API contract violations and crashes
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

In v4, the series has been thoroughly hardened based on review
feedback for v3, fixing latent bugs and improving unwinding/search
robustness:

 - **Memory/FD Leak Fixes**: Fixed file descriptor leaks in
     `debuginfo` offline init paths, and memory leaks when `strdup` or
     inlined list appends fail during callback walks.
 
 - **Callchain Robustness**: Fixed `ORDER_CALLER` update bugs to
     prevent inline callchain corruption when nest depth >
     2. Re-implemented `die_get_data_member_location` helper with
     `dwarf_attr_integrate` to safely parse location expression
     offsets for inherited properties (specifications/origins).
 
 - **Search Robustness**: Relaxed strict `dwarf_getfuncs` error aborts
     in `probe-finder` and `line-range` loops to allow skipping
     individual corrupted CUs instead of prematurely stopping searches
     entirely. Added DWARF line 0 reference support.
 
 - **Safe DWARF Printing**: Switched to the `die_name()` safe printing
     helper globally to prevent `vfprintf(NULL)` undefined
     behavior/crashes when DWARF entities (like anonymous structs or
     tail calls) lack names.

v4:
 - Localized and squashed robust error handling, memory/FD cleanup
   paths, and safe DWARF printing.

v3:
 - Minor formatting fixes.
https://lore.kernel.org/linux-perf-users/20260503003552.1063540-1-irogers@google.com/

v2:
https://lore.kernel.org/lkml/20260502155656.478642-1-irogers@google.com/

v1:
https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-irogers@google.com/

Ian Rogers (6):
  perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
  perf dwarf-aux: Fix libdw API contract violations
  perf libdw: Fix libdw API contract violations
  perf probe-finder: Fix libdw API contract violations
  perf annotate-data: Fix libdw API contract violations
  perf debuginfo: Fix libdw API contract violations

 tools/perf/util/annotate-data.c |  27 +++++---
 tools/perf/util/debuginfo.c     |   9 ++-
 tools/perf/util/dwarf-aux.c     |  39 ++++++------
 tools/perf/util/dwarf-aux.h     |   5 ++
 tools/perf/util/libdw.c         |  84 ++++++++++++++++++++-----
 tools/perf/util/probe-finder.c  | 105 +++++++++++++++++++++-----------
 tools/perf/util/srcline.c       |   9 ++-
 tools/perf/util/srcline.h       |   1 +
 8 files changed, 191 insertions(+), 88 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

