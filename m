Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71C22FE00
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925128; cv=none; b=FHQiY0wSE5gECfPny/Tti2HNQauOb/otMX/w65mhZ/nTansgQvpQt1ODnCgZyaLwyXA57CsjYk/Juoq2JuK+P15A8ZJWZtrMkq6E+lQ36DtkvicWWL8rLDEmUlN1/arkf+w77zPQIjog0kEq8+WCqPLA3MUp0GmouKXfGcePb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925128; c=relaxed/simple;
	bh=XbnE7ShtiHifaXcmvNc9qzy/uvAU0Ue2ODxgdDoBeHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E66gdrKDkgRi2M+TLbFvXSqNrL+Wy6mLE6KugH3R82v+BbY+rr5qxtZs0tlEJ15IB+IfAkJTZMYe6eKtYis47HTNUwYYUVlOIcvCXr44FpOrlzdgdCAewAR5nRUlLtc/ZgTJgAICSetnvdZOgoYdfz2N2u+/rC66hNJY7yUsEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/PBOjJm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/PBOjJm"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3061f1e534bso27592211fa.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 23:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736925124; x=1737529924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW6tEaHSv0VEQi6H89tqh39jnb+za1ZuTvq3kyjFWQU=;
        b=e/PBOjJm45O/KK77izkHhBLvedI4UyUtXl7Nket5RkuiS/ew7d3idkE27/4/FOb8iu
         xJkp+7XYRVwcv61XUkdDkY2v2nb7NZwlDMpch/ykVDXUCfFNE+JpPz2kvDb4mHnpUVhk
         u3cmzJ7AVmyMhAXlezxw/BIgumi2k5E1+NEYedSESBi+vin8xEZSUgweFgNpjSRo6A5w
         Aye0Nz6Xcuipv6z0JKEA6Wn6YB4tFJtEJDwiZVSW5GkQYqs9sqHHHkg8TAOdn1bPClxs
         iifY4GT2+YSZwRqFXwBoGrWFMLico8t+sUlydm+1CAVfMIoiv/3iOscj0Kaw3jVyd8wv
         c5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925124; x=1737529924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW6tEaHSv0VEQi6H89tqh39jnb+za1ZuTvq3kyjFWQU=;
        b=jsLkIZ9uDcTbLXh7tS6rUnRZOthsNO/Qh8yzmi8Ike/opH4Ce1428nVBzXrZdTexWl
         Ur74nvLhBLrvUKqiAA2k/lbTNrW+OXsiqeRkvrqiwlfGjBK7p4f2kcxzNEX2ovZe7uMJ
         7i/GziV2JeIM8T67Nrh6Gf54DGUZolSrIQrhW4xP+rhhG4vaf2CjuR43elk6dFZFCvzJ
         mdV0Ho0vwk9feTyt9Vwb3tVnfHIKKbblRy6B2i3P0GWrkDlpZ0tgUtt4j3WmWDbnWzzo
         VoqTbnFLQMJOc6hL71uKuDiShpLw5hpfiRJqfMDL3vlX2EeYDeDmPQDxy3+/zrC2gTdR
         2Owg==
X-Forwarded-Encrypted: i=1; AJvYcCUXSIBzNZVwTaz2ke3SvC9Lh5RtY0LwhHhjPxk3mLZv+sAlE/u5pa+Q3kHMnsZTEG10BctUUhsVeVgIEbJ0TfIM@vger.kernel.org
X-Gm-Message-State: AOJu0YzRX448IW4qETxCHJAdFAS9Tf/DSJdnT4qijUP9IkyeUxQuADPF
	ExiK85gHKhIcBDcOUPGsULN4eFppv9rcxX2KcDNWO9oW2C6hkhmYpuJL4/796S+n07Uv9DGu00x
	rrcstQrhoGr4r/2UwrB0puBmYIDBAr9PNueZa
X-Gm-Gg: ASbGncujSftXstfzLj18vmHglZJwHpMOdWi68R8Mh2E3x11CpYkyRgPEbViRKatwnzl
	qpl1XtinXwH48Jpyv5kJtSZp7O6qNWaltNiGQU4rGVFznpjL7Q723vwXP1tesQfAGaW9kDsM=
X-Google-Smtp-Source: AGHT+IF5f7dNGLbPoG0PU7iobFfKN8UntxnjhVYZtbQHd95KPjJ/ev4q5/9wUru+7Fv+pBorhNlh2jDVnbEM8vYE5VA=
X-Received: by 2002:a2e:a98f:0:b0:2ff:d49f:dd4b with SMTP id
 38308e7fff4ca-305f458a81emr84141321fa.15.1736925124316; Tue, 14 Jan 2025
 23:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com> <CAP-5=fWHivx7Q6okMwYOs=65MZr40RjE16tgatMX0hjkCfrwfw@mail.gmail.com>
