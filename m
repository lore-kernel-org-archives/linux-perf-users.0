Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793737981;
	b=LltlKRgvRfGsRMelJhPGHDtlUm4rU39unAkPRmmMwYkyEUbx9yujHvhVCh+xsl+oAZOG
	 tL6d5v2ThaFuFLFRw7FsP4DTSch0aUmSkGIXpsxRm0KON7zhxm+dhNZ9WE+w0wD10JWII
	 J3Jd7f7X1AqQd+SMal/LYeTMB/I3648ME9KDZeXrq9ldUOur44B6eZSeXQaxb9LH6POMo
	 nzyvVaiBcS64PjBUWodbShKUEIliZRe1rjknnPlo2Cva6TJ8ANLTBmaifl7p75hI3m2AN
	 A/RoOdR80gS1XP4uKifCShaAbo5XrFJefuDQNJcr4fXlUXfMTcNeen5C/Z2Yv2QF13g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gg+W2EgP56N1Sf6e0W1B3Tc564yhByMeGofGsIPeu+U=;
	b=2JINSqwUi3nLQOEf72qwJUO8iXylY4R7C1DWSUBfqEPwJsRqYt8at2MpqyMGmRoya8XD
	 MFmpNYzM7hAIxUxfX7vLND6hcvKPKtvWnU47CYdilL3dIaEnHtsYR7iaQiQ4Md/dFzwXD
	 S/FvhZ+2ZKA1jcJclNqNg5B4+i8mnQMrnHyNE3s5QKK9LsbeXJyHrTSr44kcfI/OIifwa
	 ypZaZthqKxo5YuqCTZpykCl9hFKj9JHm8Gu1UB+N4BzQbtwsZR8t2uqJtqnMDtGaqKNOw
	 72SVfC3xseW+N2ng0dqNf3/IdYd2hFX3SNd6ZhRM+0EzFSw0Eb1EMrbgHETUVBSbbjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jm9h17sU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376EE606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376EE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jm9h17sU
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so344451fa.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793737979; cv=none;
        d=google.com; s=arc-20260327;
        b=doxrwJ99vu6++xEekLxq6qmsDfjBty/Yr3kokvIxWmFKJXP+UdFsYnb6hTl9JzoEng
         JaGZLiZHqrqwGfR1zBKxF3T4JJooBEz5zU28evluTgfjHDi5Xrz6Q8YaW967J5QUD8Tj
         3XL5E15D/YPRpl5jqwWldM0xS0bPKJaM45oEYU8Fd8Pf1KfqVNYa2qiUQqk7Op7mYeSm
         2yIcydyD+HOYYey2ynG4IARIqe0Qcox+EAQpVfM0fEx1NovXzX/JZKyMvEDemUXwwTFg
         pkpFWWUidPZHd1MsdEtbkhDPlItd52YTXbfB5EeeS769Et2Gryz8O+u+/4LoRmbHbu9D
         c49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gg+W2EgP56N1Sf6e0W1B3Tc564yhByMeGofGsIPeu+U=;
        fh=hHJkQJoF5Xw2G6nabhW7Sx+6f0akNQHVJ9pXhzRbwYA=;
        b=Nm751rYfsINKsIQx0EkaUh8EnjH2GkDLipkqcBYASgfwbIFQ8v67aRZtCBUZJQQXwm
         /br3iL92SaxGSF0ixqOUH/x/xcvaoG0dRiNu4RA4Svofb3F7gNbS56bIwyGR6KShEVai
         RTr6PeT5JyzrGy2Vu/cYb6lYS2Ofzfq+QVjynD5Koq9MHZuVq5uPb+3MDcZUoPEJRmG6
         SkfZ2SGcRFHTerFHMg+jho6ncVM3UTOyaNwDHDoyNE0eQrxUK8733MNRtTI+frCv/8vs
         cZRtu6G6TD664SMQkC+DFqLe7Y6Tx3a6M6gZUz4CXk1yW6cA2IpQbelUIcWJDrnG6MNp
         RPMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737979; x=1794342779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gg+W2EgP56N1Sf6e0W1B3Tc564yhByMeGofGsIPeu+U=;
        b=Jm9h17sUzBa0J1wZjuoUGLG8nXwDfKaiZdnwQV8i0Z5rIyLWtnFizG54Mb8VhuEFNX
         rW7Y4rc1FmE2eQGibXhlfFcLCv/cANTCjYmEA3X0qB/wSffc+Jue8m0ZrTj91g/ysaH3
         II453nGlC1agps4Kl22gBYgtJAmrJewCpfylTLwG8ckuEdaqaCxeknDvLnvo8KkYqMMr
         oN1Hk4uuEJ4jQ2j8NVNpkyQEC2uRRabXtMqJv3w2Gpxh7olpRi4CGgDHr79l4gcpAzUT
         M7UJMSMiGL6ExHwGMnOskz1O2ZQopyzLk9ZiQ+5rpbFdRZFhlLgNMm/Pm5gCb6nLX0Gh
         Mdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737979; x=1794342779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gg+W2EgP56N1Sf6e0W1B3Tc564yhByMeGofGsIPeu+U=;
        b=FTIynBVodun3dh6aJPv1kn9JE630R2ibGG6WP4hZzOKXVbrZl7n10iBDrxtP3yXGM7
         H4zv6Efp6mFr1Gk/r6pKpJ0Mhue3tgiJTlhJ0AEh0aFbnyCoWSZ4XWeAXgSaatVh2S6E
         rSRxr201x5ePsM1XFs8K2dkDWEYN4o/ngEkppUpGC5g2bk4THSOh3g4T8F+m9IBHbL+3
         5h50ZIRW2XTXSXzAA9NQ1Vwo+mofLVe4njsarRzkUkSKedzQ12AVBcl8MZ0XqTYxB5P0
         btztBt27FiIHQ3POhbgxn7VA37hMM/ECywm33T4iLXWonzYq7fQyj0ckXNPA9udSUmX1
         4Aew==
