Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D7448CF6
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149310; cv=pass; b=nSV37YFYerT2L3B9XPN7rL/UGKSqJiWLzanixPNsnui6PxDsRGhS1lSBjoaeNwQiHxDn5ec+8pF9iHblnoSg6fNhl6THi8yFBv8sZkfEJIHtFNYKj4Z8jCn108KIbAjfhFAv5vdSJDQdUr63qRU5WOvMFb2M7VEsNSapzWEwcx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149310; c=relaxed/simple;
	bh=meb1bAvawCq/Ib8QpyVS9dzYsYkDPtpweSxQpaNTp0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sw511KItPnbSs7DdTC+6OC1tNLIWae5c1iKq2jqrL6qaM7byPivH3ujdkgEwXQqROaakZpRzBGD9n16mM3eIv7asCt1uE7EJwga6O5l/Mba7/X299EyMyhlLraUG3nSeL+G76Bi1DvJV+lQxZZL1KdNYLnRaLeZbzlfgvDPFURE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8mQfAi5; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8mQfAi5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53113d72966so136371cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790149305; cv=none;
        d=google.com; s=arc-20260327;
        b=s14DqzX6sYTbH+uR0TmnW8WCe2onBDtPtIkzk6us6o998RcnpR0RBDGI9/sA3jsckE
         PJm35DPBIMlkh47NUYANo6d2POpzeHEORyQEFC9oUhz1uFTa9LjBw+cVhF+SnNlWA8ZD
         H5bHjbHM0pTCPXTX5hqviYG6GAru6nY3AlYDEfMgDu7TmcK2Tbn5/7lmyK0Z4i6Jw/TM
         GOf3pbirrcOEO94Fc9/h6crje1PRldiYpVyh0slpuIF7/zOuUaeQNdp7UiWRf1cgsHI5
         vaNcMwJvzNjqVQxvlcrD1DWMVA8o9lXhT0Mr0Begx0A2moMwl9SY5TNE1FqpNU/Yt7u1
         cuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=meb1bAvawCq/Ib8QpyVS9dzYsYkDPtpweSxQpaNTp0U=;
        fh=Qk8cIIiJJNt53PiaRy/8Nw1qZmlv+MiyyZ/P+6yyK7k=;
        b=EwwhDuNimRc9PxQs/wSYEwIETTPEL029CcFB+aOdBLcQsLe7ORt/bJDsJmBd/JCzij
         IGeL+VdtYXDJSJwJRuEuMLPQ+fZ1URVDrgDtz9Lbt5udFerBXP/LIs2BEn1MYKsae5P8
         BkqovJXdIYlxzfrrymzZnFlCn8iDbckU6wRW4wsZKDWkeH4Kw6qnVTfODAgNm5GrQU0a
         lgAOeqRAXR7eL4523Lukbeba0p0uMTFNonQGlV34O5gVF1UAECszrFEvHqXAVCfpOYIq
         LQ9LunplmUl671dp3ahTl0N8kMAbocwptMWTnBvM7b06oJPI7ndPnEAWNjgb3lS4t4Fe
         Y06A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790149305; x=1790754105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=meb1bAvawCq/Ib8QpyVS9dzYsYkDPtpweSxQpaNTp0U=;
        b=W8mQfAi5fknrVsqLQojpfMuUz7nqIsVD9eU8Q/KsRk9ncgzi1eD0ZgzLelurwrKXus
         7I5SHiSUa55RMsci2iURrYte/QzO+1Jueun0FR/jlb22+Yin1ODVKm5ezw7AKaBwVeTM
         DjuCY9kXxiX4cEqEaMSmlBdfSly8DDP9k3i4isA2hkP2HgVZO1RKntA72e1J0Q0aofPw
         wbFe/pgEDZjtkG0/C2SH4nDBbjnvgnQobDLYmlJ+8ofNHk5pz0vXHyjZnfU4jU9iV42i
         9+OmneFUQdEvZny0w41v9fXMemTiPqkW++GdrvU/97bvUQlN/SYeLJjGhJdZ33p4tqIn
         Ydvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149305; x=1790754105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=meb1bAvawCq/Ib8QpyVS9dzYsYkDPtpweSxQpaNTp0U=;
        b=ekcKk1zd+JjZo3J9ADIHZJJhSHqJjkXVdAWt+S9lSBlYP8GVErz3keMleXLZ0s3fMs
         jja5CJ7kuNYxpvgHjB8ffxzUFWpdb+KPDgRbHha2wtxvGGf52D0d7A32XQTBMcqPfclk
         cocOV/qGDB8I3ie0S4VSJEsxNsc8ebJl+626jmXkuapxwk3vMYmSYmZgSWCzVrkFaFG7
         FMVtPNiX5An4YzUbmhM9gx1ihMWKdY/ksSH2Q0CUsYEj2o/EfTj/V5SlbFfr+tuCvB0B
         4SPM84F4ivXc57DYQvjaPIUoRxPZZRLHMRfuGEKzGABT2VpwFH59R7QPvQy2kDYZBw7k
         vsmw==
