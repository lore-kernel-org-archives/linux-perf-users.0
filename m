Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4ED3D3327;
	Fri,  7 Aug 2026 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103933; cv=none; b=RsoLYEAQtJc7d5sW8ECgg5//FPqyD3FdgPydrDJaSxsLtx3OC9j8jUrlhJnWtUtXNI+k/hSHx6Ucae/Pfdzhv8ndYLnuM88ouwr9mDRNhXvt8Hu5SLnLMdJfd6WfHzTUDZxsErW7rkPOpS9mT++TMac9+h4dOOHkP0dLFApiv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103933; c=relaxed/simple;
	bh=XwUlyzdF3FYLG97a+5J0u8R48D9t7mNHwVm4pxyrUBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXx8/n9Cltr04w3LxCI39W67e5H6lv9aoJQ4eGmU/5nKiRFNhZP6JtEq6tAjozDXZlmd1EiMZ1OpUw1lpJj5N6qixc8EGZSGOQ9nPRmLJwyiuiPcIE8VsdGD0gZ37oN1iB7jRymxIznBiZHO+PWo2CpFJjH06PPxzE9mXMDCV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejIIyOX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejIIyOX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2561F000E9;
	Fri,  7 Aug 2026 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103913;
	bh=wUexWbTZ+ugzISzTf9op0rCdl2R17B4GplS0CkxUTSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejIIyOX9DFtFG9XwPXQgjRcctznjDtKjkLer37jYpGxs269PmcRBMtoOL3AEWrIWO
	 hjaTeBQvJsdfOc8/I+zN2rc6Ic7Y2eo5Jff1tzEdKb4SuU5dRvCUlv2jAoF4e+fRr7
	 hheeEXD+QTNlH9juJKBP4vmb0k/c+H4OVeuatQ0DWtq6rx4VZ1xWgGzFOckIcckE9W
	 uHp2FoZv+Uj1rPHZYPwopdWLpP+ACwug4ylHv8fKZzm936I40OblDcSgyjSFMlPtxN
	 d2hhATN6PYazJ7rnDD+ZcfMcvIwXBs8+WtvOU2lcxkaaVDvVGK/ROs4lTU4tdqHdtY
	 n/VEglrYt1+uw==
Date: Fri, 7 Aug 2026 08:58:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v8 0/2] perf c2c hardening
Message-ID: <anXIZPk2CKikT30v@x1>
References: <20260805151043.237233-1-acme@kernel.org>
 <anNl0O0EEwLP2baH@x1>
 <CAP-5=fXj1xp+7vwnhGzPnLwxm8jT3WSkJe972fF2Rq9CM5ioxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXj1xp+7vwnhGzPnLwxm8jT3WSkJe972fF2Rq9CM5ioxQ@mail.gmail.com>

On Wed, Aug 05, 2026 at 04:58:37PM -0700, Ian Rogers wrote:
> On Wed, Aug 5, 2026 at 9:33 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Aug 05, 2026 at 12:10:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > >       Please consider merging,

> > > Two hardening fixes for perf c2c found by the sashiko-bot AI reviewer.

> > This short series is finally completely Sashiko clean:

> > https://sashiko.dev/#/patchset/20260805151043.237233-1-acme%40kernel.org

> With:
> https://github.com/sashiko-dev/sashiko/pull/363
> I thought we'd start getting positive emails. Perhaps we're waiting
> for the server to rebuild or reboot.

Roman is on PTO, there is a pile of requests that is getting mountain
sized 8-)

- Arnaldo
