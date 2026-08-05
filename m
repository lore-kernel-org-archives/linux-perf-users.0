Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC83CB8EB
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967344; cv=pass; b=oG6EuzhCTjDLBe3Soe/55T31JL3Ie7Cpig8+0PZbxurdAJKMrf3TDfdq4yGKEjOtnYwzEgLk4J/VjnIaag+BZxmopH7QpMh0Q4tI7bouwmbrNJjCxaXILxf6tPIZm9KS1RuDE5Mk3QHjEfJC+ZVWkBtQE6zUZC9blx/KniOkDak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967344; c=relaxed/simple;
	bh=RLFTPfQmpmexb1d//WoxUTcUm6BwYzRXeMumtLROugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTti9W2TaOfVlc71S6cLHBojA/ebOjVKIklu/dY9+otQ45l2JQgxBPUJJQFfAQQ0RWbDRGfxRAnjnKdHRWi2tX3kQlsCB8RU8ufRawBWthE201SOuXx3cVDr/INawhouWBbL0eEcPRyfXN6tL7c1nkkQY7AiLmgkeoHGll0Vu7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRK312dh; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRK312dh"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c15a5b265so107101cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 15:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967340; cv=none;
        d=google.com; s=arc-20260327;
        b=L3sZymi1avSJJDDcxTr4UcxLlIKXzim3a0t/Xicw1Kb9DAK/50HqFlRPPjRY7ADMhG
         JHHsmwp20pQtKOD9gbFL3djk7+XaqyFp5D+ErSfUxucsThBnGM/f4juKynA3XbxEYBzM
         HjScqq3fLKICKhlAKPx+M19JeEQHbT8p42r7CBI9TNbtF4MhNsSfdBvCs/2ymc062rKW
         A6GmfYmjjkAmj7M0IJo/3/3K3/WGXTpW1aUYr75jV/hv7Dwtjo8i9oiPkZZbnKPO+dse
         z7B5rtFR4jtBSVerLVh2dD8xXyUQR+FnCS/pgla9TrT0Fu5+FaocIwvvGT5HfXhY3FdA
         59Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xw4cV+hANwEVk5uV1zGNn6eOf/jMje1CiKXliNV4Ls8=;
        fh=kIwg6JGsPvwLk7cOqgYRfI8JlXw6QUnoIAIvVKgQ+44=;
        b=PxIc3IIIC76ZI9ZK2QMUyM+H/1Kl0DeYCFRRsXhnP4n1lLPWXmrHvytKc6bw1uD4Bq
         O7k/IgIHltTyv65k/H5eRjICydlM/iN1p1NwjsjA1oSVt0rPD8838RcWlcR61MAdtkcF
         tTIK+iVswK3i+t0l8SM4jA/qp4Tx4lGChkSxDVDLFEu5/TmMUZOTOXt2L36WkgzROLbY
         U7mTNRCyAcJejddxmTuYKTzjZkMJl28Dq8znDBAjHDJJBnww6WT1JK1/8TBc31Mi7xvD
         D9B4EKLeuxz+cCDkcKzDAoGNiSJkdRE5wV7iI53/A1uPiP13Wcv/cx5toDHWKlE0eRge
         lHzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785967340; x=1786572140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xw4cV+hANwEVk5uV1zGNn6eOf/jMje1CiKXliNV4Ls8=;
        b=MRK312dhtJX5wM2Hky4rGR9BJdeI74UF7wMVXgaRb7eWVefyEQXKnNTpuHqWCI5rfr
         fG0aV8wwVE/xpe9TmncBF6FqXI5STnmIkSnRixjEH0/WqE4KffL+A0HzOS2T7EKHslrY
         MpebmY3/qHygOTNDjydcZw+yiF9d7a1bG/gHqKcYW2uGv+qzOn/LukZTkaOS1g6vkom+
         J+GqrKC8XdcnmIG4rcliHYuTBWYBYmZaoHIB2TeD2Gld45wy3JNqbKYGboVZxhaGUhdI
         cIrlJ4vy82+fR7lHTHAvjRacJpqaufz8Z1FAeYDR6LepRK/wdef66Tia5jTKGdUOtzqe
         619w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785967340; x=1786572140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xw4cV+hANwEVk5uV1zGNn6eOf/jMje1CiKXliNV4Ls8=;
        b=IprJIp+FBewyTrswRfBpNRmExpIyuHHbLpNihNaJMu18IzwJDblkLBbcRf04orEAEv
         L0izFRJizdf+z9OUFZWV2cN0lC+98lE/0XbWJuunbabbS3pKevF/gxIMuYMxdDkVkkbF
         CKCd/l3bRuel4Q5NMNZ1pVBmOAM/Ar2mNbsQGzXk6WdBrVeQU8qyEaPsDsQ/8vlUM3//
         IXR4kpDIoB1GPjqERwp3akfp30gAhfBCt8FcLe0RYxVmc9AAgo5SZTqpp/kAZIUHNz5t
         OOjrrffGWSoumqJ9k3CmCOLF+U/tzfgIuL+nfLWM5ccXYa5qBCQDhoXWwBa0UCsmhykJ
         LXMg==
