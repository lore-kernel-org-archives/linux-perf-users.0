Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6ED30DD05
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621503; cv=none; b=qGuAlX/ml9hZOV/bAfFpicit91aHeIqmO9B1zkclBBlNt+1AKphj7/R0XUu0XN5Zj7QgVE//xjVRzEpDL9V7zx34JgFD22MH2F7qRIAZGSDGrXJbIKe58od7IBMKOEZyBVo7iTd7e07tLDyIbo2ETkxnE4bSgtfN+L/MB/pn75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621503; c=relaxed/simple;
	bh=RvnWt9zDI8U2yb4Plr1W40FEDhjQFFjz0st17QHRc2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FbzFm9OhRHc1r/F4SMfe2jXwEOZzIH0iUsC8aJhcpxrYppa/T9XRxkuWOnfg8F2uR4K/Qx1Rt5Zwvp6dEpyNfgA425E2nqPAN56b0rX4ScGTNIjEAK/fuyj6xR2hwJ6dymf1zc/8vThGz4UMf7YMQY9+1aMDStcPyNBfDP57wtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3ckb+kn; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3ckb+kn"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd1631d291so6656065ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621501; x=1790226301; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYiUM7OT8xFbtwcJQxaAQJAe59siRxUNLCVRDBpXMdk=;
        b=j3ckb+knuiaAcqeOI0bfT6FrUfsFL55MimfXpXfxKUbAq+ClG0M+hrVvz+S8ALj7Kr
         P+howbl+VoVkUwrXkrylaxlhOPpQOuSmKuburJdZzX3kWizi04FI7Egw/5vmTUo7hSl5
         bw32NuZ/hiEtIuFxXWfYdoxK0W2KAmkZuy3W6mm2qD7Q3K1kb8+FyFaQZyGIM5x2RFO9
         5clJBAyWP8CDd3uO2N3N6tBmpRk88W1yuzuyDkjNoyPdgjh3YXsjrhxpA0S919DrCj64
         V5nmEEuwE+2VcDVLv5fzYhmosir9DBgrfflkgHgdV+kfHXw38angcd9ZxN50epNHTvFC
         rdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621501; x=1790226301;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYiUM7OT8xFbtwcJQxaAQJAe59siRxUNLCVRDBpXMdk=;
        b=XYVEpHR5nHU/Yhkz5I3niFzI1QQqVX9DnDKM7kNYVGaf74ri0mrxznjdsbFrd1EB+O
         7HaAdG4ql/PFLwuW573PgBQX5N7JLaHep75rRog6eeVu6fAtZ78zQ/bhuOUgSPGYtOHj
         XMh70fYvN+PeptTnyK8WcEGDxzIO8Apy5UD09MnWBVVZ2TfLy21RCwA3jdmRurzxoozD
         V4cLKNASBEkuOjuCdSA3c6+A/IpSP6+O17FHfaLCaeIh66bn77JhBYPJBmukWtdHd2Ma
         6SKZoOWCuVAAcoO07wEag6q7y/Ohw7hleQpFp4mkbJdqv6uFGWUns19AKeNOAc0tDn3Y
         qT0w==
X-Forwarded-Encrypted: i=1; AKwUvBwsKlNQg6ZA7JnLktfapfwrVz4D0EAJQyp+aqk4gXuCXrFgAjwsjk4ehrv0kEsEg4lLYchUduAghDdzAjIQOPp7@vger.kernel.org
X-Gm-Message-State: AFuF++kj2hOuC4CnHZubtQaLeHX9ymYS9WcaSJhrxnvUe2SwThlhbS1a
	rnx+4NgkdxzOnQZp98gNsWaGv3I2+h0tm8z10yyUPJwGYzIWSs0poIqg1E6+9iiKFM8Oh4lHbWG
	fv6pQOc7VOA==
X-Received: from dly4-n2.prod.google.com ([2002:a05:701b:2044:20b0:143:80d3:9880])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f8c:b0:3c2:dcdd:a85a
 with SMTP id adf61e73a8af0-3dd5f5dd0a9mr14513913637.13.1789621501148; Wed, 16
 Sep 2026 22:05:01 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:04:47 -0700
In-Reply-To: <20260916234402.437113-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234402.437113-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050450.703018-1-irogers@google.com>
Subject: [PATCH v4 0/3] perf srcline: Fix addr2line cache and fallback bugs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Three fixes to source line resolution, all on the addr2line paths.

1) libdw is pointed at the wrong file. dso__libdw_dwfl() opens the Dwfl
   with the name of the file the samples came from, but when the debug
   information is in a separate file, symbol loading records that as the
   dso's symsrc filename and the Dwfl is left referring to a file with
   no DWARF in it.

