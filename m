Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AB18DB35
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552276; cv=none; b=O0vBAbNu3LI+ds7ZeTpaWXIZaVyxjloNesLNpakiC/DMifhsNXpdRlKe/HqpJUSXsER01XrRchUzE02zMoQsCv3HWMmCftQtBnH1MhGj3CiqHnDef3y8QVYKnzcxoff3dJwJHTEWwqOu4Pfuzb/zwLBaj/9TIEgxvkJ1EsJJ6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552276; c=relaxed/simple;
	bh=DooFKyvtMrhcGsvS73nOYMGBp2dUDW7K3Uj8YSGtKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvQlqK8OK+weemfZWpEYhFkt8uZ9FZZpHpe0/zumxrDHPUtfzSCJz8LcrsK3bVVWBE5REr3CgvkqHVN/ExtBOPQhCUy6MjhraHi6eNoaLeSJxIGI2gADdAsPdVQiQOEDdEm819wUkTLLCUsUP/O18BJqKik/bk2MgEBbjBDY5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1a7K+KI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1a7K+KI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so4575566a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753552273; x=1754157073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=R1a7K+KItVpkTig0JKRsKxXrlOdm7y2MqXzAiKyqc1jLSiqLvkR4nA5QMD0bUWFuLS
         hKc/0hFLfFVhHjoJ1c8I64dGL5PIQ+CbUWy9HLv3SI9CzeXqDMxT+pKixz2mhV830EPP
         MC++m6Pi6ZeCp5pRJRDMhmDBZzKJm4qqLxwAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552273; x=1754157073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=gMg6EKOIdhVyoBZkhcQ2JPL8wTDd8nPdLTdJHEx5oDIf4D670elR+0MVXM/aGcJOLZ
         VvBonrw5yCP5lhLSQKZRP8CaPIpgzebe5ffSC1jQnZJXmUD8Y3aIjQj1NatNJJtpBr1w
         ezfNAS4NQJAW2F5sYWmgWJqtLk9WeGvHEcAuVPF4yarwvABUZQCGmObG/xj3UinpO2+P
         KWkEwqOSEsFtW/e585djpE2ylxt2k7jkGE52XCOfD9WtWjm8H+dLiYN+7UTd+YgohE6U
         quQoxGO3DITMifPHK27+ycn7BMzv9lPrkZ+s9CjZ2P5A5u8wreCghHXBmflR2VW9sMi3
         lFWA==
X-Forwarded-Encrypted: i=1; AJvYcCUiAWGt1RzntHHe4aXHMKLCkNTUgIV4EBTzhyIhtar4e8mvB3NH5Xqm2VRd3pwq7Y/+R/Ql3qa7QPodVm3kWiOn@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYLIDgQ5pNLJ8cuVrA5dxf8IjRxYtS3lYC/QSBzJHbStQ/f41
	8L4jdZkh8SUDip2gLeFPokfkScdqRkBhBYofliyCGVBfa2o74wuugu5KaaBlftHRCbZTwVWV70o
	EFuWlyNM=
X-Gm-Gg: ASbGncuXZrLPB4c/QVwS5p0qMWquvt7HXVHHA8pQMp3UyYj2gPuy7ajT8IF5l7h5TBN
	xOu4pkt4lVELezmv9dPCHPMFfoK7k00lEjWAhZ2YfT+Oq9vWFGiq1umTnsLbJnv3pBz5OpwW3Lm
	AxI7PSaEC9SSAOaBB7QlW14RxfW7OwZ8wHSmy8SoDewxR0HXjhKJMouucSbxc0rF0yWNT+Iq8DC
	GK252fm0lpSsyFwRz+LAsZm33SydpOKB4QDc/IU3zVRAyg/JO8l/zcivIWd+MLaMG3wBKAF+eWL
	6ekVZzOzGDpciKv1vEbsHIdmYf/Ab7uEg/fYylHi1rCuNEoEfvS2oDxMbIorY88l3nx2ifnLnzF
	PT4j5Q6zLPLXqtSOO+kgUe8jsbhezlyrXl5G/P/jm1EMDm+hqnICVds6ugeytpwDJR0KSkJtJ
