Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFF40DB2F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770065; cv=none; b=EexvINRtXNDYK8/ViOg8gQt7TLK7g9htYtX+c2exVUs6UWXJrvLQGXpSm6MF271yFbSqeToPxh8itA6ETyDRp+q7JNfAwPD3JD34jkzfUTD3SNUbAPV2ybWzh/QclH68Yz2kHL7QDZKbqf5XYcKOjecGe0/JS9cWOMlF1YYBDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770065; c=relaxed/simple;
	bh=sLSvmkWTulKBgQrH4D4iYR3nQT5lb/AzzmbBfE82wgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WNZjg9kse2NNODyk5rJaLuOvA1yXd2p+E/LK44TbosLfZzQfHEcgJ9GXLOSMt7lcg5bb30HjTOJtleqTGiRmUHv6RWpKRK3vFQfFPE47Of/ktkcpSHuvslmMQoUo1zZ3aWTq6OHKKWWEGMRAr14PgW7a5T0+nkcWwxwgbE0ePr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX5/JVg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX5/JVg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69211F000E9;
	Mon,  3 Aug 2026 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770064;
	bh=gmIT+MBbrVscWHiEGt94V3nuaef5aHjciAyGTIrK5Ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bX5/JVg3v1E6Wn3XvGtAAsv9RIV7te8IBLLVX2NjTIb9O9q4ReIKE8s6TEj78dzXW
	 iVQ6BkqkU944TZoN8G3p3F2uYtBZ2EaALImFDg/QucrxOnU6H/PESiIQxt1iFWnHKf
	 tUkfusaXuRMY6TS98nQz/+/1VHDLZuTRNLog3SiKtGK42r25kRkQMSIueJVsLkbblI
	 yY2aJtVUdBvSlZgXHifBCfc+oNgOTL3QPKBm1JDGZhRieEg2CdxVHp3LqeoOfoKtUh
	 FKaFquT4Z4j1DzTuimNbh4MoJjtQleHCFJE1474i4kibef4u7sn9nDX+rWT3CGoNs7
	 7cN2d7L+iR+PA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/5] perf/trace-dat: Add trace.dat export
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803145958.299956-2-tshah@linux.ibm.com>
References: <20260803145958.299956-1-tshah@linux.ibm.com>
 <20260803145958.299956-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:14:23 +0000
Message-Id: <20260803151423.D69211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `TIME_EXTEND` upper bits are calculated using an incorrect bit=
wise right shift of 5 instead of 27, resulting in corrupted extended timest=
amps.
- [High] The ftrace ring buffer event length encoding for large events inco=
rrectly writes the unaligned payload length, omitting necessary alignment p=
adding.
- [High] Using 32-bit `long` variables and `ftell()`/`fseek()` for file off=
sets truncates trace files larger than 2GB on 32-bit systems.
- [High] Trace data export file headers and ftrace metadata are written in =
host endianness instead of the target trace's endianness, breaking cross-pl=
atform analysis.
- [Medium] Lack of validation for `trace_dat_page_size` can result in a fat=
al integer division by zero exception when calculating page padding.
--

--- Patch [1]: [RFC PATCH v3 1/5] perf/trace-dat: Add trace.dat export infr=
astructure ---
commit 34a2391aa9ca8393dfbdda4a477f39710a409324
Author: Tanushree Shah <tshah@linux.ibm.com>

perf/trace-dat: Add trace.dat export infrastructure

This commit adds new utility files to implement infrastructure for
exporting perf.data tracepoints to the trace.dat format. It provides
functions for managing per-cpu event buffers and constructing ftrace
ring buffer pages.

> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
> new file mode 100644
> index 0000000000000..55a7bd982c6f8
> --- /dev/null
> +++ b/tools/perf/util/trace-dat.c
[ ... ]
> +static int trace_dat__write_page(FILE *fp, unsigned long long base_ts,
> +			char **records, int *rec_sizes, int nr_recs)
> +{
> +	unsigned long long commit =3D 0;
> +	int offset =3D TRACE_DAT_RECORD_HEADER_SIZE;
> +	int i;
> +	char *page;
> +
> +	page =3D calloc(1, trace_dat_page_size);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nr_recs; i++) {
> +		memcpy(page + offset, records[i], rec_sizes[i]);
> +		offset +=3D rec_sizes[i];
> +		commit +=3D rec_sizes[i];
> +	}
> +
> +	memcpy(page, &base_ts, sizeof(base_ts));
> +	memcpy(page + sizeof(base_ts), &commit, sizeof(commit));

[Severity: High]
Does this write the ftrace page header using native host endianness?

If a trace was recorded on a different architecture, copying the integers
directly to the output stream might mix host-endian metadata with
target-endian payloads.

Should this metadata be byte-swapped to match the target architecture
to ensure cross-platform trace analysis works correctly?

> +
> +	if (!fwrite(page, 1, trace_dat_page_size, fp)) {
> +		free(page);
> +		return -EIO;
> +	}
> +	free(page);
> +
> +	return 0;
> +}
[ ... ]
> +static int trace_dat__write_cpu_dat(FILE *fp, int cpu, unsigned long lon=
g *file_offset_out)
> +{
[ ... ]
> +		/* Emit TIME_EXTEND when delta does not fit in 27 bits */
> +		if (time_delta > TRACE_DAT_RECORD_TIME_MASK) {
> +			unsigned int extend_hdr;
> +			unsigned int delta_upper;
> +
> +			extend_size =3D TRACE_DAT_RECORD_TIME_EXTEND_SIZE;
> +			extend =3D calloc(1, extend_size);
> +			if (!extend)
> +				return -ENOMEM;
> +
> +			extend_hdr =3D
> +				((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
> +				 TRACE_DAT_RECORD_TIME_SHIFT) |
> +				TRACE_DAT_RECORD_TYPE_TIME_EXTEND;
> +			delta_upper =3D time_delta >> TRACE_DAT_RECORD_TIME_SHIFT;

[Severity: High]
Does this shift the upper bits of the time delta by the correct amount?

The code uses TRACE_DAT_RECORD_TIME_SHIFT, which is 5.
This calculates the upper bits as time_delta >> 5 rather than >> 27.
Would this copy the middle 22 bits instead of the upper bits, causing
timestamp corruption for any events that follow a time extend?

> +
> +			memcpy(extend, &extend_hdr, TRACE_DAT_WORD_SIZE);
> +			memcpy(extend + TRACE_DAT_WORD_SIZE, &delta_upper,
> +				TRACE_DAT_WORD_SIZE);
> +
> +			time_delta =3D 0;
> +		}
[ ... ]
> +		hdr_word =3D (time_delta << TRACE_DAT_RECORD_TIME_SHIFT) | type_len;
> +
> +		data_rec =3D calloc(1, data_rec_size);
> +		if (!data_rec) {
> +			free(extend);
> +			ret =3D -ENOMEM;
> +			goto out_free;
> +		}
> +
> +		memcpy(data_rec, &hdr_word, TRACE_DAT_WORD_SIZE);
> +
> +		/* Large events: write actual byte length after header */
> +		if (type_len =3D=3D 0)
> +			memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len, TRACE_DAT_WORD_SIZE=
);

[Severity: High]
For large events, is this writing the raw, unaligned data_len into the
payload length field?

The internal offset data_rec_size advances by the padded size, but the
unaligned data_len is written here. If data_len is not a multiple of 4,
a parser reading this file might compute an incorrect total length and
fail to skip the alignment padding.

Could this cause the reader to misread the next event boundary?

> +
> +		memcpy(data_rec + payload_offset, event->raw, data_len);
> +
[ ... ]
> +int trace_dat__write_flyrecord_section(void)
> +{
[ ... ]
> +	section_size_pos =3D ftell(trace_dat_fp);
> +	if (!fwrite(&section_size, sizeof(unsigned long long), 1, trace_dat_fp)=
) {
> +		ret =3D -EIO;
> +		goto cleanup;
> +	}
> +
> +	/* Align to page boundary */
> +	after_header   =3D ftell(trace_dat_fp);
> +	padding_needed =3D (trace_dat_page_size -
> +			 (after_header % trace_dat_page_size)) % trace_dat_page_size;

[Severity: Medium]
Is trace_dat_page_size guaranteed to be non-zero here?

If the caller fails to initialize this global variable or parses a
configuration that sets it to zero, this modulo operation will trigger a
fatal integer division by zero exception.

> +
> +	if (padding_needed > 0) {
> +		pad =3D calloc(1, padding_needed);
> +		if (!pad) {
> +			ret =3D -ENOMEM;
> +			goto cleanup;
> +		}
> +
> +		if (!fwrite(pad, 1, padding_needed, trace_dat_fp)) {
> +			free(pad);
> +			ret =3D -EIO;
> +			goto cleanup;
> +		}
> +		free(pad);
> +	}
> +
> +	/* write per-cpu trace data */
[ ... ]
> diff --git a/tools/perf/util/trace-dat.h b/tools/perf/util/trace-dat.h
> new file mode 100644
> index 0000000000000..9aec37b708d41
> --- /dev/null
> +++ b/tools/perf/util/trace-dat.h
> @@ -0,0 +1,83 @@
[ ... ]
> +extern FILE *trace_dat_fp;
> +extern int trace_dat_page_size;
> +extern int trace_dat_nr_cpus;
> +extern long trace_dat_options_offset;
> +extern long trace_dat_header_info_offset;
> +extern long trace_dat_events_format_offset;
> +extern long trace_dat_ftrace_format_offset;
> +extern long trace_dat_kallsyms_offset;
> +extern long trace_dat_cmdline_offset;
> +extern long trace_dat_next_options_offset;

[Severity: High]
Are these offsets safe for trace files larger than 2GB on 32-bit systems?

Using long for offsets and relying on ftell() limits the maximum supported
file size to 2GB on 32-bit architectures. Since perf.data files can easily
exceed this size, could this result in integer overflow and corrupted offse=
ts?

Should this use standard 64-bit interfaces like u64 and ftello()/fseeko()
instead?

> +
> +/* collect and manage per-cpu tracepoint event buffers */
> +#define TRACE_DAT_RECORD_TYPE_TIME_EXTEND 30
> +#define TRACE_DAT_RECORD_TIME_EXTEND_SIZE 8
> +#define TRACE_DAT_RECORD_TYPE_LEN_MAX 28
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803145958.2999=
56-1-tshah@linux.ibm.com?part=3D1
