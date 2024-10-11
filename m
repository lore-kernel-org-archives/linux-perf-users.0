Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0B209F26
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634706; cv=none; b=f70VAlLQkEDWPRQEkMsWGWKiuUSIM8RwVzwLYrJ9nQ2nJwGF89AWzDX3wnAlpg/MrUXoJ/I05v+UgdiwUUUcviVGmt4P57nK52jLcqLM8rf9qpE7Q0rqylSehY90ax79sqcKkyLa9MTY9kX0REhgeTMhQY7yYRGbM6oykZZ9AnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634706; c=relaxed/simple;
	bh=kVXvOP6KE5Ty5zeNsdMXbk5ClC+3am8pith54wBKNhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CelqnCNM99HBHb7XQun8i/MpGm7TXmHHvYTY7cCdDLpQI2FMrv87FPvzEChIJieNQqGm6m1wyi5picwCSerG9DCX8IgjY9fUibK54bBIuFEwgDpqFF6tGrQ8CcarVRYZmRncOp7b61OUxdudC30HeW9D9T8onmVA0BOY22ALeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjzhxzOD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjzhxzOD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so943684f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728634703; x=1729239503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jA4fDVxLqQvympbVslTUjjSQQTz3iQG+LwynSIf0/nw=;
        b=XjzhxzODKcHC4uubA+7YAG/o1ISD4OAHYhK9ErwVoAOsQFAKEh5q1/DmhykMEV2MBE
         8gHpjstNjVXL6RJt+845C8ohcAAtsUYJ1tvSslyJoalPxN6bmwwB7OiTNMDbhTmnk45B
         UTyB4TIhdFRwVbWzoy7ZZMVTkW5JN4sHUVw33b408cGrWUHg6YiSFtOjU2rF9TbRxzre
         l9v5l8Yo7/9M6l0sXYlNz3k49tSeta/YvKMgKA0mib9DiLL+NEyne0rZQbnKbu8aJXrr
         9J8x5sx6u/WnreNZUpC1ohfWqtsrrnR+iLtamCk4d25aLnqh1Itvez/swcdA3MRqbYm3
         Lxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728634703; x=1729239503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA4fDVxLqQvympbVslTUjjSQQTz3iQG+LwynSIf0/nw=;
        b=PSaDuiwdmsadRxUzDjK/d3Tmg/LNZkV9G4xDHemNNmtRJgY/0unZV6ThXuh+nB9e0W
         rmmPcPzgntZ4WHN75qNOHFdl4lD9STxQXUtNP2zmtoIeVZSPo69KH4BUw8fMJmWhuD8/
         x/lEzbhiqzGvcZqOm8MpgJbemVJbdHCEHRlsahIuMgGA+EHf9o06qu6e1NVp3OawEP3C
         iwKnfLk9kqpsOYgg3l9etQDCBZZpm5wfR5zZQmH83B5vsvpzlwL51+Hinh6LtFi6HMcf
         iFSaGxKO0zu5MMxAEo71vzlBw/VSDxMSxRfMJKrLtTOfXsaTV3ZkQCIWMJ4Rf/2HI9tI
         zsyw==
X-Forwarded-Encrypted: i=1; AJvYcCX7PtWTzy3FqIgguPqmRyQTcqvTVh/ywwgPQgp8XyeDfj9hjrvrcZeyt7dJno/k6ByDLmHVqm4P1QHU6rsoye6s@vger.kernel.org
X-Gm-Message-State: AOJu0YykzQzsl0J5jzt4DssWRVlpxrFOTBSylIgspukdGNZc257cgnZH
	XDVdNMF7Xokl4lMBcZweRzYJICh23oSKqh8wjCXIarhfWTRHIbx4uoV4ZCkyAlE=
X-Google-Smtp-Source: AGHT+IEdG5q+nO38cL0UXFQO6d8JyQ5LOlG/e8vsvQc/6A5s1cVs+62bm1DyNBgEaJonfZneVu92Qg==
X-Received: by 2002:adf:f502:0:b0:374:c621:3d67 with SMTP id ffacd0b85a97d-37d551ed527mr1199604f8f.24.1728634703105;
        Fri, 11 Oct 2024 01:18:23 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8802sm3346706f8f.21.2024.10.11.01.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:18:22 -0700 (PDT)
Message-ID: <ae55ea37-0e0d-4fe1-9b1c-6a31dd20ea30@linaro.org>
Date: Fri, 11 Oct 2024 09:18:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature in
 clang 12
To: Howard Chu <howardchu95@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 alan.maguire@oracle.com, Peter Zijlstra <peterz@infradead.org>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011021403.4089793-1-howardchu95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 3:14 am, Howard Chu wrote:
> Changes in v2:
> - Resolved a clang-16 build error pointed out by Namhyung Kim
>    <namhyung@kernel.org>
> 
> The new augmentation feature in perf trace, along with the protocol
> change (from payload to payload->value), breaks the clang 12 build.
> 
> perf trace actually builds for any clang version newer than clang 16.
> However, as pointed out by Namhyung Kim <namhyung@kernel.org> and Ian
> Rogers <irogers@google.com>, clang 16, which was released in 2023, is
> still too new for most users. Additionally, as James Clark
> <james.clark@linaro.org> noted, some commonly used distributions do not
> yet support clang 16. Therefore, breaking BPF features between clang 12
> and clang 15 is not a good approach.
> 
> This patch series rewrites the BPF program in a way that allows it to
> pass the BPF verifier, even when the BPF bytecode is generated by older
> versions of clang.
> 
> However, I have only tested it till clang 14, as older versions are not
> supported by my distribution.
> 
> Howard Chu (2):
>    perf build: Change the clang check back to 12.0.1
>    perf trace: Rewrite BPF code to pass the verifier
> 
>   tools/perf/Makefile.config                    |   4 +-
>   .../bpf_skel/augmented_raw_syscalls.bpf.c     | 122 ++++++++++--------
>   2 files changed, 69 insertions(+), 57 deletions(-)
> 


Tested with clang 15:

$ sudo perf trace -e write --max-events=100 -- echo hello

    0.000 ( 0.014 ms): echo/976249 write(fd: 1, buf: hello\10, count: 6)
                                             =

Tested-by: James Clark <james.clark@linaro.org>


