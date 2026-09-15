Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F434FF45
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504718; cv=pass; b=CqPPl9PPFoOMdCoRN1LITy2LEbKTkGWR4cBKsVaE8GmxfAld+QiIoE7TVyQWhyS9cCFnVHnRW9B1e9e87r1LOTKN/dvMOrBkN/7yl/KlGb3Z8WWK3opVaG7sUHeeF4XNGIvvw0NHePhn5hftzQlB1a3HHU500qXYTiuEvX50zv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504718; c=relaxed/simple;
	bh=q0uhT8XiQAbMWjxV732u9cL+aV/tNoUWOtyJHrk/A68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwS5Vs/Bx6sP1Ol+TLgaE0MBx+er3pgwHULYoOABFQhvdNpWf11YXaxkHqr2nxtVcR9rOWArbO8tEyfFg1G/aeUtUT7a/yXyvCWVa8rNWpDxjZ8E6/yc/N0pGjzKZ0APUVzjy+FcojRDhTW4U7vJ0XyEVobxvzxmQQhHRPC0354=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIUdFJCZ; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIUdFJCZ"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so10871cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789504715; cv=none;
        d=google.com; s=arc-20260327;
        b=fGwVNp69wyciz6zpyKCqz963N80z1nQ0lS3LAZVeuW5qm/WKWTaSeFLNnXg5P13lq9
         hTrvYFk5zlCcrKzV0jcf7xANkmMoJHiWPx8k5Gg/JqrhbaYjs48WwhiMFA8HC9nGohNH
         TNAk/Ln3r1uJH7cUO347xSFFh/kDUTvYuh8rXobdvYiIEntCk8nXa8HjCziDWHh0wc7O
         cJra2RZ7SLKt0O+wHeGR13DNKk1KpDijpkyqkL9GNJmlOXKi8qkm+W8BBNi6XoQZCRl1
         REQhf+P5eeymXAPEYVLVJkIV8JFt9WDsWj5abDCebSRkLemZBgzPfd43q09uQ7U0sb0g
         4TGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yi9YhsgJxg5RwheIV2uUP3vETgnxDCzaYZNW3S5FHwY=;
        fh=DYu1yH00vl4eU3EFKTzl8aSaQIettTFz58zMED/v4uo=;
        b=dZuGFNaTzdMElYZrv2zUsOH4a9Vv2vJJT4EzJf+zKyGzMuy88S5GQ6mrAlv+2dyHY/
         JlpPBIJz5iBOyUh6WLIST0gLf3ds9gQkFPBZ17l4J+DHcmsY80KZs7Mg+GULE5VM6n0c
         8AOr34Zudolk5oijkfBH1WXDh5Ks/47DAmUH482VbJmb2pKAMI1Itvv2X9FwHNbmHWqo
         w02CYwe1OfSzxfyKpX2KqrSJL9/qAH4kYEhOu178pNeGLOSstddRF/stKmC/E5jQGs2J
         JCYVwFRF3CU8sS64Ucd3sQoSfjQ72ZRE9W0uFo4CsIukGLryDyhb0j0/KcwjfBCz4DVy
         LSCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789504715; x=1790109515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yi9YhsgJxg5RwheIV2uUP3vETgnxDCzaYZNW3S5FHwY=;
        b=aIUdFJCZHLXll/Q8tG6Ko9HzZqfspNX6GjUXKQ5LS8M3/+nHvcVYXbJxL3p47YG2jV
         u3Q4QtCSp/PZG1r3ltIqSWmhCch+cjxGSTwJfMUxOQJhX3aITdaJWPJe86GquUan8vbH
         IelokXPB6BSOH7FphVyKBO9dG+LOi9vn6oHr96La+XOXFxITKZPVQ8KfP6uWQzXcYK56
         obNvUo2BGbbb4KstDbdd3bOheDoloqh9ExxanDj9KwK4PZ0lqyeiQ3xP0NvoZ7ILYmDX
         9WdIpiARxWDiGp/V0ApU2lLUUNSrwd+vJwsLjphDyOskZzbBuPX/U5Pn1PT3MzpQyD7I
         RQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504715; x=1790109515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi9YhsgJxg5RwheIV2uUP3vETgnxDCzaYZNW3S5FHwY=;
        b=r+bUySCa0USjyckYbNiWHN6fZIhD5uP1X2m0LSZm2tNmGYXylJmZpNbwx+fxrV5vSF
         SO4YPw1h8UQ1/kIIX9H8il9JrZtDiwqQryfYkHCtU8s9wOxXabEwCHo8rlqvcI2sRsjy
         FKIR10bKdRhmThHTmDq8iIojbBInRy1hz141xtMLxh1QLDufiDzoxHuN389h3usnVXgW
         eDYhqGie4q/Mppejd7VJY8Cnf9F3PKrMYCkc/tTPaqT0Zc4lFt04B6oiPEFZzJM9pYV4
         9mtZ8wqgyhv+J4s0BVuCa/ctMARFra1kMQJJZFw8w+DQ6pJ39LHUQiQdHI/nsRSNzsxC
         wlWA==
