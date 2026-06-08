Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B93F1AA6
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931921; cv=pass; b=CbVBWNQqs8M/uvrvbYDt0Msz7qNZuHEZ8SPnJIzIJLIt7o+3CHwQNDlZmR7CoDWmNOHNjEFH1BU9QCZnUpyqJ0DIuaj5liTG8SAJRQnr7rRqSngjn5CAmCzXzmJ/4LkCT7TzNZSilGkMJ7zeHq/Z3HHFMLDZS5djdp69umKi+1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931921; c=relaxed/simple;
	bh=bCoATPmxueiREQEfhDMZFMTgeKe5UPwhQBcyIGzB25s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzwfAVEUVDqWHV8yulfuHBB2b0X2gJwnGvu9hYPW+5CUpcsGX3xK8ArEbcqvyIuu+iXafbKNrEELMhc5osbyZ3aZh1i7q7zkSu5kBhYiY8sGRZTg3pMiCJSRbQz1SKtPLyTRprpXl4zoCXXFj+EqgM/vbW90Y7oemj2v45OzbBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xn85ls++; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xn85ls++"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2d865383so323965ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 08:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931919; cv=none;
        d=google.com; s=arc-20240605;
        b=gL8XbpFeVZ7UTkMrSnGma30fViWTO9AoqjJe4HEMG/lBIh7E+mplq+GZaGOkqyn2rP
         NPdVCxaiacyEgohSCPxVPworSOclzoG/0+KHry3KsoCpv1XFMsxR/5+Djsb2xyFe6raX
         j84F+rq7Cxnu4FDRz+FPR1pmJeVgBIVLsqIitO4qyEXwdkUs/Itqy99/IUmO1Lu/6/z+
         CQOOBp8eauLoxkPvx9nQqwlWoEK6Gg4hElpPJU5rHBLo6HcmO/F6IHPZ/d86oG49n/iy
         1SN3e3BpIhUp0dPzn2mPr3DCD5o1z+S7mAUchAonn6FV0cFVckKdoXbT4WZvas9nI5c8
         KYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
        fh=KzTZJk+tmRETKajXbadoFU4Sj8kOVbrBQO4anw+wCZs=;
        b=B3PWNzDEjSujnTH2QqNO0KF1j4T5nKlGL+h4nRpUWFYAwSrSZDT6vUjpUCZ5s8qgwl
         Fx5N9fX3Wt9QPp8vOzyuxhRB1KKSnF5Lh9xYh52ItaqDe6RhzZKDZHggo1SHo6/PQkkJ
         ApuXUczXNJQ2B4jNIAuQ4Y3Rp3kFLvVvc+7d9HAVExp0mYm0ne18kFo71/WgwvF/P8W7
         3J02r9jQ4JC7NfP5mokpBHjiDYQ9mvfSuYnD0ci15YlclaX2+B7ibcSf/tU047gnvjne
         uVtiSPeCp7B9jmSgHcO+itU94tDFlphqlGpXtaGxXtIz1XXDXYFvXjAjwIirBHOn9tSa
         X0sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780931919; x=1781536719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
        b=Xn85ls++DHy8HAYRHBiyz35vEJ5ylUOFizq+S/LzXZteJ0PykBmKM6mj6kGMeJlona
         x1tRCl/FxWgj63bpyY/hOfhDw5JHbHpOLybvcW9R/liLtoftr6czlCJ+5VWYxnXEm+TO
         f2/eh704G1+bWcGseYGjZNeHwXmgkohzfzBGfPwHPcQvkGv+TQZW3uLl0322CEy6xKHH
         H0wsnkQ12EGp8iogVGyYdZwKg3/TJMu5os1JfIWSoxyniWXYwCCVJCJL377tZnTHsXKW
         L4Hjcggivi80xlveNX5k0yb53boJAdAPOTQShKZwNFRgWIS3r65HugVclExDU4uThNyA
         niRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931919; x=1781536719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
        b=dPtaz4jP2TMkTAxLiv30La9WU6LV6NKq64S4bKJvFgcO5L+YKl2zTRp13bVHID2Buz
         IOL8mcdJfU7pwNUO4aFOIcFkZTM9LwmHzzNGKwRwJ0GVz8ItatGYWG9aBkrskrOqJPGv
         mISQwau/pagUXTjFeT7aIkfQsM7DLlIxEKPKDrwW260RioXBXQ2tIpT2x2NIUfsYTRBi
         UTdbRAKvX+g/L7NIbh22AmctdDxdMdfglmHD6NWqzq8zN6hZ2uvrC5npE1JGI4pkORF3
         bMLo+utxDFZ9OPD1LN3Zjojt9xvZOc2jK5EMdzb9NufF6zJqEiuxvfcml0uYFJypXlzx
         PtXA==
