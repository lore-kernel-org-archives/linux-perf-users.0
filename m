Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795473142;
	b=1dgUSFfW47YmPdjDStcudJpQR7nBsKQ48YzzquLAS1ZydH9OF9svaomGW5BgbDY1vOhb
	 OwoqZJk8tgkKnxX8nWBJJ36ZByh2k+oFnGCy5P+rAkgUIACuiuZVBK7Qz2NwpuTLmnjfb
	 02/ig4mA9et9Uo5PVtTd8yIaS8kY8seswXZn4K640dsrE9/dQojvrGrzyaRjVkCt6muYM
	 CnsqTf5wbNqFwo/kxyobLPyy2GRREkuLg1HQpU9kEtmkyhFa5WnW1bup0rsZXx92Vfq46
	 uejqEIdzsVymu2mZQcAgBHq5asroc05tP/g/aSUYWpzoeFBP6z8F0ekMG2v2IC2Xgrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2Eh/Scg4g1fmeoxJAaW6QP4PNDVs9nNzors+g2yL14I=;
	b=ZgxKwl0DT7pJOXMpjDFqAYCswQVh+h/s8ntMZ4og0jv6OjBRShmRKRK/RDtmMgJXX7NI
	 RedNQyDVw6FXPDQmsp+eknLnHw+JH4ROs7Hs82T0meMpVRqn7vh8bDUsLnr4lK2rLv+jJ
	 hD5vW4opCptSIynVuowTg1lmsOJT0lFqi80W3j0HfvE09IatmqbIGuXzcvsTq2ExMkzXa
	 ET93PaabV+bxlLI0ZDmSiBi9mNPiF+DWDLxYBdNnqlacx1YR6fsNTlPnnZSFKor1JTAof
	 FeiV1NDnhPNn97oGvpqBbSw1yAHODdg8kB86lfiQ76JkTdIMquYATXiBkOH568UOaxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=pa297P7u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1200606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 22:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1200606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=pa297P7u
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso4584797d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 14:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795473141; cv=none;
        d=google.com; s=arc-20260327;
        b=DIYrYkIvpkmuWP/L3m3mmXTqcsRUcH8AZHMrPe5+WtvDfkpwA21Kwy+33HOti8nO9c
         QezqKinUwYtNnRcJ/9rzZ4bLcR3CqCjOs2w3vRLJOqRm4Dqj8riTy8+sxROfwxR7GMoC
         UoC5ag5Qof+4jOS3khIspHaiuI0FtGMu3SS8iOz7tbB0w3enG17BHp8/TlhyTnNEtXXs
         4X+wpqBuCyj5jJQd1PseCazgPcl64khr0/BP5J/3UN9WOg+49quEF7/rLfYbvFNXJw9B
         0fsEwCSvpl4DC+0T7+RZxiPARQhycl9SHygRnclfOI/krxFHribMQM+g35UBcsR5TshJ
         DnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2Eh/Scg4g1fmeoxJAaW6QP4PNDVs9nNzors+g2yL14I=;
        fh=wMdEdEScZVqBEB07cm4pP2A7+GL4EVPJsppJly9s0YM=;
        b=N+KvuotFQpCPWJ2oy3V9oFpLepFXTcWLS0JhRZiUGBLEItUfJIx48vCy2BI8wJGHwV
         1u+vyOyjfC5aEHzHXN2fGebqdiMuaa6fp2yDJpU4GkEJ2NHa15Kt3CQfdMrIi92Vw21+
         ZFn9A3A8+lNipHiFre1Xnsl8x5OXfpKsx7xGfV1WsgP9zettRs7UNQCkVHxplIRxZFSG
         Mc5h88s/z2jEsGru2afol2MI3CN+HDjEvnXHk4oGSj3PiX8rVGkkfmLxc5EdKknhL/3z
         g9d9Rd9g2JzqExFqdf5ZuXERThZ9JM6njOGDruwagz8Bu4N3pb++anFFMIpufseuX8gq
         7cuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1795473141; x=1796077941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Eh/Scg4g1fmeoxJAaW6QP4PNDVs9nNzors+g2yL14I=;
        b=pa297P7uVZvyycGhMJz0l2Xa740O5yETkXpOiyeBLj6SRme8nWzeEkfhNNf0ReXq62
         PQN3DP9nHQiS3S7C+LsR8YWvAfvwamyZvdIFFsSMsC2QEOYOC+tZXhMBVqUwZK4Qpq4u
         nowomlaQpVIZ0g5LVa3ziiHCNLLbmRO9KRApw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795473141; x=1796077941;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Eh/Scg4g1fmeoxJAaW6QP4PNDVs9nNzors+g2yL14I=;
        b=E2/MUrueXe4GM5Jfzx5pF8WsLhu6ghEVqCpqkUZFElygLk1WfiM8hs0EtjqyTQX71d
         Wr+dLwfqs/cv9TYBCNZawNrz2z71dAX5CJeyLbhAjYJlaGBJtz33RExe1esvC6HsFy9i
         83VgoipoCGEROAxVKL0+/kk+jC40j1F/0EeA7prUUq3r6qQ/vOu/xCDqNVdqrv96g8X5
         pDagpmbus1Qg6NGOwiQnqkUXI+6ThFwzCP6TtRIB851niTFWBSNBUx5CSMTStR1pSOeW
         Pka5JWnbgkSzSvSz32ud3nrv2e2eOvrWpe3MAml75Sxhdp1OZiDkZu/r1Cc4l6VnwN6M
         pMDA==
