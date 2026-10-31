Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447922;
	b=JnWK1IWjqHx8NPhuu8/oJfSI1TEarb2Kb1zUeQ8sp54WKXdJaLYgNv+YEYl/Xx6jQhfg
	 xz+6WojpsjsEAE5izlazeeq0qnZXMJ1bW8lTfXWHe5w3w4471+56hWyM+A19p0Y5245sy
	 ys7IttazUKBCp2i4DzCJFtYX8Oj8Evl3IvrcaimiXkbe86b/1Nn2tCucpZJGyRd9aho/U
	 7JDnL97Xpi3qV9LHo8lHr3qPSPdVcYwyWezEQcE7u/BanMiJIu7cjZj28qgu0N+Cy0uFC
	 6I3Ojd44obuuX6SVAUrJ+BcMCNV/O2+cVg+4xXSFViBKjoS3EcgsRIULN7q8Ufiv1Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WYsYNtoLzyOK0/FxBEnXX8e63ePRTLVlR1Bt8z3jorU=;
	b=H8rSIHpKrXEQA/Q+F+8yVaQUpVBS1qDtV/OU93iB53LqwmfINUzP40VzbXrqkQ2JHPGJ
	 vSVrnaYiyV3dHF9X91p39SZI26XBfJxfUqYszKjiFd9T5U3Mp+cUx3Jad7ZQ4HiQ9zj27
	 tP2U/LWhOvsX/nBr3rK3kMy7xqvQ4XcH0VeUoXMmDZH53bUtg/bn1Ndgl0y43x1tGOm3g
	 2Lc+gQ6+akHVzgp9Vtf1o4n5ub9ryIPGCyEs7LIL5V41AuI8aEHXvd3C8h5uhdgulsAe+
	 C+qGH3uOv2uqo45JRxIjjE7E0h6WdoRu1Wr3kanInPHRJg81KyOu44nDBIEZi4cvWIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IKI+9v/L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49435606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKI+9v/L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC021F00A16;
	Sat, 31 Oct 2026 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793447922;
	bh=WYsYNtoLzyOK0/FxBEnXX8e63ePRTLVlR1Bt8z3jorU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IKI+9v/Lhs+ipdXEp7619/R+ERxIp13eWWi3Zgm/DCowIQflVf7/CXAtIWEDBi8bG
	 uAnkMdU+tQqdR34zdod4qTyQRDvBZcC4f6uHNr8q+CfV1rp9tuHiVECGvQe2UCK2tC
	 EINzy2aXogi/zpMzQpQNLiD/u3p+yLCoSF9+kC0tBOaD5o0j7L9B2vq/f78IIJrTyC
	 d0kUUTYJvIVD46j7xahRJsvB4eNXCfqRZyt2A+10HOnuMBIgILCG1zOCEwbo23gM+8
	 zEuZzS1KE5UCVil4ULOM4WbpkjvbbtCKelg6loQrj3I/bQAZYfTZPbTcSZQ6w/iHvr
	 rtbm+WfEt0eng==
Message-ID: <sashiko-outbox-191929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Prevent duplicate sigtrap task work enqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261031114520.642476-1-wutengda@huaweicloud.com>
References: <20261031114520.642476-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 11:58:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf/core: redundant store to event->pending_work in __perf_event_o=
verflow()
--

commit badcfdb790f5048e93691fc4bd20053f8cc9e2d2
Author: Tengda Wu <wutengda@huaweicloud.com>

perf/core: Prevent duplicate sigtrap task work enqueue

This commit uses cmpxchg() to atomically claim event->pending_work before
calling task_work_add() in __perf_event_overflow() so that a nested NMI
cannot enqueue the same sigtrap pending_task twice.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 457d75ea71420..f1e4e153c49a4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10925,16 +10925,18 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> =20
>  		notify_mode =3D in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
> =20
> -		if (!event->pending_work &&
> -		    !task_work_add(current, &event->pending_task, notify_mode)) {
> -			event->pending_work =3D pending_id;
> -			local_inc(&event->ctx->nr_no_switch_fast);
> -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -
> -			event->pending_addr =3D 0;
> -			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
> -				event->pending_addr =3D data->addr;
> -
> +		if (cmpxchg(&event->pending_work, 0, pending_id) =3D=3D 0) {
> +			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> +				event->pending_work =3D pending_id;

[Severity: Low]
Is this store to event->pending_work in __perf_event_overflow() in
kernel/events/core.c still needed when task_work_add() succeeds?

The outer cmpxchg(&event->pending_work, 0, pending_id) =3D=3D 0 check alrea=
dy
sets event->pending_work to pending_id before calling task_work_add(), and
nothing can clear or modify event->pending_work while inside this branch
(interrupts are disabled, perf_pending_task() cannot run until return to
user space or task exit, and any nested NMI sees a non-zero value in
cmpxchg()).

Leaving this assignment also performs an unmarked plain write to
event->pending_work, whereas the rest of this change accesses it via
cmpxchg() and READ_ONCE(). Can this redundant assignment be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031114520.6424=
76-1-wutengda@huaweicloud.com?part=3D1
