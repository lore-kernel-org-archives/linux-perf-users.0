Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E428643F
	for <linux-perf-users@vger.kernel.org>; Wed,  7 May 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622482; cv=none; b=fifGNT3O28hlXZb2c+5R4cdHj/ai6wNWMNQChPW8PtpcKw4iJsIkJnMlFCmGzM59GEwYmuMfFv0+Au/E3q08IWx4X3nnzi13PmCQlLVJCt8aiWfrb5O2Au/NcGx+EnDGihoE+ZY1re3YXmQfCTo3+n0fctKVn9pMMPc9lIBbw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622482; c=relaxed/simple;
	bh=rlYkutOJbTy9t4vetbaK1MFW9+WsC8kSGvqRmbg4uTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn95KbHjTBi6YjNj0lbuHXx4L4xdtD/y2hoIrfWcTxt0aWw4iH2NpyQdLWK3VbBdl1AwEZUSbQPGbM1yjoxiRfvyqo59YTcc1WvmyGQL6yeXcxRWGjzhli0jLZiMURAqnOOlXXQBzX1bBUDk+Kv6EVlQkkp1wlbN7FQmscO8Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQgEfzl9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQgEfzl9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so11090883a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 May 2025 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746622478; x=1747227278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypa3PBqDtPswGp9XxxvAriQxh6M+XVug4d/DpMvuJqc=;
        b=bQgEfzl9HbV8Ufg4s3XJVQe96sNXP7OOsBMso7IeTpJK4VOET69YYJ7wptPA1gA8eT
         hyO2wPLd9NNQ9HSUjdgA34EoT5aAx5KDPbmW9s+C8Ke555bjUvd6sZ0/QOxpM/q0br9S
         PAW0e2+pDYwW8NWIqmmyRM3t5BRFt01Nm0tXBo+LMwByHGRN8BaZHxC8o5iKDbvkJC4E
         QHLBhrEJ0XLqWnVsFYUPizrj/K01Fa6hjsj3H3ubi3FHqIl9v2E6JwcWsCtyrt/CGwZF
         mKO6U/3Ysm0+0GGZXPgJKGq8Q87Rd55yLH8z/AdEAyaoVfXUn/gUhP5TwHUi7tAcqDtq
         Wreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622478; x=1747227278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypa3PBqDtPswGp9XxxvAriQxh6M+XVug4d/DpMvuJqc=;
        b=l3kd2IKQ1xMrHrNRPzwgY5eUchxLx1YoSII+F4KMH0Bq1hU1hfaT2F8caSpQK+1/ns
         LN6N0mbqealp0GQDs03mZ8/YomOimFyG/w5PPph47HZuz7ni1JPKYQyOur4MsVzafx/d
         Ksb8cZN/rcvhNinfEEQ6t/pX0i30QqpBgFeERYzSTnE5vStQ5/bW1d3FjNYfYRHWCCsG
         TNn26OQrkWMC3Qj/Dj1Q/EETRMLBdgkv2W/1NPu5SRbyDuOwuupDDJfjfNrWauzuX+NZ
         dwS2v3NruXg0Hhlpbj8TZ1swRPWDF+PgD4qBzGDQOkIsVWFwNZen/n2LEFiqqVUJnSlK
         HbaA==
X-Forwarded-Encrypted: i=1; AJvYcCV+vGXI9f1GrXPl+ILmtMxvwk110rkR4HFd5W7NiaFlkZBg+WAogfhgxis4kTLxzPCBmLgdK3WMhf0arAZKwp7K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FDqIsbw6h8nrFUR8FX9ok1r6U61WsdXN+MxpS1yiYUtXnEua
	Wf7bH92W00X8yqxu+SYFQIaiFUfU5zYVyj5aNNlNu7afKSYsv3EtpAEmCxYVeSE=
X-Gm-Gg: ASbGnctqE5BTUQnjO26QfRQ1V9do41lcYKD5txIwYQ1gSCiFY7+4MUu1Bfv5Yhr1LYt
	0g4gZ8HV6yRs2hmMfP3f1OgfWx0oOSTrxfavlEb5UJlfJC5nuKlxP9PzP2iPTSt9Bmb/+P9Ryb8
	vZCcLCBMwk4/CQjWsI8sMWAujwOu6r6NTwFWPxndTuvcsvWWqKkqNvzF5IM2Sy8GL/gVLqdtP1o
	oaB9QOSFg+fRPVv0vGoWdvZhHS7d5yRve0tb/vztzCzYVj+0VNbyr0enN0Km+YqLJwRVizynq/G
	dLEC85egJMMICH0Wj0/UUFnTAXIN6Z+dL/gsebp034ZR7++NNQo=
X-Google-Smtp-Source: AGHT+IEEHI/oSTREUk8HTc9X/nZpZu+JH0JNL8Ix0W8ZxxBaMoWEfgZFH93pE+NmBTNHIMjXerli4Q==
X-Received: by 2002:a05:6402:2547:b0:5f6:252b:f361 with SMTP id 4fb4d7f45d1cf-5fbe9dbbe1amr2731807a12.11.1746622478474;
        Wed, 07 May 2025 05:54:38 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm9354161a12.51.2025.05.07.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:54:38 -0700 (PDT)
Date: Wed, 7 May 2025 14:54:36 +0200
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
Subject: Re: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Message-ID: <aBtYDGOAVbLHeTHF@pathway.suse.cz>
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507110444.963779-4-bhupesh@igalia.com>

On Wed 2025-05-07 16:34:44, Bhupesh wrote:
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> 
> To fix the same, Linus suggested in [1] that we can add the
> following union inside 'task_struct':
>        union {
>                char    comm[TASK_COMM_LEN];
>                char    real_comm[REAL_TASK_COMM_LEN];
>        };

Nit: IMHO, the prefix "real_" is misleading. The buffer size is still
      limited and the name might be shrinked. I would suggest
      something like:

	char    comm_ext[TASK_COMM_EXT_LEN];
or
	char    comm_64[TASK_COMM_64_LEN]

> and then modify '__set_task_comm()' to pass 'tsk->real_comm'
> to the existing users.

Best Regards,
Petr
