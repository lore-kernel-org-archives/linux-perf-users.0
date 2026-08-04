Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635C3E5EF1
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877589; cv=none; b=YQvgs4q5hd1oX+OfEl8HXYXO6l5BMjykOX7P+X8PQyxc9X2FSPg+/mrk1tDHU17P3SVNc/ZZdzClCbZ3KAyDIlk36pKw8BxxFUAtXwat8B2xw76Dv/Q3MkPDf1UJwcerdEWMknpxwR3EWRdo+SHfK71FL3zPSbgby/iuIIus3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877589; c=relaxed/simple;
	bh=pfxpbIeNFSc0ZoYnjnPfD4XHfZ+dclFczBOLL7vzNQ4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dqDWUvb8lNMNe7uvvF7eGuAru3eoRLrwjXYsmgvP8R1At0ZQ9zynxNBqPZaXa28CbKlnHih9U0BxIKr03Gk1RFbhLq8LfI/0Wci+MZ3PBUQstdohY6wPgXeOzbjHZxvSf3SqrEbhMMjuuLNQo3WPZVe4eymvdxfW6c5/teBqNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAxrX+kA; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAxrX+kA"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab4af22d09so332852b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Aug 2026 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785877587; x=1786482387; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i5gQ2rzJspE7/RJU8+W1PyPQZBbheaHsGbRmii6HKrA=;
        b=VAxrX+kA5FQwKeL5zZ9VscSZ9ZYnlN6k0HLBpqDAV1U028F5dQuAUi3W6WCaWpSzD7
         oktkwBhVvrbJ9Nenh67kHwEZW+eMlofty50B3CQk/m/J5u+INJkq6RmjzAXOomgY7ROg
         KHby4ZSeCHgVS4P7phUdcXmWnJN3ySMnXkRRgcL0OBdoeqbCUDHH9et3n+YMVcoiBMPJ
         nUCL8Pgl/8UirWZYl7x2Av2mh3G70Anvdz3+RQTag9dxzHiGDl/pm+WR4jSbd3n6n3vX
         Y8ET3vSwLdfYpjQu0Mg5wLZk8yEKcfiCNr9Tto/QD8hievdduOqqMWC8685g8+TmMA74
         K/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877587; x=1786482387;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5gQ2rzJspE7/RJU8+W1PyPQZBbheaHsGbRmii6HKrA=;
        b=pcyaUKaxLjh5e4jVTCt4RLXuQtyP3L/ustpRtMIwxrIpFhMc+TBVSPVVenAbj1Q+ou
         U/qykrifefF73oK/nTkw4gtfOGMXv83GELhI4CWy2ruvFlBa3LX4pNN4EsQZCtI1IfCM
         L+J6GKlQV1x1U2SwXprvu2LDbkxqOoESV3eT35oAzCGMTK81EwHOPWlwRJkPKBsODrxl
         xKaAqjHcYKS9kov6TQV6MuwsOF91VG9/VQfUSOwtHr6jGiXHwMrumJxd0MouL92y3tXF
         TuvkmkmLdK1KDqY+v8lPEvv2K3pW+unsXkwVCmuHow6BDVpR8JSwJxs2liOkyeZxnOSc
         2ZYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rof3CiH8NLxUUIHs1ayuunZBEXxqifsR/T6zV6D3rtbnguRtR76P0jdwClH2GVOGy+xjz6EUEP9GvQsTloGtYgf@vger.kernel.org
X-Gm-Message-State: AOJu0YzZp5W9jle4YNWY2C2wzfU7oUkj6nuKjdIUJfT0p9Lxrm6p+jJ8
	qqAx241xQSV6Gzn3NQh7LL5oZEgmjlflGyPOLc53r67DKOlNDRNz1FNnCxeRJaoZXhsLaFmYUyK
	S4fpdZAMFD+NmbnmIEoFJkJ0A9w==
X-Received: from ilhw4.prod.google.com ([2002:a92:ad04:0:b0:507:c444:90fb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1587:b0:487:61da:70fb with SMTP id 5614622812f47-4afae0c7caamr886481b6e.10.1785877586456;
 Tue, 04 Aug 2026 14:06:26 -0700 (PDT)
Date: Tue, 04 Aug 2026 21:06:25 +0000
In-Reply-To: <2941da1a-b0b4-47a6-b57c-b28703dc0454@linaro.org> (message from
 James Clark on Mon, 27 Jul 2026 12:04:17 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntse4tvbn2.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v8 00/21] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: James Clark <james.clark@linaro.org>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

James Clark <james.clark@linaro.org> writes:

> On 23/07/2026 9:57 pm, Colton Lewis wrote:
>> James Clark <james.clark@linaro.org> writes:
>>>>> When running the guest on a single CPU I get different counts for the
>>>>> same event for a single process, although this never happens on a  
>>>>> host.
>>>>> I think there might even be some Perf tests which expect them to be  
>>>>> the
>>>>> same, and this doesn't depend on whether any events are running on the
>>>>> host or not. Not sure if you ran all the Perf selftests in a guest or
>>>>> not?

>>>> I'll investigate but I'm not sure perf is intended to guarantee
>>>> that. perf stat just runs the event counters but may not write or read
>>>> them at exactly the same time.


>>> Is that true? The perf core calls perf_pmu_disable() when a process is
>>> scheduled out before reading the count of each event of that process in
>>> an inner loop. The perf_pmu_disable() clears PMCR_EL0.E which freezes
>>> all of the counters so they can be read out in a consistent state.

>>> It's important that they're all stopped at the same time because
>>> counters might be used in metrics as ratios of each other. So I think
>>> it's deliberately designed that way and appears to not be working in a
>>> guest now.

>> By default I think perf assumes events can be measured independently, If
>> you want to guarantee events are scheduled together to avoid measurement
>> skew you need to make sure the events are grouped.

>> The common way to do that is with {} around the event list:

>> perf stat -e {branches,branches}

>> Please see if that resolves the issue.


> Groups only change how the events are scheduled, not how the driver
> starts or stops multiple events running on the same PMU (grouped or
> ungrouped). In my repro I had less events than counters in HW, so they
> will always be scheduled at the same time regardless of grouping.

> I did notice something extra though, you have to first open some amount
> of counters, and then open more than that. Then the second time the ones
> with different counts will be however many were opened first time, as if
> some state has stuck.

> For example if I open two counters then 6, the first two always have
> different counts the second time:

>     $ perf stat -e branches,branches true

>     Performance counter stats for 'true':

>               106129      branches

>               106129      branches



>     $ perf stat -e
> '{branches,branches,branches,branches,branches,branches}' true

>     Performance counter stats for 'true':

>               117013      branches

>               117013      branches

>               110364      branches

>               110364      branches

>               110364      branches

>               110364      branches


> After opening 6 again a third time they'll all have the same counts.

Interesting. Thanks. To clarify, is this happening in the host or VM?
