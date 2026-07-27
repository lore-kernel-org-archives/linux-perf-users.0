Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148432B9BB
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169776; cv=none; b=QXN6n3pydfVo0sOctyzsVSSkppc2zwB8DgThLTe3KFuIOaPjvq5OM//aHeVil+4PrRtwXwsJkodbVaMxOVc1I77qnWg67OWppF3h9sKLEhR2SZCnB5rjw5iztz9NQYdTTIdd25afxvcQ19NVoi6yaU3kZIlf2FaWhF1bZHFV+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169776; c=relaxed/simple;
	bh=M8FpEWz5l5Q+c/2652ZBVlbSx+t9O4m0fVUhTyIf6dI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NQOrIFcQaoVk8d5pKbgouvEy523Xek3OpXsyR+l1cm+LPjmUy/6R6Zc/nEV3EfCJDA8yudC3xnH9AxBpMoGi4L5NCE+qJAW6utQ2tN5W3RUShUZ4r3jmTCx2enR5ydWPEjETwuoM+JrZ5VfCFBjcKK3bFTOnuspnF7EQSbzY6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvjADMqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvjADMqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFB51F000E9;
	Mon, 27 Jul 2026 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169775;
	bh=1Kj4+1R41Nln9b2cv0gEdnzAhk3Pq/a3ySGM2g2GrXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvjADMqf4sml4D0DZlQM1N9lnNPwWbcbyQxgYlOcAdLEQoMUgNOZx8MNB3Ya7ewQs
	 Q/OY80vmXMeyFyiq9mOm5QLR4DqhtdZnYYol2Nm3dQf7BXiC4G8/3OC6yjSuganZlx
	 4/2P5BHgwMUH5msZpI9oQa/x4HQZpj44cw9ZeXGr4uvz7iyxa7x6Ly/+Z/AUZpj0xQ
	 mVWOBRoq+jp8YJklkoC/1VD0i1bxqf3upxSYqB4Pw7myr+c5h9bKRVgOgJUQsHj0Nj
	 NfCau6cHcRGe+JTKQSL9IVYQBkPQ+5pqs1NvQqPRp/CZvBc1q16PyH4J7IoUPLxTww
	 pA+jiA053PILQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf auxtrace: Fix queue grow overflow and old
 array leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260727161705.64807-3-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:29:34 +0000
Message-Id: <20260727162935.3CFB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An infinite loop can be triggered in `auxtrace_heap__add()` when `=
queue_nr >=3D 0x80000000`. This is reachable via the CoreSight ETM decoder =
(`cs-etm.c`) which shifts `queue_nr` left by 16. An attacker can supply a m=
alformed `perf.data` file with an AUXTRACE event `idx` of 32768 to trigger =
this.
--

--- Patch [2]: [PATCH 2/5] perf auxtrace: Fix queue grow overflow and old a=
rray leak ---
commit 6cc7c2090ef2457b5027b79136b869818ae856ee
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf auxtrace: Fix queue grow overflow and old array leak

auxtrace_queues__grow() has two bugs:

1. When idx is UINT_MAX, the caller passes new_nr_queues =3D idx + 1 =3D 0.
   The function skips growing (since any nr_queues >=3D 0), returns
   success, and the caller accesses queue_array[UINT_MAX] =E2=80=94 an OOB
   heap write.  Fix by rejecting new_nr_queues =3D=3D 0 up front.

2. The function allocates a new queue_array via calloc and copies
   elements from the old array, but never frees the old array.  Fix
   by saving the old pointer and freeing it after the copy.

Fixes: e502789302a6ece9 ("perf auxtrace: Add helpers for queuing AUX area t=
racing data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 4cd2caf540152..171edddc982fc 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -251,8 +251,12 @@ static int auxtrace_queues__grow(struct auxtrace_que=
ues *queues,
>  {
>  	unsigned int nr_queues =3D queues->nr_queues;
>  	struct auxtrace_queue *queue_array;
> +	struct auxtrace_queue *old_array =3D queues->queue_array;
>  	unsigned int i;
> =20
> +	if (!new_nr_queues)
> +		return -EINVAL;
> +
>  	if (!nr_queues)
>  		nr_queues =3D AUXTRACE_INIT_NR_QUEUES;
> =20
> @@ -267,16 +271,17 @@ static int auxtrace_queues__grow(struct auxtrace_qu=
eues *queues,
>  		return -ENOMEM;
> =20
>  	for (i =3D 0; i < queues->nr_queues; i++) {
> -		list_splice_tail(&queues->queue_array[i].head,
> +		list_splice_tail(&old_array[i].head,
>  				 &queue_array[i].head);
> -		queue_array[i].tid =3D queues->queue_array[i].tid;
> -		queue_array[i].cpu =3D queues->queue_array[i].cpu;
> -		queue_array[i].set =3D queues->queue_array[i].set;
> -		queue_array[i].priv =3D queues->queue_array[i].priv;
> +		queue_array[i].tid =3D old_array[i].tid;
> +		queue_array[i].cpu =3D old_array[i].cpu;
> +		queue_array[i].set =3D old_array[i].set;
> +		queue_array[i].priv =3D old_array[i].priv;
>  	}
> =20
>  	queues->nr_queues =3D nr_queues;
>  	queues->queue_array =3D queue_array;
> +	free(old_array);
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the queue si=
ze
checks here, I noticed a similar unbounded shift loop in auxtrace_heap__add=
().

Could a malformed perf.data file with an AUXTRACE event idx of 32768 trigger
an infinite loop?

The CoreSight ETM decoder shifts the queue_nr left by 16:

tools/perf/util/cs-etm.c:TO_CS_QUEUE_NR() {
#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)	\
		      (queue_nr << 16 | trace_chan_id)
}

If queue_nr is 32768, the macro evaluates to 0x80000000. When this value is
passed to auxtrace_heap__add(), it triggers this loop:

tools/perf/util/auxtrace.c:auxtrace_heap__add() {
	if (queue_nr >=3D heap->heap_sz) {
		unsigned int heap_sz =3D AUXTRACE_INIT_NR_QUEUES;

		while (heap_sz <=3D queue_nr)
			heap_sz <<=3D 1;
...
}

When heap_sz reaches 0x80000000, it satisfies 0x80000000 <=3D 0x80000000,
shifts left by 1 overflowing to 0, and then 0 <=3D 0x80000000 remains true
indefinitely, causing an infinite loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161705.6480=
7-1-acme@kernel.org?part=3D2
