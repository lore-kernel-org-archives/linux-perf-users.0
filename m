Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1256343D84
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625999; cv=none; b=sQvDPgDVUKenCii/023Klpt8YRQBlcBAOSYeGQjtiqV7XVnFw01gNM5B6GyUN/tzwEgdwQFW6BPiuZ9ppQmgaSmNsztjUZ9aVVOjYEjASdR8+GD487RPWxuQRpZfgT8CNR3p0tQUcwAVcdTtyIJU6JE2VQjTq13LPCNecU7LV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625999; c=relaxed/simple;
	bh=+Tn+FAVQ2wgktIzhFoSTC1Hyrva+n1/WR5IkDowBG78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEVkwZG0jPqrWP0xdJHl5DoLmJ3oVi2jARlnQpElXSCG10vJTivOGeHLmSlFt9lKLX2fHP4H5JuC+tKyQ+xovSCgZYxmSpzDamCl1TYWIg0zLo4zBC9qaWVNAbcDCD+9xUqmoznRmI40w2vSrORjXXIEiPhH99IGt9MjuiFbOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMNvNRgw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMNvNRgw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso6673715e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760625995; x=1761230795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWKLuyIwlI1mf3x9/MtMhymIvi1qQGAAK5gHS9GN9Rs=;
        b=qMNvNRgwTOIVI0q+SSSbxxsUF6RCX/+ZGJJZGzWh9qeGDoh2Q0EonDSm/eJZ2Axb/p
         D9P+AKUy/w54YR8i9izy3t4Yi9KAaK+W+8Rf0aY409VXREfLb9rpExQKgTSn+CK7Q8Im
         lI++J2Z4Rm9Edv66FjAHzZK4zi+Yl0+N4xXjD90PvGFoUddOD3hk2Vz09LmmscCRx2d7
         +COpUad1taWVmE8/2QhHaD1cdflbfVpv6++Nhcp63Jla6r2j6xdsGPZAqirY9KdqUbcn
         bAE+EfkesvVN+eCEP9PZmC0NvLfc8u8CbOYPNo9LAhY9pNHHsacJWhcBWLXCBFe/KJXX
         v+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625995; x=1761230795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWKLuyIwlI1mf3x9/MtMhymIvi1qQGAAK5gHS9GN9Rs=;
        b=Gj0lWE/goRq/0c8U7F2lbUSYOEkkOOF8YtHIqY7+9NDVNvVMSyO6B50EVAFyKKaB11
         1Q3SbLIFB7I79pqAZBwd1lS3HXM5Ek7i0KeITc5HyZBakIGus5YffStaAKObp315wi9Y
         xspaHdpv96NSURT5fu7k9BognJrt+UWot2ZIL3YBQifYVddVJhMPGKVFlPLEbfb6E/P3
         7pSvfYYr0DezOJVgCiag8Q/XsIX+mFztKVtQJr0S1B/hzd38/AeLMzuwY5YZZ1C4Ty2i
         mDEJk+o1Is0RwWUU2ISTnRqN1Cm9wpIYUySiIQRjmtBKrkiyZVUKLj6dVbP8TKT/+cA+
         5xNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvCU9O7qOt2N4cx7bcD2cq5uurlhdhtXzYNJ/wUx/suJsALL73L6IxIJFjnKhTLrZeE1w1pxm4U3fUR4Axebbd@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDhFitCE05cfPO9Ft8PRhNPDdRC3GBnojEH54IQRRZ3KXNuie
	ke2v9VllH7+G8GJgdMNg/Kfn1Kt94g29Qh2fIDk7FYL3imLINbGEFCmu9UBIgQ9d0M4=
X-Gm-Gg: ASbGnctbPAPGzWztaK0xTxSoeng1MwogvO0JMqTl13kOPfNSO3UscDrEWyZeTI/NmI4
	zWXjcChXZwCcrck1l6glC9s/mnssc/UCuIGR6yXIy47U3AWFVl8Hxknmm3A2/n8LEeGBSQGXv3k
	fFbd8J4p2Yu1VPMuzYAxZ3V0/dE1RgORyg7UwJ0nzx+ccXjVGWi4ODcONfogNlwwaCW8Qx4BS+9
	xy0/1S+5b34BkUcVSHr32LXoJZFVtg/F1n397Cazeg2Aq41emSMwz5TgJz3imcJ3AOXi8YK8srS
	yMvyViIW9PVe/DlKVMUwxO7b1xnOz1ggCFN1NLRuhO/YtW255sS6R3j3W3SiwjVqaTiKGc9yfrL
	kyxBOZ+GC/zKErZmwmHu/kaq02Lu8C6D7uZmFrGwZXidkx2Zd0H4uQdalWgMtiWDgEDXcejSu+R
	znhBU4+A==
X-Google-Smtp-Source: AGHT+IGp/lPd6/612B/ae0TH8kETwbG1cxXXSNyBdocZk3X0cGyMEoXpP8zJdRyP9AmQn5JQM8zM0A==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4711791c88bmr1995305e9.29.1760625995120;
        Thu, 16 Oct 2025 07:46:35 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm34622085f8f.14.2025.10.16.07.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 07:46:34 -0700 (PDT)
Message-ID: <abc1cb61-8169-4a26-9daf-264a6d94cc84@linaro.org>
Date: Thu, 16 Oct 2025 15:46:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 mpetlan@redhat.com, irogers@google.com, linux-perf-users@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
 <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org> <aO0ci1wX-J3au0-p@x1>
 <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org>
 <CA+G8DhJnRB=d+pv0k=uzM18EmhFiQ+AiVu3rb8w=anNgJ=dr2g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8DhJnRB=d+pv0k=uzM18EmhFiQ+AiVu3rb8w=anNgJ=dr2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 3:42 pm, Anubhav Shelat wrote:
> Sorry for the late reply.
> 
> On Tue, Oct 14, 2025 at 9:29 AM James Clark <james.clark@linaro.org> wrote:
>>
>> But now that I've seen the older kernel version, I think the issue is
>> that the throttling fix isn't present and the specific hardware isn't
>> important. If Anubhav confirms a newer kernel fixes it we should look
>> into possibly removing the tolerance from the test and start looking for
>> exact matches.
> 
> I tested again on 6.12.0-124.7.1.el10_1.aarch64 KVM with hardware
> Ampere Mt Snow Altramax. I'm getting the same error that I was
> initially getting (28 cycle difference between leader and slave

But the throttling fix was in 6.16, so I wouldn't expect it to work in 6.12.

> event), although now the difference is 18 cycles. So I don't think
> this is just an issue with older kernels:
> [root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf record -e
> "{cycles,cycles}:Su" ./perf test -w brstack
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.021 MB perf.data (266 samples) ]
> [root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf script -i
> perf.data | grep brstack
>              perf   96507 163361.511570:     434471 cycles:
> 53d4e8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
>              perf   96507 163361.511570:     434489 cycles:
> 53d4e8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
>              perf   96507 163361.511733:     422961 cycles:
> 53d424 brstack_bar+0x24 (/root/linux/tools/perf/perf)
>              perf   96507 163361.511733:     422979 cycles:
> 53d424 brstack_bar+0x24 (/root/linux/tools/perf/perf)
>              perf   96507 163361.511887:     402299 cycles:
> 53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
>              perf   96507 163361.511887:     402317 cycles:
> 53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
>              perf   96507 163361.512048:     429218 cycles:
> 53d4b0 brstack_bench+0xc (/root/linux/tools/perf/perf)
>              perf   96507 163361.512048:     429236 cycles:
> 53d4b0 brstack_bench+0xc (/root/linux/tools/perf/perf)
>              perf   96507 163361.512221:     462615 cycles:
> 53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf   96507 163361.512221:     462633 cycles:
> 53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf   96507 163361.512448:     494407 cycles:
> 53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf   96507 163361.512448:     494425 cycles:
> 53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf   96507 163361.512638:     512031 cycles:
> 53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
>              perf   96507 163361.512638:     512049 cycles:
> 53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
>              perf   96507 163361.512830:     518522 cycles:
> 53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
>              perf   96507 163361.512830:     518540 cycles:
> 53d4fc brstack_bench+0x58 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513028:     538824 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513028:     538842 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513232:     559322 cycles:
> 53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513232:     559340 cycles:
> 53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513456:     577880 cycles:
> 53d4a8 brstack_bench+0x4 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513456:     577898 cycles:
> 53d4a8 brstack_bench+0x4 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513674:     593892 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513674:     593910 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513894:     602458 cycles:
> 53d498 brstack_foo+0x48 (/root/linux/tools/perf/perf)
>              perf   96507 163361.513894:     602476 cycles:
> 53d498 brstack_foo+0x48 (/root/linux/tools/perf/perf)
>              perf   96507 163361.514116:     613613 cycles:
> 53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf   96507 163361.514116:     613631 cycles:
> 53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf   96507 163361.514345:     624328 cycles:
> 53d44c brstack_bar+0x4c (/root/linux/tools/perf/perf)
>              perf   96507 163361.514345:     624346 cycles:
> 53d44c brstack_bar+0x4c (/root/linux/tools/perf/perf)
>              perf   96507 163361.514576:     633823 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.514576:     633841 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.514810:     641207 cycles:
> 53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf   96507 163361.514810:     641225 cycles:
> 53d430 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf   96507 163361.515046:     647897 cycles:
> 53d45c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf   96507 163361.515046:     647915 cycles:
> 53d45c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf   96507 163361.515282:     653546 cycles:
> 53d438 brstack_bar+0x38 (/root/linux/tools/perf/perf)
>              perf   96507 163361.515282:     653564 cycles:
> 53d438 brstack_bar+0x38 (/root/linux/tools/perf/perf)
>              perf   96507 163361.515525:     658367 cycles:
> 53d434 brstack_bar+0x34 (/root/linux/tools/perf/perf)
>              perf   96507 163361.515525:     658385 cycles:
> 53d434 brstack_bar+0x34 (/root/linux/tools/perf/perf)
>              perf   96507 163361.515767:     663233 cycles:
> 53d46c brstack_foo+0x1c (/root/linux/tools/perf/perf)
>              perf   96507 163361.515767:     663251 cycles:
> 53d46c brstack_foo+0x1c (/root/linux/tools/perf/perf)
>              perf   96507 163361.516009:     665425 cycles:
> 53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516009:     665443 cycles:
> 53d444 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516251:     668471 cycles:
> 53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516251:     668489 cycles:
> 53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516493:     671104 cycles:
> 53d404 brstack_bar+0x4 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516493:     671122 cycles:
> 53d404 brstack_bar+0x4 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516736:     673910 cycles:
> 53d4dc brstack_bench+0x38 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516736:     673928 cycles:
> 53d4dc brstack_bench+0x38 (/root/linux/tools/perf/perf)
>              perf   96507 163361.516980:     676712 cycles:
> 53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
>              perf   96507 163361.516980:     676730 cycles:
> 53d540 brstack_bench+0x9c (/root/linux/tools/perf/perf)
>              perf   96507 163361.517225:     678976 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.517225:     678994 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.517472:     681095 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.517472:     681113 cycles:
> 53d51c brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf   96507 163361.517719:     682992 cycles:
> 53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf   96507 163361.517719:     683010 cycles:
> 53d520 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf   96507 163361.517966:     683967 cycles:
> 53d5bc brstack+0x60 (/root/linux/tools/perf/perf)
>              perf   96507 163361.517966:     683985 cycles:
> 53d5bc brstack+0x60 (/root/linux/tools/perf/perf)
>              perf   96507 163361.518213:     685021 cycles:
> 53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
>              perf   96507 163361.518213:     685039 cycles:
> 53d410 brstack_bar+0x10 (/root/linux/tools/perf/perf)
> 
> If another sibling event is added then the two sibling events will
> have the same number of cycles.
> [root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf record -e
> "{cycles,cycles,cycles}:Su" ./perf test -w brstack
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.024 MB perf.data (390 samples) ]
> [root@ampere-mtsnow-altramax-02-vm-10 perf]# ./perf script | grep brstack
>              perf  104580 166706.554289:     448152 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554289:     448170 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554289:     448170 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554461:     435718 cycles:
> 537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf  104580 166706.554461:     435736 cycles:
> 537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf  104580 166706.554461:     435736 cycles:
> 537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf  104580 166706.554626:     427053 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554626:     427071 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554626:     427071 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554798:     451335 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554798:     451353 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554798:     451353 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554980:     480005 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554980:     480023 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.554980:     480023 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555171:     507300 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555171:     507318 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555171:     507318 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555371:     531265 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555371:     531283 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555371:     531283 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555577:     551570 cycles:
> 537fc8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555577:     551588 cycles:
> 537fc8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555577:     551588 cycles:
> 537fc8 brstack_bench+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555788:     568657 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555788:     568675 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.555788:     568675 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556004:     584038 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556004:     584056 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556004:     584056 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556223:     597582 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556223:     597600 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556223:     597600 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556451:     609457 cycles:
> 538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf  104580 166706.556451:     609475 cycles:
> 538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf  104580 166706.556451:     609475 cycles:
> 538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf  104580 166706.556679:     619984 cycles:
> 537f04 brstack_bar+0x24 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556679:     620002 cycles:
> 537f04 brstack_bar+0x24 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556679:     620002 cycles:
> 537f04 brstack_bar+0x24 (/root/linux/tools/perf/perf)
>              perf  104580 166706.556910:     627492 cycles:
> 537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf  104580 166706.556910:     627510 cycles:
> 537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf  104580 166706.556910:     627510 cycles:
> 537f3c brstack_foo+0xc (/root/linux/tools/perf/perf)
>              perf  104580 166706.557143:     634910 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557143:     634928 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557143:     634928 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557378:     641501 cycles:
> 538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf  104580 166706.557378:     641519 cycles:
> 538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf  104580 166706.557378:     641519 cycles:
> 538000 brstack_bench+0x7c (/root/linux/tools/perf/perf)
>              perf  104580 166706.557620:     647392 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557620:     647410 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557620:     647410 cycles:
> 537ef8 brstack_bar+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557863:     652652 cycles:
> 5380a4 brstack+0x68 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557863:     652670 cycles:
> 5380a4 brstack+0x68 (/root/linux/tools/perf/perf)
>              perf  104580 166706.557863:     652670 cycles:
> 5380a4 brstack+0x68 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558103:     655312 cycles:
> 537f14 brstack_bar+0x34 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558103:     655330 cycles:
> 537f14 brstack_bar+0x34 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558103:     655330 cycles:
> 537f14 brstack_bar+0x34 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558344:     657722 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558344:     657740 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558344:     657740 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558585:     660962 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558585:     660980 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558585:     660980 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558831:     664313 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558831:     664331 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.558831:     664331 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559075:     667265 cycles:
> 537f54 brstack_foo+0x24 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559075:     667283 cycles:
> 537f54 brstack_foo+0x24 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559075:     667283 cycles:
> 537f54 brstack_foo+0x24 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559321:     668769 cycles:
> 537f60 brstack_foo+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559321:     668787 cycles:
> 537f60 brstack_foo+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559321:     668787 cycles:
> 537f60 brstack_foo+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559566:     670697 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559566:     670715 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559566:     670715 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559811:     672257 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559811:     672275 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.559811:     672275 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560059:     673958 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560059:     673976 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560059:     673976 cycles:
> 537f24 brstack_bar+0x44 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560306:     675608 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560306:     675626 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560306:     675626 cycles:
> 537f10 brstack_bar+0x30 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560554:     676111 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560554:     676129 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560554:     676129 cycles:
> 537ffc brstack_bench+0x78 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560812:     677092 cycles:
> 537f9c brstack_bench+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560812:     677110 cycles:
> 537f9c brstack_bench+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.560812:     677110 cycles:
> 537f9c brstack_bench+0x18 (/root/linux/tools/perf/perf)
>              perf  104580 166706.561108:     677768 cycles:
> 537f68 brstack_foo+0x38 (/root/linux/tools/perf/perf)
>              perf  104580 166706.561108:     677786 cycles:
> 537f68 brstack_foo+0x38 (/root/linux/tools/perf/perf)
>              perf  104580 166706.561108:     677786 cycles:
> 537f68 brstack_foo+0x38 (/root/linux/tools/perf/perf)
> 
> I'm thinking the problem might be in drivers/perf/arm_pmuv3.c with how
> the pmus are enabled. x86 has a function that enables all pmus at once
> (arch/x86/events/core.c: x86_pmu_enable_all) so maybe arm needs
> something similar.

But I don't see the issue on the latest kernel, so I'm not sure a change 
needs to be made.

> 
> Anubhav
> 

