Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416815E97;
	Sat, 31 May 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748715751; cv=none; b=p8aUIJlOSb9Qzquly4fkFEyZF+agWA2SkYWfp8R5/OwEQLNN9PpdcsmcituPwV+PSF4AtgFKfHYpwgtBfA0tetSNSRmtkYBzQIVR2B38RZcMTRAHfs7jrTCMV/zuP1BvF7K548ni68dQ0vL0ot4OMhTEPgsqj7+8AFWOK0Alb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748715751; c=relaxed/simple;
	bh=dg+O7+x5qrsZkLg3PcdVY1LLGw/E3RgsyTphdcchYC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYx9gCNEY9GwEDLWRa+Jm6j+qSikQrzZmndMvNnDJqlTRIMouZvjrGqkGflFFxNJjDcSKYVEcYI0EyMepLSSvaua8QHS6xSDBMogVVHhmF2KxAhb4198HtOBRHnQYy6cSluJ7m18cz37TYgekH/QtMuYwWEuvAmzK1yrsO+ErAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjoCNy3z; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjoCNy3z"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f379662cso2204644f8f.0;
        Sat, 31 May 2025 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748715748; x=1749320548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA/Y5tc5Yhy+ZwWQ0xznRNGF+dEvA9lsJSOsZ0lFIBQ=;
        b=FjoCNy3zIIc8CBaz52V2qxcig/qfEgPBhczGcCW7cGaNvdoQu7g8r1zRRGPRcqLukw
         qNN5VgVTt78UuJqVgsKAeX9TPKEDiozLZc5xk5liQo01+QLqqT+gf83HEvh73w9wSoDS
         9YiA+zKXejrofXWZ32WFXxFP4p1HAhtYrBLQwFoCW16wX1r8a5BQ5gOxf0YbFZBVub1l
         uPCjsX+p4TDwh/ePIIAbkty4Dc/pY5FAqyTkTY8+AA01240FsG/p5R3ZgHx2zvrrW/ad
         erdJ8CMmq107qscnWta4CUxaY9dqzL1NrNtzxUCg/a4IO8gZII5kXa3fbW7PS3+e25az
         bKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748715748; x=1749320548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aA/Y5tc5Yhy+ZwWQ0xznRNGF+dEvA9lsJSOsZ0lFIBQ=;
        b=xO5CtI5dxBQhzfNgEMckmmu6Fe8krjMQvfq23r0YtiDSMYj03yy3t9W49aIk6iokmM
         Op6mcDYzSj9JwL6YjlbqAcsM7SCwy4Y95q+/MWRODihggk7TH8e4PM719/YhyKAMKygR
         10pU6ic1wEbS/lzZqoi18X/7lMJtEvKR8kj5+uVMrQ7YoqY5AN4RgdhEEGaCUhTVO750
         ZtunOzoX8KVtTBRER1QHxJC58HOAgOPrKtsGHdWMRv7dzQmgcxWHt32RKBe4nd/pbQ/j
         tNOrOWnDxu6+ZOchVr+s01biM3EUcZdPsWeEOPH4c0RvD+gIrLXFxRVi7b0swHoP9pc6
         Na/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6204Umaf5ZuYEVK2HVZI/Lbx4qR2emFuhdeLJXNTbwCK3hj2PoeG3RWhs04sf70Lm4LD11V2vwAtM6h0=@vger.kernel.org, AJvYcCXEc39sa3N9UyNpwvxgYS4yjJSbvRWMahsMNU+xaeKxVtMQy8uflZmBhHAyfNcaHtRoC0wO/yCzGxNu1SURvCE1mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxKfeBl/3yEHRsRaVvnczlFMOSjjdXQRM27kv5a5HlD7gwuEZ
	clAxSmrEqzQQU2hAbqlV99PV9te2fMDOHhMsxexiR0ql6JNGr4rFFK3F