X-Forwarded-Encrypted: i=1; AFNElJ+6/pu0vKuduaWhN44R0sYCjRlJ5L/CjQxG3YBgARPoBQTNBDm9QCaBrJ10rAHu6bUqhXNdLXFovi/OkxNmSIpC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjn1killj4bch2TIRXRCmt/nlsbLLzMhBxtGfMAlVb4XtEsILN
	2BKdi+dX4cQoFb9VEjZNvNSGufWK0HTQm7CYdppdcMLdzlexKPYKGO5q2fW2E7BcnqHgSQ6++n5
	c1xEpdVowAjm7UBtZhpAKFC2fyv8cVL7sVRU/7okF
X-Gm-Gg: Acq92OEZES5iSHnykbtFxBai14dLtPL+sClTVXtfFJSOYS+7eeIcf9UK//sdwUUuQG/
	hHxXCaingzDSSWP95oazUc/Nyi9H7YB98dxnhvn/f2BLCnGFlmWoKy+OtimGySJlW3XF4sUtuBF
	mpfowUAp772t9OzyPwMEKExuv1/k/NBXyoOzNCp4fYIdYQh/LEg4t99XCwAsQkksryzRWLauW1M
	ioOE7+4LOGecf0ucen4zYXB/KBVxQXzutLKFvOAukNBTj1fScfhX8wJNPByZACv5bEt3LX0jvNc
	qy5uqDCFPYPxriW3S7txBeP2cCkppFj1l9bHdsjfjPkYgDs=
X-Received: by 2002:a17:902:cf0b:b0:2c1:68ba:aa7b with SMTP id
 d9443c01a7336-2c1ebfd6b21mr4979645ad.20.1780931918327; Mon, 08 Jun 2026
 08:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125951.90425-2-tshah@linux.ibm.com>
In-Reply-To: <20260608125951.90425-2-tshah@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 08:18:26 -0700
X-Gm-Features: AVVi8Ccbl3xR6n4R1G4IBDcL4ljsGEMowhTpXPvSlvHHfbFgDr6fr_hFW1gbXG4
Message-ID: <CAP-5=fWbaEB=8niBhrUz6TLB2dgWv=kjrH8-Hn_PAmpUwqQThg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] perf: Add perf.data tracepoint events to
 trace.dat conversion
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 6:00=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com>=
 wrote:
>
> This RFC patch series introduces support for converting perf.data files
> containing tracepoint events into trace.dat format, enabling seamless
> visualization and analysis using KerneShark.

Thanks for doing this, this is a useful feature!

