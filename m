Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC703B7B79;
	Wed, 12 Aug 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523239; cv=none; b=kEBO7V2aiUWPRSopoLF1XwQUcKsRXWWTLs+kBkFyMnx2HhPU7552A5NRvMsmqtWQes+ef1DOXgk1Mq2wiYMZRh9e6Q0jPfKz50jvWIP4deuy2MLaP0MUXa7+ReBO4FOxX2FHdZuSWs16N0m63iaUPBli4JxrlzVOo0mzNZgFZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523239; c=relaxed/simple;
	bh=OE53f+PpyVT0Fk31g8KAdp81l7g3N8MhlvrA9gb3X40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M86E4mwvbqy+6p5whT+4WTC8u9jEG3GGxZ/S3rXZUOQfOJCiYrZKhyDKdNkvGRI/E1xoIOLcdKFABcMtkp0xuVluKWbP/KaxY76A9jhaubrGau8yE2sl6qJs4kiL6Bp75CaJkMFI9i52nR2Z9O8P+Jt7SLnuVaYf8czTKrfutn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm5008It; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm5008It"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041781F000E9;
	Wed, 12 Aug 2026 08:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786523238;
	bh=OE53f+PpyVT0Fk31g8KAdp81l7g3N8MhlvrA9gb3X40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vm5008ItZcq74yFnDL5ETN/l+/Es9qN/gurjHQdvGIex7jYRanh/T9d8HFCdnm41C
	 RbZyl31znakaCMeicT9FdqMijxrYN6h/TrMx44A0ai8Y/yQNQS4J1K0p+cPCJ6PJVE
	 Iqqs3i+W1FHt36Eh246oBYvi6jxrOKvQxxQO2iuB0J3duh8tGMh/rF8pet+EgBDkIo
	 6lSxsxmzbZ8rvr24j5w2EoXurvPbG9d88oVSTD5A0/v8Yn7W+I078uNBluNQb9DDU3
	 0HU31a7krS7AAiFDSoq2m6kICKgBsQ5Dwycia9fLn3yegNpgQ87l190Uw3K5UbDvIs
	 sbdG/l3/QJngQ==
Date: Wed, 12 Aug 2026 09:27:13 +0100
From: Will Deacon <will@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
Message-ID: <anwuYYxLFbtDmmHx@willie-the-truck>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812052417.2361040-1-irogers@google.com>

On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> This patch series adds an uncore Performance Monitoring Unit (PMU) driver
> for Broadcom AXI system and VideoCore VPU performance monitors found on
> Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).

Why are you sending four versions of this patch series, at -rc7, each in
reply to the previous one? Nobody is going to review that.

Will
