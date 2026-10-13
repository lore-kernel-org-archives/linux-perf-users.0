Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7955199D;
	Tue, 13 Oct 2026 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929699; cv=none; b=fep5RCZZKhmKPvgHJcutMIILoUKOoow+Lj0efawmCu/Cz+0ysdvFiXB9uhtAFS3xOc0x8as8GAnrRFswLSzbtjNGqSHglMZ1fOL4fdHMYy1y6UtTWkDSqnYlbweyNTZlEY2rKWXCNi5m81rWrPHGjnhOx26q7YiyV7lO+qI4a6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929699; c=relaxed/simple;
	bh=v+Px2b//cyjC1k/A3Zmm/at+F5i/PNpfcr/2vmN4mK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQCrAc+73/RyXN7r+6jCDz6SKrbL2E5e4+tn19Ocx690Y2OdnX9HyavK7yQLvvnwBy4dkXHKnFu54uiHLPtk6udZmQrsWzjqWlTUfPgd4KAZJDY7tvMpiL8PiQ6sANIWkz20QcrmgI1WMTXUyaKIMHf6UzeW4H9mdmPYTZmS8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BRuWmY7A; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BRuWmY7A"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j47tV0D7Hz1XM4Tn;
	Tue, 13 Oct 2026 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791929692; x=1794521693; bh=LF8e975hmkkpUELtZzipsuJe
	haJkDu9CcLyUa+VJf5U=; b=BRuWmY7Ahf/chBnwoWAm+JlB3U8+rlr3HSvKQRTR
	yk9kYJD0uSw2oqChvhphmy6OITQaM8JRLUrRauIu17ZuoewoED4nTvpLVGx2CV5P
	o2XaufdjfuZk70/w7ZP1UaVTkpyDAk83BmKSpxCmixsIZekl44RvdjkTwfzP9Jtn
	CSiCCXOcRSAgiTfuXPtYMI619enQzL7zShxeeAbjHgsB7/ONiMsge8F58D6uV+Lm
	P9l7V6dYUdNtkzPA9wZ0Uu8EfdfQ3r5bhCKeKUHnFk1HVbiFR9FdvTJE8PGOfdph
	BTmxKG/c0+/SVr6vOHNc7845HKN1+ozGv7Z3rXPLd7JVtw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2mKJGpWtbxMd; Tue, 13 Oct 2026 22:14:52 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j47tM0NxMz1XM4Tl;
	Tue, 13 Oct 2026 22:14:50 +0000 (UTC)
Message-ID: <56cea1ea-a4a5-4c26-a15d-732415986ede@acm.org>
Date: Tue, 13 Oct 2026 15:14:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-2-irogers@google.com>
 <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
 <CAP-5=fX1XZu=3scB1-hA2ppcM0+sR7t_3=C7fFx=kGikm=dLqA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAP-5=fX1XZu=3scB1-hA2ppcM0+sR7t_3=C7fFx=kGikm=dLqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/13/26 3:10 PM, Ian Rogers wrote:
> On Tue, Oct 13, 2026 at 12:44=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>> On 10/13/26 11:24 AM, Ian Rogers wrote:
>>> diff --git a/include/linux/compiler-context-analysis.h b/include/linu=
x/compiler-context-analysis.h
>>> index 8302ebc2ea8c..024e303188ad 100644
>>> --- a/include/linux/compiler-context-analysis.h
>>> +++ b/include/linux/compiler-context-analysis.h
>>> @@ -243,7 +243,7 @@
>>>     * alias as a function argument).
>>>     */
>>>    #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p=
))
>>> -static inline void _context_unsafe_alias(void **p) { }
>>> +static inline void _context_unsafe_alias(void **p) { (void)p; }
>>
>> Why a void cast instead of __attribute__((unused))?
>=20
> I agree; unfortunately, the macro isn't declared before this header
> change needs it and I wanted to minimize the change.

Hmm ... as far as I know __attribute__() is not a macro.

Thanks,

Bart.
