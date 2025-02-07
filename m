Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF5165F1E
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916204; cv=none; b=jNfGvwj8kaKhUSaJnoytNzIOJPQSEhmcxV1OOWcFzRKE7v2ldOotXdBC99kxNEOx77Xn7u0fTZq6lbi8377vCxKw6yTnH3CR0PPn2d8Pl60UOapKDYa8R0zLNHjsKosU5rtTxYWMIwUteSDiLR2UmCwCUADbRmE7R7EP+QPfqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916204; c=relaxed/simple;
	bh=fLb9khQwGE8+zL8151VSKfNXsibt5HIsk7Aq5cONrsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdIEPy/IKzdaWOMdn9YsdWr3aWNs1nnPoeV+je6IJjnhmgRHa0ZPlwigBGw9Z0HEBdVCVXDwZqI/UK7CsttWuubnyyeK2SLJBnzkHKLs43uuM+IDJFUBDwZnsY1OmWvYby8ajjijyFUsyvrBwprwJaruTTXtF3maUhiQNBPJpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdOrCQ82; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdOrCQ82"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30761be8fa7so16723091fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 00:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738916200; x=1739521000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGw4nnlMoBqh1tMqxVCn4U2ppLWRUSnglhWch/zqRJg=;
        b=mdOrCQ82Ks4n5yAsVYMtAH9mG+XDV0/B6MU982WWghlOi3yjBlbvAoeCQKjHh7t5jw
         HrqtaeCk9w2I6xCxTo6/BxzkIJ8IB5/4eLiGarMVy0rkBXzlbsrhFEGqvMU/p49vmJwh
         VeNNthA3T0cnT+Yagiu43j3NihTRgS+LEv3PaopgOrEFdTb3VJj7hDVyNcvAIpEt8ftL
         fW6oK1JxcC2zBNBCmKdvSD3oT9yE7vTFa1kaQHj5HPKKrd4u49isz9N4Loa7RYXgUjoi
         N//jkqzb2Htp0klHsjVDR3Rn5/kJKUGgxx/zLPCopgEhxzpw9E7BVfhOnzK88V21zn5/
         n9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916200; x=1739521000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGw4nnlMoBqh1tMqxVCn4U2ppLWRUSnglhWch/zqRJg=;
        b=QuiLLA2ZqkG1EsDqFN3aZhwjr0IPMlwj8GAArL1f8sKdM7NWXOZb4ZZES7NyOexVqH
         Vrp1qWmPLSuTcUmLgLnh57j6qKcW/imXlmQFUhs0lpMsiUgdEh8FdIxZHWlC00jEc5T4
         /aLPkU9eyddC/HQ+mEUTqucdqOJ1Yhjvm2diUwXCTXmyVpspaSJ/u20UNoRCMaUwL6QL
         +ofrdSEZiBZvRwCHK++IWSokXckiEQ7bwyXIxSZcc/C2RTOL8YAtuUn7dkJ5WRPEDf2O
         HOTr/+dwMI6KTWG2OUUSEEuw4DEsqn+qvy/YF5W88hOPE5WEQ3KZZOcKjDOn6dsLwW8s
         rk2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjBA23efOIhI2UVHLCl8akQR7U3+sG8FZWXgggjmdlJ3grN3K4U6IWKOiIoSom/iwKlbVeWCFPZrn/uNjAx4RW@vger.kernel.org
X-Gm-Message-State: AOJu0YysnLQsIerMl1/ZfxevW7vIqRCStMgnYmHJNYSs5wi8iX0xbMre
	XDORjIT1rOEOIxZUMPG+e4H3qPta34Csw2MOF4B1L9pOva5AfkeUpL9+S+SmhhKVIg5XE7CZX1m
	gE8nKzutxtXYr8Q5hR+uzA+huRecGdlyzSPyM
X-Gm-Gg: ASbGncu5ogO2eLT16cXHy5bD8cS176TsgWBUSLjwOA7ptZBXVVqYObWoXlRAHN62rAl
	gp+ZvW/y4Il85Iz0kv1A+AAGK2ZGtjpldj50pqq7MFMvSc0iCbNwoGRe8YkAbfTpVKimfEYPwci
	IgKDA9gTvoHmeQAQYusIBECRPAYmM=
X-Google-Smtp-Source: AGHT+IE0UV5pVv79c7iEWeIcAn71d1qGowlugGz2XOcYzcozNgATdkOwflSlk0EFyY+0plEBfab0/tOZDdjTit22ut4=
X-Received: by 2002:a2e:b8c3:0:b0:307:8fe0:f336 with SMTP id
 38308e7fff4ca-307e580c4b5mr5861911fa.15.1738916199866; Fri, 07 Feb 2025
 00:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <87ldujkjsi.fsf@linux.intel.com>
