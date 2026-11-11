Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441038;
	b=BOM+c6VYUpVILeQNwdZC7KicC70P+BPmgxRCBE2AJxAgOK7Y78ku2k1DDEeuCs68fTe9
	 2nBw68PZY+gIKqHpIU3Qps7J0HJTibp4BaHDLkvL54ejosObzygWe+YRVFO+E0lBDQjYe
	 6tTYv5ek/bEq3VeFwaajfof5Lp0rIewhaGNWMGvooGb39lARgXdba1Rr8PxkzSjovJNO1
	 qw60MeqajJl4dfekcrjG+3eYkyLT3+C7BbCN69KXq6ANfeAHKVp59dA65OX1bhoH0aOGc
	 /+RcvP3Ku/a6pdIs79uEmRRrAV4mLZ//0gxvdcjr3oIkS0NU+qSZVE/4W1Ym/uKSQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441038;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/jXfGizkxO69J+2SCwzA4KedoDtDnbwnGmCtv0wVlkg=;
	b=MxqzeKiLN2yvzZKzldLShEtT8SmcXJXKNHW7szBRxQKKXfH5QS0dsAz+qTWbKPltaUHy
	 x+eH9Qgf4udOmxb6MvHlqcw5AAFeB15TTQg0O10A+LHqEGrZytBNodDpgalMjQNQ67ow3
	 HI9ZDDsphsmyWLUQR9PcUWhbOMCDl5NHs8FnIr9AlpI+SyYQHaCmZuO4rSSvfBDp09h+e
	 8VaQAGBEbfOfyRStFe/h96zAA3WoEFG1nsurMk/8yuIpR4IculzBUaX5MC4g16ojmKtm3
	 RU38VE38FUly2DHOovT7sjc627+xL8LBL2mOHN5uG4sUbGFjWYHXB6W0tOcKL6fooiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="U/9DVXsJ";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0A606A882;
	Wed, 11 Nov 2026 23:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB0A606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=U/9DVXsJ
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FA1F40E021B;
	Wed, 11 Nov 2026 23:50:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id togEw39fOTai; Wed, 11 Nov 2026 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794441032; bh=/jXfGizkxO69J+2SCwzA4KedoDtDnbwnGmCtv0wVlkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/9DVXsJ//TipiRfSbtrji3R+QJOeDJbnzEfTP4DEKq0AeyyQnzbj4foBwLElGZiU
	 HIbJNcstQ7jFzGVm7M2o9w8WLFxsowTw3m8Ck+gK8elSWr9BKMh6Ugrp0XnDBaWIno
	 yttp143cCG6NQ8e2JwHZikXlJ2VQ7SE1qegIvv1IYPzAECuSyKmZbxHfHqFUr6TKIa
	 7lYWT6ln8ATCrZs7om7PjQ5MLeOHtjvDCTJEgLyrzJiO2WdM7hOsekYJ+vjvDiMOLH
	 gPPflgfEjEPbG+o442Obr82IFQll0dBujJF46sCUn21K02RrR/49XY7srHJc6iUK5e
	 MvUzvDtHuUJsRmIr+ERekgShtq6VZdRzcWbKlDA3ijz7R/bx4lbNdolDen+yxDCDVH
	 1zAU3En8+1mwOsXGCjaFLpXvrHWgz/6xZ8JtqEGPxw2hkUZ76UVW0vSH04eAf35Bcu
	 6CsFpYNESdbpvehNPGLSvng8GdGCebkBHmeBTBaMDHHsy1h9I1Pm6Eue0RgVgIvsfg
	 LD8rMNoT1UQjR3YZL7qFxojjRitJhlwlvVKIO9mLOY7ETAy3QTjc2WMPXZrXveuh9L
	 RJIKZDrFTDDYjxYyyzcihianoUz68TlCKVWBSBb5+CC72XJDqOcEMiczaSMrD4HRL+
	 BEs5JFGV4B5JB9e8fBWPWwc0=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 261B940E019C;
	Wed, 11 Nov 2026 23:50:15 +0000 (UTC)
Date: Wed, 11 Nov 2026 15:50:09 -0800
From: Borislav Petkov <bp@alien8.de>
To: Dhruv Gupta <dhruv.gupta@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, tglx@kernel.org, dave.hansen@linux.intel.com,
	x86@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf/x86/rapl: Fix a bug caused by overflow timer
 being calculated using a 200W Max TDP
Message-ID: <20261111235009.GBavT_Ma5Syt72-dLK@fat_crate.local>
References: <20261111151050.329724-1-dhruv.gupta@amd.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111151050.329724-1-dhruv.gupta@amd.com>

On Wed, Nov 11, 2026 at 03:10:50PM +0000, Dhruv Gupta wrote:
> The RAPL energy status counters are 32 bits wide, so the PMU uses an
> hrtimer to fold them into the 64-bit event count before they can wrap.
> rapl_event_update() sign-extends the 32-bit difference between two
> reads, so the counter must advance by less than half of its range
> between updates. A larger advance is treated as a negative delta and
> the event count goes backwards by 2^32 counter units.
> 
> The timer interval is the time it takes to use half the counter range
> at a reference power of 200W. Any package that sustains more than 200W
> between two expirations therefore loses energy. This applies to every
> energy unit, since the interval scales with it: with 2^-16 J units the
> interval is 163.84s and at most 32768 J can be accounted per interval,
> and with 2^-14 J units it is 655.36s with the same 200W limit. Many
> current server processors draw more than that under load.
> 
> On an AMD EPYC 9654 (max default TDP 360W) running stress-ng on all
> CPUs, the package draws about 346W, or about 56 kJ per 163.84s
> interval. Over an 1100s run, "perf stat -a -e power/energy-pkg/"
> reported 4294882289.81 Joules, i.e. -85006 J, while reading the same
> event every second with "perf stat -I 1000" gave 373745.7 J. The
> difference is 458752 J, exactly seven wraps of the 65536 J counter.
> 
> This patch raises the reference power to 1000W. With 2^-16 J units the
> interval becomes 32.768s, and with 2^-14 J units 131.072s. The cost is
> one MSR read per active event per package per interval.
> 
> With this change, the same workload run for 300s reports 104062.71 J
> with plain "perf stat" and 104062.7 J with "perf stat -I 1000".
> 
> Additionally this patch drops the hw-unit check and the 1ms fallback. The

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Please read:

https://docs.kernel.org/process/maintainer-tip.html

before submitting tip patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