In-Reply-To: <CAP-5=fWHivx7Q6okMwYOs=65MZr40RjE16tgatMX0hjkCfrwfw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 15 Jan 2025 08:11:51 +0100
X-Gm-Features: AbW1kvYgt2DknR7rt6Jg6IM6PaNsBcggfNdybnbisEbJ4jolXPxI7MQJrHehK2s
Message-ID: <CACT4Y+Yh98VcNgmJ-gF9+inw=ZDkg1rRzi4_35f6krw8BBRpug@mail.gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 06:59, Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Jan 14, 2025 at 12:27=E2=80=AFAM Dmitry Vyukov <dvyukov@google.co=
m> wrote:
> [snip]
> > FWIW I've also considered and started implementing a different
> > approach where the kernel would count parallelism level for each
> > context and write it out with samples:
> > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab=
496c1a9f2
> > Then sched_in/out would need to do atomic inc/dec on a global counter.
> > Not sure how hard it is to make all corner cases work there, I dropped
> > it half way b/c the perf record post-processing looked like a better
> > approach.
>
> Nice. Just to focus on this point and go off on something of a
> tangent. I worry a little about perf_event_sample_format where we've
> used 25 out of the 64 bits of sample_type. Perhaps there will be a
> sample_type2 in the future. For the code and data page size it seems
> the same information could come from mmap events. You have a similar
> issue. I was thinking of another similar issue, adding information
> about the number of dirty pages in a VMA. I wonder if there is a
> better way to organize these things, rather than just keep using up
> bits in the perf_event_sample_format. For example, we could have a
> code page size software event that when in a leader sampling group
> with a hardware event with a sample IP provides the code page size
> information of the leader event's sample IP. We have loads of space in
> the types and config values to have an endless number of such events
> and maybe the value could be generated by a BPF program for yet more
> flexibility. What these events would mean without a leader sample
> event I'm not sure.

In the end I did not go with adding parallelism to each sample (this
is purely perf report change), so at least for this patch this is very
tangential :)

> Wrt wall clock time, Howard Chu has done some work advancing off-CPU
> sampling. Wall clock time being off CPU plus on CPU. We need to do
> something to move forward the default flags/options for perf record,
> for example, we don't enable build ID mmap events by default causing
> the whole perf.data file to be scanned looking to add build ID events
> for the dsos with samples in them. One option that could be a default
> could be off-CPU profiling, and when permissions deny the BPF approach
> we can fallback on using events. If these events are there by default
> then it makes sense to hook them up in perf report.

Interesting. Do you mean "IO" by "off-CPU".
Yes, if a program was blocked for IO for 10 seconds (no CPU work),
then that obviously contributes to latency, but won't be in this
profile. Though, it still works well for a large number of important
cases (e.g. builds, ML inference, server request handling are
frequently not IO bound).

I was thinking how IO can be accounted for in the wall-clock profile.
Since we have SWITCH OUT events (and they already include preemption
bit), we do have info to account for blocked threads. But it gets
somewhat complex and has to make some hypotheses b/c not all blocked
threads contribute to latency (e.g. blocked watchdog thread). So I
left it out for now.

The idea was as follows.
We know a set of threads blocked at any point in time (switched out,
but not preempted).
We hypothesise that each of these could equally improve CPU load to
max if/when unblocked.
We inject synthetic samples in a leaf "IO wait" symbol with the weight
according to the hypothesis. I think these events can be  injected
before each switch in event only (which changes the set of blocked
threads).

Namely:
If CPU load is already at max (parallelism =3D=3D num cpus), we don't
inject any IO wait events.
If the number of blocked threads is 0, we don't inject any IO wait events.
If there are C idle CPUs and B blocked threads, we inject IO wait
events with weight C/B for each of them.
For example, if there is a single blocked thread, then we hypothesise
that this blocked thread is the root cause of all currently idle CPUs
being idle.

This still has a problem of saying that unrelated threads contribute
to latency, but at least it's a simple/explainable model and it should
show guilty threads as well. Maybe unrelated threads can be filtered
by the user by specifying a set of symbols in stacks of unrelated
threads.

Does it make any sense? Do you have anything better?


> Wrt perf report, I keep trying to push the python support in perf
> forward. These unmerged changes show an event being parsed, and ring
> buffer based sampling in a reasonably small number of lines of code in
> a way not dissimilar to a perf command line:
> https://lore.kernel.org/lkml/20250109075108.7651-12-irogers@google.com/
> Building a better UI on top of this in python means there are some
> reasonable frameworks that can be leveraged, I particularly like the
> look of textual:
> https://github.com/textualize/textual-demo
> which imo would move things a lot further forward than UI stuff in C
> and slang/stdio.
>
> Sorry for all this tangential stuff, I like the work and will try to
> delve into specifics later.
>
> Thanks,
> Ian
