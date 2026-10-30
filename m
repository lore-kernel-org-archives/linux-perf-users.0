Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388768;
	b=y5xkStjnst4uTlxst4hvAEubhaebWPVI20AHuIQn992C8nc+pUI6QOHs6UFkGEJAwoOv
	 wvp/cogjc2MeXXsbqU3jAhTEJ1E+5n7dG3r4JmRA4xDnxLxelbELBbWxPhpb+6VhNDa7s
	 GeSl61609zcUb+bNf4jER+RWSv3JNrtGl0kfMDhbbaCsoVh0vdRltAxBkWbjnGT0+Va8T
	 jeIPRZ1kiXzjm9gqGDSCyKG5EeBTCD0PvHnZFYVwJ3r0ciS32HMKoRkP1GDXGH6VPnWWu
	 /k7mtRpvsyVRCtToNVMZTsTHUtTzracQIuXDTHBCtRJgjjJmWdlF0KYNeUWVeskZAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fPMhe94rnGW2hLVz/yw5TJ6ruEhujeJS0bfW8BgOY4I=;
	b=aIm2QzE/Z718ciW0ka91PPpoci7Gf03ZZ5OoMHkxqf7hhaqB//5rrUPPJPHv7fJIzaoP
	 bsMk14BNc4CPBCLQ0HlkxfqF8PC7e610PhQPKqn3Hf17sbE1VtFVAS2gNjntaV5f8rJLI
	 SUb3FlCmXawpei6f4U0w9OlMWTYIoETYvvreuanHBJW3GD6lh50oVN0+XAUvs2//xXyQg
	 iGVelG0yF6j+lyS5x+mAtBdtnhmzZ3/AkT4kPE4r4XLpzJ7RqDd54Ux9Eo8Mx0WGEQXBv
	 PpXDuzADONcgoWuhiOuc7bcQA4P4A7KnFnr3yRRLs/fYsz1Uqcqxr48z2pd++jKXXcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KU23NTmn;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E50606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 19:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7E50606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KU23NTmn
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab38a051aaso11961387b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388767; x=1793993567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPMhe94rnGW2hLVz/yw5TJ6ruEhujeJS0bfW8BgOY4I=;
        b=KU23NTmnrKDO4wYtg5MqjyCON6k4UWdV7snkUj9j8lzbb+B9zjVqZOMIr5BNbNNMpD
         5ZJPewCLPqW3oKGEq63M0utdPZv72yMr12pBoAfmdUUsuDGVQThaJmkliR+M9Wygw978
         ZMCoNQ6Eq7mV1PPFxrL5mUACYQ8Wpxww32U6XgJdnBvDPIAZ1pvwy75T2NUk3YJwfgAy
         J4+T5iNzIuJsrUEEjhmhVxlD9rcjssA/ok1BLmR10LE3qWoNEGU1DrpnymnmV10Mcf0f
         jjObdoHnkpW1HbVlf7fprHGjbDxuEXkc3/6EPSlDpNNxSn5LqXkS4np8A1hBkyYzTSzB
         8Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388767; x=1793993567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPMhe94rnGW2hLVz/yw5TJ6ruEhujeJS0bfW8BgOY4I=;
        b=MnSD6IkefZAc5LXfCooe1UbIN0ec8XynQfeVl8baTCKkIQKSk3Mkd199CG4lb1QKjN
         3XjMMDSvsMaVr5PMPQ+bVYU3akFe2ucb/H7c4Y9+sB7NDk6SDEhTKhNxCNVhnjqj7aXN
         iOzROXawug7yMDq9nxzDCCbJpT2y1oFxIUrfAyhbVeSZ0YLOT8t+mkPGUZwDT+/6LbzJ
         4Q+/qY5b/fyXftOowL7XcIuTxuyBMdZRxZBwNSk5icAXZnxaJgG2B5vQUNncbLixlv63
         tTAvLbWmCqEWkbk/Rj3YAx/uv31UtlQK1mLHicBZfGyvBJgs2bk1hqvQM06i2+eZAPo3
         E29w==
