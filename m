Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54811D63E8
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226231; cv=none; b=CEwVUW9Zwh/tzTWcH2xMondFoDyZQIaJOdwF5yIc/sqUN3acze3zQMJ+meBdV+2+fFgKFDp10qVqhD/KDK0VjW0Q9k6aIawcMgEG3V0NkSYblYd5EWorrNIxUBIdU5uYiwSb1cDPWPVwqROLGZVR5owdmG9rvp8o3dQ6KJkSUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226231; c=relaxed/simple;
	bh=/4ycpnKPXXjbfmeBMFynw2Wp93GvQrVEZ3Bit0VmFlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IztFlP/BxlO3UJtCGOeFz300gf+6+XU4p7TNAHWPeGHm5oxpUql7P3I/N2sFtbo2mzvsDvSz3y844kljOPKB/tAMip9roRiFyD527hstxeP1SLbG54MNBTpZT2G/RiO0yvkYAp/+b98CPtTPghjGdPFDTN0by3gfsYIB9eDhjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mesfYyrp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mesfYyrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EFCC4CEE8;
	Wed,  9 Apr 2025 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744226231;
	bh=/4ycpnKPXXjbfmeBMFynw2Wp93GvQrVEZ3Bit0VmFlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mesfYyrpwjt9rzSTpedoMIvhblC90snZgUqrofCmyzitnDbJgpU424tOanm7fROrF
	 tWWZqxK7ZVKdaO2YQhy1ve7EA0w+uCFCBUEqOKZ1ze7NY+uUCowXGXdqqfbZP/YIRk
	 xh6O7dp8gdKRqWZS1DCM1OnMjzSfkJMdmYiGfSpNNAbkxAS0VuaLADUCRbZW4VXjJD
	 K9d/fvcwtymuc3UgdOyYlasDiXFShw4lX9vXKxjDvbsBK5uh8bAj+Rdd7A2nZw8QBp
	 BzmbcISyFbXsl3sr+3meqBz1AlMTS7Gh7hWTulAlH0MFT7bwFIKGJXYMJUuX8yhfdN
	 76dBBDqSCPkwA==
Date: Wed, 9 Apr 2025 16:17:08 -0300
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
Message-ID: <Z_bHtD7umCsKeWJ6@x1>
References: <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
 <Z_aY0fTs53id77CS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aY0fTs53id77CS@x1>

On Wed, Apr 09, 2025 at 12:57:05PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 09, 2025 at 09:19:01AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 08, 2025 at 11:23:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Apr 08, 2025 at 10:05:15AM +0200, Ingo Molnar wrote:
> > > >      - Yay! But very unintuitive. The intuitive step would have been 
> > > >        the left arrow key BTW. (with restoring the cursor position to 
> > > >        the cc1 entry I pressed 'Enter' on originally), but that doesn't 
> >  
> > > That is how I implemented it initially, yes, over 10 years ago.
> > 
> > I'll experiment with making the Left arrow key, if already on the first
> > column, to work as zoom out.
> 
> Can you try this, on top of the series or even just this, pressing left
> should do what we want.


This is working for zooming into/out of a DSO, but for threads, which is
what you described, it is not working, checking that...

- Arnaldo
 
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index 115aa1af5a0218cd..dc88427b4ae5af4c 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -459,6 +459,8 @@ int ui_browser__run(struct ui_browser *browser, int delay_secs)
>  				goto out;
>  			if (browser->horiz_scroll != 0)
>  				--browser->horiz_scroll;
> +			else
> +				goto out;
>  			break;
>  		case K_PGDN:
>  		case ' ':
