Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75322839A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054005; cv=none; b=uY+pr8c6kJE2ogTg9rGUimo73VXr4Gn4/v5N7Uuwml5A6FPPykKp/6rSidyCNNb10tg7hrN0S99X0C75/Gi8Cpd28GhQziivrqzesX6A3WVhBPlH9mifsFOqDkVdUwJJgoyyvBXqyh0glG2MotZXg8CmoyMpkpH4d3MHhZYK6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054005; c=relaxed/simple;
	bh=AeXLI0p5Oh85SyYg+eR0B6jiD9bPYtTCzWHVMfqkmX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRd2K7KOttmlF/MX6JvEidBjIO9q/zhPyax2yFYvry9Rf+RD6S0Np43sZ80ePB9nKyZPv8U0RgHvPaGRzqDAqRk3Ao/H4sNNaU4UOSs/VshgH0qrLoIOTkdfuVL4mbvRIKNQubIShuJ2q8MeoOaCi/whovmc/whq+AXmQ+sC/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNa4DZwI; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNa4DZwI"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so25715ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746054002; x=1746658802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq9bePjfFa3hYmCaggPB40IP52WVwAf3pPhPUg6Mns8=;
        b=YNa4DZwIqz9GZHAqZGu8vGD+SeKYX9LIWRdYd84B5MQBDcEGKKpWfjiNY/hMHmGO25
         MkQtTLU/r/wzqzDHQD6v1oiUIAIDi9qQV/lQ+pwcTu6UYr8RUJSpJKkg42wORvPH+K26
         /o6ncnAKCl/O7LrG7ov3K/S1DuJPz64IOwRPSCursp1+zeJuZORica5SsttzMaHporTn
         OWXtPhQL0l6key6Nc771WN/WWgpZlW7UYZpEBjCwIonqq7rvfMtS19W1MGXuD+pL+Jht
         WHfG7emcLL+wub2NqHDXu5MCMJXW3edaplfnzGKii9w+HRf5uQU0sI/1NSPk/WPatfOa
         q0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746054002; x=1746658802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq9bePjfFa3hYmCaggPB40IP52WVwAf3pPhPUg6Mns8=;
        b=N/+CFUN3UOhE1lEvE3b5Hz2HXwM4SRlzMxJIxfP30bnqZCmtcc9WjGlAiHKdBArji/
         JmqPgrkoUqMEgBL7yWqm6rLSd3073fATApjMCu21AVIcRxugaJqZlH7gXQTe39jndbhA
         XfUIt5iJ4C8O4fgm14tf5qLqxiGeygCHdmWdjuWl1TiCLWRKkHcMpavulkhyD+dPkhWA
         Qn1gM4/bE6RdPlfEmxpcPa/pSpTRcLqw+amarAlSnsyh4NCFwjXJR37DMcol2Qb2Eh8I
         hS7fvaYtzh3v0/013dXISTTf/SG1VoOXcjuC0vISJ/hq9k7y4/tN5enVxzuwe+674wHt
         AWgA==
X-Gm-Message-State: AOJu0YyLJo2jlfjRO2VYj46Z23oFohv0mPqV2zqPKwowmYVcbTMzh1fN
	2KFeZiDQWGa0g4b2Pu7JSVYY7FsQ5WNUdeIB/5FZdtM9V6daOtfSGMDxH2ah0I6zLWi6OOCDrqc
	/XWEl06guKMubh2Sx127dkRL4m/CSmandOwQOOcQyPiTFrF1fTUzlae4WBQ==
X-Gm-Gg: ASbGncsedIqrj3vH4hM9gqqesUOoouaT/I1Ue6FoGyOGY23+MHPnEpKfYzMYDREMwxM
	k/QgXOmP0CVrJCQa4NfxCwuNH+Xr9SAkktt7Hx9s2hbHdSz0bNOj250v6dAokBoWTj2DhPTwtLy
	CTM1MIKJ44dQ3MJGJ5Xm8BfNXrnYLmgSLgmnWNv55yHJfc6cAOhQQ=
X-Google-Smtp-Source: AGHT+IEQtrlGsvB0mz1CyePNTNIdb78/OtVQ6wNlejO0//56NVNEz507WEomtPtNoM4c9zulrAvu1HGdB4T/Q3CXpZ0=
X-Received: by 2002:a05:6e02:2784:b0:3d9:2a76:9496 with SMTP id
 e9e14a558f8ab-3d97017164dmr617905ab.7.1746054002315; Wed, 30 Apr 2025
 16:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBCwoq7w8ohBRQCh@fremen.lan> <aBHQzU8hhyWykGwl@arrakis.home>
In-Reply-To: <aBHQzU8hhyWykGwl@arrakis.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Apr 2025 15:59:51 -0700
X-Gm-Features: ATxdqUEfDaD_tnvNv_bLmC38BYbNqnk1___Sw9qUGS5l9MPV8Ew7bnlQBYp9va0
Message-ID: <CAP-5=fWtF7xD2PrZYCjPrrEOXi0Eg-A9jJvwGOfcc5a3nUyyMQ@mail.gmail.com>
Subject: Re: perf filters don't work correctly inside containers
To: Edd Barrett <edd@theunixzoo.co.uk>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 12:27=E2=80=AFAM Edd Barrett <edd@theunixzoo.co.uk>=
 wrote:
>
> On Tue, Apr 29, 2025 at 11:57:38AM +0100, Edd Barrett wrote:
> > I was then able to reproduce the problem using the standard userspace p=
erf
> > tools. I *think* (but I'm not sure) that this might be highlighting a b=
ug in
> > perf when used in containers.
>
> Forgot to mention: perf seems to work fine inside the docker container
> *without* an ftrace filter, so it's not that the container cannot trace w=
ith PT
> at all. The problem seems filter-related.

Hi Edd,

Adrian Hunter is the intel-pt expert. I've not tried this but I
believe it should work. On the kernel side the filename is grabbed and
swapped for an inode:
https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L11474
the path should use the container's namespace. Perhaps you can use
"perf ftrace" to see what's going on inside the kernel. You can also
compare the -vv verbose output to see if the events were opened in
different ways, look for things like:
 ```
------------------------------------------------------------
perf_event_attr:
  type                             12 (intel_pt)
  size                             136
  config                           0x300e601
  { sample_period, sample_freq }   1
  sample_type                      IP|TID|TIME|CPU|IDENTIFIER
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  exclude_hv                       1
  enable_on_exec                   1
  sample_id_all                    1
  aux_watermark                    32768
------------------------------------------------------------
sys_perf_event_open: pid 288789  cpu 0  group_fd -1  flags 0x8 =3D 7
```
which is saying the perf_event_open succeeded giving an fd of 7.

Thanks,
Ian
