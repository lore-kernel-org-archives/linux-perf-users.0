Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE61990C1;
	Thu, 19 Sep 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735381; cv=none; b=R0xeqp0BvHfFb0z3lSVpfsYVOjnCdqM6Jj98q2jxBHrNSG80bDCbkxtT/hl1RG1FXDWaTug1fH9FGO1ryV1Sw4qldG2UgwGDBCrLne1rllLa9XxsZz5k8kGnVZXBBIWGtb6+caW+fhXByuk4Jh4lTfyV6Fwik5na8WNp4XQBCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735381; c=relaxed/simple;
	bh=PZHFfX6Xs1Wwf4eFstQVoFBA9GOOqkY/Qkh3mRZPtkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUOOQ98z8/MKv9LEldsRQTghzl5T9OjWj/1qNcAOBW0HNP+vKYLI16C/7JVwOYuDG7Vybuiu/KhZsN7kcRu200ETfmpu702rH+4CHF0WKpwMrA5iOFo7cHOyRMeycbYJzKJMsYzQ/QIz4ZZcCN2eoQvYzaGRyEuc7zRjfuTdTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KW7sQShs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW7sQShs"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so6223001fa.1;
        Thu, 19 Sep 2024 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726735377; x=1727340177; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q56oYwZIP3a9bwlxelu0mZMcpO1Ir/bJeTvgLeroy9A=;
        b=KW7sQShsGCtXb98Sq7ZYZnXkL+ElmhR9zzbGFVnJplGSYaA4XhX0zDOsjI4j5ivD8m
         9/j2LpqbKOCKygBcq2oDg6kBwmMH5JDnDF5wY3GH6XUUlgOrv9s2szdPp1Hhr1/jHx3Q
         tbDYOoe6c8vMmpVr7BatDD5z74IY3svWB/Pc6obkyaXI+lue+IeZ7w0yer4giRZxmdUl
         1O9YY1g0mMAoMtVnmsOMHHYMRQF4IY1wfF/d8pxTbCpJvV4khbwmqxcvZSasxJbM8afz
         h8nHVfeZZWhpFuCcr740NIkxc6gciOT2iM/acsVKYeaSmZRMeiuua5KiammvJFAyYGrj
         FMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735377; x=1727340177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q56oYwZIP3a9bwlxelu0mZMcpO1Ir/bJeTvgLeroy9A=;
        b=SnOhBZcxeDQ1HoASvRgEtN4+PAIPR9VHgKBUhR7IrLAVLgYbjvmrp1YEDrD7BvXD5/
         3uw+9CdnBp7PFvGFLFVywQ7O5NGR/fBPX5mXUHVGv0NXC0IapHXFCx4Vr/k/1XQAbRBK
         CUMxtWcmocTCfSIHZwsUI96PtJ/cSDMBAradajRQb7X0C0+FMhGpAsqB8oOrbhSZsDcs
         IM5KlTqEmTxpn+YRKFLnKEOnN/WEzCqvjIMAv0h3StJhob6Vn2MnOUqatVFehW5aUeiv
         oBZgWwgflcQmG7k3uBI+vKfoiUQ3K22QlL50Y3xzNS+dDoRBJ9l5MuWJOBptcvaaZC6l
         azog==
X-Forwarded-Encrypted: i=1; AJvYcCX3XKRf+Jo9npwqqCwtnc0zRlO66C/9lyF2rLmi39kJKNa3UwjLAjtRW/5//RXuNlEwbVucdOvfDMpcQa7bQFbf@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/j3bTG2W9lP90YOIdU+PXfh2IoxkhkXYdniVC7Y9In/zEhqQ
	4kfxASwleC9xYCW3nC+WaQwHoL5teThfimGNCO/ItG/1Wqxxkk+C
X-Google-Smtp-Source: AGHT+IEIA29X7ytBf2XZTAYRstHeHQBGG9sL4jdwDiKrlg4ZacATpccZMEL9VWgX7vDj/spHfVxjjA==
X-Received: by 2002:a2e:b8c6:0:b0:2ef:2855:533f with SMTP id 38308e7fff4ca-2f787dbf632mr140713931fa.16.1726735377071;
        Thu, 19 Sep 2024 01:42:57 -0700 (PDT)
Received: from gmail.com (1F2EF419.nat.pool.telekom.hu. [31.46.244.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754ce37bsm15719855e9.48.2024.09.19.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:42:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 19 Sep 2024 10:42:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] Performance events changes for v6.12
Message-ID: <ZuvkDlws6xvijIuc@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
 <CAADWXX_mJr=hDkOWne831Fcm+wRxRnh9VvD2AMJJ5fStodyAgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX_mJr=hDkOWne831Fcm+wRxRnh9VvD2AMJJ5fStodyAgw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Sep 18, 2024 at 2:45 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  arch/x86/events/core.c                                |  63 +++++++++++++++++++
> >  arch/x86/events/intel/bts.c                           |   3 -
> [...]
> >  kernel/events/core.c                                  | 586 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------
> >  kernel/events/uprobes.c                               | 505 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------
> 
> You seem to be cutting-and-pasting your diffstats from a *very* wide
> terminal window, resulting in a very messy diffstat result.

Yeah, sorry about that - it was a one-off manual diffstat due to the merge 
order between perf/urgent and perf/core, and indeed my terminal is ~240 
characters wide and I didn't notice the diffstat width-scaling weirdness.

> Please either pipe the git request-pull output to some tool (I suggest 
> just piping to 'xsel' or similar that does the 'cut' part for you, but 
> anything works - you can just do "| cat" to make the stdout not be the 
> terminal).
> 
> Or just use "--stat=80" to set the output width to a fixed sane thing, 
> instead of that insane 250+ character window width that it seems you are 
> using and that causes those overlong diffstat lines and makes it all hard 
> to read.

Will do next time it happens. Below is a belated diffstat with the correct 
width.

Thanks,

	Ingo

 arch/x86/events/core.c                             |  63 +++
 arch/x86/events/intel/bts.c                        |   3 -
 arch/x86/events/intel/cstate.c                     | 142 +----
 arch/x86/events/intel/pt.c                         |  29 +-
 arch/x86/events/intel/uncore.c                     |   9 +
 arch/x86/events/intel/uncore.h                     |   2 +
 arch/x86/events/intel/uncore_snb.c                 | 185 ++++++-
 drivers/dma/idxd/idxd.h                            |   7 -
 drivers/dma/idxd/init.c                            |   3 -
 drivers/dma/idxd/perfmon.c                         |  98 +---
 drivers/iommu/intel/iommu.h                        |   2 -
 drivers/iommu/intel/perfmon.c                      | 111 +---
 include/linux/cpuhotplug.h                         |   2 -
 include/linux/perf_event.h                         |  32 +-
 include/linux/rbtree.h                             |  67 +++
 include/linux/uprobes.h                            |  48 +-
 kernel/events/core.c                               | 586 +++++++++++++++------
 kernel/events/uprobes.c                            | 505 ++++++++++--------
 kernel/trace/bpf_trace.c                           |  38 +-
 kernel/trace/trace_uprobe.c                        |  44 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  27 +-
 21 files changed, 1146 insertions(+), 857 deletions(-)
