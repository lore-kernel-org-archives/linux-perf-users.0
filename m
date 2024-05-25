Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF75487A5
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655452; cv=none; b=g+zUFLLJL+3FEtU0opsoHBEUTdxsD4SCwHdEkxcBp6fRzRu5nfoWAr9Ly8XSEq+QIwZZ/Vmt9Vzxmj9WKjAvm/g0aTPN7NzYVnX4h2UUdXOEzZuudn6MYzRsEFCiJAmqucQ1EaJLHrmsPfNYKfNWFuJDUo5zz++CaItVVir4zN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655452; c=relaxed/simple;
	bh=WCBqLf8xWl7QK8aivI70dfgxab6wU9Nc6TJLS8c8dhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxeBIWiRSbqJSAaSRt2ZHph8lSEXkmq2sK+FAfVkjWPbBd9WB3IZBmtawkTy/wCjvA3XbPR1aef7JmrMEZGkxVNksmeUthkft3QqcGpDgzmY6cjyO0+zc8OGRs7mKLJyCFKDHPXBFIcfyGMfk37uOIDAf9N1490LiqDOcjuHLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MPPvh6OP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MPPvh6OP"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so75256111fa.2
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716655449; x=1717260249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XeTI2+I0Yf5YeTzSjD68RcTudZ1kraGCCr7BX0rvX0=;
        b=MPPvh6OPN7mLZJGl7COmBbmuBgT6bCMhXfDnkiHpFJrLNA4L124hT8yWCk9kZxA+Du
         7vtVpQS3LjsJRT/Slf857+D7Vd3WiTT6O/gCa/p4Z+FmWLCGXgS2iIDDfD0uM7rRyz+k
         muVGTAlu9WPdsYGBH9H2dEh5nJRRWoRYglj58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716655449; x=1717260249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XeTI2+I0Yf5YeTzSjD68RcTudZ1kraGCCr7BX0rvX0=;
        b=kHkAcWaqQI7qz7PYgTJjMQYpGaOM2ex2m3ZdKDMysK+AozeeEeoC5x266Zmwnh4V/C
         YpUkJSFgFOzz9gCcX/2eGbK02kCphECM8L5TW8r2SM0BvAY78Tu4xy4K0w0HZuJgOd+u
         DealqCZWqHmalhyX7VoEfhjmlCZD+sV5kVgM0GNBRxDSLHMh4EdpWY8UUnQt9WNgYrtO
         Tq6RUJm+JvOr211+y0ns/LLfvMczr0p0dp6mZovVLo7Uubeef5HbHbRxe66MjOg6wLCG
         idFjNObUYtVBpmhoyudTyyVWcwoyH0MSDITGojYvvLKU/Enn54lH5DAb39MyS3OmWNy6
         Uilg==
X-Forwarded-Encrypted: i=1; AJvYcCV9XZ7BVj3lo0+PZXgNkrL3jPT5W9fJYHBblqufy2BWJZnxto0FvHhuN1BYbnHdYhalb0qDshdxdk5aHmfi5M0bQXB2em0oWgHgyejtnshvLg==
X-Gm-Message-State: AOJu0YzydUvU+zGOg30YG3FYN8wAaCymtEAk70G8/4QoF2vOrw0ZSfB9
	BIXhuyjbByL4/Iqiv9LXTrUOvL6IbyFNxST+wtlN2lvLpdBl3RMPMNTjqJQPL0Q+CKrA8rF2bdg
	WyJzQaA==
X-Google-Smtp-Source: AGHT+IEao98dL44XEtPBvy+bLBPPksdp/QznKJgw11MXBFwOYwhmlsrXnCZEZ+rSgpHx+T2h8Zi5JA==
X-Received: by 2002:a05:651c:1311:b0:2d9:f68a:d82c with SMTP id 38308e7fff4ca-2e95b28b17emr30908121fa.41.1716655448845;
        Sat, 25 May 2024 09:44:08 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bf1b13esm7828721fa.130.2024.05.25.09.44.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 09:44:08 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529661f2552so1806869e87.2
        for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 09:44:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNo/xtj1bkuPGrndAkCiqzYBf5biSJxRGsxzxQmiTjeRi3xXiOvDoUtzdZLbvimqbF2u6nqoc2UaTDj4hzpnTqgSd/ihYJtSzk50W6qTPqEg==
X-Received: by 2002:a05:6512:1112:b0:520:98ff:5554 with SMTP id
 2adb3069b0e04-5296547aa0amr4212947e87.30.1716655448041; Sat, 25 May 2024
 09:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com>
In-Reply-To: <20240525152927.665498-1-irogers@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 09:43:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
Message-ID: <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 08:30, Ian Rogers <irogers@google.com> wrote:
>
> PMUs other than core PMUs may have a 'cycles' event. Default opening a
> non-core cycles event with perf record can lead to perf_event_open
> failure. Avoid this by only opening the default 'cycles' event on core
> PMUs.
>
> Closes: https://lore.kernel.org/lkml/CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com/
> Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
> Signed-off-by: Ian Rogers <irogers@google.com>

This makes 'perf record' work for me again.

   Tested-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

             Linus
