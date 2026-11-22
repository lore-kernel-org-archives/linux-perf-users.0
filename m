Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795305986;
	b=N0xUp4DYoI/Mv7K4Jqn4RI1BRD+uDqpeFXJzk8E60tMD8sHtZ49eY74pa86Y05RpyAIK
	 mVfg6zmx6sIYmrfFOsiUlo/qUgB1aOM1B6Ep/8F43NWAbTzzHiP2Mz90/nqUcSeL77Ulc
	 cG5uahgesqH5DI9A3JW1nDjT5056x+TsxvLBZN3MsoTbA9w5PHiyzq6IGmj1++suoa84G
	 78XR/3oHArpCvjw1/XHs53TVbDOm4XFOln0Twwkgb/+8Z5GpUVlsmfDkFALvpGGuaI9rR
	 PHpwdndTRvCjnOaP71tMB52Iu2cUyn0R6raAz3DgAoHCNASr2ZM+kU8xorenxXV1rKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795305986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=43XSm/5Oye+v81W5sTWVY2MRJ2snpM9u71zn2mup/WM=;
	b=zNW7jHVwqi+kwuVxR8cy5ZvPtkUZO46yN+1bb9/bcSnE4TBnWY6KltDgI6dXI3o9LbaU
	 ZDnd0PO8tWbqxC/8jSAFfZC0MzLF2zduvHOyqzdt3KVG/wS6wyTQNu45XViPO7QJT0xLC
	 dtdJea0hcgK8PvAIYI6zyyjAy5obMjfG+an/fcbTcoudoBmdgXTHtY1czSzP/xRdp26Ds
	 insUr6LisJdX1PKLANP/rDEqn9Y1nzBP6q0X4h9NX3CF6XO0ghhcZEI1tDCmxTyw83AEz
	 GFv1Kg7+7oI9wjJi4vjxxICvlwLAi4W18u3L5EHVXVUlZkMZMm0JoFxdPv9XMq1dWGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=566LQgT7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340E606A32C
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 00:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7340E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=566LQgT7
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67da3d03263so2223718d50.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 16:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795305984; cv=none;
        d=google.com; s=arc-20260327;
        b=X4V2HIU8c9moBVNthere/WekTMXb07Q9JkBRAYisn/Z8USjJf/5rZTk6gSO9rag8U/
         TDMz5uNJYE9ffYkFeuCN7KV99hS18YvLHmHr2AJzCuH38T3CkskxU7T++69xBRsZ274/
         qkYww3C6ViNHjIoLoamvGViz3reZRKWgBnQEpIpswSbqnZRJIe12387TGsBFddL1j6Dn
         kfuYpNApKvwWyUZiinEbZ5G+ijQHPY9HB0TThZOdsWXA4T7Ccueh9gng5MDKSUrg0tBv
         rJ6q5N3M6erDPIO0807T6G8lZgG/jGgzqYo38cxoeaHKIoAGXEhWBEPo6YcJLcpmtQGG
         6aGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=43XSm/5Oye+v81W5sTWVY2MRJ2snpM9u71zn2mup/WM=;
        fh=NPT58Ir7YjRkaN9Rr6t4PuZf/E5jGJ9WzzeCmIYDhVk=;
        b=lc7h4ZUskkqcF94QhBoKIgw7jDOdG/fXBHLQDIo8k6k8GB5MyLVPKA7OzcU0V+jWFe
         nfDZSBmtBf7EsoLMNv9iX4R5O1UmGS1VWsKoQY1neznlDdyUT9WTlG3oXg+UA/CbB//S
         5Lw1K6au8s8abc2O44FvwCzc6OnEkh7/ikIFQwF/uATdFLxPiwFZQzEbsXMyoJCuO66N
         k6/AqwD/3X1dkPo7yreMjjuOVOHxXEVG4zs+mbibdyf5Giag38qeqiVrZOcd3bOXYe0m
         a+uXoDXAHqF/bwQTqnUTJNEWaikF4EJBKe8PjIlsDqj167MBOZhNA6nvOByHwaqPzJKq
         lhGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1795305984; x=1795910784; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43XSm/5Oye+v81W5sTWVY2MRJ2snpM9u71zn2mup/WM=;
        b=566LQgT7esq2VEf3NoVa7rCAvQ8TecHs/i7tv9HbFirGVyPs2RBtUUUqmI12VYGptA
         ah6D10dKs8SXFrmuKX3qKhw3YW0Xwa/+vYB8dN9K+ipJCyRuFbtTIcyDMXAx3hN6nxcF
         +Xwy3CDZQUgHCj9WLDbpQnD8tGb2Nn9WSkZ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795305984; x=1795910784;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=43XSm/5Oye+v81W5sTWVY2MRJ2snpM9u71zn2mup/WM=;
        b=o0lGM/sFZ3XFPrxBiSCco5/AssCCW/MkW4g8HEf183EdZm3NkY7hDgdHVGapaI+XF7
         A9nM30mJxYIFpaybXpOiZ1PjNOprJiom+2SRQDvkJ0kV2DS1TY8G68xIA34qVI5NUNlj
         OzZ2afmEoV7ucCkDtVWXRNlfgh4RUWWn2BzzTCy4q3axSJd1+cSqYsp31UUW/82sP/4w
         q8HWskixEn7qaq+NtI5e41iDhQFWnR8GvLYl/krNKAyoDulSF2g3UGXai5n9gMSScn3w
         EhQquMaLVu/9cKm1bfYFTbZ6tK5btYaWr3ojMwF0h+o0P2ouOTehmE1MNnwt0fXuGy+y
         z4Sw==
