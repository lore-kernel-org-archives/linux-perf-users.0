Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DA2FD1B3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968232; cv=none; b=RuHOA603p/JhtT7kDZuCkGz/OkYdb6OvyhZjfCR+qNLcsV1ac+7mJN8zj4MQl6AkZtMDTM9YRPnG+cXexqEnEHuyxHaDBh92kyjYfaBJF3utPjxE95fH0aXsVkhQFWcTD4HabydU/UdqnhgVsw/5DJN52XY18+x0AVhZMpkpRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968232; c=relaxed/simple;
	bh=e2ixwL7IL0Cc9EmZg982AeqsoE0ZII1tcwrZeQVJ0rQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KZ3FPtysrBpf9KSPZ3TVlNvtDlMT9vGvhz7Fg5/rcw5Pv+A67V2akyihI37ym3iWcQ4X2wBhSXinHoPkt2HAM+K+b7DaJOSaZOYeMEE0usqi/TCyWT5caNuA2qXtJ71Y/p1iY64ToF74joE1ztG91MJY3bGjQkLsP4kMxK7zwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOcEjX4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOcEjX4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370A11F00893;
	Tue,  9 Jun 2026 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780968231;
	bh=S7tgKO74Jm1P9QO9/kmGw+Ac/bbvAOXk5Y1YwqHfDRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOcEjX4ZB7gv40lLjwB/eCgtQHLWsKisSwzoI9dvWStmLk2uqysbMHm3K9foFbNk5
	 rSWlcxp12m64n5/stY61+O5Q1piNhxFLRbB42in3/PED6lt0my8Qzy1UP+/3pGGygY
	 B6tYaOPp9QQ4hD32cWk/zQPznLsSTTPSqWgh1RvyImESTXP0PtmohZN6fREZna3OLc
	 t0JyXx9gyz4qiZ3uI3715rVCcyxFHrObAD4TTzA5jUiNO7ijS6Y81ADgUC13cXSNIg
	 EWRQEB2s+rL/sBSQXjxpHl9O7FtjPMUOhNu0BPVvkBI2NEibJ5/rlgDLQmDerIZDl1
	 SIYIb8o64lvog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] perf hists: Fix snprintf() in
 hists__scnprintf_title() UID filter path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-10-acme@kernel.org>
References: <20260609010526.1998472-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:23:50 +0000
Message-Id: <20260609012351.370A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack buffer overflow in `perf_pmu__for_each_event` due to uncheck=
ed `snprintf` return values underflowing the remaining buffer size.
--

commit 4dd3b213a3499e8521320ddfbcd3cb731ac444d2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path

hists__scnprintf_title() accumulates formatted output into a buffer
using scnprintf() for all filter clauses except the UID filter, which
uses snprintf().  If the buffer fills up and snprintf() returns more
than the remaining space, printed exceeds size and the next 'size -
printed' underflows, causing later scnprintf() calls to write past
the buffer. Switch the UID filter clause to scnprintf() to match the
rest of the function.

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 811d68fa6770c..df978c996b6c2 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2963,9 +2963,10 @@ int __hists__scnprintf_title(struct hists *hists, =
char *bf, size_t size, bool sh
>  			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
> =20
> =20
> -	if (hists->uid_filter_str)
> -		printed +=3D snprintf(bf + printed, size - printed,
> -				    ", UID: %s", hists->uid_filter_str);
> +	if (hists->uid_filter_str) {
> +		printed +=3D scnprintf(bf + printed, size - printed,
> +				     ", UID: %s", hists->uid_filter_str);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while you are fixing
this snprintf() underflow pattern, the exact same issue exists in
tools/perf/util/pmu.c:perf_pmu__for_each_event() where it can cause a
stack buffer overflow.

In that function, sequential snprintf() calls format event strings into a
1024-byte stack buffer, accumulating returned lengths into buf_used:

tools/perf/util/pmu.c:perf_pmu__for_each_event() {
...
		if (strlen(event->unit) || event->scale !=3D 1.0) {
			info.scale_unit =3D buf + buf_used;
			buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
					"%G%s", event->scale, event->unit) + 1;
		}
		info.desc =3D event->desc;
		info.long_desc =3D event->long_desc;
		info.encoding_desc =3D buf + buf_used;
		buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_used,
				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
...
}

Because snprintf() returns the length it would have written, if a long
event alias or term string (e.g., from a parsed JSON definition) fills
the buffer, buf_used will exceed sizeof(buf). On the next snprintf() call,
the limit calculation sizeof(buf) - buf_used undergoes unsigned underflow
to a massive positive size_t value.

Could this unsigned underflow disable bounds checking entirely and allow
snprintf() to write string data out of bounds on the stack? Should we switch
these calls to scnprintf() as well?

>  	if (thread) {
>  		if (hists__has(hists, thread)) {
>  			printed +=3D scnprintf(bf + printed, size - printed,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D9
