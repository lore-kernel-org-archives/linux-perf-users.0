Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815022C0F8E
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516298; cv=pass; b=OOt2ttstWO++ujoQtKGgzlb4j/brUfGKR4kLnwRt2AZcZS4Qz9C8QX7VJVyyEY5S8iNGh/rL4UwRgawNPP3sfGbgIbibjrJX528dF0OZdwuB7OktLeFXyr2R0LU+HR0U+hoR37kKzIRrh1ua9Rv7d5SMAgCOVRGyF/7zx/Gku5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516298; c=relaxed/simple;
	bh=m9PM1iMm44gGDFSDZkdisKJhJFJnJjV42RymaFR+TIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxFLFXjlL65hZh9wNziYEIrqhHEL/4rjOFDGuASGWlFKrb5XnYVAwKYeELbaYWn2qLUmZuzAxlhbuaK7aiG3aFGGciiOaOyWlhIx7PPhC2yRs0FA8FBLqpJptAhJpppE+QL+mbKOWt55ekRW9ney7DDyC3dlvSNRptlQMHHPMBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwdViGUa; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwdViGUa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2980343d9d1so326995ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Dec 2025 21:11:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765516296; cv=none;
        d=google.com; s=arc-20240605;
        b=i3AlUOdXJ1E69hfEWyEnW7AwGXQJPDCrV/ZpZrt4aoqqecNYjvBz7PDQoXMaHCFk78
         sBauycpLj5YVzUmWWjHJ4qh3T1GEfNZJC5nSsRxmtCyOJvG66zjryMaZ9BpOVrNyHvyn
         LSCVhO0DQadJKzarL5nJUzAOONyjXm3vetpHXLmk9yHMX4eei78rzXpCkEInEJ0V2zEb
         lt7ZIz++7CVHSfffcDbEJUJ65IqRVKtizFCoIPP6pKxDmKlUlljDvD4h8kPDbmZ3lv6J
         NEdO9lgRKHmJS47IWaFZC35GAYe29sEd1MpWub8jyjMxwWsdZPxelma59NpRiJh9jJ8w
         WhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eYcGx39k9tHKzAlazzOCB5+4YdUmzp9vdHlF8vgfugk=;
        fh=DNbKiQtorfA5o80FSXeT/cbi+2aKKAZHn8sh+6fYwGw=;
        b=IEGFg+YuROACF0wvrPVOOE304t1LsymVt2RzRTBRY0/FFiqNtIaknXSkOg6wHfkXDt
         KNRe3C9nDA7Ji5Dvw9eqlkNsbv1MS9EHngJLMFmEDwZAeujpUAE7cEPog/qiTWGjW+2p
         qI/4Y5IL3DY7+KryJrHIxteUrDa3B58nZZzUQeW3/bq8sBK/2QFZAfPjMgbtVD/RT1PB
         1F/zjMnqrBe45DriBnrbbMLsUHrMG+jwO2gSIyfkteH3kL/PNh5OzK/nW6PoD1Lox7Sk
         S8orn4E9lzQ4QnIA0P2D8WzUlRYoyoAOJ5nhlJR3PblVypf2hxUmHeHk4jWBjGCdYxjy
         +A+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765516296; x=1766121096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYcGx39k9tHKzAlazzOCB5+4YdUmzp9vdHlF8vgfugk=;
        b=DwdViGUaWX6lyoGJ0GpAoCmeNgD5L1cG9UXR7YN6jJwlJfuuKkFvvHrZhEW19hfM69
         vHCEcPe21B/FvK1f5Mrj2mCagaTBS0haf2ZJxDtWsP6qXvacPiSzwj1WWSMPYKreZlfp
         5Ir9rcH6GePI9ZiYEC5ZATxXlQB6j5SuM+nT8PanQYR6LB03/+iJOsjrcA0rTy/Xd22x
         otKDs92T2uqBdlTWmFtxyL+3Th1xaOQ9Gs5RKsVLoC/GfCVaMaNQS0/5O/JT1WslY5+y
         kThNy/6QoZdqEDcVrs5tBTC4gP9q7Y6aw7djQeiNUECl+yPT6a/iXZoSyJlMtRd/2tut
         ctnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516296; x=1766121096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYcGx39k9tHKzAlazzOCB5+4YdUmzp9vdHlF8vgfugk=;
        b=ftoGAI8zkN3UozGel30XF/BPXaRaz9BC4qOXcpIBXsvybYHx7i7MrUy6nwa96aYKFb
         rBjBTV8cgiPH9pLPWSZhriMXA2wxliEvNLAQZ8fK3/OShBcd/JKLaoY7vuNHZrLN20SG
         UEMhRRyiLFZhvAr6o/sPg9Utti3Nia7/MHpJfFSIFmiASglyRya4O2CnzvbA2AS7vAu5
         l4hcpHlXHUK68x9qsFRQjSxFChWf1kmIEKxnbmtDOqBWuPBY8FWytSPnyWqahflzltQd
         E3MQ8zs7wn/K2c1sFbsGEoM7m6zVwZPhgtYQrTCf0KdYSvmenkWBPdilTL30kCUjvEV7
         OUsA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+up7D7jL4WHr4ttEb5m3cpiJGXOh9yiBvumHFtNPdt1u8WRO1d0v3/cDMhnUxq/RZq9hc2HnFsb5hR+54u6k@vger.kernel.org
