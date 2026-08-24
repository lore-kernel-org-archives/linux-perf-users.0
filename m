Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2F373BF3
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540937; cv=none; b=dTPwuSUWYv5fty55nLfxX+2pRwXQGqM5aMw3CWxiMlBAWyt0+n2SuBOKWDKPRjCu+RkbLLIMRT7ezz7lFD36PKvHlRABXdHc2LjvjRf0c8Mb6O1B6x3f+uH8NRrFP3j3GwydVJnM17cgeBt/zGBA/ianzVLjb0pFTJdROt+ztAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540937; c=relaxed/simple;
	bh=anuDsmfCU/H8ld0jJrnXNpTFRcOoqFzGkLFV4vfGDyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XfWP93AQuZHjZJQ99p2lrhH0AXqheMY5IA/jykVbDIpbBhox/U0eACv1sjFDODNmjYbAq0H2uVBJwIlDMhOCZpEEwDaBMCuAvTufKx5UMsGhoIkQ2yDu1X+C0TWOG+pHjpRVdwTOA1TOYpVi00ThlbJkwDsxGqse34UiGsGoezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPzoOCG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPzoOCG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419351F000E9;
	Mon, 24 Aug 2026 03:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787540936;
	bh=R183Ec+leNIIR2e6RPsI1XkXZNS5qBEB+MFSLeESQ6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPzoOCG+R2d/GThzE7v9eeBYk0yhxkVc0NIwhUAMSXK2aSRV/xuu2MZRwAXZy9JCL
	 THknQ7G4jGtKudw/VL4iWPcVUXxqCiKCbip/6h1l0vhVmFnpTxKPa34qTezmOD+up/
	 BAaJdghSAUStozSGnUEBCbENz+3Y6xpdDqERTU+4YSqxyhK3+mf7p2mpTQXghXhjn2
	 pb/WX3HJwE/spunRKttA0W1kADU2YLjNk3ht8n7KOH942jsLGXjuWBEnf4pypTplc9
	 TkUU9T1jLi3HTErxvI3fnPKnekXPVOElb4wkxPd1UemSqbWMw0fIW23x/c5R5o16Za
	 +9hj3XoyEhmGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix off-by-one in auxtrace_info
 minimum size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yan" <wangyan01@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824025553.363863-1-wangyan01@kylinos.cn>
References: <20260824025553.363863-1-wangyan01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 03:08:55 +0000
Message-Id: <20260824030856.419351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds memory read when indexing `preempt_reasons` and `dis=
patch_reasons` string arrays with unvalidated payload data.
- [High] Missing minimum size validation for auxtrace buffers before parsin=
g `boottb_freq`.
- [High] Invalid `sizeof(record)` usage truncates `sample.raw_size` to 8 by=
tes instead of the full struct size, causing downstream out-of-bounds reads.
--

--- Patch [1]: [PATCH] perf powerpc-vpadtl: Fix off-by-one in auxtrace_info=
 minimum size check ---
commit aa49174859e1464fdc810c66395f70e08682bd05
Author: Wang Yan <wangyan01@kylinos.cn>

perf powerpc-vpadtl: Fix off-by-one in auxtrace_info minimum size check
   =20
This commit fixes an off-by-one error in auxtrace_info minimum size validat=
ion.
It correctly sizes min_sz to include the highest accessed priv index,
preventing an out-of-bounds read when validating the struct size.

Cc: stable@vger.kernel.org

> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-v=
padtl.c
> index 710f3093f3f90..c15636eef34b6 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -683,7 +683,7 @@ int powerpc_vpadtl_process_auxtrace_info(union perf_e=
vent *event,
>  				  struct perf_session *session)
>  {
>  	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> -	size_t min_sz =3D sizeof(u64) * POWERPC_VPADTL_TYPE;
> +	size_t min_sz =3D sizeof(u64) * (POWERPC_VPADTL_TYPE + 1);
>  	struct powerpc_vpadtl *vpa;
>  	int err;
> =20

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_dump() {
    ...
		if (dtl->timebase !=3D 0) {
			printf("dispatch_reason:%s, preempt_reason:%s, "
					"enqueue_to_dispatch_time:%d, ready_to_enqueue_time:%d, "
					"waiting_to_ready_time:%d\n",
					dispatch_reasons[dtl->dispatch_reason],
					preempt_reasons[dtl->preempt_reason],
					be32_to_cpu(dtl->enqueue_to_dispatch_time),
					be32_to_cpu(dtl->ready_to_enqueue_time),
					be32_to_cpu(dtl->waiting_to_ready_time));
		} else {
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but can we read out-of-bounds
memory here?

The dispatch_reasons and preempt_reasons arrays have sizes 11 and 10
respectively. If the untrusted payload contains byte values that exceed the=
se
bounds, it looks like they are used as array indices without validation.


tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_decode() {
    ...
	ret =3D powerpc_vpadtl_get_buffer(vpaq);
	if (ret <=3D 0)
		return ret;

	boottb =3D (struct boottb_freq *)vpaq->buffer->data;
	if (boottb->timebase =3D=3D 0) {
		vpaq->boot_tb =3D boottb->boot_tb;
    ...
}

[Severity: High]
This is a pre-existing issue, but is there a missing minimum size check her=
e?

The auxtrace buffer payload is accessed as a struct boottb_freq and
boottb->timebase is checked. If the auxtrace buffer provides fewer bytes th=
an
the size of the structure, could this read past the end of the provided pay=
load
buffer?


tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_sample() {
    ...
static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
		struct powerpc_vpadtl *vpa, u64 save, int cpu)
{
    ...
	sample.time =3D save;
	sample.raw_data =3D record;
	sample.raw_size =3D sizeof(record);
	event.sample.header.type =3D PERF_RECORD_SAMPLE;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this sizeof() truncate =
the
sample raw size?

Because record is a pointer to struct powerpc_vpadtl_entry, sizeof(record)
evaluates to the size of a pointer (8 bytes) rather than the full struct si=
ze
(48 bytes). Could this cause downstream consumers to read out-of-bounds mem=
ory
when casting the raw data back to the structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824025553.3638=
63-1-wangyan01@kylinos.cn?part=3D1
