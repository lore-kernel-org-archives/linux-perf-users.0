Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B71E864
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302382; cv=none; b=pnHSod3Er7xCCDQEPS6dOWPk2SixzZsBRI5YdKYv8mztunzXr5iTTxelsSZZpCuSac1IMqllTCXZ630dsB3JoTqQw6vSe6Hv76H4MKzM+FN/gjCarnLFL7CYtGL3DdvTY6YaEIBw1+OO7Bpp2fOOECOVgCcC9SBYrPaEaki395o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302382; c=relaxed/simple;
	bh=TPvbHDbxPVwjGtp/vlBtbFiPWzzfwnBlCXfzp1KbNbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3GLRUOWx23Q4ZDlm4PKUD4AfzLiT8jqutTinQNmX/XGM4xe3DYhMQm/sjDml25/9Tl4rP/WB/pv1XoDMjCwuwYAykyAKZ6GyUaNucxZOTjGnvtOxx8A6Q+Hg49gATlXZ0W4Enm6vY3G5+zZSvUHorTTpcel0nvn5LoUvvN2zjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJCt0+uY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJCt0+uY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE469C113CE;
	Tue, 16 Apr 2024 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713302382;
	bh=TPvbHDbxPVwjGtp/vlBtbFiPWzzfwnBlCXfzp1KbNbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJCt0+uYc2331WltHzsq1QJzO5MEgWgMT7m6xN5Hi3ythc9HBRTNs+fox6tQmv4YY
	 UrRw+66NSTN5pveFtUU/Sd4NzFgjYFTIDwkneB2ujfsy5YJGIsFYI72L/KLuiaqtrn
	 x111h37Ta68OsrM3XIUmUlLwP8jQ/8jVQHI6+8b5uJEnAHIxYcJXc/KHYBA2eCV52P
	 j8BaN/HgEE5jXTd7JIQx4CooEtuJEA6qzNgapCNCMi65t8hFwy8g1nVOcF5VMzaguf
	 IrB1ua4rCtUNNdKpKioZAsu+s0cgaLNVI3IzwWZg9yD2xybok5Dw8kFFwmd+gFb/cE
	 33ZFrxPexa4WQ==
Date: Tue, 16 Apr 2024 18:19:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com
Subject: Re: [PATCH V2 6/8] perf tools: Enable configs required for
 test_uprobe_from_different_cu.sh
Message-ID: <Zh7raxHFUBPoKuau@x1>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-7-ChaitanyaS.Prakash@arm.com>
 <20240409081117.beef0c0e192d647aeeb88235@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409081117.beef0c0e192d647aeeb88235@kernel.org>

On Tue, Apr 09, 2024 at 08:11:17AM +0900, Masami Hiramatsu wrote:
> On Mon,  8 Apr 2024 11:52:28 +0530
> Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
> 
> > From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> > 
> > Test "perf probe of function from different CU" fails due to certain
> > configs not being enabled. Building the kernel with
> > CONFIG_KPROBE_EVENTS=y and CONFIG_UPROBE_EVENTS=y fixes the issue. As
> > CONFIG_KPROBE_EVENTS is dependent on CONFIG_KPROBES, enable it as well.
> > Some platforms enable these configs as a part of their defconfig, so
> > this change is only required for the ones that don't do so.
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Trying to cherry pick patches from this series to make progress.

- Arnaldo

> Thank you,
> 
> > Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> > ---
> >  tools/perf/tests/config-fragments/config | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
> > index c340b3195fca..4fca12851016 100644
> > --- a/tools/perf/tests/config-fragments/config
> > +++ b/tools/perf/tests/config-fragments/config
> > @@ -9,3 +9,6 @@ CONFIG_GENERIC_TRACER=y
> >  CONFIG_FTRACE=y
> >  CONFIG_FTRACE_SYSCALLS=y
> >  CONFIG_BRANCH_PROFILE_NONE=y
> > +CONFIG_KPROBES=y
> > +CONFIG_KPROBE_EVENTS=y
> > +CONFIG_UPROBE_EVENTS=y
> > -- 
> > 2.30.2
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
