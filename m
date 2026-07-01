Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BC3B47F9
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897186; cv=none; b=gekjql2g86yJnbioa0NjDkd+J0lnWph4TzgcxFPfrGR1AjbKq9z4y5qaC3Ey1ZtRVNmuw3jx00intXn/BQjyQ88o8RjdFyuCOF0SSBE31oYWTvctFdVPpW3EHbqrKRXhUL6PECRdyfyOKAKl1J3TWIM60Esc8cmx34endfcA0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897186; c=relaxed/simple;
	bh=qe/rlVWdcceYBVdF5sJBG03XnDx0k2oFkuzlI0Hm9eI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ct8vPkTC8DTTFHs6ul740pAcb1p/RwsPL9veddVZQ1udJuDFeNZ1+h0LRV/AzCSSUmgD9YXhCdg8xxxr7ljebA6biDgzssZ8cdq5+CItVFHnwsFw+LJI9fc6JPeSD7UzBoD0POnVouZTOGQPblLSHdIAcM6i6s7hvZr5EH1+3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zid1kM2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zid1kM2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9761F000E9;
	Wed,  1 Jul 2026 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897184;
	bh=3HB8kk6xHXPqtteJu2mCez9QY0UYGn1mslrVAhNbRH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zid1kM2jQOCFTXengI3gslYY8fn0HAzldyvnnNoj0zJS+JsklhnrOV9i9rkMFpo1q
	 6WvoTVZGT3vYM1O9Tyvv5U9PLohleNBA25TScI1JNNtZl7V7QT9bTiJe8B93aczbU7
	 8f0sl/FRMldDTbrmzzN/F9bUrhILbF1nv+uaN6kmKy/95K1zJlkPbhVXEU2dQemaQd
	 hBjI5TSeePcMMotxQPxCOM22AMVOi0mFXeczgLQeSg7qTL/HDUscp4wfwY7oE6/waB
	 ytLQj7Q3q7tPQJLNtZsZcfMbGgNMmAuWrDJ3YXyIj0W3zHsygRxCT0Wffmlv2fw/zY
	 aUOCw7qLNYqMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] tools/perf/powerpc: Add logical address in decoded
 traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-10-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-10-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:13:03 +0000
Message-Id: <20260701091304.AD9761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Improper error handling causes memory leak and potential segfault =
during initialization.
- [High] File write failures cause an infinite loop in trace line parsing.
- [High] String replacement logic corrupts output for trace lines with mult=
iple addresses.
- [Medium] Unmapped physical addresses are incorrectly overwritten with 0x0=
, destroying trace information.
- [Medium] Trace lines that do not match the event label regex are silently=
 dropped from the translated dump.

Pre-existing issues:
- [High] Malformed physical addresses cause an infinite loop in trace line =
parsing.
--

commit cce34e6215ec4758fecae703f279c8591debaca6
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf/powerpc: Add logical address in decoded traces

This patch enhances post-processing to translate physical addresses to
logical addresses in the decoded output. It creates a new .l output file
with these translated addresses. It also allows optional LP index filtering
when dumping traces.

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index 050fbceac71eb..1bd2664453c66 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c

[ ... ]

