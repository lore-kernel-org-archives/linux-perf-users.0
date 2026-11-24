Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490847;
	b=J2ioLjzlY0gOnRnh7pQeEKTFymLi2tQz9CI0gVta9uPa5v8rojjTWC/R54pM35oE3MWN
	 itdvC5qyuNgGgSuJ482e4QeZxHLxlTHucvunuxGJblJc2GJVPtPiiq3Nch7jzFEBV9JE2
	 BYI+Hb70XraU+KstGm+ypfMgVq9zlUrPJNDOnqV5AJe4oUplB7SZ8IUJIesR6PUXhaqg3
	 GfFYp96S/spUEcPEXgCpi94SpR7sgaQdhH7FcFYftxE5ItesDpl/09SU/oisvzp2xinQq
	 UuuXHvmpNHzVSTKx6qeNZyDTUpHTxzlqxccgf4mdrdolBjkvq/+y25Y/njIXwQ5HGDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JiQXtAo3o2WNzv2cw0xwZCtmd/vlPYyEk4FV9girnuo=;
	b=NBAzWV8hLKxQzvyIhij6jVnBdeHGj3u5OlvRr4rJdHBVK9eDk1OTFhMZzgkJ90Fw0O28
	 koI1YAtuXLWmown8ixhUJbkd3qgzML6F5V099g3M4WNf4omgfkQR5wGgRWYtttUtYeFA5
	 SrqZHLzKFx00iZ7Qv8K1frppUB3xnj43aW7eotdd7xz7a0E60mTcGxwlZSJTxF315M4NS
	 izp+Lyw/txOedxb/qkFFz7QqkAsR5r9FNBDKbLXNzdGThicn6SPd+3RayAsljN4Do2uLY
	 UELVcW1DPAU6DU5Jqcq4h1cnCKXDs9W/2dCjLgcvvl8oIyCDYkND9kavyHRgXT9YGwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JVzybGZz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB1606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEDB1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JVzybGZz
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-54492d8a988so711801cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490846; cv=none;
        d=google.com; s=arc-20260327;
        b=GHovS/++dLnykFL22E75bsSk6qO7PqjmS1bZovU2H6s5LdRIYUZGchSrs59tWA5HWM
         U9Uvz0lB9DCYNniZENb+J7CMq+ULeYQcWfmdrb/OlpgeJybbho4CRWg7+f5m7+pi+asv
         zGRSfcCoWuem/E2rQefdRigUtlRgAc5YB/FF74EnsnchauC+DLylIedROfZaJSLJOJnw
         LhqkDcs1HIBukw8TXCstoMGIvHIyioep3TTXVRgMPOIaJlTD6GMAMSWKq3BGtZV0j8f2
         R4/n47aKMySDiNOsAmcF0zkFJUs86KNNL8gHcdatWAIjJYHPQ8zgKzwWHXPjfTrM/Sc/
         ndbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JiQXtAo3o2WNzv2cw0xwZCtmd/vlPYyEk4FV9girnuo=;
        fh=rl8iPPIU3RUc6Bxr0P5y/hqwAvWrDf0R7LajrTVd590=;
        b=d10NB2Cmqx6ncZaUEXSZZHRUskOR8QooPz2DQm8cqlK+4sg34NAoZR/T1vqVzLmlZB
         tOd42vghXGboTpx+tE3gtfFY9vt/HNjNV1Z3x4PrXZIHvt6X1Q5wHZgfeCMlOvFEhiNX
         lT3t4RvkUzcRqWoUJbGj4cniUi7n9U/+fOYGC2jHl5uEpD41SVK3jLBMCZ43YxwWBmLy
         P0OSvyaKtnTnQMlgmEb9stsSeEz5+mg5YaRlXq9laaUlsNPoiK393gNDuWL0/HFZkT7X
         4MdBPrMyAvw1v/9IyTHZd7dtApJcO2BQKdVINNZagJBDCYuMu6oZHbzB6m+RZm8ttMpS
         0a5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490846; x=1796095646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JiQXtAo3o2WNzv2cw0xwZCtmd/vlPYyEk4FV9girnuo=;
        b=JVzybGZz4oPbtX3QqoBYoJbLp8udaL1EJW4Vh3Vcrvi8wTTg3N4rGD77xVOYML7ZFI
         jN4ke2CYQuhyqPKLMxQQgOb1S64m64areXaOt10Y4i9Ok6ZvTSd/C2GffxzfqS93rbaT
         eHDUaW3avegiBlQbalvTTy+OO94qmc47Zc8uScOK4UdFw4i4wCbRwD0IoIpXd8P2viwu
         a/Ny5dFhRRRm/BXBG+OP7uXwNQwQ1XlJXLSlcjSTm0J+NGehjSqMqNqcDTY4brrqMQXv
         yBI87xUiVaRUpCtKE/UjMuwEFFPXNT5nKQGeoaunYf83/NalEX+4pAvAur9q39V+FNLf
         sd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490846; x=1796095646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JiQXtAo3o2WNzv2cw0xwZCtmd/vlPYyEk4FV9girnuo=;
        b=c61Wp2oi5hUHFBBmMwgRrl1oZ2UnfdFddZVALKHbrRHo0/+9MIfrHTXCnrL/3nY6m5
         0am+M7W8GDVRbNfKPrt9eWK/jbqjvFq7iL8COUSTikQxPJQLwDwXqbBdgVCteUkFFONR
         UxN49RXbh2GrPN7zc+U9ByU5c5H2hQx+yzjwy2mJ/UBl1z8RdI5EuzGWP8LXZK2LXp1I
         jmN2LBWf7zCHQENQvSttsylIzqLNrh8WiTgmw0Qi90WfrjrAP+yCMMlbBrJc2O0dzEhS
         UXRcYGPyi+drdCc395uMlO0g3a6cjG5Jt2LBP6rK703j2VczvSj9n/xn7Ch76lnl6mBL
         IuOg==
