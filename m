Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14A47FAFF
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512115; cv=pass; b=Rh4CFAph9dh1YS9WnQQIV29/N+ZSpXbj3iEEUNIcr6KSZ8pEBa8Pfz2T2mFMieHwxOn1fFtqiJbU79ZzPaPzK3NynUEqJ9A+g6Ko40Fo8IlfMSMtdeKbzoWjK3OlkLxAUTd6Q6En5gmhAvZGHCXpEcrJn1gAi21i2RDzsUxojRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512115; c=relaxed/simple;
	bh=ZqWDXepLUp8mVVJCQuZKOVz7QlFS0kjh5CBOZOFiWG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQsI6ObZQGPcbP6VliupvMVXu+0srXs4IFieVWnAicwSma/f2j42Cxh9uUD20t5XnLpL7GRcItS3LnZXQZn+DDUoW7ECrNrq2A6Xc7VDoYNnYWrcf2nXtWsNpI+YowaIKtMu+HpHFdteDpKxXOAf+Bv8Tt21GEkT4MhepvvCNik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWuGknFp; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWuGknFp"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso47181cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512112; cv=none;
        d=google.com; s=arc-20260327;
        b=D25olt+0TximfSnwQQoQc+xLGxW1WnyIrNtm2vQzLB4YlNuXgJC6gCxUSQ12TqI2fa
         P3G3TRw0u91ux/TYXRhltF9Pu0Ptfq90GPmaML9TiRaVTtFL2CkPoaj6lMv9V2o0nbQ7
         9/WWec4QQO4kPYxMLm+NpyNFucymnu9dueN0zPa7OKTRKe9ooBrXNpUeQySUEr2WNTae
         MpDaMKUnT9v4thEjBhDKlmqEcGOxO4o/2QLWqR+Ewm33h9uYV5d4gvDv5lLkkxRUil2G
         qOSMOZ1VX6vr25KmlWe8duPmGhVZXriSuZbpv169nwBFld+xD7YoSfkbTprTIljGMSPJ
         0YTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
        fh=u2SrDaF3Ogr9921md5bZWyrUN8eR4JK3PfZfMzqfeW8=;
        b=mb71nXddNbYVZ2q5icDM06tmO7+dJRRLgZOxICJqcd8cXxNdPDFpgTzPqAeL9p7Jb0
         9q049wIjUQ6eNyAuxJSDKjIRuRGY2xgPf18HdUYt7SPHKfERL3eahGi98adcbRrlZ+o+
         V8TIjlQ6JqJqUFOxAQ0MtCCIV6PRT6mSM/vfFRjeAL7RnqZCTJvFz4tGTHgt9mDbcvtp
         rwGbAXYqzfjReWXch8uLKgGx+Kn0CSXYGkGMotdUTWeTJqstIeB05rc+p/UF+aon0AqW
         D1Gu1lBHk5FcF/zbmRhvarVN/2mVETuAPzcyZnliQAFMkzszkmOFMBwm49zpEgLT1qes
         lPEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789512112; x=1790116912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
        b=bWuGknFpHldokpfe6NUxfBPy61UCa7aWLDwjB80br1OAf/UrlWtehEqzyovzRSxgCg
         heJuYizmG4PcVqVrO5x4CK9BE6lKtwUWBWrMtXxdG5UagiF6P998ANi9T46tiKjLIdRX
         Rf9oYx+E8859uvGfL0Hbd2JLKad/sHT44duv77bhHnqN2Z2dNTEqpn7Yf4aDV2P74J8n
         uTVs4Ya8Yu/ygETF9vQQu0twaAqbv429LkNjvITP/kK9fu19YDDyV4ikMzbV3jZCnUyI
         R89+HEhE2TIL0ZwawIaYxAtnH0pdSZEJ/vAsaKGc1NxMhBG4COI6dWEvltUXntJ98Liq
         g3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512112; x=1790116912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
        b=mZ/dPj7Quz7QTaLs14ZtRTqw8nBWHaVp42/5/4Seq/rfMN6SF52fuPGwwuI9UH8Odp
         ahs+BNA4Gp0V4gErKDcTNNN1I30UXBmcQcM9Rkwj3enQjVoE2LnY+7xh/KIo/zmHHxxU
         JOvp2JMq2RYbEm7NGPRF/pjqHD8X2sOv7vhtrwCubhrZ2o4L0ulsYb11cm1b1iS0HG8e
         oqe4K+FvzLJ6y8vZDFop8atml3s5cMDuGGjNiPv4/8U7Gx6dtLe7/J9u5k4n5pTqlSxi
         rJRG3JWxKv750UvgtjDeG/+y/WOGxnqGUiAfnMw3q+qOd5sVQ63nfxxovpX7TSAZLPl0
         fhKQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9vG4OvQ/vMXHQtJwsI55na3EgnkQZ1OvPoGeJCEQkJBWkzCTNAkvTNVfikjrj/oxdBR/dRZ0gksp3LqYuPxKE@vger.kernel.org
