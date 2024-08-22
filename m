Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35361CDFBA;
	Thu, 22 Aug 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350827; cv=none; b=Ops8e+eYCnbZoofHIdUicfl4bFWCx9r9F9DrWWun4wzW83syMBdCjZ5lkmpCDEozJwzXqCUBpHUlcKBfAa1YGaXF4CmrsXFEgiGZ53irxRsZyBidGMpcTTLjDDT1u513NFMPXib1D7SvIwlYjskQAzQsctFbUP4mwQ+66+oLHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350827; c=relaxed/simple;
	bh=tCfCh7YxdUdYoBP2Tmi0wAnXZGOg3kgKmGEv4IokuO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp0MXrhh1GLzJawuRfSLExJOd1BtPkJ0PBx1v1k+PnEypYr8Xa6bSP6Jk5yBMwxEGE+qz0/BHQJXcpeeT1PuzOa3NYNbnNa3tKiRUWooTqOKAT01A17KkDjKYw07eSkfVyb/0MV0kwEfAT7BtR5nctewiWiaNJs+TV0dFDM2YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNWmwf+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNWmwf+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6A5C4AF0C;
	Thu, 22 Aug 2024 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724350826;
	bh=tCfCh7YxdUdYoBP2Tmi0wAnXZGOg3kgKmGEv4IokuO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNWmwf+EMs/f2S5OaHflosIymaDX5ECvHIlcwX0TAd4XmgreTAA5F7dtGQ5RBFUpX
	 HqnXt2WJP8xMcO/6hhzNhx1fdfIfBzYJ2wcXpbLfWfBf87WI030rCaeBtRk8N0RXov
	 6a9wwe88gBzuIzXg9gctnnDgELRHBqROu+qziEY/ZpbPLKQvpFCLfgY3aCC8p7Xth4
	 WDGxWsC1N5kuTLZDVoKwIVJqDzzH02hfULOILEgobFv3UAlRSR2TrGVfywDysbIbFJ
	 ymSmGLo8e3ZAqgSloyeRyAkhYgKAlU2lzr/CJeLEX0cs/S/ZP28ibZKMcQDG6+WeX9
	 Ba6HTukDd74pw==
Date: Thu, 22 Aug 2024 15:20:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sedat.dilek@gmail.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZseBZ1DIi4Y5zC2W@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <ZsdKhLaPy-uzKsuH@x1>
 <ZsdUxxBrpbuYxtXN@x1>
 <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1>
 <ZsdzLmIFWRqsXeXD@x1>
 <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1>
 <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
 <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com>

On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > On Thu, Aug 22, 2024 at 7:40 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mismatch if
> > >  present on clang
> > >
> > > The -Wcast-function-type-mismatch option was introduced in clang 19 and
> > > its enabled by default, since we use -Werror, and python bindings do
> > > casts that are valid but trips this warning, disable it if present.
> > >
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Can we also add 'Fixes' tag to make this picked by stable kernels?

Fixes what? This isn't a regression, clang 19 isn't available for Fedora
40, the most recent.

- Arnaldo
