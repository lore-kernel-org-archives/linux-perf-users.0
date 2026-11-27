Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776992;
	b=htPNpvyDxaXIV+dtvOGhZ/3iqNJx0MHgbaLuuuW6OQKa17NBMsxfzBkyuHtYW07egGm4
	 8ntGedooZq3ZXa81Nhxu7euFxkkhcgQJ4Udk5Ud2XMSeStplmOGscPE0MDq6snb7A7IkF
	 xNyapejGKYMeEg5NZmio76zPn8Y2qfrLGz6/GVw84d0T1QUj20j9gyzlhSz9AtsWozE1p
	 euYWPoWgpEI8cVoQbFpix707cKvIt2rowEzCIzBlYq17QtIn+u3Rz1vW33YDFkJE7J4m7
	 04c8734iC+MVpIZ9Ww4WCqz+h8MMsoOmOKUfjHXgTs8ylBcPLnwflEmxV3RwxwijM7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1P9jh/3dNVPHo3/JRb6QOjFyR52ByPWaY+Xbs/2Psnw=;
	b=RsQ5E+v2KrfXKKtqcFcfp33ch91TkfqW90/yUwq0cBeQ0Mt3aBLrB/H/fNDqnm8F9WZn
	 /CGJ+kYS3CYFR93rrKtRzjZoktAPQg2OSe4cTxzRc3ck347EzYmup/P+4GtOcx8vfBwPf
	 ENdf76JbVa4VXu02HJ/xSbUynwxjjVrI4lJe9S6BgyJ2ZCj7VM3/XfhK4SZV2n2ZOHaKv
	 ihinDGqyWZqvp51iCyPXAQlRjTbSxfrTlTZJMoV1QAQS2+pEsSCdGIBMUst98gzqx0EoX
	 Mll1NSRLEF6emnzwApPTTm7v+Bz34WxL1nXPI6Hd7KNO6X0+NbfrUgh2Qu0iP8h0Z4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dyb5RJbM;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E131606A69B
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 10:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E131606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dyb5RJbM
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so51905665e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795776990; x=1796381790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1P9jh/3dNVPHo3/JRb6QOjFyR52ByPWaY+Xbs/2Psnw=;
        b=dyb5RJbMSTNIthJgsi/N2ySzW1R3mcY+ZvZe6M9AuUMbmlx2TUCqkrG2xu3erNO2t+
         Qoj9vIYm2Fdngl22sNhHrSlriisnh2LFEUQqXdYF6mSfhVxPdTknYvcBiynXMFaSR+wG
         WnCOHJTLxU8GWrIjotHjCKr0AWZuFkiFCDMF98GVoeoJyg2WPjK6644T4whLKPa3QPV0
         VFP1nA5/mud1GwPgrX7H1aMp2ftpoQlR1vr3Jj0gbxdP2IX1nO5tLsBKPIcxsGi98L8N
         WBKsN0ILSfkYkl0WsTMR2/rxCZqw4WtQ988KHlu8QZXS6aLMpHItXNprbyyTSPNXrAp4
         6tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776990; x=1796381790;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1P9jh/3dNVPHo3/JRb6QOjFyR52ByPWaY+Xbs/2Psnw=;
        b=YecPGv9iTQXSu72ujtKolToOQteAMW3ZpllfqKw8F6AJ1gEibPv3YE+4XY2x3MkDam
         fv5mEr8Ug8ZSSJxnUmK7jafqbQpGxShzyNSNDrAWhZIp/2ljQ77aIJQlXGn8lh5vZJMc
         3qXlM6uWAZ2+ZxImHy0DKiwwtEVo20LhFTvOMIcnlQiShgf24CaMeSdEkxLXSGUhLesH
         mi/E9f0UrWRy+ncYZFUyH25eEV4HQya9qxiKNgOc/+v6yn6jTSNEcwq5p1xnQ8O1u7B3
         sFg6eLCZJBXftB+VRjb3NW4qPu52AyZrkSFWjFo/wHxnCZh0Z8DsEJ7z23hTJEAiY2aB
         b2gg==
X-Forwarded-Encrypted: i=1; AL+hErEyYxisyzO5GQiOEOkVW17xXbDR3U4JbtSFPoJ+HBmGLxN9vIBmKSwCLMAq16Z2nzjr1HbJPOYhIOGqonJ9uqGT@vger.kernel.org
X-Gm-Message-State: APuU4Z/KSeewlqSh/V8dWpKcOF9GNqCtD71S8dZh7wA43xTChZDBDMRP
	3oWnsSfjeM7yt6pPp7Xz8vlGddQoYqGRuXLIpBG94kguF3nOqVVPdqDziFHkRBNw9Xs=
