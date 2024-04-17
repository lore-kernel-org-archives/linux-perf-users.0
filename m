Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB722324
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Apr 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386142; cv=none; b=LqAPOjMuW+RNRLvtWV4t47w6Q1IVxRwgEsLx31AF0QOs3ZBOZD0BWI+LfGnxSWcAxfo/iKfS3Od68rDPKQIEbrhygvdHTePqbkQSKRMqpH4noLs5/ptdpuQ+jzgW+Tv3ku75YsdCFkr0R9Un8Bmev4fvwcM332EwUwGMLQjtp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386142; c=relaxed/simple;
	bh=xggnwbewFAQMjiI6PFExyNVWKid/LV5NN1deXaXXwFo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gMFSHFM3LtRV2CKvUjQvfGyb9fXAfkyOJxm+IgpSo0kWwLaKbYI2lH9F2nQ/LjF9EtERFIM8dxzap+5n+ye1Yt0SVeLSiqR6yQpQ1zH9a06V4XUzxfMO8E9W+fzAMDbPLTwKWxuk6Sc77hW9FvibzYXKFMC5htZD+p+VJZbBDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqChVVPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqChVVPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CD9C2BD11;
	Wed, 17 Apr 2024 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386140;
	bh=xggnwbewFAQMjiI6PFExyNVWKid/LV5NN1deXaXXwFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jqChVVPFy8nyA/OWtCEwm87BXQpZfwawFYLAJfoVbrXeDKYD42KB9oCUSjfDXe5Bz
	 2Uok/7WieBAuaOu53QDPvneMsjRLO3ociUIAmEZfonR8aOwt1AJFwq6Jj9vj7gYweY
	 MfuOo/fcWz/+11WJI6jd1E4YuV1X4BCmPCQHnA62IyhcZ/P0yerP19BvPio0XBzkYb
	 Rj1dJrcVS0QPiD/MwfBThU8SZiIy1KQao86wxevJbkwTcBAK9FDMGS0xJUFlpldSro
	 DZrUQnzuX3ouisaBJ57Ip19XPxh1Fl9I5NpGwNMxlgcFUncAiXremE0ehnAzlxlBRE
	 6JmnOsTOU5wag==
Date: Thu, 18 Apr 2024 05:35:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dima Kogan <dima@secretsauce.net>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] Better error messages for 'perf probe --add'
Message-Id: <20240418053537.7ba9c7a8d256987521ea1593@kernel.org>
In-Reply-To: <Zh6dT13FfgdHuMql@x1>
References: <20240416045533.162692-1-dima@secretsauce.net>
	<Zh6dT13FfgdHuMql@x1>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 12:46:23 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 09:55:09PM -0700, Dima Kogan wrote:
> > Hi.
> > 
> > I tried to add some userspace probes to some C++ code, and got this:
> > 
> >   $ sudo perf probe -x tst --add _ZN.....
> >   Error: Failed to add events.
> 
> Both patches look great, Masami, can I have your Acked-by?
> 
> If you find other cases where the error messages can be improved, feel
> free to send us, please CC Masami, as I'm doing now.

Yeah, looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Thanks!
> 
> - Rrnaldo
>  
> > Note the completely non-useful error message. The issue is that the C++ symbol
> > mangling can create very loooong symbol names, causing perf to try to use very
> > long probe names by default, causing this problem. It took a little while to
> > figure this out, and a better error message would have helped, hence these
> > patches.
> > 
> > To reproduce, here's a tst.cc:
> > 
> >   #include <stdio.h>
> > 
> >   namespace n1111111111111111111111111111111111111111111111111111111111111111 {
> >       namespace n2222222222222222222222222222222222222222222222222222222222222222 {
> > 
> >           void f(void)
> >           {
> >               printf("f()\n");
> >           }
> >       }
> >   }
> > 
> >   int main(void)
> >   {
> >       n1111111111111111111111111111111111111111111111111111111111111111::n2222222222222222222222222222222222222222222222222222222222222222::f();
> >       n1111111111111111111111111111111111111111111111111111111111111111::n2222222222222222222222222222222222222222222222222222222222222222::f();
> >       return 0;
> >   }
> > 
> > I then
> > 
> >   g++ -g -o tst tst.cc
> > 
> > and
> > 
> >   sudo perf probe -x ~/tmp/tst --add _ZN65n111111111111111111111111111111111111111111111111111111111111111165n22222222222222222222222222222222222222222222222222222222222222221fEv
> > 
> > After the patch a better error message results, and the workaround is clear:
> > 
> >   sudo perf probe -x ~/tmp/tst --add probe=_ZN65n111111111111111111111111111111111111111111111111111111111111111165n22222222222222222222222222222222222222222222222222222222222222221fEv
> > 
> > Dima Kogan (2):
> >   perf probe-event: un-hardcoded sizeof(buf)
> >   perf probe-event: better error message for a too-long probe name
> > 
> >  tools/perf/util/probe-event.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > -- 
> > 2.42.0
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
