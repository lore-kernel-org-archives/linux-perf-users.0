Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0027470
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445092; cv=none; b=OKvq38upIMXgH4fsdlVpC6CGyqKAoSjDQvwrjhKWmbz6BSsktcm6DEsxxrEQ1b7qtjDIsLf4Ad/txwngyKunnBydTPCkavN3SLyW4iPoTTGFUUPqNuk/Al+GOmXBP8FbED1vZPVm484v7nK7LgcYChhE0DpseGfT45OQ/A9YXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445092; c=relaxed/simple;
	bh=oCY9bXdD+ZK/z/ccd+E1NNcJTwp7RH6tYOztz+ql0OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ghOy/7FY8W0AjtD2eSAHJR4uESpGbhBEcVYbDMa3KsAHeVDREi4NkDKTGsKgffyFiYia//CQaCBPYeSWIJY1H1Fiom16M7gZF74S3V3tB/UrGqU5ytJv/Rf97otjx4sWiDtd/mW+wvZKrs2O2bPa+5wInK/0IduLoAvOYJmtD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHLOe3t7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHLOe3t7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso30169775e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 06:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734445089; x=1735049889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dmj67p0qMqYfgSP4wpSGAlUM/o83JO5rIN+p8PsTq6c=;
        b=yHLOe3t7qyvJ6YqQZEyDXiogj+hvICLsODD5K6mgBMA8bzCDas3p6E5+Vu4032qQiw
         UT23PNvzwZ+Pk49QAVyE2oDwevpghHSiHjehz2FavPWw2NQwdPExA4U4Mf4tCnfvUUr4
         R/EM7Fv8+Oq1bOvInsMrrNLion8uImSD6vmKrANOkYThQJqZZ3HT2tLnUhiMTN7DfCEa
         dUXHBbmdwrzQkAWjF3w4l/WwxlDYySzPx3rAo+45gWECdjs/Vix0DtMb8rJnb3qa/JSo
         Mx3s5wCT8OOy1uhVMnAeqEogaxR5GQ3B1E0bGqVqFWOofFzqDt8jYCpxDdDDGEOf9CuK
         na6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734445089; x=1735049889;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmj67p0qMqYfgSP4wpSGAlUM/o83JO5rIN+p8PsTq6c=;
        b=EHnuTR8116BQ62X6IUPW1vY8egxGQCO0HuHPsDbytaeiDSvSTaViRmdMFs2vi7uqAt
         6ie0hCvGVfdpSHnNXhfXWOzeci4W0/UmK5Fhn89xDk4fPznOJ+4/LnesHVv5mpZt1IXY
         qfyrmlxbCgA4RlbQ3RSUfLds6mUjtm2ylSn/vB64OxXMZVxuiRTTewnP7Cr4ayzYjEH1
         wFOAHpgWBxs7cpMV6egc9EK5shaFvjafr6Zk2j4Or28LzXpB3yvhYysqfnTDJmg/CftA
         Q73EXKtojbMnlonMeOGhr+8E5meFRhO95sK/Uheld1dEojSGOXXDciclYG7JUKyqynGg
         r4Nw==
X-Gm-Message-State: AOJu0YxZWyAWnUXrEWb/iIJ5G/769fofQEKBnc3zQTUPDlDjakrhpZMg
	x6d37H/PzQRMOTL7yzit8J4EMxdB3YDSGV1iedEJHC/Y+09WYXPxMOssgaiWUmk=
X-Gm-Gg: ASbGncvPZFcmNxtYBzOkfUs9T8fc/VMGBCMssjNpYDjlJhKsf44c7ZhHs/0Rjw8suVA
	whxwqqE8PFyF0ZHJPyD3U0BR3co33HwGdfLclQvXwAKLfJsTjaopK2FxF9sLbKCkfUOSaw6+psh
	8RIF6+9jCGIDS9IIH6jGQactvqQf3XmS6DY/KLAgDWo8eZiGqwzM5l2AcJzfgDgUC3xx4ovHX7I
	E/GMkV0PrLze10dp6v9dETIGQr+tFuQrjxJ1DqKkHduveYXRLFuMlADFua1/UTNYCA=
