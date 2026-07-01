Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C03F1654
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896772; cv=none; b=svqmfFKWsfewQa7wZ+ncgQQJk2q2Mx8akhWB8nWFPrvUkAoRDrFRQ/zXiJy3Fs3PQ9kfXBT/FxChtUIjn0rHZAepLnUMbm0FuwZeu8N3hSQlLeliHTg3RQXx3SDJSPsJMaybVxZvEgWzCRaBR84F+st+pjk8wxlUrVMvvnYB7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896772; c=relaxed/simple;
	bh=pfXMOlXQg0XnmLBRe5s7ZZ0STxkQuxzbp0R6Vastmls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T+x8PkgyJ7ZiOe6lzlGYy7aBwwKTqqFj1svqvPOz4xRCp1wz3OpB++5b+CmeZxoVO6h+c+P0G51qx80XXbPdo1Xi9kNz6FRfDx/8vLPwQtCshjjW8CiF3xCVdVGyJXysnIA15nHlwlTrLLAPmLnNyzYlGGSu7QSecyDC3IP/L68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGp71GpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGp71GpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54631F00A3A;
	Wed,  1 Jul 2026 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896768;
	bh=vNpAFtSc9XsYihmBvJvIGmCFN3mFvK0UEle1XXIfsIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGp71GpDWvcrkObL0tjsY+bgdNG+8Y1HZqp1t08nRiOkymt8Fxn5KhknoSdhnwcJt
	 fQ1i2e3zZAPV9KAcllepc4tTBgxisJP5YXUA7O/I9C13z7zuV9WqSDZ0a9xxtNv7lG
	 ZV6y7TwlNo0QbZIcP4GS4qROZJYAIdFfCJ6Qmzedygd3auM6NtcUeIRmafHUIDPb0n
	 2rBmsoCNdYruOkd3pK6YpKnQ6PTuPRMNxiEakvant/+FnMBbcjCeAuw8lIC0YiPxE/
	 X6znULJAYGSgsa7+watEqVhg7s4TMz0QWYvHZPVkcVkQ5V07ml9sW9zI/iVznEZLy/
	 gbGNFhUbQfGlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf tools powerpc: Add HTM trace data processing
 and decoding support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-7-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-7-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:06:08 +0000
Message-Id: <20260701090608.C54631F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Use-after-free and inconsistent resource cleanup on error path=
s in `powerpc_htm_process_auxtrace_info()`.
- [Critical] Out-of-bounds read and information leak in `write_htm()` due t=
o missing bounds checks against `buffer->size`.
- [High] Missing size validation before dereferencing `sample->raw_data`.
- [High] Stateless queue iteration logic causes redundant processing and ma=
ssive trace duplication.
- [High] Missing NULL checks for `evsel` pointer and `evsel->name`.
- [High] Missing call to `auxtrace_buffer__get_data()` causes `buffer->data=
` to be NULL when passed to `write_htm()`.
- [High] Deadlock in child process after fork() due to non-async-signal-saf=
e functions.
- [High] Predictable filenames are created in the current working directory=
 without O_EXCL or O_NOFOLLOW flags, enabling arbitrary file overwrites via=
 symlink attacks.
- [Medium] Cross-platform analysis broken due to native endianness assumpti=
on on raw sample data.
- [Low] Missing explicit inclusion of POSIX standard libc headers.
--

commit 699e32993a6b92ec36264eeaf2b99217af504b57
Author: Athira Rajeev <atrajeev@linux.ibm.com>

perf tools powerpc: Add HTM trace data processing and decoding support

This patch adds support for processing Hardware Trace Macro (HTM) auxiliary
trace data collected via perf AUX buffers. It allows post-processing of HTM
traces, extracting bus traces and system memory configuration. It integrates
with an external htmdecode tool for trace decoding.

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index ffddf0e59fc14..487989ca4fc7d 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -14,6 +14,12 @@
>  #include <inttypes.h>
>  #include "powerpc-htm.h"
>  #include <errno.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include "sample.h"
> +#include <sys/types.h>
> +#include <sys/wait.h>

[Severity: Low]
Does this file compile successfully against musl libc?

