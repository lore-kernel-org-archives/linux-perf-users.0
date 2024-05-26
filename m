Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233817BCB
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716739924; cv=none; b=tSYD35Myd7+jb7152EWIYG3KZ1KOTVoeGDDUUTNOgkL4fPqhqCkmXLIc1CnUnamE7J125oJV/Zucpibm5Tiy3EY8D9bsP0WfqxVAlHkr9WWV2A1zCGXzGg5r3r7mWZNxcZT9l4LHmxng/rA9ila41i9LoDlYs81RVm+WGZO+IMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716739924; c=relaxed/simple;
	bh=1qTOg0i4AJav707D3NLC+pqPicBkYgVxlo3Ac7E7+Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL9nNaLzNM0pfac2EuAE/98Hf5rhM6iE0ksNPRwTSzZU7KT3NBuT53eWCumydi9xdbPui9SFRyU582B0nkkeam/gKWZmIrsH1/aVNYuJ9nGsZx/LWQ5NVcHYdwFLfd6Kerh1ksHyA8jXqbqxgrpDJJyOa812I8399AtZK00q+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C6A6dTaJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C6A6dTaJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a626919d19dso378466266b.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716739920; x=1717344720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3spg7Ji2j77u3EczWS+0jELUOh8+Gf0gXFP+GN0JHI=;
        b=C6A6dTaJyPsMUHQNltHZZYhNgdxdnzWxDI26t6iOhV9AxTcGLUxYI0jFiUj8U9R7eA
         mbHkqkTux+2JxzgSN88BGd2yg3HFtepr4/EfvBJ4PEhA9p08uMzJStaaOlxR+2mfYpFc
         ITsSBxh8qUZDCIV5qic7M9VBSzaZS0ZaAMvW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716739920; x=1717344720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3spg7Ji2j77u3EczWS+0jELUOh8+Gf0gXFP+GN0JHI=;
        b=YrrKmXMYjbFGq2VMMgrXJhZ5rNzirRgJiEImka8f4v4TPSpnyZd1sPjn54NgnDG/Ot
         Y0yB4hfAMnI2MXa3cTzXh9Q0G45IragiFNRSJp7DafgRliIllJ9EdaTQx0/b9ia4OKIF
         Hho14j7EZLoH2YUjmcxkexS7qwmAVF1zd6+BmBhWtclCzFidLSKNTKaJqOz3Riqgz/M5
         hWOzRPGiArJ0yXRil6sWG+twnixM33PUWHIUZdnBtTtmmqTRppQ17wg1Rtha4bNrGtD0
         R+9NClG4AzV4xZMLyfbW71XlpXmzOxfdyhgCgu9m/3qJbTovh6MDo4vAuT250BfjyPFu
         Flhw==
X-Forwarded-Encrypted: i=1; AJvYcCVcZE54iB6dXf9sERubAxU2Xnga9dQIf/RGOp5Qcjb1r8Efb3ym1eufEnblG00xbCLFMgqK3IODkPG42LcoVnoXM2SmbEN4CJFgJ9uso3tWRg==
X-Gm-Message-State: AOJu0YyHh3gF03swZmb1D/2s8MONF78kpgbjg98rzisBnCGbhhSaPSDW
	bz12kCYV3/eXmUKIs7XxvQgbpX2tQTcZe+dmrpER4FDB3k2v/Tap0GANpJnEoNg/zg6ZVMETz3Q
	JrA/oGQ==
X-Google-Smtp-Source: AGHT+IEqYEeV2+6dftjFkdxJXdsiUHW4YPylZPNPwbK2MC+f1ciQ2HRobAtSJSjjt0df8BcHb3uIGw==
X-Received: by 2002:a17:906:4a50:b0:a59:c807:72d3 with SMTP id a640c23a62f3a-a62620a72fbmr641713566b.17.1716739920448;
        Sun, 26 May 2024 09:12:00 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c2a8sm396608966b.165.2024.05.26.09.11.59
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 09:11:59 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a626919d19dso378464566b.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 09:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmYWNkN6t6ROQE21YTY0mKWjaK8b78siyD6q/XYJT5qTMGnfWjO9NO702kzsUW32K9Y/9ECwUo1zwP9+lgo+ZU10KnuB8+xxWMJzqefSnh9w==
X-Received: by 2002:a17:906:275a:b0:a5a:3e00:6317 with SMTP id
 a640c23a62f3a-a623ea0380bmr807493566b.31.1716739918672; Sun, 26 May 2024
 09:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com> <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 09:11:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ2JoyBNFnR-TUc7P8sBL2ZvR0W1fCjcK2R2w7137wfQ@mail.gmail.com>
Message-ID: <CAHk-=wjZ2JoyBNFnR-TUc7P8sBL2ZvR0W1fCjcK2R2w7137wfQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 23:22, Ian Rogers <irogers@google.com> wrote:
>
> What to do with events with no PMU like data_read?

Are they actually ambiguous?

> The rule for looking up an event with no PMU specified is to try it on
> every PMU - the rule is about as old as perf itself.

Well, clearly you then violated that rule with your change. Or you
ended up changing the rule to look them up in the wrong order.

I'm not interested in theoretical breakages. I'm interested in actual
_real_ and _clear_ breakages, and that commit of yours introduced
them.

Maybe the fix is to make sure the events are always looked up in the
right order, with core events always getting priority.

That said, in the *particular* case that I hit, it's even worse than
that. It's not just that the wrong event was looked up - it looked up
an event that DIDN'T EVEN WORK for the workload.

So it's doubly broken.

I don't understand why you then bring up a "what about" issue that is
entirely irrelevant and would presumably never have shown the issue in
the first place because it wasn't probably wasn't ambiguous, and that
actually did work as an event source.

Reality matters. What-about-isms don't.

              Linus