X-Forwarded-Encrypted: i=1; AL+hErEJoGujGDrN24DY4b7N6VERuGl6XTv5tPudVksjJIgaSvkwACss01eNQ+mkcA8alnAHEO9TtkSKoWml2fCN2Y9X@vger.kernel.org
X-Gm-Message-State: APuU4Z8cN0a5QE+AHtT/ZywQdHzYLhXKaFPxoEs3YWYFWRiI7vttpXpN
	JINA04TLHdbNsSDKlC/i+26gbSr2vM4YmZyG+Fc7PvM0hGjlCBydSY4NGKfNHcCBTmQTC43CoFo
	25/RDrtes7HfV0oitHI1ZhlbW88gZooBXwgLRj0HHqA==
X-Gm-Gg: AZFdTZdfUhVmUNvVuqlOdWvcmj8SCG9frOB4gv58TVdi9kh3ZDmT82qjihWI3RDalvW
	jlXqGhAOKvxo1kLv2fybrnEtyWR7yJLWONhY0BF+0QPfTF/Kjs3ZQM+CdmfNmBG8lhfhmAhxecR
	HnKz91e4m87GcJV3Xakgj8EF6UaJvGGadhBMXP0zCBr+wIi4cAZLrV/AwdtCS6b9PwsWi7fWq4m
	iz1dCU7N0kNIKqeQndlUT5VQek/66K8GOI0RWlf12aO4J2XqWW33Vr16SbbJD8JKuTBhmJlxTiw
	nsyGedDZr7+xknJdbrpEth6ZZN41SI1qXP1Dkh7ONjjwGa3POEErGg+UTSPOTWUfa8WCtkaB5x3
	GK5wdMPzWDgh1GoJks5or8KMHZl6L3SRF2vO7wmvy28OMLMMA2YcOZA5DcBnwkEtIsauzDFw=
X-Received: by 2002:a05:690e:12c7:b0:67d:bff8:c405 with SMTP id
 956f58d0204a3-67df42b57d5mr4783638d50.5.1795473140377; Mon, 23 Nov 2026
 14:32:20 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
 <20261121-perf-symbol-memory-send-v8-5-370561cbb5a7@uber.com> <awOQ90bOx9fbW8vo@google.com>
In-Reply-To: <awOQ90bOx9fbW8vo@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Mon, 23 Nov 2026 14:32:03 -0800
X-Gm-Features: Aa3M54r5vhVadGvkZQpkU9NkhzNGma8R6ZXlcVM2afldFAt8JUqLUoTZvG8z8Xo
Message-ID: <CA+w=M=T0FJyuH1LcQLVNHi8LvE3qvBCdFMM-DyRw_mPVq4XPpg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] perf script: Add --lazy-load-symbols to load
 symbol names lazily
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

On Sun, Nov 22, 2026 at 5:03 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > + bool lazy_allowed = symbol_conf.lazy_load_symbols && !dso__kernel(dso) &&
> > +  !kmodule && syms_ss->type == dso__symtab_type(dso) &&
>
> I think kmodule has DSO_SPACE__KERNEL so it's enough to check only
> dso__kernel().

Right, module DSOs are always created as kernel DSOs. I'll drop the
kmodule checks here and in dso__load_sym().

> > + if (lazy_names)
> > + pr_debug("%s: %d %s symbols with lazy names\n", dso__long_name(dso),
> > + nr_lazy, dynsym ? ".dynsym" : ".symtab");
>
> I'm afraid it'd add many debug messages for -v which is often used for
> quick debugging.  Maybe pr_debug2() would be better.
>
> Also please put parenthesis for multi-line expressions even if it's in a
> statement.

Will do both in v9.

Thanks,
Alireza
