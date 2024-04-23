Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7602D047;
	Tue, 23 Apr 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913641; cv=none; b=OudVWAc6MBZrYU9gtqyHwO9ntW+HaQpxmXhDoJDj3mLyApGYqQNPI5tsGB/r5D4/letbvleAX3Koll6e8wqaSG/OgSAgo89HcT5pDWQz/dILNAxr51MMEvO+uKNnxwN3nehldE0rVotsDVSgDNWknQeMG18QLTwFez8PZ8N78+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913641; c=relaxed/simple;
	bh=fdKTsQiz3KqlISfMisn7By3lzpT2+DPiBiUVpiXpxsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1yT0cvqCOOHXf+OrP43WHaetQ2+lSVfv//3QjxVqmZuRsGHxpNakM/in5roePzpPaMJEuljc3Dc4vkfN4PyyENRp1hVU/t5CRHhYoasJp/c3vXqMTZTiYFqTBpMXSfdk+RlyyV3UumUyHIAYpfzUmUN8UPwntaTzNJfC0cyOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso5098025b3a.2;
        Tue, 23 Apr 2024 16:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713913639; x=1714518439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG/KbkkbCeeM2yWNtYv7yl98W911rAWcRZclYU6jgao=;
        b=EdZ20q7fZK4WIiCdNmqYuhOBtC6c2cE499wIwt87wLh47Dwb+sy+vfUrSypMDe4K4a
         fAp75h9Q1tQfqqNAZi0ysjoUxI9XSUkZ0EnBioZ3Gmo2S1FlVTXiemOzsxdq2bbXRrQE
         w7K+eK1y/cOyW8ywp9zq65EDv6W5TAN9Ex2Q12AG3JsWl3vHe1bc4I4QtBMzJjwJ6X2h
         qkzcSfLic2LtG0Z6fMf4vhuc3chMP1T2a33l/ojjnqYGChIYhEiNXLep0jMblR7m0kRR
         UuWqwSi7wlp7sCXSfbya18QyVTxY+cYMvH6CzeeauQtbbnLA9i0ttHysKL1EtitKAZ17
         gAGg==
X-Forwarded-Encrypted: i=1; AJvYcCU/RTQk+kLp51qWSEt7qZTz6/cl5CCKgXJkIHLF6Gtv4oUAAYEbHLSJfdwqOy6KpK1FeLTVyddWtkDYDTguz4Q5y/f4dHnljBsu4ECHyhoNmdOauJtmHofEaMF6Rx4wajt9syYDhJEnQplT1aO5oQ==
X-Gm-Message-State: AOJu0YxzTEubqmPse7zzwLxZu7z0d/DzxJkMJAgALuS3d6U/4hZ8Y++V
	aHps4KaF+MWONn0KwFd/3bzEaXBumCT5N9famolEfVU5NNf9yYkxJowvkEOd8Ptj2T/nyzo18Ln
	HwOuXbNa16EgmlwKsn5nALVOc0seYuQ==
X-Google-Smtp-Source: AGHT+IEbX4NwAuT7BdgF0MqJIfLuQQKMpJ20bG7iP5jAs3FpyTqb7plx4F+PeA5E5W+C5tYvP0UTOoIxc8GBxg8Sgmo=
X-Received: by 2002:a05:6a21:3985:b0:1aa:5fb4:86a9 with SMTP id
 ad5-20020a056a21398500b001aa5fb486a9mr1078514pzc.26.1713913639442; Tue, 23
 Apr 2024 16:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423020643.740029-1-namhyung@kernel.org> <CAP-5=fUjDdy1GQCq_Z96x=bMXrxmqKojnysYsOnjBvO_nufjsQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUjDdy1GQCq_Z96x=bMXrxmqKojnysYsOnjBvO_nufjsQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Apr 2024 16:07:08 -0700
Message-ID: <CAM9d7cgDSnd_kZu5LRkNF-UgDX9L-3Po4f9idAYhmqtb8MhEdw@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix data type profiling on stdio
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 9:57=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Apr 22, 2024 at 7:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > The loop in hists__find_annotations() never set the 'nd' pointer to NUL=
L
> > and it makes stdio output repeating the last element forever.  I think
> > it doesn't set to NULL for TUI to prevent it from exiting unexpectedly.
> > But it should just set on stdio mode.
> >
> > Fixes: d001c7a7f473 ("perf annotate-data: Add hist_entry__annotate_data=
_tui()")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>

Thanks for your review!

>
> Should we have a test to cover things like this?

Ok, I'll try to add one for perf annotate.

Thanks,
Namhyung
