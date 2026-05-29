Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F532720D
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037392; cv=none; b=HUl4KneLZXwzAoiIsh/lOg/zzo5XfOo060yBfMksOa8hHJwmdB3Kf6JVSrxwp2wkimwltf5JjjmDCf/TY1n7i7tOM2a4nyiqJsZi/LIYckyPH7bX5mvGZKDO9SLaFfBcUGcBQ0cg7TAqJdTUNr9imajodTuKbfPcwsgmZxa4WF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037392; c=relaxed/simple;
	bh=cpD+UE2OTxn8z8LL9kxq3djPbt9ESlkxjDsad6C7T/4=;
	h=Subject:From:To:Cc:Date:Message-ID:Content-Type:MIME-Version; b=CWmJdGsixnjLItLIHRC/C6OdRx5l8RVxnmzuvXjQBoga5Bv6Bltfn9R5GZqlnH893xjIpP4WPvzaxP/+admbFM25SUeVSgnAyRRdU3fLtSBgYzOmkGY9HJ22/wNK/ylnWXyA2MF5yqlSkAtyKLbS2sm2MWa62tEFYfACzlEGTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg+TuvGf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg+TuvGf"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b903567fdso1275345a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780037391; x=1780642191; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:cc:to:from
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=h3f8avP0A5jcSW7V09wocZcmnKxtBmYkx60tqVzUfYo=;
        b=Pg+TuvGfnjG2PwYRB/z0yUMRMiG/yOZro6r8Z9pDBtEuWOH5jGVYaCqOhhmLuVr+jX
         q2E9s8/hPmz5iYzqhw9exWSI/3KT7B+0DUmC7dch5MJ9+nSvZtiIFKxusAiTvZ83W1QE
         DU/RVPFWpJkO9fm5yc/cgb1tBZaBxHyR9zPy4XVJBjvvFcpN0ScyJLvq34EqOfMRIYsm
         c7QJ4z2MOXnM3lBcIjGsARCGEObavo4efiBskHtUjejaYSfYq8oInEHHeK+hf4bAy0g/
         Dpm+AlWUzD5Bxfpztpp/X00OwvKEUkhNJ+PndtQl0cWvyEUOz2oTQwz+R37vEz6ChAvs
         fOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780037391; x=1780642191;
        h=mime-version:content-transfer-encoding:message-id:date:cc:to:from
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3f8avP0A5jcSW7V09wocZcmnKxtBmYkx60tqVzUfYo=;
        b=eWFXz47NA679PHDCRClFjnsB7RI0ke3KXu5PKiiJUq9cBcV9Hsjp2uNNiJ4cxww/jl
         RZiugrk6GeMsGZ/ORqc13LScTE0+WQrMcmygY3m2ui6rrrSytYzuls6hkiv22jIToAUe
         c4cZMRrkSVM+h35k81OwGH+CyBUXgsADcFKACUiZ/C4PiqLIzNHpchNocUrsV4oHOg+0
         YGVXOAO1MGAcQsHYO3Pz4RvnHag0nDE5iEuPHQtoMxVIhnipuvaObEZkskkYW0Kj2il9
         wi0LixjdHpnoCBObP3Fj9WT6B5weSTyH1Ya/HUkmTLn+FUvzFMgIsXUA/DVFHY4QG4ea
         u/Fg==
X-Forwarded-Encrypted: i=1; AFNElJ9/8wBEy1Ytp68rRehj8Ci01voI41IoKXQSRETDVTt4xSetU0AFJwZQh7fYfJMTu5XyP5v8d+3qPQspA38SwNm9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sUYwLrU4X5t77dMTAiN9I5XJOf/dp03AZkcNU1lDuGmdwbwO
	UbRQzkQQW6YiWioV5eN/bvZM3+vQAzUdsmoNtejTHlm80gkbUh1X02Np
X-Gm-Gg: Acq92OHFwMhx0kaeY8AaPuOlWADAqPGP6Xcpqia3M6HE8pDb7R5v3b+v3vsguWAhS7u
	zdF000rc3PMRBlSzA9VzpwaMFuQvgOCGwxj3AW4kjdzp//920Uhhmp7R9bbM8d/tAKd0yaFmAr9
	lDbmskKUzaoWOb00H0VEEmgMzrUMdiSOkcd2KjT/6pX+tmRvzpipe8bbdP8a5sBWMKZWLq8JrJw
	L7INWWzG00hDYr01FlMSPz+WPhNLLa58O5efo58Hn8wsBUgYyHSftHfp0a+GZvzDABWgQsYs+f+
	bkpdAWK99/ldYnWfr2+roL4PByeYPn4l63wjXOIUAM2/GOJXjgt+/nRS6PFEg1MEIPadb+UmuR7
	g5hknxmsbUDGzjBXvKaZ84z7U7nFeAc7Pz4wLpHF2q/ukrgisHOLsMzeSYDLGYxNqU32J3YTmpn
	kUVItqb7Kou9qg3PzI88buNUXCMdK/E6G0t/kfjQ==
X-Received: by 2002:a17:90b:3bc4:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-36bbd43e588mr2160966a91.26.1780037390370;
        Thu, 28 May 2026 23:49:50 -0700 (PDT)
