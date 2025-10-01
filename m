Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD27221F0C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327771; cv=none; b=dzv3s8h2R1B6zd+LV7AcW4OzBFoG2ExisIh73TgWPK9IBzqRhdPebs+XXyV8M3pWQr39mWYuuZ0VIhaHQXX990wN+5Lq3cA4JuwPk7gvPi+oL8HQTT7k4Uik9ewZx/5ETdwaMM9fSwkSVVHj5VtfFCAp1btyz6+A5xX3AgiUDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327771; c=relaxed/simple;
	bh=aV9Quhsd3bTsmyd1udOTUsvKepHnvhjVqiYvAtgBOjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHFovBfxHn8NMLhYWM5+LS4ww91t2P3QMxQG7rc6/kDLpMnx1zryZIk8+5g9SaObtUJawe0LQKdKhEjrcL14HOO3+qE0LKGlhc0NG/QxAR3a2/eYcQqz9PxGhgz1euBslB2kotpdVpQ/ftIYeG2CwI4Ww3Y14ItV15mvYjHPXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxANNX2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxANNX2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E725AC4CEF1;
	Wed,  1 Oct 2025 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327770;
	bh=aV9Quhsd3bTsmyd1udOTUsvKepHnvhjVqiYvAtgBOjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxANNX2WM64f+TmAOiA8AFpsl+rn/cPn3Wwc+0N74w+bEqSKjvIbvhHEoyBryEiU+
	 a9lafN6lol0p4dZY8oCruGHsYFjc0bQg6fJIkrx+IbtqR6I9VA3NYT+Nru97KlYfbW
	 livQCBloAMGyrbobKZ2i1rbWpJW57UxS+i1LxMaSfE88P2r8FZZs43uasDF9eIjsgg
	 Td/FpX0KWotz3tUWb/sOeKLl5KcYNGKZdofMEMHMx8MYQ0xnLp+67CFncqH4ATamp/
	 NIy4lZ5Bp0rffyLORR6/YQN+XIb32EMpEV9UIwWMja/UiP1Q8UJIzsI5boHm/pD/fE
	 q4xTpQtvC74wA==
Date: Wed, 1 Oct 2025 11:09:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	hbathini@linux.vnet.ibm.com, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Tejas Manhas <Tejas.Manhas1@ibm.com>
Subject: Re: [PATCH V3 0/6] perf/tools: Add interface to expose vpa dtl
Message-ID: <aN02F61OLv6Tx_gB@x1>
References: <20250916052536.93911-1-atrajeev@linux.ibm.com>
 <ac85151f-21e0-4a98-96e6-8153d0159915@intel.com>
 <6BB167B7-6479-44E7-9175-E67E500DB9E2@linux.ibm.com>
 <7EE7DD5B-6550-436B-A799-2B1DF293121E@gmail.com>
 <AB498516-CA5D-428C-B6FC-CC46A43E39AA@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AB498516-CA5D-428C-B6FC-CC46A43E39AA@linux.ibm.com>

On Fri, Sep 26, 2025 at 10:23:56AM +0530, Athira Rajeev wrote:
> > On 25 Sep 2025, at 9:57 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > On September 25, 2025 6:21:19 PM GMT+02:00, Athira Rajeev <atrajeev@linux.ibm.com> wrote:
> >> Looking for further comments if any on this patchset.
> >> The kernel side patches for this feature which was sent as separate series is pulled to powerpc tree by Maddy
> >> 
> >> If the tools side changes looks good, can we have this merged to perf tools tree ?

> > Sure, I'll look at it soon now that the kernel part is merged.

> Sure, thanks Arnaldo 

Applied locally, build testing now.

- Arnaldo
