Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049334A0907
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303862; cv=none; b=d6znbwmy51G5tdL5VdhHi1W2zX1yhMHqomI/t8QRjCNKdgPMM7/D7ki5uPNEgnMqsNIFqYgiVV//y68pCO/56A1/4d/M1/duRtibcPvLajBLFhG9dLEGWIdXLPtIzF+NImA53xu1/VxS4SMYeyoBsr9x2JSPj6MzqB2xGAi9dF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303862; c=relaxed/simple;
	bh=h2clrGMd9mAvaUkDYDg+c7XFsXkWRPyWML6MfhhZCWo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y5gbbz3WLyN0tOrcvMuL1S3Vup7tRKVbFTAGPE5yvfeS3B3wHMg0sP1v7t4gAO5An4sPWFuUXxSmJtt/Q8W+2DCiNJ2zIOaCAGjwU8rHWvs6JpE09i8JC75gLK2MtUaAf3T1zQexjUQznaMC1Zv2j06MX9Iso7+iU3ZPJFtDfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKNpAQDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKNpAQDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05381F0089B;
	Tue,  6 Oct 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303853;
	bh=h2clrGMd9mAvaUkDYDg+c7XFsXkWRPyWML6MfhhZCWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKNpAQDDsbHk+wx/hj6yMmFgIAUxdWrSPmVUmMZlQeNnE6kXnzt59XhC6faRnFIq1
	 b9x42jY5fvg38TcZj09W7evtXBpVc4aCl8Q5VjVs4Byr1xYJchb00PHzlx9V8BWeP/
	 pm1JHzGYijNv4aBOWrKggwgC1yeci/Ub6n+XBNGfOu+YK2OINDDHvF/8W8tyhwtB+k
	 EvGsy2N4oUmDMp1eGzooorVPIeDtk4zjGkZgT14e04LszUGRlQpp5EssCKuM4nUTNF
	 7RjRWlcQxOJXwdOImAhZUhEiJtvZiQEGUTXGDYBiDH5ecdAZIoiK30Eu5t/o0OEU25
	 REFws1XaGhQPQ==
Message-ID: <sashiko-outbox-162251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] perf test attr: Fix wrong size expectation for
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006161309.3078488-3-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
 <20261006161309.3078488-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:24:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Michael Petlan <mpetlan@redhat.com>
>=20
> Although config4 has been added into struct perf_event_attr, the size
> expectation for the struct hasn't been adjusted. This hasn't been
> noticed, since the testcase's return value has been ignored after
> rewriting the testcase to python until previous commit.
>=20
> Fix that.
>=20
> Fixes: eb89aef367e47010 ("perf headers: Sync perf_event.h/perf_regs.h wit=
h the kernel headers")
> Fixes: 80cdf208117a36de ("tools headers UAPI: Sync linux/perf_event.h wit=
h the kernel sources")
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006161309.3078=
488-1-acme@kernel.org?part=3D2

