Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587164;
	b=NHH0yVDmWYFp/F1odCyO6zk8GMdoF+2TETtTUtfy35hglSOKXySDdMFxAhWGR9Wk0fCD
	 liQbB+U81YEfjY1S9D5zfCs3F9n2siHhFasbCbz6aijBj0HMyx/VaAASdSIWFv31SKoXK
	 WVdWvBbdnuw5S90WuNasiviL035S4ouUWA1XR+eS0/Q+QTe2xPt8UKp1A9oScwCH+5Eji
	 PQPM3Vs9bhXfSK8QwjLjuWh0sSnLoW+r78JMNBzglRoKx8EXunmCc1jLNblan75WPBBED
	 u/KDMzO8YDZIxBW6qV/0fRoYo8Pv9p+J3beQW85yO+0V99Y66c+XmevCJ2LPuCE0O2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587164;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=czD34IcQnX0HZo1oS1rYEWd9VLGVe57BvEK5TimFPmU=;
	b=ClcHXY6fXPeADa/Q6TQUbAUQviUJme9bFkXAfMmvdL3WoV/auFtaj/bMwgUfIVnBCqVQ
	 xCiF3PJ35IqvX4jbQ9RufeaJrQgmK6nG+R5LSmkoBXMWbVVV5kbnE/KEuHy+LYJfKOsJx
	 Fd3A+z6Ni1COW/D2xkYD4SCNanpl+Md9Goq3DThGkDSmWAcewHeExY4ib1QL1zBwCtwzq
	 ATewSM/Nl8Sr8ioUUFpBvxx26kvQ7vI0o0BJY3Sl/T5M27hOJN1lhix8JvSuuiopfQRig
	 GkysewUxuFa3XVocQdNKIain+O1nbQbSQ+uuboNQRMdfxOTtJkELyHsObd4WOM5x6+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lVFz/Duj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E721606A328;
	Wed, 21 Oct 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVFz/Duj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422B01F000C6;
	Wed, 21 Oct 2026 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792587163;
	bh=czD34IcQnX0HZo1oS1rYEWd9VLGVe57BvEK5TimFPmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lVFz/DujYWShVqY18EKGrLr0T1dTGKsQJ7nRxH9KnjScvJj+FNnLirRix0/kDNTLE
	 36yTa6rS5z1lUx8S7s2/9q7SYVXxsi0MMFlMt3CrSKIi6QaVRJ965klnP9jIIAjz8/
	 Gch8FaPyGU34ije3QIucGYHNcTaKAaVI0HGd413cI1YTV1LHP2NO+qxaONtiwQOgyr
	 WjVLy5+v3J7L/hCLc6Bl2PGLuNznlNVF4o+3fmrtY1ChKXF0+rE0PKs4R4ZIl+Z3Gk
	 5lvDtWUr22/EW73a3bbD3d43eVSltmn4Hh8z+AZazjbjgM1IbVle4OvKGOacZ2VAv9
	 kiNGsR5Y70Pqg==
Date: Wed, 21 Oct 2026 09:52:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf c2c: Fix memory leaks on output fields
Message-ID: <ati1mDMu5SETwZi1@x2>
References: <20261015233237.542258-1-namhyung@kernel.org>
 <atIImjxxXKUO2os8@shell.ilvokhin.com>
 <CAP-5=fWCwLuFah70DQCbmmDvjQYJ5DiozBj=YawZK6eVFGNnDw@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWCwLuFah70DQCbmmDvjQYJ5DiozBj=YawZK6eVFGNnDw@mail.gmail.com>

On Fri, Oct 16, 2026 at 09:01:12AM -0700, Ian Rogers wrote:
> On Fri, Oct 16, 2026 at 4:21 AM Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> >
> > On Thu, Oct 15, 2026 at 04:32:37PM -0700, Namhyung Kim wrote:
> > > The perf_hpp_list was not freed after use.  Let's add it for the main
> > > c2c hists list in perf c2c report and a local list in print_pareto().
> > >
> > > Previously it was detected by ASAN like below.
> > >
> > >   =================================================================
> > >   ==42183==ERROR: LeakSanitizer: detected memory leaks
> > >
> > >   Indirect leak of 1064 byte(s) in 7 object(s) allocated from:
> > >       #0 0x7f17334ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 61e8165ca90f7a4f06b73f064a938c76deaae079)
> > >       #1 0x0000005fa099 in zalloc  ../../lib/zalloc.c:8
> > >       #2 0x0000004faf6d in get_format  tools/perf/builtin-c2c.c:1978
> > >       #3 0x0000004fb45e in c2c_hists__init_output  tools/perf/builtin-c2c.c:2004
> > >       #4 0x0000004fb7de in __hpp_list__parse  tools/perf/builtin-c2c.c:2047
> > >       #5 0x0000004fbae9 in hpp_list__parse  tools/perf/builtin-c2c.c:2085
> > >       #6 0x0000004fee13 in print_pareto  tools/perf/builtin-c2c.c:2563
> > >       #7 0x0000004ffcd7 in perf_c2c__hists_fprintf  tools/perf/builtin-c2c.c:2708
> > >       #8 0x000000500ab5 in perf_c2c_display  tools/perf/builtin-c2c.c:2949
> > >       #9 0x0000005045c3 in perf_c2c__report  tools/perf/builtin-c2c.c:3522
> > >       #10 0x000000505caa in cmd_c2c  tools/perf/builtin-c2c.c:3676
> > >       #11 0x0000005df50e in run_builtin  tools/perf/perf.c:383
> > >       #12 0x0000005df9b1 in handle_internal_command  tools/perf/perf.c:436
> > >       #13 0x0000005dfd7f in run_argv  tools/perf/perf.c:480
> > >       #14 0x0000005e02d6 in main  tools/perf/perf.c:581
> > >       #15 0x7f1729450680 in __libc_start_call_main (/lib64/libc.so.6+0x3680) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
> > >       #16 0x7f1729450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
> > >       #17 0x000000409c34 in _start (tools/perf/perf+0x409c34) (BuildId: 36a64600776d92e4ab7dfd5ca20c92280d72a645)
> > >
> > >   SUMMARY: AddressSanitizer: 1064 byte(s) leaked in 7 allocation(s).
> > >
> > > Fixes: c75540e3160f ("perf c2c report: Add dimension support")
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
