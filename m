Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696796;
	b=NI2x+UFKRR3c19a+wExjPZ8Jyfbh03pBqDjIlZebXBDve/cKYfzjtImYTd1u7NBhFMoS
	 j2EkvJE3K0OGstqFKnAtCgHf+JZ7J9W73HBuogI9ZVe2U6MoVMg/eUh6WUynma5wWywfF
	 neYc5Q75hlSZmFU9y1WAo4yGqcfITlHvwVJZsZXc0ZJjCcBi++Ah/zecvD+wXBZp8ZAil
	 j5ajwMRx3l2VbxpcYfD8fVzeOJTbOopWoXQxm+Q0moZMFeD9Jib5SngGteluGh7uvq9HV
	 prm9kU+Zlus9t0wCiaC7R6RDWat5OIKQDdc3YrFPS2mnTNYnrb2Yy8BUfUonkoShTKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+CjvtlLtZ8LD35jmsrC/DW5uvUUSL1yNq5kGmVgUFAw=;
	b=DCh0SPKxQWbgXjtWoslZK4Sk2fEmHR8p4GNqevXrc1IEp06BUdIyKlsOtHgEtKMRL52d
	 UKDNAZSfsJ26PGAhS5UOZHlrYYIDYK2pzxnw/xXcHgdjDnVvdTHXv7j8LIIDKz3FC0ced
	 aH40LCNsQvLow64sFA031hdRNjzQ6m6NnayjPLckXIBe6UHgU9WgbTE5jAmX639nIAtW4
	 weapB7U3ohfpG2ZrEN8GQUMdajCf+K28oYNjyIY0+ZPph0LjpPhG8b+L56W7XcMDL1etS
	 K7u6P87h+T1H3BbEhtEJ805Ne722gBR6cOSpBXFExS1BrRaRkzh9c6Mr6p7cUOWXeJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zxL6kgvY;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E27606A327
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 12:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15E27606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zxL6kgvY
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so56277945e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 04:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795696794; x=1796301594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CjvtlLtZ8LD35jmsrC/DW5uvUUSL1yNq5kGmVgUFAw=;
        b=zxL6kgvYYeHE1uF2N0d3iaJwovorY8yEoPfTlFMvMzb/+qWZy1Kj60dXHat588BHnQ
         I6qhP05EusskdgnFqAdp1pWWNsId7oYixOYmxXk7j9+q1Eafh5PhuF84ZReDiJFOQnFb
         E007V47UW6KdCfk5h/ihUSmveqvCJiolu7ZsQnoM+R6m4KAa8oSeKXXqxLkaw2nc+YYU
         st/sIDDeAz0CJa+Zw6WCLB/heYg8BO0pr6aFWmgjnITK+Zz+d14+kV0x2vMQeFj2pu1Y
         9q4mr8+vrHI5S63mZqJhWwhKa712yVoexhtQP0Orvis3QMX2eDV9vKlFkQ0mV3cY7Rdx
         IATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696794; x=1796301594;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CjvtlLtZ8LD35jmsrC/DW5uvUUSL1yNq5kGmVgUFAw=;
        b=xxjS7ScH+2XpFUQIp4YE7GK7mq7Z2tDWKhWDvmTiuOZuUoIPdt3EUvZFMQ0DnVmvPP
         4V3oXtQ6zEqNm71bSW3Ya4A/oksVRaFQH+bIsew9nlVsIp6nk6IFiio/+kILoVwfZ4g8
         M2DqlTnJp57zNeS5Apm6OxgZ3l0dUiLzKwIjrl3AlFJ74r1RhgSfID67lav7+SeOo/x1
         /Q5glYbbz1fcTd4ANhp0/qYJ7ZTyPTZ2haAJMs3101PZNR1XqwDyJqzuOCZJZMYoAuUB
         ehGVC58D87N969ECu+JrhavqJedf+GjmoItnqcy3uiUql7fhMXPJ0XHXZTGloM9mLp5h
         73ZA==
