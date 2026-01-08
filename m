Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43045C0B
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911456; cv=pass; b=PxtybeoGjTtV7bFPBEY95r9MIaDtgk5i8ayLtjSMPctpLeUB5V6Jqq75RvUPzeyZcvc0DPxR47RBrs+O9RBfA12UyH+yGleHTs6t0lWGmFL6ejpGGw3HXEE710KsE1Dl/gXJkVtLx2SndfIH+oM3aG6YxAC0ov9Q8SuNf7rIpZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911456; c=relaxed/simple;
	bh=3trsI/LvM4A8RL5UEl4yqhWqWAACPAu3ScjYj+O260I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPcfpjdC9/eMobxgbl18ixCkVfdicHlW2D8H2ADxs1ZbbqSvLePdvSw1UOtd0E7ANV8A0gjmLycGAsqlYw4go/jAeEqpMSe32yPtiyOAszOGhk08bS1bP/9WtlTfW7KSeU23gaZln/MTPjtaAki1BqEyk3ELy0htaZYnAHYIYX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebVw6w97; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebVw6w97"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a35ae38bdfso11525ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 14:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767911454; cv=none;
        d=google.com; s=arc-20240605;
        b=RyZp/E3WajxOxl8YfRUSOxcLhdPiwaP1J8TJxtIkss3pavNnE7zsbXJnMNgJbNOBx/
         P9aIboK27Q/Bd3i4nhEfNdZ0OeP2e9p9LIO8xi5Zz0S1nffdwB5+XE8DmmlDWRvFBKPw
         Rb0oteRWWPnke9hU1dI7RYkCdnBlnSuu3JKU8UdjP/koK+c6fGWWJWOPx+554HhcdCqZ
         FdfyjY7CCgAdh83PjGE4Gcnpzu3EhSKch6V5qTgI2mC5C3yqn7D9VYKyVeyhJ3Ih1Om5
         uPjMEQILHXwscxi2/mZKmg5crarOZKKCOeRyngRz8rJLcznKdHtprtfl3XCpRvPzOr3W
         sUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3trsI/LvM4A8RL5UEl4yqhWqWAACPAu3ScjYj+O260I=;
        fh=6oeOO5vgxftmtVsNWKKBhHuwtBE+531NeyOcI9abNe8=;
        b=NYNj2XldKbQXe+XAXVy9FImAFOVtBhmaF5ZhHhNMGb3jJdjH/o8IVuRZhfgZURH8NM
         z2+D9YbHXXJj3B6bc+zihg9rTD1+agi2XuMiW1pHrnr02q34diDYVW514vOc+yLkPHyo
         ljkRBKvTbTQkoy6apYbxDHYLSEchLY9jVYqPe8IODh8iwLizAUdBtK/0UH4oyei8D2B7
         1RN0gU7WE5AdrW/Rexoi01aJTQbjFP9GILT6OqW0r4kgCAVx2q92eCKa6MVsc/NClwIA
         JZFUFH2FXVvxEwIVPVso4m6TOaf5bJ0Q5ZlkVduYGMWLy3KrG6XtMoRTTqpUPPO0HOib
         Esrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767911454; x=1768516254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3trsI/LvM4A8RL5UEl4yqhWqWAACPAu3ScjYj+O260I=;
        b=ebVw6w97MkmMieBG4Khju5rmL3JIgzQfzBdOmN/14/GGPLLPhVMEQBcw4A3Ubty3vY
         2RwoyWqAu9TI02UKa7UrnIqacg2hO2Mv19u16nB2EFfdsDByhO6UEwwddNZ40mKse4Ec
         8NxDGdo3kA0it0z/dIJSzqsDcyAKTtYswrAg6ddYZxaSlHJLK5UobU7gaMm9sxlJa5NK
         Fqhc3JL7pFMH+O499yVT18zXZkMxYBWPNrsxLKjxlHvCpEt6xV8M6Lj2Tk4MAdcm2L5t
         YPVGPkgARbemav+OSsOFmyzwBVqhm1yg6LjJE5DdFmKigaeOCLYtHhxqRx8QMQKvXw0K
         0liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767911454; x=1768516254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3trsI/LvM4A8RL5UEl4yqhWqWAACPAu3ScjYj+O260I=;
        b=sLhGPGWCUgix8HJC6KM1n1mhUAXkUCmDzZKtiiuicPzQtY1lTHbM0O1cJgQ5fvy9x0
         Um33Zl5pDGrui1xxgj2L2w4yn0kjRWUSx/SYFVP7m3jZify5eeEI4XfPw6oeeeY6mkxk
         BUl6Oc89mWXkYt8mm9tC9syunq2THA/YTT2U6VTjMEZLMO/bFf+rnrVr9IvJQMWI5H2t
         YQvatimQflLP93ZCx879kvOGA3IODTUEl3Gv6nwwhAx89DITj5+/uk73Xgk+BuVzMH/H
         8c65S+6ASsErmFNMeU1WWe681JxqJ+nej5CiVLY/jeudSqXFROFgCgRMPuLi38GsjsLY
         ZgHw==
