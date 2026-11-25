Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600678;
	b=kHTMeJlV7eb4cpVT72lx2J/bFLeCfCO4KdUidcmyUpx7YT7FDgNlSxM78n0b4YMQjkl/
	 AsLy6OfvCf0gwyBZCOhp8SHAxVz0OyfHkXjat3diQUfwVXCvyp2Gh7zOJe6oOaBYxJBcM
	 H1fLlx6W881w7JoHM++V9xahcD60Oldn11XZsnc2F2ZiFztjqM6gJRbH5jefga8A0c6cB
	 IRaRF8s5eafVuytAd/hG0HbUC4LpHvG0vUdaCy+Bn7fgMQ62A1HCaqwIs4fx2GrWh7Czy
	 5we6X7hG/ctMKddsSabApxpj9vEcGOB6J3urICYm9G0fjM2mhCbmq9dVbOHDmvhQ0ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k6KEcTl/pyiQsKyyg/2eQ+l+POB59ejsRYmW+NNyeA8=;
	b=UNabEY+UtnVSN1eRKW2q31+/oZaPw4u4/k8bAEQeU3wn4C/+awi/lSmqtsssYrBdH1ot
	 TR7LYY4nXBQjvoeZ9uV2S3YSL4mWqQTN3SDWChTPtDbcEx5Rn377RMLQsi3+ezHG1Hb0x
	 +LZojlceipHyUr8XWiVus9j/Dn3VwTQzN/Wi9gl6w42XptdCiNVOJtpIOuNXr1jevjgKY
	 f6jqAHrIExeqxGVEa4PO94RRUI4fMuCGFd0ZQdEV9eJP2A3moRzIwYX3Q+/CT9A7ngkfN
	 4LPQejpV4hSSXPPe4Dy/CoLDu2lMD8JpiPF8iDOq2J39P8UTQ+m+3Epnh+qh+N0leAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U4ho5SIW;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18D606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 09:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F18D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U4ho5SIW
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e09aa5264so3174771f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795600676; x=1796205476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6KEcTl/pyiQsKyyg/2eQ+l+POB59ejsRYmW+NNyeA8=;
        b=U4ho5SIWBLfAJh6L5LxddeznA40KG8rNkgKkmJbUOGnKML97JS7z0daSK34Zyvnr9Z
         emW4BnhTJPTGzn7MDO/XQ6XFuGAkn8PqfR9lmVM0j/npQJm39KhqnCc5mQozsg9zFA+k
         nTSmV7GBL+NT8vrX+Pa7YX6Ru7xTGU3qM4CTFBA8YOieDt6N4g/1BiI6yxOrWS2aEow8
         FD4gXsInN6ZPK2FqjU/gAVh5kZCCcJGd27RWkC3rnlR+1ThU7hUb+s02kJRgG7hQmeZ7
         re6IrPGN9TT1ywerZEdUzP/LM47cfXwtQjFH72RWIUB23Wx/B17BIfb9f+7Dj7GSHpJO
         SiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600676; x=1796205476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6KEcTl/pyiQsKyyg/2eQ+l+POB59ejsRYmW+NNyeA8=;
        b=vaH2L+qDp28tXyiSiy1DKr4O1vJyz2/PYv0K5W9gyzQqsZV8x4ToJvmHtRRQBZCg5z
         4+jpFfeUD4W7D3mVVrBM0XQtGUvEVK01YKMxUvTXyhi8tSVrSHaF37Z1VTNgrTo5/Piq
         OrrFUMoTl7GxoFm96J/H2LJpGTCxt97zvC8qioSL3iKPhSt24MA3HWmB4em3jtXTeOBI
         7u25ZERDhgwlKbZWySiIkm06j7g8rcjopGZEMMsFRXXtSyghedUPN6x+rMbramMARBJN
         8DnMKqCyY560NKl0SttUqrW+k1rWc9EWxC4M3zRnuAPJv/0oEvQdJ/BustLZ7k2jGGBe
         Sesg==
X-Forwarded-Encrypted: i=1; AL+hErE5ux3LY2Ks7dSPhs4vu0hHjCAD6Uqe8WNeNNe/qr5Bei1DslIXoH5lCUIejP5hZFZ0F3/qaJtrwmxdsZpsA2pe@vger.kernel.org
X-Gm-Message-State: APuU4Z8YVrk2GiG09mHfnLs9Lw7PX3pz6qEMlj/aVu9+TGLKVk+gzT+A
	Oelz2ccAS2vuwIAZ+NHsFriBI263S1JcZQTBzKCveD8nbUmBSrjhcELmQQ1masSTTDg=
