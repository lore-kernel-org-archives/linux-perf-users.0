Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13691714B7
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750218563; cv=none; b=kRmf406SE3pQiXOMWeT0jho1yUMe6LAV4orNL+BzfZcnPKJClu/Hr978MgjAX21QRJ8/jq406bz/GQkU7U4T7cKnVDYusPJpfZ1MSEfGVcIdkYXCb1HKPoPNDHReN+8uLbCjpLOXdeVH54N/agivGNIuBSm1HJQeyKEh7VdB0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750218563; c=relaxed/simple;
	bh=6QvAOcMCRBBI7LWPY+Hl/n4adlLtJlaCD6nOUF4kXhM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KAoHqpwZZMSUdOtxfI7do6KETyCZOkrukW/cfpsiTjtdGeBVtS5mwxcRoPuOrO+FSZQwfAM7SQpyTnO5r5n9fY9X0Jm+4/gSUR13nXidiVBtsaRdDZ4czAJ+6/OqqX+IlE3w2f4Fru42LZLKbzu+ckWac2s+cImZv3CUkc62tLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=UiinTcVE; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="UiinTcVE"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fafaa60889so43303786d6.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750218561; x=1750823361; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef70Joe5j45SYlyg8314bmCwyOurjXSY3YWnIl6LCFY=;
        b=UiinTcVEYntYDIqfytCTuuEgeqD6iPAmpQkGfx61V787MZ8ZTCAEaIG05dkra80aEO
         oLELEmzuhxLYVd+2/wD9JSL1r7y/2vJIKeSnG2ugSdO+dh+CYf8xjmaFkpITCV2S4mnp
         jtTdQ6xK6LF+f8/7m0wGgdcdjR0wNFkAx+noQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750218561; x=1750823361;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef70Joe5j45SYlyg8314bmCwyOurjXSY3YWnIl6LCFY=;
        b=U+MlPfKQrgrVkJ9KnstSCJIE7TE5l7ywUZtTl6nwvF/poRT8ZrRtYYD5lDQ0VsZBCs
         cfxccM+Ul91Y1/E1REmt6sxj/V3Ib1xeZousBxCXgsOpO0QUNpXj4FgYxRP8lsFtSMc+
         Q4on2ZRqzhadjz3BYuG2chr0yOiuJwUvgu2xLbPVdCY1G987pivwkaxkZ3lVn+FzndlB
         CW73JvDYWe5Wsh3m8yKQVUyMKFra5kTtclppxANhM4xOZkEKyPskeTfHDr1t9PB/Jpt3
         UTBiMqhTFJ1mVTpzoREdBNMA96MXfjA8szt+GOED/H1iC1Ve/P4E55gSxiWTyWM5HI9e
         B/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVahmV9CDo6MPWP0VwJG76+2zjlB53bw3WKZUwMnrpPoUE7z5lnbDgRHQ7xaT0gWuelxXnrccO+OFazfEWaGGEX@vger.kernel.org
X-Gm-Message-State: AOJu0YxORgs4GLEF245xmZQmWCmRLa88ZVUSZK+/OqaWW+sxdHEiLlns
	yncFfUVLDpOmI8799yn40qRl4v2hdkf+RU9Bs53+a/OepOxGlpziSC3i3uOpyJYn8g==
X-Gm-Gg: ASbGncsfO42EQCRvOikrUlcAaHMHE/fS9mTZ4jjyessS5iM30SWKGPrztqA9rFOOk47
	Xma79O9VtlCrnwYB8bRlhKxQWkWrDMZBLwbTA9dmSVcFYW90tzGEkbLzsxJE4sZv9b4rj9gn6dH
	fL4XEwEnLmwabsEyDL21XZdfitY1JcGV1sunphVaL9NxDgYi+BrFg/m9zM9T6mFSCblREBBUd5J
	KEQbxAlYeLllG+QELq7/5RCpSm+EAucjQRGYVwzS/xUnQuVQZ4CoBcNaThQfZRG5bxFRQJqZRZL
	qZ79aPsd5EIcEpXqGBQFZvBwMxGU6N2DRocHUi2spgjZcIu7pCY/OwVVL0EQeR58TsghMSFYmmw
	dPeZlGw==
X-Google-Smtp-Source: AGHT+IEY/vDw8X+9rNcjO23dhLmtLnxL+I96K0Os1qP1BsJ1YOT+8ViRoRosC+UlntlMpWyEfSlSWA==
X-Received: by 2002:a05:6214:2427:b0:6fa:cd35:3d98 with SMTP id 6a1803df08f44-6fb47797c6cmr239671506d6.38.1750218560769;
        Tue, 17 Jun 2025 20:49:20 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb5a9dbf8csm18549736d6.106.2025.06.17.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:49:19 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 17 Jun 2025 23:49:18 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
In-Reply-To: <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com>
Message-ID: <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu> <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Jun 2025, Liang, Kan wrote:

> The commit 2dc0572f2cef was triggered by the fake event VLBR_EVENT.
> But this error should be triggered by the Topdown perf metrics event,
> INTEL_TD_METRIC_RETIRING, which uses the idx 48 internally.
> 
> We never support perf metrics events in sampling mode. The PEBS cannot
> be enabled in counting mode. So it's weird the cpuc->pebs_enabled has
> the idx 48 set.
> 
> The recent change I did for the PEBS is commit e02e9b0374c3
> "perf/x86/intel: Support PEBS counters snapshotting". But it should not
> impact the above.
> 
> Could you please help on the below questions?
> - It only happens on the p-core, right?

how would I tell?  I don't think the error message says what CPU it 
happens on?

> - Which kernel base do you use? Is it 6.16-rc2?

I was running just before -rc1.  I've updated to current git but didn't 
realize the throttle fix hadn't made it upstream yet so managed to lock up 
the machine and not sure when I'll be able to get over to reboot it.

> - Can this be easily reproduced?

probably.  It's another thing that's a pain to check because it's a 
WARN_ONCE I think so I have to reboot in order to see.  Even if it's not 
reproducible the fuzzer usually hits it within a few hours.

>   Is it possible to bisect the error commit? (Maybe start from the
> commit e02e9b0374c3?)

Maybe but I'd only like to do that as a last resort as it's a pain to 
build and reboot kernels on this machine (for secureboot and other 
reasons).  Also I suppose I'd have to manually apply the throttle patch 
while bisecting.

Vince Weaver
vincent.weaver@maine.edu
