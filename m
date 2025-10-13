Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E9309DC0
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388092; cv=none; b=hMDX/dgksEP6HepIdZ8Bg8LDgFxEvCMmi4M433Ybk7i7w+4s60XHPg5JSHoUbd3iXD9HEtN4m4yZ48wGuHak+a8qftAxSB7MEGOyegLNLQTje+0FXJF+IGHYfu6+oZFB3Cqt85+huU3n7Xj1TbNGtkZkn9me2+dQ9YJ4fzIMwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388092; c=relaxed/simple;
	bh=GsSWfFlXkBsxiUZoCz6mvqXlZhLEzpwSFRwMJKX6ek4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soBqRjlc6IQMoTvwPgQmAEH6hZViGmfXXPOYZvQcI/wbYs0UypM9RCQS1japSxYcVvYFY5BYqkpMC5VooBq6HgGPsgyiap+4Pm/zRT8Sjizhqdm3xiIuyDv/X4VMGrbmlMdLbwLPvMF2sRC2rhcsvbc1BsJv1dgEYdMOTT9jc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxSNtELP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxSNtELP"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63b9da76e42so3078544a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760388088; x=1760992888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCLtlY+GpSdapckAq80Uoda7FwoX2xkIrZqjiQg1jTI=;
        b=UxSNtELP/KctQLvknOMJ1+RLheRIKAsMqeuMzsPGnNHZOkQlhZhuccp7kF1IQ4pBXE
         y5kfnrMAXMCt/nZw9DzPEgvAkoPmxmrjF+O/NQc64D0CahamIUAucqFk+BIJ+i1DAXan
         lz9+mfdjiaMTFtHqWUvhsJW2obb0oB7iAMGYK8luUbrr8F927b0EVY1En53yGR3gxXhJ
         RaDfMGVARLqWxMN5LsuSMkSyVc/xHS9OH1iql0sdq2hegd+015elbsSDOt4w8GebaOpr
         ITWTFtG/UducX4UVpZxOhHDurzf8sy/mcfPAZCc+VaN77UP55zNI0IKCR8roYM8GZ/LT
         wqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388088; x=1760992888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCLtlY+GpSdapckAq80Uoda7FwoX2xkIrZqjiQg1jTI=;
        b=GEwqXEr1nsf+Qp2ywmnY/XKPODK8OTXuHq2hUpSF3DbgmxIwXLVPqrUZWnC8C5r2bB
         Z1WGb9xOav5otwW1Z4MTobI7K+yf6FJbUnFFFrCSomS+i1kF9WXT0betqJXd1RY1WXB/
         /L88rZVOHHfUnQ9CtBGVrxZiOKfrEKQViX+V2MqMhX0K0PIt0wqtn8XNkn3eNyEGwYnA
         tP1sHFuvT63JCp8U/NwKQF76qtaR3o/jhbcXA+BvEPNy1+MvI3QBJrjpFw/dz1ItaTEY
         evmjfRj/LHUal/TbPSPgjUQAsWo7A8DsLNVaCbiHo8B9AOjM85F7WWjrP+NYomD2asaS
         31hw==
X-Forwarded-Encrypted: i=1; AJvYcCXgg/mD1nF5ylR00Is+RBaAxeuM+d6XkIYnW9zqhtyklGvhVwNHGTe36fq8PD/h88faNuP0G44BD3kXOmJuEYm/@vger.kernel.org
X-Gm-Message-State: AOJu0YznrMg6IEWCgRtZNh9zkCYqvxM2A+RWEKcDJkg8Grp2SMMYb+pa
	gmFHJjKtBs1umFkP3KRSqm2DEmO/1zFImEx2CFhHAWvorkFfueAM2DUR
X-Gm-Gg: ASbGncuc3mGQyiNfo/hVC/FFxqeBImP6k5JJuDaMsa3YPTzfxYOjjU6XjDVwaUWMUbf
	2H3V60/ctgOBrRgFjXsv+htK5rsEydlGzUHhP6jnib5au4mXGSVGHIlf0ay07gfVxzWczm/XW+B
	Q9NxrbqBz2ivKwvSKAXQM9NXGZG/DJ/nz7ElneO3Pv/ztrs6jFBzIJRH4mks7TiUNn+Eeoyb+iM
	v8iwj74Kgu3mEDVgEXXyyzUKPMyBZ1RxGjYc+/K+aQx+/fKM0sLwh45aWkcp53RteWlzE+Ucl4B
	eUuEJ2smaVAvWCe6ZwldiIP6KmXxTMoSEW76znkDc9h9Xgqse2GzxnD/oYh1XWp9jLuRZJoGmpH
	Mq4ojwOebK6inYL9KTwTrpzUG9jJymA==
X-Google-Smtp-Source: AGHT+IFrDpANwGND6n4Bq/nSFTErKeDAVitiuC4/ag/cLsjoNuy/l3zpqrheKMdvIEEFGo6yIOFj0w==
X-Received: by 2002:a17:907:7e88:b0:b3f:b7ca:26ca with SMTP id a640c23a62f3a-b50aaa96b30mr2242003166b.21.1760388087782;
        Mon, 13 Oct 2025 13:41:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12b9dsm1000097266b.45.2025.10.13.13.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:41:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 Oct 2025 22:41:19 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next RFC 0/2] Pass external callchain entry to
 get_perf_callchain
Message-ID: <aO1j747N7pkBTBAb@krava>
References: <20251013174721.2681091-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013174721.2681091-1-chen.dylane@linux.dev>

On Tue, Oct 14, 2025 at 01:47:19AM +0800, Tao Chen wrote:
> Background
> ==========
> Alexei noted we should use preempt_disable to protect get_perf_callchain
> in bpf stackmap.
> https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com
> 
> A previous patch was submitted to attempt fixing this issue. And Andrii
> suggested teach get_perf_callchain to let us pass that buffer directly to
> avoid that unnecessary copy.
> https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev
> 
> Proposed Solution
> =================
> Add external perf_callchain_entry parameter for get_perf_callchain to
> allow us to use external buffer from BPF side. The biggest advantage is
> that it can reduce unnecessary copies.
> 
> Todo
> ====
> If the above changes are reasonable, it seems that get_callchain_entry_for_task
> could also use an external perf_callchain_entry.
> 
> But I'm not sure if this modification is appropriate. After all, the
> implementation of get_callchain_entry in the perf subsystem seems much more
> complex than directly using an external buffer.
> 
> Comments and suggestions are always welcome.
> 
> Tao Chen (2):
>   perf: Use extern perf_callchain_entry for get_perf_callchain
>   bpf: Pass external callchain entry to get_perf_callchain

hi,
I can't get this applied on bpf-next/master, what do I miss?

thanks,
jirka


> 
>  include/linux/perf_event.h |  5 +++--
>  kernel/bpf/stackmap.c      | 19 +++++++++++--------
>  kernel/events/callchain.c  | 18 ++++++++++++------
>  kernel/events/core.c       |  2 +-
>  4 files changed, 27 insertions(+), 17 deletions(-)
> 
> -- 
> 2.48.1
> 
