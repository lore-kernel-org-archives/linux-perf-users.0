Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED25227;
	Sat, 16 Nov 2024 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731786715; cv=none; b=i6OKw5B/kCFip3T1nqMCstY5AfPPBWEF/pyQdzN2pb7nZAquzDmBE+x8RhfBZb2fPRJx34s07eiUyGwyCje9BrCbL4+/hMbxaNUoQiUS4pLIsGVDx85C44GgOusgzcjupuqliNgx3z7uHH3PoeH+dp54iCGBcO8alpuNgsSTvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731786715; c=relaxed/simple;
	bh=my5CuNobNcTNpr8GHBmkucQv/kyNglVme81qvdrbu54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD+oNjIxHdQAxTrkmB2QTxJX/sjqL3nS9p9JIWseOysqz1APXSZXQ1zcYg9dZtPTux0G/P69YoGXW/WTLcV9LDihyJWW2HgFucvA5RYUshEalLC4ovj5Wb/Ht536s/0gOhLghq/JFZhMzktNwp152BtT14yKnZa6c7wDoLrQ5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YRtMi/Kt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YRtMi/Kt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=sbOH2HAxGfLHZltNxpyMjaqgY8fDhZl5Wre51PQB8dg=; b=YRtMi/Kt5PjITGY0
	o/Vu+q7DsNBSpji2nnqHcT52I8ozTpxwG625pc2yQrRX94wgkJC1GRzMVyeKFuqBuUbosg89U+A0W
	MZoYjezUDNQqhOpOQbywP20V+CcSxEZqHaTmtgRe3DCxrm8AN/GJpGOcs1ZLRqILcO0JEcRhrRMjc
	CcpMPR4ulCUTs5dtTf06wDqzkz757aSe+gkLqNbMA3MTAgoA/ImsvqTiNw2x/7YFy+78PWZk1U6UN
	QbzlP3nUTsqGInUvDYUvyh20jlsTK0MVXWnANPQ3jJOPSCAlDw99jKp8NSjIc2MTYAFXdVv9me41g
	2V0HdiIwehLX6/HweA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tCOpX-000Jh7-0P;
	Sat, 16 Nov 2024 19:51:39 +0000
Date: Sat, 16 Nov 2024 19:51:39 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Remove kernel version deadcode
Message-ID: <Zzj3y2BN_GcnRKbK@gallifrey>
References: <20241116155850.113129-1-linux@treblig.org>
 <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>
 <ZzjxxCnicVIwAF5N@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZzjxxCnicVIwAF5N@x1>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 19:50:22 up 192 days,  7:04,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Arnaldo Carvalho de Melo (acme@kernel.org) wrote:
> On Sat, Nov 16, 2024 at 10:37:32AM -0800, Ian Rogers wrote:
> > On Sat, Nov 16, 2024 at 7:58=E2=80=AFAM <linux@treblig.org> wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > fetch_kernel_version() has been unused since Ian's 2013
>=20
>                                                        2023
>=20
> > > commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")
> > >
> > > Remove it, and it's helpers.
> > > I noticed there are a bunch of kernel-version macros that are also
> > > unused nearby.
> > > Also remove them.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >=20
> > Reviewed-by: Ian Rogers <irogers@google.com>
>=20
> Thanks, applied to perf-tools-next,

Thanks!
Have you got:
  [PATCH] perf: Remove unused del_perf_probe_events
  https://lore.kernel.org/all/20241022002940.302946-1-linux@treblig.org/

=66rom a few weeks back in there?   I don't think I've had an email
response to that one.

Dave

> - Arnaldo
>=20
--=20
 -----Open up your eyes, open up your mind, open up your code -------  =20
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
