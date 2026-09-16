Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198C3F105C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539209; cv=none; b=TnLL0QqNUYwhawR+1CxKCVh1Kebvm+xLblxYI0XOoDcfCUIr5GpQZ63LCY0fi8LiZDLxZPMposr4xUs92mKmlyWRAGFG2bmaC4KfqNakZInDuU0R8lBuGRC0UqVF/pSHQzWMIXh+fLkyee4CTbbp2KAC8S9idUOIbpkoq22gCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539209; c=relaxed/simple;
	bh=/UxG/z8oqDwP9CIwjcJWyPbDAUY4rJGItVrJwkdYtcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XnYF3en8KQ6DclyXi+Ja60YF0QeW3ygCHWZlaGyIB7G0hnS8ibMXpdrCP+2T1cQmVA5RWhDOvKiXX6K7XjmbPQ2y51ssjR3cfVoXAtacfLwyszPm+8KyeNH8l54FUB8ohhYYddJM0QRHR2QFwJTbsca276imSrQnFOmhV6bknws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5X1sQhf; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5X1sQhf"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af92138f9so3165708a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539207; x=1790144007; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mE+VIvBqxJWeI7GLiq81u6doV2s7RHiOZIS5UCF0zbk=;
        b=S5X1sQhf8PRD27TmBaTV9nyWZgFb4WxZheW59NQRHqiF4qGeGbjdZTBNjuf+5LTGoW
         k7iRZHKHjfGiM3DGjU0Jk/HtYkqa5BxBfUCfxyWnADN4nQY45mZtG+Jaughht4oZ3ZAy
         X8zTcTs9XhzYHOuk5jvxc+sgT5QsWd4F5ARVugsbdnuxtPlULrc0A9ZTVUscGSKtj5IM
         ubV9HCiHt7sXGUCCb9bWtEOw3/Muaomv3OkoWskb0NoGYyU2GM/74lCGMFv8UWWyr1YD
         ghOzHzmt6RdICW8tLOG79O3xfRLmS03tc8vBT9UrTbxoXS6essbUwVzhUzt1WrPlS9rV
         /Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539207; x=1790144007;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mE+VIvBqxJWeI7GLiq81u6doV2s7RHiOZIS5UCF0zbk=;
        b=Ru9f0T1q/bpcB/P+ZU1IS7yMado1dtiaDuDsJaJBcWnwR8TNPxYdwZevkcS8da+Dn6
         Ora1qiihHOzim7aUpQetLqudPwWFRJEFx/Piq1B+n4qdd0+5fsObt+em0Rg1uZPC+Y+G
         iIP7wSsaknSBFa/cMyamqRR44QzgNTVRgMQeTtxN3DqBmqVSjrWX5rNHBmpgDzLCLfFd
         jC2ejlcxBCG23B3F2ynmBAlflz+Ty6K1tyb9k+7sl70eB0/JkftuvhubNJTKNtm8AvYx
         axJogci5z2dqwwObNygvHyc2dDpd1JNSd9OlYaLkVvgZYMqmtUDiCheiv3J+xBvzC6od
         pcYA==
X-Forwarded-Encrypted: i=1; AKwUvBw4vXoZ3hCo07TySFi/vS2IBHpaes25A/pGye2tRLZArLkqamacsyrGSZkqUcUGvzbMoxvO44oiN8hpitXRDo76@vger.kernel.org
X-Gm-Message-State: AFuF++kt2LafSPMpZLlOkKQR/Hi4NKxKM/oVI2MAFzlomMuBazcgdCbW
	XyVPnaG1VJU7idYw2Lo/7WgVjrHU1G7cDrUhLxcgkknkCLwpyzu3AJ8dpn4w6/IhdM8uu8+QlX4
	7Q+5oUckpZw==
X-Received: from dlep14-n2.prod.google.com ([2002:a05:701b:458e:20b0:143:9704:de05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3941:b0:39e:237c:50de
 with SMTP id 98e67ed59e1d1-39e237c518amr1393784a91.3.1789539206454; Tue, 15
 Sep 2026 23:13:26 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:17 -0700
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-9-irogers@google.com>
Subject: [PATCH 8/9] perf build: Remove leftovers of removed build options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

NO_LIBDW_DWARF_UNWIND, NO_SYSCALL_TABLE and the embedded clang/LLVM
support were all removed, but each removal left the matching entry in
the build test suite behind:

  run += make_no_libdw_dwarf_unwind
  run += make_no_syscall_tbl
  run += make_with_clangllvm

None of these have a make_* variable defining what to build, so $($@)
expands to nothing and each one silently repeats the plain "make_pure"
build. The suite therefore spends six builds, as every test is also run
with O=, appearing to cover options that no longer exist.

Remove them, along with the NO_LIBDW_DWARF_UNWIND comment that is still
in Makefile.perf.

Fixes: 2e9191573a69 ("perf build: Remove NO_LIBDW_DWARF_UNWIND option")
Fixes: 3cc550f5bbcf ("perf tools: Remove dependency on libaudit")
Fixes: 56b11a2126bf ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Makefile.perf | 3 ---
 tools/perf/tests/make    | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2438b40eaaec..53f538cc8e1a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -64,9 +64,6 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBBIONIC if you do not want bionic support
 #
-# Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
-# for dwarf backtrace post unwind.
-#
 # Define NO_LIBTRACEEVENT=1 if you don't want libtraceevent to be linked,
 # this will remove multiple features and tools, such as 'perf trace',
 # that need it to read tracefs event format files, etc.
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index f879f8109072..608470ff9c10 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -157,7 +157,6 @@ run += make_no_demangle
 run += make_no_libelf
 run += make_no_libdw
 run += make_libunwind
-run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
 run += make_no_libcapstone
 run += make_libcapstone_dlopen
@@ -167,10 +166,8 @@ run += make_no_libbpf
 run += make_no_libbpf_DEBUG
 run += make_no_libllvm
 run += make_no_sdt
-run += make_no_syscall_tbl
 run += make_no_babeltrace2
 run += make_with_coresight
-run += make_with_clangllvm
 run += make_no_libpfm4
 run += make_refcnt_check
 run += make_help
-- 
2.55.0.1032.g73a4cd73de-goog

