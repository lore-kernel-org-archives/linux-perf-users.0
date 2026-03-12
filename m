Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD31F03D7
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348066; cv=pass; b=W0OFIh8FAs5OJiG7ok7TGsTrr1QHM4vwZojqO954m1NUUp3JLR+ZtdRfO1gY5Lf1CaPcpri58LzXpft3miTBeHsX93wmY3KZOASkKmQQf262+zkhPl+Q46985yAEbD6T9/6pE2hT/JpN1I+A487q7s9u1oIWSe9L44R8JprrbNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348066; c=relaxed/simple;
	bh=fpoatNdzMCHs3xZFiL8fpWqdF3Hhfnvl0M5CQWMQgLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Jf5VXogVibgxfb8IlzTLIjzfcThYEN+MVpC4INKwjN6KNxbMHxENVGiu+UgizXNJq5PWkOS/xrxIFtEB9WVTMiiputt/Xd29r50QCCTBFCo7oyXVB4pDJw2SVnYs5H8QROBot0ii76A86f3OuY2w2pFJqfB483knRX7tNZqcivA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sb9xNi6s; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sb9xNi6s"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so5555ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 13:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773348065; cv=none;
        d=google.com; s=arc-20240605;
        b=Sc6Vt5mVpOLlgMvTekhuN3Ah1ati+3SfxwXORc/ycj1rA5CEposKArGVOqejL0kfHy
         y15Ds7VylJ1U3dYUn81vjX53pH87/W918XACq+w/veXyVbJcKJ4MuZjlL3a6VrP25vev
         Y+COhBvaueRR4eOCEzW2n7XnvZLwgo+TIHafScoA892KJLqsuUQ287JSOQfFO4tb7oW0
         FDgG7ldcyzVxGdGwWbLPvIOFKrKQUoS27PD9uqdyq3YaBztU4zr/C/K9fqeOm/hOw2nK
         kuEnawHR6JTT1n3p6hk7eF91pVdoPLxycxByfTlTbO0cXNLEoP0Gb7Sj9IVoJfsDYj0X
         xGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/jdrCKmnrxb3EgLrTaWCdB7hGeLNd/TsVioKAQn6TNI=;
        fh=cJpmxUGZW19sf5IbbgbsI5mq+xxFJdiS1yMz0Gat5mw=;
        b=Vj1A7n+hQptzJZVqOv6s9b0d4iBv3CdVBppuiIc44Y4OIMdeOBjEMqNQAHBM4qZaBw
         TumwRlQIH/SzeJyD1gCrHnj1IwgSEXBlimT1V2uhwIQcQtR0O8tSw8SNY0n53jG3fIgm
         ISWpF4NDQXxJcWcJ/J61+UA7IqBjuCLdFyLr4Cqf2xfunIIOuGEefWggw/GDOQ24CF5j
         g5MnOz6T7/1r4Tq49a/gCYKngzBuoiU528T1zOdm8HUiRw9YJYCcIfkKu7yZXGIFO/ZN
         y/W9Hh+hmC9U8iJjvu+0wKxlR0zgG/iagwNu8Qck/6BlIOxftyWGMmNpXtknrIYl6hRW
         76aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773348065; x=1773952865; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jdrCKmnrxb3EgLrTaWCdB7hGeLNd/TsVioKAQn6TNI=;
        b=Sb9xNi6s5NiCdYBh54iOPW4/jhvhnmM42ZePv7l4yNPYcHrlHZc+6WA1qW1/9CJpZs
         lIg3EhE7MMml1/TM5TMd6CO6HVrGvQN19LUHciN+R2ekYaxa/DNe9CAa9w1cZy8DiIPA
         w8iVUApISP6SIlZ4tnhaFXP3AXaUrhUU3L1GUZQyHKkX/aqLNei0U9HmpAdGxXmHWENy
         hqm9U6/q1Qzdv8ckWikNK/dgZHat8snSim/7bzlt+Cetq0qiQIluBM1CTkwGGZ9W8Nmk
         z7gremhtMtrhcrgQx5/YH3ljBELclVdFpuK4DPuv6nW3Eh8+xHrQkvHJ4yrnaSrkYa8J
         xYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773348065; x=1773952865;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jdrCKmnrxb3EgLrTaWCdB7hGeLNd/TsVioKAQn6TNI=;
        b=X1R+rIGCf6MaRqfsE5yxn2nwlFOWJkY9MI5EuZSMiMt6KU5ICenanhqe8vY5jyCtF0
         ryGLyLMgW4noPJlJOsw8+0ptsBPgWryyc+nGeQp0KlglapuHBYs/hbALP16rjuE6wyOM
         2p4Pxq4C5G8csCLZYaSssKj0GszZgFqcXcLS0fdT9gk1LLupO9kJMjmqV5PXyU6mAnlB
         njwAL99tES2T59G11/1ZJt+BtYva0Ym0VvMzqqf9CHnyan1nvvoOiK7+XSES428maG01
         OCx/vWxGAV6vQb+0cO3+R5MQgzo/9GLa5586qBAX+IETisTe1uYK7/utU3NUE1LAV5EO
         ZZzA==