X-Gm-Gg: AZFdTZfZtMD3dy4Zw5BoNXQsf6BKkQOSy8lPR1yzRuGwx6mznkcXDC5USEVZzYdXcBI
	OSm4iO9GMYyR/qtXVrDofrxWnAJQW+oN+BmwWeAZjk0ndbVEc11Vzlad2lojPcoPDEnmN+kAmHH
	1j+MxdWuk/ewRy1i/xeqDxC4FacwWN+0GC3RC/W7wXKXwvXdsxd+0KVe6T/Iu9frEPrXvEAFHLk
	vevsL0o7t4BMtRgRK0/5vgluAhlNv0t/SzeiGRDS7kAmpdPde+IdZbXi7A+Pnon2wpsuY+ocQyI
	d0nKDjGxeILQeVGuXmwfUTXYbJCeoly5JfgrXwtrGgLGpVeemZ+AO9hbqKVjA7B3tQPgPZio1H8
	UNNdxG41FhRBTIWOEHCd0WwgdcMX5NliGkvPHyY2pJx34k5PUB+NR1TNMDFaCYsaJThshqDLuc4
	qUB/PF/sKKl4DqYtegJ7kQZ4NLMlYAlA84MmgHbj+SAGSE71WOrfZVyyo+37yoH4V8tEPwWZ7Kx
	FvHOh7ekZVzQu6jDJd+lvoIQzu2XQirtFgZXsUL9Um2tX4uaYOWz8+YnCre2KC/J72jA0VsK/RW
	Zz1EJ5zQJXCUOOaf1sIxYdy1kq2TZi8RcA==
X-Received: by 2002:a5d:64c9:0:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-4abb0f3c071mr35368426f8f.14.1795600675654;
        Wed, 25 Nov 2026 01:57:55 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm32730070f8f.10.2026.11.25.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 01:57:55 -0800 (PST)
Message-ID: <d2ae7970-63cb-4c8a-8c04-483d88fcbffb@linaro.org>
Date: Wed, 25 Nov 2026 09:57:53 +0000
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
Subject: Re: [PATCH v4 15/19] perf auxtrace: cs-etm: Capture wrapped snapshots
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 John Garry <john.garry@linux.dev>, Leo Yan <leo.yan@linux.dev>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-15-7759e0ce2449@linaro.org>
 <8b37f5ea-9427-43f6-8abf-07a36a9bbb72@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <8b37f5ea-9427-43f6-8abf-07a36a9bbb72@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/11/2026 20:41, Adrian Hunter wrote:
> On 05/11/2026 13:45, James Clark wrote:
>> find_snapshot() isn't implemented for Coresight, so when a wrap occurs
>> we only save from offset 0 to current head, modulo buffer size, rather
>> than capturing the whole buffer. Coresight drivers currently use a
>> monotonic head pointer even in snapshot mode, which gives a lot more
>> information for taking snapshots than a wrapped pointer. It means we
>> don't need to search for data at the end of the buffer to guess if a
>> wrap has occurred, and we can go back to saving partial buffers after a
>> wrap by checking if the next size to take is less than the buffer
>> size.
>>
>> The drivers will always be able to generate a monotonic head because
>> TRBE has a bytes written counter, so even if we stop generating an AUX
>> record on every overflow, we can check if the counter indicated an
>> overwrite and offset head by a whole buffer size if it wrapped. This
>> forces userspace to read the whole buffer rather than between last and
>> current head. ETR and other sinks use software double buffering, so can
>> continue as they are.
>>
>> Add auxtrace_record__monotonic_find_snapshot() and use it for Coresight.
>> A monotonic head can't be auto-detected in the default find_snapshot()
>> by checking if head > buffer size, because before the first wrap a
>> monotonic head looks the same as a wrapped one. The search would then
>> falsely detect a wrap when head is near the end of the buffer, and the
>> wrapped pointer fixup moves 'old' and 'head' a whole buffer ahead of the
>> driver's head. With a wrapped head that doesn't matter because only the
>> offset within the buffer is used, but with a monotonic head the next
>> snapshot would either save already saved data again or drop up to a
>> buffer's worth of new data.
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 

Thanks!

