Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8821E096
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597240; cv=none; b=PM8RXU8lTFqxoynHv/Mog1J43xgjxCltP7xNRxJdaMLCEo9qdIhaE78iYQUezLiCwsnN8mCpOTYCZiqjbK0donVNLXoUbgmKaAHivD/KDFeGX5XRheNysVbjFLsQ756qK/exD6iqsiWhKcUXsskNpBulD5wooxgwJCjsOieUla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597240; c=relaxed/simple;
	bh=vHzrEzooH4K8CcIGUei7pRVS17MmHjHrMcmzZoer/Ec=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vwv7/duPdovlsEbPkdl6J/PeIdmV/XpRu7pA1fEuGn1W8sJdK8XkeOmwQp70PkxMpMBtkzP4vItdXnlc2mzuoMuCwcOefEGGvl7a2d6pyQ0/nbvDJTDnbLTQS/Q9+xVbRVSMSJZJjEbiP000OwW0hWiY/bWWmnUyw0aY0pUQis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PrgrgjIB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PrgrgjIB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47210a94356so1068831cf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740597238; x=1741202038; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=PrgrgjIBDzFyuCW0/BkssmUrWr+ejDo9K2GOMxCGaRhnW6xhcbtTD1JwwVGKLo/83P
         3dM9rKUsAMq62CVpok1RfQHA2wfcnXMzJ18qMcZcYUdGiwaEKk+ikc6U0hO+hXP5eQ2E
         NyqwDG/QmtPKzQkkLdTGYwhvbp9CTaW2CN1tiR+JGk13bm+x5+rLq5IqlamFPgOFO8PM
         HjoHxNDXIv68a/z/4EiqGgLE/s9X5kBDvYWorhxzCCaJ/Ef6jGrbARuL5iiZvdsP0RaR
         Wk+ZOlH0gvpRUqepXN07eMUzObSySHsdNfhHZlo1wCex2FQyD78d2/r2De4OapeVF9iC
         RAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597238; x=1741202038;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=o8cy6y5Sh1Pr1Yiz/Qjw9Vjp37KX3hS9IRgMHv47uGVjvUwbOcHzNB1FKnd7l1Mrnq
         CflpRPPDc1pI8r7YEesJN8EpKXlqOOUCVUdtM12mhIK/O9qkogaJ9t+R0kSQld/Yn88b
         Q40bzOs2ud6URNzak3WfYNZ2ts+TeZ8Ob3p8F+1jGthSEhBdMYkAazxO/+sjQiHsfEvk
         jj0RWqlxEr9wB7a6fCoUoDQGIgX6w8FYV7IlZSHQckGU6cDL4kUvv9AsI/P7/+PrSFOP
         CzNwv/psuYmrANmQycfx16zeD7zWvu5HtfW3OivDsb38RnjhoMCuA6uxukkVTvX/7uZo
         ukng==
X-Forwarded-Encrypted: i=1; AJvYcCUN3IM3nFQRuSOtFQ+dBIfzw24ZgI9Bj1pUQnfluF8/r0iEbYGqPmesMTnKumCTHlWbJvp3R2s8qfTbz+IsoEz+@vger.kernel.org
X-Gm-Message-State: AOJu0YzYe7TnWwTEbqEE2Lr4Bj/cdiy+c5s8/uiukJ+ku4OCCkLrFXIs
	262g5ZN+6AjXzFsUmsE+Easrl1Lqf26FojLTb9Z9yaiDIeOz9xBFXEeVjJl8Zg==
X-Gm-Gg: ASbGnctJwJcf+12f5106lIKlEWcI7uLUAU4kY693up9Fx0vkEt7zV6637aD4vwnqHiF
	eVcEkqFeKLwL80RfxgNZW+PPFr3Y+HmPEGo6+4zvXZ25sfpfeiq+7963FkNCn3tlL31dte/IMCL
	nb9374ajFND/KGziR3AWlnhn9U9x1Mz90IpLNv5ERTL9mnWytL43PA4OdWpTDGo4v5amvnTZFTa
	NYX3H0Mcs32d+6NGaGGAFMR2mjAqH7VUMNGRT2pvI3AC5BGiHJyNFZTOjTTfttkbrNooKAkFRnD
	4ndL7YpdpXzVwKmFdbw+EZW1B9UgbwzVmRMCoxKkocYDVUM7Nmghh70ZK1SiuyatBB+PCiY=
X-Google-Smtp-Source: AGHT+IGZKQ763FRka4tXmeqX9uwcpJ0v96pIEchafXYFD2cwhU7ih42tfW2HHRWzr2HQKaEkzBO+qA==
X-Received: by 2002:a05:622a:1a07:b0:472:201c:aa45 with SMTP id d75a77b69052e-47377116ed2mr109013401cf.9.1740597237709;
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47377e1543csm28407591cf.27.2025.02.26.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Date: Wed, 26 Feb 2025 14:13:56 -0500
Message-ID: <41cb98ddf724ade0fc529b8c952f3efc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, luogengkun@huaweicloud.com
Subject: Re: [PATCH 1/2] perf: Remove unnecessary parameter of security check
References: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
In-Reply-To: <20241223070650.2810747-2-luogengkun@huaweicloud.com>

On Dec 23, 2024 Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
> It seems that the attr parameter was never been used in security
> checks since it was first introduced by:
> 
> commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> 
> so remove it.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/intel/bts.c     |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/p4.c      |  2 +-
>  drivers/perf/arm_spe_pmu.c      |  4 ++--
>  include/linux/lsm_hook_defs.h   |  2 +-
>  include/linux/perf_event.h      | 10 +++++-----
>  include/linux/security.h        |  5 ++---
>  kernel/events/core.c            | 14 +++++++-------
>  kernel/trace/trace_event_perf.c |  4 ++--
>  security/security.c             |  5 ++---
>  security/selinux/hooks.c        |  2 +-
>  11 files changed, 25 insertions(+), 27 deletions(-)

Now that we have Ingo's Reviewed-by, I've gone ahead and merged
patch 1/2 into lsm/dev, thanks everyone!

--
paul-moore.com