This code uses POSIX standard functions and constants like open, O_WRONLY,
fopen, exit, malloc, and strerror. However, it looks like the explicit
POSIX headers (<fcntl.h>, <stdio.h>, <stdlib.h>, <string.h>) are missing.
Without these explicit inclusions, compilation under musl libc might fail.

[ ... ]
> @@ -26,8 +32,140 @@ struct powerpc_htm {
>  	struct machine			*machine;
>  	u32				pmu_type;
>  	char				htmbin_file[64];
> +	char				trans_file[64];
> +	int				htm_mem_entries;
> +	int				mem_maps;
>  };
[ ... ]
> +static int run_htmdecode(const char *input_file, const char *output_file)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	pid =3D fork();
> +	if (pid =3D=3D -1) {
> +		pr_err("fork() failed: %s\n", strerror(errno));
> +		return -errno;
> +	}
> +
> +	if (pid =3D=3D 0) {
> +		/* Child process */
> +		int fd =3D open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);

[Severity: High]
Could creating this output file with a predictable name make it vulnerable =
to
a symlink attack?

If this is executed in a world-writable directory like /tmp, and a user
pre-creates a symlink matching the output filename, opening it without
O_EXCL and O_NOFOLLOW might allow an attacker to overwrite arbitrary files.

> +
> +		if (fd =3D=3D -1) {
> +			pr_err("Failed to open output file: %s\n", strerror(errno));
> +			exit(1);
> +		}
> +
> +		/* Redirect stdout to output file */
> +		dup2(fd, STDOUT_FILENO);
> +		close(fd);
> +
> +		/* Execute htmdecode - execlp searches PATH automatically */
> +		execlp("htmdecode", "htmdecode", "-o", "-j", "-w", "1",
> +			"-f", input_file, NULL);
> +
> +		/* If execlp returns, it failed */
> +		pr_err("Failed to execute htmdecode: %s\n", strerror(errno));
> +		if (errno =3D=3D ENOENT)
> +			pr_err("htmdecode not found in PATH\n");
> +
> +		exit(127);  /* Standard "command not found" exit code */
> +	}

[Severity: High]
Is there a risk of deadlocking the child process if perf is multi-threaded?

The child process calls pr_err and exit if open or execlp fails. Since
pr_err uses fprintf and exit flushes streams, these are not
async-signal-safe functions.

If another thread held a libc lock, like the stderr lock or malloc heap
lock, when fork was called, the child process could deadlock trying to
acquire it. Would it be safer to use write to file descriptor 2 and
_exit here?

