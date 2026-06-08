Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64B3382C9
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924347; cv=none; b=hEI/Es+MFvyiF2Pl1Gc/meqzunjKm8yNsEx47CCasR5X7+m7EkmZEpPFqNqF28WlzuNeI8+uwU3nRZ7fJusD+/yHcqzLGBbH1HKgQAw+zY+B57vJ17ex21o/lz+1KA/ZjrMi5ycSL5pourhkBO8sHVJK3NcCX35v2GGAv0B2cCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924347; c=relaxed/simple;
	bh=0iKeTGDqslZzeAqxDsY0HyNyFzJAgL+S9Enp0usVVok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1QWU2o0q/OUdxYpR9OCJ9HYhjGNItt3MLk6pIpvYqgOfIfBxgBumG9oLHBfMoRVq0UE8Khorx14BcxSNRfy093rDbcW+nWxB29rI3m/FFhEN8WQPxMMSBcQuFLDUGpU91u1XdReGgjToJI3t5p7d4YcBJWRswkRVMKn37YPBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw2tbh8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw2tbh8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B448A1F00898;
	Mon,  8 Jun 2026 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924345;
	bh=fxEBxRxOa5ErNXDVuiL20heV4GmbXjluwmbI44n9ICc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fw2tbh8E015z6N5STTBqnkopTAtvxBgXEWeYGzbdWvqrPGJYPQY+p9PTWhMBdPust
	 t7eRZOJEgDRu4GeO77ZsmrVORR0uReQfoQrnG4lzMkr9s31QCTGaV/UJetT/V/cCyx
	 6ZNE49WXsg7OE6zlG8/pI8jPBnPGGEIXPVf0Msn1eAEbwQXlNNCq+aCPqcs9eIfQBB
	 TMbsS0ZAsFO5O8OiBNaz2RzCPglwc/ZfTNy0ALztcZsl/hbHXz5ftBmlBpHvCRgw8b
	 MrwKZgDwCA/c25jyiXJYBPFs1vEbzyxQAxFywwyZdjplNZ43pNA6RvpVhfXYUBq6Nj
	 d5iWqbSAjJ1vg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] perf/trace-event: Write trace.dat metadata
 sections during parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608125951.90425-4-tshah@linux.ibm.com>
References: <20260608125951.90425-4-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:12:24 +0000
Message-Id: <20260608131224.B448A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Using `read()` directly instead of the subsystem's `do_read()` loo=
p fails to handle short reads, causing stream desynchronization and uniniti=
alized memory writes.
- [High] Integer truncation in `do_read()` causes massive uninitialized hea=
p memory dumps to the output file.
- [Medium] Metadata fields and integers for the `trace.dat` file are writte=
n in the host's native byte order, causing cross-platform incompatibility.
- [Medium] Error paths in `fwrite` operations return directly without clean=
ing up allocated resources, leading to memory and state leaks.
- [Medium] Writing 2 bytes from a 1-byte `char` variable causes a stack out=
-of-bounds read and file corruption.

Pre-existing issues:
- [High] Unbounded string accumulation in `read_string()` causes a stack bu=
ffer overflow.
--

commit f1360b22eb92ea64822af70555a808fd9d67ae93
Author: Tanushree Shah <tshah@linux.ibm.com>
Date:   Mon Jun 8 12:59:50 2026 +0000

    perf/trace-event: Write trace.dat metadata sections during parsing
   =20
    Perf already captures the tracing metadata as a part of
    data section in perf.data
   =20
    When trace_dat_fp is set, write trace.dat compatible metadata
    sections using the perf provided raw buffers.
   =20
    Sections written:
    - Initial format header (magic, version, endian, long_size,
      page_size, compression, options_offset placeholder)
    - Section 16: HEADER INFO (header_page + header_event)
    - Section 17: FTRACE EVENT FORMATS
    - Section 18: EVENT FORMATS (per system/event format files)
    - Section 19: KALLSYMS
    - Section 21: CMDLINES
    - Section 15: STRINGS (written last after all sections)
   =20
    Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>

This commit updates the trace-event parsing in perf to write trace.dat
compatible metadata sections when trace_dat_fp is set. It outputs sections
such as initial format headers, FTRACE EVENT FORMATS, EVENT FORMATS,
KALLSYMS, and CMDLINES using perf's raw buffers.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index ecbbb93f01853..815577703c2e5 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c

[ ... ]

> @@ -145,10 +146,9 @@ static char *read_string(void)

