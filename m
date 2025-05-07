Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397425D20E
	for <linux-perf-users@vger.kernel.org>; Wed,  7 May 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620992; cv=none; b=r64grR1k8h1BfCJOV4zFv1VIpCZUsXa/NDMeAVaTNk9PLwrqZ5bkI7ZFs/nMV7jSk+cCSvODDD2cs2U1A9K6bO5UyMD7L9MRDOxpDYrQ6ZVz65K/iEq/UajtuTSkP4ao1Zc2iacSA/DrjsX8RHNuROceWZWSOuorQ1+aeya8bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620992; c=relaxed/simple;
	bh=Mqaui1F9/bOT/JMKClMuGVkx2vOY4zGOZ5ph/2yYf6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHoeTPiHC01phrCJ1rRgSnF8pakaE+vqotTMnnlPYC1X0rHXCCLbYACQoHHbEdMcil9mGhd+hso5TPC0evs3yz+mXVjfQ9Z1Qm//0L74RUZCG2PvZlRMfoCKvy5XB98tPa0d5/GoiscmoChM7xwnVuZOtgAf2FSNScWxPNpkoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PEwP1aAD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PEwP1aAD"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so227572a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 May 2025 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746620989; x=1747225789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW0x6+aPcBTGf4RTVQ8qhVtJhNXiKy2eXwn1Y4GghS4=;
        b=PEwP1aADFuIaRTSntQhykyjqBYcV858AXTJdBoF0vhOJ2NnxgFwT9S8QzO6/8u3TOX
         YXD4/bPwrqnTmZFsKlA4nGKofy/QJj+cfTLQw1hh07Z5sRfHM9GQJ8dB2iQWcv6i2sBT
         W8oHd1QIsuQLaDNOIwpDO23SjAVdeUkshwbyrFQQtSpmpwKyP9yW87HHOgfyxnPDRyYq
         j/nMHNJEUi2sVU/dP35gqIDKdsfWlFqWzCL/z9PLr8f1IcYkwoZTfJ2zatcIA3DU9S93
         ySS9oacZGkqQ8a3yXGmVdRyv9rOHoZLziVQEbEVr8eeeM7XdJ+iv3Uy3OFJSXJ8ZpqGO
         yqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746620989; x=1747225789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW0x6+aPcBTGf4RTVQ8qhVtJhNXiKy2eXwn1Y4GghS4=;
        b=vFza/fGc4/qVbOqaheQP+naXFW0gRjuh6kn204xmzSnAW+sOc/3PQkq296Tli/H05O
         8qyZFwCPeQW+d/TaZcWTKJbxDXjZtAqWS/3ryhgompXo65stZJO7zbl3kyl9hvCCuqPC
         hQjTGc/4nB3p8XKXh8ffUGo/syD1HJ7SZjTPLp7SLYiGk3EVYoJKwOl3dg8MsEUg2nrQ
         GzfBNgmT1L24zbnbCUda1aT7wsCl8I4L9CU61s3aUjM+EDLMkZRmnDCZhL/esF8TKz2q
         8KkeMIwfUICo8kJPQ1Nh/twg5J1l4JXmm9SUoeE49RoMvF89icjUmyu4bEczQex2J5CS
         Ecjw==
X-Forwarded-Encrypted: i=1; AJvYcCV7S12gJPdWXRWTLJLEpSNjnW9gvgRjBTS/dJoy8kGSgayq2mNzIaT13/qtazc1aMB9SFit3XATSgXwnQe1NqJr@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxR1xB9syi/xCs2GbnuoGQtyHE8kJ9Z9eawsDiLP77JAyIj1U
	JXc0Z37mgJpnB4g8xfADxB5cwsdbgxk+DDqmFcEBlqR/U2w3X1HcKhbZggV5usc=
X-Gm-Gg: ASbGncte7WfcI4Y0xUOKrHLftPcoBEWA0CctUT88OzL4hXsTK7XksguwcZjW16Lr3DP
	35N/9vWkaFEYwaMSw5vyVGN+bRYxgcu+nXuRG0uLSf9tSHuJBM8BjQ+Mev8pN0MXolcaiOJc65R
	XY4SLcegzMhBKFuYyZhtVp33QNByZPDbq/tDXxfUEwnRfu7dsXUmuuN+OjWOLVFY8oihzHvtJu2
	EMJ9Tzn3Ci2QZka8XiIgayFbseT6xCcR5soTmkReR0pEwPW0faRpLQPZf7897d7Hg9xIfZKEgDM
	THIxJSMFS++s1xlI3KxXH2p60hjR5h3sPg2Um0cx
X-Google-Smtp-Source: AGHT+IFcaF2HbosKXMSG7ssx4/Idj9ECcUf+SjKCY6flcCBO1BJAIS54Xv8b1MSnCIFm4q1ZvQeSUQ==
X-Received: by 2002:a05:6402:2804:b0:5fa:aa28:b10 with SMTP id 4fb4d7f45d1cf-5fbe9dcd645mr2810548a12.13.1746620988876;
        Wed, 07 May 2025 05:29:48 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777c5c3asm9429175a12.21.2025.05.07.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:29:48 -0700 (PDT)
Date: Wed, 7 May 2025 14:29:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <aBtSK5dFmtFXUaOE@pathway.suse.cz>
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507110444.963779-3-bhupesh@igalia.com>

On Wed 2025-05-07 16:34:43, Bhupesh wrote:
> As Linus mentioned in [1], currently we have several memcpy() use-cases
> which use 'current->comm' to copy the task name over to local copies.
> For an example:
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  ...
> 
> These should be modified so that we can later implement approaches
> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
> is a more modular way (follow-up patches do the same):
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  comm[TASK_COMM_LEN - 1] = 0;
>  ...
> 
> The relevant 'memcpy()' users were identified using the following search
> pattern:
>  $ git grep 'memcpy.*->comm\>'
> 
> [1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
> 
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -53,7 +53,8 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
>  	do {	\
>  		char comm[TASK_COMM_LEN];	\
>  		/* This will always be NUL terminated. */ \
> -		memcpy(comm, current->comm, sizeof(comm)); \
> +		memcpy(comm, current->comm, TASK_COMM_LEN); \
> +		comm[TASK_COMM_LEN] = '\0'; \

I would expect that we replace this with a helper function/macro
which would do the right thing.

Why is get_task_comm() not used here, please?

>  		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\

Also the name seems to be used for printing a debug information.
I would expect that we could use the bigger buffer here and print
the "full" name. Is this planed, please?

>  			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>  	} while (0)	\
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index bd0ea07338eb..94a941ac2034 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -214,6 +214,7 @@ DECLARE_EVENT_CLASS(block_rq,
>  		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>  		__get_str(cmd)[0] = '\0';
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		__entry->comm[TASK_COMM_LEN - 1] = '\0';

Same for all other callers.

That said, I am not sure if the larger buffer is save in all situations.

>  	),

Best Regards,
Petr
