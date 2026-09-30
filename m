Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131648B371
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810705; cv=none; b=YYdABXymnIs10QfG2lz02bLeVCY874sFpOfDZY1WOTRXKdNin9PCtQJWFDrcecP9BG2GuciiTGGQHcSmjDac1PJn9A4qzDB8C2hTwmis03v2cnY8GPvXYU2RFWclSVUZqle8nJRjW03gVAwG1bt+OeejXwwPYdqej8W8G5SjP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810705; c=relaxed/simple;
	bh=9PA8UKwSmtPXVhKF50stSSh7QFWYV0fe2Zw2PcC0gu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPjmVHK3TfxNR83GJFWSowxFnQsjlD6gPAqJ9Oh0J+9s3txraSffbvsPeu021xBrPS5jHPM8Z2Elethgl6jxW3Tw460grwAeQfTogQTa8aseMlk37L92ynKpMW7zBMGY0GSWZLhQjRLyQP+UVWBCRZrbdyu5pqfW+HQo+AAaw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvjrnNkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvjrnNkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883BB1F000FF;
	Wed, 30 Sep 2026 23:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810703;
	bh=Qr39AJJWh2P6FACMbsiL7KwXXdjOo8Wxo/20jH/X4ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hvjrnNkORGvVXvUAD5HVxdfVOHIF2xUf7NAcODVOobNq2l/4XXNOMTJUmz/lwIHBK
	 /fGEFrrS7gZ/mmILJRgXWLcytLEhQ5FykixeT9z3Xs6s/kRKh5ERjP59ddPVOBK1Ik
	 J5VhxRRA9BbXeGzObXbnajOaSHFjwE2NiFt1cWLBKchyHBTID+xuAqFBThg5ZpnQhQ
	 iOSXQ16pGzlw8LNue9WTuAezYpO7EDRUQJXgHpksSDZm6trtEpGpvtYx8amEHoKhOD
	 yDpCEyLHu3FSMUzZqAmr1gZsqvl1V2MMt2Nf9PmwsxtwnIm/JrfJEsagPv7XJTcvQk
	 7FzSuRWtwQpjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf/arm-cmn: Don't schedule events on a CPU
 which no longer owns the PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930231127.3094040-2-harisokn@amazon.com>
References: <20260930231127.3094040-1-harisokn@amazon.com>
 <20260930231127.3094040-2-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 23:25:03 +0000
Message-Id: <20260930232503.883BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/arm-cmn: stranded event in old CPU context due to migration=
 race
--

commit 79c6912babc23948df500b06efb6265f5c3afcf3
Author: Haris Okanovic <harisokn@amazon.com>

perf/arm-cmn: Don't schedule events on a CPU which no longer owns the PMU

perf_event_open() can latch cmn->cpu and then install the event after a
migration has already moved the PMU. The driver has no locking -- it
relies on all events living in one CPU's context -- so such an event
races the owning CPU and can corrupt the shared DTC and DTM state,
giving wrong counts. arm_cmn_event_add() now rejects an event which is
not on the owning CPU.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index b162de3d9d169..0a35a692241dd 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2098,6 +2098,9 @@ static int arm_cmn_event_add(struct perf_event *eve=
nt, int flags)
>  	enum cmn_node_type type =3D CMN_EVENT_TYPE(event);
>  	unsigned int input_sel, i =3D 0;
> =20
> +	if (cmn->cpu !=3D smp_processor_id())
> +		return -ENOENT;
> +

[Severity: Medium]
While this rejection successfully prevents data corruption during a race wi=
th
PMU migration, does it leave the newly created event permanently stranded?

If arm_cmn_migrate() runs after perf_event_open() reads cmn->cpu without
taking locks, but before perf_install_in_context() completes, the event will
land in the pre-migration CPU context. Because smp_processor_id() no longer
matches cmn->cpu, this check returns -ENOENT.=20

This leaves the event marked INACTIVE by the perf core and permanently stra=
nded
on the wrong CPU context, where it will silently fail to collect counts wit=
hout
crashing.

Could this race be handled differently so the event gets correctly migrated=
 or
rejected during creation, rather than silently failing to activate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930231127.3094=
040-1-harisokn@amazon.com?part=3D1
