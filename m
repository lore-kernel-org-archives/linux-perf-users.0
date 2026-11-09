Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223197;
	b=ujf5IE9oUlqohp6Zm5aieycRQbBnE+LYpAp6PzN1urwKGBx8yiGtPLACSV2venyTHy0w
	 k+/fFcwB2nA92HSwipIP0q3X4TAl8/c1Vn1cvNGt/CvY3el8bKDsf/ZpJrzG2nyf78QxU
	 PN7WN14cotgJkgct0V7dD4NFJKpNA5xl8KWmAggOvd5qjLCo4MkgGcbYE0TcyNK+TAj2j
	 YVhLTjVL6l9hyBY5lQBR9E0o9WWeSnlXliymhy81ZqvpreHFzXJgXCXAX2ZJesD9icbI+
	 VGnfiWjhJiYlUjAncVFauUU6/oE6kL+b4u7E9QMc0L0035csFHQVKQGbFqKGElha5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WO07T3iwpJzHvxuO/do8IZbWSn6dr9c2S7mcJrXY/DQ=;
	b=Z/O9FlLMJQWdEbzh0XNFdtcUMI92MvKBIdmIpcfGH6JIkqYVqWwGRWZtZ+f0r8Lt16qz
	 oWMC+I2wiUpV0AHM/BSlaRv1L+WaknIQiEVmEDqKNfAZYPaco5EXcPvd5g5+m7AZaMYM9
	 z+/hYpMQg5YxJ+s8l2Nk5u7nVXLz/2utFlZyMGLSAys+sBWKs5axw4NwmqVcrqUKMKh25
	 KZ4fKeoumUr5sF9dUhRzNWAE1HmpwDQJMN20MAotqMlYecRCzCL1hg8/xJDuTq7TM3IBM
	 YqCCqy8nRYIL/oJ0XDTqdZydv/PzNQwxF+vzKgZb1thHoR0O4jvbMnpO/XSiq4etgHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=of9iZ0d4;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E3606A335
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C12E3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=of9iZ0d4
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so480944f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 03:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794223195; x=1794827995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WO07T3iwpJzHvxuO/do8IZbWSn6dr9c2S7mcJrXY/DQ=;
        b=of9iZ0d4eI+0wTal+tpXcK3y7s7Orx9H014cG12Mf4ic6RiZEJC2UtqJi76NROuYo4
         8ZXxyHDKXkOIeO+GtJwTyl0zMbT04TRI50XTjF74EG0E2ulx5VtINdbdT6rj7GVWR9RZ
         wZWhKd/JOPIedgjq03fj4G4NF02a8SGKWCCac9j2i8dxnswy8kOX4GtjhXPTohQnMm/O
         tZR7IrwEVhGDpALBopfGToBTYYWsMjPFeUoWac7v7bY1a11VOeO4Iax8TPeuch30zJk0
         NlFoOsbZsc+9fTk+5PF0m9cyvdpuoH2qHSZtr3xXq7FWFWz4DQ6jMYM3G8HUZnlYcRn9
         rGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223195; x=1794827995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WO07T3iwpJzHvxuO/do8IZbWSn6dr9c2S7mcJrXY/DQ=;
        b=MDM2O9k0ihsq/29CiURrBYufaC/3eS5UjgPFQrxL+ZYBmUjDogO6mAagwj1H3O24wo
         XWvOyCGXxiPfxTdHL7Ggey5CcWi/c8wsOhMs4uM1UtkgfgCFV0jnNKBNzNBYa4WF0FxQ
         mLcb1HClDtuXxCKGavjjX2c/QwzopPlUxrDUMaYJIogNYbyNIrGtSylF4v35uvLQI+tR
         033P5S3f04X89Bwiw+tVaw8Nph3IcvuYgsjQ6DvyjlXajoWjCrIqLqs22wsD+fdwstR1
         OX9dk1NnZxXsT+6WAVGVRUn/DzaneqElKmkFO6Dws+7cG2wNGBjdYorZHvTGc7xDJREQ
         PX4A==
X-Forwarded-Encrypted: i=1; AL+hErGaF945W6cPuARZ93L9CL3D9IWvB6DNZX02+qQ+Ljze4T/l2XCwIJo9nbOJ+YvBy4QLzGCksY58hH2Sd8nc2osd@vger.kernel.org
X-Gm-Message-State: APuU4Z801USKJH96U9GiQVkHbMyDmHxioLHA8iLynW5dPWlw6iXWa1Ak
	mkPfB73fE+l2lC0MnCmmjOHLmF0txj/SvywAXgCuIXrv3oeYSEk7EThC5mjeDojJiaE=
