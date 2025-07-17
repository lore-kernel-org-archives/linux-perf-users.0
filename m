Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B720ED
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777366; cv=none; b=rmE65f9zSWVKqwIXy+LaW4yrSBxTDDJf6UfXd+DosprCXgrlNzj3WNzb/jnU+blZbE88KJmK04clk6ynXKzZTB+z5vY1fyCWqccnSE+I1ikZDWYTOF0pjO3Ng+5Xm0UtJA1QoS6fU1tit5UWcKcKItbPAa566bRXivbzPvjFh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777366; c=relaxed/simple;
	bh=nT1GppLNav7xgnl/ObI19ndyqjnUwbm8v4pO3iyByg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIG+fUgfAW/BwuyNNUhSsxojy6ZPyhVBN87xZOJqoZ8YhuUjCBjgZCG6SU+Or/fPaTCOIR3yi2qH8q7i7l+r5uPAcVYw+ycqG/wuvpqNBK6xSnOyDDr7/gQdFVkzzA32a1HuL0j8G7y3LuAMuzrH/wKxKfoLqrjHFgYa5zVZ5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QqG4lPDd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QqG4lPDd"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so2457840a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752777362; x=1753382162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=QqG4lPDdGI52mriQlxm8gkhkDgRBvkKYlwsLoDdItzckUU/QrCT+p1yMZgdVVF/4nv
         fs4CsRKSBFXm7GWA3TzoGboMvVvI6keB1x8xis0nuT7Fq084ybRfz4r8bmDFzVFj5zj2
         2DAzkRHb/IVHCcI2GExgraOVw2NzNEugQT1/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777362; x=1753382162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=RD2y4/7PfijhmTWCUlwCzZpjTypGESdXM0cziZ/dvWcRN57U6LeuQd/Zwy3seLDy6F
         zTFrIAQsbn6qp/6ZAJgPFKMiDidPZalG+cYVIcE9JLtwO4qjodRCzpW111luJxdF9cgx
         inZdeVTzU2ExroHf/htbvH2MVgEaFdf1AGySM9p2tvjsCldtOabuYyv6ZuEnTRWA4VC8
         rqllBZnXGOJ1GF2X8nxDrG6/99wJSGWSt/WsP9zPAvHh1XEEXNunFWjC7EqVJT0PxZfF
         S7Z7PF2Po8cfb2gzQSJR/6HPE8jdpXhDU0WpG3k0RRhimIT3RPUkpFFNW2cS4XsMZ/0C
         OYcw==
X-Forwarded-Encrypted: i=1; AJvYcCWlGcDjIHQNlT29qj6dKbnbdC47Cg2VF9aph0cyFuRiAdBigiD+rTWCsB1FobNcqA4VD5YUTO7DLdwz6zcBfuc/@vger.kernel.org
X-Gm-Message-State: AOJu0YweL/xHl6At44A3Esdgu9t+tB3A4bWRPocYM9Fn4ANstk4NTWI8
	XdlqD11Op/b4g1BkxTLx+w/ryg/DowSsc2dGFD6jTnj/cmog1Fr7lvZCNO5ceMgtTJKrTfxTUXA
	IUVs4/Ww=
X-Gm-Gg: ASbGncseQ8xueOi9WHgsiDWKA1f/gZ3ZuSh0hUgc5wDyQ4KlBVpHMsxqPECMx2fu114
	2Qx95YWPvw2wO96tKnQKyJyBwSsomyzz1Z4ch9IVRPk/DkB0jn1aFQmqMxBYbpx+Tc/PcIs/HpY
	eiuKoMZvk9K/QBru22b5tI7X6p5wcBEiQANwfJSQNUUiq6ZzSv0LnxqCa0y4RxeiRmrnr6bcNAv
	2YIVtden0yi4S9jqC4nE4FGCYes31JbnPxLkYsK8M/6etk1sJuaFkSFZRrBD12hcVPIoAa2BwsK
	kh9pJZrg4OtBUxuVS9SZ5efqgMqNT6b+sJ9b5ZEwvpy8DAyHyPsqRShBk8zbijDo6t73cRW8hyM
	byaQz9XdH0rhq4bt7gj1V/ErD+u0PlWlANTKRszDkFcSbqEaZ5aw1lbwaRj7Li1I/hJPNJxHP
X-Google-Smtp-Source: AGHT+IFMnufvOzca/F3+S/aB5ddOAfqKwI+AwtkHys/fz0CwOFimo6lrHCgRTIhdQ7VCR7HSphZF3g==
X-Received: by 2002:a17:907:f1c2:b0:ae3:f903:e41 with SMTP id a640c23a62f3a-ae9ce14b264mr801186866b.54.1752777362074;
        Thu, 17 Jul 2025 11:36:02 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee569asm1392545666b.44.2025.07.17.11.36.01
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so2457817a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvjL2fprnfSEtMbZyyvlJG8W0qPljOwFL6e9f1jFBauCn/0B/j1BArFxjzPKuHenjRXCgfNTqQyT4iQGU60TU1@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-61285bf3730mr7487110a12.30.1752777361408; Thu, 17 Jul 2025
 11:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
 <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com> <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
In-Reply-To: <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Jul 2025 11:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
X-Gm-Features: Ac12FXw_kNIbTRokcm7T_S0XklVgvPSebW7F_Vtc8CMTkt7DzdcMPhb6rT3qzqo
Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bhupesh Sharma <bhsharma@igalia.com>, Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, 
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org, 
	willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk, 
	keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org, 
	kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 13:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> But given how frequently task->comm is referenced (pretty much any
> profiler or tracer will capture this), it's just the widespread nature
> of accessing task->comm in BPF programs/scripts that will cause a lot
> of adaptation churn. And given the reason for renaming was to catch
> missing cases during refactoring, my ask was to do this renaming
> locally, validate all kernel code was modified, and then switch the
> field name back to "comm" (which you already did, so the remaining
> part would be just to rename comm_str back to comm).

Yes. Please.

Renaming the field is a great way to have the compiler scream loudly
of any missed cases, but keep it local (without committing it), and
rename it back after checking everything.

Then just talk about how every case has been checked in the commit message.

             Linus
