Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE73451DA
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546724; cv=none; b=d0kvm2lqGcgvdFkYsxJ/DoVgydX4kzZnugKHu0uUEiOEfG6weO1SVwUchH7CNridV4O4ax01FOq8KmE9SFFq4X4tmT+n9CQBCvXOgrmmJ4xormghtM9HZFMi7TfmnryaO6wPjHrVxJOs16wbHbtFeHM8UFgX9yDcZ5+bYAQGJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546724; c=relaxed/simple;
	bh=sE1DwKTzRxPE9/G9AbJEn5qvUJUyFv/6e8INyaRobPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O6SXsSy4oubXPFYp4VHdZ0VoZiaNTyrizuwRzpHqF7hJMZUITa5EIG4gkjKJH5umG6JQGnznUFrPAeQKU96fEuicsGXE56BjR94DlCR42kP7EBB77ew2JCtVDkevY35v6+7STjRVbMm5S2TFzfI7p7dmHLRtY9dPrxk6/AhvFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRuMWgSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRuMWgSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773F1F00A3A;
	Mon, 20 Jul 2026 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546722;
	bh=woWMjpH2024syf91VHEF2VbvgZ0PZJzkUapmOz9cvDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRuMWgSNiJWhX3/vxykKfQfYcWbP2Vnbx+ij4+/RCJy36ykpzLx0zEfhIQKEAgMt2
	 E+ubreGiZTJyUQpQYB3mnZlQ6rz5EnaJWQaSrD/9k3cOI4eC3q6aJvqP9d0N7ai0s6
	 NtPfYucO+I6GVBOF48lzurmAAifAho6F75YGzBAPcDpjPRzo8ZNDNxxCpLjStrBQpo
	 9oj1qyXUky8njggPRs0ICqTgfOxi7MzB2OcOamu2iINvxqYSzz1lNg3d+DexkrqbmJ
	 NYHGN6O1jyCOgD1z80pf9Curbzqgy2o4Di8wXu/Sk3MQMBGMylBM3Hh9zCDgU/JR9s
	 GjVmH8Q4yT55w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 6/6] tools/perf: Add perf tool support for processing
 powerpc HTM AUXTRACE records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720105218.14277-7-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-7-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:25:22 +0000
Message-Id: <20260720112522.8773F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Incorrect return value in `htm_target_seen()` causes trace file tr=
uncation instead of appending when target capacity is exceeded.
- [High] Missing bounds check on dynamic array portion of `auxtrace_info` l=
eads to out-of-bounds read.
- [High] Integer underflow when processing `sample->raw_size` leads to bypa=
ssed length checks and out-of-bounds read.
- [High] Direct dereferencing of a 64-bit pointer causes unaligned memory a=
ccess.
- [High] Integer truncation on 32-bit platforms leads to a severe heap buff=
er overflow.
- [Medium] Processing multiple AUXTRACE_INFO events overwrites `session->au=
xtrace`, leaking memory.
- [Low] Missing explicit POSIX libc header inclusions causes musl libc buil=
d failures.
--

--- Patch [6]: [PATCH V2 6/6] tools/perf: Add perf tool support for process=
ing powerpc HTM AUXTRACE records ---
commit 30554a3a06e5c4703030155cf5ee8abbdc6f50e6
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE recor=
ds

This commit adds perf tool support for processing powerpc HTM AUXTRACE reco=
rds.
It introduces logic to map CPU configurations to trace targets and writes H=
TM
data directly to files. Memory configuration records are also extracted from
raw sample data and processed.

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index 8d28d02031d6e..28166f7f7463b 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -11,9 +11,12 @@
>  #include "util/session.h"
>  #include "color.h"
>  #include "powerpc-htm.h"
> +#include <errno.h>
>  #include "debug.h"
>  #include "sample.h"
> =20
> +struct perf_session;
> +

[Severity: Low]
Will this fail to compile on musl libc? The code uses POSIX standard functi=
ons
like open, write, close, calloc, and snprintf, but standard headers like
<fcntl.h>, <unistd.h>, <stdlib.h>, <stdio.h>, and <string.h> are not includ=
ed.

[ ... ]

> +static bool htm_target_seen(u32 *targets, int *nr, int capacity, u32 key)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < *nr; i++) {
> +		if (targets[i] =3D=3D key)
> +			return true;
> +	}
> +
> +	if (*nr < capacity)
> +		targets[(*nr)++] =3D key;
> +	else
> +		pr_warning("htm: too many targets (max %d), appending to existing file=
\n",
> +			   capacity);
> +
> +	return false;
> +}

[Severity: High]
If we exceed the target capacity, does this return false and inadvertently
truncate the file? The warning message states it is appending, but a false
return causes write_htm() to select O_TRUNC instead of O_APPEND.

[ ... ]