X-Forwarded-Encrypted: i=1; AKwUvBxbj4UtqhUsynAs4mj/fMygyvRTei0v6u65hqtI8RnsLB//DwEM3iGHuwq2KHg+G7HFX2udxZXBY83KmsN9Srkg@vger.kernel.org
X-Gm-Message-State: APuU4Z/CGjfQYu76EeZuLX9Td6L1y4VfxfjmQhOdFldSWHk9EzMRFFMI
	T3IQedLVO1HXyB9WwtNs8qtx6yEeK4gIVuYIjmKDkwWXZRQQ7LinNkNZfAJC1t8wG9Z8CgRlDtI
	aHfMLLlozSrB/E5tzdKEBhQhpObi7lOA=
X-Gm-Gg: AYBFou2EoJn7NaOx9jXAbzCipLbaOQjmSIGqsGffH9aP9HkuVIWCQ5IoWDNPwQ/OkxU
	8lYt5C8pRem/aAuCOl867aWDYDvTqVvnTtSUfdq9m68ONSI6wRh2tBNHp1PQbcBKlz1v08uua1I
	dKILExfMKrTYzTnPvcIIxrmu3iWyAWUjWWWrl6ZvQhYh8UszkHNwKGThwHMaL2hdF3Rx9jjWiJ2
	thcVVScWQG3PNBhJY6wt6hKyEVjb4DPfdPlRDew6381JUm+7pUgEA44E2n5J1xmZsW58WXnzP87
	ah/DMmSj7jkW3f0ylA7KoGqBC/L7MPrJ9S2Y6qajiup4gb27lfolLLY6wSOrd/mARVYIkJfQCTZ
	dQav6QRhCTVsAwExkYu9DjcNRug+Jtbt8HOmUKmbJtQ6NJcR7Uxwgyq4VN/YiXPdi446aF6/LkM
	2V5nSyizjgbc2vkmBICcBdh70kTCDhPBheW+0mkhBuSNknUsO5zSMle4vjvBVlIelxbZDlnz/tv
	w==
X-Received: by 2002:a05:651c:a0cf:10b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3acb7b2ae3fmr23751711fa.19.1793737979205; Tue, 03 Nov 2026
 12:32:59 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com> <CAP-5=fWC7AM9aAsHaZvQVXznYzVp5FRQtH=vu2xxQys7QWvCQg@mail.gmail.com>
In-Reply-To: <CAP-5=fWC7AM9aAsHaZvQVXznYzVp5FRQtH=vu2xxQys7QWvCQg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 3 Nov 2026 15:32:47 -0500
X-Gm-Features: AclHuK_DMhE10jbZfTykItRyJaRbazl8IY4r3kkMT9nMEXLGWMUP-9x3lCLMK38
Message-ID: <CAEdQ38GGq6Dsq+daBNKsPOWtR8h6+KcdvaVqrxd24Dd3QJhZwA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] alpha/perf: add ProfileMe sampling
To: Ian Rogers <irogers@google.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
> [...] I have a suggestion about the rest of the data, which is
> currently only reachable through PERF_SAMPLE_RAW. Raising it now since
> it's easier to shape before the uapi lands.

Thanks, Ian. This is incredibly valuable feedback. I really appreciate
you taking the time to write this!

I've done all of these in v5, as patches 8 to 11.

> The PCTR1 window count looks like a natural fit for
> PERF_SAMPLE_WEIGHT_STRUCT.

Patch 8 does it as you suggested, and only when the sample's IP is the
profiled instruction. On the ES47 the weight matched PCTR1 in the raw
record in every exact sample, and was 0 in the PALmode ones.

> Similarly, if any I_STAT trap types identify a memory event, a DTB
> miss on a load or store say, setting PERF_SAMPLE_DATA_SRC (mem_op,
> mem_dtlb) for those samples would make them visible to the memory
> sort keys.

Patch 9. The DTB miss trap types map to an L1 mem_dtlb miss. I_STAT
does not say whether it was a load or a store, so mem_op comes from the
opcode. A test touching one word per page got LOAD and STORE as
expected.

One thing turned up while testing: an instruction killed before it was
mapped can have TRP and MIS set, even when it is not a branch. So
those bits are ignored when PM_KILLED_BM is set.

> The remaining status bits (retired/killed, mispredict, trap) don't
> have a generic home, but they'd make useful filters

Patch 10 adds retired, mispredict and trapped in config1. As with SPE's
event_filter, a sample must match every bit that is set. Dropped
samples still go through perf_event_account_interrupt().

> Since PEBS and IBS op only sample retired instructions, it may even
> make sense for precise_ip to imply retired-only, leaving the profileme
> bit for the unfiltered view.

Patch 11, kept separate since it changes the default. On a loop with a
randomly mispredicted branch, 19% of the unfiltered samples were killed
before map and another 48% later; with cycles:p both are 0%. The cost
is that DTB miss samples are of aborted instructions, so seeing their
data source needs cpu/cycles,trapped/p.

Thanks,
Matt
