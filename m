Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2E52FE4E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930398; cv=none; b=HA6WAejnStWcmraE2sn1xXARaCZPaTBuvi/6PKTi0LsoBMP51HkQnpfCaCxFHQNJOqnuEutahbw1Or/QGziBpUOcnUYkrU3FKiBO+8AxR3xb+Crk/bgLQjdRX7dsJXZRJI7827SyLGKGsvJwMVNggq7122H1jFMaDyEnxty/fm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930398; c=relaxed/simple;
	bh=8nHhekRIt27cGPBv7t/KpeDStZPq//tmFcDkgjIS0M8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRGCKo+g3uMvs2E8Bg0k9JNBaHIAgCnpCoB4gwakdoAHBTSzY/NMUi3ZjD8QrGDv2sOJNxXxuwT+yrIGWsgjq74zvQol9YeaIIBPAFZ4eFfhWro+1t9LmdOHvoKnwvu3eF2GHPzDPXwES3ngPPZeKwMeIh9Buc+Iu2qdSzwr0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzcJCNBn; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzcJCNBn"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-887e45c7063so2758752b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791930396; x=1792535196; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWC+YbIRwL39Ia+o8sJ3o3jnTmOu9eXYgwdijYxRdc0=;
        b=mzcJCNBnFhTLyckekpubvxP23A7ENaspfPTT/BdG0F1kM9y3GtmW47vgGT04sNSnYQ
         a/s1vAj5oyXeThWjUoN9dRruUl5mJcE8Wcpowx2gYnzvFaM8n1SySfPjDal8DfdqhVYw
         Y5473Q5RHq+cpVs30PjAnnm2E6Gg2ka0s2uiRrPUqIllDs3dn9u8oYkga8y9yrBSLWJ7
         aogGc1Bmkv/9/seMGfHWZd7xZVX+3e+fQzw1rwBHtiNU8PI7k1pg2M7KW8vd4qzVT9yc
         lVWVcH5lDgjtRBe1yEyM6gYUARf4hNUsVmIoCfZ/mmP0yA/zerjH2Gzx3dtOO7Kcp9z1
         hCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930396; x=1792535196;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWC+YbIRwL39Ia+o8sJ3o3jnTmOu9eXYgwdijYxRdc0=;
        b=T+ddNP6CybXZCHNDzlAp+VRh31Atvp1bCZjSLsiREX507UMleiBV5+N5HfRr6VyJpJ
         /RYbeqiFWhmSnX4A2E6xbJBEsRgHRGsWk5wRHSmmIhrii4TBV6sTy5nb8f0woYv3DvkQ
         t0gtUB3E8xXpSn2zflXzUGAwtshEthd8oUNLVPE+ECIJrfL0NVbOtT8PnmH4q3wqj1FP
         SnCUE6bgojhASLKvTnQeuv+OWSXMakmDRnL1I2vpsDM53ad3Lei9yeq1mpMOiaadWUAr
         DtVKEWzEwI3FZ6bRdYsTzDWnTsSF6HsDpDuh1ca/5uOhkRJui4ig2RWXi5OxzaHtmggV
         5m/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw1K2oz8CaxjgFkB4xclMlk4rd1xmALa6qXJWkXQwpJ/FbyJSq+Qlaf+TVEgpIaL5jCdTeGRMqKclZprAbdWLpN@vger.kernel.org
X-Gm-Message-State: AFq9FYLcfV3oDBH0dwHYFt6jnNE1nVyrn/iVwhrwx2DwZwJhMCtd1saq
	lWJt6O2jXijJ3Lvv/AQAyVN5pUuDvLpYIp4L/FGSlapTV/JMFWknSdsDTofDbcsfwChdKNSNXpM
	qNwuuEXvtUQ==
