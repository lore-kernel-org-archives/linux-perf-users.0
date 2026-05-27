Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32F1A683A;
	Wed, 27 May 2026 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843017; cv=none; b=pQqXGpACpgMY6GKl/IQPvRB/driODfvyo/BCL3iGrtrFHm8kWWvKxn6Bl2heItDGvsky6zblN52cTLYWqnZd6vmsAED/LzGOekVgfeb0sRsGa3GFcpf7X2vBGqs5IxmOnJkUSfnbQeU8+/BoOVA78tj49nvHqzL3w+jNZi74eJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843017; c=relaxed/simple;
	bh=KP4eZR4aMzEyXVRm91xOOTNia3o1zlwLIb8aPYPItyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZGgNZlpUztoeYUTt6ECxLzXIQJQrRKqloRQKAFeDPtgTt/JUmyKczgdVUsvJeZM1nF+KpxW2pq86s7/sknD5J/YYnhc+7P7MBC/eSQcKe9FjP7Mlw/mueu0hzicpilX7chusF/Px4rSavlbUqTe5fgEor2eni94jxdXwTYU/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksJzaw23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksJzaw23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706F81F000E9;
	Wed, 27 May 2026 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843016;
	bh=KPrWi2VMdrVIKBDKSVmaf8ckz+OwWS2ppmMbkUG1Z4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ksJzaw23fAGyTM18l15nUfq6RW6kXrCZy3+ZzXjCCFYo/YL4Lccx6a9HmzubhwZ29
	 Rkq5oXNYAXKyrJ+Mj8oVaWrDehv3jyXC/Og28k4zQ7NQKodN4FxQ0zLv3jzhetAEku
	 mZknKEIg78ALv3eMM3gDURQLJxv6hMKQD+4+DymlZGIGJi4SEBh80basPXtuCRyohw
	 OSSDJIC+4Ajz8BBnXshANYuTFw9mccRkQcE5MKrEm7RfYKNWt8etQG88/V3NXWJQEj
	 FkJiXOOFTQAnxdB8PdvTaurpnv0FGaYEc4zuZpp71tiwSsbHeTKfbvwjwYyv7jPLyZ
	 XgUvPnHr2PDVQ==
Date: Tue, 26 May 2026 21:50:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 29/29] perf test: Add truncated perf.data robustness test
Message-ID: <ahY_xHU9rLRP6M6X@x1>
References: <20260526211806.1193848-30-acme@kernel.org>
 <20260526221941.5806C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526221941.5806C1F000E9@smtp.kernel.org>

On Tue, May 26, 2026 at 10:19:40PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The cleanup routine may delete a file named '.old' in the current working directory if temporary file creation fails.
> --
> 
> commit 6d5a7740cf583f089ba666236f38032085207496
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf test: Add truncated perf.data robustness test
> 
> This commit adds a shell test to verify that perf report gracefully handles
> truncated perf.data files. It records a simple workload, truncates the file
> at various offsets, and checks that perf report exits cleanly with an error
> rather than crashing.
> 
> > diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests/shell/data_validation.sh
> > new file mode 100755
> > index 0000000000000..5c3e6fced6fce
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/data_validation.sh
> > @@ -0,0 +1,85 @@
> [ ... ]
> > +err=0
> > +
> > +cleanup() {
> > +	rm -f "${perfdata}" "${perfdata}.old" "${truncated}" "${stderrfile}"
> > +	trap - EXIT TERM INT
> > +}
> > +trap 'cleanup; exit 1' TERM INT
> > +trap cleanup EXIT
> > +
> > +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
> 
> [Severity: Medium]
> If mktemp fails (for example, if /tmp is out of space), the perfdata
> variable will be empty and the script will exit, triggering the EXIT trap.
> 
> Will the cleanup function then expand the command to rm -f "" ".old" and
> silently delete a file named .old in the current working directory?

Good catch, added the following patch to it:

   err=0
 
   cleanup() {
  -  rm -f "${perfdata}" "${perfdata}.old" "${truncated}" "${stderrfile}"
  +  [ -n "${perfdata}" ] && rm -f "${perfdata}" "${perfdata}.old"
  +  rm -f "${truncated}" "${stderrfile}"
     trap - EXIT TERM INT
   }
   trap 'cleanup; exit 1' TERM INT