[Severity: High]
This isn't a bug introduced by this patch, but does read_string() allow a
stack buffer overflow when accumulating characters?

In read_string():
    buf[size++] =3D c;

If the input file contains a string longer than BUFSIZ without a null
terminator, will this increment the size index and write past the bounds
of the fixed-size array buf?

>  static int read_proc_kallsyms(struct tep_handle *pevent)
>  {
>  	unsigned int size;
> +	char *buf;
> =20
>  	size =3D read4(pevent);
> -	if (!size)
> -		return 0;

[ ... ]

> +	buf =3D malloc(size);
> +	if (buf =3D=3D NULL)
> +		return -1;
> +	if (read(input_fd, buf, size) < 0) {
> +		free(buf);
> +		return -1;
> +	}
>  	trace_data_size +=3D size;
> +	/* Write kallsyms section with data */
> +	if (trace_dat_fp) {
> +		unsigned short section_id =3D TRACE_DAT_SECTION_KALLSYMS;
> +		unsigned int string_id =3D STRID_KALLSYMS;
> +		unsigned long long section_size =3D sizeof(unsigned int) + size;
> +		unsigned short flags =3D 0;
> +
> +		trace_dat_kallsyms_offset =3D ftell(trace_dat_fp);
> +		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
> +		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
> +		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
> +		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp=
) ||
> +		    !fwrite(&size, sizeof(unsigned int), 1, trace_dat_fp) ||
> +		    !fwrite(buf, 1, size, trace_dat_fp)) {

[Severity: High]
Could using read() instead of do_read() here cause uninitialized memory to
be written to the output file?

Unlike do_read(), read() can return a short read. If a short read occurs, t=
he
return value might still be greater than 0, bypassing the error check.

Will this leave the remainder of buf uninitialized, failing to advance the
input_fd offset by the expected amount, and then dump the partially
uninitialized heap memory into trace_dat_fp during the fwrite() call?

> +			free(buf);
> +			return -EIO;
> +		}
> +	}
> +	free(buf);
>  	return 0;
>  }

[ ... ]

> @@ -209,6 +261,7 @@ static int read_header_files(struct tep_handle *peven=
t)
> =20
>  	size =3D read8(pevent);
> =20
> +	header_page_size =3D size;
>  	header_page =3D malloc(size);
>  	if (header_page =3D=3D NULL)
>  		return -1;
> @@ -227,19 +280,59 @@ static int read_header_files(struct tep_handle *pev=
ent)
>  		 */
>  		tep_set_long_size(pevent, tep_get_header_page_size(pevent));
>  	}
> -	free(header_page);
> =20
> -	if (do_read(buf, 13) < 0)
> +	if (do_read(buf, 13) < 0) {
> +		free(header_page);
>  		return -1;
> +	}

[Severity: High]
Can integer truncation in do_read() lead to massive uninitialized heap memo=
ry
dumps here?

Functions like read_header_files() allocate memory using the 64-bit size re=
ad
from the file:

    size =3D read8(pevent);
    header_page =3D malloc(size);

They then call do_read(header_page, size). Because do_read() takes an int
for the size argument, values over 4GB are truncated to their lower 32 bits.
If size is 0x100000004, do_read() will only read 4 bytes.

Later in the function, fwrite() is called with the full 64-bit size:

    !fwrite(header_page, 1, header_page_size, trace_dat_fp)

Will this result in dumping 4GB of uninitialized heap memory into the
output file?

[ ... ]

> @@ -298,8 +405,31 @@ static int read_ftrace_files(struct tep_handle *peve=
nt)
>  	int count;
>  	int i;
>  	int ret;
> +	long section_size_pos =3D 0;
> +	long count_pos =3D 0;
> +	unsigned long long section_size =3D 0;
> +	long end_pos;
> =20
>  	count =3D read4(pevent);
> +	/* Write ftrace formats section to trace.dat output file */
> +	if (trace_dat_fp) {
> +		unsigned short section_id =3D TRACE_DAT_SECTION_FTRACE;
> +		unsigned short flags =3D 0;
> +		unsigned int string_id =3D STRID_FTRACE_FORMATS;
> +
> +		trace_dat_ftrace_format_offset =3D ftell(trace_dat_fp);
> +
> +		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
> +		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
> +		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp))

[Severity: Medium]
Should these multi-byte integers be byte-swapped to match the output file's
endianness?

The trace.dat file endianness is explicitly declared to match the original
perf.data file (endian =3D file_bigendian).

