Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33176410
	for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405092; cv=none; b=E3BgWobefQXpHHIswvz4peWQcH2R7WFdCD1h4p92Q7YILnBRKX4TE8MwAiFEXzOlZxDZU73e0Mjv4qZM3J0WbIdmvdAzeEAFS46YxHR+rod262pHOC8S735jStc5kubOGtGrG4gEZtzkmCXdGW6wxQgJ9JiLJ05gn+U2iLl7uNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405092; c=relaxed/simple;
	bh=eMAldY621LGBuYWnS0DttmFZTqueAPJOlZY/rBYz5WY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZzIKiXyT7nBTiiX94LcABfIMBSo/+nfmwkVC6tDQG5M8Y9j6xc1nPyP4dlWjNuJtL3tuJGmUpucLpAiPyJKm2wGKLJ/IituEQzejFjdRR8qFhcNOBySHL1ohZWQziFRP/QM0gW8lAA9PD/9urgQhxa/7hF2IV4M8FytM8u+nBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=NeZPS+LI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="NeZPS+LI"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c597760323so232998785a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1747405089; x=1748009889; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=owY4nRaaHwvI0FEJzLInMFg5XKLo1UFESw5ag0F5X+w=;
        b=NeZPS+LIdYd8rZsx68P/1Fr/6QxTqVyMCcRY5T7d3L4VUWLKuA10Dha32ET9/bYE2V
         JFyM0eG8ApelM+O1795yEvvIjMDLG+pobTO9QU7eZhXvSMB5IfmRs84EhNpmX+XYbYLv
         KoGphNopelw223F5CluNFoAhI3SS6yrKIQaSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747405089; x=1748009889;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owY4nRaaHwvI0FEJzLInMFg5XKLo1UFESw5ag0F5X+w=;
        b=rAlivLXDL86X8MdXEpi0nFrvelKJphkFFpEiRorpk8BjgTswaUWFBLDvjUDjv2+ObQ
         D43Z+mWsmKc+hlYfAIHUuYJgUkLwyuuKnHAmaWqzsEy+FFx+VLP3BRBzbHQscHna30mr
         Y4OgM3NFswLNJbYRN5MRXamofDKbdW1ZF8VugfUOqfecyagaiOjISeUNYnTBrXdmpOIH
         BsrOVfdqMdD5KPgpQK+w9QGWTly9zzL81R5Xmpzlyv/3VbuJp5ndGiQaV4Zo2onV9W5R
         0qw8ivaB0ZAIAMPkv0QooeQr4wQOqhfBgpHf7tgJaHJPIxgAWYPQswPIkqBwg//ua3ML
         Dftw==
X-Forwarded-Encrypted: i=1; AJvYcCUgiRjtrqi5+3Pzu2cIupxWfzej6tiracwfL1iFLjiGOCmk4dSsJmi2M1uOQDAs90oJMhk+Oon0clHV6KEg+P3K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xEnrdOmAwVPJewM4PkZpWTRelbR60rVaxVIZtgHbPlXfsEMb
	oyRCpaEfLbc+8CH99u38VSsaGMuJa17KddHSjiQncGGl9DaXyuGrN0ToQSKDAmJLnw==
X-Gm-Gg: ASbGnctNTW3rDxvOo5hDpovOcORUeNTgn4RT8LEVtNznnJxINzPQReGhn2e0Be7bJhw
	jC58ZnD7IeLosr0kmlEWbU3cLNyD16N5r91oTjOKmMh/FHh68cW7pLp4otPNiLt3c0piQMyAOZn
	HVderWe+uY/hJU56n8Vq/oqa3e+1dTKEZFwIU9yQYCkm/dheDyI0k9TR9gfp7oIOs+vxs9IQG4j
	8h3lMLXah206TZ8wAkyWwZGA3aku0TBNWCi8a0dVPOixBl45opA8jc4c4FDnFlCyainVT1o6xX+
	WBCHtmvM8vWshuj4UGeMvcD9hrM6ZhATLFRVy5UfsdWwMePk28PmYsYOTNmirgorW5SGFww=
X-Google-Smtp-Source: AGHT+IHX54JGF3VTnio+m8DU2sCiIbyBg5xhIiMGOX8DYyY/nAQMnnooQoTr9NQ1eTWo+ItnU0AtUg==
X-Received: by 2002:a05:620a:444d:b0:7c5:5f19:c64f with SMTP id af79cd13be357-7cd46708138mr549132785a.4.1747405089444;
        Fri, 16 May 2025 07:18:09 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467db690sm123338585a.48.2025.05.16.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:18:08 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 16 May 2025 10:18:07 -0400 (EDT)
To: linux-kernel@vger.kernel.org
cc: linux-tip-commits@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>, 
    Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86/amd/core: Fix Family 17h+ instruction
 cache events
In-Reply-To: <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
Message-ID: <c409c331-da7d-7424-e0db-a4c61ea423ca@maine.edu>
References: =?utf-8?q?=3C2f475a1ba4b240111e69644fc2d5bf93b2e39c99=2E174661?= =?utf-8?q?8724=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?= <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 May 2025, tip-bot2 for Sandipan Das wrote:

> The following commit has been merged into the perf/urgent branch of tip:
> 

> perf/x86/amd/core: Fix Family 17h+ instruction cache events
> 
> PMCx080 and PMCx081 report incorrect IC accesses and misses respectively
> for all Family 17h and later processors. PMCx060 unit mask 0x10 replaces
> PMCx081 for counting IC misses but there is no suitable replacement for
> counting IC accesses.

can you link to the errata document that describes this problem as well as 
maybe give a rundown of how and why this breaks?

Vince Weaver
vincent.weaver@maine.edu