[ ... ]
> +static int write_htm(void *data, size_t size, struct powerpc_htm *htm)
> +{
> +	FILE *fp;
> +	u64 *num_entries;
> +	size_t entries;
> +	size_t written;
> +	int ret =3D -1;
> +
> +	if (htm->mem_maps) {
> +		fp =3D fopen(htm->trans_file, "ab");
> +		if (!fp) {
> +			pr_err("Failed to open %s: %s\n", htm->trans_file, strerror(errno));
> +			return ret;
> +		}
> +		num_entries =3D data + 0x10;
> +		entries =3D be64_to_cpu(*num_entries);
> +		entries++;
> +		written =3D fwrite(data, 32, entries, fp);

[Severity: Critical]
Can this result in an out-of-bounds memory read?

The code calculates the number of entries dynamically from data + 0x10 and
then calls fwrite with entries as the count multiplier.

If the trace data is malformed and contains an artificially large entry
count, it seems we could write gigabytes of out-of-bounds heap or mapped
memory to the file without verifying that the requested write length is
bounded by the size parameter.

> +		if (written !=3D entries) {
> +			pr_err("Failed to write data: expected %zu, wrote %zu\n", entries, wr=
itten);
> +			fclose(fp);
> +			return ret;
> +		}
> +		fclose(fp);
> +		htm->htm_mem_entries +=3D entries;
> +		return 0;
> +	}
[ ... ]
>  static int powerpc_htm_process_event(struct perf_session *session __mayb=
e_unused,
>  				 union perf_event *event,
>  				 struct perf_sample *sample __maybe_unused,
>  				 const struct perf_tool *tool __maybe_unused)
>  {
> +	struct powerpc_htm *htm =3D container_of(session->auxtrace, struct powe=
rpc_htm,
> +			auxtrace);
> +
> +	if ((event->header.type =3D=3D PERF_RECORD_SAMPLE) && sample->raw_data)=
 {
> +		int *content =3D (int *)sample->raw_data;

[Severity: High]
Could casting sample->raw_data to an integer pointer cause an out-of-bounds
read if the raw data is smaller than sizeof(int)?

Should we verify that sample->raw_size is at least 4 bytes before
dereferencing it?

> +		struct evsel *evsel =3D evlist__event2evsel(session->evlist, event);
> +		int config =3D (evsel->core.attr.config) & 0xF;

[Severity: High]
Is it possible for evlist__event2evsel to return NULL here?

If it fails to find a matching event for the sample, dereferencing evsel
immediately in the config assignment would cause a crash.

> +		struct auxtrace_buffer *buffer =3D NULL;
> +		struct auxtrace_queues *queues =3D &htm->queues;
> +		unsigned int i =3D 0;
> +		int j =3D 0;
> +
> +		if (strstr(evsel->name, "htm") =3D=3D NULL)
> +			return 0;

[Severity: High]
Is it guaranteed that evsel->name is non-NULL?

If the event is unnamed, passing evsel->name directly to strstr might
trigger a NULL pointer dereference.

> +
> +		for (i =3D 0; i < queues->nr_queues; i++) {
> +			buffer =3D auxtrace_buffer__next(&queues->queue_array[i], buffer);
> +			for (; buffer;) {
> +				if (j >=3D *content)

[Severity: Medium]
Does this code handle cross-endian analysis correctly?

The trace data is read directly into content as a native integer. If a
trace recorded on a big-endian system is analyzed on a little-endian
host, it seems the value will have the wrong byte order and the
comparison here will evaluate incorrectly.

> +					htm->mem_maps =3D 1;
> +				if (write_htm(buffer->data, buffer->size, htm))

[Severity: High]
Is it possible for buffer->data to be NULL here?

Because the auxtrace subsystem lazily maps file payloads, passing
buffer->data directly to write_htm without calling
auxtrace_buffer__get_data first might pass a NULL pointer, leading to a
crash when it is dereferenced inside write_htm.

[Severity: High]
Does this loop iteration lead to massive data duplication?

The code iterates over all auxtrace_buffer elements starting from the
queue head for every PERF_RECORD_SAMPLE event. Because buffers aren't
marked as processed or dequeued, subsequent events will cause the same
buffers to be appended to the output files multiple times.

> +					return -1;
> +				j++;
> +				buffer =3D auxtrace_buffer__next(&queues->queue_array[i], buffer);
> +			}
> +		}
> +		/* Only for power bus traces, we decode traces */
> +		if (config =3D=3D 1)
> +			create_mem_maps(htm);
> +	}
> +
>  	return 0;
>  }
[ ... ]
> @@ -205,6 +420,14 @@ int powerpc_htm_process_auxtrace_info(union perf_eve=
nt *event,
>  	}
>  	fclose(fp);
> =20
> +	snprintf(htm->trans_file, sizeof(htm->trans_file), "translation.n%d.p%d=
.c%d", nodeindex, nodalchipindex, coreindexonchip);
> +	fp =3D fopen(htm->trans_file, "w");

[Severity: High]
Are we vulnerable to symlink attacks here by using predictable filenames?

Creating files with predictable names like translation.n%d.p%d.c%d using
fopen with the w flag without O_EXCL could allow arbitrary file
overwrites if run in a shared directory.

> +	if (!fp) {
> +		pr_err("Failed to create %s: %s\n", htm->trans_file, strerror(errno));
> +		return -errno;

[Severity: Critical]
Does returning directly here leak the htm struct allocated earlier in the
function?

Additionally, if the function jumps to the err_free label on other error
paths, such as when powerpc_htm_synth_events fails, does it bypass the
session->auxtrace =3D NULL assignment?

If session->auxtrace was set to &htm->auxtrace, leaving a dangling
pointer could cause a use-after-free when the session is later deleted
via perf_session__delete.

> +	}
> +	fclose(fp);
> +
>  	powerpc_htm_print_info(&auxtrace_info->priv[0]);
> =20
>  	err =3D auxtrace_queues__process_index(&htm->queues, session);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D6