X-Gm-Gg: AYBFou1rvs9WPNNhnv3DpCPSOQb+KKcd3JebmXpXF2GZStsFgnR+NBuoxRjhcHRffIM
	YRbTpAtjXRfNbtIKYhcgCW4XhgvUMTsnlHMtnSXBiQi1TNNTogIG+QGTheoOgETev+FF/BpV5bo
	quecwjR0LKgLQoOIlAQiFPHMrmtQs0RZJIGgIYRVJrNVxz77D7kcinVsyMhcX3B4Zgtlsa/75dH
	8uQa5nsqC0Phck3+6jaAGb08AanXRtR+zpJhT5yF824SsoSi5S8wrSw36Wb+RxIwSkg6TRDrCUP
	KSTA0eX0p1UzEtVD2F436f3ZSaD1v2aIFdASHcQrGaWN6o84BgKD1C6FbJPuvK8tV+Ffla6sUx3
	b8UlZ+7zknNB07ouViZ8N2TDWgLvmqD8u3aZy/VaHBWwPQRIze2R+YBdxuweQJu5cY3h2ZY1Eow
	q32k9JweIa+NgDZ/DZ2b+KIPp3JEkpErbZpvIUcvIc53uJwT75HAWVZKsMeAqJv8vZaAnkk8C1d
	8L6D2tfW6hrhkLR9cglZPX9cCBI62OSWW8DEu8PL7G1XA4X5iy1uYossCsNSmyLDQEFbrhSrgpy
	SEnp7Nk/Fo655qKGBYK1a+MDoAd4qf/C
X-Received: by 2002:a5d:584f:0:b0:48e:76ab:7906 with SMTP id ffacd0b85a97d-49588622039mr7484276f8f.9.1794223195052;
        Mon, 09 Nov 2026 03:19:55 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783e39esm9142819f8f.45.2026.11.09.03.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 03:19:54 -0800 (PST)
Message-ID: <1baeb4ec-4244-42e0-8c53-29df079c80f6@linaro.org>
Date: Mon, 9 Nov 2026 11:19:53 +0000
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
Subject: Re: [PATCH] arm64: perf: Fix the userspace counter example link
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20261106234551.1474417-1-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261106234551.1474417-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/11/2026 23:45, TAKANO Mitsuhiro wrote:
> Documentation/arch/arm64/perf.rst points at
> tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
> target, but the file does not exist: no file of that name is in
> tools/perf/arch/arm64/tests/, and no commit in the history leading to
> this base has added one.
> 
> The userspace register access described in this section is covered by
> the "User space counter reading of instructions" and "User space
> counter reading of cycles" cases in tools/perf/tests/mmap-basic.c.
> That file is the only in-tree userspace test that walks the core PMUs,
> pins the test task to each PMU's CPUs, and selects the PMU by its type
> number when the kernel accepts the extended type.
> 
> perf test -v user runs the four cases in that file; the two reading
> cases ask for user access through config1.
> 
> Point the text and the link target at that file.
> 
> make htmldocs does not fetch external links, so a plain documentation
> build does not report it, but make linkcheckdocs does.  I checked that
> the old link target returns 404 and the new one returns 200.  No kernel
> was built.
> 
> The edit and this changelog were written with the help of an LLM
> assistant (Hermes Agent).  I reviewed the diff and the reasoning, and I
> am responsible for the submission.
> 
> Fixes: aa1005d15d2a ("Documentation: arm64: Document PMU counters access from userspace")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>   Documentation/arch/arm64/perf.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
> index 997fd716b82f..236cb5da425a 100644
> --- a/Documentation/arch/arm64/perf.rst
> +++ b/Documentation/arch/arm64/perf.rst
> @@ -140,9 +140,9 @@ only be enabled when the tasks are pinned to a homogeneous subset of cores and
>   the corresponding PMU instance is opened by specifying the 'type' attribute.
>   The use of generic event types is not supported in this case.
>   
> -Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
> -can be run using the perf tool to check that the access to the registers works
> -correctly from userspace:
> +Have a look at `tools/perf/tests/mmap-basic.c`_ for an example. The two
> +'User space counter reading' tests in it can be run using the perf tool to
> +check that the access to the registers works correctly from userspace:

The section above already says how to use it, and points to the libperf 
test as an example.

So this extra reference isn't necessary and is in the "About 
heterogeneous systems" anyway which doesn't make sense. Unless it's only 
to show how to call sched_setaffinity(), but that's not really in scope.

I would move the sentence about how to run the test into the "How to" 
block above and delete the sentence about user-events.c. mmap-basic.c is 
also a very confusing test IMO so isn't a good example. That saves one 
reference going stale again in the future.

>   
>   .. code-block:: sh
>   
> @@ -160,8 +160,8 @@ userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
>   and should be used to mask the upper bits as needed.
>   
>   .. Links
> -.. _tools/perf/arch/arm64/tests/user-events.c:
> -   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
> +.. _tools/perf/tests/mmap-basic.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/tests/mmap-basic.c
>   .. _tools/lib/perf/tests/test-evsel.c:
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
>   
> 
> base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee

