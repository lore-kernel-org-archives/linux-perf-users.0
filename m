Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849431ED80
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787381088; cv=none; b=rLxVCW+TxR2qV/PBk5K0kU4s4OtzkGdaYTaT7X3OPIn4LOlpFvPRBD377Qg9PZ0PbjBBbAZALSLfX7meLes7+Own89IezxJv7hi2zUiYa/Og/25Vr4e2HCHpojNsY1xvRn5fBHhwWI3UPJidbIu5OUM2Xeo4X5R0ml5PLOWkcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787381088; c=relaxed/simple;
	bh=wlFCUXFFqiuet4Z3TSfXWkpXMRDXxvoMnCm/Y4VznPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o7KMQT//wdP3rBb9duwfcn5JQ8v9azbFM3vvatq5kH9QqZDd8oORGs119fU83RSjqTFx7E4LXRQDBGqR0CadY301GA/dLiHXOa3nPC7G6RHIw4tRD7pkzqq/0alTMvA3lNX3+SVrUR5TT/e1lZcub4Vp9LbLev7vPYVmhhrf1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX99aYVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX99aYVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24B41F000E9;
	Sat, 22 Aug 2026 06:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787381087;
	bh=r87N7p2u6g/PYlcoo8zCWDT0Zfuttdfo2vV1P2NPNVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TX99aYVtcUw6SR3/m0w8CiIU//0Md+Lct0MKv7IMugFdua3uo7s9xyCH8LzaIGbnF
	 nwUdqsYcx8j5JZMx19CSUCjhkNlVzDPpGMVZwdNosQTXfnVXiH9VF45jXB15eeJ2VS
	 T1bQaSkCQkc51x/ZFUMD1UHeyUR0fHRyAISRztFSAAb9+Bog97pKmsrf6yPR+W0q6y
	 8C6fMDr7YZNpSkaDU72WxrdTZldUhlzEoXuLKW5aucWyIQ5KX9awI8KSKNX8Pps2by
	 LkSzATYcrG13QTp6ZHMPjiAesV/6XfLB1EyuZxsghttQlrcan10DVsja+vK9bmtze3
	 qP4J6BoocAdTg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/5] perf/trace-event: Write trace.dat metadata
 sections during parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822062729.882005-3-tshah@linux.ibm.com>
References: <20260822062729.882005-1-tshah@linux.ibm.com>
 <20260822062729.882005-3-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 06:44:46 +0000
Message-Id: <20260822064446.D24B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Missing bounds check on `raw_size` leads to massive out-of-bou=
nds read and heap buffer overflow.
- [High] Hardcoded 16-byte page header breaks parsing of trace data recorde=
d on 32-bit architectures.
- [Medium] Host state leakage / Cross-platform analysis violation when embe=
dding the TRACECLOCK option.
- [Medium] Signed integer overflow causing undefined behavior in TIME_EXTEN=
D bitshift.

Pre-existing issues:
- [Critical] Integer overflow in `read_saved_cmdline` size calculation lead=
s to a heap buffer overflow on 32-bit systems.
--

--- Patch [2]: [RFC PATCH v4 2/5] perf/trace-event: Write trace.dat metadat=
a sections during parsing ---
commit 75d79e7a5c5c4a1484c389705c19fc30dbdd1deb
Author: Tanushree Shah <tshah@linux.ibm.com>

perf/trace-event: Write trace.dat metadata sections during parsing

Perf already captures the tracing metadata as a part of
data section in perf.data

When trace_dat_fp is set, write trace.dat compatible metadata
sections using the perf provided raw buffers.

> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
> --- a/tools/perf/util/trace-dat.c
> +++ b/tools/perf/util/trace-dat.c
[ ... ]
> @@ -161,8 +164,12 @@ static int trace_dat__write_page(FILE *fp, unsigned =
long long base_ts,
>  		commit +=3D rec_sizes[i];
>  	}
> =20
> -	memcpy(page, &base_ts, sizeof(base_ts));
> -	memcpy(page + sizeof(base_ts), &commit, sizeof(commit));
> +	/* Byte-swap page header for cross-arch compatibility */
> +	ts_out =3D to_file_u64(pevent, base_ts);
> +	commit_out =3D to_file_u64(pevent, commit);
> +
> +	memcpy(page, &ts_out, sizeof(ts_out));
> +	memcpy(page + sizeof(ts_out), &commit_out, sizeof(commit_out));

[Severity: High]
Does this hardcode a 16-byte page header regardless of the original
architecture's commit size?

If the original trace was recorded on a 32-bit machine, its header_page
metadata usually specifies the commit field as a 4-byte local_t. Writing a
hardcoded 8-byte commit field here might cause parsers to misalign by 4
bytes, potentially interpreting the upper half of the 8-byte commit as
the first event record's header and breaking parsing.

