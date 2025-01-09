Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713D4A1A;
	Thu,  9 Jan 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457587; cv=none; b=PvJ4rr5Ka+1JlHVk0wGm2bu11Z+7dkVgoIn0h2qSPN2oAzpn1NeMr2vHIEXPL+emByFoFIwxpngRo2wHV6rYb1eKVJNev6J/2UYGbKMO0KlNjt+g7Aj5Y1dJ/lkF9wAqrWmrb7a0X1HlaJLZIV0VJQ0oU1O7nUWXcPwjH+cwD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457587; c=relaxed/simple;
	bh=/+CuzyI4ogI8kX2Wrufcv5bIb8TPa6p0upBceJiHjRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXaAKp7E3kYvy3Y+PrW08B287zNCV3Mh6bmlra5cGQvSmVLDQm4A5TSZ0tiogp75tT1Pga6oKv1TZrRcwsQ296zo+uQY3zeCWVIpTiNwCdnG4sDjI7bFIKO3kikSL0ww2MQQ1wXd+5LVJeuF8Vdvf1zd78MQ1mQgYRdM2hBuopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfp2+Cz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfp2+Cz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78328C4CEDF;
	Thu,  9 Jan 2025 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736457587;
	bh=/+CuzyI4ogI8kX2Wrufcv5bIb8TPa6p0upBceJiHjRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hfp2+Cz1/nFOq/61ISUnLBxHcbViRy6F2dhWFJohXd/HehbVc453ks3QIqtaLKCep
	 6Au1kNVgAZBUzxq7pZAjF5eRPyAwsn3JK5EtupqoRchQMb973DnV1zFdHLwtMSXieS
	 JfAUi6D7qS28tYpQT6m2/xiZ2oJeASLp+Y4gHSIZ7Z3qxvjdiZO3xj6MJ/n7SsRcK8
	 d+GhumOLvYskC23n0hlQtGQwYMG4JvDa5ByZLjQkWLVLQ8rtaaDMpk29kR6HNPgBWX
	 ejExiOfXTUY1EGNMjVLPWng8tXnwJRtqNRmCBbdqM3ogTzhxAd+9OAJX5SpQc7c/BU
	 3ILwr/Tge2Edw==
Date: Thu, 9 Jan 2025 18:19:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Blake Jones <blakejones@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fixup end address of modules
Message-ID: <Z4A9cMoSHVpAxF3-@x1>
References: <20241218220453.203069-1-namhyung@kernel.org>
 <CAP-5=fX2Pj+Gv89LoO8SakqwVoaiT2A9BZEKmLjnbYmc4ZRo4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX2Pj+Gv89LoO8SakqwVoaiT2A9BZEKmLjnbYmc4ZRo4w@mail.gmail.com>

On Wed, Dec 18, 2024 at 02:15:35PM -0800, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > In machine__create_module(), it reads /proc/modules to get a list of
> > modules in the system.  The file shows the start address (of text) and
> > the size of the module so it uses the info to reconstruct system memory
> > maps for symbol resolution.
> >
> > But module memory consists of multiple segments and they can be
> > scaterred.  Currently perf tools assume they are contiguous and see some
> 
> nit: s/scaterred/scattered/
> 
> > overlaps.  This can confuse the tool when it finds a map containing a
> > given address.
> >
> > As we mostly care about the function symbols in the text segment, it can
> > fixup the size or end address of modules when there's an overlap.  We
> > can use maps__fixup_end() which updates the end address using the start
> > address of the next map.
> >
> > Ideally it should be able to track other segments (like data/rodata),
> > but that would require some changes in /proc/modules IMHO.
> >
> > Reported-by: Blake Jones <blakejones@google.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Daniel Gomez <da.gomez@samsung.com>
> > Cc: linux-modules@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
