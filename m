Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBC155333
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833965; cv=none; b=HzxGvdSQxKS/U15rMqu9L+BLjcQte0FEJ2nslEMdVLw3EBJEOHsRIr+FRHFDto8c9BnCf9dHhMwk2KU14s+aN9I300eQXwFIVBtckfFSyMXvaxACWSGs/6F1Ub5vLec3hx/z3ibm7/pJshVTXRY6xLXTObEKqf1A7vgPV4po4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833965; c=relaxed/simple;
	bh=mXY3MKwkg0zz91nO2AeCx6Xe/uq0Wn+XITv0U6JeGf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxfKvECeSQAaVVcZssDhgNI0a26qoHKv3ATlcabIbze68/CUXtVLjUbyzi0hnEpkVCi8KEMZXd0GN4J9BtO1x1YTIKQwDL4aiZT1uEgEscyxiMFNtFd850x2P1eBSTPP5u2mvSEsF9h67ppdUlkyd6NFlnAMvFfev1cSuRrKNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGTKrQ/N; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGTKrQ/N"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429babfccd9so494816f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761833961; x=1762438761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjHx7hcf/NGeojUYk7NHqohE/hKvOnIgg1InxPgATyw=;
        b=UGTKrQ/NZlycOMW/AEjMWXiRaQoIDfdx/q52m9+0RRya9o/FsniRoMtG7OwzUK/8d4
         1WHK/yiBoh+cVWbEa08ENEPks0gYnfo09Q4zxx+4/8zynZnrNaA/kGHCNc7UTu9KqxQY
         KH7AHpzPo6Hvn52JIJEnm0K45GMtQu8jXIgOTKbO8sLKg0M4RGE539/rEfgPxeL/Lx0A
         A6Xsy/tUBVIjQ/QVyKs/xmrYLgoGEVWoP1uo81U+41pugxpa6BoONGnMy/5+0zAaPsVR
         ZgDBlX0I294HErd5Dk4cmjkmv7etw8v9l3sYAmK0W9k0k64ZFa3Mp7Fdm1kk3URIJN6v
         KOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833961; x=1762438761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjHx7hcf/NGeojUYk7NHqohE/hKvOnIgg1InxPgATyw=;
        b=Nm1BRwOo5DuxJ9SanEYhDKJ6DPfRJkJHJp8DUnPjKuHMYuJV/Xz7TkJQNpJyMnDnBO
         dgzKg1VkBULik6QlitOBar3m2rBf/i3pu2JrRs5793GidL1X9nb1Lzvm9OF8kiYgDwTC
         dU9U00HxF79oewmSFqazCfYu6kkeM8B+aDQC9vLuFV09kc9ooLC7I7VkISPNwV1rC0ZA
         gO4wGBKL1m0TDMCaTqeAZcIGXAyJxqMXPzmBc1coNjg5kW0UK62HOKzXwRf8LpbAcvu5
         I/2ktwPovY+CF5JBfosNerij7X9UrCnBOtXl5AD+jP49yfeEUklv9ov8uVIS4HGySMr2
         iZkw==
X-Forwarded-Encrypted: i=1; AJvYcCVUSMwTsK4K+TaG1EDHpxdcqNFCRdSLvNuIvpazHCZnRzJhjW8DLHD/dK3PKtLmoDgkxpN/mQU1miomBF2EDhc0@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqMkRsUsChb28vlLVAgGRak9NSpPy7mzvvwlZoU8Roqst33MF
	kh0NrhQmpl6bjhfPkfsGokbJ8Zk1ppP2oCaaFcXdzE0PYqoeyw0Rv8FZVH4QLogz9i0=
X-Gm-Gg: ASbGncu+WGi9L6vcR3nEMyw+HqZPUMmMZkQ9sFof5dljfdC4JjJU+Z5KaNy6G6zS7GA
	2jvpdGeQDsN/V7rbo/yrvhJyv9nv/tOplh7xUpXp54/pwYWQUnBldQVWR6KL8cIzk9cwvGmvhhp
	cSYAkW9lhM5uAs+1zRFgQyr1gsXh5fnFy358+ZLNkTct9lL8OH4W69Pdh0/XW6fI19Fwy8vv82R
	GV+AkYVmDocUPhfzsmB7rQTKeTp3PaL/LUu6a6SIxNop2PFWiH65pV5ohsNfA7TccuHQKYVSzwg
	6DKC/VWMQvD9SLRMoGzw3qJuXNivp6yTKCYCBIxUv4haLcpQZ+bA38SaeloRW42dYAnA9+LGs6j
	ER3AsM+AftB3BpGRAj18HMAAGpX13piNmivRQpllTNAQjnoZVOZJMwAUCBnphuWvQH6br0qPWHo
	OJ/AFTAvOIhpa0EHZs