X-Forwarded-Encrypted: i=1; AHgh+RofHbcYf+XOq/jdht6qiwXfPK+DOTkGt8/qkNhsuzYjSI6axjyfl3VVmt5H+Lr0LeVrPTLQRotaXOACWfKnLIeg@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfDzODcxVCOQiTOAPAuE75P8HzM8jTWcANsJ90uIMq0YcDTbl
	d1EjFbp+6xgL7eYnqmlvnD5Df9Y+h8Nj20CfhdQBbx2AC2omh3ywadN4R2BG5DFEwa4UPE5slPR
	aKNKN3Wa1mM3qy4nSkfqTKCpkx4g1sl28+4ZK3tQq
X-Gm-Gg: AR+sD11N26dYnxrai6njAdFC2B8ZZo3sw617sww/nvwLUtYcc2ODDmvrb5/vrGEGsYY
	XNcUugFQC9UvdADQmEDpJ8FzbiXbxf1aEjIO/OK/ZAqdqn1RsErdLK7W+R7pH7wEV4IKlpoaaLs
	xt6okjZw8rMTEGZNSBtpqW3xB2tTaWMPZTFE4ew8540rhdM9b4KluCUkioOZ3eKqbzkFIHEUKxO
	iSJ8+5NWeH5PDd2ix0r9VYRm2wmck8nsq91jwIGT0KIgGlWDO6nDASwjVyMIVgvlcnkONMM2gI/
	OQh2T/TENeRDPcxSej3mshWFJGo99Vbb8kLR+byJo+UeydIN30z51lNpOg==
X-Received: by 2002:a05:622a:4c8d:b0:519:b655:235 with SMTP id
 d75a77b69052e-52cfea045dcmr1197651cf.3.1785967339675; Wed, 05 Aug 2026
 15:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805210751.287746-1-atomlin@atomlin.com>
