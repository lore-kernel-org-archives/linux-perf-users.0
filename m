Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA6301017;
	Fri, 12 Sep 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677776; cv=none; b=f1rpg3L1YeJ6PzEqBc1f02sq3ib4WcQFpPEauJHH3W5+Qcwiwluc/WCRLYF+Fm57K1UMrnKXR53xYR4dC+1gvbYnvdtFMTFYDxhwUQmFMj4fyBvN2I4GFxt8mE7lniM1uZfEv93tY7rvbmK04ZKa/CcZH4V6vy3GIg7pudPNNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677776; c=relaxed/simple;
	bh=dgdcxtuGDgjv2LMECKB+QSRF/xELI57ELOO6Cb7PK2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF7cn5NPN+PsXn09vhhHuvId03alOPxp9ZhHCCeSf3cwtovUYDo2FzJuW87LhpHu5RJgXTmBazDoE9aU7ptevwrBm72GUImm9C0Id77V/xKGfarBftRJwQSA+aR3yJfS3AG9rf4nxnSkTo3DJHj0nYmHcIECwtPfZMKpzwBtaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A73AA340FE4;
	Fri, 12 Sep 2025 11:49:33 +0000 (UTC)
Date: Fri, 12 Sep 2025 13:49:29 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: Problem with perf report --gtk
Message-ID: <aMQIydhceXVRORNp@gentoo.org>
References: <aMACaOmneDrG8_pQ@gentoo.org>
 <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
 <aMAtqNq55TZEuaKn@gentoo.org>
 <CAP-5=fX-GG_pUH+1Eak8dsoTdNh=vRU+00scBxbRt7EhXZosiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX-GG_pUH+1Eak8dsoTdNh=vRU+00scBxbRt7EhXZosiw@mail.gmail.com>

On Wed, Sep 10, 2025 at 09:45:35AM -0700, Ian Rogers wrote:
> On Tue, Sep 9, 2025 at 6:37 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> >
> > On Tue, Sep 09, 2025 at 06:04:42AM -0700, Ian Rogers wrote:
> > > On Tue, Sep 9, 2025 at 3:33 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> > > >
> > > > Hi Arnaldo, Namhyung,
> > > >
> > > > Since sometime we have a bug in Gentoo's bugzilla about perf report --gtk not
> > > > working¹: https://bugs.gentoo.org/937869
> > > >
> > > > I know this feature is not used very much, but I thought I'd report in
> > > > any case. The problem is easily reproducible as shown below:
> > > >
> > > >
> > > > $ perf record -a -g -- sleep 1
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
> > > > $ LD_DEBUG=symbols perf report --gtk 2>&1 | grep '(fatal)'
> > > >     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: symbol lookup error: undefined symbol: hashmap_find (fatal)
> > > > $ perf report --gtk
> > > > GTK browser requested but could not find libperf-gtk.so
> > > >
> > > > I tried this with perf 6.16, but this bug seems to have been there since
> > > > at least 6.12.
> > > >
> > > > Please let me know if it's better to file problems at https://bugzilla.kernel.org/.
> > >
> > > Thanks for letting us know Guilherme! I suspect I broke things when
> > > trying to fix python things. The code linking libperf-gtk.so is:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n809
> > > The hashmap symbols are part of the perf-util library:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/Build?h=perf-tools-next#n197
> > > So maybe there needs to be a libbpf -lbpf for your case? Alternatively
> > > we may need to reorder the libraries here:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n464
> > > like:
> > > PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_UTIL)
> > > becomes:
> > > PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LIBPERF_UI)
> >
> > Thank you for the suggestion, but just changing the order of linking or
> > linking libbpf doesn't seem to fix the issue. I still see:
> >
> > $ nm -D libperf-gtk.so | grep hashmap
> >                  U hashmap_find
> >
> > at the end of the build. The function is in util/hashmap.c, so the
> > problem might be more involved than just the linking order.
> 
> Thanks Guilherme! I was able to reproduce the "nm -D" output. Adding
> "-z defs" to the "$(OUTPUT)libperf-gtk.so" also fails for that symbol,
> it fails for many more. Even though the symbol is undefined "perf
> reprt --gtk" works for me. Attaching gdb I see that the symbol is in
> the perf executable itself. I tried the following change:
> ```
>  $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
> -       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
> +       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^)
> $(filter %libperf-util.a,$^) $(GTK_LIBS)
> ```
> or
> ```
>  $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
> -       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
> +       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter
> %libperf-util.a,$^) $(filter %.o,$^) $(GTK_LIBS)
> ```
> but the nm output shows either the same or more undefined symbols, not less.
> 
> I'm wondering if perhaps the hashmap_find symbol is being stripped
> from the perf executable. Maybe it is an LTO or stripping related
> thing?

Dear Ian,

I don't see any hashmap symbol as part of my own perf executable:

perf $ pwd && ./perf version
/home/amadio/src/linux/tools/perf
perf version 6.16.6.g1037d3a33ba6
perf $ nm -D ./perf | grep hashmap
perf $ 
I compiled perf with:

$ make -B -j16 V=1 WERROR=0 NO_SHELLCHECK=1 GTK2=1

Cheers,
-Guilherme
