Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F733EB12;
	Tue,  9 Sep 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425071; cv=none; b=MOWx7a9F2h7xzl4tqrqaZ7Nxb0ES0cJHzblVqb91y/POqmCcSSAX3BSdzGe30Epoa9Tw/SJr8E+6ANx8sS7JhEfcq04S1nHZn1c3Qj4RRo3scDVWIJfZLH0cM/Bng2DTsTO0y9LajPs1AMqQuv9TBn/oCNW1b8nr2pxy72x3TmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425071; c=relaxed/simple;
	bh=W8CrvuxacbP1I8gYlmWv/RUJjIlSXHD10AO8XMDXJQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbcnNhS+5U2ZXZVm1KwmrziL9R2/N4U1m6ZSTlNOTrY/bxCDaTKMrxIpBArQ87Fp2RvhkUAtrlPYNMQ/+YwcOdgU+ZW0K+QkJ1XL7JLBVXOapgQW35qjTTpAJop1P13fLSTO5aE6sMDCVKT0KGW6ggrCRhmYGiQngMxX8+eRTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6AD8A340EFF;
	Tue, 09 Sep 2025 13:37:48 +0000 (UTC)
Date: Tue, 9 Sep 2025 15:37:44 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: Problem with perf report --gtk
Message-ID: <aMAtqNq55TZEuaKn@gentoo.org>
References: <aMACaOmneDrG8_pQ@gentoo.org>
 <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>

On Tue, Sep 09, 2025 at 06:04:42AM -0700, Ian Rogers wrote:
> On Tue, Sep 9, 2025 at 3:33 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> >
> > Hi Arnaldo, Namhyung,
> >
> > Since sometime we have a bug in Gentoo's bugzilla about perf report --gtk not
> > working¹: https://bugs.gentoo.org/937869
> >
> > I know this feature is not used very much, but I thought I'd report in
> > any case. The problem is easily reproducible as shown below:
> >
> >
> > $ perf record -a -g -- sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
> > $ LD_DEBUG=symbols perf report --gtk 2>&1 | grep '(fatal)'
> >     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: symbol lookup error: undefined symbol: hashmap_find (fatal)
> > $ perf report --gtk
> > GTK browser requested but could not find libperf-gtk.so
> >
> > I tried this with perf 6.16, but this bug seems to have been there since
> > at least 6.12.
> >
> > Please let me know if it's better to file problems at https://bugzilla.kernel.org/.
> 
> Thanks for letting us know Guilherme! I suspect I broke things when
> trying to fix python things. The code linking libperf-gtk.so is:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n809
> The hashmap symbols are part of the perf-util library:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/Build?h=perf-tools-next#n197
> So maybe there needs to be a libbpf -lbpf for your case? Alternatively
> we may need to reorder the libraries here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n464
> like:
> PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_UTIL)
> becomes:
> PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LIBPERF_UI)

Thank you for the suggestion, but just changing the order of linking or
linking libbpf doesn't seem to fix the issue. I still see:

$ nm -D libperf-gtk.so | grep hashmap
                 U hashmap_find

at the end of the build. The function is in util/hashmap.c, so the
problem might be more involved than just the linking order.

Best regards,
-Guilherme
