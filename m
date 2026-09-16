Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95534AC163
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602256; cv=none; b=AgzToKQeW0rdKo+i0YS9YkBVRh4XWiQzlw/Ld4zuFRFKf8oo0DaKQDqcXCxrRR9nGb64wcNL7CEbSemXszCFNs7cZSNgiaKcSHxKxXD1+twh1AuU+0WlpkfJmpmRkzYz7lGYvxcu27BTZbW82Ouq7G4wII51ryJYGtSddRUAFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602256; c=relaxed/simple;
	bh=H5tme0yWGsG/iUMmjSC9sar8JQv2trAeHdf650t15Lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWzgj7E0WFuA3jRWlX0QsvZB3H1amXKrKjSk/74RQXLxQ15Pf9hHkPDtGpGX01xF/SS5G6yhkNdNAvwK5ykXDHK0UatBNGH6hpXTsyZN+5mCnn5zzgZaAl3uRhnkmZOyQtqcu+yidnIOge4ZyrqMwdRJ9WloPwmfp8TLCmc+y7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiiKgKUe; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiiKgKUe"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396901263b6so413346a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602254; x=1790207054; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7d1MNChRBTl5w46eq7AS5MtXU3THtIxH7MT8aWDI34=;
        b=LiiKgKUeWQK84gvO/kUdqiCaJ/gF0FAGfSnaTOseSjvgWfui1QV5sDELVR9vyKo7qA
         WXfO9Sun/DS9Ds7CHtI3E9ldYtmpQJwLS8uqpAKRjwuZU6mfR+/LzmYOdhgIsBMTXOdB
         BPCVlKuQzo3HrXC/aEDbP98kE1RMInpWGohpi+DxlS9H8zsPFIqytpheHTMO+G8WHHZn
         WOGVsH2cxKjyS0qJuLJAlqHMfnqNJ6jLKccttRgT1AUmfg9oz/GTIzkkp7afnURmfe3i
         YQIAtoej6zmj9BRkN6SyOrU7oTb8JB2QKC3rOYeE6jue44Mgg6zBzndssc/r5//kZStz
         HowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602254; x=1790207054;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7d1MNChRBTl5w46eq7AS5MtXU3THtIxH7MT8aWDI34=;
        b=jpkpHfej+3k3+E64MdjOInp9IMzjL3zEiv7W7WQntUVJScCiDADOt64bflYreYlQxi
         Ry0M3XbZ+kl5SF2OEMU9rzqqsqUapEaQjlP52+q2QDQnjIHBSctoL8xGbIYfZnjKO2Ii
         8a7FpIPT+IuTJracytQzhPwm11hQnLpCx/EJimSHuH+Z4QBFXKviBLk5fo8gWl2OYUQz
         r8YMIyMIyZjcHv29UF0c1LC93iBIgC4rN8Zb5aSJ39tip888ROWXIpBkfUmyXOnCxLaV
         /meyAUZiw+An8w53c3zg9pFhtdxSXmzPs6YBn6pdLihqCenGJc9TtbWzoN4PE0xLF9Xa
         e84A==
X-Forwarded-Encrypted: i=1; AKwUvByLIdnvdoD2POVVHGYa1eZcgTjNeAFPv1aHpHU4sKNhXw3c47GF6yB/eJYvx8HF+cHdYa4KpDo28J3CaP9AZEoy@vger.kernel.org
X-Gm-Message-State: AFuF++ni6iwRPom5fRk+/uw0l3U1WWyWHlVdgWwCHhKbjHdePSnx9ijU
	zm+ku1ZDMhUDDndkaBNrlW3FxTvvOQsBTC/cNSk9ym5G5/ZYmeonjCgXGC0QfDy2v3rgEdQk37d
	uMfLlEWPYUA==
X-Received: from dyjo21.prod.google.com ([2002:a05:7300:3395:b0:335:175:7bd3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c88:b0:39e:26a7:7aca
 with SMTP id 98e67ed59e1d1-39e26a77cefmr11029554a91.23.1789602254109; Wed, 16
 Sep 2026 16:44:14 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:43:59 -0700
In-Reply-To: <20260916063545.3103314-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916063545.3103314-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234402.437113-1-irogers@google.com>
Subject: [PATCH v3 0/3] perf srcline: Fix addr2line cache and fallback bugs
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
 tools/perf/util/addr2line.c                   | 41 +++++++++---
 tools/perf/util/dso.c                         | 58 +++++++++++------
 tools/perf/util/dso.h                         | 26 ++++++--
 tools/perf/util/libbfd.c                      | 53 +++++++++++-----
 tools/perf/util/libdw.c                       | 39 ++++++++----
 tools/perf/util/srcline.c                     | 63 +++++++++++++------
 tools/perf/util/unwind-libdw.c                |  2 +
 tools/perf/util/unwind-libunwind.c            | 62 +++++++++++++-----
 9 files changed, 250 insertions(+), 98 deletions(-)


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