X-Forwarded-Encrypted: i=1; AL+hErGNYOsrmC0JCjg2CruEoDug2X+jcTdTCEnt+U+/qi0z+QKjMqhbubVcEN6S+WLpn44dbCYFkk5WEXlHnxQgJJns@vger.kernel.org
X-Gm-Message-State: APuU4Z9cOTL0HanWzxSo/HASW9Jn4+ojrq/tZzRKX3/naMRWubAS5qA/
	DrcaJBCmJzrvQ2Ma5Y6cCmPCefQzITwgAEnFE/MDYhDhPldERv5g3lX9ba1vvv5I7LCrDrroTTl
	r79mT1sQIQvgNuOmo0CquwvEeRlE1psQIsvb0qrx6
X-Gm-Gg: AZFdTZcqQFwSAglQHlZ1oEgGW5rhLDwc+sMyhiCpOVGw6AinaQOAO4Q1tGhRCK7o0LF
	advP4ujhOTDX2KV9BXY3MKIcqi+iJN29Uikm3mW06coBzb5zLr2ZwUM0Jutyd6wLO84jiCEaBP5
	5vR7Y8YQgDpy/wgtpftNw+eSPPJqxLiwb5+QWpgiPpi0DL1csxXU3OMSRsBb7gci0vbL4UvLTfm
	Mt3SwjXTHNfj8PN0FfcUeB3WVqxhWFAj8DBYNkYI2OpdxcRlVtUZHg+fcShaCgEWastV6hmqeXV
	mDez7GslGs/jZzbqZaPHm4S6k7tujnD/Z+fCr6TQgg/ya89rj8ISwYKTDM7mrg9UJ3AMyCeBMg+
	s+/seWaGeznI24huWOXXJJeF0f2SmvoIEnABC
X-Received: by 2002:ac8:6542:0:b0:55b:ab4a:6fad with SMTP id
 d75a77b69052e-55d88fffc05mr49383221cf.9.1795490845197; Mon, 23 Nov 2026
 19:27:25 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com> <awS0QkL6JuMfC7Z0@google.com>
 <CAP-5=fX4-HqRbB8zWNSUFyCc4Lzz44iNmok5HJVj5O1+oqoWOA@mail.gmail.com> <CA+w=M=TtEOjHR83QWYknCdSxAPxMNSmQ8yHdVJOXcecRgNEJNA@mail.gmail.com>
In-Reply-To: <CA+w=M=TtEOjHR83QWYknCdSxAPxMNSmQ8yHdVJOXcecRgNEJNA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Nov 2026 19:27:14 -0800
X-Gm-Features: Aa3M54qtiUMX4Q38ODAOzNu5qyFDixnhQ6fLkCkxAsQyceRWQZcJSGJusRlceJI
Message-ID: <CAP-5=fUy+Rt6=8eTDjJE4KKmhToDgYCTrBCeB5Yc-EZ8kvrcUA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 4:31=E2=80=AFPM Alireza Haghdoost <haghdoost@uber.c=
om> wrote:
>
> Hi Ian, Namhyung,
>
> > >
> > > I've applied the first 6 patches to perf-tools-next.
> > >
> > > The patch 7 was bigger than I expected.  Can you simplify it more?
> > >
> > > Also I don't plan to merge the rest patches as of now.  Let's wait fo=
r
> > > the lazy loading and try that for a while.
> >
> > Thanks for merging those ones. I will split patch 7 and rebase. Patch
> > 8, shrinking DSOs, etc. is kind of the whole point of the series.
> >
> > Thanks,
> > Ian
> >
>
> The lazy loading v9 is rebased onto perf-tools-next with the first six
> patches, so it now works on the sorted symbol array instead of the
> rb-tree. I'm going through review fixes and should post it later this
> week.
>
> Ian, it uses symbols__visit(), symbols__sort_read_lock() and the
> symbols array directly, so if the split of patch 7 changes those, I'll
> rebase on whichever lands first. I'm also happy to run your remaining
> patches on top of v9 against the same profile as in the cover letter
> and send the numbers, since the two should save memory in different
> places.

Thanks! In v9 (sending out shortly), symbols__visit() and
symbols__sort_read_lock() keep the same signatures and contract:
symbols__sort_read_lock() merges any secondary sorted run or unsorted
tail so symbols->symbols[0 .. symbols->cnt) is a single contiguous
sorted array under the read lock.

The only struct symbols field change to watch for if lazy loading
populates struct symbols directly (rather than via symbols__insert())
is that num_by_name, sorted_by_name, and the sorted boolean were
dropped in favor of sorted_cnt and sorted_tail_cnt (so sorted =3D true
becomes sorted_cnt =3D cnt; sorted_tail_cnt =3D 0, and zfree(&symbols_by_na=
me)
alone invalidates the name index).

Running the shrinking patches on top of lazy loading v9 against your
profile sounds great=E2=80=94thank you for offering to test and share the
numbers!

Thanks,
Ian

> Thanks,
> Alireza