X-Forwarded-Encrypted: i=1; AKwUvBzfehB/QsroBRDQEemqh8dLX/bnyu7nGdffIKpzUse33IhT2s09wGqguYWMuzyU4NXy8Map+sGBs/MvfSwCGESG@vger.kernel.org
X-Gm-Message-State: AFuF++k2ASmuCYirk0RXr2kHK4UIwUtb1RAn53owPHTkEfGfQSfhn8fp
	Uat+WGOuN5a/3GXtEI7RHQNOMl+Kdi3bIPt4VVtdkazP//2SGWJ1vTwyTRj5C94wS8Vx7aoCwKs
	WjmCKyTl0jlNecqh40eFxbuW6GzeHYOdPeA6kcIK5
X-Gm-Gg: AYBFou3M9q4L18gLDNhcBQ0Ye8K6x2GIUffvj5hcXGVUBCPCZduYb/OTXKBS/j+Nkq6
	GJ5Qoi2B1TwWxwQQpyGFEf5Vd4r/HKwrulhGdUMjuqVrCN/H4ok1niS6hNv2JpDlVEZ2/xyxgcS
	Ac8aZG52HTP4mH6n3bVbtg2aTcrd8UMhswEnbzsIw3gMohMChuDqpCzmPk1HS1PVo1qGiVCH3qb
	euiKCHnnMu1k4tQT96/hZTE7V+J09L4tWj6utJv3PIQvPUJQuR/RjvFoqM6D7kuBxpu0jM1t56Q
	2jHJ+B3NmuTHDChhUBpAvYXT0CMbwU/jCpB3420nePbw+55JJ/sAzK9hvcZYCW66RmjszuNgCEq
	ceHF0BZwjDg==
X-Received: by 2002:a05:622a:260f:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-5325087c7f5mr3564871cf.12.1789504714348; Tue, 15 Sep 2026
 13:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178003738371.62097.10360938456907564684@gmail.com>
In-Reply-To: <178003738371.62097.10360938456907564684@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:38:22 -0700
X-Gm-Features: AcwNN1UXK9UtE6mV4KOXzn7kUifeCNY5PJcwT2rEeTndVdIHwQO0dV89bOJN7GA
Message-ID: <CAP-5=fUbwmmuRj6p94+M4k869nHPXuNBXyvtizvgdjVG46w8MQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] perf: fix six memory-safety vulnerabilities in sched/header/subcmd
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:52=E2=80=AFPM Wang Haoran <haoranwangsec@gmail.c=
om> wrote:
>
> >From 9e71ffe9400fd54c4fc958b16229e5628271e4ad Mon Sep 17 00:00:00 2001
> From: Wang Haoran <haoranwangsec@gmail.com>
> Date: Thu, 28 May 2026 15:21:08 +0800
> Subject: [PATCH 0/6] perf: fix six memory-safety vulnerabilities in sched=
/header/subcmd
>
> Hi, I found several vulnerabilities in perf module.
>
> This series fixes six memory-safety bugs found in perf version 7.0.6,
> in the perf sched stats subsystem and related infrastructure.  All six
> were confirmed via AddressSanitizer + LeakSanitizer with crafted
> perf.data files; the reproducer files are attached to the individual
> patch emails.

Hi Wang,

Thank you for the contribution! Since there have been similar fixes in
perf-tools-next, could you rebase and resend this series. This should
automatically trigger a Sashiko review, which is currently missing.

Thanks,
Ian

