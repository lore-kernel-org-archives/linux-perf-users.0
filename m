Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8612153E9
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687303; cv=none; b=FwIbgacs+4hSg29HCXGkerhSxstAiBtpmYJwhB+d01Omal1CQ+jRK1V7N4k9MXDN+eUQCuR+Iu96GU4bPBS9WpRVYASGqoRgTF/Zya7VFYQN59gxw/iHv+ciDsgZq1SAQzMH5Jp/vLGDekd2dS06K0y8BzGnGsSYzR0wazxVeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687303; c=relaxed/simple;
	bh=KmbuQodd8gdeNbqKPNLZW0QJqWSD6SMs5dgCQkjfjSE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J3UrIntlMoItr7lLg+ypnm/UIxZkBXzR1g4/GxFQBwzUvyBzpbHkSxAEUY/eMZyShGLXFfKvm7eaa87MgYLxtI6TsyVokM7VYAVJhW+kKQ1Zj3R+g96sXs6OHWgfwZe70v2m30Awibk1fQ5iy4+Gstl1RFk2YMaJ5sWOVi7W5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=ZyOD8byj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="ZyOD8byj"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46e28597955so52160661cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1738687300; x=1739292100; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=52Wdx1BmdnQgYoMxdnPqrdFSJsd5zNLPV/6lG8XSTk8=;
        b=ZyOD8byjj6qfFXjGy2yENHxXSbUsfgD12SNVLgMUmmWbvO4nnB39kc1iQR3F+fKaQU
         18gymkxtK4wjob2OwXq7bXQSL3nBR7grMB3iJmjYCtaY1AbPGwvcFlhhOvTMRF/A1IcJ
         czwcsGNMQ2IzLk7IoZ/eHCrZMOpfDV1YLPSVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687300; x=1739292100;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52Wdx1BmdnQgYoMxdnPqrdFSJsd5zNLPV/6lG8XSTk8=;
        b=KzzIXqk/ZvsmiKKAOU2EVo5e2Y47vdIffzBQlKXCQ0eP6/z31h5x/GJaPbnMDwxaEe
         MyzRRryFa7dFPIzjruonPp+VFKn0+aO0WfZdzYl3HBTAKEOcRUZWJH9lubcDANLSqE6i
         7n1r/QIQHSfrnuLF7nzq/PHSsrs5LRDzay68KOcU+DADcfaHToy53Rh8AMgPL4R1sn66
         TYfbGhscufp7tJLshKX5qxDLId59c6TdPTEwXshVSkxKVq1xRG6JP16ArETjVXX8vUVu
         TAtiQ/y3igPpMt0XCctPxkmb7JQX0KM6TbrSO67EGNY4AnRpMbhvGhMz0Vdev+pv3TQ9
         Tf9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2eIb+b2rjz6+kfuip4Tvn0V+DI362e9tGEnr/advLb71gQyDRyjd5AFHdbSltA3hmYmox9PlnKJy46kchP06c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz90c95tJ40Pe4F3v4JqgmUbnSm7hLactGBvkUAJcCgqvSTVE2
	FHyHBFh2PeT9XOqIMLZwoN3bWqs1/3I46IGOfFgWqtafFMBF3u23+7WdJw3Y3w==
X-Gm-Gg: ASbGncu1+cULazU5u5bAI+/wZdjf20WVZ4iap8DNoJcZBbjm+zZn0PBCGH5X0cP3Gzp
	quEBSJtTjLPM9wNoliZxh+hfVTZdTUbcyvun1LUEur8EEz+UVLGjbP8oMRijSsW8VmHzopHgKoC
	V6DaP0VGiGbZ8vlqE4y8bbp/Rc+hvQMINeZI9JULXAHnKPfx3kKN3mJEDpgoHIiSLKhSYGWMemn
	GQIeuvQ4zMsPOM2pe+B74Xl+n7spd1+qE4FC125rTwWxCrie0bB6F34/9cGf7ca5A/6H6WJNR/D
	E1N8VVAIBcyrstv5T5EOnMF7crg2xurz89DWcA==
X-Google-Smtp-Source: AGHT+IHfp/3fqPtIKWPO/WOMcL7EqM8NzX6aIAw0wddWU+eeThQX93zsyLCt4Vbb/kcMnKFcCRw82w==
X-Received: by 2002:ac8:5d12:0:b0:46c:8380:4392 with SMTP id d75a77b69052e-46fd0a96272mr370145551cf.20.1738687300627;
        Tue, 04 Feb 2025 08:41:40 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0e3089sm62240381cf.46.2025.02.04.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:41:39 -0800 (PST)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 4 Feb 2025 11:41:38 -0500 (EST)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: "Liang, Kan" <kan.liang@linux.intel.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
In-Reply-To: <2025020408-apron-fled-d29e@gregkh>
Message-ID: <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
References: <2025020304-chip-trench-4e56@gregkh> <87pljyyx68.fsf@ubik.fi.intel.com> <2025020426-spool-refreeze-2870@gregkh> <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com> <2025020408-apron-fled-d29e@gregkh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Greg Kroah-Hartman wrote:

> 
> It seems that the majority of the perf code IS looking in the correct
> place, just mem-events.c seemed wrong.

I hate to tell you, but other places in userspace are depending on the 
current setup.  libpfm4, used by PAPI, is looking directly in /sys/devices 
for pmus and will break with the changes you are planning.

Vince Weaver
vincent.weaver@maine.edu