X-Forwarded-Encrypted: i=1; AJvYcCWmVHRCXVymaVG6Ekpm+PUnTCbYiKALtEdFTe1E8HFO4VsBAVpWvrSyT+iWmOxWs1wop17lv6OIkGxPBoKL8p3E@vger.kernel.org
X-Gm-Message-State: AOJu0YxKW61Mij0g2Vo8j4SffRzSaRMqqzUj6U6uxJwEvse42xlzm2nN
	SKYSd2LR9X9D6YKsRl2Etx94Hez7SIyUkymyaHTCgmDQjz1GjzFaqf8MvRUq7g/eTr/lmEhxEwZ
	7i8TRBmBGrmwAHZAn57o7NxgbqlDfN5UZVlfgk59z
X-Gm-Gg: AY/fxX5KCtOhIKcqrt0na2Tlrla7cEEVBybTX+Tgc3E2Ymxw4BnVGqVJeJyziLiqLR2
	LPVsVaVYsEvkwA8Tl8W0cTNwCyCnNCBTKlN2hjrOFTL95y5gzIqp51B4u+QUn45sIIdAOSJeWoe
	KkjcpEjCWwEYXa9RuYAtUuKXqTK65weeikNsPSZfnnLHFhAHOPQ6fax+y5CqczLNMt5O3zvenwx
	1EhIiqb7B6KhvzWAH6RDRkN0KFW+gWcRjxFaPYDgX09x9X5hPutH+Kyc67F7ipMnDDpwQDm2COZ
	bleLf3LJARNh/1lItXxkhQXb/A==
X-Received: by 2002:a17:902:e742:b0:295:1351:f63e with SMTP id
 d9443c01a7336-2a409ac1534mr826145ad.10.1767911454144; Thu, 08 Jan 2026
 14:30:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108212652.768875-1-irogers@google.com> <20260108212652.768875-4-irogers@google.com>
 <aWAqpy1LU-uWvXEZ@tassilo>
In-Reply-To: <aWAqpy1LU-uWvXEZ@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 14:30:41 -0800
X-Gm-Features: AQt7F2pwxNqN-Ofv8_1egE7Ywm355qMZ0gUolrdshC1b6TKktNuHXbF7PAB8fk0
Message-ID: <CAP-5=fU2YLHpK_BymOM-J8mdbw2Pzhx+2Khpppi-OCCctxhYYw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] perf stat: Add no-affinity flag
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

On Thu, Jan 8, 2026 at 2:07=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> On Thu, Jan 08, 2026 at 01:26:52PM -0800, Ian Rogers wrote:
> > Add flag that disables affinity behavior. Using sched_setaffinity to
> > place a perf thread on a CPU can avoid certain interprocessor
> > interrupts but may introduce a delay due to the scheduling,
> > particularly on loaded machines. Add a command line option to disable
> > the behavior. This behavior is less present in other tools like `perf
> > record`, as it uses a ring buffer and doesn't make repeated system
> > calls.
>
> I thought we had agreed that this change isn't needed?

This patch or the series? My last feedback was:
https://lore.kernel.org/lkml/CAP-5=3DfUvsF7RtLAKaMwc28CeSEOJ+j0gVwvQN59moOn=
US=3DkWVg@mail.gmail.com/

So the code as-is is trying to always use setaffinity. For a single
syscall on a particular CPU this is unlikely to be profitable on a
machine under load, the IPI will happen faster. You mentioned that
realtime priorities could address this but that this also required
capabilities. I didn't see that as something that contradicted the use
of these patches.

The point of the flag in this change is so that the IPI behavior can
be had should issues with CPU affinities be experienced. With how the
code is refactored we can also make the existing "always use
affinities" behavior an option by modifying evlist__use_affinity, but
given the cost of an IPI should be less than that of migrating a
thread it doesn't seem like this option would be useful - you could
also make the code do this by adding a dummy event as >1 event
triggers the setaffinity behavior.

Anyway, I think we still want these changes that successfully fixed a
customer issue I had. The already merged patches do improve things,
and I think we can do yet more, but the real cause of the delay in
reading counters was the calls to setaffinity and this being slow on
loaded machines. The patches make it so setaffinity doesn't happen if
there is just a single IPI being saved or if requested on the command
line.

Thanks,
Ian

> -Andi
