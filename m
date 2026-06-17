Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B375380FC0
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727927; cv=none; b=bNprkL6YJ/0u2giKNtAhMYnXY8jGO8sa8Nsta/YspLjJU6DnJbmkhwTp2JJbvs0lXQ5S20kynBPNKkGMT66tdf6j07IjGmfpCA6Kclz70EAQakRXXG6nrQR/NQLAcMx7fF/SDWo6vnrXCw05JJ82USQaDs1K7vNvueskhqYB9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727927; c=relaxed/simple;
	bh=XoB2PtKoBBYaASyT9eALr9yp+TJQh8dR9kg7uIQ7X3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EmTOtmf03gXzbVZB86uJ95wozv+/XLFmcSmgGPOXrRVxYdeY0+FnH6RX6AIE/MoOcBKP5rSfJ/GKoPQtaDSsCiiMjoduLAi3bW3gHWrAJF7pMPGUcmWGlgeXFp+dqti08umeiCCqcd2VTcG2sDlX9iGfoXLpa882DwpMJlvrl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp2ibjer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp2ibjer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4211F000E9;
	Wed, 17 Jun 2026 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781727926;
	bh=Vn7T+wn5Udhp9KPJ32xgU7YvMg0a55fuHXLRanX4grg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bp2ibjersvz2XieSz1WqRqCzTiLk0fGmfLNBA7n4qrQoQg81Qt9iqIL/Eo+VapyNI
	 FQI1BGilanFelHoymAShtK00STMVm1MIIl1meMlTQEaYlHr8df/ZNqqrWqwFrNpWJQ
	 0qlJHdnuZGPe21eYMgTDL+14ovpQel12nJdNB6zZoHhWlwAUOalzyVX2KXQpTcG4n2
	 Y8R50swrSEOWHOFGevpjTa5jngxyDlWOzX+HoBU3yw/6l26cFsilNtbA/KETISdZfy
	 5Uvnd9aQnlRU7VXl15x8hL0EaxgTWZU+iUcrqPomrcrkl7Jt3XH0nxwJv4++Rwl9AY
	 eoAKEtYbbLMtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/9] perf cs-etm: Fix thread leaks on trace queue
 init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-1-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <20260617-b4-arm_cs_callchain_support_v1-v10-1-e8b6e5d63db5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:25:25 +0000
Message-Id: <20260617202525.CD4211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Crash via NULL pointer dereference in `cs_etm__etmq_get_traceid_=
queue()` when `intlist__findnew()` fails.
- [Medium] Memory and thread reference leak in `cs_etm__etmq_get_traceid_qu=
eue()` when `reallocarray()` fails.
--

commit 81959854a0401183b992f3f15f791657d4e73afb
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Fix thread leaks on trace queue init failure

cs_etm__init_traceid_queue() allocates the frontend and decode threads.
If a later allocation fails, the error path does not drop the thread
references that were already acquired. This patch releases both thread
pointers on the error path to avoid leaking thread references.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0927b0b9c06b1..d484a6155c2c2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -661,6 +663,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_q=
ueue *etmq,
>  	zfree(&tidq->prev_packet);
>  	zfree(&tidq->packet);
>  out:
> +	thread__zput(tidq->frontend_thread);
> +	thread__zput(tidq->decode_thread);
>  	return rc;
>  }

[Severity: Medium]
This isn't a regression introduced by this patch, but while looking at the
thread and memory leaks fixed here, I noticed a pre-existing regression in
the caller cs_etm__etmq_get_traceid_queue() which calls
cs_etm__init_traceid_queue():

tools/perf/util/cs-etm.c:cs_etm__etmq_get_traceid_queue() {
...
	if (cs_etm__init_traceid_queue(etmq, tidq, trace_chan_id))
		goto out_free;

	/* Grow the traceid_queues array by one unit */
	traceid_queues =3D etmq->traceid_queues;
	traceid_queues =3D reallocarray(traceid_queues,
				      idx + 1,
				      sizeof(*traceid_queues));

	if (!traceid_queues)
		goto out_free;
...
out_free:
	intlist__remove(traceid_queues_list, inode);
	free(tidq);

	return NULL;
}

If reallocarray() fails, the code jumps to out_free. Does this leak the
inner allocations and thread references of tidq?=20

It appears free(tidq) is called, but the nested allocations (like
tidq->packet, tidq->last_branch) and the thread references acquired in
cs_etm__init_traceid_queue() are never cleaned up here.


[Severity: Medium]
This is another pre-existing regression in the same function. Looking
slightly higher up in cs_etm__etmq_get_traceid_queue():

tools/perf/util/cs-etm.c:cs_etm__etmq_get_traceid_queue() {
...
	inode =3D intlist__findnew(traceid_queues_list, trace_chan_id);
	if (!inode)
		goto out_free;
...
out_free:
	intlist__remove(traceid_queues_list, inode);
	free(tidq);

	return NULL;
}

If intlist__findnew() fails, inode will be NULL. Could calling
intlist__remove() with a NULL inode cause a crash?=20

It looks like intlist__remove() unconditionally dereferences the node passed
to it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-b4-arm_cs_=
callchain_support_v1-v10-0-e8b6e5d63db5@arm.com?part=3D1