X-Forwarded-Encrypted: i=1; AL+hErGnnQPe5pTfs8PvNJH4pjIOECIJcHfWjNLWnjXUmjRkFNSpokY0BxxDlTsuGTgEImynSxoKBdaRzEBS04rWEZe+@vger.kernel.org
X-Gm-Message-State: APuU4Z+VxPem81KUgdLpXAOyf9ZrTbUtQ0OzE7JVfK5xWDtKKSFpxGrn
	eZuioFPS4G4QY4zQ8BulLMQsuWe2HjnrZSYtTG/4ODyqlROPwrOOYCoCpiNnX1octkHxYrarz1+
	2+STlcyvHmxggqUuye9LcFb6MleTNhArYdG7SfULN4A==
X-Gm-Gg: AZFdTZfkHXE8ytH91TAOWLWDQKJ1CDssZ7XgnmHuHXQrWZypUkU5WomBqCOxQcTNlno
	f+w2fDp7A4Wsozcz5Et7zKsyMqit/PArQE+aIRH5GzBjF5OQ1o5Z98TW9LQDcxblAOr2F4au6Y9
	8574MhMLuxlwtIe0cKtpoQsIa5eRJh9sxul9sKEeU7aXsQJGmez5Q4RcOV8PXTllP4ZYLK49FXz
	HbVPj7My1WSt18UEGAmgK3SAUEzjEVZoYsjJv8CmVn9lN7M2PiqHKElM22Yp2l5KVDZNs7NM0jt
	XrpJC754XntzFCyVowwr50W+NaGw+tULEPUlfNQpH3wzC5s5IYvuQK9Bh+t3BkxujbUhqqdQAdf
	ny9bybTtK1hnDVVMEcf7IFYH9Zz9HwEoovkEU+091pbtikxAuvf9BJ8XboqkTpoXktLBSBQ==
X-Received: by 2002:a05:690e:400b:b0:679:c17e:407f with SMTP id
 956f58d0204a3-67df42b59e6mr2399497d50.10.1795305984101; Sat, 21 Nov 2026
 16:06:24 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-2-165dceb2b049@uber.com>
 <asbDJrY97tRqoPaR@google.com> <CA+w=M=TtAfiHVQqiwmchtsWwNeN5So5MxWW=82RRAUXHhg8D+A@mail.gmail.com>
 <atTzPJJvR2-sqtJn@google.com>
In-Reply-To: <atTzPJJvR2-sqtJn@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sat, 21 Nov 2026 16:06:08 -0800
X-Gm-Features: Aa3M54pmvrE4E58Pk7_kkWcO1hx7Txyg9UmbRekqT_g6DcaxVJXnk_2vAMUNgOU
Message-ID: <CA+w=M=SOVcLiy3Bs8CKpHmKYMzyN3BOBjV+8wFWH6xoo-DrE5A@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] perf dso: Allow reading DSO data from an explicit file
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

On Sun, Oct 18, 2026 at 9:26 AM Namhyung Kim
<namhyung@kernel.org> wrote:
> On Sun, Oct 18, 2026 at 08:09:41AM -0700, Alireza Haghdoost wrote:
> > Unless you are already working on this part, I can send a separate
> > series to make the data cache type-aware. The series will add a type
> > argument to the read API and keep separate cache state for each backing
> > file. I can then change the lazy loader to use the data cache again.
>
> Sounds good.  Please go ahead!

I looked into this again after lazy loader v8  series [1] and built a
prototype before changing the DSO data cache.

v8 checks the file before each lazy-name lookup because the saved name
offsets are valid only for the file used to load the symbols. If that
file is replaced or overwritten, the same offsets can point to
different bytes and produce wrong names.

A type-aware cache would therefore need separate file and block state
for each binary type, validation before using cached blocks, and
invalidation when the file changes. It would also require changing the
lock order between the DSO lock and the data-cache open lock.

I measured a behavioral prototype on six workloads. Keeping cached
blocks for later name lookups did not give a measurable speedup. In
the many-DSO test it removed 64% of the pread() calls, but the run
time was unchanged because the file open and check still happen for
each lookup.

[1] https://lore.kernel.org/all/20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com/

Thanks,
Alireza
