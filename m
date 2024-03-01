Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204EF9FD
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311206; cv=none; b=mXUwlbviv/WsgiLMEAfww+sYCT8EHYeOVCkV3NVN8GsJRk6qWLju22vtywWtLOFVVtfBn2LmYt2ur0kGTm0wDGRRVERwNN4i5sPVp+sdsD1+XPm2LNC/ls3b+1XrX9o1NukDMPPppFnvdH6zuQ7R1+hcnlhkWAPDDQcQCe8qE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311206; c=relaxed/simple;
	bh=gZv9ZVm2Y/YJWkqC68fwBWPcxyg0G+3yV6nrkCH4dtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDcofdKR5lcJsbglQoWvvgzG8PrNHWNFzFL7ozQYPZlQWkWNfHNdC5lRhKrvPTB5TzqacmMOEJQG8gCgJMyi/OgaD03uGI5PrB8T7otf939Idb/MclhtquZ0YA7Rpl9utyN6Oys4Vfiuh/oUP83qalqjxQD8hrqQRpE1DEuv5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbx0afDH; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbx0afDH"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3650be5157fso172535ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709311204; x=1709916004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Iz8VtV+mrAqmT+Yd+rcCtPv1t4xoF3O9HUxQFtiwYg=;
        b=tbx0afDHqNU7Atji/Hk4INNkkJ6qAxU3Bg6UINSILPRvNDwZyVL7vWwjWfI3YbuMnS
         QFkZvtL5qRK6kBEbOSbALAbc1o+y16POptDhmgRfO8hCkKlIKouwgTMaHuUjOdf3r8mS
         ZaOO6kM676gORaBomJs6JOPsAknOnvVJUKn86WBQ41ua+mD1ACXq4VW2VSWtf5O9c9yO
         lwt801wmPbAiEVByugI1f+ZLdYTEOe4v9EdI8a6H5qQ3E8cDQ/Pm0uF0ODfy0Mimo/FG
         l8xQBvUOLRtSbgYdzls7VALTOBgLVA50OIT4Yr/jt8b6it5XmQFDf0Ecj3u5oFvisd+K
         gyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311204; x=1709916004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Iz8VtV+mrAqmT+Yd+rcCtPv1t4xoF3O9HUxQFtiwYg=;
        b=EXmc9rO0AcZ6XOrJBzhnWmHBXEI38nEwaOLdB0Xx4LSfWrpvIqMARDbp9w8CH0CQU8
         pKc8odlK8WwUrVKoJEeTTn366F0gzF90QX90BKEWasXzchE9asTNXbbKD7/VB4cSFYcV
         CKn/1/TvlU2ehby0Q7qxARA6zF1FE7qLfTTsMxB0AL4P4v4m6S4Ynpeqrp7K1R3nQUpP
         NhH59f8g/O1H64xiUPV2sGIsjw9k3g7rDr5oqulyyCRU2iTlrcSPTAgeNtyBK9l7v4Z6
         nda30FApLqexUbwX4jx/RJEhZaCysIqtcrNsk5OKrp87Mg5O7fuLTp48FW+Y19hkVoj5
         sZMg==
X-Gm-Message-State: AOJu0YxvoC2aK8+ctwBYMH6Amk3WyPxULRrbtGyclcnpaGo78RGHOWbb
	VKTTpCUv04IyXisM6YQYeUpl6ReueWyoR9cTv32c8cq95g0ydQIV0cSE1WyAZFQjFoQksY3X3ku
	NmAfOEvFhKPY7Wk53BidiBWgnjl0m9XbCPoTX
X-Google-Smtp-Source: AGHT+IFhKuMkCMVygmw7wOWmjh+fqlQG1IchTKTj3q1zr5rHxYjNFVMGcW4VP+Ggz34Rx1p4O+y00HjkGptVTU/gOiM=
X-Received: by 2002:a05:6e02:1a8d:b0:365:16d5:4b11 with SMTP id
 k13-20020a056e021a8d00b0036516d54b11mr191985ilv.3.1709311203702; Fri, 01 Mar
 2024 08:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301084431.646221-1-sandipan.das@amd.com>
In-Reply-To: <20240301084431.646221-1-sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 08:39:52 -0800
Message-ID: <CAP-5=fV49j-fMSF5PcAXP7hoD4guqy8DnQs_uJWcgVM7fKxLhQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events amd: Fix Zen 4 cache latency events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	eranian@google.com, adrian.hunter@intel.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:44=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> L3PMCx0AC and L3PMCx0AD, used in l3_xi_sampled_latency* events, have a
> quirk that requires them to be programmed with SliceId set to 0x3.
> Without this, the events do not count at all and affects dependent
> metrics such as l3_read_miss_latency.
>
> If ThreadMask is not specified, the amd-uncore driver internally sets
> ThreadMask to 0x3, EnAllCores to 0x1 and EnAllSlices to 0x1 but does
> not set SliceId. Since SliceId must also be set to 0x3 in this case,
> specify all the other fields explicitly.
>
> E.g.
>
>   $ sudo perf stat -e l3_xi_sampled_latency.all,l3_xi_sampled_latency_req=
uests.all -a sleep 1
>
> Before:
>
>    Performance counter stats for 'system wide':
>
>                    0      l3_xi_sampled_latency.all
>                    0      l3_xi_sampled_latency_requests.all
>
>          1.005155399 seconds time elapsed
>
> After:
>
>    Performance counter stats for 'system wide':
>
>              921,446      l3_xi_sampled_latency.all
>               54,210      l3_xi_sampled_latency_requests.all
>
>          1.005664472 seconds time elapsed
>
> Fixes: 5b2ca349c313 ("perf vendor events amd: Add Zen 4 uncore events")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
