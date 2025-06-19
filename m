Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDE1C8611
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346281; cv=none; b=Quk+/KNl8L8YEtdNhb9zwopqv5IVmlughFE5b07YGKvpKlYWEamr6QRnZHPd7SRmTQdcTmOkuTI/i+SJkNZvQVQPeAyc9slu2kYaakQXNV5iutVza3E2uxs/Be58VWNBeyqZjlm960aI3/RCXIq8YpxqidiDa975hKjQx9LgQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346281; c=relaxed/simple;
	bh=Lss/rPYLZG9odOVpBtCol6toF0P1/fBtF9QDHyljGBw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pGG9YPZeulZ788eoXBAmuz0E6r3HlYKozc1IU4j1urMhsWD4AohD4allVzJCQvsN19JiVTYs8Vsy4nJOZvbldKy+CvGuSRPlt3p6eCMhwxFm+OpQWQj7DygUC2hy5pqSnHTzJmvaUTXTYTI9Axw8xDTmPWABMBWzBfvYSkDhqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=RMtxkTuF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="RMtxkTuF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3862646eeso60781585a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750346279; x=1750951079; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hz28kZce3rKn2T+B8sZgV0w8PzAQ2ReDHPYg2LQY5lA=;
        b=RMtxkTuFai+MNu/IOAYhlxMYajrC4mS7EKOUyPTs2FlgSOhC4f5gJrATVxrurfOz0T
         jRS4pTjLWpkZd7qLCXip4JRsSeiM3P6ZqbeFfY+MrNKWU+IVUnmXp0Iru7L4S7Q3UJA+
         VDuSl99gYZsOTkIYbGdWmJbz2KZDrir8ebg8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750346279; x=1750951079;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz28kZce3rKn2T+B8sZgV0w8PzAQ2ReDHPYg2LQY5lA=;
        b=BYzBKAK/HGH38KGVeR4XkxPqSOmUZT5psQ0rbKCaFzsdpbHiBn4jSS/KOz1CKpThRp
         n3ZIfTMyPHMJdG+7lIlzfF70G5Xck814iKW0yH0j0mMcv1YF71Nw3xfh19tc3gourpfE
         IuGwq+bx2CzlEIAO1EB/dZKdGuOOFimVxgnv4K8f6aDxjsOA22FI3Qv7YsVXZXKPNaNH
         LfElONZRgfPWgC3nz2ier7+l4WCvNk/MB/QyimHrA1bFzdZnKJN3VnGZIjw5TBnekYV8
         mN3oJbY/gxEc9oySENytoCy5sXPn3dQKgrYlMMDm4cqcvq3N5BwWcqTRxSMFK8p6vBqW
         0rsw==
X-Forwarded-Encrypted: i=1; AJvYcCUMxg8dD+rtkdNwiHkrfMKS96JFqUMbuO8lElDKif4jpcNJ7KD8WfM206LYtBHvO8IJtulAJxg5qHI+n9r45iJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvg2MZHMGMchNehIXHP7RWsRURoFoGzEBzw+NYk1oPpyxpWqmr
	iuDQo9h4MMABW29GFpBhlSMZQllGZgydUczLoOPQt0afI2nod6n7OCN3gqKqcbMkNw==
X-Gm-Gg: ASbGncvy/Vl006QMKZeGM9ZllCH7LE7H8WwP5kGEg65qKyA4TK5AbgeczOAFAVr6Mt/
	xrbXzd9z78uu+YmTwQdZLUE4UrRtRHkKz9lQ3RN2kGPSbuDlyPXEHl1HebSEFiGGEUZ9PsEyjUC
	1YmFRHECVjZeftEmw4gzPb7D8KuG6mJ8w5yF3QtYD9pFo1d7DMJ96kVFNq7/jdcVv4ydjv46OCL
	88DMlIX7nnWyz9WSY4RnK+4PNucck9q+pKxDu2CE1fGKhyeMe+xihnsdnlrAYw+A2y2GZaSrgIU
	x9YVthzCuiSmFm1klGundr6P0yeo7FJnjv2HpsJujbHFvE4wCHJir/iTjPPhX3WK6rgL/U0YJib
	zE6OJwQ==
X-Google-Smtp-Source: AGHT+IEtRLEcL6c4FOyoPa6VH1mLjUTdXNOPO0QoSfcHnfta24N3guMo0jFLti3k1pcheA+EEeb6AQ==
X-Received: by 2002:a05:620a:1a86:b0:7d3:c68e:fcf6 with SMTP id af79cd13be357-7d3c6c0dd22mr3150099885a.9.1750346278672;
        Thu, 19 Jun 2025 08:17:58 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f8e4b8ecsm7861585a.74.2025.06.19.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:17:57 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 19 Jun 2025 11:17:56 -0400 (EDT)
To: Vince Weaver <vincent.weaver@maine.edu>
cc: "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
In-Reply-To: <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
Message-ID: <52656281-ab73-baf7-0a80-ebcbe79dfca2@maine.edu>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu> <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com> <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu> <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com>
 <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Jun 2025, Vince Weaver wrote:

> On Wed, 18 Jun 2025, Liang, Kan wrote:
> 
> > No, the error message doesn't say it. Just want to check if you have
> > extra information. Because the Topdown perf metrics is only supported on
> > p-core. I want to understand whether the code messes up with e-core.
> 
> I can't easily tell from the fuzzer as it intentionally switches cores 
> often.  I guess I could patch the kernel to report CPU when the WRMSR 
> error triggers.

I've patched the kernel to get rid of the warn_once() and added a printk
for smp_processor_id()  (is that what I want to print?)  In any case that 
reports the warning is happening on CPU1 which is actually a P core, not 
an atom core.

Vince Weaver
vincent.weaver@maine.edu