X-Gm-Message-State: AFuF++kitdpYLQI9AoJqMOUH26ysvkP9WVIIcIK4EslB+y5r718/76CX
	NNaAj+24jdQdIUw5Vw5JeDm4ueyKTWkI6KtisiOoGC5pGkDbv/D+np54lRbZ1ERmg8xWOlgTwqf
	lfv9MzZ4PLFvX8pkJWmSWYFuqIWHtBinnqYFCTAf5
X-Gm-Gg: AYBFou3rOmXYrv9W6kMdvtvZ/Sj+CJp97M339HLL1Vyi4YJ3wA5nxryhGgaVSFpjgH6
	o6U3yGWk1dT5QApWFnEqjnElz2jAS1eYVkGkVzgR+oL4ETTIYvVSOMt/y0r78FZpC0PuNUF9KG5
	jys0qAMbXDvGTfd+8f7GlxgH7YR54+UTapSMV/ZFwkU6WDMBvypgZ3fAuQvrM+8myEM6tOPXx3O
	tuh3MeMWPtedw1LI8ZVuYyu0SV9RYATzE+QbSLMvS2auTd839l/cCCfmpwzFF+oYnWzSMVffc2T
	a4tOUiMzvVL0ipr+spNfTuLXHZpH60tt12mzWBg5ApiLtUzJMYo3FeF8cPsIEnC6wii5lxzZadb
	EYJ4nPLSZOw==
X-Received: by 2002:a05:622a:580e:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-5327f5e8dedmr1378711cf.9.1789512106116; Tue, 15 Sep 2026
 15:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807144135.2607-1-atrajeev@linux.ibm.com> <083A4990-6158-4C25-B29C-78A8AF9ADCF3@linux.ibm.com>
In-Reply-To: <083A4990-6158-4C25-B29C-78A8AF9ADCF3@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:41:34 -0700
X-Gm-Features: AcwNN1UEG7pVwjSnb00JbKXR74IHKWDgQf1sITA6eKr5Av6Gb5msdaS6bHv88Y4
Message-ID: <CAP-5=fX-sUhf06gSoib1S5y-fFTg=dNmXkNXJ-LEtgj3fO4KbQ@mail.gmail.com>
Subject: Re: [PATCH V5 0/6] tools/perf: Add powerpc HTM auxtrace support
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com, 
	usha.r2@ibm.com, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:11=E2=80=AFPM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 7 Aug 2026, at 8:11=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.co=
m> wrote:
> >
> > Overview:
> > This series adds perf tool support for capturing and processing Hardwar=
e
> > Trace Macro (HTM) trace data on POWER systems.  HTM exposes raw bus-tra=
ce
> > data via the H_HTM hypervisor call.  The kernel-side HTM PMU driver
> > (submitted separately) streams this data into perf AUX buffers and emit=
s
> > memory configuration as PERF_SAMPLE_RAW records.
> >
> > This series wires up the record and report sides in the perf tool so th=
at
> > 'perf record' collects HTM data and 'perf report' writes the trace and
> > memory configuration to files ready for post-processing with htmdecode.
> >
>
> Hi All,
>
> I am currently working on addressing Sashiko's review comments for V5 of =
the patch series.
> Before I proceed with posting V6, requesting for any feedback or suggesti=
ons that I should incorporate in V6, apart from Sashiko's comments.

Hi Athira,

Did you get what you needed for V6? I see Adrian's reviews.

Thanks,
Ian

