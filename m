Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD430EF72
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938757; cv=none; b=RyGuWidGIu9XNKXvi1UpIfEDDf7EgIa/TgPcsfp9w9p9Onh4jO5ZcW1qngHHbc99tR/lc9ITA60GU70F+G86DoH09fW2bEeNKL7axmS+x+wRMaxZmSZGEsUU9Rd2IPg1kcYHLwlIazH/xCTVLWLntv1DwVfnKr3wREmA9mwvEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938757; c=relaxed/simple;
	bh=CxF/bywb+jSmWAvpG/Jmo9ddnQwSavE6ZlVGidWhWy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGKO1PuPMZa0KtnqwBgRhP8OnoeOjvSUXWJDhbjpQX7xCnjnOaum/VkM7+Eu4xJ0FwqvfhWWUw2CBODGEidG/fLnyMR5Vb7Cm6WzmNrpcKfypq+v/aZJDdF9/BYZtqu1aAoLPyNFcJd7VyidKV95dFFFBN46m9wHMmG+bN/tmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7+v7l9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7+v7l9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F269EC4CEE7;
	Fri, 31 Oct 2025 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761938757;
	bh=CxF/bywb+jSmWAvpG/Jmo9ddnQwSavE6ZlVGidWhWy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7+v7l9kYTZTuOqpPxMkPBFxstWLn6H719IqvcxaFz0Ss0p6fyZCRpGjww11yjE6K
	 VJDbAeUClM3T0lE780wKjO3ihnssKryBqApxIsYxAeMttTl+xjqubTUWWT8HMFxPFt
	 OXMq6nRpWtguL97ELPtFjo0cL0HbRRWcIRRd6o5cRss++0yQA9wKH4D2pEqPLQtHKZ
	 SipKbn+PiZmmqdUCQha0PEQdWtVfx/opXjsCdHDLvzyFtsaZ4yX0oQByi/DnK+deIL
	 4+W/3Y1VRsJNOad/3DzkEtpBE2xXrVhJEeHA8OW2ej8s8cbgmcNCjU9uMCHgudeD9m
	 G4GQu5/q2mjdg==
Date: Fri, 31 Oct 2025 12:25:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [RFC] perf tools: Update JSON event description
Message-ID: <aQUNQ8sHpTqQXoez@google.com>
References: <aP_AyZAzBBGXaTgR@google.com>
 <CAP-5=fW==xQ=fgyCTZmrPDTc3aikdoLdRUYk5NxEbDq+0HP6mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW==xQ=fgyCTZmrPDTc3aikdoLdRUYk5NxEbDq+0HP6mQ@mail.gmail.com>

On Wed, Oct 29, 2025 at 08:28:34AM -0700, Ian Rogers wrote:
> On Mon, Oct 27, 2025 at 11:58 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > I'm trying to make this change in the JSON description for hardware and
> > software events.  But I got a build failure in the empty-pmu-events.c
> > even after I re-generated it like below.
> >
> >   cd pmu-events
> >   ./jevents.py none none $PWD empty-pmu-events.c
> >
> > Did I miss something?
> 
> So the build failure/diff has the path to the generated
> empty-pmu-events.c. I'd copy that file rather than try to recreate the

I see.

> command line - although there should be no reason generating the
> command line fails it looks to me that you need to pass "$PWD/arch"
> rather than "$PWD":
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=tmp.perf-tools-next#n51
> Fwiw, the formatting in legacy-hardware.json was based on Intel doing
> the same thing and not wanting to start new conventions:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json?h=tmp.perf-tools-next#n32
> ```
>     {
>         "BriefDescription": "Conditional branch instructions retired.
> [This event is alias to BR_INST_RETIRED.CONDITIONAL]",
>         "Counter": "0,1,2,3",
>         "Errata": "SKL091",
>         "EventCode": "0xC4",
>         "EventName": "BR_INST_RETIRED.COND",
>         "PublicDescription": "This event counts conditional branch
> instructions retired. [This event is alias to
> BR_INST_RETIRED.CONDITIONAL]",
>         "SampleAfterValue": "400009",
>         "UMask": "0x1"
>     },
>     {
>         "BriefDescription": "Conditional branch instructions retired.
> [This event is alias to BR_INST_RETIRED.COND]",
>         "Counter": "0,1,2,3",
>         "Errata": "SKL091",
>         "EventCode": "0xC4",
>         "EventName": "BR_INST_RETIRED.CONDITIONAL",
>         "PEBS": "1",
>         "PublicDescription": "This event counts conditional branch
> instructions retired. [This event is alias to BR_INST_RETIRED.COND]",
>         "SampleAfterValue": "400009",
>         "UMask": "0x1"
>     },
> ```
> As the order of seeing events isn't well defined, I'm not sure what we
> gain by shorter descriptions and it could be frustrating for a user to
> see that 'cycles' definition is in effect a redirection.

I generally prefer short and clear descriptions and feel better to
remove duplications.  But I don't want to change the vendor JSON and
this change is not important so I can drop it.

Thanks,
Namhyung

