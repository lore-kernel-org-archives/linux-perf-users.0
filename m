Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C43E450D
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450466; cv=pass; b=RLewWnROzFQbkpEw7p2UeQeVx75tMR+fMJKPkKMQu2g2bz06dLN2ROKBX/qb90xK1suQNMbYt9whHyShOKXLoFg/a52MalRQZMSDeJkmGh9fPUOdA+pKhZL7CEzYwrSYe/oou7w350N7QwlwW/Mk8mtp1uDOeLfcqNQ2lsL3ldg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450466; c=relaxed/simple;
	bh=mxR6zo1uzVmlCvrVVTNLSNdWhxzrwV7OGrG+Af4HFoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9pMS/Z/MwWDpxYdZzwKAlRTrR38ErdqMe2Gu2rODR+BBeuyK/EJ1ucffOBetCM//wjcp4owSncbvEVVntmoTGUqlaPgErtb/9LDU+46IJLj0Rsfb3VImnMAKlrMXufHcfRKDZfzibYZ2SqhgqrN8frDfaKZcVP6C23qNcHLS+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAVr1pfw; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAVr1pfw"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e27035206so464418b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 15:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450462; cv=none;
        d=google.com; s=arc-20260327;
        b=J5rvWyi2q2vbFmMrtPoRAMSjqwxE+pCDyCBOoBihdlPoMAj2vJOify1pwuy5b7zlea
         Elw8aqHCYoND1063IuUmG7CnZOzasUci0kNA79XdE4yY6dkp/OoBqckIrQ6JkqA2yBH1
         eOamREnmSoBqpnIhPkGHZXxQqHzUpmMxGksy5kekFIeYMRMyiUdaTNcayNqX96epCx2g
         SDJjQ2ljdKyuDDQInlhFOlQv2hZ9ZaZITdrhae12U1c77unGya9mNrNkxQMQkkxVwBW4
         JV1BWoSUb15c4F/AOVBB02lvmAxaUsMOemcVLFwN5Yamj6GxsvRymICqA/q7lENdeQTI
         8JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        fh=c0ift9ijz2CUtL8waMKn2N3i7Dqyb8GIpTTcLfTpDsw=;
        b=cBMBaSRzvbe9m0uovnTKND2dmuQZHTDE5QQjIxV9hcmCGeU7o3XjbAshl9mzjqST3G
         FfhGCR+oYtWSldebAN5FDAGbEVHgXvpK1K7AnNJTm9CpzVKFgzTp2V50RsR9WKUu1cqY
         fFWjGVaCKKJgh9mW3Go/Spt15GjGG2/UgODpRWZ7tz674DESb8aRI7JI+BwsWSMJvz2U
         IRvw51ORHdkfMOYy/6H4GkDTLTzmI2AlNQyWqFdsfVuWN2qlHiiIfk698E2psSW0xXKX
         wuyjDmnXE+Q3EUipEgyr0nWJ7Ix60QJjXkEv5lph0YQLnLK6kL2sUiYwX6ICulimmQhI
         wFTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450462; x=1786055262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=kAVr1pfwLotij0D/D1LNuSSV7eWURHJKJ9ODxzZVVUGFEJkqaFm+LPBTf4faSM0vOY
         9fNS4/9fB4691cD4z+w0fTFJetWOtE6FTN5yN8WqQh5EZJIqHHKaUjatResq//qoYEN0
         hVXUQ3w/1i+6u8aipLwJZXTDPc4bFRaVFC033swyS9R18K35kYCsKyHRf95dqELAuzLT
         nGnaw3ZwL10yE7cLYjWA7+E1FJiVyucawHXoy6+aQcRsczQOnezCxO9WwqxmAsGyg3JY
         SdTHxbiujsnADkJiN+8mxrtKpubgkfZ982rI2V+9fm797IGmsaxzASE8Q9V8dMHNI+xb
         s9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450462; x=1786055262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5roJyEXd7zYUkj2A9s/Sahih0EpxfdZ7m3/sd8D6kWU=;
        b=YinzxaBtUY7GG2sal81a+TvU/hxMknfU5RzwpKhReNU9aF9PbC2SdJqUEyN/jotH0n
         aswpazXLvt/GllBFixkcZXuiCzCxSdGQuXUXrqk5Ls2uvO2s3MYtvYSmxbhb8N+Kx6WQ
         S6gbOi3FcppNR2pLUMfqmeZMDl3N/mxjljg4SUqUEkyhdDz3Rclqfr1hh3+xQm8CechR
         0W04GGQqUUhDmW019p/PIrNLiWp8FJMo1QazWgRN3gFLHanpTdzql3rssCI5UkAup4Ww
         sJSVov8RR7tXfLZPCl8cDuagPNTiwolPdrCbCKYudvYIWAtrFQW4jtJS5nsHISLkZnKX
         KIEw==
