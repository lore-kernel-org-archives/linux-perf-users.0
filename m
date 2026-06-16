Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0031F98C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573333; cv=none; b=IdR72rHf4QC6s5Ed1meB1+vQNK0fVP3AB6hUmQrqMrmcFA6k8c8hlIr6VmBu4nNZ7qrWMCyGBWv27fLQkbrpRSmcCeHRoe+CfS5d5544rzhEDLUMsyI6xz9BTvMTfEnA5xHiXVlTjZC5iwW3t0aUU/UIdfNAQaNp6izbDs6mIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573333; c=relaxed/simple;
	bh=FsJxGhMhwYePoUMahBvYefhZccA8nxH7zRMY9U59jkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXO8p462lpG0i8UNDTnk5DvRlJ2jVskbvYpV6WJ3idRVmw8nIA7aE8ufPx72RY7UsFx7t+jsVOMw23WTuNjIUo+YBLpIb1sy1l7sP1EbytJkqExTu/Pwre18jnZR04YaTROSozmwJVsKYTlkkiuf1VT09H3ANVJUNTeK5oK7LiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8xQMoiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8xQMoiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD861F000E9;
	Tue, 16 Jun 2026 01:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573331;
	bh=UKkPIjsM2ZdA/peEbseG6LLCo/8dVgWnpXockFb++kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8xQMoiYaa45WSSjxGls1Vd7Djy4WdoJFoCVNLga59MiVlzE7pLp3d/UdJz20qsaQ
	 VRoIWokClH1NfZV5XACI7wiOqg8aDiQl9XwpMybH4TWMsyV1auQReoEe+Wu1BVlJVq
	 XBHDT0loihqoZk5S/vecWoZ6Z24eNCb4yAwmpdJRoZn6tcQi2fE50X0e48F7Qjpcup
	 CGlzVMQ1qR+TL2uJvIFSxAShLO7/ONZduGpX/wEHIAMpxhDeEHvhe3HberIIPyU4q9
	 WizJ+Oc+aVBVl7lTkDBh6/qTJsM4x2yyDwh3jlYS/jnuIF4gVR644cO2hq+4ZhalX0
	 YL/2MBONpQJWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf cs-etm: Bounds-check CPU in
 cs_etm__get_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616010834.37618-6-acme@kernel.org>
References: <20260616010834.37618-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:28:50 +0000
Message-Id: <20260616012851.6BD861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in auxtrace queue growth logic allows massive out=
-of-bounds heap corruption.
- [High] Implicit signedness cast of `event->auxtrace.idx` causes a negativ=
e index out-of-bounds access.
- [Medium] cs_etm__dump_event() lacks a NULL check for `etmq`, leading to a=
 NULL pointer dereference when processing malformed PERF_RECORD_AUXTRACE ev=
ents with the dump_trace (-D) option.
- [Medium] The `auxtrace_queues__grow` function leaks the old `queues->queu=
e_array` memory when growing the array.
- [Medium] The error path in `cs_etm__process_auxtrace_info_full` permanent=
ly leaks all allocated `etmq` structures.
--

commit d0ad74eaa00ab2c6c0f68cce04f6849c506a5134
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Bounds-check CPU in cs_etm__get_queue()

This commit adds a bounds check for the cpu parameter in cs_etm__get_queue()
to prevent out-of-bounds reads when processing untrusted trace payloads.
It also adds NULL checks for the returned etmq pointer in callers to handle
uninitialized entries correctly.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d121c8f22028d..5d0664ff73b79 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does assigning the untrusted u32 index to=
 a
signed int lead to an out-of-bounds access?

In tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_event():
    int idx =3D event->auxtrace.idx;
    ...
    cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);

If event->auxtrace.idx is 0xffffffff, it casts to -1. If dump_trace is
enabled, this uses a negative idx as an array index, reading an out-of-boun=
ds
pointer from the heap before passing it to cs_etm__dump_event().


[Severity: High]
This is a pre-existing issue, but is there an integer overflow in the auxtr=
ace
queue growth logic that could lead to out-of-bounds heap corruption?

In tools/perf/util/auxtrace.c:auxtrace_queues__queue_buffer():
    queue =3D &queues->queue_array[idx];
    ...
    list_add_tail(&buffer->list, &queue->head);

If idx is read as 0xffffffff from the untrusted perf.data,
auxtrace_queues__grow(queues, idx + 1) is called. The value idx + 1 overflo=
ws
to 0. Inside auxtrace_queues__grow():
    if (nr_queues < queues->nr_queues || nr_queues < new_nr_queues)
        return -EINVAL;

This evaluates to false, the array remains at its original size, and
success is returned. Execution continues with
queue =3D &queues->queue_array[0xffffffff], which writes linked-list pointe=
rs
massively out of bounds.


[Severity: Medium]
This is a pre-existing issue, but does cs_etm__dump_event() need a NULL che=
ck
for etmq?

In tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_event():
    cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);

If idx is larger than the currently allocated queues, auxtrace_queues__grow=
()
dynamically expands the array, leaving the new .priv pointers
zero-initialized (NULL). Because cs_etm__dump_event() unconditionally
dereferences etmq->decoder, could a malformed PERF_RECORD_AUXTRACE event
with the dump_trace (-D) option cause a segmentation fault?


[Severity: Medium]
This is a pre-existing issue, but does auxtrace_queues__grow() leak the old
queues->queue_array memory?

In tools/perf/util/auxtrace.c:auxtrace_queues__grow():
    queues->queue_array =3D queue_array;

When the array is expanded, a new array is allocated and the old state is
copied, but it doesn't appear that free() is ever called on the old
queues->queue_array pointer.


[Severity: Medium]
This is a pre-existing issue, but does the error path in
cs_etm__process_auxtrace_info_full() permanently leak all allocated etmq
structures?

In tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full():
err_free_queues:
    auxtrace_queues__free(&etm->queues);
    session->auxtrace =3D NULL;

If a setup step fails, auxtrace_queues__free() is called, which only frees
the queue array and buffers, but not the decoder-specific .priv pointers.
Because session->auxtrace is then set to NULL, the generic session teardown
will also fail to call cs_etm__free_events(), leaking the etmq structures
and their internal red-black trees.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616010834.3761=
8-1-acme@kernel.org?part=3D5