X-Google-Smtp-Source: AGHT+IGbghy43wuhvRZXTSfi8dq5mb22IuK/CMho+FBpLbKpXMKTHjkj4M9j8lAdj4R8RpzRREBhxQ==
X-Received: by 2002:a17:907:ea8:b0:ae6:e0a7:234c with SMTP id a640c23a62f3a-af61dd64f9fmr741909966b.33.1753552272856;
        Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63586065fsm174068466b.15.2025.07.26.10.51.12
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo5632557a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHLYphj/uQQcPnada8W9QbKfHtW+Z7ssbhhzuIY0O8ovQNooPR/EP5TKzEdBwN2nmVEj4Miq8CsCOZAtPlssYZ@vger.kernel.org
X-Received: by 2002:a05:6402:14d:b0:611:d10e:ebd7 with SMTP id
 4fb4d7f45d1cf-614f1da658amr5711204a12.19.1753552272125; Sat, 26 Jul 2025
 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook>
In-Reply-To: <202507241640.572BF86C70@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 10:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
X-Gm-Features: Ac12FXwUXdIlVLvMNocbefDF6HEUwlAESHc5g0TBeq7Fw2jKEkXsJpBWks3U_Dc
Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
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

, but

On Thu, 24 Jul 2025 at 16:49, Kees Cook <kees@kernel.org> wrote:
>
> Why not switch all of these to get_task_comm()? It will correctly handle
> the size check and NUL termination.

I'd rather aim to get rid of get_task_comm() entirely.

I don't think it has ever made much sense, except in the "guarantee
NUL termination" sense, but since we have basically agreed to always
guarantee that natively in ->comm[] itself (by *never* writing non-NUL
characters to the last byte, rather than "write something, then
overwrite it") the whole concept is broken.

The alleged other reason for get_task_comm() is to get a stable
result, but since the source can be modified by users, there's no
"stable". If you get some half-way state, that *could* have been a
user just writing odd names.

So the other reason to use get_task_comm() is pretty much pointless too.

And several of the existing users are just pointless overhead, copying
the comm[] to a local copy only to print it out, and making it much
more complex than just using "%s" with tsk->comm.

End result: all get_task_comm() does now is to verify the size of the
result buffer, and that is *BAD*. We shouldn't care. If the result
buffer is smaller than the string, we should just have truncated it.
And if the buffer is bigger, we should zero-pad or not depending on
the use case.

And guess what? We *have* that function. It's called "strscpy()". It
already does the right thing, including passing in the size of a fixed
array and just dealing with it the RightWay(tm). Add '_pad()' if that
is the behavior you want, and now you *document* the fact that the
result is padded.

So I claim that get_task_comm() is bad, and we should feel bad about
ever having introduced it.

Now, the tracing code may actually care about *performance*, and what
it probably wants is that "just copy things and NUL-terminate it", but
I don't think we should use get_task_comm() for that because of all
the horrid bad history it has.

In other words, if "strscpy()" is too expensive (because it's being
careful and returns the size), I think we should look at maybe
optimizing strscpy() further. It already does word-at-a-time stuff,
but what strscpy() does *not* do is the "inline at call site for small
constant sizes".

We could inline sized_strscpy() for small constant sizes, but the real
problem is that it returns the length, and there's no way to do
"inline for small constant sizes when nobody cares about the result"
that I can think of. You can use _Generic() on the arguments, but not
on the "people don't look at the return value".

So we do probably want something for that "just copy comm to a
constant-sized array" case if people care about performance for it
(and tracing probably does), but I still think get_task_comm() has too
much baggage (and takes a size that it shouldn't take).

"get_task_array()" might be more palatable, and is certainly simple to
implement using something like

   static __always_inline void
       __cstr_array_copy(char *dst,
            const char *src, __kernel_size_t size)
   {
        memcpy(dst, src, size);
        dst[size] = 0;
   }

   #define get_task_array(a,b) \
      __cstr_array_copy(dst, src, __must_be_array(dst))

(Entirely untested, hasn't seen a compiler, is written for email, you
get the idea..).

But I think that should be a separate thing (and it should be
documented to be data-racy in the destination and *not* be the kind of
"stable NUL at the end" that strscpy and friends are.

               Linus