In-Reply-To: <87ldujkjsi.fsf@linux.intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 7 Feb 2025 09:16:28 +0100
X-Gm-Features: AWEUYZnNemwiE1h3hWO3Y647F4u1Ba9x8XM_uOnfP5YXQZcfHD4UyBOc8rdzRYg
Message-ID: <CACT4Y+awFXT2j+HMeAy2RKnoBzb--+heFzJUoBZWp9iJevy1Dw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > There are two notions of time: wall-clock time and CPU time.
> > For a single-threaded program, or a program running on a single-core
> > machine, these notions are the same. However, for a multi-threaded/
> > multi-process program running on a multi-core machine, these notions are
> > significantly different. Each second of wall-clock time we have
> > number-of-cores seconds of CPU time.
>
> I'm curious how does this interact with the time / --time-quantum sort key?
>
> I assume it just works, but might be worth checking.

Yes, it seems to just work as one would assume. Things just combine as intended.

> It was intended to address some of these issues too.

What issue? Latency profiling? I wonder what approach you had in mind?

> > Optimizing CPU overhead is useful to improve 'throughput', while
> > optimizing wall-clock overhead is useful to improve 'latency'.
> > These profiles are complementary and are not interchangeable.
> > Examples of where latency profile is needed:
> >  - optimzing build latency
> >  - optimizing server request latency
> >  - optimizing ML training/inference latency
> >  - optimizing running time of any command line program
> >
> > CPU profile is useless for these use cases at best (if a user understands
> > the difference), or misleading at worst (if a user tries to use a wrong
> > profile for a job).
>
> I would agree in the general case, but not if the time sort key
> is chosen with a suitable quantum. You can see how the parallelism
> changes over time then which is often a good enough proxy.

That's an interesting feature, but I don't see how it helps with latency.

How do you infer parallelism for slices? It looks like it just gives
the same wrong CPU profile, but multiple times (for each slice).

Also (1) user still needs to understand the default profile is wrong,
(2) be proficient with perf features, (3) manually aggregate lots of
data (time slicing increases amount of data in the profile X times),
(4) deal with inaccuracy caused by edge effects (e.g. slice is 1s, but
program phase changed mid-second).

But it does open some interesting capabilities in combination with a
latency profile, e.g. the following shows how parallelism was changing
over time.

for perf make profile:

perf report -F time,latency,parallelism --time-quantum=1s

# Time           Latency  Parallelism
# ............  ........  ...........
#
  1795957.0000     1.42%            1
  1795957.0000     0.07%            2
  1795957.0000     0.01%            3
  1795957.0000     0.00%            4

  1795958.0000     4.82%            1
  1795958.0000     0.11%            2
  1795958.0000     0.00%            3
...
  1795964.0000     1.76%            2
  1795964.0000     0.58%            4
  1795964.0000     0.45%            1
  1795964.0000     0.23%           10
  1795964.0000     0.21%            6

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

Here it finally started running on more than 1 CPU.






> > We still default to the CPU profile, so it's up to users to learn
> > about the second profiling mode and use it when appropriate.
>
> You should add it to tips.txt then
>
> >  .../callchain-overhead-calculation.txt        |   5 +-
> >  .../cpu-and-latency-overheads.txt             |  85 ++++++++++++++
> >  tools/perf/Documentation/perf-record.txt      |   4 +
> >  tools/perf/Documentation/perf-report.txt      |  54 ++++++---
> >  tools/perf/Documentation/tips.txt             |   3 +
> >  tools/perf/builtin-record.c                   |  20 ++++
> >  tools/perf/builtin-report.c                   |  39 +++++++
> >  tools/perf/ui/browsers/hists.c                |  27 +++--
> >  tools/perf/ui/hist.c                          | 104 ++++++++++++------
> >  tools/perf/util/addr_location.c               |   1 +
> >  tools/perf/util/addr_location.h               |   7 +-
> >  tools/perf/util/event.c                       |  11 ++
> >  tools/perf/util/events_stats.h                |   2 +
> >  tools/perf/util/hist.c                        |  90 ++++++++++++---
> >  tools/perf/util/hist.h                        |  32 +++++-
> >  tools/perf/util/machine.c                     |   7 ++
> >  tools/perf/util/machine.h                     |   6 +
> >  tools/perf/util/sample.h                      |   2 +-
> >  tools/perf/util/session.c                     |  12 ++
> >  tools/perf/util/session.h                     |   1 +
> >  tools/perf/util/sort.c                        |  69 +++++++++++-
> >  tools/perf/util/sort.h                        |   3 +-
> >  tools/perf/util/symbol.c                      |  34 ++++++
> >  tools/perf/util/symbol_conf.h                 |   8 +-
>
> We traditionally didn't do it, but in general test coverage
> of perf report is too low, so I would recommend to add some simple
> test case in the perf test scripts.
>
> -Andi
