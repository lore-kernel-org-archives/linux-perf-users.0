Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9B5FBB1;
	Wed, 21 Aug 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251532; cv=none; b=sQ92+OAguS+dCq3x2EFuqztHy2acX4nb+IYe+O3hIzexFjbpiH+4NkiKIjXCUE0tHm23B7CwYHXCgU7K3rqU5MCO9s0IMwnhgSq8/bp9WeTFupwgzyTuINZhH3r9q9yAaEkG6emmr0AKiFaziFHNqV7CnxFSJKjf3jdAGOPYz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251532; c=relaxed/simple;
	bh=94snl9uJNq1Uh/1TFdmI02fxGni2eP7lrk7Jdtz14s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAG26dIaopaWIuYhXBU9epxKUs802Y6zpRHbaCYtuFLuwKBEwBOUO5/r63rAhj5Z7n+h0+1sJZWueG+QMdjrcw7VwtV3vvA9STLW9EG6sAuovRnFJCZhbtkl4J9xrvDtIto+w8xbf/qrLRvPTNfbD5pR/lJsKIKTBIyxh1ZXxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ0wJGkH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ0wJGkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A0C32781;
	Wed, 21 Aug 2024 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251530;
	bh=94snl9uJNq1Uh/1TFdmI02fxGni2eP7lrk7Jdtz14s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJ0wJGkHMNItCfpPDgV5qPCQ4KYSF/XJ0p+oE0vNXuoDZidEO+lCcWOFF1d5MwHwK
	 0L6azenY07/6U/XizUJM5u9IchUCqHRISPbxoQHJzGO/PX65Lt8sheu1XIfhV3q0Ky
	 KlRqG5FgwxlqiURoGXzlyMPLaev24YqcJ9lQXdDZD5YoGwF3g7BNJtaPNnrz83Fl5d
	 vqFmhy4y3clA4gQfzd+B0yecSgRDXD2fy8107mVX/1qvAvuAd+7/78jeu9ZUzpFzae
	 OWsDpXP+roMCTI5iKK0XKH0J57qO4kIQA2F+Pgo/iolR67mcwYO4eactTdvyIG40Sx
	 I7LnErBTM9a4A==
Date: Wed, 21 Aug 2024 11:45:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf annotate-data: Show offset and size in hex
Message-ID: <ZsX9hyFnVNCZg40u@x1>
References: <20240819233603.54941-1-namhyung@kernel.org>
 <CA+JHD93fa33YL_AHL9RfxUOoBm+hw8zHbk13BU4qD8B3p4KHug@mail.gmail.com>
 <CAM9d7cjLvS5BUO_AEkfR3LsT8SNB8MCt-DTHCiRDrZyQxhySoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjLvS5BUO_AEkfR3LsT8SNB8MCt-DTHCiRDrZyQxhySoQ@mail.gmail.com>

On Mon, Aug 19, 2024 at 07:21:34PM -0700, Namhyung Kim wrote:
> On Mon, Aug 19, 2024 at 5:12 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On Mon, Aug 19, 2024, 8:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> It'd be better to have them in hex to check cacheline alignment.
> >>
> >>
> > Why is it better? To compare with the usual output of some other tool?
> >
> > Spelling out reasons helps reviewers/users.
> 
> Cache line sizes are power of 2 so it'd be natural to use hex and
> check whether an offset is in the same boundary.  Also perf annotate
> shows instruction offsets in hex.
> 
> >
> > Maybe this should be selectable?
> 
> I can add an option and/or a config if you want.

It would be interesting to have, but I'm merging the patches to make
progress...

- Arnaldo
