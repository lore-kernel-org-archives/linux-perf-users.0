Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4413AA2B;
	Thu,  5 Sep 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530873; cv=none; b=oCA95WOSBKxCgIu5wg92oi8Sg94qw/VwBl3BaBYf3r6Kh1ME1P8cjdfCJDIvfYWXuhjpok8+pVG+JM0yI2CWNS9sVJhucPBUDjodCZ3z41BWAugBOznx9yJnHNcuDW6sxG/Q5Hfxy/sH9fpCflqvDSDbx+7/O1tMPlXKEK3xjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530873; c=relaxed/simple;
	bh=8+yEYQloSb35AbD/c6EivzKKFCvB3oHMSwHLT/lrbC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Toagxl5WnEvHEdjntA6ivikOklbdXFHqMIB2HM+mr6DSR/YOniLINcumxT5M6gNZ/D5HBY6TYNMBNYnMND/KwvIHu84VKVMMbcIyHRkeZlWK/TSXq5Zd4KmjFm67xmLz8S3+p28rKAou/ox5kt6LlAKxllrRt6qXJBKUvYNgB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbm1rfkl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbm1rfkl"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbe908380so4547455e9.2;
        Thu, 05 Sep 2024 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725530870; x=1726135670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVBpYbN9FUlDCPdRPdnCD8BoUHCMkop99PjMh0L2J1M=;
        b=jbm1rfkl5dKXRoxNDubT36iXdfL4gACi/4KP3hU4g2AzaxFwvTSej6OWrwP7foNX+O
         z89jLzDicXAUn/n5B41pLoWloKwvS1L7riU65yBxfolkfPaRg6yqbem1tc/u1Y5DwO1t
         lZWkLf1H2i7yeM7Wi1SdY/yrvSU823/5lokniqg5rT6yCqndktYbiBoQxCgOgGu6s/M0
         YAb9ccZQ7/QXOuObwMIDj+uaQlgmjfI6KkaV7HjoEGzdVk8ALKbbMRp2QDFTiuHxr9Lg
         LabikWu/m3BcwxNx2pBLObYpHcP61Gmr02rUXAPbZl+OAJMQHakk7elmoL+Ka0IyLP+b
         ZIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725530870; x=1726135670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVBpYbN9FUlDCPdRPdnCD8BoUHCMkop99PjMh0L2J1M=;
        b=ukL/nXRrkaljayG3S6tqtLpDrSjCJl4DDAmMMpxXc0HdGjjz7Zd7OLs3CDwfi9dob4
         x4XRRCWM427OszSlQ52OIYf9a2L+ck1GbKJ98vv89+Y33GdGJXdfQLu4dzNv9wo1fcDu
         v1YBGFGu7FYyRd9srwFMtWAtIbwVqhtqWwRSH9DaR51tM0/d4J+OeCR40F1Uma/8btZE
         xADpWMH0/YMGYnKCfCy3usmZF+B9Eq+TxxJHQWqA+mli5TlLvQHts8RVNOjdzn/1aI3g
         /I13eHaMvZJKxfRLqzz21hxop7D677So2MWSZRzNIuJqfYc88VAXqwuF/ECLFwCQDlKh
         UO/A==
X-Forwarded-Encrypted: i=1; AJvYcCVdH1vd17p0VsoRmDh9Tih8jJVF/p8K9JAd1sPOT3l8YOS6utQCvxm27jsTdsh2di/dpiMZEjCxPKKn8iOFgZiXeg==@vger.kernel.org, AJvYcCXcNaoj2IqidRFt7JX2uVIYlIC7Rtc/WSgtiUzYoab6jRPZ7zDF7KyL4OmvEaoDrcY9Gdtw8PfQZwZ7m24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhuu4c4+P34Ann3GCtTNPbr39e32gm30LKlZp7mp7enGhi/hEP
	mb59+xQcHK8l8fKvnsnJFfJaDFhDB9jWez62ekxmkRP0Q7hSHhCH
X-Google-Smtp-Source: AGHT+IHlDKo45UTAojMx1v/LjuS5FK6JXSOUdUDY8gr5BSXfjdq70WWCwyA/s/Ptpb4/5mRyjF9V5Q==
X-Received: by 2002:a05:600c:4eca:b0:426:5471:156a with SMTP id 5b1f17b1804b1-42bdc6334cbmr125451395e9.13.1725530870011;
        Thu, 05 Sep 2024 03:07:50 -0700 (PDT)
Received: from gmail.com (1F2EF525.unconfigured.pool.telekom.hu. [31.46.245.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639671dsm266679645e9.5.2024.09.05.03.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:07:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 5 Sep 2024 12:07:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, gautham.shenoy@amd.com,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Message-ID: <ZtmC8hhpUvQTXFDn@gmail.com>
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
 <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>


* Liang, Kan <kan.liang@linux.intel.com> wrote:

> 
> 
> On 2024-09-04 6:09 a.m., Dhananjay Ugwekar wrote:
> > After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> > on AMD processors that support extended CPUID leaf 0x80000026, the
> > topology_die_cpumask() and topology_logical_die_id() macros, no longer
> > return the package cpumask and package id, instead they return the CCD
> > (Core Complex Die) mask and id respectively. This leads to the energy-pkg
> > event scope to be modified to CCD instead of package.
> > 
> > So, change the PMU scope for AMD and Hygon back to package.
> > 
> > On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> > 
> > Before:
> > $ cat /sys/devices/power/cpumask
> > 0,8,16,24,32,40,48,56,64,72,80,88.
> > 
> > The expected cpumask here is supposed to be just "0", as it is a package
> > scope event, only one CPU will be collecting the event for all the CPUs in
> > the package.
> > 
> > After:
> > $ cat /sys/devices/power/cpumask
> > 0
> > 
> > Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Note that I just merged the older v2 version into perf/urgent, because it's 
a regression fix, and to not create a backporting complication. I added 
your Reviewed-by to it if that's fine with you.

Your hotplug series can essentially revert this:

  8d72eba1cf8c ("perf/x86/rapl: Fix the energy-pkg event for AMD CPUs")

and apply the v3 patch to gain the simpler version.

Thanks,

	Ingo