X-Google-Smtp-Source: AGHT+IE+PK61QbQHoTYD2vtOjdjF1VTdJJcrOI1Gx+DBtoZYSe2yxZpiFpdJE2iGJ5oZbzupNcnREA==
X-Received: by 2002:a05:6000:2584:b0:3ec:6259:5095 with SMTP id ffacd0b85a97d-429b4c72ec5mr2941504f8f.12.1761833960454;
        Thu, 30 Oct 2025 07:19:20 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba445463sm2500116f8f.10.2025.10.30.07.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 07:19:20 -0700 (PDT)
Message-ID: <6b1d742e-ae54-4c24-a4c0-11565729cb90@linaro.org>
Date: Thu, 30 Oct 2025 14:19:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling
 test"
To: Anubhav Shelat <ashelat@redhat.com>,
 Thomas Richter <tmricht@linux.ibm.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251023132406.78359-2-ashelat@redhat.com>
 <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
 <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org>
 <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
 <CA+G8DhKTpZLzRbZvGiS6YZxOXecEcrtOUcNdHOpjDM9Cz0qzxg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8DhKTpZLzRbZvGiS6YZxOXecEcrtOUcNdHOpjDM9Cz0qzxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/10/2025 1:52 pm, Anubhav Shelat wrote:
>> On 10/28/25 12:30, James Clark wrote:
>>> You mentioned on the other thread that it's failing "differently", can you expand on that? I'm wondering why you sent the revert patch then?
> The issue was that for every (leader, sibling) event pair there was an
> 18 cycle difference between the sibling and the leader. Initially I

Isn't that the same throttling bug? A difference in cycle counts.

> thought that this was fixed by the group throttle fixing patch
> (9734e25fbf5a), but I just got a VM running 6.12.0-145.el10.aarch64
> which is up to date with v6.16 and it has that bug.

I'm not really sure what "v6.12 up to date with v6.16" means.

> I want to revert the patch since the bug it exists for has been fixed,

How do you know it's fixed if you are still seeing differences in cycle 
counts? That seems like not fixed to me. (Although I'm not able to 
reproduce it).

> and as you mentioned it could be silencing other bugs. Since I'm able
> to reprouce Thomas's issue on an arm machine it seems like this is not
> a hardware issue inherent to s390x and there's no reason for this
> patch to be in the kernel anymore.
> 
>>> As I mentioned before I'm not seeing any issues. Can you share the kernel version that you tested on and your kernel config? And can you share the same outputs that I asked Thomas for below please.
> For the system experiencing the 18 cycle difference bug:
> Linux ampere-mtsnow-altramax-03-vm-13.lab.eng.rdu2.redhat.com
> 6.12.0-145.el10.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Oct 24 12:39:51 UTC
> 2025 aarch64 GNU/Linux

Right, but this is an old kernel. Does the issue reproduce for you on 
the latest kernel? Can we just ignore old kernels from this point on, I 
think that's what got confusing in the last thread. Let's simplify it 
and say it has to be tested on the latest kernel on bare metal. If it 
has to be in a VM because that's the only place it reproduces then both 
the host and guest have to be the same and latest version. Otherwise 
we're just putting effort into some bug that's already been fixed.

> [root@ampere-mtsnow-altramax-03-vm-13 ~]# perf script | head -30
>              perf   91202 168884.094165:        146 cycles:
> ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094165:        164 cycles:
> ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094188:         74 cycles:
> ffffc6fe45649728 [unknown] ([unknown])
>              perf   91202 168884.094188:         74 cycles:
> ffffc6fe45649728 [unknown] ([unknown])
>              perf   91202 168884.094213:        134 cycles:
> ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094213:        152 cycles:
> ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094233:        136 cycles:
> ffff9e9473cc _dl_start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094233:        154 cycles:
> ffff9e9473cc _dl_start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094252:        293 cycles:
> ffffc6fe45648e18 [unknown] ([unknown])
>              perf   91202 168884.094252:        293 cycles:
> ffffc6fe45648e18 [unknown] ([unknown])
>              perf   91202 168884.094273:        275 cycles:
> ffff9e9473fc _dl_start+0x30 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094273:        293 cycles:
> ffff9e9473fc _dl_start+0x30 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094291:         56 cycles:
> ffffc6fe45648e18 [unknown] ([unknown])
>              perf   91202 168884.094291:         56 cycles:
> ffffc6fe45648e18 [unknown] ([unknown])
>              perf   91202 168884.094312:       1138 cycles:
> ffff9e947400 _dl_start+0x34 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094312:       1156 cycles:
> ffff9e947400 _dl_start+0x34 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094336:        414 cycles:
> ffff9e947454 _dl_start+0x88 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094336:        432 cycles:
> ffff9e947454 _dl_start+0x88 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094355:        692 cycles:
> ffff9e947444 _dl_start+0x78 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094355:        710 cycles:
> ffff9e947444 _dl_start+0x78 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094379:       1328 cycles:
> ffffc6fe45648e18 [unknown] ([unknown])
>              perf   91202 168884.094379:       1328 cycles:
> ffffc6fe45648e18 [unknown] ([unknown])
>              perf   91202 168884.094403:       3871 cycles:
> ffff9e941550 __GI___tunables_init+0xd0
> (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094403:       3889 cycles:
> ffff9e941550 __GI___tunables_init+0xd0
> (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094425:       7787 cycles:
> ffff9e94153c __GI___tunables_init+0xbc
> (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094425:       7805 cycles:
> ffff9e94153c __GI___tunables_init+0xbc
> (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094464:      17320 cycles:
> ffff9e94c794 __set_vma_name+0x54 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094464:      17338 cycles:
> ffff9e94c794 __set_vma_name+0x54 (/usr/lib/ld-linux-aarch64.so.1)
>              perf   91202 168884.094606:      38889 cycles:
> ffffc6fe45649bcc [unknown] ([unknown])
>              perf   91202 168884.094606:      38889 cycles:
> ffffc6fe45649bcc [unknown] ([unknown])
> 
> For the first mismatching sample:
> [root@ampere-mtsnow-altramax-03-vm-13 ~]# perf report -D | grep
> ffff9e94ba40 -A 8
> 168884094165520 0x6a0 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
> 91202/91202: 0xffff9e94ba40 period: 1 addr: 0
> ... sample_read:
> .... group nr 2
> ..... id 000000000000002c, value 0000000000000092, lost 0
> ..... id 0000000000000034, value 00000000000000a4, lost 0
>   ... thread: perf:91202
>   ...... dso: /usr/lib/ld-linux-aarch64.so.1
>   ... thread: perf:91202
>   ...... dso: /usr/lib/ld-linux-aarch64.so.1
> --
> 168884094213520 0x770 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
> 91202/91202: 0xffff9e94ba40 period: 1 addr: 0
> ... sample_read:
> .... group nr 2
> ..... id 000000000000002c, value 0000000000000162, lost 0
> ..... id 0000000000000034, value 0000000000000186, lost 0
>   ... thread: perf:91202
>   ...... dso: /usr/lib/ld-linux-aarch64.so.1
>   ... thread: perf:91202
>   ...... dso: /usr/lib/ld-linux-aarch64.so.1
> 
> For the first matching sample:
> [root@ampere-mtsnow-altramax-03-vm-13 ~]# perf report -D | grep
> ffffc6fe45649728 -A 8
> 168884094188520 0x708 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
> 91202/91202: 0xffffc6fe45649728 period: 1 addr: 0
> ... sample_read:
> .... group nr 2
> ..... id 000000000000002c, value 00000000000000dc, lost 0
> ..... id 0000000000000034, value 00000000000000ee, lost 0
>   ... thread: perf:91202
>   ...... dso: <not found>
>   ... thread: perf:91202
>   ...... dso: <not found>
> 
> 
> I also was able to get a bare metal arm machine with the same kernel
> version: Linux ampere-mtsnow-altra-01.khw.eng.rdu2.dc.redhat.com
> 6.12.0-145.el10.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Oct 24 12:39:51 UTC
> 2025 aarch64 GNU/Linux. On this machine I wasn't able to reproduce any
> issue. I'm trying to get another vm to reproduce Thomas' issue again.
> 
> Anubhav
> 

