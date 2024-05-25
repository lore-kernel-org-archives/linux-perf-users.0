Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885FEBB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600736; cv=none; b=Vw5jM0flmVMZdV2rfxI7pu6njDxAVqH/vhuZHjlZu/zjcs53HIXtdHS5M84y/VR1EJIQB0bsVZdnqnGBiaQue/WkN59iFyYWqsD/b7s0+J8ei5oUI4X6MqsEB6/O3qyT/jkSVZUuG3ncsn+X94yK+HCaynKv8NfTiAFT36vfwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600736; c=relaxed/simple;
	bh=AmRb1euoDS4vvG+sR3/5zbY42oCpsiLFEgxly6UEdkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mj/TsnP6YYx3f4oZJt110o5l/deAgFBsvGE0HgIGDwDpNokBKwxLlKIaoZVMhDfEpTqgLDwt3suWol3bUhx5h8vggjhu95XkLKspwiPo5nLXhphELf5MgEebGyZd2IaXj+suHPQqoQFyucz9GlpP+2l5AFzNaB4yd1jpxUoGvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fDzFm0EU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fDzFm0EU"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5785c1e7448so1219174a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 18:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716600732; x=1717205532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAjYvK5/+oIgbwyHngh2RKpRp6/A9MjgsXDVBo21WwI=;
        b=fDzFm0EU3tc7r+wsRiuXVWRjXycqavkGDuWM7kJ98E1MUBO9lPET9Q7oxmEUAmC+H2
         5jSfJkSmy/R5MzxVVMF0JNGBOEhvGlUkh2frEN1fsPMqZfjLLFKmitYN0POHdZoMHneg
         aty9TOQDX0SYW+he5aksC7lGtmjWRsugIlpwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600732; x=1717205532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAjYvK5/+oIgbwyHngh2RKpRp6/A9MjgsXDVBo21WwI=;
        b=kjziRViIFp5fFIJaLPgQUgXghHM+abUirlxqYVXiW0lY9mv3HidB+MZmv7sDMoga7B
         NzxjON4NlfNO8mtczc6391jXM9Cswtrya7P7wJki0kfZZLeZBHflnkFYAfE39CYsNuqQ
         aiEKDVbcC2jD6vOBVHTzwyjq+5U4tA83X7/CzJUPtIqW/URGNWVNDxrFI5vEwXCwI/07
         j5mSIlhwTYgGa3cfE6/8z0Jq+KUpbzrBLiUMYQfX6fxYsp4qPnQHxBI9VEDSbPxx3xJo
         DlQfb6yLxSpjbDylpKiUjNSWJCWh6wdbVW7mpIOVFE9e83VzIx+22VKHMfQkFlH7lwN7
         kqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1rjOicHy/BJ00L24xajE5IX/nYjQyXwozdAMoIRiWxeIWgROrZbeOjfrjvEcH/trBfVD6ckkNDw+Ql6vsq94eF1wxUYuBXR+ljyYexs5wdg==
X-Gm-Message-State: AOJu0YzuPzhspVw47f75VevqZj7qfqKx5IkGUznZo8WnGa9Kk4qltUj0
	kajBgIYgMy3TwcJWXhbqWJ9mriU/2wu+4qS3KRacqb++nZ9P01F8BLA4+H//+Q2SqqqSFeZE1k8
	zUKoXvg==
X-Google-Smtp-Source: AGHT+IF1luc8sMNarwcty1B+8vCOpsLI0LjfbbETk7LnZLvkMxQM8TK20peBDC2SXpmDEGZmuwdWFg==
X-Received: by 2002:a50:9eab:0:b0:572:a123:5ed0 with SMTP id 4fb4d7f45d1cf-5785195c826mr2531140a12.21.1716600732184;
        Fri, 24 May 2024 18:32:12 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240df42sm2498120a12.53.2024.05.24.18.32.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 18:32:10 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso136302366b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 18:32:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkEuKOMmu+TrN8B83aTM2JNsfrM29kbHvpPks4wQq1d+kcVtfFwENdUqAQETBKfLfN1Gk00mjki1gV/z6mw/ugc9yJfcvOUbAfNz8ta5Adiw==
X-Received: by 2002:a17:906:55ce:b0:a59:c3dd:db2a with SMTP id
 a640c23a62f3a-a62641aaf08mr236390966b.11.1716600729273; Fri, 24 May 2024
 18:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org>
In-Reply-To: <20240521192614.3937942-1-acme@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 18:31:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
Message-ID: <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 12:26, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> perf tools fixes and improvements for v6.10:

This actually broke 'perf' completely for me on arm64.

With a 6.9 version of 'perf', I can do this:

    perf record -e cycles:pp make -j199

and it all works fine.

With the current -git version, when I do the same, I instead get

  Error:
  cycles:pp: PMU Hardware doesn't support
sampling/overflow-interrupts. Try 'perf stat'

and after trying desperately to chase down what went wrong on the
kernel side, I finally figured out that it wasn't a kernel change at
all, it was the tooling that had changed.

I did a 'git bisect', and it says

  617824a7f0f73e4de325cf8add58e55b28c12493 is the first bad commit
  commit 617824a7f0f73e4de325cf8add58e55b28c12493
  Author: Ian Rogers <irogers@google.com>
  Date:   Mon Apr 15 23:15:25 2024 -0700

      perf parse-events: Prefer sysfs/JSON hardware events over legacy

and very clearly this does *NOT* work at all for me.

I didn't notice until now, simply because I had been busy with the
merge window, so I hadn't been doing any profiles, but the merge
window is calming down and the end is nigh, and I just wasted more
time than I care to admit trying to figure out what went wrong in the
kernel.

And no, I don't speak JSON, and I have *no* idea what the legacy
events are. Plus I'm not very familiar with the arm64 profiling etc
anyway, so I'm just a clueless user here.

I *can* confirm that just reverting that commit makes that trivial
"perf record" work for me. So the bisect was good, and it reverts
cleanly, but I don't know _why_ my arm64 setup hates it so much.

             Linus