> +static int write_htm(struct powerpc_htm *htm, void *data, size_t size,
> +		     u32 node, u32 chip, u32 core, int mem_maps)
> +{
> +	u32 target_key =3D htm_pack_target(node, chip, core);
> +	char target_file[128];
> +	size_t written;
> +	int flags;
> +	int fd;
> +
> +	if (!data || !size)
> +		return -EINVAL;
> +
> +	flags =3D O_CREAT | O_WRONLY | O_NOFOLLOW | O_CLOEXEC;
> +
> +	if (mem_maps) {
> +		uint8_t *byte_ptr =3D (uint8_t *)data;
> +		__be64 *num_entries_ptr;
> +		size_t entries;
> +		size_t payload;
> +
> +		if (size < HTM_MEM_ENTRY_SIZE) {
> +			pr_err("Malformed memory mapping entry trace segment\n");
> +			return -EINVAL;
> +		}
> +
> +		/* Entry count is at offset 0x10; add 1 for the 32-byte header */
> +		num_entries_ptr =3D (__be64 *)(byte_ptr + 0x10);
> +		entries =3D be64_to_cpu(*num_entries_ptr) + 1;

[Severity: High]
Can this dereference cause a SIGBUS on architectures with strict alignment
requirements? Since byte_ptr comes from sample->raw_data, it might only be
4-byte aligned due to the preceding u32 raw_size in the header. Should this
use get_unaligned_be64() instead?

[ ... ]

> +static int powerpc_htm_process_event(struct perf_session *session,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
>  				     const struct perf_tool *tool __maybe_unused)
>  {
> +	struct powerpc_htm *htm;
> +	struct evsel *evsel;
> +	u32 node, chip, core;
> +	u64 ev_config;
> +
> +	if (!session || !session->auxtrace || !event || !sample)
> +		return 0;
> +
> +	if (event->header.type !=3D PERF_RECORD_SAMPLE || !sample->raw_data)
> +		return 0;
> +
> +	htm =3D container_of(session->auxtrace, struct powerpc_htm, auxtrace);
> +	evsel =3D evlist__event2evsel(session->evlist, event);
> +
> +	if (!evsel || strcmp(evsel__pmu_name(evsel), "htm") !=3D 0)
> +		return 0;
> +
> +	ev_config =3D evsel->core.attr.config;
> +	node =3D (ev_config >> 4)  & 0xff;
> +	chip =3D (ev_config >> 12) & 0xff;
> +	core =3D (ev_config >> 20) & 0xff;
> +
> +	/*
> +	 * raw_size includes 4 bytes of u64 alignment padding added by the
> +	 * kernel.  Subtract sizeof(u32) to recover the true payload byte count.
> +	 */
> +	if (write_htm(htm, sample->raw_data,
> +		      sample->raw_size - sizeof(uint32_t),
> +		      node, chip, core, 1) < 0) {

[Severity: High]
If sample->raw_size is smaller than 4 (e.g., 0), does this unchecked
subtraction underflow to a massive positive size_t value? If so, this massi=
ve
size will bypass the boundary check in write_htm(), leading to out-of-bounds
reads when evaluating the entry count.

[ ... ]

>  int powerpc_htm_process_auxtrace_info(union perf_event *event,
>  				      struct perf_session *session)
>  {
>  	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
>  	struct powerpc_htm *htm;
> +	u64 num_events;
> +	u64 i;
>  	int err;
> =20
>  	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_inf=
o) +
>  					 HTM_AUXTRACE_PRIV_FIXED)
>  		return -EINVAL;

[Severity: High]
Does this size check fail to validate the variable-length dynamic array of
num_events pairs? If the payload provides a small header.size but a large
num_events value, the subsequent initialization loop might read completely =
out
of bounds of the memory mapped event buffer.

> =20
> +	htm =3D zalloc(sizeof(struct powerpc_htm));
> +	if (!htm)
> +		return -ENOMEM;

[Severity: Medium]
If a perf.data file contains multiple POWERPC_HTM auxtrace info events, does
this blindly allocate a new powerpc_htm structure and overwrite
session->auxtrace later? This would lead to a memory leak of the previous
context during session teardown.

> =20
>  	err =3D auxtrace_queues__init(&htm->queues);
>  	if (err) {
>  		free(htm);
>  		return err;
>  	}
> =20
> +	htm->auxtrace_type =3D auxtrace_info->priv[POWERPC_HTM_PMU_TYPE];
> +	num_events =3D auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS];
> +
> +	/*
> +	 * All three arrays are sized to num_events, the exact count of HTM
> +	 * targets written by htm_info_fill() at record time.  This replaces the
> +	 * old compile-time HTM_MAX_TARGETS constant so the limit is always
> +	 * consistent with what was actually recorded.
> +	 */
> +	htm->nr_targets   =3D (int)num_events;
> +	htm->cpu_configs  =3D calloc(num_events, sizeof(*htm->cpu_configs));
> +	htm->htm_bin_targets    =3D calloc(num_events, sizeof(*htm->htm_bin_tar=
gets));
> +	htm->translation_targets =3D calloc(num_events, sizeof(*htm->translatio=
n_targets));

[Severity: High]
On 32-bit platforms, does the 64-bit num_events value get implicitly
truncated by the 32-bit size_t argument in calloc()? If truncated, the
subsequent loop using the full 64-bit num_events limit could cause a severe
heap buffer overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720105218.1427=
7-1-atrajeev@linux.ibm.com?part=3D6
