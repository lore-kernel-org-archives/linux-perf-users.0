Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609733E34B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924434; cv=none; b=f5Rn8JRlsN57fG26nwhiuc6nvLo+/2+RXmOj7+ZTpyFzILCP7KC9Cvm0qp+G5SzNgwsDBy8TjcbSvqIfn/JPt3hnweH3rKKvWKRfJiVPBzxPgX5kEjwuG+4b5vqnMZmbLbpfy9aOdT3uFHriINluTWuRAlgTkA9lkjwWuQFdgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924434; c=relaxed/simple;
	bh=GftzvG4oGvK9Zt+cnd7p8s9F1SZ/00EFBgvHJcxnUyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhsU8WwJ+tThGGlHDF9dMovl7ZsiqZtvyx1svo7ryuEf8oL2LJrg6mSz3FGpyZroX7LAhmqrwhMZAxWsvaKKFFXeTW7k5DF1VsgdmgibiyA5HA4mUaJft7p7pLsQzbahI/JD0ffBg2330BTgtciwYu4gWizaapMD4f6+SmlA/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWfuxLAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWfuxLAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2831F00893;
	Mon,  8 Jun 2026 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924432;
	bh=vZgQ7b/rn30Hy2u0NFUzCFK0NV91THT7B0r8vL2GR70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWfuxLAPhVFgbrei4FhYGC1s4LamWHMMGvmldCgt/RMjnXUoK9Wj4DE/wqYxuKfjz
	 wX/pFAf0aW7z3sL4aRIxOYqsO4jo6McwEbmjv0hojor7x7Pyxmm05JS62VOko7SHWd
	 jNeg9EU0ZdWZh2wFzYmZi4+nHSIjQ9z0JXn3LFw5AtuLHTfqVqcZphj9d1hUlPvXhV
	 8xBtGn0v8pIQ/nk16aNioczoC8buu+CLZ5XY4FeKfGagfQB6YGVVIMA6wp5JuGVbLw
	 W8+oIR2RmP6HGlEZ6riIKeUqm+okZzUOGx+fhHBfh7a/aQsGE23Vbz+8iIcylkj0/t
	 BCLDCdqouY5kw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] perf/trace-dat: Add trace.dat export
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608125951.90425-3-tshah@linux.ibm.com>
References: <20260608125951.90425-3-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:13:52 +0000
Message-Id: <20260608131352.BA2831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Sequential realloc failures cause a use-after-free, double-free, a=
nd memory leak.
- [High] Unchecked realloc overwrite leads to array leak and a later NULL p=
ointer dereference.
- [High] Unchecked calloc failure leads to NULL pointer dereference in fwri=
te.
- [High] Heap buffer overflow when processing abnormally large trace record=
s.
- [High] Unchecked get_tracing_file failure leads to NULL pointer dereferen=
ce in fopen.
- [High] Ftrace ring buffer format is incorrectly constructed for events >=
=3D 28 words, causing data corruption.
- [High] Timestamp deltas larger than 27 bits are silently truncated.
- [Medium] Direct return on record allocation failure bypasses cleanup, lea=
king accumulated memory.
- [Medium] The section_size for the flyrecord section is incorrectly calcul=
ated, violating the trace.dat format.
- [Medium] The current event record is leaked if flushing the page or reall=
ocating the batch array fails.
--

commit b7f763e536c02304fb52bceb9c78dd92220fa81a
Author: Tanushree Shah <tshah@linux.ibm.com>

perf/trace-dat: Add trace.dat export infrastructure

Add new utility files util/trace-dat.c and util/trace-dat.h
implementing the infrastructure for exporting perf.data tracepoints
to trace.dat format compatible with trace-cmd and KernelShark.

> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
> index 0000000000000..aa34a7b89b7a3
> --- /dev/null
> +++ b/tools/perf/util/trace-dat.c
[ ... ]
> +int trace_dat__collect_cpu_event(int cpu, unsigned long long ts,
> +				 void *raw, unsigned int raw_size)
> +{
[ ... ]
> +	if (cpu_events->count >=3D cpu_events->capacity) {
> +		cpu_events->capacity =3D cpu_events->capacity ?
> +				       cpu_events->capacity * 2 : INITIAL_EVENT_CAPACITY;
> +		cpu_events->events   =3D realloc(cpu_events->events,
> +				       cpu_events->capacity * sizeof(*cpu_events->events));
> +		if (!cpu_events->events)
> +			return -ENOMEM;

[Severity: High]
If realloc fails, it returns NULL and overwrites cpu_events->events, leaking
the original memory block. Later, trace_dat__free_cpu_buffers() iterates ov=
er
the events and dereferences trace_cpu_data[cpu].events[i].raw. Can this cau=
se
a segmentation fault during cleanup since events is NULL?

> +	}
[ ... ]
> +static int trace_dat__write_page(FILE *fp, unsigned long long base_ts,
> +			char **records, int *rec_sizes, int nr_recs)
> +{
[ ... ]
> +	page =3D calloc(1, trace_dat_page_size);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nr_recs; i++) {
> +		memcpy(page + offset, records[i], rec_sizes[i]);

[Severity: High]
When a trace event's size exceeds trace_dat_page_size - 16 bytes, the
oversized event is queued into a new batch. Does this memcpy copy data past
the end of the page allocation, causing a heap buffer overflow?

> +		offset +=3D rec_sizes[i];
> +		commit +=3D rec_sizes[i];
> +	}
[ ... ]
> +static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long lon=
g *file_offset_out)
> +{
[ ... ]
> +	for (i =3D 0; i < cpu_events->count; i++) {
> +		struct cpu_event *event =3D &cpu_events->events[i];
> +		unsigned long long time_delta =3D event->ts - base_ts;
> +		unsigned int data_len =3D event->raw_size;
> +		unsigned int words =3D (data_len + TRACE_DAT_WORD_ALIGN_MASK) / TRACE_=
DAT_WORD_SIZE;
> +		unsigned int type_len =3D words & TRACE_DAT_RECORD_TYPE_LEN_MASK;
> +		unsigned int hdr_word =3D ((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
> +					TRACE_DAT_RECORD_TIME_SHIFT) | type_len;

[Severity: High]
If the gap between events on a CPU exceeds 0x07FFFFFF, the ftrace
specification requires emitting a TIME_EXTEND or TIME_STAMP record to advan=
ce
base_ts. Does masking off the upper bits via time_delta &
TRACE_DAT_RECORD_TIME_MASK silently truncate the timestamp and corrupt the
chronological ordering?

[Severity: High]
The ftrace ring buffer specification uses the 5-bit type_len field to encode
lengths up to 27 words. For 28 words or more, type_len must be 0, and the
actual length must be written as a 32-bit word immediately following the
header. Does applying words & 0x1F map large events into special types (like
PADDING for 29) or to type_len =3D 0 without appending the required 32-bit
length word?

> +		int rec_size;
> +		char *rec;
> +
> +		rec_size =3D TRACE_DAT_WORD_SIZE + data_len;
> +		if (rec_size % TRACE_DAT_WORD_SIZE)
> +			rec_size +=3D TRACE_DAT_WORD_SIZE - (rec_size % TRACE_DAT_WORD_SIZE);
> +
> +		rec =3D calloc(1, rec_size);
> +		if (!rec)
> +			return -ENOMEM;

[Severity: Medium]
If calloc fails, this directly returns -ENOMEM. Does this bypass the out_fr=
ee
cleanup label entirely, leaking the page_records and page_rec_sizes tracking
arrays and any previously allocated record strings?

> +		memcpy(rec, &hdr_word, TRACE_DAT_WORD_SIZE);
> +		memcpy(rec + TRACE_DAT_WORD_SIZE, event->raw, data_len);
> +
> +		if (page_size_used + rec_size > trace_dat_page_size -
> +		    TRACE_DAT_RECORD_HEADER_SIZE) {
> +			ret =3D trace_dat__write_page(fp, base_ts,
> +			      page_records, page_rec_sizes, nr_page_recs);
> +			for (j =3D 0; j < nr_page_recs; j++)
> +				free(page_records[j]);
> +			nr_page_recs =3D 0;
> +			page_size_used =3D 0;
> +			base_ts =3D event->ts;
> +			if (ret < 0)
> +				goto out_free;

[Severity: Medium]
If trace_dat__write_page fails and we jump to out_free, the newly allocated
rec has not yet been appended to the page_records array. Is this memory
permanently leaked since it is skipped by the cleanup loop?

> +		}
> +
> +		if (nr_page_recs >=3D page_cap) {
> +			char **tmp_records;
> +			int *tmp_sizes;
> +
> +			page_cap =3D page_cap ? page_cap * 2 : INITIAL_PAGE_RECORD_CAPACITY;
> +			tmp_records =3D realloc(page_records, page_cap * sizeof(char *));
> +			tmp_sizes =3D realloc(page_rec_sizes, page_cap * sizeof(int));
> +			if (!tmp_records || !tmp_sizes) {
> +				ret =3D -ENOMEM;
> +				goto out_free;

[Severity: High]
If realloc for tmp_sizes fails, the code jumps to out_free without updating
page_records to point to the newly allocated block in tmp_records. Does the
cleanup path then iterate over the potentially freed page_records pointer,
dereference it (use-after-free), and then call free(page_records) again
(double-free)?

> +			}
[ ... ]
> +int trace_dat__write_options_section1(void)
> +{
[ ... ]
> +	/* TRACECLOCK option */
> +	opt_id =3D TRACE_DAT_OPTION_TRACECLOCK;
> +
> +	path =3D get_tracing_file("trace_clock");
> +	clock_file =3D fopen(path, "r");

[Severity: High]
The get_tracing_file function internally uses asprintf and can return NULL =
on
memory allocation failure. Is it possible for fopen to receive a NULL path,
leading to a segmentation fault?

> +	put_tracing_file(path);
[ ... ]
> +int trace_dat__write_flyrecord_section(void)
> +{
[ ... ]
> +	/* Align to page boundary */
> +	after_header   =3D ftell(trace_dat_fp);
> +	padding_needed =3D (trace_dat_page_size -
> +			 (after_header % trace_dat_page_size)) % trace_dat_page_size;
> +
> +	if (padding_needed > 0) {
> +		pad =3D calloc(1, padding_needed);
> +
> +		if (!fwrite(pad, 1, padding_needed, trace_dat_fp)) {

[Severity: High]
Is pad passed directly to fwrite without checking if calloc succeeded? Can
this lead to a segmentation fault if the allocation fails and fwrite receiv=
es
a NULL buffer?

> +			free(pad);
> +			ret =3D -EIO;
> +			goto cleanup;
> +		}
> +		free(pad);
> +	}
[ ... ]
> +	/* fill section size */
> +	end_pos =3D ftell(trace_dat_fp);
> +
> +	section_size =3D end_pos - flyrecord_start;

[Severity: Medium]
In the trace.dat specification, the section_size field must indicate the si=
ze
of the payload following the 16-byte section header. By capturing
flyrecord_start before the header is written, does the final section_size
erroneously include the 16 bytes of the header itself, causing parsing tools
to miscalculate the boundary?

> +	if (fseek(trace_dat_fp, section_size_pos, SEEK_SET) < 0 ||
> +	    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)=
) {
> +		ret =3D -EIO;
> +		goto cleanup;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608125951.9042=
5-2-tshah@linux.ibm.com?part=3D1
