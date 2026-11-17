Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916077;
	b=hV/HAU3LO8c5+HvL5G2/6PeoW/yFoXMd7aYZ7mZLNHEF8mTqgwZPYrIvfmKtqRSWaz6z
	 nF4V/Qxh+QEhgzfQXwnnV5vhk13KhSlQUjiKHlpY2UzJ7ClYta7T5ipyYEn/SZZxQFzeL
	 /CJFoxf/0hTVqAbvDbDtEpHBZL7nakvILMMGytCvSmtCBV0KMGmDaT+XiQXdZzwnoKGEy
	 1HcSOIU4syMiQfcb3JxZChDJudN5mxNmMsg1YLUpA5vvmiMsBx3yrpCHz4V51izk2SDzC
	 +qLxfahVAv48AILIjsOqvMnDztNKUF2T/nnrOpajO5ssrOUDCsQG8csf3jDDowUaeyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916077;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mzCLfTWbTdpsZmQFx1S0wErJ2q1UPwfDlwbR/PR3BdQ=;
	b=bnp1PQlazs/bHFyAKuvpdZZB5IvZcf1/Stbc0KLGpuuHfNDMHMrjz2w9cb2eaI9F8gq4
	 oLExLsCukT7b9pSLOrM7VX4b1WBxItq/O0dL4cM/LEgGTN/Qaoa9fK/sD3nWGc5jDUaZt
	 XD7kz0GMv5EYFkRePEcnhwj5cdYIyJbxouX6BWK+IQ53/fXye3iihaU8UwTTYe5epgtEz
	 NqGYDAdnPnvU3rN74ZOGSK1W23paC6Q4Ux3v4u0/ajQRCbx6yt+HkvCwz8KhsCvMeMf02
	 VKB12NTwp0kf8xnCnQ32hV87DNkDFG9ilbzMn5FmBtc0qEgwimhN8hVV3kKUxiPpurw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcONIdkt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E108606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcONIdkt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A311F1F000C4;
	Tue, 17 Nov 2026 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916076;
	bh=mzCLfTWbTdpsZmQFx1S0wErJ2q1UPwfDlwbR/PR3BdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcONIdktC7WGgOmkgAyAvH4FIcLUi5uYUD44nInpaRNb9HAvQzyU5ZTIILzEUeM0k
	 ljmjAmLIT7Ry//boHPncgiTtqQenzoO0sAOOB4Jm3f/fUKpigU9HHnHlCWh4lPJAUN
	 d3ZVqMRd4BNI/aBT9gA7YOZh+1ZS4IlKmA9xZJxMUVwuePEHhfsD5TwpdVAxPfS5ot
	 0Z2tIEiOwn1L1nhlJQiCYkLaz5f2EQ5y9UI6dmLhjA2lOKOcv8frniSh+A/0RdPVkh
	 Ghr7jtTkFQemtqnXzRUC05pjnKAoXBfss2Io/0rZqNPWcAt1mYObFaYYc9erQRDV5r
	 /LkUSRTJNqV/A==
Message-ID: <sashiko-outbox-218727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1794914794.git.wutengda@huaweicloud.com>
References: <cover.1794914794.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1794914794.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 11:47:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
>=20
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
>=20
> The re-entrant call path looks like this:
>=20
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
> [ ... ]
> the exclude_kernel warning path to ensure the read is properly
> ordered.
>=20
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794914794.gi=
t.wutengda@huaweicloud.com?part=3D1

