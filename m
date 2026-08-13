Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D283469EE;
	Thu, 13 Aug 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610469; cv=none; b=Hq3u1qAUb/dAzczzg2kN4+PfQTPSBNc6v63BiXdmbpQ2DMAc4UN8+GbM6gil0SL5sDefyeEpENoiEVOse+ASMYIhestNQrjQ/bWIYgRvO+zfOMyOSFMQZj8iR0VEY0ykxDPWa6McQLbjsJvPH+ukKvrbNeWS0UPUbN85ymaOeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610469; c=relaxed/simple;
	bh=HJF38ojJi88LTRn7v1B2JVeRcM0tTdWJPkHjb9Awr9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsN4hwpzJSTPufdAcJF8x6zS25+AfXVgkFtl5DmIThaq/jI+6DiGB9r0WWWUQk+5d3eBBU0IHyIF3gpjXdi6UEQNCPz8mDTBmYIHdXverDPSLTBmnyUJSww5HrPWTw1B2P979WqeGjL47GdMZO0ISGOifgxg+odz9jcZKQ0m1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccmUWQF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccmUWQF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A9D1F000E9;
	Thu, 13 Aug 2026 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786610468;
	bh=/OPXs53O0k/9aDgHV+FEk26wxFCfAnqX1iyxncKf+Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccmUWQF+jvDc5hTzrD6MUln8C/4SyQR+2qveqCoZtuEV3nmwKUva8wsrVS6dB6wBj
	 o0bu4LLzoV3jhvsANW/1bi9kRwW6Scd7Am8IDruuz5yBZqYu0CWQ0ONkDclNTh3b10
	 E52MYX3ej6VY4wzXM9GsRnW+15NkfFXfQbn2/RAddC/kiX8N4MraHUbtFZlGLkze7v
	 T7wIUNMXL14eA7x2nDEnSORhdmJkzEBcQTd3Yk++/gaVBmavBO+M0kWgnVhklgYVpc
	 iPP8201PWHTcXFw8z4DvPVoDSVUjtvy8Bt4MCZ8NqGg3BRZ+1XvWC4EHnh+KchHZUz
	 J18zNc0AFU8zw==
Date: Thu, 13 Aug 2026 09:41:02 +0100
From: Will Deacon <will@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
Message-ID: <an2DHgfQsQ6TOF44@willie-the-truck>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
 <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>

On Wed, Aug 12, 2026 at 06:38:24AM -0700, Ian Rogers wrote:
> On Wed, Aug 12, 2026 at 1:27 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> > > This patch series adds an uncore Performance Monitoring Unit (PMU) driver
> > > for Broadcom AXI system and VideoCore VPU performance monitors found on
> > > Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).
> >
> > Why are you sending four versions of this patch series, at -rc7, each in
> > reply to the previous one? Nobody is going to review that.
> 
> See the cover letter for changes. They address the sashiko reviews,
> you may not see these reviews as they are only sent to me and
> linux-perf-users, which is somewhat customary in the sashiko setup.

Have you considered running Sashiko locally given that you work at Google?

> I don't see any relevance in rc7, I'm just mailing out a new driver
> now that I have the opportunity to look at it. Whether and when it
> gets pulled upstream is up to a maintainer.

Right, as the maintainer for drivers/perf/ and I'm just asking you to
slow down a bit. I don't need 10 versions of a patch series in two days
when I'm focussed almost entirely on the upcoming merge window, which
this is too late for. You should read
Documentation/process/submitting-patches.rst which states:

  | Wait for a minimum of one week before resubmitting

> The changes are sent in reply to each other because the entire series
> is visible in one mailbox (b4 mbox), which I find easier to work with
> and provides me better context. Others use semcode to do something
> similar, but I've not explored that.

Unfortunately, this tends to confuse b4 when applying the patches and
makes it really hard to manage on the maintainers' side. I think this
is also documented in Documentation/process/submitting-patches.rst so
please do what everybody else does.

> Let me know if I should drop you from the cc, I placed you there as
> Mark and you were the only suggested reviewers from
> scripts/get_maintainer.pl but I don't want to spam uninterested
> people.

It depends if you want the patches merged...

For now, I'm ctrl+d'ing the thread.

Will
