Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC32BCF5;
	Fri,  6 Sep 2024 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653186; cv=none; b=iaSti1hkwmesKfjZ/nXzYfI2ZqEl0eTrr7m9e2cEwJssfOTHqe3GZOpz83VuFTXYpQm2luZJAGfAxO+cV+Aem41HnjgAxelEjOnAKEg3YWtx0ABFAKEWenYEc1Oes+yPT1YUYlkmNVhoJ4icZowNcUtwGkk3YK0bHEKCEm9zS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653186; c=relaxed/simple;
	bh=4wOrm1/JMqXF81WTRl2exPoXRDO6uvmW+dNAP5ZUVms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKGsARgoxGv+RSmt1N5iAnJM5AKkaytmnDJQO/z8I+ysnGU/UBLqNMYhcjB/VqH4ciujbNnX8sTbiQRnxNEyba2z7JoL1sndrIKtjJkwMLNEO9ExmS/g+M9svh93GaAmmd56PARa6isCewlxEnIIjcU2EvYMYOTtE5KaUwam1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suZslRvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suZslRvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21409C4CEC9;
	Fri,  6 Sep 2024 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725653185;
	bh=4wOrm1/JMqXF81WTRl2exPoXRDO6uvmW+dNAP5ZUVms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suZslRvDiCSl8lp0BcAxcsu+JSmQ0W4pAYv0Tw1n/ZVTuMWiRwtm9D8trOoljyZBj
	 Fed9qU/4z4X9RLJXTQ7mUbIM8zIJZiqB7hzap3UFDMzZR57/LVj7wpNPZ91981uckJ
	 fuAt1wzUpBOsRr6dUkZHKjD+l+0AA4L+ru+RUh46iERsEI60AL5CsHeIIOjHMvLG5g
	 99cByClrmyt2gUQba2dYy7pE9TG1Mrz1ZvXVoTRcD7t9m4ieJRtZLlZKKBulkUEg+M
	 4tmQD01KUOdqn83xjiEHm6Vn3U8RztkiwH4xzz954aXUuGBlLuYeL1/DFLLAEz/vAU
	 uwQJlJINWEctQ==
Date: Fri, 6 Sep 2024 17:06:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf mem: Fix missed p-core mem events on ADL and RPL
Message-ID: <ZttgvduaKsVn1r4p@x1>
References: <20240905170737.4070743-1-kan.liang@linux.intel.com>
 <20240905170737.4070743-2-kan.liang@linux.intel.com>
 <ZtoHgMqNhnDdvAIi@x1>
 <1a339858-74a3-414a-9fc1-bef47c513728@linux.intel.com>
 <ZtsO-v3pUVezKBgE@x1>
 <8644996b-33d6-4eee-890c-f23a3c830b77@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8644996b-33d6-4eee-890c-f23a3c830b77@linux.intel.com>

On Fri, Sep 06, 2024 at 12:08:52PM -0400, Liang, Kan wrote:
> On 2024-09-06 10:17 a.m., Arnaldo Carvalho de Melo wrote:
> > On Thu, Sep 05, 2024 at 03:47:03PM -0400, Liang, Kan wrote:
> >> On 2024-09-05 3:33 p.m., Arnaldo Carvalho de Melo wrote:
> >>> But can we reconstruct the events relationship (group, :S, etc) from
> >>> what we have in the perf.data header?

> >> Do you mean show the group relation in the perf evlist?

> >> $perf mem record sleep 1
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.027 MB perf.data (10 samples) ]

> >> $perf evlist -g
> >> cpu_atom/mem-loads,ldlat=30/P
> >> cpu_atom/mem-stores/P
> >> {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}
> >> cpu_core/mem-stores/P
> >> dummy:u

> >> The -g option already did it, although the group modifier looks lost.

> > Right, I can reproduce that, but I wonder if we shouldn't make this '-g'
> > option the default?

> I think the evlist means a list of events. Only outputting the events
> makes sense to me.
> With -g, the extra relationship information is provided.

At first 'perf evlist' showing just the events present in the perf.data
file seems enough, and maybe it should continue like that.

It is just that this relationship is so critical that not showing it by
default looks suboptimal :-\

Perhaps we should add some warning at the end mentioning the special
relationships present and suggest using '-g' to see it?

- Arnaldo