X-Received: from pgby3-n2.prod.google.com ([2002:a05:6a02:6503:20b0:cc7:982c:320f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2287:b0:3dd:a195:dd56
 with SMTP id adf61e73a8af0-3e16bfc2d17mr12433915637.56.1791930395398; Tue, 13
 Oct 2026 15:26:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:26:12 -0700
In-Reply-To: <20261013182458.1234616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013222622.1822619-1-irogers@google.com>
Subject: [PATCH v2 00/10] tools/perf: Adopt kernel compiler-context-analysis.h annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The perf tool previously added Clang thread-safety annotations in
tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
unified set of static context analysis macros and attributes in
include/linux/compiler-context-analysis.h (context_lock_struct,
__guarded_by, __acquires, __releases, __must_hold, etc.).

This series makes tools/include/linux/compiler-context-analysis.h
functional by synchronizing it and the required compiler_types.h helpers
with the kernel headers, converts tools/perf from its custom mutex.h
macros to the kernel-style compiler-context-analysis.h annotations, and
expands context analysis coverage across comm, dso/dsos, thread/threads,
config, intel-tpebs, env, and maps. In the process, it fixes an unlocked
__dsos__add() call and TOCTOU race in __machine__addnew_vdso(), avoids
dropping dso__data_open_lock in dso__list_del() under REFCNT_CHECKING,
fixes an unlocked read of tpebs_reader_thread and double-close of
tpebs_cmd.out in intel-tpebs, avoids a potential read-to-write deadlock
in maps__load_first(), and adds a read-lock fast path to
dsos__findnew_id().

v2:
  - Use -c rather than -E when probing for
    -fexperimental-late-parse-attributes in Makefile.config to avoid
    -Werror,-Wunused-command-line-argument (patch 5).
  - Acquire machine->dsos.lock in write mode across duplicate checking,
    dso__set_long_name(), and __dsos__add() in __machine__addnew_vdso()
    (patch 7).
  - Release the REFCNT_CHECKING reference in dso__list_del() without
    dropping dso__data_open_lock, avoiding an unlocked window and AB-BA
    deadlock with dso->lock, and check dso__data(dso)->dso in dso__put()
    (patch 7).
  - Pass tpebs_cmd.out directly to __sample_reader() and set
    tpebs_cmd.out = -1 in evsel__tpebs_open() to avoid a double-close in
    tpebs_stop(), and clarify the config_set_mutex comment (patch 9).
  - Drop maps__lock before calling map__load() in maps__load_first() to
    avoid a read-to-write self-deadlock when loading kernel maps inserts
    additional trampoline maps (patch 10).

Ian Rogers (10):
  compiler-context-analysis: Avoid unused parameter warning in
    _context_unsafe_alias()
  tools headers compiler: Synchronize compiler_types.h with the kernel
    sources
  tools headers: Synchronize linux/compiler-context-analysis.h with the
    kernel sources
  perf mutex: Use kernel style compiler-context-analysis.h annotations
  perf build: Enable additional Clang thread-safety flags
  perf comm: Add __guarded_by annotations to struct comm_strs
  perf dso: Fix unlocked __dsos__add() in vdso and expand lock
    annotations
  perf thread: Expand context analysis annotations to threads and
    namespaces_lock
  perf config, intel-tpebs, env: Add __guarded_by and __must_hold
    annotations
  perf maps: Add context analysis annotations

 include/linux/compiler-context-analysis.h     |   2 +-
 .../include/linux/compiler-context-analysis.h | 518 ++++++++++++++++--
 tools/include/linux/compiler-gcc.h            |  55 +-
 tools/include/linux/compiler.h                |  50 +-
 tools/include/linux/compiler_types.h          | 206 ++++++-
 tools/perf/Makefile.config                    |   5 +-
 tools/perf/builtin-sched.c                    |  16 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/tests/dso-data.c                   |   4 +
 tools/perf/util/annotate.c                    |   4 +-
 tools/perf/util/annotate.h                    |   8 +-
 tools/perf/util/bpf-event.h                   |   5 +-
 tools/perf/util/comm.c                        |  10 +-
 tools/perf/util/config.c                      |  43 +-
 tools/perf/util/dso.c                         |  93 ++--
 tools/perf/util/dso.h                         |  12 +-
 tools/perf/util/dsos.c                        |  35 +-
 tools/perf/util/dsos.h                        |  12 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 |  98 ++--
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/maps.c                        | 133 +++--
 tools/perf/util/mutex.c                       |   4 +-
 tools/perf/util/mutex.h                       |  90 +--
 tools/perf/util/rwsem.c                       |   8 +-
 tools/perf/util/rwsem.h                       |  10 +-
 tools/perf/util/thread.c                      |  10 +-
 tools/perf/util/thread.h                      |  30 +-
 tools/perf/util/threads.c                     |   4 +
 tools/perf/util/threads.h                     |   6 +-
 tools/perf/util/vdso.c                        |  17 +-
 33 files changed, 1095 insertions(+), 422 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