X-Forwarded-Encrypted: i=1; AKwUvBysqEjqH9btil7ZdJzM0kLy0u2AsquW9CpvhXdxeP5+VnHZTKVVhS4n78w7b2EIEEHmoCx9hMR5CtHFEnsQ3Yu2@vger.kernel.org
X-Gm-Message-State: AFq9FYKX1KMC2mZefqkC/0A6Pc6tGM7BpAz/z30QbDzOyFQ5yAIRb99L
	q8Ry7CIAa32UNdJh/gYYv+7v2WKRedgJ++xqZUsKw649v4zvkb2BrDsD
X-Gm-Gg: AYBFou3jDzZFVMYckGCuBxnO/39zXjimMwYbxpoEUNjFdxTJ5G5RihPJEAnm4z7mjt7
	JoN3GhqfzQmbtiHtwa+BFfm2RC3Y1LEiA3ax6jlDkSJhfVPjka+Ot7hVpAHR/8d8ZI1nutP8TWS
	TFYjNnaNGgUf9N770ks2F+FLV7iwMrYS3vFedxgt5+5YgTaE2pUQRKaQ30IlnyaHzHfW+JIXbRu
	ZZHBDhUdy3Rb31Sl7CldxaOC0ed3VZkMLeR8WS1cW/eZVmbiRP2dvSNSLfhwZHLpQMl+cFNcZ87
	uqj2BuvSQMFFuDE/p/aWWlgT3B2fJWHJCdfUL4VASyDyCXW1duBcZw73AaCJ72wZNDAPpZf9X9S
	ZIxYS+DgNnYbmdM25r916vtgatS9bM5m4B/oAzkxMGVKAfwholcEUFF2Vhugx6QZ9AAK3kzCZ48
	+9dibcI0I7fqaevORiehCwQUTDjvU5N9j0ij9/jn9rMmIzFvykKjslvCjb2aPbMAsQlWBjYBFDE
	3eh0L55MNV5ULks30VzWyIbSq+DL+7cohaiuHDuE7IZlNWHNhFhp3/4jFroCAPQRKC51zkbhl9g
	uAtSbcBDDnzF66QCN3yE8Aw3yNcQQsySO7l7VVHjDqBpSqcJdg==
X-Received: by 2002:a05:690c:660d:b0:8ae:8d28:77ca with SMTP id 00721157ae682-8b2b6723e65mr22272437b3.33.1793388766791;
        Fri, 30 Oct 2026 12:32:46 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:47::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7198c65sm13595867b3.36.2026.10.30.12.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:32:46 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 0/2] perf unwind: Don't load symbols when the caller doesn't need them
Date: Fri, 30 Oct 2026 12:32:32 -0700
Message-ID: <20261030193237.1440673-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf only needs to know which DSOs a callchain passes through (as
build-id marking does at the end of 'perf record' and in 'perf inject
-b') it resolves the callchain without symbols. The DWARF unwinders
ignore that and look up the symbol of every frame anyway, which loads
and demangles the whole symbol table of each DSO they visit.

On arm64 every frame pointer sample also gets a short DWARF
unwind to find the leaf function's caller; since v6.17 (commit
29be60c93d2d, "perf build-id: Mark DSO in sample callchains") the end of
'perf record -a --call-graph fp' loads the symbols of every user binary
it sampled. On a 128-CPU arm64 host,

  perf record -a -e cycles:u --call-graph fp -- sleep 2

never finishes writing perf.data, with over 1GB of heap growth in 5
seconds.