In-Reply-To: <20260805210751.287746-1-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 15:02:06 -0700
X-Gm-Features: AUfX_mwsdkU_k60wEmHeXOOYlbhofU0wwvq5imiTvrPjS5ZCA3tQxfAWL28LSZ8
Message-ID: <CAP-5=fViE_+UoKhUJ2FHeyhuVKz6--yFcrADBqf1YMYhpLmOdw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] perf sched latency: Refine outputs, unit scaling,
 and histogram support
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	steve@abita.co, rishil1999@outlook.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:08=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> Hi Namhyung, Ian, Arnaldo,
>
> This patch series improves 'perf sched latency' by suppressing misleading
> empty table output, extending pipe mode stream processing, introducing
> dynamic unit auto-scaling for latency and runtime statistics, and adding
> latency histogram visualisation alongside time-span filtering.
>
> Patch 1 addresses an issue where 'perf sched latency' fell through and
> returned success (0) when perf_session__has_traces() failed due to missin=
g
> tracepoint events in a perf.data file. This caused empty header tables an=
d
> zeroed summary statistics to be rendered. In addition,
> thread__get_runtime() in map_switch_event() is guarded against potential
> NULL pointer dereferences under memory allocation failures.
>
> Patch 2 extends pipe mode stream support. Because event attributes in pip=
e
> mode are received dynamically during event processing, session->evlist is
> not populated prior to event processing.
> To handle pipe input correctly:
>     - Register the missing .attr, .tracing_data, .build_id, and .feature
>       callbacks in cmd_sched()
>
>     - Promote the handlers array to file-scope (latency_handlers[]) and
>       dynamically assign matching tracepoint handlers (or
>       process_sched_ignore) inside perf_sched__process_tracepoint_sample(=
)
>       when evsel->handler is NULL; replace process_sched_wakeup_ignore()
>       with process_sched_ignore()
>
>     - Perform the trace check post-processing when handling pipe data
>
> Patch 3 introduces dynamic auto-scaling for latency and runtime display
> columns (Runtime, Avg delay, Max delay). Previously, all values were
> unconditionally formatted in milliseconds (ms), making microsecond- or
> second-scale latencies difficult to read. Columns are now dynamically
> scaled to the most appropriate unit (ns, us, ms, s), column headers are
> updated, and format specifiers are aligned character-for-character with
> table headers.
>
> Patch 4 adds three new command-line options to 'perf sched latency':
>     --histogram (-H):
>             Displays an ASCII bar chart of CPU wait latencies between
>             snapshots
>     --hist-mode:
>             Configures the bucketing scheme to either logarithmic (log) o=
r
>             100 us equal-width linear (linear) mode
>     --time:
>             Filters trace event processing to a specified [start,stop] ti=
me
>             span

