Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7463126DA
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502856; cv=none; b=s9vvJJZmuWZ81G+xGrZhlT//9HQNlRvIdft9JCSRT7HEpJMGI1Px4v2P8nN3IJTrdYMQQPifpdoem99iSI/1Luu0bZBuJpFyRAoFw4WAc5bHZNCaydo7TqlSMrKkYnweVYWzhdFhyi8wNW5dJa9zzEo4/rqyezby4wF2FC3zKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502856; c=relaxed/simple;
	bh=4OBZ2ZfKsExYLPiXZhnyp4Ky5O+dJ7H0S4S55ZV3fVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=arPywQRKQKOVMMRl/PEVLOwe7lAMwZJuJU3RA4EsS/Mv9l/tORPhD86ybqoNMSD1L+/osJita2hBZsBItbdomx6Yqq5wYE5h5Mv/9tvRLRgbA4h0CZvRP2r0hOvuuFL6xFXxtqkE//+jmhqctlza8H1u+Eb7h4AdqTe7evv3PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbhzhbfA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbhzhbfA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb5492350so44095985e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757502853; x=1758107653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3OQu9v7444v/noKKraVi4jc91DRs3isyorMMbC0SUY=;
        b=cbhzhbfALaQnnWzjVxOUJel//fGecYdcGBFeUwvaOTeyowf26l8mQOS8fyyeZ6h8kO
         ixUxTNzm7m0VqhL70rAgSAg3fz+HMsjZY6w8eA6EHe4+kkJwhksvrXbxta3h3JLzysSY
         F6ROmmjY1S6Cug2sEVTTQRn9BWFF2H8ZWen0RKuD/Ch0HZ+RWnYTTNB1709cB3PwrBmp
         YORw7OchwmTpkiI9SijTxi25KTiwFhsY6KMAW8xHaximR7Quli3Tg/pNBxvgFKx4H1pX
         tNDQ4+CoYJO8+jazN817aVSsUiUyqL0uO5r9YPXYgLSZWVQFe94eXFguxegOtaiWjHPz
         m9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502853; x=1758107653;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3OQu9v7444v/noKKraVi4jc91DRs3isyorMMbC0SUY=;
        b=LYVc5sGmzCh5ilI843eGvI3ZbxKsYOVZOUinCsEI4LEyOo99QtYOPbBla9lbKTuYBd
         aT2Q9+VfpK9OZX/nkc8SErqHb2i5qJo2NQr1gogUSMSHWyMZo63IEWKt8b9WYZ0Otb9k
         IwR9i6lLD6wWKW1v0n+s8hC/V7pGBpvtjh2oJCPZI4n0dVqhRLstBq3P8V5vpHpITEU4
         9oA2m+0dwvAkLl12gDCfAesTllqs5nekGCClQBYBJzniE5EJtKxvGACF0Um5RqKw5128
         DIrwfEY8TUQxUaDnWVf/LFREkYfbGce1s6X8l6uWPeLqQQkjDnyHbHrG4XLv2EGlqsjz
         AJAg==
X-Forwarded-Encrypted: i=1; AJvYcCXC8LmOb0wRsHQ/2l74Nj9O0vkI5U2WBZYNzWncNfZ9jpQhMjmP7ct3iYWbVligak6UnwbxJehU11ARA+hRF2vD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4FABb9Cw72rsxfch9lRl6IRFx8P6/RSiHNQeBh/KRg4kbJdWL
	QNIIc5zRuR3r9km9pWvmib0ICWetBBZWdg0l6p6xlI+qs0nqYLia8MocniUxfei9OtM=
X-Gm-Gg: ASbGncusoj5t3yTFOdeYI1SgbcyxgPmVRkJbOFlLuGeYXjAhM72r+1f7YK6IntHn0pt
	wIyrtDm9Tbg+7hJtDQVB9LFfbqFLruC40wGlmkorv5bW4zPzOmO1ODeDSZFGHx8F7iAGRkpg2zJ
	oVTgTEF1Ft5nOxr/+UelDACRzB8fSV9XptshEBxHKsj8ZcHI9fMYg06SYDhDRUmca3QJQwUUb0x
	Cd1csjCmQRec6iu95z8OyQajBlLdgBsa9JJk/RdgnZ1h8pa9tW+vfDygA7zkHKfRlxmiEFscy+6
	QTpdtGHDkikhh8z7mRIN/jNZsceqVwBU6DIL2fTqnsd2ixVKwRf3HnRw8s8nxTACXcAGcuuEdFP
	aKhV7NzD38JTqtGJDxYEdvCOYeZCd0QRI0OX1xQ==
X-Google-Smtp-Source: AGHT+IE9s13i7j3TkMJ++FVCyif8BAKmecMcfB9JJQFyKeNZbnaim6+3ufJHKPlruBr5wa8K36udJw==
X-Received: by 2002:a05:600c:4692:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45dddeb907dmr132007665e9.13.1757502853033;
        Wed, 10 Sep 2025 04:14:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf85esm6721413f8f.1.2025.09.10.04.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:14:12 -0700 (PDT)
Message-ID: <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
Date: Wed, 10 Sep 2025 12:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
References: <20250828205930.4007284-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/08/2025 9:59 pm, Ian Rogers wrote:
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
> event on all PMUs.

Hi Ian,

Briefly testing perf record and perf stat seem to work now. i.e "perf 
record -e cycles" doesn't fail and just skips the uncore cycles event. 
And "perf stat" now includes the uncore cycles event which I think is 
harmless.

But there are a few perf test failures. For example "test event parsing":

   evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
     misses,branch-misses}'
   FAILED tests/parse-events.c:1589 wrong number of entries
   Event test failure: test 57 '{cycles,cache-misses,branch-
     misses}:e'running test 58 'cycles/name=name/'

The tests "Perf time to TSC" and "Use a dummy software event to keep 
tracking" are using libperf to open the cycles event as a sampling event 
which now fails. It seems like we've fixed Perf record to ignore this 
failure, but we didn't think about libperf until now.

Thanks
James

