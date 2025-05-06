Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA1450F2
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510940; cv=none; b=skg1GEbTnWVGV3LBwT132owXpE3rSnwxoV/dN168/zdFvaVMsbaNhBIo5vvTbqIPeMOaHOuOJy8x+J13tZMaupbjKa2k8GgO3vnHd7Rd6Xu/Bh/s+sCOB1/GYvxQLTrop55NyX1FcXi6/5PyRCNVRFBKx7f24S2W4fIZo0IcU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510940; c=relaxed/simple;
	bh=bbg8aE81iUeNiDZF1MGzc6bTtql/UMVFOFLOhAydfjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH3PsEzwdRl87afP8oviop6R7AsEd4Flv5dRd2V7kIeTiFf5BeTGP4pQ8L5EonVA3HtZIC8QcfyOTTxD6dTWvXdyxp9VzAFT7PvBHKfhes/hfv9UwCGRPxCBWmBGumXjxkEVxWDmdS5FdhiVAGyoaYOrpG7MRSzhaRjp17CxWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNcXxzYh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNcXxzYh"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so51606531fa.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 May 2025 22:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746510936; x=1747115736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YN6ZkVN+p85UYTJ1uEVJUwHOFyEfoNRoe5b4WgP6N7w=;
        b=SNcXxzYhs5/AcE+tfJOnkbGu3njiJnF5+O6Jjk7di6dV4i/2g7JNAILrVMYnyx23FP
         Bn6KtMvrlHNC1SeFB83OknGdT8gADHZSpnOczHw2ylwwca30xAjpcjM3o9dnhcTgMFiF
         HC0dL6zO68WmGGLM70RiGYqNR7DOQTk0oGKTm/dVa4Je6wu8yRS0LDgqruBRM5+f38Nk
         cJoR9R5+xrQnx3yPSI8FEnhsaXOXnZM5t7iCugOYPQRZ2Ck97UZZJNuBRHnJv7v70e/b
         e9Bo2j5R/kj9YY4GeMeMI7TlhuoozUWXq2S6Xp38IEj67tiSrAj2l0AQJI/gYdZTm+4o
         y9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746510936; x=1747115736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YN6ZkVN+p85UYTJ1uEVJUwHOFyEfoNRoe5b4WgP6N7w=;
        b=u9qW/Ujf1sgqCinegk6O9FODLM5jfWjHDQZhe+IfdmkCizjZy8+fXrwW1nTcyGiPOD
         /ZeAn+6lFdAIMR+KiWmhJ9b0nvt3ROUaPvpUvL9KzGY8IvcPzF0h+IM/yLwhcPWRFy6e
         xq2S4AASXryfkAZVlgZBmlqX7WM4TFZOVkWpetzCYbkEMjia8h5y894I11nhyOe+5DDY
         WjTgr0yTqeqJSU9phQBgIEZBWRsMBfnsj1lcxGRS7Pb9k6WxoArDb9yO1KrTqrwnt2nY
         vM0sJVPcT2fXEFac5vEdbFVAixpv33PISQAXA07EcGPOb7f7NHBQ126LYHivju6vuqU/
         yGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7N9FqvThqj/24veRlsXJtTSIMjY7APe8yEZgHV9x2o+HiFdv/c4cIJOCkVDGfedyQdvez65WW6tQZpglY9KgE@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxuvQp/IQRW48Pc1WBNevFPuykjDbc90t8qdDmEKT4wcY1McW
	hB9Ui9PDpFmLGWZe0OJ9Ffn40/nTA9CGtkZLtIXW2ig2/2XsurwnnrF9WMRkJuj5FmfG+of7UtS
	AfQo4Pm4hvnPBLks7EcSbNLgy+fvV814n0BGW
