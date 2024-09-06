Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A52155732;
	Fri,  6 Sep 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610355; cv=none; b=IYuZok3oxcs4P4c4YyUzoM24zTU+pzBRIKdVCKiFJMapilNLVes7qsIpDCOPntQxwJF7uKKmeJmLDUCnJl2DDHEpJznVQs2YsQuTBn6fZBXIybKxypbPfz1FJwE08h2oImClSFQTIAirRzyO3iVoREdOhxL5YKvZpMI3XbxG8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610355; c=relaxed/simple;
	bh=UWpwGB3hOXzvwxu0sLSidDGYUqVqGHxyP+GWMOcbby8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+zdoUMhlYsTCtQytpvo6rFMJjLM9Wi1OJC3H76rlcSiWVZ7gv+SLRGI8CY5jI1j4FHvkfpyHgg+M6aE+TcMQIT+BFlgDeZYX6+GsZzVTl5UYRkzs/hnCeovruirMOd3lAhfRii8G+EfWc3HYq3Z8BvCyz482fMmstv0xguIDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCplR2Ej; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCplR2Ej"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42c94e59b93so15426915e9.1;
        Fri, 06 Sep 2024 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725610352; x=1726215152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC+dvkJhq/G3oGDne228ddeYfJVB1YPiQTaYddUNBtE=;
        b=fCplR2EjQdARw6bXdBRnibX2TwnYh3pMAOkgH4J5vPfnf9hIvY8CF6Jl14b6vVkrIV
         mAcOKnLVv3UEvWCHXMoeZwbpXZAy5jzLvdeYZKVKf67PnTBh2ePcmEmgNb+VJZII6oyS
         xHsV5dVpDFTzayyMXh8TeYDktc+HLl4YQLJBpMWpOrECNLkbVs7/og3nZSwFpkXVCyWB
         qDFkMOoiXKu7Yn2b8f82DJWPFpGu7oMwBFo7HZyCU2jVGlFnO4moDhrhaX6XhY4bJQ1c
         onD/PNCO+l3pPFLv7mpN2Z2uY8ln6xT/3/imw3vx1+6rG5PJHgxLkuwlUwk3bagX5Kek
         79Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725610352; x=1726215152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC+dvkJhq/G3oGDne228ddeYfJVB1YPiQTaYddUNBtE=;
        b=b6Fy0vZmG/VYLFbm2mJ8qa//TOWqFOF0Rio5VRvBanJTpbk03srJzJLuGLPD60gcyu
         VIOOIOFEgYsDPLCYOw2YBcGNbYXJxom8W1qXpUmMndyGvEELaCZavvny0pZhk9NDBlmI
         qIQFn2agIubWEBNurih4/fkqs6ojARPywFOppInK7c1ophbiy+43Y7XCSf0FQmdlfnC8
         f0vj+mzvVro5pqWzLFVmwLpoE3ywRCAJjWp7155nWqvIKB9XF802g1GoF6GWgCiiO3FE
         2FUye8TYe7EfKwtarBc0r26uj8TpdYR6jPX1jDfEkmAxlLol3G2mFwTkOby2KRuf/tvL
         P4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUYJFNE7z5KAuH3A/ptbEpgRVFyt4+iGp8JUlh4JgUZctmuHGGce/nrdZMRohICDsqQ4HYz+XB1rJT/UG2A8i18vA==@vger.kernel.org, AJvYcCWJ2UiIQmaXfjFWeIaG4udHx0ZIcM3xzQcIXo8X11wsSjYMqrK5sY+iSD6Cc8CiRx8qOCyU+Tv0fegW9yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFdXL8ifQNOTrKg/XyTtS0KV0XIicPICZyrPJkszvMN7IWVSt
	jh5/zcS12mbd/KIZ7+zBh+hpArFjASsrWSNyNXer8ADZep6jNZGX
X-Google-Smtp-Source: AGHT+IG1ZJtWKkJO8/SAaiocgyDO2wR5cL37STT+7rljQjF4nIaJLxXaNcyE08Uc3wakXLAogFHq+g==
X-Received: by 2002:adf:a15d:0:b0:377:7256:bb3f with SMTP id ffacd0b85a97d-3779a612a68mr4931270f8f.14.1725610351490;
        Fri, 06 Sep 2024 01:12:31 -0700 (PDT)
Received: from gmail.com (1F2EF525.nat.pool.telekom.hu. [31.46.245.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca054c166sm12486665e9.0.2024.09.06.01.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:12:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 6 Sep 2024 10:12:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	gautham.shenoy@amd.com, ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Message-ID: <Ztq5bI0PBhYWEUV4@gmail.com>
References: <20240905153821.3822-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905153821.3822-1-Dhananjay.Ugwekar@amd.com>


* Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> wrote:

> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer
> return the package cpumask and package id, instead they return the CCD
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
> event scope to be modified to CCD instead of package.
> 
> So, change the PMU scope for AMD and Hygon back to package.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package
> scope event, only one CPU will be collecting the event for all the CPUs in
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
> v3 Link: https://lore.kernel.org/all/20240904100934.3260-1-Dhananjay.Ugwekar@amd.com/
> 
> Changes from v3:
> * Move the rapl_pmu_is_pkg_scope() check before the memory allocation for rapl_pmus
> 
> tip/master + PMU scope patchset [1] to be taken as base for testing this patch. 

> @@ -643,9 +672,10 @@ static int __init init_rapl_pmus(void)
>  	rapl_pmus->pmu.start		= rapl_pmu_event_start;
>  	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
>  	rapl_pmus->pmu.read		= rapl_pmu_event_read;
> +	rapl_pmus->pmu.scope		= rapl_pmu_scope;
>  	rapl_pmus->pmu.module		= THIS_MODULE;
> -	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
>  	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
> +
>  	return 0;
>  }

This chunk doesn't apply to perf/urgent.

Thanks,

	Ingo
