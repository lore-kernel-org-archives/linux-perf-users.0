Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9631E1A16;
	Thu, 10 Apr 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298926; cv=none; b=f63LZ2RM73VYQ/mB2445h4GtdKcaGZXtSSZJgocCL8IwfIeqf/Dpnq8bEhfmPEZGs7w/ugEn4qDZwxR6Q7sUqUl5EjGGwWe+Hr1QKhc0v6ySLpGxJN0xos7SmCsjChqwaRIfgl8ZMjAQiYR9KzkxNTfKrYc20wAByODxihNe7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298926; c=relaxed/simple;
	bh=718k6QvGmJu05O7VkQL4HPbifWCi7RFcg9TeJJXoaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7iyxWTXuoJKmAj0YXQQjbi8JsXduRyJ0mpMF3sp2Zjn4MT67ND0ASt2x/yu2gIxJS0yflH83l0ap/cxRcACkyf0T7fwKpW26Pq00eCUmJTv7wTb6+y24V6ePhqVSE4EKO5bRqw4KkJg+UyyilDnEnqDhuh9GMG/hfkY8lzaqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dt5ZIdAP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkpxuEuk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dt5ZIdAP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkpxuEuk"
Date: Thu, 10 Apr 2025 17:28:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744298922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg5shFLUj81Z+cE91CGDcMYonXV2MYb1+smZ4TlyyOo=;
	b=Dt5ZIdAPbILzH0QnkRmb3I6tRXs8ThFMLQUXOfUE0EufFTGv1RXkn1IHycjWdncEXPiByw
	E+DXRabbwPRbGW4FnCbiKqQdA5stCyxjUdUhmEWjyFIOR/BFNUPVqLXcfuhUBimwuw54LH
	F1X5V3Ys0LqhJKDoNIuA/Uo3JvPYKiwS3t45qZAj0izllaSyRcXXk933OjPKKxiFpuo/iV
	Q6EypLWNym09zc5IMgTDoSf42qNrUuu0dChCGXy0A+o6VMO6ukd+7156HMYoewzjqyRJk0
	q7y6qg9v94iV/qySDsBNnNbJ49/pUwjoExqo6yFv7FV4VYr1tsWUGhARlRGx5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744298922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg5shFLUj81Z+cE91CGDcMYonXV2MYb1+smZ4TlyyOo=;
	b=MkpxuEukUunfjoMwHw1/7JSRzcuSSq4IcujUeiXJJR2Kw9mGe2anSkcQi+R/omWX1AZpJZ
	WQymkLmFyLgupGDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 19/19] futex: Allow to make the private hash
 immutable.
Message-ID: <20250410152841.KypBTUMq@linutronix.de>
References: <20250407155742.968816-1-bigeasy@linutronix.de>
 <20250407155742.968816-20-bigeasy@linutronix.de>
 <ced9c08c-a017-495f-978b-0c4d13992e5e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ced9c08c-a017-495f-978b-0c4d13992e5e@linux.ibm.com>

On 2025-04-10 20:22:08 [+0530], Shrikanth Hegde wrote:
> Hi Sebastian.
Hi Shrikanth,

> It would be good option for the application to decide if it needs this.

You mean to have it as I introduced it here or something else?

> Using this option makes the perf regression goes away using previous numb=
er of buckets.

Okay, good to know. You test this on on ppc64le?

> Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>=20
> base:
> ./perf bench futex hash
> Averaged 1556023 operations/sec (+- 0.08%), total secs =3D 10  <<-- 1.5M
>=20
> with series:
> ./perf bench futex hash -b32768
> Averaged 126499 operations/sec (+- 0.41%), total secs =3D 10   <<-- .12M
>=20
> ./perf bench futex hash -Ib32768
> Averaged 1549339 operations/sec (+- 0.08%), total secs =3D 10  <<-- 1.5M
Thank you for testing.
=E2=80=A6
> nit: Does it makes sense to split this patch into futex and perf?

First I wanted to figure if we really do this. I have no idea if this
regression would show up in real world use case or just here as part of
the micro benchmark.
And if we do this, it would probably make sense to have one perf patch
which introduces -b & -I.  And then figure out if the additional option
to prctl should be part of the resize patch or not. Probably we should
enforce 0/1 of arg4 from the beginning so maybe folding this in makes
sense.

Sebastian