X-Gm-Gg: ASbGncsDgaGx+mQKQ+jrdyyhSFmSJDQfbdqvCrXt49YYLC2a1koqUg3BL5k8EWV+G7C
	mOqSudwCl8RvwkPY/5A1jTpKZxCBPeLsXfNkC6ukgb3y9SiOLK19rc7r2PqbPN8R+GGXJ3G1cO5
	yqLYVItZ8a5aRItlkv2xJL0IEm4k0TleK6v+bTHadt0P48r4jf97Z7EyoqHRMIQLAlMDbQTMguA
	St8lVY5iE8x80xVws9yuwAH+HqKBqMoQaiSCIgjOXxrMa6YBRVbET2+ATJCtgEQ/g1tJmPSPdoR
	5/QInAOOoWCRLjXvl6/ZUidqNGnS89E295jk8ULAUxG3wxa8PpELtTTwSPRAgRqLnSbbpnAhXJG
	LiPfzivmbQuauzaVZSWS6IV2l
X-Google-Smtp-Source: AGHT+IGbBtA4NXJIIjNlWGD7+RYvJF/QR6rWPaKJGFwGHtSLn22Sbi+UT9O29RTBbYILlxC44pl4Gw==
X-Received: by 2002:a05:6000:2287:b0:3a4:f6fe:5244 with SMTP id ffacd0b85a97d-3a4fe154d04mr2104077f8f.12.1748715747984;
        Sat, 31 May 2025 11:22:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c9d4sm8885386f8f.38.2025.05.31.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 11:22:27 -0700 (PDT)
Date: Sat, 31 May 2025 19:22:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's
 -Wunreachable-code
Message-ID: <20250531192226.6af9bbde@pumpkin>
In-Reply-To: <aDoyPbQ38vZTCaNn@google.com>
References: <20250410202647.1899125-1-irogers@google.com>
	<Z_mK9BVv16MT7shL@z2>
	<CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
	<CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>
	<aDdU1npHL2Vczhsa@google.com>
	<CAP-5=fUycjUUWW=hoSSvxfUVPXcqAk5KHnknFuUDOr7+Zf=M2A@mail.gmail.com>
	<aDdqcfuAuk78eKXD@google.com>
	<CAP-5=fUX-gSv0q_j59bG19=dnaCPMeATtFgM0bPMSP8DKZWRJQ@mail.gmail.com>
	<aDeHN4DeYS3i-5jY@google.com>
	<CAP-5=fW0g_bhmHm-uyVRja7dhkw47K-PLAx5iubQEm4X+vTSAQ@mail.gmail.com>
	<aDoyPbQ38vZTCaNn@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 15:33:33 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

...
> > > No, I meant we may not need the __builtin_unreachable() at the callsites.
> > >
> > > Would it complain this code?
> > >
> > >   if (some_bad_option_use)
> > >     usage_with_options(...);
> > >
> > >   /* normal code path */  
> > 
> > Right that would fix -Wunreachable, but the existing code would be:
> > 
> >   if (some_bad_option_use) {
> >     usage_with_options(...);
> >     exit(..);
> >   }
> >   /* normal code path */
> > 
> > Letting you know that "normal code path" couldn't be fallen into after
> > usage_with_options(...). To make the behavior more obvious we could
> > rename usage_with_options():
> > 
> >   if (some_bad_option_use)
> >     usage_with_options_and_exit(...);
> > 
> >   /* normal code path */
> > 
> > What I've done is:
> > 
> >   if (some_bad_option_use) {
> >     usage_with_options(...);
> >     __builtin_unreachable();
> >   }
> >   /* normal code path */

Isn't that just wrong?
Doesn't __builtin_unreachable() tell the compiler the code can't be executed.
In this case you want the opposite - something that the compiler will
whinge about if it finds a path that does execute the code.

In terms of source code readability it is a also horrid.
It is pretty common for an application to have a lot of 'usage' errors
and you want them to take as little vertical code space as possible.
That is the whole reason why it is common for a usage() function to
call exit() rather than return.

	David

> > 
> > My reasoning is that usage_with_options() doesn't obviously on the
> > face of it call exit and never return. To make that clear we could add
> > a comment:
> > 
> >   if (some_bad_option_use) {
> >     usage_with_options(...);
> >     /* usage_with_options never returns as it always calls exit */
> >   }
> >   /* normal code path */
> > 
> > But my preference is to use __builtin_unreachable as that is the same
> > as the comment but is also something the compiler can trap on were it
> > not true.  
> 
> I see, thanks for the explanation.  That part looks ok then.
> 
> Thanks,
> Namhyung
> 
> 

