Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC981A5B99
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867890; cv=none; b=I4LNAMS0MO1MRrBU+sXlcEpjne3yy26cOs1a0JlhHttFq0/GHtrPcvQ+GNEHMe9af0A+sEk0YQqmoJgmM7oEHrpLIAGsi9Mxrko9X3BXMrkgT4cQWhIpisJ+AUMeW3fbK355LdK5LPyg1H0WyspdQg7/4veekA/lotXVWBTyjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867890; c=relaxed/simple;
	bh=W+EmoY9BtXnORycbSDogTMfJwHH9/hNjgpy3kW9vOv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h64/w9HmQyfJc+/58hHRV+0hzcoDWI7yRQavOMUtV5pGl82oTOQvzn5IjbzkVXMoEkSWls6fCGPEXTk5fsGcSExFXE2dGMCkRIlQiUXq94Hhw6N437fxJYT4qwIZ0pv8dWzpCMH/S1ICBJssyRst+IiM2/TNMBZh42UaReevopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOTHEUFH; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOTHEUFH"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d04b70fe79so12265ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Feb 2025 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738867888; x=1739472688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+EmoY9BtXnORycbSDogTMfJwHH9/hNjgpy3kW9vOv8=;
        b=wOTHEUFHNTUtlEFVNl377DEV645sMOC8y5QdNGcAKRYRz0xpf0gyW7HwNgxltz9n7H
         rlRaVh2+TzAOwNYip7e7SbHUzYa0tvo9ncEphrYLdFGKZDyITlhs2K+piD8QbqOr+ASb
         +diHQKqQ06azbcHwZv6c2EBZlE37iblFGVX8e2Mtmc4pT/djNxm0hjGmFjDiGJHui1vJ
         dyczxQ5LDA2V2uIWVhulloxw8LF1JfVXEYsnDZvCJZiQktrxiXA5LY0H1i8JrPSqRPmZ
         b8wWC4cV3VTKfKWLnpU3bfOCObKpu3S+Y1YRdE+JGcfVRcYBQsYyeZB7YRNbhvj9OogO
         YASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867888; x=1739472688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+EmoY9BtXnORycbSDogTMfJwHH9/hNjgpy3kW9vOv8=;
        b=ISr9wzypDY9HdVoflu51jYa/jNYy1v0+Y9uxnGnjnlYyNjOEFYwtr9s9+I1e+tL3aJ
         U5wt9Bnsjrm9k5CG6lM5UAV0jC0i+pX3T8XeWYsLIbe1jx8Ln+UI24aMFVeI7jgh06c8
         A1tJ8NPmDjiIeor4daCra+d1pm7rwMGbDQY42jYwbRRhx7j/WYFgEtPRWEL711BH6+pu
         GnLuSEA6QFbadZZttEy9YS5lbJod3PGpsyeSW0YDMKZ700B65x6g3/gJwRzPTpeuzuQ8
         9eFW+zU+j2ff4LgpJBgY9UW+5xTy1D3joytqYcO9TH/rDCWpnEKdX2QX/gYl0VgK+1td
         Afng==
X-Forwarded-Encrypted: i=1; AJvYcCWyKOUUxnW9TKUjJ7Sm0/YQ5Sw1WFOYPGKFAAqDb4hXdHTVx7wHEU03XD91HHqvH2DFbu2JPm+NgnI2osC8nZK/@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDFtPgv+uUGoumex2aF3jMwd6LsOSpk3+bnaEDe3EfJjgJNY0
	4jrJW6J4yKqvWwODOEktygiZao8wp6X0nH9E7qhhRJGa2d4LxZpaHVL+0qRs39i79dntCe/dqTc
	b8FrhqvT6fXssVl0sAOPGQyN8Ku+4xOKupFOg
X-Gm-Gg: ASbGnctYFuGpFZxmRRp9ZekS14KtSMC2RJs3PVrweJTBRG52TfN6O7Iw53Up+MDNAUH
	GwiszvqSTtryizNnb/jyAqVd1A6MbDu8BxNBs1qhv5/bIfJ7iwdhepZMxm7Q5x4uyeRggV2rKjm
	GQCe5vRf/GF4+U+W56nuDPE+3T
X-Google-Smtp-Source: AGHT+IF9+Ul15W+RjPSocu8uUZAho7OvRYprbn6nq3pQFsVOTDKly+b2R09++b/gTdnOVYVoRxVI5nYqlAPkSwXc3os=
X-Received: by 2002:a05:6e02:20ce:b0:3a7:c9eb:accc with SMTP id
 e9e14a558f8ab-3d13df24892mr112355ab.14.1738867887651; Thu, 06 Feb 2025
 10:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com> <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
In-Reply-To: <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Feb 2025 10:51:16 -0800
X-Gm-Features: AWEUYZmZkbYvDg8fUC5Pm5bSxbJep8KVTkj4PMB3cOfAmup00_un0a1HQJcD9YM
Message-ID: <CAP-5=fUxY1KYXN-HcJPd2D66j5cC6DFTGPzYFVvJKvBLqyz6-Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:41=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
> On Thu, 6 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
[snip]
> > We traditionally didn't do it, but in general test coverage
> > of perf report is too low, so I would recommend to add some simple
> > test case in the perf test scripts.
>
> What of this is testable within the current testing framework?
> Also how do I run tests? I failed to figure it out.

Often just having a test that ensure a command doesn't segfault is
progress :-) The shell tests Andi mentions are here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell?h=3Dperf-tools-next
There's no explicit `perf report` test there but maybe the annotate,
diff or record tests could give you some ideas.

Thanks,
Ian
