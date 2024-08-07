Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78F22334;
	Wed,  7 Aug 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020875; cv=none; b=kgU7D4094/jxbJE+s+a5I4uXynqlzA18mAYPH4BktK5xBAoBHMhvzo4ic+ze6x/lFzYGnpp762aEp0cQJjIJj/d0LYnZM8ZllMbmrACAPZG6RuANx6+wrNYf4Iz+QlQI3/sNfn365o0I8DZe/wy8ZqaBnrbfF5l6DDKfyY6udyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020875; c=relaxed/simple;
	bh=Jp1FFPAcPVLqB1cNeZutNl6ygB/KT74rhDRU/Q1H3Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N30uq1PzeDNDNAEi7WYcpUyXPTF+ZBUEBh+PKXAZyE4y4DU3T/Mp9BOe2pHrtYKryjX/0Ydk5P915JKJtUJk2ujvguoAl5vKHAsCG3Ug8ngaB9a1xQn+D3vIiBSiD3mYZvW5K41VL7gDW49uYG+eGfNoihvguRiNhl3tkAG65pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=c4i49En8; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="c4i49En8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=miQ8a2DrdymNd/XsjzaRvOeIV5C9+9V6PuYpgF8FIFA=; t=1723020873;
	x=1723452873; b=c4i49En8a0Y4N52OKAdrvHFeoTNw9miLawj1IC+esitG1lreBn4lgholBVFYS
	qwifK6PsM8OYVeDgbkalnFs/0APMtt9ogVO7j45ls4IsMWgDwZUK4b4jPJGjLltBdiV6Ivzywbp4a
	hSxM3P6Ryn5rKSu/R3ap2Oq90u6JzwEzrYIIqri/aKwCXEDPlF8cRHekBf6zL32Hs4C+s8UcoHTjS
	P0wlISYNEe11PPY6ncTdVIL2TbnHr4H8FKIhhoijLUBJOd2tPKCIUObkY8ictWzmII/Tl5lheSHex
	l8+1N4jv96qa0+jLbQ+MG0pXMVDeN9XuERec9UGKH47bgHzU6A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sbcRC-0006Qc-1L; Wed, 07 Aug 2024 10:54:30 +0200
Message-ID: <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
Date: Wed, 7 Aug 2024 10:54:29 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Ian Rogers <irogers@google.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "to: Mark Rutland" <mark.rutland@arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723020873;ea42c35e;
X-HE-SMSGID: 1sbcRC-0006Qc-1L

On 01.08.24 21:05, Ian Rogers wrote:
> On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [TLDR: This mail in primarily relevant for Linux kernel regression
>> tracking. See link in footer if these mails annoy you.]
>>
>> On 22.11.23 00:43, Bagas Sanjaya wrote:
>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>>
>> #regzbot fix: perf parse-events: Make legacy events lower priority than
>> sysfs/JSON
>> #regzbot ignore-activity
> 
> Note, this is still broken.

Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
this? Or is this a "we are screwed one way or another and someone has to
bite the bullet" situation?

Ciao, Thorsten

> The patch changed the priority in the case
> that you do something like:
> 
> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
> 
> but if you do:
> 
> $ perf stat -e 'cycles' benchmark
> 
> then the broken behavior will happen as legacy events have priority
> over sysfs/json events in that case. To fix this you need to revert:
> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> events over legacy"
> 
> This causes some testing issues resolved in this unmerged patch series:
> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
> 
> There is a bug as the arm_dsu PMU advertises an event called "cycles"
> and this PMU is present on Ampere systems. Reverting the commit above
> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
> __evlist__add_default") to fix ARM's BIG.little systems (opening a
> cycles event on all PMUs not just 1) will cause the arm_dsu event to
> be opened by perf record and fail as the event won't support sampling.
> 
> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
> fixes this by only opening the cycles event on core PMUs when choosing
> default events.
> 
> Rather than take this patch the revert happened as Linus runs the
> command "perf record -e cycles:pp" (ie using a specified event and not
> defaults) and considers it a regression in the perf tool that on an
> Ampere system to need to do "perf record -e
> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
> will choose the cycles event correctly and with better precision the
> pp for systems that support it, but it was still considered a
> regression in the perf tool so the revert was made to happen. There is
> a lack of perf testing coverage for ARM, in particular as they choose
> to do everything in a different way to x86. The patch in question was
> in the linux-next tree for weeks without issues.
> 
> ARM/Ampere could fix this by renaming the event from cycles to
> cpu_cycles, or by following Intel's convention that anything uncore
> uses the name clockticks rather than cycles. This could break people
> who rely on an event called arm_dsu/cycles/ but I imagine such people
> are rare. There has been no progress I'm aware of on renaming the
> event.
> 
> Making perf not terminate on opening an event for perf record seems
> like the most likely workaround as that is at least something under
> the tool maintainers control. ARM have discussed doing this on the
> lists:
> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
> but since the revert in v6.10 no patches have appeared for the v6.11
> merge window. Feature work like coresight improvements and ARMv9 are
> being actively pursued by ARM, but feature work won't resolve this
> regression.
> 
> I'm keen to see such patches as there are perf stat fixes reliant on
> the stacked parse event fixes that are consequently not merged
> affecting more than just ARM.
> 
> There is a related discussion that events specified without PMUs
> should inherently only mean core PMUs. Unfortunately such a change
> would break uncore events specified without a PMU, for example `perf
> stat -e data_read -a sleep 1` gathers read memory bandwidth on uncore
> memory controllers on recent Intel devices. Not specifying a PMU for
> uncore events is also assumed by perf metrics, so a large number of
> metrics would need updating to make such a change work. Many existing
> JSON uncore events specify a PMU in their name like
> UNC_M2HBM_CMS_CLOCKTICKS and it feels somewhat redundant to have to
> make that h2hbm/UNC_M2HBM_CMS_CLOCKTICKS/. It is unclear who would
> pursue fixing all of this, and so it seems not specifying a PMU with
> an event for perf will keep meaning trying to open the event on all
> PMUs that advertise such an event.
> 
> Thanks,
> Ian
> 
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> That page also explains what to do if mails like this annoy you.
>>
> 
> 
