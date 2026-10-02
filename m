Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C72D12EE
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939550; cv=none; b=mheqZCR8p7yWp2Q6DgoEPul54rQRauCSwWcXxaEDOjxcdmM++iKBP4Cx5kVJ60S4Tq2zWBwRt4N3C5vnObqLt5U+HWNfhbQZyrJFZSac8CYUm9ZbGWddOhGU+bBSVMmJJJRkskdMv82A6BGuUlDHzqTyI2KU7fYXzByQk5eWw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939550; c=relaxed/simple;
	bh=j4E8iZjMgWKr83Y3OdG+F88zPtRgQWu02JkVMPZweas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JimF4sPziSmPTG0hxqYMz8NPg64fiQFEznhgqVgdk/nkKopv7b+5bmk6NfyB1k7fd0OS8XnMty45UqqmJ9qyzBaTo/lYW8ZkWUgsyEUpBGOB93/pgxanBX9ZEeXBJVIqN49URmSOB/7+WbgtEDfHnJUkSvrVvDLXWdp1qx3NB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjIYnfEU; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjIYnfEU"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so57223765e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939547; x=1791544347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4E8iZjMgWKr83Y3OdG+F88zPtRgQWu02JkVMPZweas=;
        b=cjIYnfEUctQg0tNuYzWcgp02Q81R9OgkQ6GS2kK88tj2eK9WNnfYEVKpjO3wDsDZxb
         7LMQ77/hcCB1F8DdN1M45iQAI+3eixSlIE9T4TxAJGAKO/XdaQFQ0UZNCTc+Wnyne7CH
         Msdqisvuf0kmVjyKnBuwwtMqzbIXSSbzYyWCwyPtwEjoGqGNn0iawJ8eFyCPI8z9hZMU
         1ZJ4ay3y8Rz39JjBcYALBHRNa0068ApH65PqLk40Cce/s7Y8ArNMLWJS71Br1BEkshfV
         mjgoOXoAuGgcNcysvBp7c7CDjgPu7VlQ4veyn67l9W0VP9jeApJo3J/WIMxDAWFmmMah
         AtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939547; x=1791544347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4E8iZjMgWKr83Y3OdG+F88zPtRgQWu02JkVMPZweas=;
        b=ybeORfcNGZf1jajA4wJwN1XhzS9FClT7S4w1Ecm73pna3LetXMCIYL8e+frUxzWgZ4
         rzb0ylH9mv/GnXjYkRilti77LyPscHHIn5IgsZd47qwJlDlInHHhxquLMYpcN24qATz2
         MTP80TOVggwgbb15Z9PDAEnH0UzCzQPPqXdGFdYD6KIdUKScwNHVgBCoRJESAqUGx0IR
         oGhqzZaBPgWiGPRz3vqq2mcWFhPr7DGB+MJO4oBWHHRsg17eBGWoYfh4Did2PKol0GQH
         okKkDVqQBz7WU7S0/Pc82HBv4VEznN6CjmcBA4QJvCP4QX6BLwS/UknvBoH/bs4Y4KHR
         QTFA==
X-Gm-Message-State: AFuF++kj9UCP1MMzhYO0oy2u5JDN9OF6Mi+zrXG4HlYTpoyZyNlu5ZgL
	1dr/f9YxP6awLWfcM2ufTMw1YGmOQNPnFgIU9NYeS/7e3lEXNpOCSE01/3Babf2+dMFI6JlHIEa
	EGKALeydC1Q==
X-Gm-Gg: AYBFou1umYb64YEO1ZX3ayZAaVV+JTsFp75YhJ57wFV2evQlOqNO7f+bJzBw8yiHqii
	ufwCjNDMNiTHVVbUdkMwEqzOuUDyHW4smMJ4rAGkMZS7OC6kZCui9O3dwTZJ3f8Ynu+hN8ak8SI
	YHI7TCwzOXOt4KBwGLdu35XL0TADB6EK+JQloSik1uSlj3KkNLp3RLmdWWMgxpWl3tpTz3IlbO+
	izEMKE/TkVQpgNp08cKeT72uBXBNEFe4koH8OgZBpL/+YbBgNsp0PE5X7JirkWwt8zBXvLwbNKt
	TpiR4725EC1DV7Wocim9Pblde4xYo0SFF5vHA3y5m3HKo764TqB4HXm/EFUUDzZUpafyCewkaNW
	n+KDcSgFAR6IpNLQ1NpWZ7XtT3SFXVzKGWiH5YzWquEa40qgw+Syg9/C87HE3nYwRFgKjBWtU34
	F8c0ZfgtQa3e0tADIq5VjRfm7tmI3x45Xb+ZSLlZPTWF9QkBFXltprSc7buuEzw5lbB6K3NrCEH
	FQ=
X-Received: by 2002:a05:600c:8b77:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a027564df4mr41427285e9.19.1790939547101;
        Fri, 02 Oct 2026 04:12:27 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f9ae1sm5204513f8f.39.2026.10.02.04.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:12:26 -0700 (PDT)
Message-ID: <a300ab54-67ad-4081-969a-c1ddef69b8ea@linaro.org>
Date: Fri, 2 Oct 2026 12:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] perf: cs-etm: HW_ID improvements
To: Linux perf Profiling <linux-perf-users@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2026 12:03, James Clark wrote:
> prerequisite-change-id: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e:v2
> prerequisite-patch-id: 1aa32269a3a7dc76840dd8a24cb5a8715507e898
> prerequisite-patch-id: ef471f468351462f67efa58a09a3461306ac5a0a
> prerequisite-patch-id: c78946cf4ec1c7722570865403a3562625bdaa33
> prerequisite-patch-id: 0b953eee0252db3c7ba3ef1e3397048a94482ca2
> prerequisite-patch-id: 27da72c2f01bcc68205bbcc14d5019369c02cb83
> prerequisite-patch-id: 365c6d5f71c754e4c690b5ebed3453565bb5b809
> prerequisite-patch-id: 64e9419a41082a2db3daf255baf0fb40efbae5dd
> prerequisite-patch-id: 1dc2e6ef8e76b369736b4c88560302861b2e4faf
> prerequisite-patch-id: b7de38ec4d90f5b45d56390a4e5919a1d6439951
> prerequisite-patch-id: 3548d5b161cfb8c11a166ca2b3228ca4821f1ca0
> prerequisite-patch-id: 97e66600218a2b32e5b21d0abcb6321590f98de9
> prerequisite-patch-id: 292282b20bd8ad7d096ee7ffbc55dcfb75455f53
> prerequisite-patch-id: c80259b47850ba65c985c85a29c8cf4948463d59

Forgot to remove this from the b4 metadata, but it's no longer true.

