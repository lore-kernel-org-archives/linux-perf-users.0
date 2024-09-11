Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F401A304E;
	Wed, 11 Sep 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070224; cv=none; b=EFqlR+rWYC4PKRhOT5Lj4os/xqb6t03kQvSOhkg7RvzKhm4ADY31+5lQjlgxH8l5WrojWl4ZzH5L/oZi72CnbPRI0kmxLlhICMo4qT/D8ErIqKHp4f5al3A3kdIiQ4jL9YWjyWsLBDfaSPTNY5q+McIbQU4oi1CKDG+W1p8v2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070224; c=relaxed/simple;
	bh=U3AaWtUbGFR9tt01UqvoLSbhbgiM9cu0hXA9w9pTxMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZd3H45A6lhaWYWN94pS0n//0uWijYxvN7EkqJZ2BSKxJ7keH+lhBRm2DVNrvdPNbSuW+8MmNOEJEebJYbEEY606bMGCyv07s472qvpMGRwCk0afythbH7Wr6R7ITjL7BIRtAjv2iQv0XhzzSEss33tYs9ToFTyPYVipZnyhpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVuUOR3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVuUOR3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26408C4CEC5;
	Wed, 11 Sep 2024 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726070222;
	bh=U3AaWtUbGFR9tt01UqvoLSbhbgiM9cu0hXA9w9pTxMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVuUOR3zcp0K2TQ64jt0KVoWQLJWGIi6bI7pE+kHMq4MMQVj30SdoL/8weXYQbqrd
	 1PHQ6EO4N+HTLR2FVcZzNMMHChEjTTcayHHWWXSjxEkIxoMNmHpKMPgsBYzwXgVa4T
	 UREoHnVUYlv1o3Ks67jb291evfLnEKzIc5e8z6IqpDSnQiiBsB1iqtKSvWohTr/Bml
	 zckLzn+iL1ed1ykSHIcuDIWSTmPDEglB7gwOvvP5+cBTUpAf54Rw/5NS23UJ5LRoVc
	 RqTl0XDlGXqOdMEaFapNzIwqpHxyxWcu+raUfS6x5043M81YJNIEVjCTjfaroUxYo0
	 0A4reAZJhYdow==
Date: Wed, 11 Sep 2024 12:56:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf mem: Fix missed p-core mem events on ADL and RPL
Message-ID: <ZuG9ywKpzDE953RD@x1>
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
 <20240905170737.4070743-2-kan.liang@linux.intel.com>
 <ZtoHgMqNhnDdvAIi@x1>
 <1a339858-74a3-414a-9fc1-bef47c513728@linux.intel.com>
 <ZtsO-v3pUVezKBgE@x1>
 <8644996b-33d6-4eee-890c-f23a3c830b77@linux.intel.com>
 <ZttgvduaKsVn1r4p@x1>
 <eafb8f49-2396-4652-a74e-882b4066790e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafb8f49-2396-4652-a74e-882b4066790e@linux.intel.com>

On Sun, Sep 08, 2024 at 04:30:44PM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-06 4:06 p.m., Arnaldo Carvalho de Melo wrote:
> > On Fri, Sep 06, 2024 at 12:08:52PM -0400, Liang, Kan wrote:
> >> On 2024-09-06 10:17 a.m., Arnaldo Carvalho de Melo wrote:
> >>> On Thu, Sep 05, 2024 at 03:47:03PM -0400, Liang, Kan wrote:
> >>>> On 2024-09-05 3:33 p.m., Arnaldo Carvalho de Melo wrote:
> >>>>> But can we reconstruct the events relationship (group, :S, etc) from
> >>>>> what we have in the perf.data header?
> > 
> >>>> Do you mean show the group relation in the perf evlist?
> > 
> >>>> $perf mem record sleep 1
> >>>> [ perf record: Woken up 1 times to write data ]
> >>>> [ perf record: Captured and wrote 0.027 MB perf.data (10 samples) ]
> > 
> >>>> $perf evlist -g
> >>>> cpu_atom/mem-loads,ldlat=30/P
> >>>> cpu_atom/mem-stores/P
> >>>> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
> >>>> cpu_core/mem-stores/P
> >>>> dummy:u
> > 
> >>>> The -g option already did it, although the group modifier looks lost.
> > 
> >>> Right, I can reproduce that, but I wonder if we shouldn't make this '-g'
> >>> option the default?
> > 
> >> I think the evlist means a list of events. Only outputting the events
> >> makes sense to me.
> >> With -g, the extra relationship information is provided.
> > 
> > At first 'perf evlist' showing just the events present in the perf.data
> > file seems enough, and maybe it should continue like that.
> > 
> > It is just that this relationship is so critical that not showing it by
> > default looks suboptimal :-\
> > 
> > Perhaps we should add some warning at the end mentioning the special
> > relationships present and suggest using '-g' to see it?
> > 
> 
> Agree, and we already did a similar hint for tracepoint events.
> 
> Here is the patch to add a hint for '-g'.
> https://lore.kernel.org/lkml/20240908202847.176280-1-kan.liang@linux.intel.com/

Thanks for doing that, patch applied!

- Arnaldo