X-Forwarded-Encrypted: i=1; AKwUvBxcWBQYGf+6S4UUzEUnPq+IxVEZhaxOkPgqUi0IyTzKL9RXEAYR8kdP+R2JaHUhOMoM3QU1b8x5zBeN04q6CbKI@vger.kernel.org
X-Gm-Message-State: AFuF++m8MuzHHnBAfhh3VI1bJLmwdTwJpzR5lEqL4VFK7G8aPd0d90CH
	TRokVyJW5MolvtA8q0Z+T9bm18z9ivWFaewYFR50OvIhbWZMOlUg7rALleRs0zAaIGhdEN4SPVR
	Gp8TzMHmBTRDl8M5SUvDlrsiWt65WGwE9qj21YAd4
X-Gm-Gg: AYBFou0iu3/JxtoLdPb5mmO4S+EnhYFA4e2pMkwCvHdkdOJ/u9AnaaoOH17EDMU9xzR
	Hq190xCTqRaPGeKJ1YkWjSq7bYEjML/BllYk7aFBQxALmkvXqHQ21Qu8B0662/41FEtU02JeYS/
	A82f3aaZBHGkYChk4idoUv5NRWctItO9BRFM0s5s7B05wT00DzjV+pKDlHV9mkmVOJ4WUrQwZbF
	XoQvXRyU8DE0hGpijtwaxA1fL38Eo7uss0kzXFFwAULF04kYs5410qDnkBLfcaIvyu27jX5/67C
	T61fytkjJWYnPR5AW/B7ddj8lVSU4g1pXcP6tDEbmtyenUCYcHz1120=
X-Received: by 2002:ac8:7f43:0:b0:532:ad75:e432 with SMTP id
 d75a77b69052e-532ebc71886mr11204181cf.8.1790149304297; Wed, 23 Sep 2026
 00:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922215548.398541-1-chrismelnu@gmail.com>
In-Reply-To: <20260922215548.398541-1-chrismelnu@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 00:41:31 -0700
X-Gm-Features: AcwNN1VapWtcX2GGSDCIJrm4EXoEzaxFJtfKpxb1AM3c9K7F1JzWeyqMfOzL1aE
Message-ID: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
Subject: Re: perf stat: worth documenting task-clock/cpu-clock in perf-stat.txt?
To: Christian Melendez <chrismelnu@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:56=E2=80=AFPM Christian Melendez <chrismelnu@gmai=
l.com> wrote:
>
> Hello Arnaldo,
>
> I'm learning performance engineering and ran into this while playing
> around with perf stat. perf-stat.txt's TIMINGS section explains "time
> elapsed" and "user"/"sys", but I couldn't find task-clock itself
> documented anywhere, even though it appears in the first command
> example, as the very first metric shown.
>
> This apparently came up unanswered on this list before, in 2013 and
> 2015 (2015: https://www.spinics.net/lists/linux-perf-users/msg02405.html)=
,
> where users asked about cpu-clock too, without anything ever being
> added to the docs. Would it be worth documenting task-clock/cpu-clock
> there? Happy to send a patch if so.

Extra documentation always sounds good to me. We added json
documentation for software events not long ago (it shows up in `perf
list`):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/software.json
There is also documentation of cpu-clock and task-clock in the
perf_event_open man page.

Thanks,
Ian

> Best regards,
> Christian
>
