Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E444062D
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163932; cv=none; b=FB5CHQ6rU0RTK7zRW/ib4amF29NbZiR88zcb17aaAv9RmXYCGecrFMs5g9Z2J++ARdwxXzvvt7/PIK9gE6VRbNxSDrqbJhabh4wAHdXmhRqkextKWfhNxoyum5V7ADjhOj5r3XcBXKDgRnYleQ6FENKrpOpiGYtlqNTRC6CePBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163932; c=relaxed/simple;
	bh=hk839zjCyZVZCvGzHzk1OczIXwLj5ns5KxczH/Jy11k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTm/V7SQBvmQFg6izajoU12NWX3Ayal2UcPisrTjxpqkyEcBXLMtKrprQnOl5QzoEmA+cFYmjD9YujhQrKmrcsyEKQm5ULiFTXZgnKuxNNwn9sp351glcoWG/CobFet+3oI+hBDaggUxa86hcKRR34XVb9QdmAW93378FeKSevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=oSWx8YPg; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="oSWx8YPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1787163927;
	bh=hk839zjCyZVZCvGzHzk1OczIXwLj5ns5KxczH/Jy11k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSWx8YPgYQtkrc0Y7TWuGUzKGgqaxaHZaDr19+DJWkYPySFy/WXtr7rLy4YYq458v
	 3q/gCCk+yItKI63GHsSEBqnYrt8+Lho8pnj8GgRJnWyHyRfnZGa9lqgJt8ptk9xvtp
	 nERxV9CdXeChYqPcknVon2/zeuNvWsE4XB0Qf+2M=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 0F2735E89E; Wed, 19 Aug 2026 20:25:27 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:25:27 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org, acme@kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
Message-ID: <aoX1F_V1pS9VCMjF@firstfloor.org>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo>
 <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
 <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org>
 <CAP-5=fXLe9tqR7wHh9auRxqX82Fw6zYh1EoTOXjPhOXcRXB92A@mail.gmail.com>
 <aoXVrD-Qbhi5qd2D@tassilo>
 <CAP-5=fW6a4MQurwVeL16WWFnO0VQPRm992M==DP9zVza3wgdfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW6a4MQurwVeL16WWFnO0VQPRm992M==DP9zVza3wgdfw@mail.gmail.com>

> So I think we can add a json field to indicate mergeability and set it
> on legacy instructions, perhaps things like branches and
> branch-misses

But the current simple check already works fine for them? 

>. We can also detect a hybrid system and switch from
> cycles to instructions as the default event when merging is desired
> (like in perf top).

instructions rarely gives you an accurate breakdown because
the IPC varies so much in practice. cycles is a much 
better default.

The other things are reasonable I guess, but all not really
needed initially.

-Andi
