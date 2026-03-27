Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FD39B486
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619314; cv=none; b=OFnKNDy6eH78hiOOgCY2Ra/I4/Zgno5E9w+SAJuvA/NWtPIu9Rxwu6V04k4dJFLRFXjMTHdSEWIEPjZuzBojbZ+SX9zHnbrW3R6LlhknjT2nybEb8FkCvINsYj355WuEU5yKYncwr4yf5NiYcJ1+fzDK67WMNqRuelw6bGjEd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619314; c=relaxed/simple;
	bh=v/5hlIOW8qCPjIgfmcDgxik36K+rYeVBjtEOI2EqxM0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ooVCbZwcFDuQhxADcNrs8d2z8GX1aWKMIeTNsu7U4xXUpKVCU9lHV8addrBskM8KPr4Ca4SnP2Jam4e+7y+3H5imrGCjK9AY5+7RJQgf34qdaZu45pDmyWw2HYeQHS9vNlNM9sQjz5qUiv7iqhfiQf7LceXIhWm9disgsNhg9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQg2ocsb; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQg2ocsb"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-604f1bfed92so1126256137.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774619312; x=1775224112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2MsGrGdLsGOpHi+7v5lNT9Z4Ew2p2trijHpVq40QAM=;
        b=rQg2ocsb9TDXM5y9hVuU25lTWsvUw5ss6sg7vvzIy2aCSPm2MKXW8xoXJLu1V13Grj
         fgtHWFB31eHliWiZAXB4A6pToWZ8oovIGQemIIC5JY/2vFhepyNW5lizFej+N1j+pNB6
         tNCQf9g1ljvYK3nL9V4v1J8GRW21nMrYnNOXcV4VZC8mv0k0cMlqMH5fFuxKsUQ5ux/t
         twna/TLNGSnhcwPT8UNI+vYBF2fn+IZL6mEe9NKfZtBk1Tqv9dSN0Ly8RJGodrRwQQMF
         LD14OBV0OinRcFkGpyQGLvNl7n8r0KZtJ1LOMeAr2oekHanj67LStFGHWb/O1bzMccoy
         /xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774619312; x=1775224112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2MsGrGdLsGOpHi+7v5lNT9Z4Ew2p2trijHpVq40QAM=;
        b=nQaoO2B/0faC26hXB+JnTuRRYMLitmWryl8blqkhHn/jd95614xQviCpoG2Qe6D5Jx
         8DKCLFmEcsZbHHzWqh0cFkaS2dKUkdGD59iRMWxXdE/SYwKM/xqGpOEWqKT0b0mOeA3m
         eROb0UeuCzZizvl2JQFt07HJSWtKwIXODIcy2dqGTQ02BIaMHxgfMDrlw/R1fCPVZD52
         7wy1R4bniMf8PdJYtdMabi/YDJBEO94fuc2X79jJnm+Njh1bGaFIZHX9M6gntsvLm6ui
         BxsWEIhw/9SgpSVZ8F1xAyHB4jp9l8WkdAPuNPsSR+x5l99tY7b4h9LGXnuxVe+OMbCh
         zmeA==
X-Forwarded-Encrypted: i=1; AJvYcCVA1frprMY7kbBmfblSq4LfcqwR5Tk3j2IkZAdFfFuaVW/m2QtMA82AH7LMhXspe5VmS8+uMMKcxnWOsM06+U18@vger.kernel.org
X-Gm-Message-State: AOJu0YzoW+4wahvIV//M4AV6aQLjJdv1IkfDjl6zi86YF3MYZXYn6r4s
	LtrLeeB6il3Cf+Tohaw5/wIG9Ase+kzIOnSmiV0orWXCbIq0LhCNwKy9
X-Gm-Gg: ATEYQzwYd4KVlimVahCaht7U/tCr4G+ws90/mck7/e3xAdrLsIMyldGdqVvoesvBpQJ
	0SkVG4GfKyvZFs07LZqOJEIgfXaPVDnHcJzuS54MwmASIwtEv4uRUFcYZGqlcMQKAlvUzmNJA1J
	YMquv/6bq32yNRDCZgsDMPRnBZkYC6vryeNPDCSAmjqmHjuSPig79OMRXp/VfVGka0QZon1fPDE
	mUqs3YRUK6T7MjtQH2CablMfvp+VQbT+urCpxnOmXoumqW9BR5fhg2GiRb4lcRyhBoXt372JNdx
	G/vJAqBJLKXDjblztSHnn6HyiKD8JPmN5v1juNre3U2UnwbPAZ4lOGxAhLgNyW0VWttjsrIcIee
	nJSaTFd92Tno8fy3Gby9zKh9a+dwsWc8zqDNRWBYr4xRBtGqjr3bx5dNLPnru5QWn5s4MBjU7R/
	J2gv0so9gZ32tw0aX2HJ538VJmwDSoli/iGV1AYY/v
X-Received: by 2002:a05:6102:5e97:b0:602:6e95:bc97 with SMTP id ada2fe7eead31-604f927561cmr1070863137.20.1774619311916;
        Fri, 27 Mar 2026 06:48:31 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:388:90d0:41f1:18a0:a805:5cce:c5d3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951be56f28esm6871641241.10.2026.03.27.06.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 06:48:30 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:48:25 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Breno Leitao <leitao@debian.org>, Leo Yan <leo.yan@arm.com>,
 irogers@google.com, cme@kernel.org
CC: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Denis Yaroshevskiy <dyaroshev@meta.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
User-Agent: Thunderbird for Android
In-Reply-To: <acZcG634vXs2_EWj@gmail.com>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org> <20260325205914.GA356832@e132581.arm.com> <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com> <20260326163926.GB356832@e132581.arm.com> <acZcG634vXs2_EWj@gmail.com>
Message-ID: <5CAC1C39-9E69-4952-95CC-D84919D81F8A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 27, 2026 7:35:19 AM GMT-03:00, Breno Leitao <leitao@debian=2Eorg>=
 wrote:
>On Thu, Mar 26, 2026 at 04:39:26PM +0000, Leo Yan wrote:
>> On Wed, Mar 25, 2026 at 03:27:05PM -0700, Ian Rogers wrote:
>>
>> > From the stack trace I don't see anything that should allow this=2E
>> > Either the list of metrics is broken, or the struct metric_event's
>> > evsel is NULL=2E But that should never happen as we wouldn't have a
>> > metric at that point=2E The sorting shouldn't affect that=2E If you c=
an
>> > reproduce the issue, verbose logs may help=2E
>>
>> I believe I encountered a different issue, which is irrelevant to this
>> patch=2E  So Breno's patch is fine for me=2E
>
>That said, are there any concerns about merging this patch in its
>current form?

I guess not, will try and merge it later today for 7
0=2E

Thanks,

- Arnaldo 
