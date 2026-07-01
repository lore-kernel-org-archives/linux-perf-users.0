Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955403C108E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897167; cv=none; b=M/ljdyGaOyeACaL8THEsQCQ029XvG41gQ9p7wIMw/5JBu+mc27Arj2yuSU7VsPdZYz4JCotCOICiKyoFYQjulyimtwwGf8W8oalreIw9N5VmC+kASGrculpfBhmAu+PrJRzhukrR17BqY8me1cCzqOpWUFxcI3UBrQkn6H+6xrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897167; c=relaxed/simple;
	bh=O5bPxOppBWUJaSa+KN19rj2apzqoap5qX+lJP5ESxwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UdavEYa9rZhp4OETqeMsHNe0ozZnQFRr0fN6saLr92w0jJ38M8gq87r3jNd1NXXjEtsSBL5A2wJEzfnIfAhjLm/iUJbCleelwfJDUlmt9lg3PZoaSgZ/s8aPi3l+Gh+xJVDOK4lobUi1r1/TykTUoMD1wIqPPFq6n6tCp4PY8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwJRtZgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwJRtZgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6E21F000E9;
	Wed,  1 Jul 2026 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897166;
	bh=O5bPxOppBWUJaSa+KN19rj2apzqoap5qX+lJP5ESxwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwJRtZgj668s/17TvpRfqo2ERIF2lL2VfbITcVIeCB8Dr5o6tKg+zscYnSYJHgi+x
	 6QVBPzx4ZKPSr/qUNau7dU/KxMqtKPrZ/DuhKrLGJwKsEbfhG8aQRnLQW7EbRZ+JcN
	 YqHb7f0bn+kf3AXvUZLYud4WYLzqWnS0mo7lK9eiv4Fq9zaFRc5rjxh4MPQJTUDYhv
	 KcBtdu/upvF/6xwq+rrr/HZlVHueLT55uGPcwG27ORPFc1r3QqjJsh+P0r8CbRF4X8
	 phosPQGtGPUI/FHYOhlF3z7HmiHD4ukbFMcUIOGNjVU3VAxerQtkCUREtlrmnTrd4I
	 e8gZNgV/7ODwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] tools/perf/powerpc: Add event name as htm of
 PERF_TYPE_SYNTH type to present htm samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-9-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-9-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:12:45 +0000
Message-Id: <20260701091246.5B6E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Error handling path bypasses auxtrace_queues cleanup, causing a me=
mory leak and leaving a dangling pointer that leads to Use-After-Free.
- [High] Unchecked direct access to `evsel->name` passed to `strstarts()` w=
ithin an event loop.
- [High] Unchecked dereference of `evsel->core.id` when synthesizing event =
IDs.
- [High] Synthesized `PERF_RECORD_SAMPLE` events lack payload serialization=
, causing downstream parser faults.
- [High] Off-by-one accounting of translation file headers causes out-of-bo=
unds mmap read and data corruption.
- [High] Processing the auxtrace queues for every PERF_RECORD_SAMPLE duplic=
ates trace data and heavily impacts performance.
- [High] Missing POSIX libc headers violates musl compatibility guidelines.
- [High] Massive out-of-bounds heap read in `write_htm` due to unvalidated =
length field from untrusted auxtrace data.
- [High] Missing `NULL` check on `evlist__event2evsel()` return value leads=
 to immediate crash on malformed events.
- [Medium] Using strstr from the beginning of the line inside a regex match=
 loop corrupts the output when a trace line contains multiple addresses.
- [Medium] Using `unsigned long` for 64-bit PowerPC addresses truncates the=
m on 32-bit hosts, breaking cross-platform analysis.
--

(Note: The standard patch quoting format has been altered to a free-form
summary due to system recitation restrictions. No code diffs are quoted bel=
ow.)

commit bb9556f09003be87e7766614cf5cfdd9647bd477
Author: Athira Rajeev <atrajeev@linux.ibm.com>
Subject: tools/perf/powerpc: Add event name as htm of PERF_TYPE_SYNTH type =
to present htm samples

