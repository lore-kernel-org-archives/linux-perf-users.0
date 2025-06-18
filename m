Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3941F4C85
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271170; cv=none; b=o3uy8e5ntbTG7iyuA9D5OS8JRIa1j9241UlxoGDR9VkQ0IDiqruinMpHwvSCM0Kd1LBPzd9crRDLg/6kUARzzw9cYgQPAMRkmV5fDZCpvZwSv5L3JwdCNTCAYoSlAwaKpMouZwBSbtnU51NFDx5/0aFL31/SBPpSWW0PLh7TwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271170; c=relaxed/simple;
	bh=IXK+S4uXxPqEnY9h1bAL/eP3qq5ugrshNaDE7HOMvwU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gZzWkSgcUJEHogfbcb8Zgp9IWR4v83ztJQwZn0gFjhzQ3fGPSUXKT8J+3arg6hUaKwwb49bbexVidMpIeaYuq5XeHbmIx7Ib+OqhHL8QBWJPpsr5j/417A0sTbN5Vx0jTWUaIs+Q+sytYNwstFl/nqhLwgCShXHQz09qgCOx/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=MXbFu3+d; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="MXbFu3+d"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a5903bceffso84577301cf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750271166; x=1750875966; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQyolkiMyjAckIG3knda/ZNUyqwRYUv8nQKXIT9FUXc=;
        b=MXbFu3+dVazDfmtXOEyOG5eg8CClDAsJObR7p1ywAUtjLOf4XN6+Gbg5FgdhU8RbDh
         0bEWLLQzhEcxR0NkZmEaY7OBpoLBEUpmqxb1ygqJpgbC71AbIXx4/kuw/ZwOwVOQuzZ+
         JItUquAV9jGnAsnCWNiRLlTgYbtUDC9R3bg70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271166; x=1750875966;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQyolkiMyjAckIG3knda/ZNUyqwRYUv8nQKXIT9FUXc=;
        b=D51uHEuIRJzZhDz+nrvYIBlwHhL8HU6q01uuLPtpzt82wWq3iRzzayxqgKhXZSE6Ke
         +BX3p5YnhTcA443uAmsmcWrT8f24vFt+RkKB5I/CBzv37kwMlhHMv4uD8+RqLD9RBFiD
         wD/J7NagR5+6l9XCql9Ug0DNbDmTcMWvAMegpWWClDMWInWYywDd5XrP30xEixNseMpp
         yOgi4NjwfLKT9OPecgSQ+5U2egj3hG9W1nsSwQG7B9kFbDnS0h5RT8xOimyPoprtEIRP
         5cekYjmIH7jmGN5hVkcffNQ+6xgRLtZaUXqnoJsP3+17jcBGHoqxEue876Jm5Z6lAnHP
         029Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw7LnSkioVxjpQM2+Skyjdnro1d1N5f8UWO9+aJtX1yua+Mxcp/XcUIQIvrQtzMU9wwz6zhRdMQQZ7q3bWeRGg@vger.kernel.org
X-Gm-Message-State: AOJu0Yziyicr1b0c92fq3uKxvpfrftpGLcodWwZZhbrUeS8f2kQMMVel
	FWxJ4BHJWF9ijtwjuH4EKSKzlRdgenmXqUvAJ8pNhWtX0ydRtetC0cmiSvhRuVT5hA==
X-Gm-Gg: ASbGnctWrFK3rHdzPojblklVHIeN1ZO7wz/ByoqNdxh9QapxuOw6gnJs7Z9mfVS9mYM
	OsayWOH1w2DllrSxGZNVHuPwqT29A7Mbloj/0uUvH8PY4l/UTDdcc3/NlgeCE0N4kwIYhnmrQU7
	OIxBSh/roqBQzjRnzZR+MghyLqFVOsgbYaTZHKMyxHnVYqQdf6ikysnxCfqthFSIQS+ryZ8pATA
	thCKZgy5e+78hhmKazrt8tpOKgmsaVO50R/XGzRAd473wAd4vt1nqpopC5JIG/el1a97JBb0+q/
	UrGuejHgJJrkualyIrBiTcmGQ6DsCNoRkInsCtCrhFPmoUCYJzx3b+wDg+9/KfLqsCSg1e1SaQR
	FRCi5+w==
X-Google-Smtp-Source: AGHT+IEOSRhUOkMxVT34ymUQgwCslbypVaUotjLJ3GfRwJWwd0EJHpVqBJVQyle3azFTQ1TTYRMmbQ==
X-Received: by 2002:ac8:5813:0:b0:4a6:f5a8:3832 with SMTP id d75a77b69052e-4a73c617171mr254000481cf.42.1750271166573;
        Wed, 18 Jun 2025 11:26:06 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a52a1ddsm74868321cf.81.2025.06.18.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:26:05 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 18 Jun 2025 14:26:04 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
In-Reply-To: <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com>
Message-ID: <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu> <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com> <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu> <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Jun 2025, Liang, Kan wrote:

> No, the error message doesn't say it. Just want to check if you have
> extra information. Because the Topdown perf metrics is only supported on
> p-core. I want to understand whether the code messes up with e-core.

I can't easily tell from the fuzzer as it intentionally switches cores 
often.  I guess I could patch the kernel to report CPU when the WRMSR 
error triggers.

> > I was running just before -rc1.  I've updated to current git but didn't 
> > realize the throttle fix hadn't made it upstream yet so managed to lock up 
> > the machine and not sure when I'll be able to get over to reboot it.
> >
> 
> They are not in rc2 as well. I guess it should be included in rc3.

OK I am running rc2 now (Well, whatever current git is) with the throttle 
fix applied.  The throttle crash is something else, it crashes my test 
machine so hard that even the power button doesn't work, I have to 
physically unplug the machine to reboot it.


> >> - Can this be easily reproduced?
> > 
> > probably.  It's another thing that's a pain to check because it's a 
> > WARN_ONCE I think so I have to reboot in order to see.  Even if it's not 
> > reproducible the fuzzer usually hits it within a few hours.

I am able to reproduce the error on -rc2 using a specific fuzzer random 
seed.  I can possibly try to create a simpler test case but that would be 
a bit of effort.

Vince Weaver
vincent.weaver@maine.edu