Thanks for these improvements and the tests for coverage! For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Changes since v7:
>
>  - Added a guard clause in perf_sched__process_tracepoint_sample() to
>    reduce loop indentation (Namhyung Kim)
>
>  - Converted dummy process_sched_wakeup_ignore() references to
>    process_sched_ignore and eliminated redundant code (Namhyung Kim)
>
>  - Replaced string comparisons with faster integer checks (i.e.,
>    thread__tid(...) !=3D 0) for swapper (idle thread) handling (Namhyung =
Kim)
>
>  - Added automated test cases for --histogram, --hist-mode, and --time in=
to
>    tools/perf/tests/shell/sched.sh (Namhyung Kim)
>
>  - Link to v7: https://lore.kernel.org/lkml/20260802210914.199941-1-atoml=
in@atomlin.com/
>
> Changes since v6:
>
>  - Fixed O(N) hot-path traversal overhead in
>    perf_sched__process_tracepoint_sample() for unhandled tracepoints by
>    assigning a dummy ignore handler (process_sched_ignore)
>
>  - Replaced evlist__set_tracepoints_handlers() in sample processing with =
a
>    per-evsel lookup to prevent -EEXIST early aborts and avoid dropping
>    late-arriving pipe events
>
>  - Updated commit message for the pipe mode patch to reflect the
>    single-pass handler assignment logic
>
>  - Link to v6: https://lore.kernel.org/lkml/20260801234008.176724-1-atoml=
in@atomlin.com/
>
> Changes since v5:
>
>  - Split pipe mode trace sample handling from Patch 1 into a standalone
>    patch (Namhyung Kim)
>
>  - Added a Fixes: tag to the pipe mode patch referencing commit
>    27295592c22e ("perf session: Share the common trace sample_check routi=
ne
>    as perf_session__has_traces")
>
>  - Updated commit log with before and after illustrations of table header
>    formatting
>
>  - Link to v5: https://lore.kernel.org/lkml/20260730185416.97166-1-atomli=
n@atomlin.com/
>
> Changes since v4:
>
>  - Added the missing .feature callback to sched.tool in cmd_sched()
>
>  - Fixed memory leak by reusing uncompleted work atoms when sched_in even=
ts
>    are skipped or lost
>
>  - Promoted the handlers array to file-scope (i.e., latency_handlers[]) a=
nd
>    added a dynamic lookup via evlist__set_tracepoints_handlers() inside
>    perf_sched__process_tracepoint_sample() whenever a sample arrives with
>    an unattached handler (i.e., evsel->handler =3D=3D NULL)
>
>  - Prevented double-counting wakeups (i.e., ignore sched:sched_wakeup)
>    in pipe mode and non-pipe modes
>
>  - Added missing trailing pipe in output_lat_thread's new auto-scaling
>    format string
>
>  - Stripped redundant prefix strings from each row's format string to
>    produce a clean, tabular output
>
>  - Link to v4: https://lore.kernel.org/lkml/20260729144451.38286-1-atomli=
n@atomlin.com/
>
> Changes since v3:
>
>  - Registered Missing Callbacks. In perf_tool__init configuration inside
>    cmd_sched(), added the .attr, .tracing_data, and .build_id callbacks.
>    Without these callbacks, pipe mode drops header attributes entirely,
>    preventing tracepoints from being populated in session->evlist
>
>  - Introduced an explicit post-processing pipe check. This ensures that
>    pipe mode aborts correctly and does not produce superfluous empty
>    latency tables when no trace samples are available
>
>  - Prevented potential NULL pointer dereference. Added a NULL check for
>    thread__get_runtime() in map_switch_event() under memory allocation
>    failures
>
>  - Fixed column alignment. Modified format specifiers to align
>    character-for-character with header column widths across all rows
>
>  - Adjusted header label padding. Updated header label padding and column
>    width delimiters in perf_sched__lat() to match the exact field format
>    specifiers printed in output_lat_thread()
>
>  - Fixed swapper histogram inclusion. Excluded "swapper" (i.e.,
>    CPU-specific idle thread) from global_hist buckets
>
>  - Preserved task state machine across --time bounds. Moved time-window
>    filtering inside add_sched_in_event() to gate latency statistics
>    recording without breaking wakeup state tracking across time interval
>    boundaries
>
>  - Link to v3: https://lore.kernel.org/lkml/20260726032533.712462-1-atoml=
in@atomlin.com/
>
> Changes since v2:
>
>  - Ensured vertical pipe separators align across all latency table column=
s
>
>  - Excluded "swapper" (idle thread) latency samples from global_hist
>
>  - Preserved task state machine transitions across --time boundaries
>
>  - Suppressed empty table headers, total lines, and histogram graphs when
>    no matching trace samples exist (e.g., when --time, --CPU, or --pids
>    exclude all samples), outputting "No matching trace samples found."
>    instead
>
>  - Linked to v2: https://lore.kernel.org/lkml/20260725173341.679782-1-ato=
mlin@atomlin.com/
>
> Changes since v1:
>
>  - Fixed integer overflow in latency_bucket() (Ian Rogers)
>
>  - Linked to v1: https://lore.kernel.org/lkml/20260724142901.634761-1-ato=
mlin@atomlin.com/
>
> Aaron Tomlin (4):
>   perf sched: Suppress latency table output when trace samples are
>     missing
>   perf sched: Handle missing trace samples in pipe mode
>   perf sched latency: Auto-scale latency and runtime display units
>   perf sched latency: Add histogram and time interval options
>
>  tools/perf/Documentation/perf-sched.txt |   6 +
>  tools/perf/builtin-sched.c              | 347 ++++++++++++++++++++----
>  tools/perf/tests/shell/sched.sh         |  29 ++
>  3 files changed, 332 insertions(+), 50 deletions(-)
>
> --
> 2.55.0
>
