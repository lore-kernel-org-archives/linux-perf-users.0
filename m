Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E71EEA43
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jan 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771023; cv=none; b=cFh8KvBOJxanosIXoSglGTSNSVUfdEAIPJkRdHjmZTEMueI+q7sMQiEGE6fkTDad8HITWAmysE0Ij5HD0JjyrDqRuOAPIxMu03JW+bUgNtBu3Hh1xQhc4a/OZRPY7/qQR9FSD6dVpf6uTx+wTkFHiuXPcpXPG4mW6MPJR5sZoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771023; c=relaxed/simple;
	bh=U4OfVI98EtmndPqJypCWUQMs4TPRk3LIzn5BzJBNfIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biTuXh+1nC+6EcxJhHF+CfnBLrS+nsY3jVYpqp5X0cHT8VVytlkGwjWOcSgfSngrOIYR71MdD3qDgHJPiCiQNDiOWg6dnUXYVV89BFGMYN9SMTVLLQxS3SQdaCvr6gHWV1XvItpkZKcvfbzwqVqMlMecNVEjU0Vt+T72ZthGb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFMcKuC0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFMcKuC0"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so57585ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 18:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771021; x=1738375821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GLpe/cxkIfblDNFrCWwp8fAWDmqnsZCx1i/qXjFxwQ=;
        b=TFMcKuC0FiQyQIsjOFLghlgo670w/gfx+j8fQvgkqoy+KXQE7Et3hX1lF95D7MEjwE
         eh0bMAL/JzZMND3Nl1BMGfMnxhaKmNTiMa++G3E8+bJWli7OweUp30Tn6EwWyazR08bd
         U5DLv73vp3pZcC1BqKD4B6OXgcFMLpASmS54O1jR+0pMRjm93fat/wMyOHtLpDQLHtn3
         42xqGs60g5MWegJiP0UgD6L4nfVIszbwiQjajL0gpH32+Y7dhDE60K2uAfvpE4dTHel2
         P4er8bggNvBx4vhomdw6k4qfG/3bxqYWeIf6DRhh8+Yk66YpUuw+dc6nIuJJ6R5um/EY
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771021; x=1738375821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GLpe/cxkIfblDNFrCWwp8fAWDmqnsZCx1i/qXjFxwQ=;
        b=Vn6QIHiDO0OEyp7c0wBqgtAe2wJWbshX3aeJUxVl4zJ1REIUDsRR2S6N5V20yw9css
         8o+9rykvcsMFOZHOcKhK6migUDxk4HAdOsUSbgICIZiO1yz1lxCDliN39R65D5XtZisy
         OoJraFg8Nw7OQpwLxgWyzh49vu0baiUFfRF4NVEnBOD8MY4DrIo6TALn+3mvoi4E7LJ6
         pi84En+AhOTCmKw1FD0ScW2wk30Avym77bRsmfmwLyajBQlsRZ5/zvb6VMSy/46khH6o
         yut7c1ZjMGhn0imQ2qAKLCgjcaiC9KrxJ1zTZbYxoZl2d7WF5mBkRtkxRyEleerhu89A
         GefA==
X-Forwarded-Encrypted: i=1; AJvYcCXFzD/+w/jJEFyLNLZVriyYp/pZg5KACWu4/SIdYpx1tiAuUzC13MvPacOuxDpiAQ8vCEHamihSBWmG43Gkz8Uz@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjMQDL6kNelZ9HBGQOfqitSNhuLWV+HhjbZvUFR23fMDCf3NR
	4kouyYywvgPjJuZSQOvRDriyH2TJrTHVTXiPlV+lM6kKkIoozp9rrvhoBc2s2V7yAW1sFnBdsv9
	YjNbjv0zfa/f2UddtGfbx0RuKcZdnOz6X1YBw
X-Gm-Gg: ASbGnctnqGHa9U0b+FPvCQjsRty+wgagkEVbgOTyqz4zw5qHYowNUKYMc9g1b4761St
	HyUaYr9hJ4K0UfIhJXcTeCsTYL5a4jO7bKLtzSYTIg0QmpDmjdd4BwmA0xM5r/Mc=
X-Google-Smtp-Source: AGHT+IH9gOBnwr6oouPJYY8IGyJSsJGYHNtNIGoNY5t+P4OlMagBFmG+IUhhJ/3DtPf7JyxcTX6dssWtapZDy582GZ4=
X-Received: by 2002:a05:6e02:e12:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3cfd20f42c9mr689845ab.23.1737771020782; Fri, 24 Jan 2025
 18:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com> <20241025172303.77538-4-irogers@google.com>
 <Z5QngQQZBIekSl_v@google.com>
In-Reply-To: <Z5QngQQZBIekSl_v@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jan 2025 18:10:09 -0800
X-Gm-Features: AWEUYZncrM3Cam2DZOEq-LG4JnuYNKk9aJ_26ArSyvwrOMqrJXZ-Zd4LnQ4iNjY
Message-ID: <CAP-5=fW8sGBQ_KRSRKhpUH8fzjy_PG7S-75O-YF1xGj0agoe6A@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] perf build: Add mypy build tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 3:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Oct 25, 2024 at 10:23:00AM -0700, Ian Rogers wrote:
> > If MYPY=3D1 is passed to the build then run mypy over python code in
> > perf. Unlike shellcheck this isn't default on as there are currently
> > too many errors.
>
> Can you please add an example output in the commit log?  Also you need
> to add a comment to describe the build option.

It feels more of a developer option, so I'm not sure we should
advertise it. Ideally we'd just default it like the shellcheck case.
I'm not sure of the benefit of snapshotting mypy errors, a quick
internet search will show what mypy does and I'd prefer the patch set
focus on the build infrastructure changes.

> Is it ok to pass the option on a system that doesn't have mypy?

I'd expect the shell/which assignment to MYPY would leave it
undefined, in which case the behavior would match not building with
MYPY=3D1. It's basically the same logic as with shellchecks. I didn't
test/optimize for people requesting a build option with dependencies
missing.

Thanks,
Ian