X-Gm-Gg: ASbGncvyjf9BRY1ntzaHciqCkuWGw2oWB0GPCrZXPRa55nOsnVQF+kQviNMmjHxinOd
	kU+VUd1M9SvVQp+Ln8B7XEaoZHtvxXTIe2n/UXi/q+oPmRVoFsCKNac8a+4Fcz5i3CKbrjLZzgD
	+xNHVf073OATVXQXDvcJJ6spVnZ+RVoCpiWPmTRrCEDdYkTIkZysgfMxk=
X-Google-Smtp-Source: AGHT+IHsIk28zJMcncG8p7BszPQDRO9igxHegljSXjUZlgP5bjEPHbU/3keGB/2EMPEFSEM15W6T184/cId4/RjRHXE=
X-Received: by 2002:a2e:a547:0:b0:30b:b956:53e5 with SMTP id
 38308e7fff4ca-32348b4dd85mr31334831fa.12.1746510936195; Mon, 05 May 2025
 22:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org> <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com>
In-Reply-To: <aBmei7cMf-MzzX5W@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 6 May 2025 07:55:25 +0200
X-Gm-Features: ATxdqUEh1iZsyBF0tsJGQfvphUe0MbKDfV7H5u0vY5Ty3Aqja6LdhhLx5G8OWZ0
Message-ID: <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 07:30, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, May 05, 2025 at 10:08:17AM +0200, Dmitry Vyukov wrote:
> > On Sat, 3 May 2025 at 02:36, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > When it profile a target process (and its children), it's
> > > straight-forward to track parallelism using sched-switch info.  The
> > > parallelism is kept in machine-level in this case.
> > >
> > > But when it profile multiple processes like in the system-wide mode,
> > > it might not be clear how to apply the (machine-level) parallelism to
> > > different tasks.  That's why it disabled the latency profiling for
> > > system-wide mode.
> > >
> > > But it should be able to track parallelism in each process and it'd
> > > useful to profile latency issues in multi-threaded programs.  So this
> > > patch tries to enable it.
> > >
> > > However using sched-switch info can be a problem since it may emit a lot
> > > more data and more chances for losing data when perf cannot keep up with
> > > it.
> > >
> > > Instead, it can maintain the current process for each CPU when it sees
> > > samples.
> >
> > Interesting.
> >
> > Few questions:
> > 1. Do we always see a CPU sample when a CPU becomes idle? Otherwise we
> > will think that the last thread runs on that CPU for arbitrary long,
> > when it's actually not.
>
> No, it's not guaranteed to have a sample for idle tasks.  So right, it
> can mis-calculate the parallelism for the last task.  If we can emit
> sched-switches only when it goes to the idle task, it'd be accurate.

Then I think the profile can be significantly off if the system wasn't
~100% loaded, right?

> > 2. If yes, can we also lose that "terminating" even when a CPU becomes
> > idle? If yes, then it looks equivalent to missing a context switch
> > event.
>
> I'm not sure what you are asking.  When it lose some records because the
> buffer is full, it'll see the task of the last sample on each CPU.
> Maybe we want to reset the current task after PERF_RECORD_LOST.

This probably does not matter much if the answer to question 1 is No.

But what I was is the following:

let's say we have samples:
Sample 1 for Pid 42 on Cpu 10
Sample 2 for idle task on Cpu 10
... no samples for some time on Cpu 10 ...

When we process sample 2, we decrement the counter for running tasks
for Pid 42, right.
Now if sample 2 is lost, then we don't do decrement and the accounting
becomes off.
In a sense this is equivalent to the problem of losing context switch event.


> > 3. Does this mode kick in even for non system-wide profiles (collected
> > w/o context switch events)? If yes, do we properly understand when a
> > thread stops running for such profiles? How do we do that? There won't
> > be samples for idle/other tasks.
>
> For non system-wide profiles, the problem is that it cannot know when
> the current task is scheduled out so that it can decrease the count of
> parallelism.  So this approach cannot work and sched-switch info is
> required.

Where does the patch check that this mode is used only for system-wide profiles?
Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