X-Forwarded-Encrypted: i=1; AHgh+RqzxRXf8GrfNfEsM+DvV0D4d0tetMQa1FGTneRrBvesVIes26PZ1Z9ygdeGUYQUc+KFLDjrQE9xeHrAcEW1KjWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0q50/s78j5FjEQTl+TfUYv/nwJzONVwej7YTFg13kqdojqJCS
	O+w0AENVH4tIH9OfDc6fx/146dfzGo5iYTePlHk/8DjKgtEIK27ukXCTScxk7v7FCXErWWGVp8M
	lwOkG3lSwW/kAJcTGIuJFxcalXQGmuWI=
X-Gm-Gg: AR+sD10xX6vuiFKLtoTCbdStmxg9ngNnGqGLooe2QwzR8c5iYVHdCeWd6+fkO9Rc8Td
	ky73jkaZh2Y0VbFoLb85F3Uw8wfkieeRzA9Rb6kLsSKL011PJAq4KcEqKKQAsJsCulT+psXK2+V
	oqFO86IixJk496lvQtF4RDKxPDGMMrmAwzvdhk/RePCukgKZ66WmDa0rZ/1d/1Zf/lpK/L9/2Q3
	Tt4m2NWNtNQJi1+4Nl4TuzmfsW5w9i9vhsRNKSNJxCupXBOMJ7wOG6enj4fr0KefxfLZ/zcWeJb
	GS95WD3o4Ygu8xbme09XIIM1BC1faFZ29f4X+NHk+Af9/W3vyZ02uOtGwq4awxrESmEki48j891
	g28K/Jb/ZDeGGPCxQNh8Etz6zb5zj/KP44sJOjscCPYnnQpGmqMepPZsHQZ8yEea6
X-Received: by 2002:a05:6a00:c82:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-84ebc1fdaa9mr3988166b3a.16.1785450462053; Thu, 30 Jul 2026
 15:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
 <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com> <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
In-Reply-To: <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 15:27:27 -0700
X-Gm-Features: AUfX_mwDesWtdCLE-1Fw6wnAI4608m7zqiXpKFs0ROJhEZiKm1s5xaCdqqVAUCY
Message-ID: <CAEf4Bza3LeVB-z3jwMdnBGLdjpPr9tZFhGHt5pUwui64ZX66Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri Jul 10, 2026 at 11:23 PM CEST, Andrii Nakryiko wrote:
> > On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> uretprobes_srcu currently uses normal SRCU, which issues
> >> two smp_mb() per read lock/unlock pair. This overhead is
> >> paid on every uretprobe hit.
> >>
> >> Switch to SRCU-fast-updown, which eliminates the per-reader
> >> memory barriers by moving the ordering cost to the
> >> grace-period side (synchronize_rcu() instead of smp_mb()).
> >> This is acceptable because grace periods (uprobe
> >> unregistration) are infrequent compared to reader-side
> >> uretprobe hits.
> >>
> >> The updown flavor is required because the SRCU read lock is
> >> taken in prepare_uretprobe() when a return instance is
> >> created and is held until that return instance is finalized.
> >> The traced thread returns to user space in between, so the
> >> lock is inherently released in a different context from
> >> where it was acquired: on the normal return path via
> >> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> >> ri_timer() (expiry) or dup_utask() (fork) via
> >> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> >> are designed for this acquire-here / release-elsewhere
> >> pattern and, unlike the same-context srcu_read_lock_fast()
> >> variant, do not carry the lockdep read-side tracking that
> >> would warn on it.
> >>
> >> The short, same-context SRCU sections in ri_timer() and
> >> dup_utask() (which guard the uprobe against reuse across the
> >> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> >> for proper lockdep coverage.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  include/linux/uprobes.h |  5 +++--
> >>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
> >>  2 files changed, 20 insertions(+), 14 deletions(-)
> >>
> >
> > Very straightforward replacement and will improve performance, thanks!
> > LGTM. Peter or Mingo, I assume you guys will want to route this
> > through your tip tree, right?
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
>
> Hi Peter, Ingo,
>
> Gentle ping for this.
>

Another ping, please consider applying, thanks!

> > [...]
>
