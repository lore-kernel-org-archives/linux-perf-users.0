Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BC79CD
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563737; cv=none; b=quJg+fayJYHhFXySVlDloWjDaZ3W3yLPyGrzr2slsJjv8zLqQ7rJkaSnjKhN3I4xyoWJy4hKisXRuwQ642hl7xV7JHpYfCEW4ZvCyPlAx0Symd+baqjFrmKh0x+dRCy5Q//NmYnMN7UW3wcAOBptBJTcZ2VDt5UqKWP8UJaBsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563737; c=relaxed/simple;
	bh=COBFxC59vDNZoGkytA+WGCfFu1Im7b3QXH0aBBl2LRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EAzG5UJwZhycw35+wUaLljLXeii0vsjoiR9sjKIDFb2fXZs4YcLQ274smDoSih5fe7DgbWxdqqWczicO3umUD6rJtWlOyvynZesFqOG0fjClQ6UIBxCy3jKjeUFC+XX//1hDc69cgQCoWr+gvVJoNV9ue7w3yQ4SqrbaQXSLAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh0+aT0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh0+aT0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D051F000E9;
	Mon, 15 Jun 2026 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563736;
	bh=95y8FjKV1bKCeShGmFL7bwgH8KHwuuKjTsDucOiw0FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kh0+aT0w6z2v1H4+KXImS56nHbn6mUipCsEr+DdKRGz9ljTgFaR+SaIPrgXn+u6nj
	 yqbxtOvakS5AxcNsbs9R58PwVsfqsm7QMUJHCYt6pybwnjJkv6+R1Bh36Y/mCTXihF
	 4jraQg+2ghRhrZFffyhnGaxayMnnQPW8zWndQWK5o2Mx1Dui4YbNBKs+n+yNLt7eTY
	 RUvglQtWpNH66RZjbBof03X4yNm8w+/JhRx8yeWmeYQMEcG8ZfBDmktph4guk/QhN+
	 jwecvPwED8z5NtJw3iopCrwsY1XAsH7wxyPUkM7DM5XhEgg9ETZcbOHb/TJNBGy0l0
	 6jDcxvfMcfHIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf cs-etm: Validate num_cpu before metadata
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223249.36598-4-acme@kernel.org>
References: <20260615223249.36598-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:48:55 +0000
Message-Id: <20260615224856.18D051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Insufficient bounds check for the CPU metadata parsing loop lead=
ing to out-of-bounds memory reads from untrusted data.
- [Medium] Missing bounds validation on `num_cpu` before printing trace met=
adata causes out-of-bounds memory reads.
- [Medium] Memory leak of `cs_etm_queue` structures and RB trees on initial=
ization error paths.
--

commit d0500b50aa50740d3a89612a4e4d97ba8f0c3129
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Validate num_cpu before metadata allocation

This commit bounds num_cpu by checking it against the total available priva=
te
data size to prevent an integer overflow and subsequent out-of-bounds writes
during metadata allocation.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0927b0b9c06b1..d121c8f22028d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3431,6 +3431,18 @@ int cs_etm__process_auxtrace_info_full(union perf_=
event *event,
>  	/* First the global part */
>  	ptr =3D (u64 *) auxtrace_info->priv;
>  	num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;

[Severity: Medium]
This is a pre-existing issue, but does dump_trace in
cs_etm__process_auxtrace_info() extract and use num_cpu for
cs_etm__print_auxtrace_info() before this new validation occurs?

tools/perf/util/cs-etm-base.c:cs_etm__process_auxtrace_info() {
    ...
    if (dump_trace) {
        num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
        cs_etm__print_auxtrace_info(ptr, num_cpu);
    ...

If so, an attacker could still trigger out-of-bounds reads by specifying an
excessively large num_cpu when perf report -D is run.

> +
> +	/*
> +	 * Bound num_cpu by the event size: the global header consumes
> +	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
> +	 * metadata entry after that.
> +	 */
> +	priv_size =3D total_size - event_header_size - INFO_HEADER_SIZE -
> +		    CS_ETM_HEADER_SIZE;
> +	if (num_cpu <=3D 0 || priv_size <=3D 0 ||
> +	    num_cpu > priv_size / (int)sizeof(u64))
> +		return -EINVAL;
> +

[Severity: Medium]
This is a pre-existing issue, but does the metadata parsing loop later in t=
his
function lack a bounds check for the buffer size?

While num_cpu is now bounded, the loop iterates j < num_cpu and calls
cs_etm__create_meta_blk() which advances the index i:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk() {
    ...
    nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS];
    ...
    i +=3D nr_in_params + nr_cmn_params;
    *buff_in_offset =3D i;
    ...

Can a crafted nr_in_params bypass the new bounds check and cause an
out-of-bounds read on the next iteration?

>  	metadata =3D zalloc(sizeof(*metadata) * num_cpu);
>  	if (!metadata)
>  		return -ENOMEM;

[Severity: Medium]
This is a pre-existing issue, but does the err_free_queues path in this
function leak the queue->priv allocations?

If an error occurs later in cs_etm__process_auxtrace_info_full(), it cleans
up via:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
err_free_queues:
    auxtrace_queues__free(&etm->queues);
    ...

auxtrace_queues__free() frees the arrays but doesn't free the dynamically
allocated cs_etm_queue structures stored in queue->priv from
cs_etm__setup_queue(). Is an additional cs_etm__free_events() style cleanup
needed to prevent memory leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223249.3659=
8-1-acme@kernel.org?part=3D3
