Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895423909C
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110505; cv=none; b=ZkzPWcSez0VVsF48RzwslqTQcmPmRkjoBQ4mm9EsFMDNyAhtAJy0xckqPDfOWM3lJCwxRmZXSkvvVg9JuiEWDNHAK3s9cYFjQNjveyNXavZ8snAOJBjYsGzqtQjMmq9tds5Gw7U6sDErdZU6hSU6gRye4glSpTv0KP8TJCZhovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110505; c=relaxed/simple;
	bh=gcMURUZC4/88e1N06KekCP4i+JopUXGsCTSV3P9iyug=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PPksBRy2aFmsXqktEwY0apfxszIledN53eiXKTndqWzBUFPqUVsG4VPbTeC4RVdzbnbTuaxqgMtBuG8Br6PXtYzspzuip7xwOg2VQlQASfWxswCnGj4JuoK7AWnsup4NendCaF8NoiA4jChmfZQqya+LcCnfmB/vAz7aiU4kM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=Mzrmgkth; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="Mzrmgkth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1787110494;
	bh=gcMURUZC4/88e1N06KekCP4i+JopUXGsCTSV3P9iyug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mzrmgkthh3J0VHJabWBsPmjLUyKMyWtlWtz+t8XqxAkf7YumbaaQdSvid0wwNQcnF
	 1GXnR/QkV3uJlMbtUzxMgENWER8oUHTn46iDR9MPfsERp3Ondie5J7O+ZlKwnhTmiR
	 rFWBKt53l19OK0q9jDhY6XmHKGg04COrhb69BVUQ=
Received: from firstfloor.org (localhost [127.0.0.1])
	by one.firstfloor.org (Postfix) with ESMTPA id 106455E89D;
	Wed, 19 Aug 2026 05:34:54 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 20:34:53 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org, acme@kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
In-Reply-To: <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo>
 <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
Message-ID: <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org>
X-Sender: andi@firstfloor.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-18 19:58, Ian Rogers wrote:

> Since we have frequency mode on events and the periods are aggregated,
> I find it hard to fully think about the ramifications. Consider this
> example: I have two identical loops, one loop runs on a p-core and the
> other on an e-core, both accessing identical data that fits in the L1
> cache. Since the IPC on the e-core is lower, the number of cycles it
> spends in its loop should be higher. A user might mistakenly conclude
> from the higher cycle count in one loop that cache/memory issues exist
> in the e-core's loop, rather than realizing a scheduler issue caused
> that loop to run on an e-core. If we detect a hybrid system we could
> switch the default event to for all perf tools to instructions, as
> instructions don't suffer from this problem.

You already have this problem in any other system from the last 20 years 
or
so which has frequency scaling. There is nothing special here about 
hybrid.

The scheduler has some internal magic to handle problems like this, but
it's probably not directly applicable to user presented views.

In perf there is also frequency mode (which is usually used with top) 
which
kind of mitigates it anyways because it evens out the number of samples
(at the cost of some terrible statistical properties, but that's a
different chapter)

Also in general people don't look at cycle counts, they look at 
percentages
which scale per CPU.

> How can we merge non-legacy events? On ARM there is no PMU with a type
> number file with TYPE_HARDWARE.

Very few people use top with anything other than cycles, so it's 
probably
not a very urgent problem.  I suppose you could push the problem to
the user with some configuration file.

-Andi
