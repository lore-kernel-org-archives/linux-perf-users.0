Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CF168489
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854263; cv=none; b=jz4L4d5NbC4iMGLeR4BZOX8eD4rJ/BL42LJuPJhwgAPCK8d9u4YojDWTo7CUvgq5pz3CHaqVT48ovSHGlL3siD6831ckwdFLL390EtxgGFYUpP0JEZwsqk4xJdBF2h/CawktUKHtUuUEVAQdVx7oqpFSGr8PFmalfVRrss3YOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854263; c=relaxed/simple;
	bh=WmTe0NmTE5nz7CnVH0CZsvjpOyownnTQR8nHuQ/BEcc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mL1sOuRb5NdMxX6GSlK7Car1pXjA3605Ilc0PtODSjHPo4fFfUirN233xx4gaa0F8O8RhWadKYtJ/NuVuEOfhLsk9uU8fcU+XlPaKq17itfOgQvBdpEPObjwBkMTNG0SYFCPv3B0eMqexZ1pQB2hDHdm/aZmgP+otlLyvXWSBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkUBu0nV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkUBu0nV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724854260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctDyDuNIi0XNqOWhLL27sc5y8m8fIjPT9hoerciMlg8=;
	b=AkUBu0nVO5u7ZcJrlbAaGP+rr5/43T9XFBaOSo5A/gdlioj2jYUXMVK/AssDYCk3nhEn1v
	ichul+lk/tv5OIx+SSYmwEKbOn19RH8O/z4TQYKW0xt5VR6tOofFacCOgDvHiILE1u6Gtv
	uLSrVa9mBh91I5BjWf8YRtZ0J+IV7pk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-dKNq0aDgP86JZ8OmbscWpA-1; Wed, 28 Aug 2024 10:10:59 -0400
X-MC-Unique: dKNq0aDgP86JZ8OmbscWpA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371936be293so4021527f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854257; x=1725459057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctDyDuNIi0XNqOWhLL27sc5y8m8fIjPT9hoerciMlg8=;
        b=uUgjXzX1fNWpeknKwt935iJ4vIiQZpEFiDqSOOzJ4qMWm+Tl9lzUiPEQMmzxP31A17
         U6D5GYb/E2Em/Uey/pGokepz8n+T0cg/hw7KVKO/yTX6lrtplhuynwQ/wsKuyU2iIT3l
         EQcp9NhpWcqLtP8xBLazjhVOjpMrgcEknsM9gRBGbkGUrXu8H/UFGcIB9I8NR63+2IIq
         EYR/EEDdZ42O+6vA66NuKVEZ72BqfOfmbS+DyfCw3ix4EIeLM/jFJkPeUjZUFzS88+SO
         60Azwa9tyfJ6cIWELV7gTZPaoBf6yR1A7vmRmox/lXVg8IJ89tPuRJSHSezzxzSmMYe1
         ckWA==
X-Gm-Message-State: AOJu0Yyl/GbkjZR+/SmzYSjncMyfNWVJhkT8dTSWzavNhklOqwtb8Z2K
	A7JbuBDEJE4UJnU98sj01Y7jwY+fQ6OJIr72Eh3zOkoBCv0VOgaGhllhpmBALKTnT+MuBZvk3EL
	tw+gSUcXSUrPRLP4/L4A5cKvL20O5t5aBZDXHejPEHuRKyfv9fMSGL4rnSI8zQRTlgsUSeu8oYm
	aeG8Ro30+dAH4/DwFilxd9Gqcu4CuerELOdJptI2p3uPfVJIAH99fuQg==
X-Received: by 2002:adf:cd08:0:b0:368:3789:1b6 with SMTP id ffacd0b85a97d-3749684b764mr1448029f8f.47.1724854257606;
        Wed, 28 Aug 2024 07:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5bwuQ62CDeP5uNw9Mhk+Sz9K/jdnShoyWeo4RUCQ+ET5jXye4ymQDWje0T7Ljl0hvWCUG5A==
X-Received: by 2002:adf:cd08:0:b0:368:3789:1b6 with SMTP id ffacd0b85a97d-3749684b764mr1447996f8f.47.1724854256797;
        Wed, 28 Aug 2024 07:10:56 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815c035sm15676994f8f.55.2024.08.28.07.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:10:56 -0700 (PDT)
Message-ID: <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
Date: Wed, 28 Aug 2024 16:10:55 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
From: Veronika Molnarova <vmolnaro@redhat.com>
To: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org
Cc: acme@kernel.org, mpetlan@redhat.com, irogers@google.com,
 atrajeev@linux.vnet.ibm.com, masami.hiramatsu.pt@hitachi.com
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
Content-Language: en-US
In-Reply-To: <20240702110849.31904-1-vmolnaro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping

On 7/2/24 13:08, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Hello,
> 
> rebased the patches for the current perf-tools-next branch in v2 as it
> was not applying.
> 
> Thanks for the notice,
> Veronika
> 
> Michael Petlan (2):
>   perf tests shell: Skip base_* dirs in test script search
>   perf testsuite: Install perf-report tests
> 
> Veronika Molnarova (9):
>   perf testsuite: Merge settings files for shell tests
>   perf testsuite: Fix shellcheck warnings
>   perf testsuite probe: Add test for blacklisted kprobes handling
>   perf testsuite probe: Add test for basic perf-probe options
>   perf testsuite probe: Add test for invalid options
>   perf testsuite probe: Add test for line semantics
>   perf testsuite: Add common output checking helper
>   perf testsuite report: Add test for perf-report basic functionality
>   perf testsuite report: Add test case for perf report
> 
>  tools/perf/Makefile.perf                      |   2 +
>  tools/perf/tests/shell/base_probe/settings.sh |  48 -----
>  .../base_probe/test_adding_blacklisted.sh     |  67 ++++++
>  .../shell/base_probe/test_adding_kernel.sh    |   3 -
>  .../perf/tests/shell/base_probe/test_basic.sh |  80 ++++++++
>  .../shell/base_probe/test_invalid_options.sh  |  79 ++++++++
>  .../shell/base_probe/test_line_semantics.sh   |  55 +++++
>  tools/perf/tests/shell/base_report/setup.sh   |  32 +++
>  .../shell/base_report/stderr-whitelist.txt    |   5 +
>  .../tests/shell/base_report/test_basic.sh     | 190 ++++++++++++++++++
>  .../shell/common/check_errors_whitelisted.pl  |  51 +++++
>  tools/perf/tests/shell/common/init.sh         |  31 ++-
>  tools/perf/tests/shell/common/settings.sh     |  28 ++-
>  .../tests/shell/perftool-testsuite_report.sh  |  23 +++
>  tools/perf/tests/tests-scripts.c              |   2 +
>  15 files changed, 640 insertions(+), 56 deletions(-)
>  delete mode 100644 tools/perf/tests/shell/base_probe/settings.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh
>  create mode 100755 tools/perf/tests/shell/base_probe/test_line_semantics.sh
>  create mode 100755 tools/perf/tests/shell/base_report/setup.sh
>  create mode 100644 tools/perf/tests/shell/base_report/stderr-whitelist.txt
>  create mode 100755 tools/perf/tests/shell/base_report/test_basic.sh
>  create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
>  create mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
> 

