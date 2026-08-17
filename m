Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247913B5850;
	Mon, 17 Aug 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953294; cv=none; b=LwMMEyh8Ht5f5X19gPgjJYkWkH/Y5siAni+VUPGytQJ16GfMfF7snYRYtC1meEUEuDBRVn84Ol3oSebpHv7u+c+lvhapsnHOJaJ9SGPHQNAL0yZZZiJkL3UhjauxtrJaN1s+dpDQjiv7vNLhp9Xhxd3831qcU3mnlYR4EYv2/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953294; c=relaxed/simple;
	bh=4e7kIdE0zcjBnLCU7lhJyBQpJxkwx9Y21awpvSvsWVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJW6buivuJjzAg1HjQuVAvdZcRByI/RmOsYzSO1rHgtCvJIGuTk+wqAkO4eNQ9aY/8wzYO4CwtvydGcLKPsy6yrDLR/D68QuzvPXLG98whQVX0hAVtXnvlbC+zPA6enceHkKWVzJAykw9AqabCa0NU0B+piy9OlIx5Ax22yaneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oypufksR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oypufksR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D846E1F000E9;
	Mon, 17 Aug 2026 07:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786953292;
	bh=RNjpfSmzin3RnkChc90q8nEY8hKPNjfQH6/ZWx+NdXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oypufksRQ816F5ciS6TjyLxTWrFjZ2q/0ahuzidm/udX3oPgdR9anETNVX83h31vQ
	 PG/NHye9X1rch2XouSbb7r8/VTvn3nlfglvCOKtswzpZnKZEGrpNDaOh1SyeBk9m3l
	 G8CcCYY6GhAymJvvvioWksKE6iTzQbQsVS8Lc4vUpLPw3fHL88oxGt8eQRgDWKGwTo
	 fqc4B8zENY/F2/3lyBa/UXi3mq88zSCQM68exo4epotO+0H6Lg2WFtnMZt+6TOmBF9
	 RAi8EwRrRQiCb7ME3wnBisjqFgUQYJXv5uy9m3CEj69HwG1Et/l6V1riSdF7BmJygl
	 5fyo0L0k/E8jA==
Message-ID: <caa08751-a578-45d2-bb2e-349ae201d4e2@kernel.org>
Date: Mon, 17 Aug 2026 09:54:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/3] perf: Add Raspberry Pi AXI PMU driver
To: Ian Rogers <irogers@google.com>
Cc: florian.fainelli@broadcom.com, linux-perf-users@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pbrobinson@gmail.com
References: <20260815082048.4043217-1-irogers@google.com>
 <20260815172712.50119-1-irogers@google.com>
 <4998d0ca-eeb0-4b04-b3ac-a1f97c1829f2@kernel.org>
 <CAP-5=fVffrRgO4OM6u=JTEUwBY0np+fUExqOpbiYU1JgyMr7Rw@mail.gmail.com>
 <7cc71fbf-425e-4047-94c5-3f06d3ed8905@kernel.org>
 <CAP-5=fW7yQmH+4+x5QCqr2vO_MNSYuPW4T8X8qTns=GitOUN8w@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAP-5=fW7yQmH+4+x5QCqr2vO_MNSYuPW4T8X8qTns=GitOUN8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/08/2026 09:46, Ian Rogers wrote:
> On Mon, Aug 17, 2026 at 12:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 17/08/2026 08:57, Ian Rogers wrote:
>>> On Sun, Aug 16, 2026 at 11:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 15/08/2026 19:27, Ian Rogers wrote:
>>>>> Motivation & Background
>>>>> ==============================
>>>>> Currently, Linux lacks a standard perf-API compatible driver for the
>>>>> Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
>>>>> out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
>>>>> kthreads, preventing integration with standard Linux perf tooling (`perf stat`,
>>>>> `perf list`, etc.).
>>>>>
>>>>
>>>> Slow down!
>>>>
>>>> One version per 24h in normal cycle, not 13 patchsets in two days! (and
>>>> even rarer during the merge window)
>>>
>>> I'm familiar with perf-tools which was set up to follow BPF's example,
>>> both have -next repos. The -next repos merge into linux-next for
>>> testing. I agree that cherry-picking shouldn't be done straight into a
>>> pull request to Linus. Is there a principle against using -next and
>>> linux-next?
>>
>> How is this relevant? I don't think you read my comment.
> 
> I think I addressed all the points in your email. The -next
> development is relevant because it directly addresses your point about
> not sending emails during a merge window. Except when the -next branch
> is becoming the main branch, merging patches at will is acceptable and
> you also benefit from the linux-next testing. Not sending patches 5
> times a year during the two-week merge window, it is nice to think
> that this timetable fits everybody.

No, next is not relevant, because I am not even speaking about applying
patches. I explained you the rule of one posting per 24h. Not 5!

Best regards,
Krzysztof
