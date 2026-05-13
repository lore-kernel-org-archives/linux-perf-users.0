Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63892D5436
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645805; cv=none; b=VTd7DUMkIVgdE0NV5YxHx+joSY3pcPTZs727v/oZxl26YgeFFfFtg4gFvGV4NTvRSmbxpXYF4U4ZWv85ZE/27l1CyAnY0bz7y0+f69r2/bPOdWM203KsXVQPDnhM1/NbAMOcgZcu0dQjmWsrA2rGvR2q4549Hk8/r0Jk1aLQcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645805; c=relaxed/simple;
	bh=I2sKcS1znbnZn7Yi8wg3SUvDOeBnhN2M7+U6nZ8wptQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=iRc2uz5Gcxm7onRro8jBczH+2zcj3iuk/zRcEWSBuEPKvRawv9uhVj+6PKvqlOrfVlLwuwsfTDCfaI5gnlYGTlH+/bEsovc/wpaTB0F+zyHmrU8EU5VAFEr5zwXoHQ8Y2id/WPSmNk5Nwhap+yliykbJCcuGog9vOcxVq3ueO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6cJ4nY0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6cJ4nY0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so3628918a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778645803; x=1779250603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgwjs4Wmc3SmAqImPeb+QvEd0ROSS5ez6gLjaZVs7/o=;
        b=C6cJ4nY0klYq1tYgUPqNVZcM/9uV1g18WIT102Y6YC6jIEg61rMU9BaZnVhjas7D1P
         v08LTlZmOdx0Ih+O/2o1yTDm9lSTHgktT2KqZrw6ageS6Hpdz1hthDlFOS3o+Yc5VOmI
         rG4bjpvzerUxQuFPHr+osAyJnZNCyWETrSLVDIzUsdF39k2QjBvy1NWPS+3GuSkZHxxx
         shhEB7D1iWfG8eck3qhgk2h6J35epQ/tJmLbo3pag86KjNCdEw1ZIP7EDMtK53Q3t4qZ
         LLRVeODBMT1jnmxfWx48/0jI4b8fDh6uK2gIIS5i13DAJUTx+0K2BKEbpreh9zpS2LQl
         ShJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778645803; x=1779250603;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgwjs4Wmc3SmAqImPeb+QvEd0ROSS5ez6gLjaZVs7/o=;
        b=CXlP/Y2NfnOWIuMHZK8tVntzaYt4302NgNlS4KHbF6f5WlUOFcSzNqZJB8uQTq7m45
         +LdsVRaEX4t/7sVpDLLG6nOA9yWfbwveoU/rgZWXR3Vu54KK9Pvpxt9J/ikcuvJ3v8sN
         7/Y3dGXra5418NE+5KhcOvZpxkOzYaMF0DxATX+1ZD7Vg6mWE8dPjgDSV+e2BIc/5YTP
         ISVQAyn8sXm42On4gl0lLcv/EmJwqJg38SFvsB4NG4AOmbk54PGoaehEVeZt6k1LmBw3
         S5wu6a/t0om8G41Wzhqxfm7t5nQ6EihmfLYskd86GPD9Mrkx0G42dCN171hgtkJ7JZ1f
         WOyA==
X-Forwarded-Encrypted: i=1; AFNElJ/6tHL2Mh0gh1CeqSb6x64a3jE4Q6VL0hplo3R0yZ/lxJ/lwxh7ZJ5BC6VGymE23Ckov1xC/J/AUOli570pqOjL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd95qCxvgT8w5QWrVlr/wFsV4Lrp5+IL+0rCy2bHPZqSX+vPDU
	uSdQK96Qkq/Vvb9WvnN0/l+7bDbE5oEMSXpRx6zMsiqkysabF6sROgW/
X-Gm-Gg: Acq92OH80qqhUF+YStSO6SRXgykM4OYWtlAqtPi0MpwtPrOmMarz88+fXB28fcQQBp1
	XzEGMZO+5CW9a4vSehRZEdozPxRKLwF3QnKmPSzdlxSh31bPTaOvh9zAcgjQ0z9t3mAMAQZAKRZ
	yMaAKVx3wl2+kB7rP9xoCmJgQtwqzLOllanZY9f0n85BxdZzXLnb84g4A+GW6jVrylm2MUhhR9E
	R04Nc9Oys3o4TV9lJ9OUoDpsAVx6MOk6RAqRZLkLH6nO60vn6lxKzVjidLkEwBXJPUIEJ8X3ub/
	PXoJharM3rwDY/iljmJW8CAg9j29SSIfC0NAZ4j+N9uzGKTSF7LP6Wz3Gr7WGCpbyQaknR0YH3c
	g16QcNpaEIty+Rx3bo7Sa/4FuLjhN4xBqsQHZ2g15H/GJy2ZBPhhbiVg3J7hOrFZXqGRo/wLfVg
	Gh2MLnAWDPVhYrL8qOEV18UQ==
X-Received: by 2002:a17:90b:134d:b0:366:3ac:f725 with SMTP id 98e67ed59e1d1-368f409cefbmr1683736a91.25.1778645802683;
        Tue, 12 May 2026 21:16:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771b19csm13145401a12.22.2026.05.12.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:16:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Subject: Re: [PATCH] perf kvm stat: Update the exit reason mappings
In-Reply-To: <agNS2p8vXm-Pkkfv@Gautams-MacBook-Pro.local>
Date: Wed, 13 May 2026 09:33:10 +0530
Message-ID: <qzngq7lt.ritesh.list@gmail.com>
References: <20260512120408.59332-1-gautam@linux.ibm.com> <CAP-5=fUzQRCpF4U_0dnPxrx5sa3U-XbpLzn=c=EbeRsCY2=dPw@mail.gmail.com> <agNS2p8vXm-Pkkfv@Gautams-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


++ linuxppc-dev

Gautam Menghani <gautam@linux.ibm.com> writes:

> On Tue, May 12, 2026 at 08:25:08AM -0700, Ian Rogers wrote:
>> On Tue, May 12, 2026 at 5:04 AM Gautam Menghani <gautam@linux.ibm.com> wrote:
>> >
>> > Sync the exit reason mappings with the mappings in trace_book3s.h
>> 
>> I see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kvm/trace_book3s.h
>> Would it make sense to have a copy in perf and use the check headers
>> code to keep them in sync?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/check-headers.sh
>
> I'll take a look at this, thanks
>
>> 
>> Could you add the commits that add the H_VIRT and H_FAC_UNAVAIL
>> definitions? I don't see them in Linus' tree yet.
>
> I posted that patch earlier today - https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/
> should've pasted the link in the patch
>

For patches not yet merged and having such a dependency, this could cause
confusion. What I generally tend to do in such case is, group this
patch (changes in tools/perf/util/kvm-stat-arch/book3s_hv_exits.h) into
the same series which adds H_FAC_UNAVAIL to trace_book3s.h [1].
This way it is easier for everyone to keep track of the dependencies.

[1]: https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/

Note, that we should still cc the relevant mailing lists, reviewers and
maintainers to get an Acked-by. Since the changes in this patch are
largely powerpc specific, so IMO, it should be ok even if it goes via
powerpc tree via a common series, as long as everyone agrees.

-ritesh

