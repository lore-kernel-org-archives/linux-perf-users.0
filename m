Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9852E6105
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435980; cv=none; b=CoID/KTKuQh922hNikzCe7gE3YdAAMigVh20tZNfOR7g7sCP7yjlBKSGu3cEwFeF5Dfw0Cf177jmfXmfV+dm+2+fh/k9FFi+S1kxCStWf04LRMDudDLwJmItB5WaWD95VLQf+JET8GMGWZs5n3JD1Up/PBJNPsGE1sMizHIXpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435980; c=relaxed/simple;
	bh=o/PDhYBLFV0Jd9O/4xdvr//PP/eZn5Jae6HmO5vzAHg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bgbSjIwqr5Y/gXEWJBGPJqYuPW8SYSCyJx0+W1Rjf3qEh7NdMQRyGfjN9oLiKfOSNOLI+UeLm1COR3VjjNzbdn9ipkcMLQxJP/X1z8QpLH+7YOg7Ml7dt4EwaKQsGktVL5LCj18VaEr6oXw+D97/Xi0d51r3EBDMy6ZEpbyH4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=IR5IsCJi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="IR5IsCJi"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so16069286d6.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750435978; x=1751040778; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/PDhYBLFV0Jd9O/4xdvr//PP/eZn5Jae6HmO5vzAHg=;
        b=IR5IsCJiXK6NqolsSkyec3JLjvgKNbL2IgKEwOrH31h0lFYQ/dI5dU3B9+grzUbi7G
         DvYh41YNnkcBFq/YAZWB+fpG6hwPYG5nai0DnE9T5oCxBSgBP8ITgaHh2bMEHrRcBb9H
         QbIG4L7WxAgIC04aL/++f/zgjLigIKoce0HgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435978; x=1751040778;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/PDhYBLFV0Jd9O/4xdvr//PP/eZn5Jae6HmO5vzAHg=;
        b=L+FkytxXxHGqnUo6pnEvilHnxD0/zH+PovVOsoVSJzIm92vuDNufgm2Liyq6wYwegC
         4pUuW6Cvm1QTcD/wVhxsrTC7k2Jy+kW9XkdGbcPVBhNVGUsoy/t2Pnd+iyoTBWtcszFf
         Z7Vfk1akqGo6LomqIqgtG5cBPdi6dgULoB0pDa/W7m8iG3U7aFdLEorY5V81Ul3Tmtlw
         6QzHw5SFa1TwgIfDSb5sGPD80RHdLIXcAY8eH0OCbEc2gzIMexaNTBhAZI5MZ169Niu1
         5et24nR1XTI0UdVYQ5xa9HjjMsYTCA38199v3lz66ZWbzzenVz0no/LOk6GoyEWGlI5+
         bFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb1wQmJi12FSDd17ou/LfQTxhgv+jBfMljkpkCPXNBcQtTdvwEZbUSIgJDZyAZ+RZoETR3u0KWFavhhuBbF1Pn@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8CLV7SgiyikkPz3RyHpOgEZGonD+SWQwahk4NKdbct70kBrv
	3mueLp1R8FOsPaYKdx7IieJW+g9kZj79+bcVXIh/ZKhrv6scOdC4mYaR9VFyGLx78ZdpuE6sRIh
	+B7o=
X-Gm-Gg: ASbGncvLHTvnTMCAZ0/c1AYLBXGds1FmIXXZYsZ1aZhMxbyhKovOBATb6M/KCmXIzTx
	85cxx/MjzMzZYE544RB7sbtlPRD9VUvU/8hnrdHR0ARFpkzd2vQpze0qnmQTZAYbnAc0+xuSTbX
	a/16KrSQJpMpAoBnizQz0A+7eQnd9emIBzNaQ/tGovcZcoDd0sxFyWwTn9rk0wKB83IVKnvYBtA
	sfh3PDNMMUV78JgXP3mfOCykUX9+9Kdi125RbnBzjZRpVbGMa6PcFAv9d79HD1mO4OC0I2Kh3v+
	Izr0AUiMTMONLQHK5mx6KywzQ7RIjHH0j0ELQninpr7tKLmIGO6Qca69lkOItFgjDzFIyh44y4J
	KNrxw0Q==
X-Google-Smtp-Source: AGHT+IGoovvsl19mY0vCtYhvu9E/Pp3ZVzXJ4Ykxp/GDEUA/7TwOQGC7TYT+H9Qq8AVH2lCTzNqJTQ==
X-Received: by 2002:a05:6214:2627:b0:6fa:c0ca:c75c with SMTP id 6a1803df08f44-6fd0a5fff0fmr62574406d6.42.1750435976837;
        Fri, 20 Jun 2025 09:12:56 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decfbsm13710906d6.11.2025.06.20.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:12:56 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 20 Jun 2025 12:12:55 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
In-Reply-To: <ef72c8cd-5bed-44ce-b950-d64dc1c22baa@linux.intel.com>
Message-ID: <5a53490f-d4ec-85f7-4175-e148e02c3e67@maine.edu>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu> <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com> <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu> <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com> <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
 <52656281-ab73-baf7-0a80-ebcbe79dfca2@maine.edu> <9aee2b65-e43a-4fcd-a929-a98269621315@linux.intel.com> <d12d4300-9926-5e58-6515-a53cb5c7bee0@maine.edu> <ef72c8cd-5bed-44ce-b950-d64dc1c22baa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 20 Jun 2025, Liang, Kan wrote:

> Thanks very much for the reproducer! The issue has been root-caused.
> I've sent a patch to fix it. Please give it a try.
> https://lore.kernel.org/lkml/20250620110406.3782402-1-kan.liang@linux.intel.com/

I've applied the patch and can no longer generat the issue with my tests.

Thanks!

Vince

Tested-by: Vince Weaver <vincent.weaver@maine.edu>