nit: typo KernelShark

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Background and Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently, perf and trace-cmd operate as separate tracing ecosystems with
> incompatible data formats. Users who collect tracepoint data with
> 'perf record' cannot easily visualize it in KernelShark's graphical
> timeline view or leverage trace-cmd's analysis capabilities.
>
> This creates workflow friction when users need to:
>
> - Visualize perf tracepoint data in KernelShark's interactive graphical
>   timeline
> - Share trace data between perf and trace-cmd workflows and toolchains
> - Perform architecture-independent conversion and analysis of traces
>
> This conversion bridge eliminates these barriers by enabling seamless
> data exchange between perf and trace-cmd ecosystems, allowing users to
> choose the best tool for each analysis phase.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Implementation Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The series implements the trace.dat file format specification (version 7)
> within perf's data conversion framework.
>
> **Patch 1/4: Core trace.dat Export Infrastructure**
> Introduces util/trace-dat.c and util/trace-dat.h implementing:
> - Per-CPU raw event buffer management (init, collect, free)
> - Ftrace ring buffer page construction
> - trace.dat section writers (strings, options, flyrecord sections)
>
> **Patch 2/4: Metadata Integration**
> Extends util/trace-event-read.c to write trace.dat metadata during
> perf.data
> parsing:
> - Initial format header (magic, version, endian, page size, compression)
> - Section 16: HEADER INFO (header_page + header_event)
> - Section 17: FTRACE EVENT FORMATS
> - Section 18: EVENT FORMATS (per system/event format files)
> - Section 19: KALLSYMS
> - Section 21: CMDLINES
> - Section 15: STRINGS (written last after all sections)
>
> **Patch 3/4: Conversion Backend**
> Implements util/data-convert-trace.c with trace_convert__perf2dat()
> function:
> - Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
> - Collects raw event data per-CPU using trace_dat__collect_cpu_event()
> - Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
> - Writes FLYRECORD section with per-CPU ring buffer pages
>
> **Patch 4/4: User Interface**
> Extends tools/perf/builtin-data.c with --to-trace-dat option:
> - Adds command-line option for trace.dat output
> - Mutually exclusive with --to-ctf and --to-json
> - Calls trace_convert__perf2dat() to perform conversion
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Current Implementation Details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> **trace.dat Format Version:**
> The implementation currently targets trace.dat format version 7, which
> is the stable version supported by current trace-cmd releases (v3.x).
> This version is hardcoded to ensure compatibility with existing
> trace-cmd and KernelShark installations. Future enhancements could add
> version negotiation or support for newer format versions as they become
> standardized.
>
> **Compression Strategy:**
> Compression is explicitly disabled (set to NONE) in the generated
> trace.dat files.
> This design choice:
> - Simplifies the initial implementation and testing
> - Ensures maximum compatibility across trace-cmd versions
> - Avoids external compression library dependencies
>
> Future work could add support for various compression algorithms (zlib,
> zstd, lz4) with runtime selection via command-line options, significantly
> reducing file sizes for large traces.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Usage Example
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ```bash
> *Record tracepoint events with perf*
> perf record -e sched:sched_switch -e sched:sched_wakeup -a sleep 10
>
> *Convert to trace.dat format*
> perf data convert --to-trace-dat=3Doutput.dat
>
> *Verify trace.dat structure*
> trace-cmd dump --summary output.dat
>
> *Analyze with trace-cmd*
> trace-cmd report output.dat
>
> *Visualize in KernelShark*
> kernelshark output.dat
> ```
>
> **Conversion Output:**
> ```
> [ perf data convert: Converted 'perf.data' into trace.dat format
> 'output.dat' ]
> [ perf data convert: Converted 2684 events ]
> ```
> **trace-cmd dump --summary Output:**
> ```
>  Tracing meta data in file output.dat:
>         [Initial format]
>                 7       [Version]
>                 0       [Little endian]
>                 8       [Bytes in a long]
>                 65536   [Page size, bytes]
>                 none    [Compression algorithm]
>                         [Compression version]
>         [buffer "", "local" clock, 65536 page size, 16 cpus, 1048576 byte=
s
>     flyrecord data]
>         [10 options]
>         [Saved command lines, 0 bytes]
>         [Kallsyms, 0 bytes]
>         [Ftrace format, 0 events]
>         [Header page, 206 bytes]
>         [Header event, 205 bytes]
>         [Events format, 1 systems]
>         [9 sections]
> ```
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Testing and Verification
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The series has been extensively tested with:
> - Various tracepoint events (sched, irq, syscalls, block I/O)
> - Mixed recordings containing both tracepoint and non-tracepoint events
>   only tracepoints converted)
> - Verification with trace-cmd report and KernelShark visualization
> - Memory leak testing with Valgrind (0 bytes leaked)
> - Cross-architecture testing (x86_64, ppc64le)

It seems that some of this could be a test to give coverage of the
feature. We have similar tests for other convertors:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_perf_data_converter_ctf.sh?h=3Dperf-tool=
s-next
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_perf_data_converter_json.sh?h=3Dperf-too=
ls-next

I think Sashiko has caught some coding issues, so I'll hold off on a
full review until the churn from Sashiko subsides.

Thanks!
Ian

> All generated trace.dat files successfully open in:
> - trace-cmd report (v3.1+)
> - KernelShark (v2.0+)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Next Steps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We would highly appreciate reviews, comments, and feedback on:
> - The overall architectural approach and integration points
> - Compatibility considerations with trace-cmd ecosystem
> - Performance characteristics for large-scale traces
> - Additional use cases or workflow scenarios
> - Future enhancement priorities
>
> Tanushree Shah (4):
>   perf/trace-dat: Add trace.dat export infrastructure
>   perf/trace-event: Write trace.dat metadata sections during parsing
>   perf data-convert: Add perf.data to trace.dat conversion backend
>   perf data: Add --to-trace-dat option for converting perf.data
>     tracepoint events into trace.dat format
>
>  tools/perf/builtin-data.c            |  38 +-
>  tools/perf/util/Build                |   2 +
>  tools/perf/util/data-convert-trace.c | 152 ++++++
>  tools/perf/util/data-convert.h       |   4 +
>  tools/perf/util/trace-dat.c          | 705 +++++++++++++++++++++++++++
>  tools/perf/util/trace-dat.h          |  79 +++
>  tools/perf/util/trace-event-read.c   | 259 +++++++++-
>  7 files changed, 1230 insertions(+), 9 deletions(-)
>  create mode 100644 tools/perf/util/data-convert-trace.c
>  create mode 100644 tools/perf/util/trace-dat.c
>  create mode 100644 tools/perf/util/trace-dat.h
>
> --
> 2.53.0
>
