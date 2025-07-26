Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A6226D1B
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573076; cv=none; b=TPEKYGLCssjDxFfX0A6FYnzkHjhroC1p9fJkjo6ZPBzgJiaBKyQLDkF73dNpYgk0iVjH+VMAggKEHPURqp5J4khNM/38kIJUw9wRVShM4YrTGnL9xJvVkvp8Ovbzhgqx9SjJ0Y7XOEEQ9DDPXj28rj5KcVCpUSg91yfBzmXNMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573076; c=relaxed/simple;
	bh=7B24QJDsbG9O9xyrIOj7H/k5Wjt7NkdzQ2ZYcADPiko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaiqDbsve2TKSTDmusG3dKPj4x3CBffEno6W1drWtNxzjItHIw/R7zPyd6VPgaIVFZ0g0yiwQ6FHLlQHVDUR6SWkmkLaaY3SOJdRIMgdsss3IIV60683TzgcF9Abp0BY+wj+RlbFPwbSTleUS9J5yAZ1KQKQIKSx4ch0lKA2nQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YCpSn1le; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YCpSn1le"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae360b6249fso550134466b.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753573072; x=1754177872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=YCpSn1leoz8iY+M1vcgUvBZAhIM5A+TzG88DyCPofvwrQz37gx7TF+UOReUjPlrwZ+
         8NxkmnOjg4W5+g3RrUorRFQ974SK4fOQTxGdOTlp4MYQREzeI0+g1hgn3+nsgWl2tA9e
         X328Xr7ZhwkqdGRCPzUT7efqp/1HlPTs0z540=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753573072; x=1754177872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=gtBfLWh2tsCsdquOOJKZT12opnP2n2ehsDqL3g1ugnVOJqkfBBHIvr0bBBUYHBFRh9
         WKUc63FccT5W5l773TirnvwW4E9cwNL7UP2/Hd5VSE7cQ8MfHaWs6QbKkSWb/z62lBTh
         TV/IwM42tzL4OrDJIX0jeAc12s80wL1uTsrkCaUd2RrvKMRqnHhziv7udP5Hiq3B2Shy
         5tmDBW3i3uHSaC3HotGgBpr0iLPFLNEVT1IVGSIunTEEU09mkFQBdF0gWf5qCMcBv0hO
         wLKEELuz6y6YAlvmkA6FY8Wopuo2ylLwiK0+r79IdX47Xqfhfk4kfZYknQupjrw3kbG/
         WPYA==
X-Forwarded-Encrypted: i=1; AJvYcCW1VR3eHXnmTCYbOmJJhlyTYZ7olKYEqFtLBgllD+7Z8Av/xxGaHtjGydcgZjQ/jhS61qbfR43N0zEMKf6TXeEs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7PeeBlA0bsfBzeJOz01NTBiFquoUhOLJ8Iv5Hi6o9KkdQgY2
	e5hLXSXdn5MyEBZFGkoUk2Bk1epq/d19GdbIeZqCZPH6yZxbK6qV9RvAopIolc1u2NEnNJpJBzy
	R4YineRWDPw==
X-Gm-Gg: ASbGncvl6NKrdtPbRBP4aPwqYhX0yWp+/rKAJmATAH3LwnwmY18YWa80Oi+NQ5VlQkQ
	hBPy5s2TYIwnVp2bFuCyw4HdpneF55/PT/fKqkhtTb1N6VAAww1tkFP2f0JMtp0joyWmkbZGLpz
	mB8cuhkOsOL9JoowsaYeYmV7pYnu+c05b4zJ/1TwTZFD0SG/0o3vOz48wTpXXEzQKYvKyI0vL52
	Mn+qQunl32DWoUPeNeH9pPJFpdSVKBdE79lzylk35e0h3XS6/uPB0217GPyGpyWwig/NZHOdWtq
	v82d41aJ9UPLp+WjaDdROsa/zP1sN+vbWYQ4pm8CEd4AY/q6zncJ9hvsu4b7WIHtQSy3f0xagbH
	fEoZ2nBaK1QbOiKaewxbDS2druNkUKi4bCf0kJ6fYboURR+/bdKa79BZaIDJiERtZ7fPV5DJJ
X-Google-Smtp-Source: AGHT+IGq1w8AqO0FHfSJZ7JiwoPNtEKlIgepIa4JhOSlbpOhRKERda9Fv8TYn2Dg//gqkCMCDeb7QQ==
X-Received: by 2002:a17:907:7207:b0:ae0:abec:dc13 with SMTP id a640c23a62f3a-af61eb1c9e5mr632252166b.53.1753573072481;
        Sat, 26 Jul 2025 16:37:52 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a618fdsm207637166b.82.2025.07.26.16.37.50
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso5286893a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrzBDHfK31n3QfTQBZCUVcWAqe3k4n44j68/2iIxRoQOoVnrZft3Ma+Oc8Nn18gNFVc4FNho5PefH10rTcKl5C@vger.kernel.org
X-Received: by 2002:a05:6402:483:b0:611:f4b2:379c with SMTP id
 4fb4d7f45d1cf-614f1dced8amr5514831a12.20.1753573070075; Sat, 26 Jul 2025
 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook> <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
 <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
In-Reply-To: <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 16:37:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwLhT2VoOEv9kNeOdgouvN4zZ9YLvHzVMPIsLMuRmQFnkSkLFn13r5tjO0
Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 16:19, Kees Cook <kees@kernel.org> wrote:
>
> That works for me! I just get twitchy around seeing memcpy used for strings. :) if we're gonna NUL after the memcpy, just use strscpy_pad().

I do worry a tiny bit about performance.

Because 'memcpy+set last byte to NUL' really is just a couple of
instructions when we're talking small constant-sized arrays.

strscpy_pad() isn't horrible, but it's still at another level. And
most of the cost is that "return the length" which people often don't
care about.

Dang, I wish we had some compiler trick to say "if the value isn't
used, do X, if it _is_ used do Y".

It's such a trivial thing in the compiler itself, and the information
is there, but I don't think it is exposed in any useful way.

In fact, it *is* exposed in one way I can think of:

   __attribute__((__warn_unused_result__))

but not in a useful form for actually generating different code.

Some kind of "__builtin_if_used(x,y)" where it picks 'x' if the value
is used, and 'y' if it isn't would be lovely for this.

Then you could do things like

    #define my_helper(x) \
        __builtin_if_used( \
                full_semantics(x), \
                simpler_version(x))

when having a return value means extra work and most people don't care.

Maybe it exists in some form that I haven't thought of?

Any compiler people around?

                 Linus