X-Forwarded-Encrypted: i=1; AL+hErFVJe4KtH8q019tcyrG81DTLk/5xlSNXWoK1JObrhgtP83oIDdTOP8rTX3Olp9MFo4eKhAFgvQD+xN/zUenSgkp@vger.kernel.org
X-Gm-Message-State: APuU4Z8UH4UNC576EPnQKMQVN5+9WBAHvqTBmwMwsaUDW7wYEKQCeYlX
	3fK6ATo8vdnbNp/KjWLOeXqClGjQ/FEC0vHJG3lTIaUGoM9rzBw60Lzks99H52ZVxE0=
X-Gm-Gg: AZFdTZdAyUPt5Dt4Ri2TVP/nLMOQjUSJv+rHUiu1aL5kWcN79sKEb3ZDrgXvwodP8Oc
	d+4aT4EHDLvCHM2u0/BtkF22CV7X9zeCeRtWRaCBrM7CJLADDuyxDM7ZaeMFRVFp8ehv4sLvwAo
	2WXFNII4eXL/7T1K7w49aZXYMM6wAmg2WzwUJCwkPxWkcKeL6ZfocPi3/tkHcx7vAwqHmfF8kBy
	QEWWkvWTzaeoJQOX+8M7SZBVvq0OPSMkGJfyx0xln9X62UEXIhvpi1gkgF8/2gxF5nLfpmnFk5E
	Mu11lXSok0fVEdCkg9VGACV/90vWfvVBU65NuZ7+qjAA4K2Uv0UCqAHioXplyIic656Okz82FGt
	QMoe7rTx6T7m0w6PLSat0DQ+l9INP8/9IfDAozwRDFDeAlPEOtqmV3wBb8AdnpZAIVGvRm7O0z0
	qX2VDZ9qaeltAZuly3XvnpJbqZnCtDUTFsLvyO+1UUrUIz3TSEuuYo3Te5hJWLZ6e4Q0H1y5z/a
	x/JHiI8A5BqdMyD6rCZjYEbNo6bmZboSAJL7HAt3mXS3nBhIK02IrZu/P8ujoSCJ7NwP6cXgTTv
	Qhq6n4WNT+F2RfXcK32NgsNC3i/4VTCMMg==
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb888267f4mr432189715e9.29.1795696794423;
        Thu, 26 Nov 2026 04:39:54 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm330174705e9.3.2026.11.26.04.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 04:39:53 -0800 (PST)
Message-ID: <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>
Date: Thu, 26 Nov 2026 12:39:52 +0000
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
To: vladimir.murzin@arm.com, Puranjay Mohan <puranjay12@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/09/2026 17:46, Andrii Nakryiko wrote:
> On Wed, Sep 23, 2026 at 2:15 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 22/09/2026 21:40, Andrii Nakryiko wrote:
>>> On Tue, Sep 1, 2026 at 6:45 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>>>>
>>>> Hi James,
>>>>
>>>> Can you review this version of the patchset? It is implementing what
>>>> we discussed in the thread on the last version.
>>>>
>>>
>>> James, do you mind reviewing the patches again, seems like Puranjay
>>> went with the implementation you suggested, would be nice to review
>>> and ack, if it looks good to you.
>>>
>>> Mark, Will, you guys seems to be designated as maintainers for
>>> drivers/perf/arm_brbe.c, can you please take a look and give your
>>> feedback as well? This is important and useful feature for newer arm64
>>> CPUs, it would be great to get access to this functionality that we
>>> had on x86-64 side for a long while now. Please help get this upstream
>>> or, if it's not in the right shape, guide Puranjay towards a better
>>> implementation. Thank you!
>>>
>>
>> LGTM, and the Sashiko review is good too. It does conflict with the
>> FEAT_NMI patches on the list, and you'd have to disable NMIs but as it
>> stands right now it's ok.
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
> 
> Thank you, James! Mark, Will, do you have any suggestions on correct
> sequencing of things and how we should proceed? Thanks!
>>
>>

+ Vladimir

Hi Mark, Will, Vladimir,

Any thoughts on this approach where NMIs need to be disabled? 
Alternatively we could do something like track where the PMU interrupts 
and BPF snapshots overlap and then discard the BRBE buffer and make sure 
they don't trample on each other etc, but it looks like it would be 
significantly more complicated.

Thanks
James

