Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3E3D16E9
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366602; cv=none; b=Gk8EKXJX2wiWEKWnWaAsoGvZUgmfHt4NmNL0HfvaKJ4NfXdHqXqLYxwnJN3OU3twkwtrAQsypHIkrF3hlpa7E1szle6859uF1F6uQR52uFKPnAH2vMcOVxpxrFFkqTIzkfx4xMVQ+GZHV2KxiWqmo6MnplefM2ec0tr7QOFiI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366602; c=relaxed/simple;
	bh=/XPZyDVtW0FyskQoBI95DtRJ8HUoFeRyY9lxEGJfA4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIxtzuoqCh6nUu+BoZo54Jaawm/lgAldNOqw5xGhdZV1PAunDHuzNR9dBYkLPych/TtbKrbTp+KqHTJjhY2nsNs52jIct7KhDYlJQ1trRkRo2l4O4d1qEGupYdIqOAw3cJ02SKtMZ1NydWRTw7Z8K7M619s1lVP+g+voo5EmBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W552ZJ6u; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W552ZJ6u"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7f4f0d37f93so725684a34.2
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789366599; x=1789971399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9l6TcC8yxA6i44GPZCrTXq0qAIOnsPIUcD2ascLJ07c=;
        b=W552ZJ6uST3QspZ1bSUIlGAs22oYWdsHf4HZfGTiEZbR6p3jvfrscNac5wZpvomqeT
         VKBCS2RBpCQTU2NDGnsvT6wDaEQEzAoxjrqg6QywnEgKb7fjQmKNuVYK6tAA/iU15z7I
         xh9MRObLat2gr0O1aUVsb9ausENcR2N6ji6uf1k1j1paSq7dF18BlBF6kXqBXeQ3sBP8
         4lp762pmqKnPIp3+CQqBwTAIHJoEVxFB26b0HL6J04y4dECqmM26NoerTqf8BcLTxLiG
         qFRhjL2crCl0U0P/F5/1DfZGDRVd+lwQtyKhXv7RP+N2OMVzGxiDevCnc44yPZlzM11D
         mdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789366599; x=1789971399;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9l6TcC8yxA6i44GPZCrTXq0qAIOnsPIUcD2ascLJ07c=;
        b=fWtQWNem7j4/GX4sxM4Yr+Q0AyGnnCucn8F6gZvIr6WNovkvqOXhomQCIp4TJGB8Ep
         vNHCPplribaCeZ1stW/j2kOyZxHBurg76SpovZDoFXR10UALKbRTXxwQ3r/g2veLOpqQ
         Jy1vor7U6XxL7dQ7JmBpIY+5LJvwvyxMIoWuKCT2CcJwyzD+VVEHfiN2fI2MJugUISwX
         VEHBzwN27TMgonWiD6A+PsA9pNDGBjYfynVPzZdl/opwfyGxhoMfZ4H58hwyNP6K/nmH
         pWKgT9GMzO4IlvTMtb8goro1dPAoZpplzk8KBr506mq2MuJt4OQExHw5C9QW7EDTxr2M
         JKiw==
X-Forwarded-Encrypted: i=1; AKwUvBwuj5oU/bGXsFI1PZ33j9t+k7fUA7fNsOQbvtiakYx4XX2xY7fmGe+fJ5Ui7I2+wlwjW/R0pi9KxJpyTmwPYjOf@vger.kernel.org
X-Gm-Message-State: AFuF++kT7oaNd3YfcStGmBQgQlMkhOgOnqjweR+B4s11on2EcoB7eDzc
	oz6wQk+SmZzMa6bV3dplNFR+SQEDUhpPETxLjaiyThp/6Yexa3JfL5Hwub01US3W
X-Gm-Gg: AYBFou067r7J7ikLS6ECGOGbE7YMPQyDmsVyvkkDDduJ//kiJieFHbVe+IYDbgvINSV
	ci1nwhhCWZ55WVhIDx7n/Gk/tAH1h9wFV2qSVOKO/IWNuJwYyqFmJUacd6i0gIdJUCmzAw8eBgP
	qruWUM/9BOKCwdUGOnqdUhiBF0kUBpqn3unNyskk+P7842iUIRLHCrbBRK+bTluNGB5qbIIY+gX
	AvJNBR9jiCSNBR9HDD4uyTbSuX63mRlTclS28S5KHikMpk8jzldmztaMjFpd86+WWI6L4fRIq0Y
	jR6iiM3v5skIW1ZfkEx7Vkc5e/kJUfv/COWNCRarQzVSq5zk87xyYv3DysKyUOjEIA3uLbfqrij
	jXQ+OzfAVBgSAGsTA04cyNnbUwsyIfrpfH7yXFSc0i15ctczetH/97cCLka8x5f9oLpcJz21fZr
	bxruCzBsMQQFPP04aMmlxnjhp1uw/Byp/bzkXwDTjbVEqCAhiOmSkcXB1waEFNjRNXlEk/VMpx
X-Received: by 2002:a05:6830:4413:b0:800:a53f:707c with SMTP id 46e09a7af769-80897094151mr638955a34.2.1789366599490;
        Sun, 13 Sep 2026 23:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5ffd82bsm10128992a34.11.2026.09.13.23.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 23:16:38 -0700 (PDT)
Message-ID: <da053ac4-f4ee-4f1f-9bcd-b2f04b13f407@gmail.com>
Date: Mon, 14 Sep 2026 14:16:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/12] tracing: wprobe: x86: Add wprobe for watchpoint
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <307d6fd5-a8fa-4777-b513-9a8cce46f38a@gmail.com>
 <20260912223658.c4495241023f72e3cf48bf0c@kernel.org>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20260912223658.c4495241023f72e3cf48bf0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 9:36 PM, Masami Hiramatsu (Google) wrote:
> On Fri, 11 Sep 2026 15:27:41 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> Hi Masami,
>>
>> I see the watch address update currently goes irq_work -> workqueue ->
>> on_each_cpu().  I would like to discuss that path.
>>
>> The race window wprobe may be used to watch can be very narrow --
>> sometimes it lives entirely inside a single function -- and the trigger
>> does not always run in in_task() context.  The current path defers the
>> update to a work item, so by the time the debug registers are updated the
>> window may already be gone.
>>
>> Now that we have modify_local_hw_breakpoint_addr(), the trigger could arm
>> the local CPU directly and use smp_call_function_single_async() for the
>> remote ones.  That should improve the overlap between the watch and the window.
> 
> Hm, that is a good idea. Maybe we can check the current context and if
> possible call modify_local_hw_breakcpoint_addr() directly for current
> CPU core, and kick irq_work for other cores.
> Does this make sense for you?

Yes, that makes sense.

> 
> Thanks,
> 
>>
>> What do you think?
>>
>> Thanks,
>> Jinchao
> 
> 

