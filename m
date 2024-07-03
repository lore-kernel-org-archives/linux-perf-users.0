Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0C1940B9;
	Wed,  3 Jul 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042404; cv=none; b=j8lkfpVDsM3yMbZf0Gxjdnl7zWo6GzW/sRgPBpDmEUptvWFe80Y6p+Jr4HiDZZD9EM+Ly15I5Bz/p7QLis01KwaBtFFf4GL6PLLCmB4yAojA2rI6l6sOUl3ogiAHv2KZUCrkjE/YT/YNHi/A72DgdEg8FUmdSA/Wg2QCVRcBXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042404; c=relaxed/simple;
	bh=OkYtB1316J9NrBqd8USjAW1wVBXQUj788mHBRh31ILk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpjeXDfaF7wjIJ0vIT6ohHSb5KZcGSYnbVdOQ4Qr5s/tpHyo+IfU8BLzSjLvM+1OTzXheck+YWOiTq5jBV00MNPHSyp1rteaxkQ5DyshrYneZmBoIqzzym872p6ROjgi4d1k7WpAok8XBZBqWUOFNAjGEiKWfuCYQ+Lq1vqN33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwyexZ64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwyexZ64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46984C2BD10;
	Wed,  3 Jul 2024 21:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720042403;
	bh=OkYtB1316J9NrBqd8USjAW1wVBXQUj788mHBRh31ILk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwyexZ64SdVFSXi2PaiUD6U572CmkLsaJzPeXvbWFvZPQ7yTg3K2wduoGqjM6ox3e
	 cfkHwazYOs5q6SlelKpUZ53mkdqRoVSvbhs4NhH52zEF+y+3sXk1iRFgpJAiWe2x97
	 z/JZBnuKC4ImdgZbS88z7EmH2qClwH8swisxr+aKxASbOUGeDv6DEw8m9QHP3lyreA
	 lulcDBxSpHVZjEGJaT1ZZgDOMttlq38c1FUx5Tc5GeUgMVm2wuicSsV4c/8VtnI6AF
	 S/wtyHrEpTXOn0vYJql4QisdAnIQlYvRiqX/p68yQF8h4pdlZQoZk3pFF2UmPGHbRy
	 BoAE2F1+Gd3eQ==
Date: Wed, 3 Jul 2024 14:33:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guilherme Amadio <amadio@gentoo.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] tools: Make pkg-config dependency checks usable
 by other tools
Message-ID: <ZoXDoajJqDiIcgwg@google.com>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
 <20240628203432.3273625-3-amadio@gentoo.org>
 <ZoSP_vFMVl83pxES@google.com>
 <20240703153617.650fcc1c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703153617.650fcc1c@rorschach.local.home>

On Wed, Jul 03, 2024 at 03:36:17PM -0400, Steven Rostedt wrote:
> On Tue, 2 Jul 2024 16:40:46 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > +CC Steve and linux-trace-kernel list.
> 
> There doesn't seem to be a cover page, and it doesn't apply on
> v6.10-rc6 nor on tip.

Oh, sorry.  You can find the whole series here.

https://lore.kernel.org/linux-perf-users/20240628203432.3273625-1-amadio@gentoo.org/#r

I think this is based on the perf-tools-next tree and depends on perf
changes.  If you're ok with the change, I can carry it in the perf tree.

Thanks,
Namhyung