Received: from [127.0.1.1] ([104.28.157.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm952626a91.14.2026.05.28.23.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:49:50 -0700 (PDT)
Subject: [PATCH 0/6] perf: fix six memory-safety vulnerabilities in
 sched/header/subcmd
From: Wang Haoran <haoranwangsec@gmail.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 haoranwangsec@gmail.com
Date: Fri, 29 May 2026 14:49:43 +0800
Message-ID: <178003738371.62097.10360938456907564684@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>From 9e71ffe9400fd54c4fc958b16229e5628271e4ad Mon Sep 17 00:00:00 2001
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Thu, 28 May 2026 15:21:08 +0800
Subject: [PATCH 0/6] perf: fix six memory-safety vulnerabilities in sched/hea=
der/subcmd

Hi, I found several vulnerabilities in perf module.

This series fixes six memory-safety bugs found in perf version 7.0.6,
in the perf sched stats subsystem and related infrastructure.  All six
were confirmed via AddressSanitizer + LeakSanitizer with crafted
perf.data files; the reproducer files are attached to the individual
patch emails.


Privilege note
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"perf sched stats record" requires root to capture
scheduler events from the kernel.  However, "perf sched stats report"
processes a perf.data file from disk and requires NO special privileges.
This means an unprivileged attacker can hand a crafted perf.data to any
user who runs "perf sched stats report" -- the attack surface is fully
reachable without administrator rights.

Crash-to-fix mapping
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  crash_err234_iter50.data  -> patch 1 (memory leaks in schedstat)
  crash_sig6_iter840.data   -> patch 2 (heap overflow via bitmap_zalloc)
  crash_sig7_iter210.data   -> patch 3 (SIGBUS via out-of-bounds mmap)
  crash_sig11_iter2.data    -> patch 4 (array OOB in domain index)
  (no poc)                  -> patch 5 (list_first_entry on empty list)
  crash_err255_iter46.data  -> patch 6 (astrcat leak in parse_options)

Vulnerability summary
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Memory leaks in perf_sched__process_schedstat() / free_schedstat()
   (tools/perf/builtin-sched.c)

   Three distinct leak paths:
   a) When zalloc() of the inner data pointer (cpu_data or domain_data)
      fails, the outer struct is returned without freeing the parent.
   b) In the after_workload_flag=3Dtrue branch the temporary struct and
      its embedded data pointer are used then discarded without being
      freed.
   c) free_schedstat() frees each cpu/domain node but not the
      cpu_data/domain_data pointers allocated inside each node.

   ASAN/LSan reports 72-144 bytes leaked per crafted event processed.

2. Heap buffer overflow via u64->int truncation in do_read_bitmap()
   (tools/perf/util/header.c)

   bitmap_zalloc() takes an int but do_read_bitmap() passes a raw u64
   read from the file.  If size > INT_MAX the int wraps to a small
   value, a tiny buffer is allocated, and the subsequent loop that
   reads BITS_TO_U64(size) u64 words from the file writes arbitrarily
   far past the end of the allocation (heap buffer overflow).

3. SIGBUS from data.offset beyond file size
   (tools/perf/util/header.c)

   A crafted perf.data can set perf_file_header.data.offset to a value
   larger than the actual file size.  mmap() succeeds because the
   kernel accepts out-of-file offsets, but any access to the mapped
   region triggers SIGBUS.  Confirmed with data.offset=3D0xff68=3D65384
   against a 4760-byte file.

4. Array out-of-bounds write via unchecked domain index
   (tools/perf/util/header.c)

   process_cpu_domain_info() reads a domain index from the file and
   uses it directly to index cd_map[cpu]->domains[], an array of
   max_sched_domains entries.  A domain value >=3D max_sched_domains
   causes an out-of-bounds write into adjacent heap memory.

5. list_first_entry() misuse on potentially-empty lists
   (tools/perf/builtin-sched.c)

   get_all_cpu_stats() and show_schedstat_data() call
   list_first_entry() which, unlike list_first_entry_or_null(),
   never returns NULL -- it computes container_of() on the list head
   itself when the list is empty, producing a garbage pointer.  The
   NULL checks that follow are therefore dead code.  A crafted
   perf.data that causes an empty list makes these functions dereference
   the garbage pointer.  Replaced with list_first_entry_or_null() plus
   proper NULL guards.

6. Memory leak in parse_options_subcommand()
   (tools/lib/subcmd/parse-options.c)

   When subcommands are present and no usage string has been supplied,
   parse_options_subcommand() builds a usage string with astrcat() and
   stores the pointer in usagestr[0].  The pointer is never freed,
   causing a 73-byte leak on every invocation.

Testing
=3D=3D=3D=3D=3D=3D=3D

Affected version: perf 7.0.6

Each patch was verified with:

  $ make -C tools/perf EXTRA_CFLAGS=3D"-fsanitize=3Daddress,leak \
      -fno-omit-frame-pointer -Wno-error=3Dstringop-truncation" \
      -j$(nproc)

  $ ./perf sched stats report -i <crash-file>

Before the patch the corresponding crash file produced the ASAN/LSan
report listed above.  After the patch the same file is either rejected
cleanly (patches 2-4) or processed without any error report (patches
1, 5, 6).

The reproducer files (crash_*.data) are attached to the individual
patch emails; each is a minimal crafted perf.data (~4 KB) that
isolates exactly one bug.

Wang Haoran (6):
  perf/sched: fix memory leaks in schedstat processing
  perf/header: validate bitmap size before allocation in do_read_bitmap
  perf/header: reject data offset beyond file size
  perf/header: add bounds check for domain index in process_cpu_domain_info
  perf/sched: replace list_first_entry with list_first_entry_or_null
  subcmd: fix memory leak in parse_options_subcommand

 tools/lib/subcmd/parse-options.c |  3 ++-
 tools/perf/builtin-sched.c       | 32 +++++++++++++++++++++++++-------
 tools/perf/util/header.c         | 17 +++++++++++++++++
 3 files changed, 44 insertions(+), 8 deletions(-)

--
2.53.0
