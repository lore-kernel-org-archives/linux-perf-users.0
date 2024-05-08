Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359C393
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208464; cv=none; b=g1ryMcRLuuO25w8uT30SFLUN+461ge2RZjDlnkZZlIMGGx7xTcZxUez8+YrxkXtwufriMz3f4+1aRF5VzbC/EeRPNyZf0cek0oIZhkpH+cNCptE2jK6oyeTKEMtIe/RP6Z4idQAxYHf0yvA3bzJdww0FKLIJEGJK90w6pNW/iKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208464; c=relaxed/simple;
	bh=jnwBvi3VGiseF6Vuo3qjNo0hfBkpQ/lo1uw1t+xS6XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJnjFglwG1ZuqYLqeXKDa5sR0TqFhPWUC5K2GtDkPUXNtmZu9cUpw8vyYszfwImQ97Gr6nSGK0Mn5xU4rTvxeb6yIeAlQ/RDR10o1lofafX1P6IkEr/Rtz5GvKPGk/n7yB7ImYwXdZIXLXVYIVyZB+i8SLpF1mTqSMHxAK0EqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/SERx1c; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/SERx1c"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso55805ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715208461; x=1715813261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THTWPlGhHz/tVFafrr0g4VrmAxP+zcOMLOOzRkGzd3g=;
        b=K/SERx1cdsUDOPDli4wFwpxXu7C43YjwqX98tlXcqf0A+Q/BntX6nTtazdjtesX41Z
         zSeVkWN1exGAB4R0fsxu7TrHajbw8j4R5teRuZ3lPI6eJO5KDNQYyssJfrOYb0XziLAQ
         IrOjGuXp2P9xvHh4h5bPCJ6bxz03ZqiXiqEh50negoyFfy6M81MbTC2u0Zp7EqU66Y1e
         QlUnnN4bP97Pcsjf/zNlk2PrHany5qa2nYOJ9XCFGdUJFdbBaxFz/hqOR7iYbGjiUFmr
         NEEFNiojILTDJ9/iEDU2hc0TaIoeUj1QMCf9F/dCdYHL7nZzrb4AqVoHH/SIR/ZDLFbV
         6qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208461; x=1715813261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THTWPlGhHz/tVFafrr0g4VrmAxP+zcOMLOOzRkGzd3g=;
        b=wr6S6xqUO9e7Z5IAODWiFeBs7eHQeAhzxPCJVVTw0mfkfdbX0wKFcOfac1BYoeltVW
         t1mR3d+mOrxU4nXZ6V34vwiq0sNq5bKr2dO47oiJMluzG5oD+s4Mp7c2IwmkGGQcWSf5
         Ekz1SGkO0SfaYqmU1jSjLSWvfvNEja/6dGDxFEKAcv5Vd7c6QcjJeU9g5rLg1u9pQFYT
         l8tCgw8dwxRCQnjtR+QxoWWaqREyUb074JzlmFXJnH5DbW8PQJVOt48BWrBWLqQ2Ug7H
         0qjNmWMVfjG3n/n/E2sFL0JNJhpB00HJ/lZNLhzHA2qtZJA/0RD12ogOUVsMxbriazBU
         X84w==
X-Forwarded-Encrypted: i=1; AJvYcCVOA0gupyaAQ8GzHr1WxMSfZSrVQYCpnmffYhvQncTPMqEIgfB8bVuCQCKcyKCtETjkwBefDBuWxwtjcTFguBc/oyWqpuOsO9eTgdLbMq9xmA==
X-Gm-Message-State: AOJu0YwNhsEG4cTjrYXpfzbkxFjvyhv0++t9DKOIy3MhX20NHor5UvDm
	ZzZTXG3iC94HCVYt6vJOFO3uQfl5tMuApqT2jlisBUkXjIs9xDuq/SiMzgMSwRsF3pgdh4JCmnm
	v0HroGSPFi9suahLwv9Je5z4TMDFd/sdKjmDK
X-Google-Smtp-Source: AGHT+IHrMeDweZX5R1ZZNFbZEVYbhOS8HhI9h0QysvVsuKNihdt4RsQMqmZtPUqj/COBVYwAz3IPYtFqMjoIACrZ4UY=
X-Received: by 2002:a17:903:2405:b0:1eb:1663:c80b with SMTP id
 d9443c01a7336-1ef0913fa51mr368755ad.11.1715208460682; Wed, 08 May 2024
 15:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 15:47:29 -0700
Message-ID: <CAP-5=fWRLcsgMvBJnJNBt1k1O8vDqk2O6V2v2k7Jf3nY=yA+cQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf probe: Allow names to start with digits
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:14=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> This is a rebase of the patch orginally sent almost two years ago here:
> https://lkml.kernel.org/r/20220612061508.1449636-1-asmadeus@codewreck.org
>
> At the time I was asked to add tests, and Jiri whipped up something to
> make the test pass even for probes that don't exist on most systems but
> that ended up never being formatted or sent... I asked what happened of
> it and got asked to send it myself, but obviously also totally forget
> about it myself until I needed it again now.
>
> I've taken the diff from that thread, adapted it a little bit to the
> current master branch and checked things still fall in place -- I didn't
> see any obvious problem.
>
> Thanks!
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Note, this isn't applying cleanly to the perf-tools-next branch on:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

Thanks,
Ian

> ---
> Changes in v2:
> - update Jiri's email in commit tags
> - (not a change, but after being brain-dead and Ian helpful
> reply I'm confirming patch 3/3 works as expected)
> - Link to v1: https://lore.kernel.org/r/20240407-perf_digit-v1-0-57ec37c6=
3394@codewreck.org
>
> ---
> Dominique Martinet (3):
>       perf parse-events: pass parse_state to add_tracepoint
>       perf parse-events: Add new 'fake_tp' parameter for tests
>       perf parse: Allow names to start with digits
>
>  tools/perf/tests/parse-events.c | 11 +++++++++--
>  tools/perf/tests/pmu-events.c   |  2 +-
>  tools/perf/util/evlist.c        |  3 ++-
>  tools/perf/util/evsel.c         | 20 +++++++++++++-------
>  tools/perf/util/evsel.h         |  4 ++--
>  tools/perf/util/metricgroup.c   |  3 ++-
>  tools/perf/util/parse-events.c  | 38 +++++++++++++++++++++++------------=
---
>  tools/perf/util/parse-events.h  |  9 ++++++---
>  tools/perf/util/parse-events.l  |  4 ++--
>  tools/perf/util/parse-events.y  |  2 +-
>  10 files changed, 61 insertions(+), 35 deletions(-)
> ---
> base-commit: 7367539ad4b0f8f9b396baf02110962333719a48
> change-id: 20240407-perf_digit-72445b5edb62
>
> Best regards,
> --
> Dominique Martinet | Asmadeus
>
