Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F1341051
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569575; cv=none; b=ZG8zKdZCAnVUXunzF+WEdzUYVzfb+Mlqd2qywh1B83Efn/y2cUOVPGwR/PZeBnFg40L7xvjSY0LyLQhLFN5AzgAQ5lPkBLT6H8Y6wUJ6rxhD+qf7Kr1geQ65m/K0s1h3oVgFdsywxW6p7VIfcfpHj2/DgLNdVAymytze+IfhOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569575; c=relaxed/simple;
	bh=kp8RopAHLbKeFSiA5P+Jv9nHnOWt5EBoxB3Qph8v9B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF4USJjr3UOLgM/3wKg/O8UwhJS+pt+it4oR38oYJKNkmkXLqeuAPqhAfa3lkZjb2ZARP6nzWuSSkpIr2TQ2UcYyS55Lj98aVnGOzfvUn5K176jiibA/fxFQqyMzqzHNFzSBl+7yVMOGZebodvgJZmztntkzUUvPYJES9MoJsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZS0rZ8tn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZS0rZ8tn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29852dafa7dso212175ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763569573; x=1764174373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp8RopAHLbKeFSiA5P+Jv9nHnOWt5EBoxB3Qph8v9B0=;
        b=ZS0rZ8tnVNuf3pNdiS1ND+pbP/6BbFxNiGVQTplbTbV2guGHrn/V56BGCQZyHt5zUD
         /dcebZz8+2QjGTWHLs3Y7KvlO2bIcy4KuW19ayJyEyVhZnSiTHsrMIzFSW47PBgc+T3q
         M04nNSSjkKn8JjsRnq+NC0uxKDgYwdalKYqlh5/c+96eGaJ0CpTowN2D18Nv9VsoxXs5
         mdnSDtaI/3YW31IIbK2+I4OG7DK7Jf93VCtPyf3jbP0CxaKemDGQvP2KIzm7+V2hkdkG
         FDsOhd91Ij3WjKGUljlsL+bRHWV5nD19QUqw1GT/1RjCwHImJ2bp2znJKQLbk3DPzHMV
         2WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569573; x=1764174373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kp8RopAHLbKeFSiA5P+Jv9nHnOWt5EBoxB3Qph8v9B0=;
        b=Ns38XFvzJgG8RtOz5gPXesTo4gmNrMqvKaCjPy7bUA22EE0SmQrdq7lem65dWfRLKC
         60oV3BOJlBTDicrwu5EcVwVrv3OlyCYmr3KbXOM0tVc1S/7iUmgqFQIUim70n4WTLQsG
         ZPzq4k8g1BMPgQKhMrVsnTSfEVP0PNbk3r3CH8rEP56brE1FrsoeSl8C+1rl2REELbaq
         cNjakPdMBSTGUMZEYh/ZACM4MtOzhrzaxiECZkNf2HuTvQ6bPuP1Qb1EDbjkz+Yjx5wG
         bAW79lUUG+6bsVHV+BMDQnPA/0jnyEh9iG1ej3KCsWtH0ZFm8yf8DqZq8oglO2lhEp9G
         kHOw==
X-Forwarded-Encrypted: i=1; AJvYcCXtnryQOgJ7vk93azbxlrg7RJNODAEzXRHwqbOIX9NrF9rw69xlowycwp3jUfNT0qePka86zidIyJBeDiFOAS6+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Vjlnn7enLDJtdl/pNqNhjnftdejpxRZrDDpbvajRSemNYEcg
	USvTrNYklJQjrGKoSxnL6kEurc3M8h9wSzJL73MZYVQpadzVFa1Ogj4X5hB8HmCYHIVX02pkcOe
	bjoq0rW1beHK49WkONYjdA5gQAnSxcgfGXMinc0Yq
X-Gm-Gg: ASbGncuiy6l5/vi3NUFRN5lCsNHr7y4l+FzeQT+ecQy/+Y21hxuc/J0/TaCe7u6ZNGP
	ZHeC3T5DJ5ROC9zOZAdszOUFJkfVFAp1b96HCq9IQTVSd2FfM45rrLzLAqBls8WoOTl27I5OAnY
	lj8qixoJ7JW8tWrYXSbflPo0Hfq6Fol8H3Y7ZAGr2EcfmCUxMlYhE30F9nHVhn8dnQOIWiX+9PD
	aLyZTFMKfAMysEuzwRJrwL3WR1eSr2Q/T0WpnUKpkvUvOK1XUUiuZJxpjdUVaoLC3IMqhD2RucW
	3cBAHwJTf9J4aywRAGh6g5kUTw==
X-Google-Smtp-Source: AGHT+IGNF1WWmbuh7n0RWPz28sKc389KlQJI2uOYQdvOkTmGe79SR5mFlXGCctKc0qC1gsu+Qjj68wdYArtds2QBnhk=
X-Received: by 2002:a05:7022:e01:b0:119:e55a:808c with SMTP id
 a92af1059eb24-11c8ddae890mr115565c88.9.1763569572587; Wed, 19 Nov 2025
 08:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118211326.1840989-1-irogers@google.com> <20251118211326.1840989-4-irogers@google.com>
 <aRz-6jQf9GH4JROi@tassilo> <CAP-5=fWSXboT2jEYtua_N8AnaXc0SUeoC2iBgxSz5QRF09bfoQ@mail.gmail.com>
 <aR3kN1GiKki4AO9b@tassilo>
In-Reply-To: <aR3kN1GiKki4AO9b@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:25:58 -0800
X-Gm-Features: AWmQ_bkSE1E8AJpK_KQsWLifNM-tu0frIr_JeGj16ryd0iOuSJjZ_3mfJM1iVYs
Message-ID: <CAP-5=fUvsF7RtLAKaMwc28CeSEOJ+j0gVwvQN59moOnUS=kWVg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] perf stat: Add no-affinity flag
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 7:37=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > Ack. This is only adding the flag to perf stat, are the storms as much
> > of an issue there? Patch 2 of 3 changes it so that for a single event
> > we still use affinities, where a dummy and an event count as >1 event.
>
> Not sure I follow here. I thought you disabled it completely?

No, when we have `perf stat` we may have a single event
open/enable/disable/read/close that needs running on a particular CPU.
If we have a group of events, for a metric, the group may turn into a
single syscall that reads the group. What I've done is made it so that
in the case of a single syscall, rather than try to change the
affinity through all the CPUs we just take the hit of the IPI. If
there are 2 syscalls needed (for open/enable/...) then we use the
affinity mechanism. The key function is evlist__use_affinity and that
tries to make this >1 IPI calculation, where >1 IPI means use
affinities. I suspect the true threshold number for when we should use
IPIs probably isn't >1, but I'm hoping that this saving is obviously
true and we can change the number later. Maybe we can do some io_uring
thing in the longer term to batch up all these changes and let the
kernel worry about optimizing the changes.

The previous affinity code wasn't used for events in per-thread mode,
but when trying to use that more widely I found bugs in its iteration.
So I did a bigger re-engineering that is in patch 2 now. The code
tries to spot the grouping case, and to ignore certain kinds of events
like retirement latency and tool events that don't benefit from the
affinity mechanism regardless of what their CPU mask is saying.

> > We have specific examples of loaded machines where the scheduling
> > latency causes broken metrics - the flag at least allows investigation
> > of issues like this. I don't mind reviewing a patch adding real time
> > priorities as an option.
>
> You don't need a new flag. Just run perf with real time priority with
> any standard wrapper tool, like chrt. The main obstacle is that you may
> need the capability to do that though.

Ack. Thanks!

Ian
