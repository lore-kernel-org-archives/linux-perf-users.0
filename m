Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C18267391
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214228; cv=none; b=Azy68vMz3IOEu+u46xYjhvbUuT1Uh62P2TpvvygRZ5+vS7FYAEv4BSwD6kWZYySb9qLY+1UFnjmQ41uGs7GxboVqtESDemGhp688ed2J0g3saf3o8qG2tNPJcevjBAp+1Txlyn5vms9bE2QHJ20GeLioUsXFYVIvOh7QsRkBNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214228; c=relaxed/simple;
	bh=q5qzw8UpcZquc26QYItmGdz3XV702QjvXrDaRDiSDgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1rz1186LLCeBZCPl3dIL/Awk5vnno3Ljckugjs6ufCHdPbc+YHwlPqY0sg8vi7IwL7ZFaUR0uX9wf3wSJkgwI3/wy+jzSlixB4lyXPWAQRTbcpkLmgNLc6qZ+kiU7EDaDj0HUcvUvbMegF3279m6mxvpYpihHy0dBbDpmzXIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6On7OHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6On7OHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9760CC4CEE2;
	Wed,  9 Apr 2025 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744214228;
	bh=q5qzw8UpcZquc26QYItmGdz3XV702QjvXrDaRDiSDgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6On7OHHPO6mWxxMMNP+lVq/bNUdzdPWnAReH7ThiDVcz6Kn8+89rRJI9aIeIkuVK
	 Tz/o9Tr52j65ZWZqibb6E3ADt9H/lEnwQlVOaaIW5bBakAyH4kaFqxz7txHnVguEu1
	 BMxg+gzWoKIOswa+WIozoKjKJBL2S2sirSOfI0S/MY8Y6/zXmYA9l9JgGWbpKUAXFJ
	 E7dsvNMzY0OG7CLYrttrk+wOkmsgWb3e9mrTd9NkWePLOxdTyJPQgJbtIc3zmkvnr1
	 AgFLUph8g8D8AUSVmgE2mVPqQM4AUHYQpK2lYMWIYKhbNpm3Cljrom5uYpe3UUlx2O
	 FaimAD89CzhgA==
Date: Wed, 9 Apr 2025 12:57:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_aY0fTs53id77CS@x1>
References: <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ZltdaHx9XuKcd9@x1>

On Wed, Apr 09, 2025 at 09:19:01AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 08, 2025 at 11:23:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 08, 2025 at 10:05:15AM +0200, Ingo Molnar wrote:
> > >      - Yay! But very unintuitive. The intuitive step would have been 
> > >        the left arrow key BTW. (with restoring the cursor position to 
> > >        the cc1 entry I pressed 'Enter' on originally), but that doesn't 
>  
> > That is how I implemented it initially, yes, over 10 years ago.
> 
> I'll experiment with making the Left arrow key, if already on the first
> column, to work as zoom out.

Can you try this, on top of the series or even just this, pressing left
should do what we want.

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 115aa1af5a0218cd..dc88427b4ae5af4c 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -459,6 +459,8 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
 				goto out;
 			if (browser->horiz_scroll != 0)
 				--browser->horiz_scroll;
+			else
+				goto out;
 			break;
 		case K_PGDN:
 		case ' ':