X-Gm-Message-State: AOJu0YyskpamyiInZpvr1jxCt5vhTrK9cCJnNCchlBRSFdBdMiQa2ABn
	+tfYIksQvJ4JuB4KMrmVrHfsl7SlSMz9v1Vavno58VuQ1sMUXEiwsu2Y6VFVNM+R/JI0LUxFBRf
	uSGkLdp4wQkER30JwDhZ3Sig194LssCoraLvq3g8n
X-Gm-Gg: AY/fxX6G6Q5j03pH+3IX1peS8xWrP6mMvVpsapJKKBE2JU8XZ6JaT5wvy7daDaTPJJS
	MkDyUWEWC4eysjI8LKHma51xt+golr7UkA8RKtyPhyXkSmuWa8ulx49f3rK4woy62lzwsuKYwvt
	WBf93cXxehcHuV6rGuXeerVnahuCicNSsTD7LwQTZYhEkmFVxqTX5eFtbdDPSGsMlyLJYTcfknx
	rQl0W3ejx2rrGvkXrei02UgYro5WAp+XBGyax/++NpAQhVgKgL/WD9fn8AkV7xmqvCZHvjp
X-Google-Smtp-Source: AGHT+IHPiVHqZ4Qx/atzIrknue67A6y0ErgnO88TKvjCdA4d6o0d8NXNBovB7OC5KD1s6hlKRkY/ad1UHsfh5DFkVlk=
X-Received: by 2002:a17:903:2b03:b0:295:30bc:458e with SMTP id
 d9443c01a7336-29eed326705mr5807555ad.3.1765516295309; Thu, 11 Dec 2025
 21:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
 <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com> <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
 <4f231fbb-d38b-4c0e-82dc-6b334f340943@amd.com>
In-Reply-To: <4f231fbb-d38b-4c0e-82dc-6b334f340943@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Dec 2025 21:11:24 -0800
X-Gm-Features: AQt7F2oAxVK-J4stIjRTW9aCtMPT4ETEBJxdRwvZXASksVqEUrYAFmkWsk1yeo4
Message-ID: <CAP-5=fV+wNXdJpgWLSvxcwukc3qciGfFVjUbv+3rE0V-ExqW2w@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] perf sched: Introduce stats tool
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, james.clark@arm.com, yu.c.chen@intel.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	rostedt@goodmis.org, vincent.guittot@linaro.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com, 
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com, 
	sandipan.das@amd.com, Cristian Prundeanu <cpru@amazon.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 7:43=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Hi Ian,
>
> >>> Next is CPU scheduling statistics. These are simple diffs of
> >>> /proc/schedstat CPU lines along with description. The report also
> >>> prints % relative to base stat.
> >
> > I wonder if this is similar to user_time and system_time:
> > ```
> > $ perf list
> > ...
> > tool:
> > ...
> >  system_time
> >       [System/kernel time in nanoseconds. Unit: tool]
> > ...
> >  user_time
> >       [User (non-kernel) time in nanoseconds. Unit: tool]
> > ...
> > ```
> > These events are implemented by reading /proc/stat and /proc/pid/stat:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/tool_pmu.c?h=3Dperf-tools-next#n267
> >
> > As they are events then they can appear in perf stat output and also
> > within metrics.
>
> Create synthesized events for each field of /proc/schedstat?
>
> Your idea is interesting and, I suppose, will work best when we care
> about individual counters. However, for the "perf sched stats" tool,
> I see atleast two challenges:
>
> 1. One of the design goal of "perf sched stats" was to keep the
>    overhead low. Currently, it reads /proc/schedstat once at the
>    beginning and once at the end. Switching to per-counter events
>    would require opening, reading and closing a large number of
>    events which would incur significant overhead.
>
> 2. Taking a snapshot in one go allows us to correlate counts easily.
>    Using synthetic events would force us to read each counter
>    individually, making cross-counter correlation impossible.

Thanks Ravi, those are interesting problems. There are similar
problems with just reading regular counters. For example, with the
problem in this series:
https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
that was reduced to just the remaining:
https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.com/
we could do a better bandwidth calculation if duration_time were read
along with the uncore counters. Perhaps we can have say a "wall-clock"
software counter (ie like cpu-clock and task-clock) to allow that and
allow the group of events to be read in one go as optimized here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n1910

So maybe there is potential for a read group type optimization of tool
like counters, to do something similar to what you are doing here.
Anyway, that's a different set of things to do and shouldn't inhibit
trying to get this series to land.

Thanks,
Ian


> Thanks,
> Ravi
