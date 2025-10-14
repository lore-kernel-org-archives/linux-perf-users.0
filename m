Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB035313E08
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445320; cv=none; b=j2K7LVBtANgV+S6EiZiyPSz8za9+3mpbotNqR/2k3Mbth+YWf9qz5UTKR8O3i761jL+GLpyQsImdx0kEkJKGw1JrIyRiEJaIY/SVMEQCuZuDkUFq7ugfVgckmA0Z6UTYS4EhECw+xthTRwNVPcGY0sN2SbwboWp5k68tVcsCNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445320; c=relaxed/simple;
	bh=hDd2eGJu7GhjVZljbuDAEPwmscHy3Q+LnSCyF7CfxnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTKo62KVAbH8+mL9DZLTwKVjr/flWbMnbxI7Ug2TjsV8/MhU/bbwmPXZYIabiTz/KDPB8+OWMcsSNjveDTVo2t3ozP2PZOMxq9kQXC414XDD2Z7xcfZKnjnkIgT2Px1btdDPWUYzZQhb/4MkZpRWGz5zVEWetXsafKqlvdzp0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VBf9I9dQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VBf9I9dQ"
Message-ID: <da9d29d1-ecfe-4d0a-8e13-aa13f0620d0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760445306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOdsdiGzhlT0IMy6VMm3bVjfGtCfa0IiauUj80YM3QA=;
	b=VBf9I9dQAhtsaQD5qmzCNPdMUR/tKiTrN8BXd7P+SupykD8BjXos7Rj7EFvUYX2bCwCcJr
	qJGFwLYI3nAc8CHGaudnbOUdH4JRwosJWLZu1cBQvEnfeMrTS9qZO3GVrftve3R1PvBgIE
	PAJ01clUooODCuceW3HsGobc1tyU5gc=
Date: Tue, 14 Oct 2025 20:34:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to
 get_perf_callchain
To: Jiri Olsa <olsajiri@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aO4-jAA5RIUY2yxc@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/14 20:14, Jiri Olsa 写道:
>> +	struct bpf_perf_callchain_entry entry = { 0 };
> so IIUC having entries on stack we do not need to do preempt_disable
> you had in the previous version, right?
> 

Yes, i think so, preempt_disable seems unnecessary.

> I saw Andrii's justification to have this on the stack, I think it's
> fine, but does it have to be initialized? it seems that only used
> entries are copied to map

That makes sense. Removing it definitely looks better.

-- 
Best Regards
Tao Chen