X-Gm-Gg: AZFdTZei9L2D1lnNcQ1wF/aY+PFK4P1EBzGjNnAC2kmJU3+9fKmhgc4X1yrIs5M3Wpf
	BJmz8Szh/ZRzsYFsThN5PJkgPrKr4/T2G4lfaIJstjRL+MNWI/F7jjqigi6F0V9pWZjihID7UM0
	CCP3YDtE3HMMaK5bMbwH/oTfBO+W3GJ/6VaqnDGW3ikF77C6X2WtcIy+/c0d2N9d1tmRIJ2r63f
	N1zgEL3VH8n8l5ElYDtT3Nw1Mb9tnJ4UFz9bJtZmpE4goHuOzDkto+NKFqNJ5Pam1wElNRR6Zu3
	KjGx+YbVrJLklXs+5VCtsDKDj8AUIW9Fj3sf2Efs8d9KrL1phl+9GIVO25V1MdT0FWcAs10n5n4
	FsKjhP975k61cTkZUsNd3k54DptyN8FQyDV80jESqZ/ybiRj00oiptL68XxbwEphO2dB6VWNS32
	n+3FnC20tR3Jb6rOV8e3JTu7/AUWj1yz8MdmZrUA7Bat8plW74BYO+QgpQO085NoERk/As+52DU
	K6MOxuSS7GEt/8kNtmsyLlLIApF58W5uxv4L6QJ4vtF++9ymLjKePWbBkMKX+MJ97W2OOOkEp54
	hZydYYorZAP1NoSOdsvQkUxHKB6bk/eD9A==
X-Received: by 2002:a05:600c:6744:b0:4bb:afae:150d with SMTP id 5b1f17b1804b1-4bbafae24acmr75249945e9.33.1795776990010;
        Fri, 27 Nov 2026 02:56:30 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm408746585e9.1.2026.11.27.02.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 02:56:29 -0800 (PST)
Message-ID: <9a471409-04c2-4f6e-aec9-0b23bb9b69f0@linaro.org>
Date: Fri, 27 Nov 2026 10:56:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Leo Yan <leo.yan@arm.com>, Puranjay Mohan <puranjay12@gmail.com>
Cc: vladimir.murzin@arm.com, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif
 <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
 <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
 <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
 <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>
 <20261126180214.GB809232@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261126180214.GB809232@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/11/2026 18:02, Leo Yan wrote:
> On Thu, Nov 26, 2026 at 12:39:52PM +0000, James Clark wrote:
> 
> [...]
> 
>>>>> Mark, Will, you guys seems to be designated as maintainers for
>>>>> drivers/perf/arm_brbe.c, can you please take a look and give your
>>>>> feedback as well? This is important and useful feature for newer arm64
>>>>> CPUs, it would be great to get access to this functionality that we
>>>>> had on x86-64 side for a long while now. Please help get this upstream
>>>>> or, if it's not in the right shape, guide Puranjay towards a better
>>>>> implementation. Thank you!
> 
> ...
> 
>> + Vladimir
>>
>> Hi Mark, Will, Vladimir,
>>
>> Any thoughts on this approach where NMIs need to be disabled? Alternatively
>> we could do something like track where the PMU interrupts and BPF snapshots
>> overlap and then discard the BRBE buffer and make sure they don't trample on
>> each other etc, but it looks like it would be significantly more
>> complicated.
> 
> Could we restrict bpf_get_branch_snapshot() on arm64 to a free-running
> BRBE mode? On a given CPU, at least one active event would have to
> request a branch stack, and every such event would have to be a
> counting event.
> 
> This seems to fit in this series. The selftest opens a CPU-cycles event
> with PERF_SAMPLE_BRANCH_STACK and sample_period = 0, then takes the
> snapshot from an fexit program.
> 
> Counting events can still generate overflow interrupts for bookkeeping.
> It requires to refactor the PMU driver to leave BRBCR_ELx.FZP clear so
> an overflow doesn't freeze BRBE. The interrupt handler could service the
> counters without touching BRBE and losing the branch records.
> 
> Thanks,
> Leo

Yeah I think this is a pretty good idea. It looks like it would avoid 
having to disable NMIs. You only need a local_irq_save() to avoid new 
events from reconfiguring BRBE while taking a snapshot, and you don't 
have to disable the PMU counters either.

If any sampling BRBE event gets scheduled then the snapshots just start 
skipping and returning empty.
