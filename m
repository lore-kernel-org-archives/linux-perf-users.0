Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FD8F4E
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716717526; cv=none; b=aIYxiVxODR5VnsZmUl7HFFC/TT32rIEdzs5wycTr0bmx/DbMn1fLhdqiyrsdZT0bGdbWS3tsgs61dRFi8jQm4+J5D9MkVtJWJr+r+W1VcE40ZWeeFk/y/rHFUgOwkT2k7M5MQx2n+1AEQ08P72AL5x/6ZbMU7PHoBQ2i3Gfc2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716717526; c=relaxed/simple;
	bh=hRnXOL3/JG4PcBU2yqlNxZ96e+xvO+9TwGHHI2I5pnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVwacCdrKnRsr7xwStzqAQsnUcjdvFpemqQNQqndmwkPoqH6FmVY9yYB29WzUPdiWp9RI9fJMz3tSwNd24LRQbubVOXLz7uPVdN6RWGQDTaoaDyL8jj3hGksgp0OPnJK6bWqgvUXyO63lElDgbD/+Fwf2NUwqCbiveOOjTS5QVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kks7iPe5; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kks7iPe5"
X-Envelope-To: irogers@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716717521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4epl//+/WLyc/JhDbO+OjPKpdtrbovVIa7El3gIFMA=;
	b=kks7iPe55jwgWSkp0t9Ue7pLpfBbn+3u4R/aXez1d4hvQEvRYnCw1SV4fU5JAqUVdwSt+5
	6mxomxnsYPGlM7SZdU81kaUReKuTLk07u4H9uoU3Uu9O3PABBt6Vp2pwDRBHdggQcqJ6ER
	5uD47PXKH5HxHCiMdKqgYR0WlEhDnWQ=
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: namhyung@kernel.org
X-Envelope-To: acme@kernel.org
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: mingo@kernel.org
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: adrian.hunter@intel.com
X-Envelope-To: williams@redhat.com
X-Envelope-To: kcarcia@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-perf-users@vger.kernel.org
X-Envelope-To: retpolanne@posteo.net
X-Envelope-To: unixbhaskar@gmail.com
X-Envelope-To: j.ethan.adams@gmail.com
X-Envelope-To: james.clark@arm.com
X-Envelope-To: kan.liang@linux.intel.com
X-Envelope-To: tmricht@linux.ibm.com
X-Envelope-To: tycho@tycho.pizza
X-Envelope-To: yangjihong@bytedance.com
Date: Sun, 26 May 2024 17:58:38 +0800
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Ian Rogers <irogers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anne Macedo <retpolanne@posteo.net>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Ethan Adams <j.ethan.adams@gmail.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
Message-ID: <20240526095838.GA33806@debian-dev>
References: <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1>
 <ZlFGpxWGQskCTjeK@x1>
 <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
 <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Ian,

On Sat, May 25, 2024 at 11:22:08PM -0700, Ian Rogers wrote:

[...]

> In doing that work the code was tested by IBM for S390 and by Intel,
> but it was fixing an ARM created problem. ARM were the first to have
> BIG.little systems but contributed nothing to the perf tool to handle
> it, even though each core type has a different PMU. ARM BIG.little
> remains broken with the perf tool and when I fix it for them they
> don't review or test the code. ARM changed and left unworking uncore
> PMU naming conventions. ARM don't fix tests for their platform. ARM
> don't help make perf's tests cover their different way of naming PMUs.
> No one is trying to break ARM machines, but when ARM fails to do
> anything other than review their own changes in the perf tree it is
> something of an inevitability.
> 
> Fwiw, I am working on making perf record, perf top, etc. skip events
> on non-core PMUs when they fail to open. It is a rather large and ugly
> change. It is also a holiday weekend and I'm spending a lot of my time
> in it addressing latent ARM problems.

James is in holiday, so I should cover this in time. Sorry that I did
not respond the issue quickly - mainly as I am not familiar with JSON
and perf event part.

I tried to reproduce the issue reported by Linus on my Arm big.LITTLE
system but cannot reproduce it. As I saw Linus mentioned the issue is
related with Arm DSU event, which is absent on my test board.

But your complaint is received well and I am very appreciate your work
(especially in the weekend). I will continue to look into the details
in this thread, and monitor incoming patches and I will verify them.

Thanks,
Leo
