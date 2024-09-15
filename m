Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86B1C4613
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Sep 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726398687; cv=none; b=cfYjVsadaO29fWNY7SLI5orrT006ifJW6/IFbaPvCviJ74MtvuE2niXfkNsbm3df9WWnWPwOU3BCMZLxYQ7xG5s5+B9P96W+ztWmFU2EBL8eFr1JFsSx9oeCSLwfd6euzKpY6NLsrRysK2TKL2IfK72w5aCTYwW8LDYBJ5n7W+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726398687; c=relaxed/simple;
	bh=4/g887YGfPYAHyWs/NWbBAFJc55zHbIhKoE//wgF5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc99tZwpv1uXP3/0D+i/l8CMKqNQMv8sncaF3eeHZUr/ogPkitTGbrm4/GdSmP8kgyNi8SYJV5ufqZcVXeQL+j32Z69e7tTr9P7fE0T1N5+K8V1dUd9QzT7BmS4fRncD6/Jpsl57/8605dBf5Bro5TaY5YD0d9vFe1qZM3/WPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfQRL87G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfQRL87G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726398684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNvhOEpWa+WgXm7ScMKYLhJj9zxz0J165YKRpsScurU=;
	b=EfQRL87G91buImoXnfJu5Z97AoG7pSL2f5/EWE5G3tExVfxCN7RRPssODSPhy+ozh1Rj5f
	XbYSUto+MF2uu6uQwCkoG3pGucWCEFCoQ+4D3nTf8kVjKIHy6QnqQpA+18hgGuzqdt/bCe
	xvvT1HdWdiEcTnGaLT6v8EeXRefDVm0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-8gOMeDYXOe-yLpYPnXM2rQ-1; Sun, 15 Sep 2024 07:11:22 -0400
X-MC-Unique: 8gOMeDYXOe-yLpYPnXM2rQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-718e2da2e33so4009079b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Sep 2024 04:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726398681; x=1727003481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNvhOEpWa+WgXm7ScMKYLhJj9zxz0J165YKRpsScurU=;
        b=j7jh9nJS3p1oY0PjC9zDWGwlR35VZhdxwZSqily5DNAWfY0Mih5Poy4crevVWmgZos
         HTe2HA5R49vGYHMsMmjOBg+5ghH1smejJyRsO2EzgGzPhGgNW+GuDlgj4Ue3GfBrV3ia
         xgWFd7qkq/oLuIsSzTe7cBRt78A4Q2tT8iiacY8M97snDkNqOELPnAXV0kAl2q5dSsiO
         FmliDF7Jchc09jjbl1jrrHuIdOlfhbSRMyTSoWqxvkULoa8WS5ryvdva7vrLq1mAerdO
         SxfXWtwkFjcTywyrmpjrUdQqvNTL2FdfC3zCdzP5Q77dVuVPJLwyvfjbkqjZuJLqaizX
         dKEA==
X-Forwarded-Encrypted: i=1; AJvYcCVNh6m4pPVnQCs42Rlkq3KkzvwYAr8WyYh9hblgOkvkogOcb/4/6RP7fhRUEWLmynsDl0urkrbjxACvyJ9hh/WS@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYuzpF2bSKR0cUz1XYeGjlz0GSx9JBA8Wuv90w6nJ6p0XtPfg
	HBmqSgz0MqlatHHLOzUdGa0mcUNuxaCV8xVvcrM3PbVMIvFlQv0BI5sD8ydKH/ieiLK/7OZXIxx
	n8LLhTNWMuCpzl28kWaPQI3NcReSORmWds3OAEn963s3qO3F1106hRFZb2bgzhA59F3w=
X-Received: by 2002:a05:6a00:cc8:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-719366c41f9mr15101423b3a.0.1726398681379;
        Sun, 15 Sep 2024 04:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkFC3ox3k9XnXOpQDj+eZjiShD47i/J6YW0fVP/iI64Bht3XO3ZBlbuzRnWoqFD5CzrX3s1Q==
X-Received: by 2002:a05:6a00:cc8:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-719366c41f9mr15101374b3a.0.1726398680885;
        Sun, 15 Sep 2024 04:11:20 -0700 (PDT)
Received: from treble ([143.110.226.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab49d4sm2062405b3a.45.2024.09.15.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:11:20 -0700 (PDT)
Date: Sun, 15 Sep 2024 13:11:11 +0200
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240915111111.taq3sb5xzqamhb7f@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914081246.1e07090c@rorschach.local.home>

On Sat, Sep 14, 2024 at 08:12:46AM -0400, Steven Rostedt wrote:
> I think the unwinder should have an interface itself that provides the
> deferred unwinding, instead of having all the tracers to implement
> their own.
> 
> The user space unwinder (regardless of sframe or not) should provide a
> way to say "I want a user space stack trace for here, but don't do it
> yet. Just give me a cookie and then call my callback function with the
> stack and cookie before going back to user space".

We (Steven, Mathieu and I) have been discussing this at GNU Cauldron and
I think we're in basic agreement on this.

I think the biggest tweak we decided on is that the context id (aka
"cookie") would be percpu.  Its initial value is (cpuid << 48).  It gets
incremented for every entry from user space.

> That is, we should have an interface like:
> 
> typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);

> struct unwinder_client {
> 	struct list_head	list;
> 	unwinder_callback_t	callback;

I assume we want to allow tracers to pick sframes or FP (or auto).  If
so we would need to add a user_unwind_type enum to this struct.

Then the question is, what to do if tracer A wants sframe and tracer B
wants FP?  I'm thinking it's fine to allow that.  I assume the "multiple
tracers unwinding user space" case isn't realistic so any extra overhead
from these cases is the user's fault?

The unwinder would need two sets of callbacks and task work functions:
one for sframe, one for FP.

The tracer would need to pass its &my_unwinder struct to
unwinder_trigger() so the unwinder knows which task work function to
activate.


I thinking we also need a 'max_entries' field.  No need to keep
unwinding if we've already reached the tracer's max.  If there are
multiple callbacks then we'd have to get the max of the maxes, but
that's easy enough.


Mathieu had requested passing an opaque void * from the NMI to the
callback, but I don't think that's possible with this scheme since the
unwinder wouldn't know which callback to give it to.  Instead the tracer
would have to keep track of its own data associated with the given
cookie.

-- 
Josh