This commit creates a synthetic "htm" event to present hardware transaction=
al
memory entries as samples in perf. It adds configuration values and uses the
logical address as the sample instruction pointer to aid in identifying hot
logical addresses.

[Severity: High]
In powerpc_htm_process_auxtrace_info(), if powerpc_htm_synth_events() retur=
ns
an error, the code jumps to the err_free label. Does this skip the cleanup =
of
the auxtrace queues and leave a dangling pointer in session->auxtrace?=20

It looks like the err_free_queues label handles both auxtrace_queues__free()
and setting session->auxtrace to NULL, which might be needed here to prevent
a use-after-free during session teardown.

[Severity: High]
In powerpc_htm_synth_events(), the loop iterates over evsel entries and che=
cks
if they start with "htm" using strstarts(evsel->name, "htm"). Could
evsel->name be NULL for unnamed or dummy events?=20

Passing a NULL name into strstarts() could trigger a segmentation fault.

[Severity: High]
Also in powerpc_htm_synth_events(), the synthesized event ID is generated by
adding a fixed offset to evsel->core.id[0]. Is it possible for evsel->core.=
id
to be NULL if the event was recorded without sample IDs?=20

Dereferencing it directly in that case might cause a crash.

[Severity: High]
Looking at powerpc_htm_create_sample(), the synthesized event size is hardc=
oded
to exactly sizeof(struct perf_event_header), which is 8 bytes. Does this om=
it
the actual sample payload serialization that perf_event__synthesize_sample()
usually handles?=20

Downstream tools parsing this PERF_RECORD_SAMPLE event might expect a paylo=
ad
based on the sample_type, potentially leading to out-of-bounds reads when
they process the 8-byte event.

[Severity: High]
In write_htm(), the total number of entries is incremented to account for t=
he
32-byte header, and this is added to htm->htm_mem_entries. However, when
create_mem_maps() later maps the file, it skips the first header but loops
exactly htm->htm_mem_entries times.=20

Will this result in reading past the end of the memory-mapped region?
Additionally, if multiple chunks were written, would their embedded headers
be misinterpreted as valid trace data?

[Severity: High]
In powerpc_htm_process_event(), the code iterates through all auxtrace queu=
es
and writes their buffer contents to the file for every PERF_RECORD_SAMPLE
event processed.=20

Does this repeatedly duplicate the entire trace data? Since the buffers are
not consumed or marked as processed, this might result in an exponentially
growing trace file and significant performance degradation.

[Severity: Medium]
In process_trace_file(), while iterating through regex matches for addresses
on a line, the replacement logic uses strstr() from the beginning of the li=
ne
to find the "addr:0x" prefix.=20

If a single trace line contains multiple addresses, won't strstr() repeated=
ly
find the first occurrence instead of the current match, potentially corrupt=
ing
the output?

[Severity: Medium]
The physical and logical addresses from the HTM trace are 64-bit values, but
powerpc_htm_create_sample() takes an unsigned long address.=20

On 32-bit host systems performing cross-platform analysis, could this trunc=
ate
the 64-bit addresses? The boundary check for kernel addresses would also be
optimized out on 32-bit hosts. The addr_map structure seems to share this
same truncation issue.

[Severity: High]
This file utilizes several standard POSIX functions and constants such as
fopen(), malloc(), strtoul(), and O_WRONLY.=20

To comply with musl libc compatibility guidelines, shouldn't the standard
headers like <stdio.h>, <stdlib.h>, and <fcntl.h> be explicitly included
at the top of the file?

[Severity: High]
In write_htm(), the num_entries value is parsed from the incoming auxtrace
data, converted to cpu endianness, incremented, and then passed directly to
fwrite().=20

Is there a missing bounds check to ensure that the calculated size does not
exceed the buffer's actual bounds? An unvalidated length could lead to an
out-of-bounds heap read if the trace data is malformed.

[Severity: High]
Both powerpc_htm_process_event() and powerpc_htm_process_auxtrace_info()
fetch an evsel using evlist__event2evsel() and immediately dereference its
config attribute.=20

If the event's sample ID isn't found in the evlist, could
evlist__event2evsel() return NULL? A check might be needed to avoid a
segmentation fault on malformed perf.data files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D8
