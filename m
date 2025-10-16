Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC322FB984
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626982; cv=none; b=PAIEK0ZuMfoNMyHkpOwjZnJHLS9bjNQSHnt3WWEzCIL5YBbU2MG13UGFDt8S9qMwARwD5XBv7Vm+A1V/4VUI6ZZOhaVbcyL3Q+sMmtOjgLn41ZqiJLiYxL1QW2Iuzqv97/2N+VoOyhrwmUVcY9LWGAl1nvsoxKjtIo3uk0e5ZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626982; c=relaxed/simple;
	bh=OQ1A4dVm5DAdEeEBApKQzZKh7V+oPSeChL2356GfBfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPq788/uCeVi4qJk9+W8/BKlc8NktYfr3pjMHO+ynnhS12P0a/bu+mhNKznvKRxjwFs1VfugrstM0moVI7BuU2t4HuDD/V0goxvSB15ygKshodR69ExDeDPYTLj00DvSTXTvPz3X60YGxhKezPfMIegfi6oNj4norKcNEYW3zDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZnLbA8t0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnLbA8t0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-427007b1fe5so470184f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760626979; x=1761231779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aUPR08mmztRyTCr2P2Ef81F1uM0hF1XfMqoz+oB4jk=;
        b=ZnLbA8t0q4EobfTdJINGpmgvwd4JfH43oED72kk1M6jv+B7l7ynKjVLrhq6pS/6rJR
         sokjoh27Q5GMhFerIpAJqLfteOd3U7EpSjayvvCVddJuOEa7CuVuz6QBnFv0b+2IqzDf
         My6Bk6gDLysCnY9yo4UNRACGQ3bvFL/epHbiZ9ThzuUWsgGit7ogsS7JFafzsgt16+f9
         54cp3qjW/Ycr5xZqZtGzeZ97rMc3wnF2o23riq6iOkLyfGhdyBJdZrccnY9LtYFU1e1X
         Du6g94h5eSXFhvQYt8U6xD0dobJNolvPd8YMgfwUil6lrNNVtcv0ZI9bvMrUkSqjKcyv
         9PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626979; x=1761231779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aUPR08mmztRyTCr2P2Ef81F1uM0hF1XfMqoz+oB4jk=;
        b=q3yymZqFtnN+1lqfeVE4Q3t9aLZxb3MgdljV9cfcAs2hZXToa+aGs25XjeEtBlj98s
         xNpQGvWA1o06WJZsLh5t9AHBiY76sUGFOYXLao0Grl1Q3/KQSDGP9ADwITDkqvDOGsph
         daYsYxjJprWk0IRKnNLJ8Et8MiTlhnJzR9RpZbK30/3Rl00fSOzVGm2QeJ18P5HKz3fb
         A1FObwfddsSiqaePyMy0vy1wd6oCz5tmd/XgEbyL8mJ3azlu5seG6UDoJCoV4RPFi/PI
         4XZa4HGi9R9+Vy/Vmn2qxXIsKHBsKzC0fK8AP3NhmxBaWyPQCbVrbI2h2BNFORP4VXMT
         N2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVockPBcE99plRgWabh5N8Ndv0M+wb3C4wCzIlnzfpHpPcgaaJZ7tVY2pufnmF73h9y0LVVntnzGgBNdzZvkR1N@vger.kernel.org
X-Gm-Message-State: AOJu0YzMct3eUqrRoE8Tx6xSl5Dgcezjf9EJEeYURs/gul+0k51jqtDj
	ze6fOovAOhc/JLP2An3RIHszC8IxcGMiUP8Cos5hJGvlhi74xnw39w6JffOaQEYszhc=
X-Gm-Gg: ASbGncs5aFNRYr7oU0tnw0CE6cjckizCIo0tw16dSu+YhqwbgtDTlvblGx1FzVPNsoA
	887R/n2Y+6ppKCBxWrR3RrgQPqiuyTz8f3xyjL08fssHePqTjXGmrCuKePVOl7vJzuBV9hY4Bov
	iRC7dZ//vVFzQPO9RFmJ+08tZFe7HHsyDYQY9X92irDtp4gLnE+sux3GujlNQlBFm49BPHnmGdR
	wavOyomN2zg8WLamQLkUEZIIVX6uSfitV83BYDeeQgCsIUZl9lkT1K746HxKQtkE3IEOLhzx7s9
	7DFeE1i3buFMT77jQGx9eTCCDGU5243cp05A7CPTTheW+5Z3NROWNb0T66PzZjcp/tCBeQXV/7D
	t9t0Q7MA9Ki7JvSGuKmozBmVkGQpLMOCfcj8xrihs/sIzPrei8lAp3Iwvm9hOwNWP/cmQEt01u/
	pb3xMjlKm2QM4DgP21
X-Google-Smtp-Source: AGHT+IFaMdEkFpJsDrxKqD6MGwkR/CHIUDk8m65eyyRnB61EOkq9YBFq8EPCvyuftako93662DzzOQ==
X-Received: by 2002:a05:6000:2084:b0:401:e7a8:5c8d with SMTP id ffacd0b85a97d-42704d83e2bmr256901f8f.6.1760626978455;
        Thu, 16 Oct 2025 08:02:58 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114444b06sm33598495e9.12.2025.10.16.08.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:02:58 -0700 (PDT)
Message-ID: <d207997c-bd73-4dd0-ba0f-93b994b14196@linaro.org>
Date: Thu, 16 Oct 2025 16:02:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 mpetlan@redhat.com, irogers@google.com, linux-perf-users@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
 <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org> <aO0ci1wX-J3au0-p@x1>
 <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org>
 <CA+G8DhJnRB=d+pv0k=uzM18EmhFiQ+AiVu3rb8w=anNgJ=dr2g@mail.gmail.com>
 <abc1cb61-8169-4a26-9daf-264a6d94cc84@linaro.org>
 <CA+G8DhKDeg61ZM+Pzurnbvvs0L=mdxYhZZTMqfri1wf3AnFaeQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8DhKDeg61ZM+Pzurnbvvs0L=mdxYhZZTMqfri1wf3AnFaeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 3:59 pm, Anubhav Shelat wrote:
> On Thu, Oct 16, 2025 at 3:46 PM James Clark <james.clark@linaro.org> wrote:
>>
>> But the throttling fix was in 6.16, so I wouldn't expect it to work in 6.12.
> 
> This is using perf built from the upstream source so the patch is included.
> 

The throttling fix that was linked previously in the thread [1] was in 
the kernel though. Unless you are talking about a different patch than 
that one? And that patch is in Perf?

[1]: 
https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel.com/

