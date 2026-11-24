Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519481;
	b=Y5bwnNyOsPt3lAUwyEIXeTkvtE+Qz8rt7op30l4uQxArSwWvtM44wx1vrf6assUyoXt6
	 qcsWRIq1Bi0xULtX2Y6kvdILK/tErZBJtwjLcCxGth5l3VL728G+oR3OXmqvWgyf1Cgqa
	 mm6sTZVeww+HVkx+VIyCE8m9/cGOepI0pXIVzaUYvD64xgHmBjdF3Ec4SXaJMjubEJb1o
	 C9wV+Kg07NoeNvxtgL1pydQSEPpADzwagp5kjmZBOWjJ3ybo5ZlF3n3r6MqyYEqVyJvDN
	 PQPeUg2ATOwyuMZdeRg/zNXa42BW3SDrtFx+EPqYeH8fdqVpmuUkCcXchEIt1jkjsqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RzFMb3TtzuucWHVLWCFL8thSDn33UJo8KWwaTHZ5em4=;
	b=rarWtT6Bak3fOoyL9Vkl9PS1T7jffUNV47xKeEAIxjrZex21vo3R6ZeK4E0huZ+W3aLJ
	 9nmoRxvdDa2sErYzLDGbOWU6rIJuwLsg6S7QLPo35U2Zvof2KKlxvuNli7llkI7VgZtcc
	 j/wZ46dPzr6hjdz2+NMhG2yYgjIL+BsPh6sW01bicTfEx7TBZ52N+lTQ5t9+4QpFCyptN
	 CTAd/mdnbectpcF23YBCJAsGxgKpruFPMMUB28Unc198fMFthqd2aBoFcz+kk0812ho9l
	 XGIn8yf16tCJ1LWJsqk8GOLgxCcTgiylmjf3bEH75cs8E6BtxRJHuwiD8XofksNJZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G859brBp;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3372606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 11:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3372606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G859brBp
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490d59c3edaso2952862f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795519479; x=1796124279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzFMb3TtzuucWHVLWCFL8thSDn33UJo8KWwaTHZ5em4=;
        b=G859brBp3PRE9sKtnIOu+PiddHE693uDbFkFcyk61iNPdCgzB5fRX7Z0xSh+Ehz9QH
         jnr2NJxcJyyEamvREUpvoTjvvYevuMuRAQmCM4ecpupnJb3514160g5Zh+uEUIbd4mqM
         ktxy2mixDWYnycwuMhm7jiONKjuvObrXipDiOcRA1RrSudSI7WZ12nTVFFz5oRmX2HaF
         RHBy859GtqyGXZPqhSoejfjnPhk5H6OZtCfm33mHNgNI6MENB3xjCxaLdLedLqc3uxb3
         FZgSV3jY/+6gQCplX6mtf38JhQy67GjS4Fu3PTpXFAiE4IWQjnZD4JNLMYcdtI7Qs2W0
         HyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519479; x=1796124279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzFMb3TtzuucWHVLWCFL8thSDn33UJo8KWwaTHZ5em4=;
        b=fJxetZoNV5cZ1GwtLbU++UEDumSS/88lLwonW7k0gNU/h6Xyx6qWlgHzfgDVhHv9uD
         V87eEYEUvkeSUz38pzLVbo523AdP7PKexwOppUxKclFU3v9o/t3dS8YlnUGGXEX5hOIb
         5U6vTOni4VXWutY4j2hFbKlV7SiU8/XHbznA87uBiIJGIANO4fN3s1+5w8KgiY8ufbXh
         CZ8cp1qYMjEyMCjG7tGwBChKR2bHqvIxSSvmR0wcbcz1pLxCph7FSasdhuM3R6wX97pD
         x1jUorFGwZciY4ExorHz6VjZlyGnVyK+MAa29PD1xhnPIZC0UgrCiGSU3A3Cb5DWlg0P
         AzTQ==
X-Gm-Message-State: APuU4Z+LJpP9ckVgaJdUgnYRGi2kOGv/IVC/KSONhcWLrN8Hg18EPXTL
	0pP2BG/o2xekM20AOgbzD3Y9rPZtrYfMlLhtwP55nf7ER5inK/xVU90uo9Ue0l35/1U=
