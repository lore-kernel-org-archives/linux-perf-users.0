Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75681193060
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616922; cv=none; b=NI1w3FtbqmPIWVe142DVxGJXdl0kNYdERYVxkRSy97JT31WwVQSS6uyI/9GQhrjUVMJP8spfpGZJazPYouCbX0xh7XcYaXAEVf8s22JCIdq83BHa5EFNtVFE3uZ115Ek6gZEYp0perDHtrZ4/7NMNjAYGO1nue7LLIELZ4A6jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616922; c=relaxed/simple;
	bh=QeyjTSziSsVFe1DChrP/yRnOREqQL0sosAgzfMWH/J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmil6GGJ82wuc8/hTasktsS/v/ZV8GnEfAtzU/SaykcQ/YmYJfquv5aQ3fZdkxWS2rj6RvleYHHKVKduiViGoo/oB1XV+3JbmDNJv+rH23gTNKRT0hQuoQz0e/W6QA46qgy+LmqNtkGUJFLQoWLZ7OpEbe5zWfeExLC0UBkpvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=SMv6SDFZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="SMv6SDFZ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7955ddc6516so302162685a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2024 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718616920; x=1719221720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hZzV45iNv0Ldf9zk8+wWWXuniGWZT5cS9IFQO5nsD4k=;
        b=SMv6SDFZGsQ2cng1kRTcug84syzHiuXCNBZ42axgHRsC3BggWWRZUMWmTKuNO/IqFT
         mdwrFXVlKFf2fwyVT+djVUngDPRauODJmvdgiw+alwpMsdm01dEo20sunFZ2q0q83vsm
         89roBV80JOLo+roVucRrFRmhNv5GkW2LPt23w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616920; x=1719221720;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZzV45iNv0Ldf9zk8+wWWXuniGWZT5cS9IFQO5nsD4k=;
        b=kjzgzmdihEF2IC3DygFv9D+6nwV9oYCLYyox9szhUeE4CUtZ9MaYkm027SEbpBEWpC
         3lCT26vvE0SIrozLucuY0v+YKA608AxQFqnMhNISEjraMTDEp5tu0dI4tLepNZyXGGbD
         DG0db7uYMfmae2a+XpTMVS2prj784CCACeu7YTP4HVTKo2Q2tTOqRgdtWuRisOLAAAJI
         Fp0Lf2fzxHxxB/vrm5KCptm0GiBkoaaiN5LbhZ9QFWRms2DnpCs0L4AgQRxJeFBYtC8Y
         lStwLomwhxHc91pCGlv98krVjuTlfqSknr1wiBNh79vQU6m91o2EcjydSfR4mLjU9O5j
         Up5A==
X-Forwarded-Encrypted: i=1; AJvYcCXNa3x8eGNL30oFrGuJqvSF8KjmH2SFBL9pCIx5LZb/MKnzFdNPTEZH+r1upkSs8bel3wv6N1RSf1+k5cBPyjf3A/ajyrvRjJ8+QGI/fIzJ/A==
X-Gm-Message-State: AOJu0YzQsoYP0MRYIDoIp4LyWWkPOwGG/B78k9rp4vTQV+/hnZHWB6iG
	jTbu8NdB3QZo4EfI1LIHXLvo8o1etxbY3mnoilS4Va7ScPAzivSrAgTYA3INmsE=
X-Google-Smtp-Source: AGHT+IF2aZVz2wdsoed5g5hsJNVZ5D0M7nSHyyRJA+LASgY7f1atiDw7hH6bBcRtto7990SD6YfPFg==
X-Received: by 2002:ad4:4381:0:b0:6b0:6965:511 with SMTP id 6a1803df08f44-6b2afc6ca64mr87440946d6.7.1718616920332;
        Mon, 17 Jun 2024 02:35:20 -0700 (PDT)
Received: from [10.125.226.166] ([160.101.139.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf2832sm53569346d6.24.2024.06.17.02.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:35:19 -0700 (PDT)
Message-ID: <f4242edf-6c78-421c-8e21-63627b13c35f@citrix.com>
Date: Mon, 17 Jun 2024 10:35:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/06/2024 10:11 am, Pawan Gupta wrote:
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cb4f6c513c48..f310a7fb4e00 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -95,6 +95,9 @@ struct cpuinfo_topology {
>  	// Core ID relative to the package
>  	u32			core_id;
>  
> +	// CPU-type e.g. performance, efficiency etc.
> +	u8			cpu_type;
> +

End of the structure?  At least that way new additions are less likely
to add more padding.

> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 9a6069e7133c..be82c8769bb2 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -140,6 +140,14 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>  	}
>  }
>  
> +static void topo_set_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
> +
> +	if (c->x86_vendor == X86_VENDOR_INTEL && cpuid_eax(0) >= 0x1a)

c->cpuid_level ?

~Andrew
