Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B593C8C71
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889541; cv=none; b=eC1LRyqCGnBqlz5BvWukXjjTjiwzYjib7JlX4FK1tdgRG7Pjq96IdvzkybXWbZwx2uAmRTUtyGJ+sz8TyGvzZhVtBptrKscu5PwppQ8crbXGJc26wCnorHgpVjaTNfpH2JoVA49al4Wg0m+AHAAYrT6J2Yno9QXGL/aoqHmBFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889541; c=relaxed/simple;
	bh=p6T/v7ZDVG4Ct1VECj+lwwyYV2q+c08iM4DxwOYmSpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l0eIrWl5S/MwYaAiUa3pw4IXf9SWw5ED7WMsUA6hdEx7PAJKbI12UsjJqA4pFKYpT3uxnKo3wsCVXdPrHT+3+fo+pXJGkSCdhxCVrHF+VnkrVC5ofduMLGBetVM9BvAE0IQ4TwIWyQPcZ5SM5D3C3QRfW0AbiHIJaFnf6d8NOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD6BVXSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD6BVXSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E81F0089A;
	Sun, 20 Sep 2026 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789889540;
	bh=p6T/v7ZDVG4Ct1VECj+lwwyYV2q+c08iM4DxwOYmSpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GD6BVXSKTNGMvFFVDpFWIezK2Kbn/lfNsfS4dWKOn9DOE0mh4HdKeTZafOG3OVHbW
	 IU4VTp3hLuQ9dsy0MsXblc6BLPw8UQXA0/098aSajL2JnJj4pG5Bu8jttYkgUPl7RJ
	 mxFnOEaif+qbKf10F9fwAHyG7XffQc+Zoe0hzx2A70GUozNT8qqtiga/EhLZofwmpK
	 zvfwEMKR20We6daqn6a/krK6W3ml/+Kl6zAFjpfzmaBe0MpRFrcRXNmp0Ax78SNF0z
	 BULTLuM9ygy04LNUsoVLqNEDxr55R4OixLhWZ8RpQFz3hraM+U7cZbVtJLO1JBim2e
	 mgMlbF73bzHiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Fix race between perf_event_exit_task()
 and perf_pending_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luo Gengkun" <luogengkun2@huawei.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260920075026.990582-1-luogengkun2@huawei.com>
References: <20260918095049.GL1837346@noisy.programming.kicks-ass.net>
 <20260920075026.990582-1-luogengkun2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:32:19 +0000
Message-Id: <20260920073219.E95E81F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A race condition exists between perf_event_exit_task() and
> perf_pending_task() during begin_new_exec().
>=20
> During begin_new_exec(), perf_event_exit_task() may be called, and the
> PF_EXITING flag is not set on task. So perf_sigtrap() continues to execute
> and triggers WARN_ON_ONCE(event->ctx->task !=3D current).
>=20
> Since both task exit and exec paths can call perf_event_exit_task() which
> sets ctx->task to TASK_TOMBSTONE, fix this by explicitly checking if
> event->ctx->task equals TASK_TOMBSTONE and dropping the redundant
> PF_EXITING check.
>=20
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920075026.9905=
82-1-luogengkun2@huawei.com?part=3D1