> Privilege note
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> "perf sched stats record" requires root to capture
> scheduler events from the kernel.  However, "perf sched stats report"
> processes a perf.data file from disk and requires NO special privileges.
> This means an unprivileged attacker can hand a crafted perf.data to any
> user who runs "perf sched stats report" -- the attack surface is fully
> reachable without administrator rights.
>
> Crash-to-fix mapping
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   crash_err234_iter50.data  -> patch 1 (memory leaks in schedstat)
>   crash_sig6_iter840.data   -> patch 2 (heap overflow via bitmap_zalloc)
>   crash_sig7_iter210.data   -> patch 3 (SIGBUS via out-of-bounds mmap)
>   crash_sig11_iter2.data    -> patch 4 (array OOB in domain index)
>   (no poc)                  -> patch 5 (list_first_entry on empty list)
>   crash_err255_iter46.data  -> patch 6 (astrcat leak in parse_options)
>
> Vulnerability summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. Memory leaks in perf_sched__process_schedstat() / free_schedstat()
>    (tools/perf/builtin-sched.c)
>
>    Three distinct leak paths:
>    a) When zalloc() of the inner data pointer (cpu_data or domain_data)
>       fails, the outer struct is returned without freeing the parent.
>    b) In the after_workload_flag=3Dtrue branch the temporary struct and
>       its embedded data pointer are used then discarded without being
>       freed.
>    c) free_schedstat() frees each cpu/domain node but not the
>       cpu_data/domain_data pointers allocated inside each node.
>
>    ASAN/LSan reports 72-144 bytes leaked per crafted event processed.
>
> 2. Heap buffer overflow via u64->int truncation in do_read_bitmap()
>    (tools/perf/util/header.c)
>
>    bitmap_zalloc() takes an int but do_read_bitmap() passes a raw u64
>    read from the file.  If size > INT_MAX the int wraps to a small
>    value, a tiny buffer is allocated, and the subsequent loop that
>    reads BITS_TO_U64(size) u64 words from the file writes arbitrarily
>    far past the end of the allocation (heap buffer overflow).
>
> 3. SIGBUS from data.offset beyond file size
>    (tools/perf/util/header.c)
>
>    A crafted perf.data can set perf_file_header.data.offset to a value
>    larger than the actual file size.  mmap() succeeds because the
>    kernel accepts out-of-file offsets, but any access to the mapped
>    region triggers SIGBUS.  Confirmed with data.offset=3D0xff68=3D65384
>    against a 4760-byte file.
>
> 4. Array out-of-bounds write via unchecked domain index
>    (tools/perf/util/header.c)
>
>    process_cpu_domain_info() reads a domain index from the file and
>    uses it directly to index cd_map[cpu]->domains[], an array of
>    max_sched_domains entries.  A domain value >=3D max_sched_domains
>    causes an out-of-bounds write into adjacent heap memory.
>
> 5. list_first_entry() misuse on potentially-empty lists
>    (tools/perf/builtin-sched.c)
>
>    get_all_cpu_stats() and show_schedstat_data() call
>    list_first_entry() which, unlike list_first_entry_or_null(),
>    never returns NULL -- it computes container_of() on the list head
>    itself when the list is empty, producing a garbage pointer.  The
>    NULL checks that follow are therefore dead code.  A crafted
>    perf.data that causes an empty list makes these functions dereference
>    the garbage pointer.  Replaced with list_first_entry_or_null() plus
>    proper NULL guards.
>
> 6. Memory leak in parse_options_subcommand()
>    (tools/lib/subcmd/parse-options.c)
>
>    When subcommands are present and no usage string has been supplied,
>    parse_options_subcommand() builds a usage string with astrcat() and
>    stores the pointer in usagestr[0].  The pointer is never freed,
>    causing a 73-byte leak on every invocation.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> Affected version: perf 7.0.6
>
> Each patch was verified with:
>
>   $ make -C tools/perf EXTRA_CFLAGS=3D"-fsanitize=3Daddress,leak \
>       -fno-omit-frame-pointer -Wno-error=3Dstringop-truncation" \
>       -j$(nproc)
>
>   $ ./perf sched stats report -i <crash-file>
>
> Before the patch the corresponding crash file produced the ASAN/LSan
> report listed above.  After the patch the same file is either rejected
> cleanly (patches 2-4) or processed without any error report (patches
> 1, 5, 6).
>
> The reproducer files (crash_*.data) are attached to the individual
> patch emails; each is a minimal crafted perf.data (~4 KB) that
> isolates exactly one bug.
>
> Wang Haoran (6):
>   perf/sched: fix memory leaks in schedstat processing
>   perf/header: validate bitmap size before allocation in do_read_bitmap
>   perf/header: reject data offset beyond file size
>   perf/header: add bounds check for domain index in process_cpu_domain_in=
fo
>   perf/sched: replace list_first_entry with list_first_entry_or_null
>   subcmd: fix memory leak in parse_options_subcommand
>
>  tools/lib/subcmd/parse-options.c |  3 ++-
>  tools/perf/builtin-sched.c       | 32 +++++++++++++++++++++++++-------
>  tools/perf/util/header.c         | 17 +++++++++++++++++
>  3 files changed, 44 insertions(+), 8 deletions(-)
>
> --
> 2.53.0
>