[ ... ]
> @@ -229,11 +237,18 @@ static int trace_dat__write_cpu_dat(FILE *fp, int c=
pu, unsigned long long *file_
>  			if (!extend)
>  				return -ENOMEM;
> =20
> -			extend_hdr =3D
> -				((time_delta & TRACE_DAT_RECORD_TIME_MASK) <<
> -				 TRACE_DAT_RECORD_TIME_SHIFT) |
> -				TRACE_DAT_RECORD_TYPE_TIME_EXTEND;
> -			delta_upper =3D time_delta >> TRACE_DAT_RECORD_TIME_SHIFT;
> +			if (tep_is_file_bigendian(pevent)) {
> +				extend_hdr =3D (time_delta & TRACE_DAT_RECORD_TIME_MASK) |
> +				     (TRACE_DAT_RECORD_TYPE_TIME_EXTEND << 27);
> +				delta_upper =3D time_delta >> 27;

[Severity: Medium]
Could this left shift result in undefined behavior?

Assuming TRACE_DAT_RECORD_TYPE_TIME_EXTEND is defined as 30 (a 32-bit signed
integer literal), shifting it left by 27 bits yields 4026531840. This excee=
ds
the maximum representable value of a 32-bit signed integer, which can cause
undefined behavior in C.

[ ... ]
> @@ -311,8 +332,11 @@ static int trace_dat__write_cpu_dat(FILE *fp, int cp=
u, unsigned long long *file_
>  		memcpy(data_rec, &hdr_word, TRACE_DAT_WORD_SIZE);
> =20
>  		/* Large events: write actual byte length after header */
> -		if (type_len =3D=3D 0)
> -			memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len, TRACE_DAT_WORD_SIZE=
);
> +		if (type_len =3D=3D 0) {
> +			unsigned int data_len_out =3D to_file_u32(pevent, data_len);
> +
> +			memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len_out, TRACE_DAT_WORD_=
SIZE);
> +		}
> =20
>  		memcpy(data_rec + payload_offset, event->raw, data_len);

[Severity: Critical]
Is it possible for a crafted perf.data file to cause an out-of-bounds read
and heap buffer overflow here?

If the original sample's raw_size is maliciously set near UINT_MAX
(e.g., 0xFFFFFFFF), the data_rec_size calculation in
trace_dat__write_cpu_dat() calculates data_rec_size =3D 8 + data_len, which
wraps around to 7. This bypasses the page size check and allocates an 8-byte
heap buffer. The memcpy() here then attempts to copy gigabytes of data into
that small buffer.=20

Similarly, earlier in trace_dat__collect_cpu_event(), malloc(0xFFFFFFFF)
could succeed on a 64-bit host, causing the subsequent memcpy() to read
gigabytes out-of-bounds.

[ ... ]
> @@ -464,16 +500,17 @@ int trace_dat__write_options_section1(void)
>  	payload_start =3D ftell(trace_dat_fp);
> =20
>  	/* CPUCOUNT option */
[ ... ]
>  	/* TRACECLOCK option */
> -	opt_id =3D TRACE_DAT_OPTION_TRACECLOCK;
> +	opt_id =3D to_file_u16(pevent, TRACE_DAT_OPTION_TRACECLOCK);
> =20
>  	path =3D get_tracing_file("trace_clock");
>  	if (path) {
>  		clock_file =3D fopen(path, "r");

[Severity: Medium]
Does this inadvertently leak the conversion host's state into the
converted trace data?

Since this dynamically queries the local host's trace_clock via
get_tracing_file(), it embeds the local machine's unparsed clock file conte=
nts
(such as "[local] global...") instead of preserving the original recorded
machine's clock metadata, potentially breaking cross-platform reproducibili=
ty.

[ ... ]
> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -383,6 +615,27 @@ static int read_saved_cmdline(struct tep_handle *pev=
ent)
>  		pr_debug("error reading saved cmdlines\n");
>  		goto out;
>  	}
> +	/* Write cmdlines section with data */
> +	if (trace_dat_fp && !trace_dat_write_failed) {
> +		unsigned short section_id =3D to_file_u16(pevent, TRACE_DAT_SECTION_CM=
DLINE);
> +		unsigned short flags =3D to_file_u16(pevent, 0);

[Severity: Critical]
This is a pre-existing issue, but does the size calculation for the
saved command line buffer overflow on 32-bit systems?

Looking at read_saved_cmdline(), when size is read as a 64-bit value, if it
is 0xFFFFFFFF, the allocation calculation of size + 1 overflows to
0x100000000.

On 32-bit architectures, this is truncated to 0, causing malloc(0) to return
a small valid pointer. The subsequent do_read(buf, size) then passes
0xFFFFFFFF to the read() syscall, which can overwrite the heap and
potentially cause a denial of service or arbitrary code execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822062729.8820=
05-1-tshah@linux.ibm.com?part=3D2
