Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BE352017
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563574; cv=none; b=f3tpzbsD0b31ayJLeNnwqNyWBAvS8GTchO0ciy07J3moTuHkpc+3jyHV9knFBE2SHeUVspnqJYGI5S3p/zN9JEfYqnKObv/sIuXlk3TAfmfQ4XNhO61v7wdsWzQsRxm4KxruLV6HFKyIMvRCS2k3zJ0rFQBcv6Vv9BjMELfhu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563574; c=relaxed/simple;
	bh=U4Q22l+IdLYhteRU1TJLoUVE9RDVglVtAaX3pouQNc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GqAwEAYyXBMWgO88HsLGKelmLXjFvhejo6TW8Es1KB01rqkzvMMf66u4izniY7/0xNKOM23SdO3D2yVNI951NlVAGAjal6l6K/MTjOZVNRfvQnj1cL1/63x0xZA1bb2RT2w8/75PVGnOrusC9y4j2FBbiN3NBjyEX3aEGKMI0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3l3PcqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3l3PcqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF5C1F000E9;
	Mon, 15 Jun 2026 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563573;
	bh=M97EKRnBJUVdGyz/33EuAh3Tntf3ckPw6C7/OaTsrcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3l3PcqPAp08bmzlxjO7dlPV+7XYFNlZ8T1HGqmo0qgQxuUukeWwkrgQAAmYyRePN
	 /nGurvb84fN+aljaDAwMn6OjxqU0xXpMsMD0S0CQmE1njYiobQUPvHgu1eFw5vTKH8
	 8+EhjgfPa66EbsQzBkd52CdRZQ9eHjiWRrtGH40lHympLFFZISh5fgnO7psjwu7n1t
	 vSmVQSDilxRJkuzQ1Y2XZu69atx9zY0KArLoSLodRP8FhJWpRVISLMzRQoYPbclRSr
	 kI1kdW13QYcJLAh/uAo1Sdy9D/srRISeiL+ug109LSCJ6OALDm7OnzZKR37jzssgLd
	 7H402rAHBVweA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] perf cs-etm: Require full global header in
 auxtrace_info size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223249.36598-5-acme@kernel.org>
References: <20260615223249.36598-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:46:12 +0000
Message-Id: <20260615224613.5FF5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient bounds checking for per-CPU metadata allows out-of-bo=
unds reads when parsing and printing crafted auxtrace_info events.
--

commit 3efe458a25dcafb887e671334329fd63dbfdb114
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Require full global header in auxtrace_info size check

cs_etm__process_auxtrace_info() checks that header.size covers
event_header_size + INFO_HEADER_SIZE (16 bytes total), but then
accesses ptr[CS_PMU_TYPE_CPUS] at offset 24 from the start of the
event.  A crafted 16-byte auxtrace_info event passes the size check
but reads out-of-bounds. Include CS_ETM_HEADER_SIZE in the minimum
size check so that the global header entries are guaranteed to fit.

> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
> index 4abe416e3febd..aebef71d3a0a1 100644
> --- a/tools/perf/util/cs-etm-base.c
> +++ b/tools/perf/util/cs-etm-base.c
> @@ -170,7 +170,9 @@ int cs_etm__process_auxtrace_info(union perf_event *e=
vent,
>  	u64 *ptr =3D NULL;
>  	u64 hdr_version;
> =20
> -	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE))
> +	/* Ensure priv[] is large enough for the global header entries */
> +	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE +
> +					  CS_ETM_HEADER_SIZE))
>  		return -EINVAL;
> =20
>  	/* First the global part */

[Severity: High]
This is a pre-existing issue, but I have a question about the subsequent
parsing of the event payload in cs_etm__process_auxtrace_info().

When dump_trace is enabled, it extracts num_cpu from the payload and passes
it to cs_etm__print_auxtrace_info():

tools/perf/util/cs-etm-base.c:cs_etm__process_auxtrace_info() {
    ...
	if (dump_trace) {
		num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
		cs_etm__print_auxtrace_info(ptr, num_cpu);
	}
    ...
}

Does cs_etm__print_auxtrace_info() or its children validate that the event
is actually large enough to contain this many CPUs?

It looks like cs_etm__print_auxtrace_info() iterates num_cpu times, calling
cs_etm__print_cpu_metadata_v1(), which accesses array elements directly:

tools/perf/util/cs-etm-base.c:cs_etm__print_cpu_metadata_v1() {
    ...
	magic =3D val[i + CS_ETM_MAGIC];
	/* total params to print is NR_PARAMS + common block size for v1 */
	total_params =3D val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
    ...
}

Since i is advanced based on the payload-provided parameter count, could
these operations read out-of-bounds if a crafted auxtrace_info event has a
large num_cpu but a short payload?

Additionally, a similar bounds issue seems to exist in the non-dump_trace p=
ath
in cs_etm__process_auxtrace_info_full(). While it verifies there is at least
one u64 per CPU, the loop processing each CPU reads further into the buffer:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
	for (int j =3D 0; j < num_cpu; j++) {
		if (ptr[i] =3D=3D __perf_cs_etmv3_magic) {
    ...
			err =3D cs_etm__create_meta_blk(ptr, &i,
    ...
}

Where cs_etm__create_meta_blk() accesses multiple elements without checking
against the total event size:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk() {
    ...
	nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS];
    ...
}

The strict event size check (i * 8 !=3D priv_size) in
cs_etm__process_auxtrace_info_full() only occurs after the loop finishes.

Would it be safer to check the current offset i and the required size again=
st
auxtrace_info->header.size before reading elements from ptr[] or buff_in[]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223249.3659=
8-1-acme@kernel.org?part=3D4