X-Forwarded-Encrypted: i=1; AJvYcCX5qDZ8cAFcpAzPlS4Hozyw0rlKe5YpPy6iHCbYGfTZzo3qNdTNw1mHYa+h5WWiwbphdKhlbYwnTXsQu8ctft7I@vger.kernel.org
X-Gm-Message-State: AOJu0YweEkmDokNWy0JygZHwIA03dfPgY/2YKwu48Vmiw0IieglepJZu
	Eot5k8IrTZh5KKLb4rsr8Cmy1rjHVwBAQhmnSl+XGwYLtrYqphMRA6cpvvXscLPWLeqhx8Kv15+
	UPy1LNNLLQt/UFRDhozzM3tDmGYxJpFWsrbZUk87z
X-Gm-Gg: ATEYQzxsHrZexsX1qxqB6dKWw0AuY/y8sfkYu+VFh2PiJajjmjw6eMJQfKmm+08wzJO
	+Vs1RvkgXWTpTsAsrI4o52jWFyWysJMVQ+1fcFtT0eRP12USpICU4WuC7WUMSlDbH2Yvn8AwqCC
	VzSWM3PAkjv/RDsUeL0SZrgzEL/1y5zEQJwCEgbAr1oe9Y7txs9WxjnYi/Wy0pz/Womb5d7BlQg
	o/i8vjCJnzlu3kqWXrc98XB8GZwwYNfrlqeDymG0zJH6OJCpL9/SRdsz9CsYnA7/OfAcvLQv7Ge
	bYBIo2MRVfP+3eMYmelODHEIyROHC1IELdXW
X-Received: by 2002:a17:903:287:b0:2ae:8a37:94b5 with SMTP id
 d9443c01a7336-2aecd612daemr180215ad.13.1773348064787; Thu, 12 Mar 2026
 13:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207082428.1742209-1-irogers@google.com>
In-Reply-To: <20260207082428.1742209-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 13:40:53 -0700
X-Gm-Features: AaiRm50uWaR0OYfAazbeJ1o2CEAsb8ifdFzaU-NNzQZJ54kkN2PCuXCLbM53sBs
Message-ID: <CAP-5=fWUk4pwHpgSQbrCuXKDu_wZDjmLd6kbtQ9zqCkNdJZGmw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] perf tool: Minor code clean ups
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 12:24=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Remove some unused functions, files, etc. Reduce scope of variables
> and functions. Constify arrays in perf.c.
>
> Ian Rogers (5):
>   perf symbol: Reduce scope of elf__needs_adjust_symbols
>   perf dump-insn: Remove dump-insn.c
>   perf tool: Constify the command and option arrays
>   perf bpf_map: Remove unused code
>   perf record: Remove unused cpu-set-sched.h

Ping.

Thanks,
Ian

>  tools/perf/builtin-record.c     |  1 -
>  tools/perf/builtin-trace.c      |  1 -
>  tools/perf/perf.c               | 12 +++---
>  tools/perf/util/Build           |  2 -
>  tools/perf/util/bpf_map.c       | 70 ---------------------------------
>  tools/perf/util/bpf_map.h       | 23 -----------
>  tools/perf/util/cpu-set-sched.h | 50 -----------------------
>  tools/perf/util/dump-insn.c     | 23 -----------
>  tools/perf/util/symbol-elf.c    |  8 ++--
>  tools/perf/util/symbol.h        |  1 -
>  10 files changed, 10 insertions(+), 181 deletions(-)
>  delete mode 100644 tools/perf/util/bpf_map.c
>  delete mode 100644 tools/perf/util/bpf_map.h
>  delete mode 100644 tools/perf/util/cpu-set-sched.h
>  delete mode 100644 tools/perf/util/dump-insn.c
>
> --
> 2.53.0.239.g8d8fc8a987-goog
>
