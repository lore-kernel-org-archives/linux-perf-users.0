Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97AE3AD51A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540569; cv=none; b=fO/T8TJV6oFcN21/sV6X9YaumMTz4SbsBKLKU3+l9Y7cxs0pWZCB64qs740zSm6A3B+vS6yzRVWMEn/ZCtm3XmxJ0jt9vxo+bisZX93F1oZAve0xU9jJSvAaSV/GGHhwlPUCDvznaXqLHm60juXp1mwuHLzbFOL4oNWOYdc97GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540569; c=relaxed/simple;
	bh=NCEstLyEH26Gcrt5WvQF8dDQqZ4yLbXySAqcvIx/IfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvUnSNyvCVsnKLp45IEl8Iv+64+cSQ/+sItktY8OSSKJpPnNn+zQcm0yLYzvzx8RZtEIYBepITmgE1Ht3sZzXai5MkhWIVUw4lOfg2wltNfvILTjY5LaRcRpHuZ6fX8hHPckKvXNTBRmYPyhs9WLaYW4jbN3BpNwTUYVFM4hpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slzHnJrf; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slzHnJrf"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso9751135a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789540567; x=1790145367; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BRKY0SGTh5bi94+k10OWCyNcuDFr8NzNm2CDXcPuQ0=;
        b=slzHnJrf/hiV1Cd0ZpxkPhl9XyAxSKW8JfKVth0hqIvmQWwDnbk+EkA21deYY1p/r4
         1m6mA/P6+XILjC0wlvjniftyS/k5Pz4UOU7wYa8LY/DUcFqV9GtcahAiECd0uLZAmBme
         U2b//9TBNER5xfJjXV+WNjCUV7BQYjABrzWZEVHt2VzybqdLfepLAUHpvi5PkyLXuyWh
         j+eaptS+ICDWoTreXA01USLqo/KXQGTAh/+18qmZCRNtCif03ObmOZJ4TYiD7xh5d0L4
         +5/PqYbiMOxSvOGcMz6x5TB7st8YkYY9WyWUQGwgZHeSxmlf7rhJeoS5nN+AzJ+wmYTG
         Ejkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540567; x=1790145367;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BRKY0SGTh5bi94+k10OWCyNcuDFr8NzNm2CDXcPuQ0=;
        b=UYweFI4rRDzCtreFwz11D95eDvpvcWqpUYXfLy1bD93d3huh0oZ3ngdTMotiaJ2JrV
         dWnOmJBooG7m1vuGAwAY8R3xflqksI7vYXZW+vTkhsrgoMdEsS6CObtrgicy0JYQMCMc
         NN7XzPzMUeDrMs9CRi9PpX/oRK4pEGhJCwN6K1e8dweha3z3m+94iYP9NRmLYMZOSjt0
         b0RN0h162ZGFBGXXljpAvGt9Xbxm9HLd1JrMvAh9p/yMHO5EqH5r5AF3UQqTMZzkI2EF
         SBpgRfzF9RREXCC3ceKgz2iHb66xbimd8xIQvXY34dt/8+GJcUewkh/baam/lO7syhvd
         R5TQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0pnohHR9qb2hPstANP08XsOAymPXOs/tDZ0dOTHwKobc1uyB18zwkU9Ep93aiwNcjALiwqaK/KolEZjicqeLZ@vger.kernel.org
X-Gm-Message-State: AFuF++l8iKMDrcOAaSYsgwEhb8PP6lx3OMEySoFe3djVbia/rtaBRG5W
	+Ibo3A5WdMjh7pucNhk1LlMzqjGpUaqgFAIJUq6Y893d55bw3zHqvu0PUb5Obn6mPUt8wxb7ViN
	+1KdYwO1SLg==
X-Received: from dlae2.prod.google.com ([2002:a05:701b:2302:b0:143:89e0:aa57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8f:b0:399:ecd:d68d
 with SMTP id 98e67ed59e1d1-39e1e514ec5mr3814837a91.22.1789540567023; Tue, 15
 Sep 2026 23:36:07 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:35:42 -0700
In-Reply-To: <20260914170759.1992947-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914170759.1992947-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916063545.3103314-1-irogers@google.com>
Subject: [PATCH v2 0/3] perf srcline: Fix addr2line cache and fallback bugs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/addr2line.c                   | 35 ++++++++---
 tools/perf/util/dso.c                         | 58 +++++++++++------
 tools/perf/util/dso.h                         | 26 ++++++--
 tools/perf/util/libbfd.c                      | 52 ++++++++++-----
 tools/perf/util/libdw.c                       | 39 ++++++++----
 tools/perf/util/srcline.c                     | 63 +++++++++++++------
 tools/perf/util/unwind-libdw.c                |  2 +
 tools/perf/util/unwind-libunwind.c            | 62 +++++++++++++-----
 9 files changed, 245 insertions(+), 96 deletions(-)


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
2.55.0.1032.g73a4cd73de-goog

