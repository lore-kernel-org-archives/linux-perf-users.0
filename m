Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C63F8890
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987371; cv=none; b=OFRgxAHobfevlqseQBK8UQ4gNOEHraNwHOf+gm2fvocMt4BbVFI77yi7CosjeHDMKm0zJ7ekgTk18SRrXC8qavhNhoy4sviX4iTa4KQStYdvL1Mb4xrF4nzJFZurjC8a9cVTc0DqLjWRlc9XJnMQ1DQXV/y+tvLf7wv+n1gz2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987371; c=relaxed/simple;
	bh=dRm6v9rJ98fryRZu+nDZ52gP6ZF+I/symBIWFqheIec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX5lJs/+93ruxY1NIIpV2/jfs8CzjTWvdZbI8nfxAlqtEzi+a2TatPVyuZAz1sDbtwSUdkQazjDCoR9zj5uuyWYD3uPX4pZV+R/O858Jt/ei7KUpw4ZD6ydUPFPISitwcDUo0+BuGXB2xTqudNfc9Bic7ztPSb/GEM98qEwoX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=axxvXFIh; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="axxvXFIh"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d97689903so3848891eaf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779987369; x=1780592169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDGJeqE4tTfg/YKUkoTVnPS7Lm5TeqY7Toc0BSTB4Ms=;
        b=axxvXFIhScPMwL1SYv1SB/8Twa6Qjpy4MHe4/Zy7f+oNlk8eF6vcpwSjMxUCgkdaZk
         H2r4dgPHHu3jnBszJQpKbqLgekX8xr5tOZIcZbJbYQQIZ8ojEJRLFWpfSn02Vdt590Lj
         +JdTIeluvDz8KhKs9IORim7N+sgGXktxRB1C70gXOxClZT7XoGhKqYzsUg9V7gQMK4UQ
         QlnyMKWM+ISgiaifbHgBHXkboi3nHAgNX4VdKx0gQ4c9QFzxb5Lc246wAjsS2DSZdHMs
         J0fMheyMpMNKb9nzBIxJBG9v1ZmNg2RAwLMqUUokGc6eK8QKKzP0eW7ObVslwpDeP5lb
         H+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779987369; x=1780592169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDGJeqE4tTfg/YKUkoTVnPS7Lm5TeqY7Toc0BSTB4Ms=;
        b=LOqxRNGUPmCLxveSz0SSspETe1aqQtJSW0fQr0sXyskhGOodTb3+6nXzAplDo+AJ8P
         Y6SaMCdnsFTHhgKtnrApYQGC9nJ16kyEn0EHRA8ddeWdKDS2toR88ZxtZuLNUvaHQLCb
         EOpVu04vwivX4NyOrZMi0MdswYMNKN+vGUiCAjBRqbOSH7GPb953xcxlBMuC5t4AoUA9
         Q5HiqgYuqXbYI9rm5Vm9wHJoyEqO7myL5K+eAP1JqfDgkrS7iwTjfnxJOmSLExItkkch
         Ds1UOTneWS8bIvPWjVwzND3W/nP81B0+4U6ItIrt76xsxmaTz+qfO6E5rp5Crf4NAkvf
         ZGVw==
X-Forwarded-Encrypted: i=1; AFNElJ/eiUPDK248I+75jeJ2jjVo7GQnglPl4PfpqsurMu812SpuHZ8iyMWaG5RcMV66NF0quvltsxDA+XOKgExGm06c@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXJF+pnDYUdbp/Ru1tPLApVkd4tpQWbFqV4O6W83zTsGu4zO0
	UxmEAPvz+BEv3qdgsECp/dACfVKHuZVWlnPUuIdbGIE9PLAf+FlVIfaICMx9vXMmMN4=
X-Gm-Gg: Acq92OGeMdeRNEMeyBRfgxYgKOpNYHHH4WYy7EWhjy0bBTQRRFmZgx8XfNhhNW9yNcD
	s60gyr4/TDRzR5U4PRXme1F2ipCuj1XaWCGD6KlwxXS/hFBEV4ZABmwOi1Tjl+JXIGMdgwZJleB
	Qa4g7P3beLZ1kY1LM8TZ7duttN2fo+IknueSZJSU5YTpKGKN+I0kgZ5y4Euofe6spaMu3N7Zv1u
	OJgsG4MirA0eTMrv4EJIu+UmC4gdXA1yPMDalfbn2CXPtMxuO8CvfeNrSnqMoFcinhxIdNA0X6G
	Mr5Z+lwALPDBVGQ3FfniZgaMQwXNu763BISZC88x38RBO3iTY1zhF7C44Pq4ubCYwXQh9QpKIQB
	g7goeuHJHVSTjPVVK7WZQXjQEKeTd21ih+EVIUrXSOpheNEWzPvPA3jug1L3Ymkx8C2tJ5oMGSG
	mOJKyzrP+E9OSDQl4peu26cJ2ZFVjAZof/vclEGbM5BkKeMcJkmdMN/VsEyZrN+LEzdR//bYs/+
	I0gtB7UIIK986hDos0=
X-Received: by 2002:a05:6820:4c07:b0:69b:5fcb:1a69 with SMTP id 006d021491bc7-69d7ed105b6mr14873551eaf.59.1779987369074;
        Thu, 28 May 2026 09:56:09 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e010cd4casm152656eaf.7.2026.05.28.09.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 09:56:08 -0700 (PDT)
Message-ID: <2cfd6455-7b5b-4974-b8a1-4a0abca69768@kernel.dk>
Date: Thu, 28 May 2026 10:56:06 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: Remove support for AIO on sockets
To: Christoph Hellwig <hch@infradead.org>
Cc: demiobenour@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Eric Biggers <ebiggers@google.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, linux-api@vger.kernel.org,
 David Howells <dhowells@redhat.com>
References: <20260523-af-alg-harden-v1-0-c76755c3a5c5@gmail.com>
 <20260523-af-alg-harden-v1-1-c76755c3a5c5@gmail.com>
 <ahQCZQNoyO8GQt3H@infradead.org>
 <92db3ff0-8f0b-4b61-a167-5004ffcf9025@kernel.dk>
 <ahanjVfIDlCmeCUE@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ahanjVfIDlCmeCUE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 2:13 AM, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 09:58:27AM -0600, Jens Axboe wrote:
>>> The current TCP zerocopy implementation provides completion notification
>>> through the socket error code, which is freaking weird and doesn't
>>> integrate well with either io_uring or in-kernel callers.
>>
>> We already have that via io_uring
> 
> Where?  And how do make that available to in-kernel users like
> storage protocols and network file system, which really suffer from
> the current MSG_SPLICE_PAGES semantics.

For zero copy, on both the receive and send side. Since we have a proper
notification channel, that's what we use rather than the hack that is
the error queue.

>> , and without needing msg_kiocb or the
> 
> What do you think is the downside of using a kiocb here like for
> everything else with async notifications?

Where would the notifications go? You'd end up inventing something new
to propagate them to userspace then. The io_uring side does not rely on
using msg_kiocb, and iirc that part was only ever used for the crypto
stuff and largely broken. Which is why I do agree with just yanking it
out.

-- 
Jens Axboe