Skipping the symbol lookup isn't enough because loading the
symbols also finds two things the unwinders depend on: the DSO's
build-id, which libdw needs to fall back to the build-id cache, and any
separate debuginfo file, through dso__symsrc_filename(), which is how
both unwinders find a .debug_frame there.

  1: add dso__load_symsrc(), which does the same search for debuginfo
     and the build-id as symbol loading, but doesn't read any symbols
  2: pass the symbols flag down to the unwinders and honour it, using
     dso__load_symsrc() when symbols aren't wanted, which also makes
     the arm64 leaf frame caller unwind skip symbols

Testing compared v7.3-rc7 with this series, on x86 and natively on a
CentOS Stream 10 arm64 host:

 - The 'perf test' dwarf unwind and 'perf inject' DWARF callchain
   conversion tests pass on both, also in a REFCNT_CHECKING build on
   x86. The libdw multi-threaded unwind and addr2line inline unwinding
   tests pass on x86; on the arm64 host the former is skipped and the
   latter fails both with and without this series.

 - 'perf inject -b' on an x86 'perf record --call-graph dwarf' profile
   of a Python workload goes from 0.19s and 69MB max RSS to 0.10s and
   33MB, with the same build-ids injected.

 - A test library built with -fno-asynchronous-unwind-tables, so that
   its CFI is only in .debug_frame, then split with 'objcopy
   --only-keep-debug', sits between two other DSOs in the sampled
   stacks. On both architectures, with the debuginfo found either
   through .gnu_debuglink or only in perf's build-id cache, 'perf
   script' output for a --call-graph dwarf profile, and on arm64 for an
   fp profile, is unchanged with both libdw and libunwind, and 'perf
   inject -b' unwinds the same frames and marks the same DSOs. v1,
   which only passed the flag down, lost every frame past the library
   in all but 5 of 4045 samples in 'perf script'.

libunwind's .debug_frame support couldn't be exercised: EL9's x86
libunwind is built without it, and on arm64 perf's libunwind support
has been compiled out since v7.2, as libunwind-arm64.c checks
HAVE_LIBUNWIND_ARM64_SUPPORT while Makefile.config defines
HAVE_LIBUNWIND_AARCH64_SUPPORT. With that macro defined by hand, and a
cast for the build error it then hits, arm64 libunwind results are also
the same with and without this series. That breakage is independent of
this series.

Not tested: the build-id cache fallback for DSOs in another mount
namespace when the MMAP2 events don't carry build-ids.

Changes since v2:
  - Instead of a separate debuginfo lookup, reuse dso__load()'s search
    and stop before reading symbols (dso__load_symsrc()) so candidate
    files are checked against the build-id, --symfs, mount namespaces
    and chroots are honoured, and the search is done once per DSO
  - Drop moving dso__read_build_id() out of 'perf inject'
  - Extend the dwarf unwind test to unwind without symbols, check that
    no symbols get loaded, and compare with unwinding with symbols
  - Link:
    https://lore.kernel.org/all/20261017000158.1178269-1-thepacketgeek@gmail.com/

Changes since v1:
  - Complete re-work on approach based on feedback
  - Link: https://lore.kernel.org/linux-perf-users/20261014151326.4142140-1-thepacketgeek@gmail.com/

Matthew Wood (2):
  perf symbol: Add dso__load_symsrc()
  perf unwind: Don't look up symbols when the caller doesn't want them

 tools/perf/tests/dwarf-unwind.c               | 71 ++++++++++++++++---
 .../util/arm64-frame-pointer-unwind-support.c |  7 +-
 tools/perf/util/dso.h                         | 11 +++
 tools/perf/util/machine.c                     |  7 +-
 tools/perf/util/symbol.c                      | 40 +++++++++--
 tools/perf/util/symbol.h                      |  1 +
 tools/perf/util/unwind-libdw.c                | 17 ++++-
 tools/perf/util/unwind-libdw.h                |  1 +
 tools/perf/util/unwind-libunwind.c            | 22 ++++--
 tools/perf/util/unwind.c                      |  7 +-
 tools/perf/util/unwind.h                      | 11 ++-
 11 files changed, 164 insertions(+), 31 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0-Meta

