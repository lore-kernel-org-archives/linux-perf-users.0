Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC81FCCF8
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157412; cv=none; b=bNc4UM3ejXaRne5fx5c3cHCMexDQMDO9BcGUcmRY8VUdzP/FfoNZ9dYXsxHkOgNI+65x3jW42bA6fNFQKKQrGa6FQdNQEMDsOMefZ5I4hAauTd8wEuzH+U/+RDW36ptJ/WgF6MtbJ+8VFRLrk+Y0BrOZmFkAom/0fJm2vdk0xV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157412; c=relaxed/simple;
	bh=hPeudKWhQ4RbVYkTTt7D3cuJu5GzpC7mlVjqr+LrW3E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ctsaXihEk0OhbeNqB+woe+Ud4u84+sSxH/I1XaYJqKsXoB0DKudchnJAvwE68ir40uhcSGMTG5mmg5UWJEZqXWKWId1aEkkoHL/LOhTaHwrLSHaxRa/sghF7uaIHLu5VIyHvBglpsNIYrTqhmL1ITMioImS1YVgpoiV5ymLQ4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=OeTCyz3W; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="OeTCyz3W"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fae04a3795so16580106d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1749157410; x=1749762210; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYv/BBqpPR/j3uwNGj5iM8dPA3cPsdOTHli866hFVas=;
        b=OeTCyz3WbpKInG3GBWQDdzDtcMCYGK0EYkMwYCJc9Rd6CgJfTkeiq1UAdXBRMpt19P
         km8kWCtwLIzf9EI9tUEX8SCvth1OAoKDFVuRLzxCWoWoa6dlSgQm8pSywFnKZ1IgWSP3
         ZRTTge0LLRFXwjkwWjlohHBJ1NxGRJFQpoU5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749157410; x=1749762210;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYv/BBqpPR/j3uwNGj5iM8dPA3cPsdOTHli866hFVas=;
        b=jGY1f5FZEXorBskqq+aqZJ4o60g5EeMmn3mrh1cUhMjdU/ggWVrj6PQvq4EmOkaqjC
         pE0PtGZrei6U+qLBPVt8GZuKp0aohPM4zU9RtWaMgYHwgB3oMK0TvlkDSx45ymt1Ru6Z
         hgphV/4RxbLp+Nnf0tBqupkWactE7KTCcZKJUsT3mJLuC+F2hrD8lMGEYNVHQEJqQNBY
         v8p7e0eMJK2KDXGy1OFEpdsqMCUG4F4UsADezxcMpm5p1PwXORXQGi2RrKT6tML2zTOF
         yWGrfssVjF2/suxtNGZVODnejEOSF0fzNGD/yBPQTcJ4z0i35YBPqWf1MrVAZFVukT3c
         EFPA==
X-Forwarded-Encrypted: i=1; AJvYcCXLcMgEswxg81rvwuZV9V0vMQl+HhNFLrK/1+ShCEHcRgj/ZCf1+BFCsPJtGMeoWo1RIklqzBzZOWr8J03Q6zPm@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUNaqC/0xQ7sSkfwcM9cyoXnMRxEdxXp/VjvPbPL+mPyjyhzX
	HXuhoshPoQIaM133QMzc0TTY0kxooHidmzK9y1WkpEnBr3pVvOX+V6Naci7lcRgwZw==
X-Gm-Gg: ASbGncvzByibvodaLaMXNuBp/huuDbwIqOh9bha8DOELcWq4l/az/W5NuC9avTvKnyk
	SY5X9k/dZDXRAe5zXlI5nfpaM2t2rrx3NsuwLQwN+gJb5Cz/q0urBixN15CkORESo91ExVg4kiR
	AewCuiO9mFX42JoahIab8zkeMsgPQlwPXBF8wMUaDPxq8eJF4/twXHnj+L3ec5LyhfbL+IDt9Mp
	NK/w+EBkFtwGiVLzVZ0oob06CpmxJ9cqDXmGp/dnKLu6HhEgTpsRxffrY78Xl5vR5l6xRWsUR0P
	B9JLWOmNJMsgkhZtDiXV4B4XjpG3NTPhtYxxxLMiPtgLFnepyo1c6YKmyNiNcTTFKAe0AOQ=
X-Google-Smtp-Source: AGHT+IFbnGNEIN/7Iacj9GEJZ/AzfVbRazHzR8ojLNpScIs9K/r0gWT4rEk0OkKS9cjVlYMEz1VS7g==
X-Received: by 2002:ad4:5f0f:0:b0:6e4:2e5f:c03b with SMTP id 6a1803df08f44-6fb08f655f8mr15482596d6.22.1749157409918;
        Thu, 05 Jun 2025 14:03:29 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b366f5sm500916d6.117.2025.06.05.14.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 14:03:29 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 5 Jun 2025 17:03:28 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [perf] fuzzer quickly crashes kernel, possibly memcg related
In-Reply-To: <b07f0716-c335-4b6d-bf49-26dd24015d10@linux.intel.com>
Message-ID: <bbd92696-a413-5440-eb65-e2caed0d6a98@maine.edu>
References: <4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu> <b07f0716-c335-4b6d-bf49-26dd24015d10@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Jun 2025, Liang, Kan wrote:

> 
> This should be a known issue introduced by
> 9734e25fbf5a perf: Fix the throttle logic for a group
> 
> The patch can fix it.
> https://lore.kernel.org/lkml/20250604171554.3909897-1-kan.liang@linux.intel.com/

I'm testing with this patch and it does seem to fix the problem.

thanks,

Vince Weaver
vincent.weaver@maine.edu
