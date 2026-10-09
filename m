Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1C3D9548
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537955; cv=none; b=uh1yd/YAwPQyA70e2f106t6gwhWTnrBTKyBctM/v+a/EtJefj5TcUfYHDpPlT/gMRlpRhZxUPYnVG+Wcpm3s1lurowy9p8EUZrAuJJo3Rjdl0+yqL4QESjwXzQms8tsgRWPpKDGrYhbOd6R3vK5tixgrQZPHw43J7AYvTBJtYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537955; c=relaxed/simple;
	bh=i098y0mnHm57TQorRg/tN8rNvRK0uv5JFbnfSKqREz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKCDX9Um+5/BTGq1D3WlOoHFVVWDjkzCTtGEg7QdUFLWAyEqxZSdRjJhlG9faEfYG/5ShS/3mKZAn/HHX62DA6o7kvNbJXP2CPs+2ZYyE3t4eyz0X8vkN2ef2mqyi70F0SwWmlrBl4pu6pkmB44f2W5ofpeAjTIQNL61kFyoA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugBAGAhD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugBAGAhD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso3637004f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791537952; x=1792142752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgzMN7GSKW7bwxrlr1yTEXEUokyD0aM/o483mXV6npk=;
        b=ugBAGAhDkwUDNRWXTqCR9hlFdBb6S4w/BffoywkkgsDPKAIT2JmGqu/4olI4juJMZp
         g8ZFm5Ekfo2i7sTMScylHScoDFB2zTag2n5ZAMq+c5NMgmz9QmcfV5PgRFWLgFvDO93W
         dPZA0K6dKisa5+fFw319aAGmM5EOlFd5BbEERcBysSTH0pVvFVNBD2/pbinG5Q6SIPf+
         Y8qHcxQzXXNG+Wn5VG4YnWNxLC6LWqOoUttgsWL3lEawWe0g5sJ4WZ01rPtFiN24tcf0
         HVgZeEIG/BYfUt8wfwkfT3/iXRQReYGbbWYMCqOBt2J7s+6ULdOy5nSV7C+WcfMmadyU
         LTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537952; x=1792142752;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgzMN7GSKW7bwxrlr1yTEXEUokyD0aM/o483mXV6npk=;
        b=PbERrFvOpOyhqazU2VXD7/9c6mvK5H74E3va4Tl+XrgTKnWKuAC25W1pi9bT6Cfxbr
         +5G4C4jrJwUB6Y8alZfjzwUCygdZnNdHt/RjT6YNZJYcOI4uCtZ5lElABJeh9mgrsxMB
         CbMrwTHMS3nvmPqZh0NbNNo5667tdllbRZt/QGnIqkq5GVHwqr0zK2FBLQE3NaImi37e
         gq3//LDR6Sx+51/Nf/I/IEejApIXT4tvCUD7NZITvApuPyQGxW3zCyycJat/CpdiZdqS
         HxY5M00M7fopl0xCP+jZ3EKT7VokXNuX3rpbyKBoOPa3POYLPNNgqeQg2CtHfzK2pGDU
         6XMA==
X-Forwarded-Encrypted: i=1; AKwUvBzdZTHv3l0r2VqkcNhKvoAD2TAXnTy71P6weG020uFRL0ay7Hl8uiDKRdS6nZVCzeKHYMMsiZ0p9DmWIJ7OfLRm@vger.kernel.org
X-Gm-Message-State: AFq9FYI2k7U5SpqHGg2S3wegWXi1MLxPibZfx6cQbLyL7S+tE3oG7bwm
	rtXRWnytRCJpL6Y9zuXd4IVuecotkAvH+bTEi4su5yRSadVfsyore3LTLLAS887JsVE=
X-Gm-Gg: AYBFou0wQ2GB0RpMti33OZYLc0t0TuOm3F3Su2NZhmKxvgq77gI2oebv+AxFpnU+UsV
	ggLq6FfJPMYDB0a/eUdH5CtjPnqcGOY4AxekJSwkzlqOMtweZQJiJ6Kqts3UXxykdcbkVm/fuzS
	PyzGRwLtQbJoYEINnJWOCTg7DrfLU7kcjQ5MC4zbM+cCL4QHM/H3sSbOrywfT87k4x6tEQNCcre
	hGtL6g79/6AKqE5E8m+9JEDlW7YGmL89nnDUthLMYvpvguA7ENq11+7/7oxdKGmjKMnVNKpvo1G
	Blc0infEcs72+3sp9uZL8GZwhhXPUAVeCsPj4u65bYOAR4c2M43Qu3ecAMAqUPfkiJVgOjEvm5/
	Emgq6+b0CI2naFCEo4WftfY9umsiSxHKAo2beT0nlHBIe74eJjK95aD2HMWtDnHHkgbXsjtn640
	bkvLuZtryEK4M9Ra1wsB9vTsI8J1TMKfF8ee7yir/3eSj+zHQgqFQsB1UcmpEis+g0bZB6zaZa5
	FSp2eyBW4LGDQ==
X-Received: by 2002:a05:6000:2301:b0:488:8ab9:f74c with SMTP id ffacd0b85a97d-48dba77cd61mr2451398f8f.3.1791537952139;
        Fri, 09 Oct 2026 02:25:52 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9462ebcsm3297499f8f.8.2026.10.09.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 02:25:51 -0700 (PDT)
Message-ID: <f66a803f-6355-45df-83d0-bb6d29afb4c5@linaro.org>
Date: Fri, 9 Oct 2026 10:25:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] perf cs-etm: Queue partial AUX records
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-9-00c4fd0701b4@linaro.org>
 <20260827170936.GO8904@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260827170936.GO8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2026 18:09, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:49:07AM +0100, James Clark wrote:
>> In snapshot mode AUX records may straddle the boundary of multiple trace
>> buffers. Currently we only queue AUX records whose range is contained
>> wholly within a single buffer.
>>
>> Fix it by queuing any partial AUX range that overlaps any buffer.
> 
> This issue has already existed before this series, so need a fix tag?
> 

I saw it as more of an improvement than a fix. I was hesitant to put fix 
tags on everything because there can be so many different interactions 
between the changes.

Maybe we can leave the fix tags for the actual blockers and asserts etc?

>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Otherwise:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

