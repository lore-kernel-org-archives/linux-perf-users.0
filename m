Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE382264A8
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588366; cv=none; b=CQ8wKv/rwYr0c5T4IoKxWh+gR+CgxAcK+2AVzhib9BBdBC/Mwo4SwNu1ApZZ/8MwjaDIFr1f6+IsrgwrJonJ9vmknmQICzSs4G8ezW6uH8G5TpvHJ/aXcHAVRZq/BT7FnxAfYIxh5SJNXr/3QT/l6YONLztuq65r7hVd+i0KAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588366; c=relaxed/simple;
	bh=I3RR4mkzvl3vrE7xdB+EXcNPHaVK9jeMfWJtpB2Cb/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCrA2RwcjEsdSeb+W/wIgfu/XeSPPagJlolXXPv3Qi5THdJ1d77Ntoni4vodfq9ncC6+L9g9uQfYgwWEDfSdK+XhTnneMiA8LWc9qQvo5adAQl4av2HOwK1rXXxZ3fcA3cwRcjh1rR4sNdttki9blXPs0yqVIK8cnxpeG39kSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YektZVu0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YektZVu0"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so2307992a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 00:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769588364; x=1770193164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syby8oeFyZiDA53Kg1ApA4RRxVSYxXfIUH/FGHxf7A4=;
        b=YektZVu06aPh2N57E9Reg7Bg5oXylj8Cs/Ww/9s/CT+T6rVCNDqF43ogxGpcIAzcsD
         UhTb7+HLeLnZ08xeyCEIZoukDhPhkpoEhT3bgfR8nqGRGPaHzI9ryqQ6Y09OyXEC+TgU
         +FWz5K/tA5lmQqSoJ7vjKmFzeWViN2rhQjPwfPSFDi1h353cOYQg8ZF82rBh6X6hW9LA
         xWkiAmKgflCRHG8dCinaF3nYtJiAZrVMqZhClbhFPgWW+XzYQ51sBrxQsZ9lH2UaRTnG
         naowKAMfrFkUnAo5UmI1+nTPCeTSmkTmznzXHlfg0FwqNnu62+h53G627UDTKXsn1d83
         KaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769588364; x=1770193164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syby8oeFyZiDA53Kg1ApA4RRxVSYxXfIUH/FGHxf7A4=;
        b=NArlLhJxViSSxblQpCtycbyycQ8DcpYwM/AQsMRL/ttFk9NI1OLojC8uw3ptjnzDG0
         +id6tzckigP3do36QtDRT+HK8HvTG04Fw3nbWTcpgTCph2y7AvoOWi/g77NlJf/3boAZ
         RZq1DRGlQweWgEuEOsdvNMNQgcWLzziI/ddY+gSD4f9htuZeEvvxBdA3aCPGFF8aDu5r
         2G5SKqLYRAweOA2GV2DI12pMnsYw6DsDG3D+vmZW8wjkGYTkEobqgKSjKSlSuqKvq7v0
         mUO+c+5uX45VwwxyaxFbs7ZsEhoIhYhBj6D6lhZkOdEfd+DcxcvQlAfgqMpoFpaK9f7e
         GKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjCvpzT7EPzhhfq+NSlK2f+tr9uv/Wn0vJG14XHQkWvIDU9+0hhOO4+ANP7O4vbZxaLP1f/Uz+La08Wx5dZGLq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pZZWxnD0xFbKBT/JVL8q9XEtGF5rV0k5fhiLE9tlSgqul/mE
	cf+zPHTTpzzjC1UhxPNwkVrUyFnmBup3oG/mAs4pLQR0ZwcdHPAqrp7N
X-Gm-Gg: AZuq6aI3ZNuTaCaVVg1g71J66NUD/E43s2DbcBdfFbjm6jmPCuti6+KR7XD3nCKZrtx
	hpSp9o968l0tGT51UCW9YtLvVLtHGCg5431TmG8S3Z8QUBoMuBf9x5agnmZiCuHCJuF4Oz58Cbc
	wiVDItV0OGBZZrkDOdprHkLcylVxtgVFLVtwO0X8J9ISG7EQ4CCx5pY1dstokvzl6MNGwW2EwW1
	FjN1qUPe+o86uGqFm2IPk7nP4OQMsD6u6qvnQH6WdhS1w9SBv84diDfBhN2lghZ8C05XeQJ4Le0
	MTrgKsDG/v704g7gMcZQoS9B4tjduK+Bg4eFajmV474B0H30n5Ub+PSRSGjo0CGblyg6sfvv28u
	n1wkEcOhmdaY51OKTffmAyA4hMlPEVCGQkmdLjT08r8tl0bO6WZvC7Ykb84eIO+tOTzCMY1bDcz
	qP60KfgC3r7vPiuiWpw1U=
X-Received: by 2002:a17:90a:e183:b0:34c:37b8:db34 with SMTP id 98e67ed59e1d1-353fedb153fmr3633477a91.32.1769588363583;
        Wed, 28 Jan 2026 00:19:23 -0800 (PST)
Received: from [0.0.0.0] ([188.253.4.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm1664437a91.0.2026.01.28.00.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:19:23 -0800 (PST)
Message-ID: <874829ba-00b9-49cd-8f67-a4c33a8f409f@gmail.com>
Date: Wed, 28 Jan 2026 16:19:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in
 get_callchain_entry()
To: Qing Wang <wangqing7171@gmail.com>, andrii.nakryiko@gmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, irogers@google.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org, peterz@infradead.org, radoslaw.zielonek@gmail.com,
 syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
References: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
 <20260128062656.1860201-1-wangqing7171@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20260128062656.1860201-1-wangqing7171@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/1/28 14:26, Qing Wang 写道:
> On Fri, 19 Jul 2024 at 01:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>> Which is what I'm doing in [0]. Radoslaw, can you please help
>> validating if those changes are enough to fix this issue or we need to
>> do some more?
>>
>>    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240709204245.3=
>> 847811-10-andrii@kernel.org/
>>
>>>
>>>> ---
>>>>   kernel/events/callchain.c | 11 +++++++++--
>>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
> 
> Hi,
> 
> I found this issue still exists after your patch in upstream and I have a
> patch to fix it.
> 
> Patch here: https://lore.kernel.org/all/20260128061753.1857803-1-wangqing7171@gmail.com/T/
> 
> Looking forward to your review.
> 
> --
> Best regards,
> Qing
> 

Hi Qing,

I have a change that will remove RCU. As Andrii pointed out, using 
get_callchain_entry without RCU lock in BPF appears to be safe for now. 
Please point out if I've missed anything.

https://lore.kernel.org/bpf/fb745675-e25c-4dcc-be4b-4a4411056755@linux.dev/T/#mc0fc5e0fec2e6456f72f402308fd4e397ba19d09

-- 
Best Regards
Tao Chen
