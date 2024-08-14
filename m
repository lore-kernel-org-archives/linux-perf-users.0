Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3A1B1405;
	Wed, 14 Aug 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653703; cv=none; b=hymzJ9PUs8hCS6lCN2DXBv6DqKWqiVZVKiGZHx9J+PP9LcoBH6BKGUgKlYrE0lQV40ufVdwD0g0fYTYzrnvmDrV7kpK5a8O6a/ltvQqR1I3/foUczQCcUykA4B3hJIoWJAk7XEHnC12KLyl+TEvukLNjMv7qB4uGhFJiwAS3AqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653703; c=relaxed/simple;
	bh=oRBsxwoUBV8IWRdPaDOxWP9dB1rTaBy9f/k7rxBrtXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLZa1Pou3HXsJM9JKWIaepQwvifZvJ5Jcu59vTIZ3q6p0v/+jYWn0mcW2B3hg6pV9ZtJgYIWUuYYp/VZkYZIG5HIFldvNRwenqlkP7fdMBiwh7zzFIFlBTpPMZYLG8JJxHycOxMjZ/0bVmMvdwe5NovdLzf0mrGpWBNRfOU8yeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sytFp4g1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sytFp4g1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64031C116B1;
	Wed, 14 Aug 2024 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723653702;
	bh=oRBsxwoUBV8IWRdPaDOxWP9dB1rTaBy9f/k7rxBrtXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sytFp4g1ZMhTycSnPEaJtY8FkKC1U6V24Oq2pHY+zQqRagfQhuvoXiV1eoL+9Osb2
	 ioEgdQuMtyC+1ifVVcA436f0CdNB4rFSalhNvqCxCR222sedIoh5ax3KfH8//wpMMI
	 Sf3YNckrAMeiZPutvKT0Fv75r05uj8YHxhP1DDnbqwZS4SRm9yT1H9UJEzcugRbVU+
	 M20W0HA2NG+bC0OjlqhnIWDKK7Xhgz//scASd1iSB57AOmKlsjbc1RyDVBiQIIHGjK
	 +DNa4fa9qBPBuOYjznUSfkVnAshjmcRImNZuj2/1F8OTthTB5SOU/jEKpWFJGruSTM
	 tkHsYS8eZVeNQ==
Date: Wed, 14 Aug 2024 13:41:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux perf Profiling <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	James Clark <james.clark@arm.com>,
	"cc: Marc Zyngier" <maz@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZrzeRM3ekLl9zp3z@x1>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>

On Wed, Aug 14, 2024 at 05:28:42PM +0100, James Clark wrote:
> 
> 
> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
> > On 01.08.24 21:05, Ian Rogers wrote:
> > > On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
> > > (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> > > > 
> > > > [TLDR: This mail in primarily relevant for Linux kernel regression
> > > > tracking. See link in footer if these mails annoy you.]
> > > > 
> > > > On 22.11.23 00:43, Bagas Sanjaya wrote:
> > > > > On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> > > > > > Perf broke on all Apple ARM64 systems (tested almost everything), and
> > > > > > according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
> > > > 
> > > > #regzbot fix: perf parse-events: Make legacy events lower priority than
> > > > sysfs/JSON
> > > > #regzbot ignore-activity
> > > 
> > > Note, this is still broken.
> > 
> > Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
> > this? Or is this a "we are screwed one way or another and someone has to
> > bite the bullet" situation?
> > 
> > Ciao, Thorsten
> > 
> > > The patch changed the priority in the case
> > > that you do something like:
> > > 
> > > $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
> > > 
> > > but if you do:
> > > 
> > > $ perf stat -e 'cycles' benchmark
> > > 
> > > then the broken behavior will happen as legacy events have priority
> > > over sysfs/json events in that case. To fix this you need to revert:
> > > 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> > > events over legacy"
> > > 
> > > This causes some testing issues resolved in this unmerged patch series:
> > > https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
> > > 
> > > There is a bug as the arm_dsu PMU advertises an event called "cycles"
> > > and this PMU is present on Ampere systems. Reverting the commit above
> > > will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
> > > __evlist__add_default") to fix ARM's BIG.little systems (opening a
> > > cycles event on all PMUs not just 1) will cause the arm_dsu event to
> > > be opened by perf record and fail as the event won't support sampling.
> > > 
> > > The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
> > > fixes this by only opening the cycles event on core PMUs when choosing
> > > default events.
> > > 
> > > Rather than take this patch the revert happened as Linus runs the
> > > command "perf record -e cycles:pp" (ie using a specified event and not
> > > defaults) and considers it a regression in the perf tool that on an
> > > Ampere system to need to do "perf record -e
> > > 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
> > > will choose the cycles event correctly and with better precision the
> > > pp for systems that support it, but it was still considered a
> > > regression in the perf tool so the revert was made to happen. There is
> > > a lack of perf testing coverage for ARM, in particular as they choose
> > > to do everything in a different way to x86. The patch in question was
> > > in the linux-next tree for weeks without issues.
> > > 
> > > ARM/Ampere could fix this by renaming the event from cycles to
> > > cpu_cycles, or by following Intel's convention that anything uncore
> > > uses the name clockticks rather than cycles. This could break people
> > > who rely on an event called arm_dsu/cycles/ but I imagine such people
> > > are rare. There has been no progress I'm aware of on renaming the
> > > event.
> > > 
> > > Making perf not terminate on opening an event for perf record seems
> > > like the most likely workaround as that is at least something under
> > > the tool maintainers control. ARM have discussed doing this on the
> > > lists:
> > > https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
> > > but since the revert in v6.10 no patches have appeared for the v6.11
> > > merge window. Feature work like coresight improvements and ARMv9 are
> > > being actively pursued by ARM, but feature work won't resolve this
> > > regression.
> > > 
> 
> I got some hardware with the DSU PMU so I'm going to have a go at trying to
> send some fixes for this. My initial idea was to try incorporate the "not
> terminate on opening" change as discussed in the link directly above. And
> then do the revert of the "revert of prefer sysfs/json".
> 
> FWIW I don't think Juno currently is broken if the kernel supports extended
> type ID? I could have missed some output in this thread but it seems like
> it's mostly related to Apple M hardware. I'm also a bit confused why the
> "supports extended type" check fails there, but maybe the v6.9 commit
> 25412c036 from Mark is missing?
> 
> I sent a small fix the other day to make perf stat default arguments work on
> Juno, and didn't notice anything out of the ordinary: https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org/T/#t
> I agree that change is quite narrow but it does incrementally improve things
> for the time being. It's possible that it would become redundant if I can
> just include Ian's change to use strings for Perf stat.
> 
> Of course I only think I have a handle on the issue right now, seems like it
> has a lot of moving parts and something else always comes up. If I hit a
> wall at some point I will come back here.

Thanks for working on this, hopefully we'll get to a solution that keeps
all the expectations expressed in this thread about not breaking
existing muscle memory and that allows us to progress on this matter.

- Arnaldo