X-Gm-Gg: AZFdTZfC+3HV/p9AMCfwp+//mEzFNpjRfc5rVHAvNnvoglGQfFSK7Ahs6aD/xgt1em8
	oldhqrgf2sT4xWnfEdK5dOoa7MnKR0uKFsun4Ih9AoM338qRJ1GCZweAZXZgx/tXmv6c6jMxo5u
	eSaCbytlPzPYh2tUs0ZY2E6VPiE5L/kwxlWL0sCG8tWTMgWIey7A4d/1p7bNwosBSrlcpDEgDxZ
	SRsh2SLR224nmOUCaJuWL/GrMiSlXLcB0nz7HgFLA6hZybuGpt42s741CZE1bwhg3jWdVPkazmn
	RWdXAaKgQRyvQ2zGlL8ILUPTDsDohNATr0kZ3/KJPb6tQrl4wJixjdgo8Wq7yIkvtsFYA5RG8CQ
	6iWjgOqyrQ+kWFXxffvnHN15FpYOhSbUA6yzzUrnKDIzhjC6Q7WR6SAawWi7XU6A2gWG3j9CDo4
	K1K1baCDfGC7htcNGrJXVJyvfHNotMuWseT/HDiRTDEIE7jjAEfuYoR1tkkJs2TTHRJcabRluON
	QhuvbtpDytIqURMGJn52wiJ3ESAFKWlrCf176Fo/DltK/tB0DAKr7AlY7eGJEC+C94PEspusCjw
	UgEZxCnm2Z0t7ym7VVTDRAPphUVIoVDhSw==
X-Received: by 2002:a05:6000:184b:b0:4a7:9630:7b36 with SMTP id ffacd0b85a97d-4abb3f15ddbmr29862376f8f.21.1795519479042;
        Tue, 24 Nov 2026 03:24:39 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm28811395f8f.39.2026.11.24.03.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 03:24:38 -0800 (PST)
Message-ID: <46a896ba-cd45-4747-837d-50ea4b4dbed9@linaro.org>
Date: Tue, 24 Nov 2026 11:24:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23 or
 later
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Melo
 <arnaldo.melo@gmail.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
 <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
 <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>
 <awSu48pUIh942Zm4@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <awSu48pUIh942Zm4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/11/2026 21:23, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Nov 23, 2026 at 04:55:16PM -0300, Arnaldo Melo wrote:
>>
>>
>> On November 23, 2026 3:44:12 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
>>> On Mon, Nov 23, 2026 at 8:46 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> Context analysis requires Clang 23 or later (see
>>>> Documentation/dev-tools/context-analysis.rst), otherwise the build fails
>>>> on older versions, e.g. Clang 18:
>>>>
>>>>    util/env.h:142:39: error: use of undeclared identifier 'lock'
>>>>      142 |    struct rb_root          infos __guarded_by(&lock);
>>>>
>>>> Only enable it when the Clang version is supported. Leave the other
>>>> thread safety options enabled if they exist because they don't cause
>>>> build failures at the moment, and might provide benefits even without
>>>> -DWARN_CONTEXT_ANALYSIS.
>>>
>>> So we've had -Wthread-safety for a long time in the perf tree, I'm
>>> guessing __guarded_by is missing on older clang versions. Can we just
>>> stub out the __guarded_by for these old clang versions and keep the
>>> lock checking?
>>
>> Looks way more reasonable, and no need for a feature test since we know
>> the compiler version when __guarded_by was introduced, right?
> 
> Sorry for the trouble.  I checked with clang 21 and it didn't have a
> problem.
> 
> Thanks,
> Namhyung
> 

Looks like __guarded_by() has also been around since at least clang 18, 
so that wasn't the issue. The problem is that it's not supported on 
struct _members_ specifically until clang 19.

I sent another version that stubs it out for < 19 which works. The 
commit summary changed to "perf build: Stub out __guarded_by() on older 
Clang versions".

The header diverges from the kernel one which isn't great, but I suppose 
that's better than someone on clang 17 or 18 missing out on all of the 
lock analysis.

