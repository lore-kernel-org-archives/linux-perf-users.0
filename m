Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E3224AE1
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670127; cv=none; b=ch0WgWzzTIq9iVYWnc0AbGksfLfKQfexGKAnkoEY1H4slsktJFTOle1p15Bp75DSZdtWuHgsFoUXiFdBLtkvZ7Fw0bpsSr/WYOz7iOAD7yNcT2P9fYAr/Z111D8OPogWGJYm4877v3C31kknL3rHF0vx1eOW6wv8Rm5W8QajTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670127; c=relaxed/simple;
	bh=FHSJKbaVsXnpai4AZoxw4CdJRiJHGiUPSXPDotRSaxQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NssB26LIVZvqP+yH5qN1MfFKQTKd2szurTCToZtazz7f0T0hO1v4EiCxpDIr9L7cOvZ6hhqRCofwhfyZKSG+OtRTEyTqgkMXmGTEw1c9xZu1uDUJRYSRkypLYUerorofBFAwMUXtDn8pMTLyMNtPwk49FSRSYpNboStsy4JWmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=c4e69sE0; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="c4e69sE0"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6face1d58dcso3411616d6.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1749670123; x=1750274923; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=InneJdZRcVVlaPFNnewjOZhPI90vEkv+Lpgu7MYMxe8=;
        b=c4e69sE0tvBZOoQG57WwWclkuLyMwSKKw/mmKSqRD1ih56VgmqGmtxgdTDFOhL1qZB
         f6VhE2JEkSY8fMVUgUFfolngH7qOHrrHYfmozG0TdZPJA1J2KrYCPiVM04lJPVreJuTu
         vNdUpcwBbXsmcioHEETZhcs3lcxMl6ZwbB5ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670123; x=1750274923;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InneJdZRcVVlaPFNnewjOZhPI90vEkv+Lpgu7MYMxe8=;
        b=xVjqASdbW80G6a3/bm+/EeUqZZqiJLBGt7PALBRUaaYC7RveVV3s1oLT1a1F1gBckp
         KsU7xgAB+A6e9GrIfEJLYgVr2kQ3rLFsStnHUovBP8g0f3NAXJi3R9dWp9naSf0NkCfE
         4m7YQzG6A0/b4XUoRAFB+Op8vW4a+rzasi5jqC2aTWtMBS5Sc1VTbR7y074MyIJ7Pl2l
         UdI5EcWqJn1ZO+sC/0inViIsP3q1YSsuWxczttC3hGBxpcSoSM03vStPaOUdIRxxR68p
         Sdw9l6CQRVoVpmQKnAF6Yxl+qUMjDRHgx8s5m3abnNcDa2VzHJEkROgh3cS5bx+rNif1
         RLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6jZkQrm2nxgseYc05KydbrCLn9butV0I3LJMmvznnRYrYPDwjL6h7bgnuJEPeIa+Ugtu/6GDBMJOlIptKNs4I@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeXqw/jhIvuuon2o4rrHrkfkTiPAMYGne8djZ3AFOzCYc85C+
	nyAUg8bQAL0mguMmlK9nzhaPecaj+0e/nGp46yTJRF3beZZ+27KtQRj2dytH93p1dQ4/Yy+up/D
	GayE=
X-Gm-Gg: ASbGncsKrZEX2G7UZnrWVS99KmDRBzQABJuyFMckUOCe/D1t+jguNXqG7sRdRsjDUoN
	yc3j28xiPrnpavma4uTKilT3zRUJRI16Y/lT/nn6RCxUjpe+2oZBD2k4aWz5FFFITtPm2LvmkCm
	2efmDMg+z9bZD+DGt/s4mvdS2MNML+xwARSoIz6ubgghmtCHGyszmPEKRheqvEDyRSMyX+T8IbG
	inUK9xwbrmJU56LklutAd4DAQ5Kh4a3LT0Xemhh+RY27JyLv4yW7Bn3Z9LUc6RQMtI6mZ2kdocc
	O7AAH0One+/3aZ1Lz29ukAnDyrbbyvF2hiIl3yGx9jlzo0lx255tujSyc/scyOzVuqrELRzHS4V
	ggEXMrw==
X-Google-Smtp-Source: AGHT+IE6SoauonDa6W5DSM24sCvdDwQpN7IJnm81GX21ZWGOaPczOVEPXw9rzsmF/TsIAaiVA3vGjA==
X-Received: by 2002:a05:622a:1f91:b0:476:964a:e335 with SMTP id d75a77b69052e-4a7229ef9ffmr12316091cf.24.1749670112144;
        Wed, 11 Jun 2025 12:28:32 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a6f5c7a22esm64211531cf.54.2025.06.11.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:28:31 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 11 Jun 2025 15:28:30 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] crashing bug in icl_update_topdown_event
In-Reply-To: <d8c64a21-ed4e-4d37-8d4b-9d3a9857b7fd@linux.intel.com>
Message-ID: <704f6604-547b-f7ca-ad45-2afd2dd70456@maine.edu>
References: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu> <080706b6-ed21-540d-dfae-ae27d130d796@maine.edu> <d8c64a21-ed4e-4d37-8d4b-9d3a9857b7fd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Liang, Kan wrote:

> 
> 
> It seems an regression from the f9bdf1f95339 ("perf/x86/intel: Avoid
> disable PMU if !cpuc->enabled in sample read").
> The commit merged the intel_pmu_auto_reload_read() and
> intel_pmu_read_topdown_event(). It's possible that a PEBS event 0x0400
> runs on a ATOM CPU. So the PERF_X86_EVENT_AUTO_RELOAD is set for the
> event. The is_topdown_event() also returns true.
> 
> Does the below patch help?
> It checks the PERF_X86_EVENT_TOPDOWN flag as well before invoking the
> topdown functions.

With this patch applied my test case no longer crashes.

Thanks,

Vince Weaver
vincent.weaver@maine.edu