2) The dso addr2line cache is shared between implementations. The libbfd
   reader caches a struct a2l_data and the command line fallback caches
   a struct child_process through the same pointer, so once a dso has
   fallen back from one to the other the cached object is read back as
   the wrong type.

3) libbfd only reports success when the caller asked for a file name.
   addr2inlines() doesn't, so srcline.c treats a resolved address as a
   failure and tries the next implementation, which appends its own
   frames to the ones libbfd already appended. Every frame that isn't
   inlined is then reported twice. This is the default when perf is
   built with libbfd but without libdw:

     $ perf record --call-graph dwarf -- perf test -w inlineloop 1
     $ perf script --fields +srcline
     ...
                 56051a99503a inlineloop+0x8a (perf)
         inlineloop.c:47
                 56051a99503a inlineloop+0x8a (perf)
         inlineloop.c:47
     ...

   With addr2line.style set to "libbfd,addr2line" so the fallback is
   taken, the script output for that workload drops from 288 lines to
   176, and each repeated frame goes from appearing 16 times to 8.

Changes in v4:
 - Patch 1: add the headers that are used, rather than relying on glibc
   including them for us, since these files are rearranging their
   includes anyway: <unistd.h> in addr2line.c for write(), <stdio.h> in
   srcline.c for asprintf(), and <unistd.h> and <limits.h> in
   unwind-libunwind.c for close() and PATH_MAX. These are all
   pre-existing omissions that musl libc builds would trip over.
 - Patch 2: drop the duplicate "dso.h" that the include reordering left
   behind in the alphabetical block of dso.c, as it is already included
   at the top of the file.

Changes in v3:
 - Patch 1: re-read dso__symsrc_filename() under dso__lock() in
   libbfd__addr2line() and cmd__addr2line() before initializing the
   addr2line cache. In v2, __get_srcline() fetched dso_name before the
   lock was acquired, leaving a TOCTOU window where another thread
   calling dso__set_symsrc_filename() could invalidate the cache and
   cause the new cache to be initialized with the stale dso_name.

Changes in v2:
 - Add patch 3, so that a resolved address isn't retried by the next
   addr2line implementation and reported twice.
 - Patch 1: rewrite the commit message to describe the wrong file the
   Dwfl is opened with, which is the actual bug, rather than the cache
   teardown that follows from it, and add the Fixes tag.
 - Rebase onto perf-tools-next.

This series is independent of "perf build: Fix builds with clang and
BUILD_NONDISTRO" posted earlier and applies with or without it.

Testing:

 - "perf test addr2line" and the hists tests pass.
 - Builds in 13 configurations, including BUILD_NONDISTRO=1 where the
   libbfd reader is actually compiled, and with clang and gcc.
 - Every patch builds on its own, so the series stays bisectable.

Ian Rogers (3):
  perf libdw: Fix Dwfl discovery with split files
  perf dso: Separate libbfd and cmd addr2line caches to fix confusion
  perf libbfd: Report success when an address is found

 .../arch/powerpc/util/skip-callchain-idx.c    |  4 +-
 tools/perf/util/addr2line.c                   | 42 +++++++++---
 tools/perf/util/dso.c                         | 57 +++++++++++------
 tools/perf/util/dso.h                         | 26 ++++++--
 tools/perf/util/libbfd.c                      | 53 ++++++++++-----
 tools/perf/util/libdw.c                       | 39 +++++++----
 tools/perf/util/srcline.c                     | 64 +++++++++++++------
 tools/perf/util/unwind-libdw.c                |  2 +
 tools/perf/util/unwind-libunwind.c            | 64 ++++++++++++++-----
 9 files changed, 253 insertions(+), 98 deletions(-)


base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
prerequisite-patch-id: b6fdc526887b71fb66f5fe0c0d41f7ef9493861e
prerequisite-patch-id: d47077f674c700f4f6296e9367f7ddfe004aea89
prerequisite-patch-id: ed0db23450840601762fe85ca1bef06ce6d28fe7
prerequisite-patch-id: d84e6b96d533ee6ed549e26e94216e2da60f7f74
prerequisite-patch-id: 6e8f19551d771621a5037096626cfe7e271b36f9
prerequisite-patch-id: 3768dfd588c7439deb741bce44c74763011c6be7
prerequisite-patch-id: babac99a4faa3b1525e44d3f34ab33a88103334c
prerequisite-patch-id: 5279827453fea1536abc620aa33c887c44e41ee9
prerequisite-patch-id: bdc0d648a577142b9270fb59b54496bc2bf8d5ea
-- 
2.55.0.1082.g2b9226bbc0-goog

