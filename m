Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD018E1A;
	Tue, 15 Apr 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726967; cv=none; b=DGH/ag+NfGxv3DkvsjT+3t40FG+bHmHiIKTDqFZ1OCx9RD2wSVSMFZ5vtHLWIDck6bfO8PO2aJH3brVC8NOUTcEUwO37uoQLO8wOCjIdYh6FuTbN2rU95y6KUCVIy59+ZVGR95WFvP/L12JVWVm/bQVpoTiXiHy92V2Og++31Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726967; c=relaxed/simple;
	bh=CtgxB/ZU4v9c0Nr/WCLB1gJC7TJjSTsmSFedm+T4dNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cRXyOBlsOydTYMjEJvFpRQ68gtSrko5iiXFL7ECWC3QxM9kSkfkzitm4LuzGMiAdSEtCuaRBZ6NTOKDAjvVgw1YYcZ0Ezhauu9Mz9JaVoRuB5cqn5oPGNCwSuaLcfEU30KXkll7i2kuIOtaZt6ZOocKTvOB6Om8X5o9gMRKj1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM6IfmKt; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM6IfmKt"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2279915e06eso60170385ad.1;
        Tue, 15 Apr 2025 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744726965; x=1745331765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmJxWfWHA7bnPsHWZ3AfA94kON1Er5HrsuLi+dRB8to=;
        b=jM6IfmKtPCHyC0+ri/8uaL1M7LRYJSXPzu5nK6vCoa32sNsGEN9bzH8Bu7adMfZHXv
         y0HsV70PiNa5qizCGRGmhGQxE2+iLc6hTHNztk2PlacTybGGi6tdSRjAACXRoALki7uI
         iy2v0zFZEkqnpZptjCyghzsIYvKfeipwhsb7QABQ1PRcByA2arCNJqpFl+0gb8mv/XZy
         26fyepYaV88FCRxGc8ELgfKn31Kh/v3NBe1UU+fY9wVmU4gFDQ+6g5ta9pBXXjpudDSV
         mAtUfKvlSd3NhwRMbH0c7D4aIShN6PJy0yxTWpvtrguRkwMvlMjQvAAc9hyRLM5Q8RKf
         nWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744726965; x=1745331765;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GmJxWfWHA7bnPsHWZ3AfA94kON1Er5HrsuLi+dRB8to=;
        b=XIiCJxtjuGYXpjzscLMYDFU222doAVTqoc2uleQpkEbJKxwxkTzxDLCieXwCdWdDdY
         mE59fCqIvxosqbW5XFVNDmpAgvTiqjcMwfaDtP/X1GamINvuzx5Wt8rLs5fcYchOZ+LN
         ZtjINTccd5kCDMaT8EYs2ypb8VQ4rIkc69Kf34agxTPwRge+5TsTu9xfh5vYGo/RLdjO
         lnf8LvRsMTygFqZmuyMVq/URnP/kAtrAqgR01fscNWTOVZJKiHF9PZBacuLxucdFwLx6
         SCSS72FT2NMpUwB/Dn5zGvQxvKLI8hIQvE4QBKsFtwUmYPI81+ca8tGpPJS7Vcycliyv
         hUsg==
X-Forwarded-Encrypted: i=1; AJvYcCWfOmu4zPmD0q0pX3Ix8GqbwRj5I7NmRZ7GS0AkoOSPEOlsBu6g5gXIcHb8aFge8JjtsPvh8uaEJJh/FEgSQKt7DA==@vger.kernel.org, AJvYcCXuJqJYJisi9276xOj072JpAcsFYBYzJY0I9d6/hXTW8tnru9xs7q0Jqy10wycfadHIrg9/AOJ8w4Kivh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysa8CzvTj8QygHNGzD3UD/vk3ehL7OXvVBWf2oXH32yigP0wW3
	vPrmaz1nB8YrxgMZ9JezO+0ppX7bwLeqG5nmZG5m7YU4oBTGEY2/
X-Gm-Gg: ASbGncu6TshzvfRDabpj33HCEP3PtAXfNSuhRmxz+LDBwcOOWJK9SpUNZ9ZXSPovLhw
	D4wZuxBdsuE9j52hbJ+oZvSM/wMMJoVvtsFlivmpmUdNiwHLRP6oZADn38HBxabmQoRKIf3kJOL
	vtpze2eS1n1YGxcg5oZ5dCycthMGRzBAfTpV9J4zBBQuF143HEa42BUkvTOi0mTT1d3HtKR5nAl
	nZQGlgi3Ekfnf4vCrzYSiFgl2kcoS8xqFJAiH9KEFvhOyfD69Nc2VbYE0i+gYtZ77K2mR1GWcjN
	DWb+vTokn8xWcVW6/JmbgcGscBpSuqYnTDH8foDvFNg9HYmOdGC4sgbEXAC+
X-Google-Smtp-Source: AGHT+IFUTNEsWmG+rj7RI8gnYBKjkocJNOCNTmcoqNItsoBYPvpDOGyAMAepGC7aSX/Ic3G5GBsLlQ==
X-Received: by 2002:a17:903:2f8e:b0:223:6657:5001 with SMTP id d9443c01a7336-22bea4f04a8mr279941955ad.40.1744726964722;
        Tue, 15 Apr 2025 07:22:44 -0700 (PDT)
Received: from [192.168.3.3] ([27.38.215.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6508esm117901735ad.52.2025.04.15.07.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:22:44 -0700 (PDT)
Message-ID: <c4d3cd8f-7d9e-4827-b9e8-4ca8d7b9946d@gmail.com>
Date: Tue, 15 Apr 2025 22:22:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf/core: Fix broken throttling bugs
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250405141635.243786-1-wangqing7171@gmail.com>
From: Qing Wang <wangqing7171@gmail.com>
In-Reply-To: <20250405141635.243786-1-wangqing7171@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

PING.

Thanks,
Qing.

On 4/5/2025 10:16 PM, Qing Wong wrote:
> From: Qing Wang <wangqing7171@gmail.com>
>
> There is a bug that broken throttling, this patchset intends
> to improve the accuracy of throttling.
>
> This patchset does two changes:
>    - Revert a specific patch to avoid broken throttling when
>      max_samples_per_tick>1.
>    - Add throttling judgement when max_samples_per_tick=1.
>
> base-commit: acc4d5ff0b61
>
> Qing Wang (2):
>    Revert "perf/core: Fix hardlockup failure caused by perf throttle"
>    perf/core: Fix broken throttling when max_samples_per_tick=1
>
>   kernel/events/core.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
