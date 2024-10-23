Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531914EC55;
	Wed, 23 Oct 2024 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722587; cv=none; b=JtdXJ/wFJkstmxi6Xl5cUfM+b1IEcVASYU1dmNfCyu5jqAGApCbiYSCazTjrZ6snC7urdFLg4RTKPHnxOeQMePEHA+9fYNUjMeJaquZk+E54xb94Wt60/ZQr7wHrXq451B6a2DHcOM5MLDd8Iq5/5SSEB4Ba+jNNrXi9tdGgmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722587; c=relaxed/simple;
	bh=pEgmy51T1zra7F98d2fnat675DwGcf+TUWjeAVRKf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtbkiLbBkz5vWXKtFhoAhzQ0NKgYg+em8/LveGAb7L5hj4/f5cq+M4wD3aBrt/uyH5M3dGeGCfFINlvnZAohjzRMzuepZ2Yq2Orqkedx1jXA4+Kw5qvDZBOV2iVDO1hsuvto6WJevMlKxR9/N4yZ/P5KWef9Ql86mDGystjLrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faOPjrA+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faOPjrA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B625FC4CECD;
	Wed, 23 Oct 2024 22:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729722587;
	bh=pEgmy51T1zra7F98d2fnat675DwGcf+TUWjeAVRKf3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faOPjrA+uZ/bKz8Vq7YdjddG+baOPmxeG7wohD9pDpyFi2HoLQmS85nw9ods7tPq4
	 O3mjOMa1O+82b/ICdBv4TPxfRAKRibCZCpJ8gOg1gBkrkji5q3PIEUt+tPOv1crq2r
	 R3qffVDUxZ+eJm5pdJjgk6xdlEo7OaDVGowWFavJW2g0+wtEkLDczwbGzo8N8OWVbw
	 ZMaF2trhvo16SxR/JbEw7Dskx3b5o3Ywb1+FFn2O34tflL/C83MioQJKQXqYSINdoe
	 w+5gjgG2/5RFX7NBak7qquJvLyX45p/ZddXu4UpAC6xkYB1t7YdOV6nO2TlWHCi8Jo
	 xEbg3XRovQrUg==
Date: Wed, 23 Oct 2024 19:29:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1 perf-tools] perf python: Fix up the build on
 architectures without HAVE_KVM_STAT_SUPPORT
Message-ID: <Zxl41sigv9Fw7Vqv@x1>
References: <ZxllAtpmEw5fg9oy@x1>
 <CAP-5=fUF1kfioGSgnXzPmadwKrd65mUpHPamPNt29ra9qZAzJw@mail.gmail.com>
 <ZxluzQ3wN1aTcEXt@x1>
 <CAP-5=fVMwVigWsi7-QgBGZ1QbUuPjAxnr5gaLybHtynG7rHU6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVMwVigWsi7-QgBGZ1QbUuPjAxnr5gaLybHtynG7rHU6w@mail.gmail.com>

On Wed, Oct 23, 2024 at 02:48:04PM -0700, Ian Rogers wrote:
> On Wed, Oct 23, 2024 at 2:46 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Oct 23, 2024 at 02:40:45PM -0700, Ian Rogers wrote:
> > > On Wed, Oct 23, 2024 at 2:05 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Noticed while building on a raspbian arm 32-bit system.
<SNIP>
> > > > Fixes: 9dabf4003423c8d3 ("perf python: Switch module to linking libraries from building source")
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > Cc: Ian Rogers <irogers@google.com>
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> > > So this will at least conflict with:
> > > https://lore.kernel.org/lkml/20241022173015.437550-6-irogers@google.com/
> > > where the #ifdef-ed out functions are removed. Does that series fix
> > > the ARM32 issue? Could we land that?

> > I'd prefer to have what I posted for perf-tools, as it is smaller, and
> > to land the patch removing those functions on perf-tools-next.
 
> Makes sense to me. Have a
> Reviewed-by: Ian Rogers <irogers@google.com>
> should you need it.

Always appreciated, thanks, applying it to the patch,

- Arnaldo
 
> > I'll try to switch testing to a librecomputer board, the rpi3 is super
> > slow :-)
