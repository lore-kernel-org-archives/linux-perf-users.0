Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F12F6164
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921581; cv=none; b=e9XKRa30/9NrJjZgZKYz7XrjksNeQbW4ypMG234460x1ZYnSIoDEBbbshA0ldH+DsrlTgjpm4Re43ngXIxP+v6kRktbSstqIJsRgGjIc+orW7ZZstmIkBRLW5KBRZsFB1rLbEUmMLR0NJ9zQlh6sbBz+BIy9yn0hwyfd9wqs0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921581; c=relaxed/simple;
	bh=rcwtB4rVyCBzKNTcc0KmvFQOQiz2Q3Ry7cOYyj+n2BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q5siI1R2VVRMT/qtrhJmdsDr4kCpYQmj0qcafZE4Mp+QTFT0ZEdeiaOel0auHjS7CVT/18Eu0FUh51UBFeHCJv/4A8LL3Zk7+NDpfct8cK9QcshMBpLACAnxt7zaRaqjhlzmQk5b6J58VFxrUR19Ft2t74ZOiTRK9D6xRxe8xDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fk1SIjNC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk1SIjNC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42420c7de22so3921514f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759921577; x=1760526377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9skgAXCV5SdOI7tzHYlaMNV43kkRs+2XgsWaNKtkOk=;
        b=Fk1SIjNCrHv0AxtqYk2mp3gjmEcQ6zcKnSkltZ5aawyp3tkWuoysQohc1wQUHkkxAW
         3u2vs8e91wf6Wa3Sz81XMBR0uLWnE22r9PMzfDBcHGeFG+wOAKiD/F52LihigHvOgbkN
         eAKR9gZGv6shkuluRUWJX0FbCa2W/AckgWDRCJxy8Mlo1HJC+tvjWgDOmKgKiezWbAUW
         vwbhn6elwbrnD5DKau19HrU/lWnS4AiJ2TbTtigM6d8YnPAt9KjxrjN5NaQeIif7SDnD
         mcOMP8hAgd+CdS5qcwpBg4wwIyHR24XLXZTOcOvNn8424A5paI1M3D+VrpJqF9i7FIfk
         GMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759921577; x=1760526377;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9skgAXCV5SdOI7tzHYlaMNV43kkRs+2XgsWaNKtkOk=;
        b=IcdAEmynf+Hbb6TvuuIItIEqWB2+M2AOZ5jRXSaq/DSOxuH5YT0VFq4r+iusifexsD
         wto2BeTbez26zeCiCx7VBZeuRDU9Ti4Kt9IQjsNyk/zy7aMmr5p8KR9eojeffaayqUZd
         9lrvYaAEtSsyOP2LSMHmTmjknrhPkZCYOqh5kEHIoIxTP3hdxrhEg9UoW/Lo6Ri3sufE
         bAdLj86eTFFWZCOh6/LnNPIL18gRCyJzYg1WDTG/+SkeRU00ZhCoUMK7grtwwDc3sMjP
         AP/OLxoVJa3zF3kVujizJFEM2/kWVJLSPld29/nSCacTcgoJdFvxUDhjroxf7h1RiFLp
         rGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG9YEfMUHRRDPD17IAB4Br2vbY0EN/qXQJhPoOwNx2AVKkGfDR1XTC+ukZVgFRgvoY1MQ4raiQOOAFm9Ir7+x7@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCMWbEK1tFPehX+De3+BzW+envPFiJW0Br/9pHg5lgn99Zl9Y
	1Qd9Jsd3OSq0ktgk1Y976T6fqu6cI7M2XRR/UtK2kgdiXa0Lf1MnAj4glQLyBdr+qYg=
X-Gm-Gg: ASbGncv0L/FQhDSPTUN+unpKgTmMHenw77UsNNumgzon8L1mmARtyVy3daTmU1Omvgi
	PbL+Isuaxr/aPD3wQgLVyZRNBsYCI0Ui4J+6ougAYZRpAvVa1ScBoEcIJARheIlBrz9wDyinEOk
	kTob4WHHr5dPqnbo9+bK/pZErI3zexBbFPtv1SqEUa9mUMcOoYbcIY3LkOREfKJLO/dNgU0xntM
	XfRxrUJX9wWgwN/xsERE1ZD2sUd7S5/wwFkgvkKGNye/PHc1ifYTmd8/51DecUfHJc4q9Fqyz7i
	QnWxRUUNz0ZrPCrGoGPV/c9qqgJXzSuXo7R8V6/J2V8oG/Woe5Y7KfocKzUpIBaBWE++4scnQ9y
	rk3oQ+tVkcvfk6CXA16X8pn7Tk7xE55z8riOr++3V6Z6lAXLetwimWPnoblgiEVkkfcQ=
X-Google-Smtp-Source: AGHT+IFCaW9bqzii0o/1hvZKcttM6MZo9qaAIXOGfzuzrPpIJh30cCzasApmxEzd6HrEw7WMhn6Zsg==
X-Received: by 2002:a05:6000:2c0d:b0:3e2:da00:44af with SMTP id ffacd0b85a97d-4266e8d8d0dmr1918170f8f.36.1759921576763;
        Wed, 08 Oct 2025 04:06:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42585989607sm6721887f8f.53.2025.10.08.04.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:06:16 -0700 (PDT)
Message-ID: <8ddd5f97-79a9-4608-8a40-871fb70f2725@linaro.org>
Date: Wed, 8 Oct 2025 12:06:14 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
References: <20251005182430.2791371-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/10/2025 7:24 pm, Ian Rogers wrote:
> Mirroring similar work for software events in commit 6e9fa4131abb
> ("perf parse-events: Remove non-json software events"). These changes
> migrate the legacy hardware and cache events to json.  With no hard
> coded legacy hardware or cache events the wild card, case
> insensitivity, etc. is consistent for events. This does, however, mean
> events like cycles will wild card against all PMUs. A change doing the
> same was originally posted and merged from:
> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> his dislike for the cycles behavior on ARM with perf record. Earlier
> patches in this series make perf record event opening failures
> non-fatal and hide the cycles event's failure to open on ARM in perf
> record, so it is expected the behavior will now be transparent in perf
> record on ARM. perf stat with a cycles event will wildcard open the
> event on all PMUs, however, with default events the cycles event will
> only be opened on core PMUs.
> 

Hi Ian,

The previous issues seem to be fixed, I don't see any Perf test 
regressions or issues when there is an uncore PMU with a cycles event.

Tested-by: James Clark <james.clark@linaro.org>