> Thanks
> Athira
>
> > Patch overview:
> > Patch 1 refactors the existing powerpc auxtrace dispatch.  All VPA-DTL
> > recording logic is moved from arch/powerpc/util/auxtrace.c into its own
> > file, arch/powerpc/util/vpa-dtl.c, leaving auxtrace_record__init() as a
> > thin per-PMU dispatcher.  This is a prerequisite for adding the HTM
> > recording path cleanly.
> >
> > Patch 2 adds the HTM recording path (arch/powerpc/util/htm.c and
> > util/powerpc-htm.h).  htm_recording_init() sets up the auxtrace_record
> > callbacks.  htm_info_fill() stores the PMU type and a (cpu, attr.config=
)
> > pair for each htm evsel into the PERF_RECORD_AUXTRACE_INFO priv[] area.
> > The decode side reads these back to map each AUX buffer to its
> > (node, chip, core) target using event->auxtrace.cpu.  PERF_SAMPLE_RAW i=
s
> > also enabled here so that memory configuration records are captured
> > alongside the AUX stream.
> >
> > Patch 3 adds a generic weak arch_perf_record__need_read() hook in
> > builtin-record.c.  When the hook returns non-zero, perf record performs
> > an extra mmap-read pass before disabling events.  The drain loop runs
> > until the hook returns 0 or no forward progress is made, then the event=
s
> > are disabled and closed normally.
> >
> > Patch 4 implements arch_perf_record__need_read() for powerpc.  It reads
> > event->count for all open htm evsels via perf_evsel__read() and
> > accumulates the values.  The kernel driver sets this count to the numbe=
r
> > of 128-byte HTM trace records written on a successful dump, 1 when the
> > AUX buffer is temporarily full but the hypervisor stream is intact, and
> > 0 once the stream is exhausted or a hard error occurs.  A non-zero tota=
l
> > causes the recording loop to perform another read pass.
> >
> > Patch 5 adds PERF_AUXTRACE_POWERPC_HTM to the auxtrace_type enum and
> > wires the dispatch in perf_event__process_auxtrace_info().  It also
> > amends htm_info_fill() to set auxtrace_info->type now that the constant
> > is available.
> >
> > Patch 6 adds the full HTM decode path in util/powerpc-htm.c.
> > powerpc_htm_process_auxtrace_info() reads the (cpu, config) pairs from
> > priv[] and builds a cpu_configs[] lookup table.  As each
> > PERF_RECORD_AUXTRACE event arrives, process_auxtrace_event() maps it to
> > the correct target and writes the data to htm.bin.nX.pX.cX.tX immediate=
ly.
> > PERF_RECORD_SAMPLE RAW records are written to translation.nX.pX.cX.tX b=
y
> > process_event().  Per-run first-write tracking (htm_target_seen) ensure=
s
> > O_TRUNC on the first write and O_APPEND on subsequent writes.
> >
> > Patches not included in V2:
> > Three patches present in V1 are intentionally dropped from this series
> > and will be submitted as a follow-on once the core infrastructure gets
> > integrated:
> >
> >  - htmdecode integration: V1 patch 6 invoked the external htmdecode
> >    tool via fork/exec after writing htm.bin.* to decode the raw
> >    bus-trace data in-process.  This is deferred because the interface
> >    between perf and an external decode tool needs more discussion.
> >
> >  - Physical-to-logical address mapping: V1 patch 7 read the current
> >    partition ID from /proc/powerpc/lparcfg, parsed the translation.*
> >    memory map entries, and mapped physical addresses in the decoded
> >    trace to logical addresses within the LPAR.
> >
> >  - Synthetic sample generation: V1 patches 8 and 9 created a
> >    PERF_TYPE_SYNTH event named "htm", injected synthetic perf samples
> >    with the translated logical addresses as sample IP, and wrote a
> >    separate .out.l file with logical addresses alongside the decoded
> >    trace.  The appropriate abstraction for synthetic HTM samples in the
> >    perf tool requires further discussion.
> >
> > Usage example:
> > Collect HTM trace data from a single chip target:
> >
> >  # perf record -C 9 -m,256 \
> >      -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1/ sleep 3
> >  [ perf record: Woken up 1 times to write data ]
> >  [ perf record: Captured and wrote 256.277 MB perf.data ]
> >
> >  # perf report
> >
> > Output files written by perf report:
> >
> >  htm.bin.n0.p2.c0.t1       raw HTM bus-trace data
> >  translation.n0.p2.c0.t1   memory configuration records
> >
> > Multiple targets can be collected simultaneously:
> >
> >  # perf record -m,256 \
> >      -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1,cpu=3D8/ \
> >      -e htm/nodalchipindex=3D1,nodeindex=3D0,htm_type=3D1,cpu=3D9/ \
> >      -a sleep 10
> >
> > Testing:
> > Tested on POWER11.  Both htm.bin.* and translation.* files are produced
> > correctly for single and dual target collection.
> >
> > Note: Link to kernel patches:
> > https://lore.kernel.org/linuxppc-dev/20260807143734.1224-1-atrajeev@lin=
ux.ibm.com/T/#t
> >
> > Athira Rajeev (6):
> >  tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
> >  tools/perf: Add AUXTRACE recording support for powerpc HTM
> >  tools/perf: Add arch hook to drain remaining data before event close
> >  tools/perf: Add powerpc callback support for
> >    arch_perf_record__need_read
> >  tools/perf: Add powerpc HTM auxtrace event processing support
> >  tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE
> >    records
> >
> > tools/perf/arch/powerpc/util/Build      |   2 +
> > tools/perf/arch/powerpc/util/auxtrace.c |  98 ++----
> > tools/perf/arch/powerpc/util/evsel.c    |  77 ++++
> > tools/perf/arch/powerpc/util/htm.c      | 185 ++++++++++
> > tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 +++++
> > tools/perf/builtin-record.c             |  65 ++++
> > tools/perf/util/Build                   |   1 +
> > tools/perf/util/auxtrace.c              |   4 +
> > tools/perf/util/auxtrace.h              |   1 +
> > tools/perf/util/powerpc-htm.c           | 447 ++++++++++++++++++++++++
> > tools/perf/util/powerpc-htm.h           |  43 +++
> > tools/perf/util/powerpc-vpadtl.h        |   3 +
> > tools/perf/util/record.h                |   4 +
> > 13 files changed, 954 insertions(+), 72 deletions(-)
> > create mode 100644 tools/perf/arch/powerpc/util/htm.c
> > create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
> > create mode 100644 tools/perf/util/powerpc-htm.c
> > create mode 100644 tools/perf/util/powerpc-htm.h
> >
> > --
> > 2.53.0
> >
>
