Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C451AA7A2
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306418; cv=none; b=B2DLAVyrFLmjvNyiE1PnIyAcWth7K9+miOdmZYXrbm5V5/qkRZXlAvLbl60DOguAH/+Pn0MelbVT+Li0fe42jVo6vm45zvS2MMNym9LkNCXZhplWoQZuaMcvbPJ6+T+nUaNL4ZCcwKQDYXXMnGVZ3R6lxDjq5V2jWmsQmyUgWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306418; c=relaxed/simple;
	bh=gmTWp42uVpMYzw60S7pepILZWkU0vYie0Bkl0Evppjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLWOICpM8t8qkga3CIPQw0gjlUDoPKU0+mytW/H/xWFjZ3MhHHBuvz3vQUR6sdUKL2wLGI3rZTRuLvk8oN+nhbjgVEC0SvrBQU1miUAu2f793bpQumH/PQKP9ZyeWoww0rdzgdillueVvY2fsioxVUOucQqisFEM9MUmQ3OTJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkNNj1kJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkNNj1kJ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e3621518so3470647f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733306415; x=1733911215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ct6TiWILSfI4o4NLd8e+Uh155SuDdxolQSAG0h83St8=;
        b=bkNNj1kJ7Hyev2lAS0sGbRDA5mQGkWyDjOOxhoU1rUz7megc5lq3BBO4O5dCcBFjJ/
         C2UlOlJHLh66GU5G46eyX6rP8+DG2ynOfT9ryYlI04a3XLd43rxcmS2fKvD6ki7t/0jX
         ezZqihIDfNf7w7qQdrZxub7o122DqnAzz7fC7IBqV24z2zLH8r3x5OmT1nMnl6VOhkzi
         rUPhSzesB8DZi5mU3rQRiM+RySIUzGi90ohz9SOV8zRnQKUTGQaC/wZtkJvquk3/siFE
         nkcV86SvPdT80moFwuPPQ0BSbIjf/4PkrZVlIQoLaj81PaXDy+ZgraQbkaiLwTDy9R3L
         zVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306415; x=1733911215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct6TiWILSfI4o4NLd8e+Uh155SuDdxolQSAG0h83St8=;
        b=X+95sk1+9h1G6oHnghDwd5LirLBFKLQpxH0leYnBA7IHO23XH60G5X6pOQluGugJ2n
         lWfiOgT4FaMwL/ixx1tiWW49ncCIUyQLXWj2lNUuSx5Yi6TJtjfvBMR0PvNOefAJl0Rd
         tKgqpNpzxro8b6Y2whQcEUp2HJBRBvkSNxr5ALt5qIfh/Ucn0U1jqDJYsBm8LnuWeOm7
         cuzUsCW5z3CtCsr6eTjQ421fv4GNHEEdb5uFzhshuRbMqZ6fyvFCcf0zoG/YvNiwE0VD
         01bNXot8mvYcSf1fYYP+wREzExIA82G1hzjC34LWs/WCGBukalCK+VqTafCFPv59xdnw
         Sf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuGG8uYPFX1jdOmzrDXzkCSSE3UG1kvYrutb1YkBIo161+xnSYgu+6cu4mpQF7SaALNpeVNtj7mQZiNjCiy3BP@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgjpoTaDUKLZilOhc53usVCTcYbCcLS3/3DlBsQX4vKFAHnlS
	wB3ZPb4gbEumBbP8AeFegS0IBhUUyuJZy63fxclG1EWXPrexKZcl3TJ49Dg9tAo=
X-Gm-Gg: ASbGnctHXaAZuQpV2XyOer7j40FeKp8lPBNsuOIefFkMipBdrQ7IFjm0Sp18mrFhqvG
	Xw+JD6ALbNkKho7BKRYWPyD9El3Tk/fiIM4SRgxovzwNAJRx3FNSzY9PnFvwXi+/eunbYkQi7tA
	bY4J+bp1AqixPxIDM/QzZWdllVCfZ9O4/MS8qJsUE65zeswt1HvaEmIJEV91kGmpkF9Sq1+QpcE
	DrluJIGUkDrMqfmqwUDbw4qs+3v9Xjcxg//vdWb/JuU7Zio4Tau1PAvsZnOeg==
X-Google-Smtp-Source: AGHT+IEcals9cWAl+b1w3YqlYSBEmA1VjlSI88V7L5ie0gT9yHjt9N2Z8yNkC7HYy7dX+eZU577mMA==
X-Received: by 2002:a5d:47cb:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-385fd54d75emr4238048f8f.50.1733306415065;
        Wed, 04 Dec 2024 02:00:15 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d97ab259sm16081204f8f.95.2024.12.04.02.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 02:00:14 -0800 (PST)
Message-ID: <c470d6a9-8717-44ad-a713-70cf39ff87df@linaro.org>
Date: Wed, 4 Dec 2024 10:00:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 00/11] perf tools: Sync tools and kernel headers for
 v6.13
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241203035349.1901262-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/12/2024 3:53 am, Namhyung Kim wrote:
> Hello,
> 
> I'll carry these changes on the perf tools tree to update perf tools to
> understand new syscalls and parameters.  You can refer to README file in
> the tools/include/uapi directory why it's needed.
> 
> Thanks,
> Namhyung
> 
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Namhyung Kim (11):
>    tools headers: Sync uapi/drm/drm.h with the kernel sources
>    tools headers: Sync uapi/linux/perf_event.h with the kernel sources
>    tools headers: Sync uapi/linux/kvm.h with the kernel sources
>    tools headers: Sync x86 kvm and cpufeature headers with the kernel
>    tools headers: Sync arm64 kvm header with the kernel sources
>    tools headers: Sync *xattrat syscall changes with the kernel sources
>    tools headers: Sync uapi/asm-generic/mman.h with the kernel sources
>    tools headers: Sync uapi/linux/fcntl.h with the kernel sources
>    tools headers: Sync uapi/linux/mount.h with the kernel sources
>    tools headers: Sync uapi/linux/prctl.h with the kernel sources
>    perf tools: Fix build error on generated/fs_at_flags_array.c
> 
>   tools/arch/arm64/include/uapi/asm/kvm.h       |  6 +++++
>   tools/arch/x86/include/asm/cpufeatures.h      | 11 ++++++--
>   tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
>   tools/include/uapi/asm-generic/mman.h         |  4 +++
>   tools/include/uapi/asm-generic/unistd.h       | 11 +++++++-
>   tools/include/uapi/drm/drm.h                  | 17 ++++++++++++
>   tools/include/uapi/linux/kvm.h                |  8 ++++++
>   tools/include/uapi/linux/perf_event.h         | 11 +++++++-
>   .../arch/mips/entry/syscalls/syscall_n64.tbl  |  4 +++
>   .../arch/powerpc/entry/syscalls/syscall.tbl   |  4 +++
>   .../perf/arch/s390/entry/syscalls/syscall.tbl |  4 +++
>   .../arch/x86/entry/syscalls/syscall_32.tbl    |  4 +++
>   .../arch/x86/entry/syscalls/syscall_64.tbl    |  4 +++
>   tools/perf/trace/beauty/fs_at_flags.sh        |  3 ++-
>   .../trace/beauty/include/uapi/linux/fcntl.h   |  5 +---
>   .../trace/beauty/include/uapi/linux/mount.h   | 14 ++++++++--
>   .../trace/beauty/include/uapi/linux/prctl.h   | 27 ++++++++++++++++++-
>   17 files changed, 126 insertions(+), 12 deletions(-)
> 