However, variables like section_id, flags, and string_id are written using
fwrite(), which writes them in the host's native byte order. If a
little-endian host is processing a big-endian capture file, won't this corr=
upt
the section IDs and sizes in the resulting trace.dat file?

> +			return -EIO;
> +		section_size_pos =3D ftell(trace_dat_fp);
> +		if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp=
))
> +			return -EIO;
> +		count_pos =3D ftell(trace_dat_fp);
> +		if (!fwrite(&count, sizeof(unsigned int), 1, trace_dat_fp))
> +			return -EIO;
> +	}

[ ... ]

> @@ -363,6 +557,23 @@ static int read_saved_cmdline(struct tep_handle *pev=
ent)
>  		pr_debug("error reading saved cmdlines\n");
>  		goto out;
>  	}
> +	/* Write cmdlines section with data */
> +	if (trace_dat_fp) {
> +		unsigned short section_id =3D TRACE_DAT_SECTION_CMDLINE;
> +		unsigned short flags =3D 0;
> +		unsigned int string_id =3D STRID_CMDLINES;
> +		unsigned long long section_size =3D sizeof(unsigned long long) + size;
> +
> +		trace_dat_cmdline_offset =3D ftell(trace_dat_fp);
> +		if (!fwrite(&section_id, sizeof(unsigned short), 1, trace_dat_fp) ||
> +		    !fwrite(&flags, sizeof(unsigned short), 1, trace_dat_fp) ||
> +		    !fwrite(&string_id, sizeof(unsigned int), 1, trace_dat_fp) ||
> +		    !fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp=
) ||
> +		    !fwrite(&size, sizeof(unsigned long long), 1, trace_dat_fp) ||
> +		    !fwrite(buf, 1, size, trace_dat_fp))
> +			return -EIO;

[Severity: Medium]
Does returning directly bypass the cleanup block?

If fwrite() fails, this error path returns -EIO immediately instead of using
the "goto out" pattern established in this function.

Will this cause the allocated memory in buf to be leaked, since free(buf)
is skipped?

> +	}
> +
>  	buf[ret] =3D '\0';
> =20
>  	parse_saved_cmdline(pevent, buf, size);

[ ... ]

> @@ -440,6 +657,28 @@ ssize_t trace_report(int fd, struct trace_event *tev=
ent, bool __repipe)
>  	tep_set_long_size(pevent, file_long_size);
>  	tep_set_page_size(pevent, file_page_size);
> =20
> +	/* Write initial file header to trace.dat */
> +	if (trace_dat_fp) {
> +		unsigned char endian =3D file_bigendian;
> +		unsigned char long_size =3D file_long_size;
> +		unsigned int page_size =3D file_page_size;
> +		unsigned long long placeholder =3D 0;
> +		char trace_dat_version =3D TRACE_DAT_VERSION;
> +
> +		if (!fwrite(magic_buf, 1, 10, trace_dat_fp) ||    /* magic + "tracing"=
 */
> +		    !fwrite(&trace_dat_version, 1, 2, trace_dat_fp) ||

[Severity: Medium]
Can this write out-of-bounds stack memory to the output file?

The variable trace_dat_version is declared as a 1-byte char:

    char trace_dat_version =3D TRACE_DAT_VERSION;

However, the fwrite call asks to write 2 bytes:

    !fwrite(&trace_dat_version, 1, 2, trace_dat_fp)

Will this read 1 byte past the trace_dat_version variable on the stack,
leaking uninitialized stack memory into the output file and potentially
failing to write the expected null terminator for the version string?

> +		    !fwrite(&endian, 1, 1, trace_dat_fp) ||
> +		    !fwrite(&long_size, 1, 1, trace_dat_fp) ||
> +		    !fwrite(&page_size, sizeof(unsigned int), 1, trace_dat_fp) ||
> +		    !fwrite("none", 1, 4, trace_dat_fp) ||
> +		    !fwrite("\0", 1, 1, trace_dat_fp) ||
> +		    !fwrite("\0", 1, 1, trace_dat_fp))
> +			return -EIO;
> +		trace_dat_options_offset =3D ftell(trace_dat_fp);
> +		if (!fwrite(&placeholder, sizeof(unsigned long long), 1, trace_dat_fp))
> +			return -EIO;
> +	}
> +
>  	err =3D read_header_files(pevent);
>  	if (err)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608125951.9042=
5-2-tshah@linux.ibm.com?part=3D2
