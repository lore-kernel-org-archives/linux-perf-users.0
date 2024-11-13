Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179218A6D8
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541253; cv=none; b=VnKMQA6fgeTmK/3sVTn6bctGy+I5PSE/I7l8WMAqTTML6AFQOucF+xGlNMk6e0wjXFJI0GjMD4c4UaRmPFlVkj+soI4PA6/vP0sAt4+x6v3UIK6eFDORhyWweIPYccl1+ymuq+lmOpMVTwoeRulw/+OApt0B6NMfzpStAdBYYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541253; c=relaxed/simple;
	bh=n8nBYFsvDBCotCg58+sOi96R9rXZN7f73l2S1Mi5FS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a41RHigtbmQKe82ciHO+Lbzh6oX6d33pY6++5TvClkpywp5TnSRMGPkSra0hnlx5e90jBxGlBpZkJX3fjnHgg+EB+aKTsWNtcJJE1NbxPnYhjfbXOrcMb1ZCFR6L6Iw0QlgvU1kY1L5zqzdyvwKxA0gbLzAf5W/tQqbgiEmsOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5IOoWj5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5IOoWj5"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a716d74c28so12715ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 15:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731541251; x=1732146051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8nBYFsvDBCotCg58+sOi96R9rXZN7f73l2S1Mi5FS0=;
        b=j5IOoWj577d0DjPAmKaqOE8qVMYcOi+KfY2JqooE6UTS6ZXeCXxAG9X4//BcyRAOor
         DzxG0p7CU1jUxvXP1CIyuvwGmmLKPbregpqhB7doECuCBt9mgbtZxGhQtfU/7ZRUIs9W
         f3a++xFe2uDQusom/FbaeLQPUUen6pdBwVk4HjqKIT2Zsi5jMjg9P5jgo3ufGH5A9A1/
         ZHHM+A2/WwZA4oElIuuFbzD02F77bAGoo7CGsVcejab1Up7Yp0knnanSuNfZNriri/R/
         PjDNHzobtdrFmOYhosIdgF1JhBs9G6qTitDU0FRUEgBZ1sVTYTf94Te4FjIhXTyQEWSd
         +giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541251; x=1732146051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8nBYFsvDBCotCg58+sOi96R9rXZN7f73l2S1Mi5FS0=;
        b=CoaxL92DnDcmN6o6YvMEW+918YXd9IWLVt77wUZlzew2rEia1cKomA3xrUXY9X5jSz
         iOLlYZ0pc15BYrN1OmBP7DZTdg10q+dXrOdu/h3gLKMoMhAt07aqYhe7oR6K0q7z54+V
         g0hpxJfk4IMz/igdEPLJtXONmmhNdWnZTFKnwzAbR9fGUPppFHXVlNtP3f12Ec6kmmzz
         4rBPAgbomMwTgdHtsBmvJ8QG+YSEIlwCP7y6WqH9G4AvSomrpIU0CXrg/bVOzbiBSNkz
         1fZ53V419ZuFicvSNtd2cYPIUxUMQIcOuTkE9Fohi7smXMX+DyehBev4r7X6tVsYWJJj
         XtJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2fMx1TATSU6PtX9B/UzOmXx9gN7cEsm2OZJoRWYpnzaaZGA9RXviAz2q4fy9zvUd1sXuoMpiLcmM9bisTPDcv@vger.kernel.org
X-Gm-Message-State: AOJu0YxeN1DUn3Ag00FtaLkCI8lBzyb6oRxTTNVTU5JLaxNp9nzK0Z9Q
	g1hZo/8o3+e/gtbRE3YwHtsbAEgG+LklTEUuSpEo7Vo4qW/dL4hNw8N/oZK3iRwLUoDTQm++QMY
	5lm+Ze0S8QeM1kcKU6KzCF/khF0xvijsQ4c2/
X-Gm-Gg: ASbGncufcugaTKrTV3vdbmMAXgi/suCA9cdUd85wxMT9xynUjWy4QU9S7cWIRAkhsRh
	T69FVemLTpPbWGMS2iIQOc3queCPwwLsXTru5mEG1pZ0D17rNyisLLWX5cZAIsq8=
X-Google-Smtp-Source: AGHT+IEv/AxbLCrxL3qYhb4sdLAHJGoF9BYLR+kiCSSJ6XRxxnDn753DPoPlPrCyzeYVNz2q75bxxZw6sJpXgwiONm0=
X-Received: by 2002:a05:6e02:1d82:b0:3a1:a90f:74c6 with SMTP id
 e9e14a558f8ab-3a71f743df0mr386015ab.21.1731541250616; Wed, 13 Nov 2024
 15:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <bbbd024c-d2df-47ea-9587-f68e5bc45962@linux.intel.com>
 <CAP-5=fVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2bebNcGYTg@mail.gmail.com> <07ee39aa-309f-4414-aee0-cc5b86a66af7@linux.intel.com>
In-Reply-To: <07ee39aa-309f-4414-aee0-cc5b86a66af7@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 15:40:39 -0800
Message-ID: <CAP-5=fWP7-CjuJXRfdxD1mfAXtdwiq3e=j5i=ia7_UAKQAE+Gw@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] Python generated Intel metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:47=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-10-09 12:02 p.m., Ian Rogers wrote:
> > On Fri, Sep 27, 2024 at 11:34=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >>
> >> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> >>> Generate twenty sets of additional metrics for Intel. Rapl and Idle
> >>> metrics aren't specific to Intel but are placed here for ease and
> >>> convenience. Smi and tsx metrics are added so they can be dropped fro=
m
> >>> the per model json files.
> >>
> >> Are Smi and tsx metrics the only two metrics who's duplicate metrics i=
n
> >> the json files will be dropped?
> >
> > Yes. These metrics with their runtime detection and use of sysfs event
> > names I feel more naturally fit here rather than in the Intel perfmon
> > github converter script.
> >
> >> It sounds like there will be many duplicate metrics in perf list, righ=
t?
> >
> > That's not the goal. There may be memory bandwidth computed in
> > different ways, like TMA and using uncore, but that seems okay as the
> > metrics are using different counters so may say different things. I
> > think there is an action to always watch the metrics and ensure
> > duplicates don't occur, but some duplication can be beneficial.
>
>
> Can we give a common prefix for all the automatically generated metrics,
> e.g., general_ or std_?
> As you said, there may be different metrics to calculate the same thing.
>
> With a common prefix, we can clearly understand where the metrics is
> from. In case, there are any issues found later for some metrics. I can
> tell the end user to use either the TMA metrics or the automatically
> generated metrics.
> If they count the same thing, the main body of the metric name should be
> the same.

I'm reminded of the default events where some of the set fail on AMD,
and of AMD calling their topdown like metrics things like PipelineL1
and PipelineL2 rather than the Intel names of TopdownL1 and TopdownL2.
Like you I have a desire for consistent naming, it just seems we
always get pulled away from it.

I'm going to post a v5 of these changes, we carry them in:
https://github.com/googleprodkernel/linux-perf
but I'll not vary the naming for now.

Thanks,
Ian
