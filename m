Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB1199E89
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022873; cv=none; b=r6LFw0NBBRjBJqy7poBanHltZ09CVY77nxG1YzaXfqgiMrcUCcn1FG3EZPe9vAekJsldE84j35YMfAyFxGJZZPS7Y1Y9PbJ0KCawdw56r90a3LDZaU/Z9gy0szdOnkqDC/srQfGG6VIXPOvDsW0M0Ydxt+5rWMqX5nT05Dpq660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022873; c=relaxed/simple;
	bh=g3sdEftCCh4n9eWWJtWjEfYZGacQCHDQ9ZoN6mDJ7+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L6JRreSfLDO6vXakgyccOmk0Q9JsbL+Y95DzXgg/EvCS8FkLq9sfXg7Yx99NfR4mTNtbQWsYjGa5pHNM80cXFZYPmstjNXCUcbgvF4mw30Pw5rQd/i8ULLUjS2MPLJyB8lJRcbU/8WRWklCRAVVMEbSOMptXGjU2WikPS20vs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZP8b9WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZP8b9WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398871F00A3A;
	Thu,  2 Jul 2026 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022872;
	bh=8husUu5nqEI6+sanTx/qeLZ/XdspcN0in1Dx7mOp8Vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZP8b9WUAvVb6mPHxqkT1wLqYJB7e1pd3jqQnRijI23BtoCc/SddsdFBsRef61rJs
	 tBeWVcvvNp2nZcHl/J3RZdKJskIqW9r4/qL8rvNBK2dHxFTRPURRSrVKylyk9iOD4O
	 KS7v+siZT+/fYd71EbupqAx6HGd+WVw8J54RYQvxa2EuZqLLYKbWDCjeCyyUrYnyEj
	 YA/eXSdeFoht7EA+UU5SiiSo5812YbFfq2x6wd0p691HOctnZNI4Wv9zWTSVh7ktVj
	 TkJ/9xRgfX2kFV/ThnCATB65kA83vABr97mpBhODw3+wiv3OP6S8bQaMfR5CZZUglK
	 bjGL/5SZLmDFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/9] perf cs-etm: Fix thread leaks on trace queue
 init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-1-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
 <20260702-b4-arm_cs_callchain_support_v1-v11-1-846abbf600d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 20:07:51 +0000
Message-Id: <20260702200752.398871F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a NULL pointer d=
ereference occurs in the error path if `intlist__findnew()` fails.
- [High] This problem wasn't introduced by this patch, but the `reallocarra=
y` error path in `cs_etm__etmq_get_traceid_queue` leaks memory and thread r=
eferences.
--

commit 7d838026b9aad27b43e259b084c832b06d7fc96a
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Fix thread leaks on trace queue init failure

cs_etm__init_traceid_queue() allocates the frontend and decode threads,
if a later allocation fails, the error path does not drop thread
reference that was already acquired.

Release both thread pointers with thread__zput() on the error path, so
does not leak thread references or leave stale pointers behind.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2284cda78abe1..deca07d57282e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -645,6 +645,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_q=
ueue *etmq,
>  					       queue->tid);
>  	tidq->decode_thread =3D machine__findnew_thread(&etm->session->machines=
.host, -1,
>  					       queue->tid);
> +	if (!tidq->frontend_thread || !tidq->decode_thread)
> +		goto out;
> =20
>  	tidq->packet =3D zalloc(sizeof(struct cs_etm_packet));
>  	if (!tidq->packet)
[ ... ]
> @@ -679,6 +681,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_q=
ueue *etmq,
>  	zfree(&tidq->prev_packet);
>  	zfree(&tidq->packet);
>  out:
> +	thread__zput(tidq->frontend_thread);
> +	thread__zput(tidq->decode_thread);
>  	return rc;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
pre-existing NULL pointer dereference in the error path of the caller
cs_etm__etmq_get_traceid_queue() in tools/perf/util/cs-etm.c.

If intlist__findnew() fails and returns NULL:

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

Can this crash? Passing a NULL inode to intlist__remove() eventually
leads to rblist__remove_node(), which will try to dereference the pointer.

[Severity: High]
This is also a pre-existing issue, but does this same error path leak the
internal resources of tidq?

If reallocarray() fails after cs_etm__init_traceid_queue() succeeds:

tools/perf/util/cs-etm.c:cs_etm__etmq_get_traceid_queue() {
    ...
	if (cs_etm__init_traceid_queue(etmq, tidq, trace_chan_id))
		goto out_free;

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

Since cs_etm__init_traceid_queue() successfully allocated dynamic fields
like packet and prev_packet, and acquired thread references that are stored
in tidq, wouldn't free(tidq) leak these allocations and references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-b4-arm_cs_=
callchain_support_v1-v11-0-846abbf600d7@arm.com?part=3D1