X-Google-Smtp-Source: AGHT+IHkiDyTw1OdX9zf1Bc4YlM3ydbuWw+uGesFZnDt1Nz7xBRZ8QucbaO84X5WUtVxRQfNYGWWcg==
X-Received: by 2002:a05:6000:1864:b0:385:fa26:f0d8 with SMTP id ffacd0b85a97d-38880ac2646mr13378319f8f.8.1734445088895;
        Tue, 17 Dec 2024 06:18:08 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8049facsm11485099f8f.79.2024.12.17.06.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 06:18:08 -0800 (PST)
Message-ID: <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
Date: Tue, 17 Dec 2024 14:18:07 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
To: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
In-Reply-To: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/12/2024 7:01 am, Christophe Leroy wrote:
> Hi,
> 
> I noticed with 6.12 LTS Kernel that perf top and perf record/report 
> don't display kernel symbols anymore, instead it displays the raw 
> address with [unknown] as object.
> 
> After bisect I see that the problem appears with commit 659ad3492b91 
> ("perf maps: Switch from rbtree to lazily sorted array for addresses"). 

Hi Christophe,

You might want to try applying 0b90dfda222e3 as it claims to fix this 
commit. I doubt that will fix your issue but it's worth being sure.

There was also another fix recently that could be related: 23c44f6c83

Did you try the perf-tools-next branch? Maybe something that's already 
fixed needs to be backported.

Thanks
James


> Previous commit 39d14c0dd650 ("Merge branch 'perf-tools' into perf- 
> tools-next") doesn't exbibit the problem.
> 
> Now:
> 
> # Overhead  Command     Shared Object  Symbol
> # ........  ..........  ............. ......................................
> #
>      80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
>       3.91%  Coeur main  gau            [.] engine_loop.constprop.0.isra.0
>       1.72%  Coeur main  [unknown]      [k] 0xc005f11c
>       1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
>       0.44%  Coeur main  libc.so.6      [.] epoll_wait
>       0.38%  Coeur main  [unknown]      [k] 0xc0011718
>       0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
>       0.22%  Coeur main  libc.so.6      [.] 
> __GI___pthread_enable_asynccancel
>       0.19%  Coeur main  libc.so.6      [.] 
> __GI___pthread_disable_asynccancel
>       0.19%  Coeur main  [unknown]      [k] 0xc0011170
>       0.19%  Coeur main  [unknown]      [k] 0xc019ac64
>       0.19%  Coeur main  [unknown]      [k] 0xc01f54bc
>       0.16%  Coeur main  libc.so.6      [.] read
> 
> Before commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily 
> sorted array for addresses"):
> 
> # Overhead  Command     Shared Object      Symbol
> # ........  ..........  ................. ......................................
> #
>      76.65%  Coeur main  [kernel.kallsyms]  [k] finish_task_switch.isra.0
>       4.26%  Coeur main  gau                [.] 
> engine_loop.constprop.0.isra.0
>       3.69%  Coeur main  [kernel.kallsyms]  [k] do_epoll_wait
>       2.00%  Coeur main  [kernel.kallsyms]  [k] timerfd_read_iter
>       0.96%  Coeur main  [kernel.kallsyms]  [k] ep_start_scan
>       0.87%  Coeur main  [kernel.kallsyms]  [k] __rseq_handle_notify_resume
>       0.79%  Coeur main  [kernel.kallsyms]  [k] system_call_exception
>       0.71%  Coeur main  [kernel.kallsyms]  [k] do_notify_resume
>       0.66%  Coeur main  [kernel.kallsyms]  [k] timerfd_poll
>       0.63%  Coeur main  [kernel.kallsyms]  [k] __copy_tofrom_user
>       0.57%  Coeur main  libc.so.6          [.] read
>       0.52%  Coeur main  [kernel.kallsyms]  [k] ep_item_poll.isra.0
>       0.52%  Coeur main  [kernel.kallsyms]  [k] 
> schedule_hrtimeout_range_clock
>       0.49%  Coeur main  [kernel.kallsyms]  [k] ep_done_scan
>       0.46%  Coeur main  [kernel.kallsyms]  [k] schedule
>       0.46%  Coeur main  libc.so.6          [.] 
> __GI___pthread_disable_asynccancel
> 
> Can you help fixing that ?
> 
> Christophe
> 

