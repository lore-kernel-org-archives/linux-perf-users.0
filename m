Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304E16631D;
	Fri,  5 Jul 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188025; cv=none; b=W32Mu6AqM531Hnv6BmM91xdgU9gvTrLToXqmpe7zAseahzwsRKxzuSFv1wSO5v4M5hi7f9mzJ+FaZDy43tw3jPyhR8DB95KsFQxpEyiSxI+EguowCZ1RqSzmy9/XEpthgpCJnXPdw7nLDLI/lHKi3WDKQpE7HuCweBnLQ7fVBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188025; c=relaxed/simple;
	bh=agqqKJKzbW1aqKYewjNAaN3ZRgAj8vqnz4dkErwIMAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvcS/0NKLgl/FiPXWPlfbiOxDyIBGqhMPsYGTDlsoOT96c5b4MxhZQq32i9Y+Z40OjDoJgDc+kpAUJsbej7eFYT+kIPv9i+7ZiEv2UkpJIpLlJhdvQ1gF1HpfPfa6vTzwcMWgmEKa2GqzRkokCyvi3hDKNhUg/897CWm4B1Bs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gl+0850E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3WSj4do; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gl+0850E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3WSj4do"
Date: Fri, 5 Jul 2024 16:00:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720188022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd471HKM0n0gUNDpnPVA900itYyFBQtln3wZ3G7NRs4=;
	b=gl+0850EKxXK16hTO9AGF8h6GUxuP3K8vmBITE58g2JPIOuSmEBovzqab7xHuHl0y5+W5m
	aq2k7hQmAcRaldKGhw/dH5dn+nadY+HUePnpWPQGQ/u5MObq7KlyI95kB+rDwUZSpnZejZ
	H4F4yE+fapHZJMfIQ8m3kM15tzYkuT/whg7HlENXHUFBU8jfigFTKEB+sjdCXWRNhqEOfc
	H83BQTiF8iCd1IY+SN/PQy1L7Th9HubilqMmjbaiNizPMqdouP+9pc8qR9hfBuzyE6iyZU
	w7svIQpMzcjCQqXAVubUYR9vCZQQGv8yJdHnmMtLuKvnjzGrXkSUKh+zc10NpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720188022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd471HKM0n0gUNDpnPVA900itYyFBQtln3wZ3G7NRs4=;
	b=v3WSj4dopAUxV6/5VzdjL1JByFgaXRGU9IoRXk5A6t8fOQKOH1f9IpNCz1Hko9TEd+8BRn
	+BMZsK5vSSgdPyAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/7] task_work: Add TWA_NMI_CURRENT as an additional
 notify mode.
Message-ID: <20240705140020.J2dyu3fZ@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
 <20240704170424.1466941-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240704170424.1466941-3-bigeasy@linutronix.de>

On 2024-07-04 19:03:36 [+0200], To linux-perf-users@vger.kernel.org wrote:
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 2134ac8057a94..05fb41fe09f5d 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -1,10 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/irq_work.h>
>  #include <linux/spinlock.h>
>  #include <linux/task_work.h>
>  #include <linux/resume_user_mode.h>
> +#include <trace/events/ipi.h>

Just noticed that this trace include does not belong here. It is a
leftover from an earlier iteration where I intended to use
smp_send_reschedule() instead of irq_work=E2=80=A6

Should I repost the series, or just this one?

Sebastian