> @@ -259,36 +261,60 @@ static struct addr_map *process_trace_file(const ch=
ar *trace_file,
>  	unsigned long logical_addr;
>  	size_t total_phys =3D 0;
>  	size_t total_phys_to_logical =3D 0;
> -
>  	FILE *fp =3D fopen(trace_file, "r");
> +	size_t prefix_len;
> +	int found_match =3D 0;
> +	FILE *fout;
> +	int filter_lp =3D 1;
> +	char *output =3D malloc(strlen(trace_file) + 3);  /* +3 for ".l" and nu=
ll */
> +
> +	if (!output) {
> +		pr_err("Failed to allocate memory for output filename\n");
> +		fclose(fp);
> +		return NULL;
> +	}
> +
>  	if (!fp) {
>  		pr_err("Failed to open trace file %s: %s\n", trace_file, strerror(errn=
o));
>  		return NULL;
>  	}

[Severity: High]
Does this logic mishandle failures from fopen() and malloc()?

If trace_file cannot be opened, fopen() returns NULL. If malloc() for output
succeeds, the subsequent if (!fp) block returns NULL without freeing output,
leaking the allocated memory.

Additionally, if malloc() fails when fp is NULL, the if (!output) block cal=
ls
fclose(fp), which would dereference the NULL pointer and crash the tool.

[ ... ]

> @@ -303,6 +329,10 @@ static struct addr_map *process_trace_file(const cha=
r *trace_file,
>  			while (regexec(&addr_regex, ptr, 1, pmatch, 0) =3D=3D 0) {
>  				unsigned long long phys_addr =3D 0;
>  				struct addr_map entry =3D {0};
> +				char *hex_start =3D strstr(line, "addr:0x");

[Severity: High]
Can this strstr() call corrupt the output for trace lines with multiple
addresses?

When a trace line contains multiple addresses, the inner loop iterates over
each regex match. However, hex_start is calculated using
strstr(line, "addr:0x"), which always finds the first occurrence in the
entire line, ignoring the regex match bounds. This will cause the same pref=
ix
and suffix to be printed multiple times, duplicating portions of the line.

> +				const char *target =3D "addr:0x";
> +				char *old_val_ptr;
> +				size_t written;
> =20
>  				if (sscanf(ptr + pmatch[0].rm_so + strlen("addr:"),
>  					  "%llx", &phys_addr) !=3D 1) {
>  					pr_debug("Failed to parse phys addr from trace line\n");
>  					continue;
>  				}

[Severity: High]
This is a pre-existing issue, but does this error path cause an infinite lo=
op?

If sscanf() fails to parse a physical address, it executes continue. This
skips the ptr +=3D pmatch[0].rm_eo; offset advancement at the bottom of the=
 loop.
As a result, the next iteration of the while (regexec(&addr_regex, ptr...))
loop will match the exact same string and fail to parse it again, looping
indefinitely.

> @@ -315,7 +345,30 @@ static struct addr_map *process_trace_file(const cha=
r *trace_file,
>  				logical_addr =3D find_logical_addr(phys_addr,
>  							mem_entries_array,
>  							n_entries,
> -							lp_filter);
> +							lp_filter, filter_lp);
> +				/* create output.txt with logical address */
> +				if (dump_trace && hex_start) {
> +					old_val_ptr =3D hex_start + strlen(target);
> +					prefix_len =3D hex_start - line;
> +					written =3D fwrite(line, 1, prefix_len, fout);
> +					if (written !=3D prefix_len) {
> +						pr_err("Failed to write prefix to output file\n");
> +						continue;
> +					}

[Severity: High]
Can file write failures here cause an infinite loop in trace line parsing?

If either the fwrite() or fprintf() calls fail (e.g., due to a full disk),
the code logs an error and executes continue. Similar to the parsing error
above, this skips the ptr +=3D pmatch[0].rm_eo; advancement at the bottom of
the loop, causing regexec() to repeatedly match the same address string
forever.

> +					if (fprintf(fout, "addr:0x%llx\t", (unsigned long long)logical_addr=
) < 0) {

[Severity: Medium]
Are unmapped physical addresses incorrectly overwritten with 0x0 here?

If find_logical_addr() fails to find a mapping, it returns 0. The code then
unconditionally writes logical_addr to the output file. This replaces valid=
 but
unmapped physical addresses with addr:0x0, rather than preserving the origi=
nal
address.

> +						pr_err("Failed to write to output file\n");
> +						continue;
> +					}

[ ... ]

> @@ -335,6 +388,12 @@ static struct addr_map *process_trace_file(const cha=
r *trace_file,
> =20
>  				ptr +=3D pmatch[0].rm_eo;
>  			}
> +			if (dump_trace && (!found_match) && line) {
> +				if (fprintf(fout, "%s", line) < 0) {
> +					pr_err("Failed to write line to output file\n");
> +					continue;
> +				}
> +			}
>  		}
>  	}

[Severity: Medium]
Are lines that do not match the event label regex dropped entirely from the
translated dump?

The logic to dump lines to fout when dump_trace is enabled appears to be
nested completely within this if (regexec(&label_regex, line, 2, pmatch, 0)=
 =3D=3D 0)
block. There is no corresponding else block, which would cause any
non-matching lines (like headers or metadata) to be silently omitted from
the .l output file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D9
