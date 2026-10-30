Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368535;
	b=tZ/ZNa19G4OG+qZoKwD/7hHOp4JrcHcp6PqvtLCtmdUGD3DuKCo44AkeRbCyHorW8/sS
	 3HYoYQobeyErb9uoJu/LOjDLmzhS3VnJTX7Uz6gxhCPfOu8ST6nRgAcHBIV0tCCw7QGHd
	 Fg9jruWd5LhDNixu/ppiwhFi+uToPx70CD6D9wIN58gGEuk0+q7Kkql1YHfQHQHMfQfkt
	 FwrhI3tRlMAVf9+Z0oYskaOwYG4hOpVCpdm3GO4NcwMSIraMjhNOtEP7X0K2vInK3eBKM
	 AjrdOI89wJEp8Lc5PPm66MFa/ftuFmnoVDo9cCxyny36j69qUqmZVRihPJi6q/oYbaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=dtvSC+Ou86by9mEh2D4NPgVOHJN4VrQWEhxe1Vpo7Eo=;
	b=Vp5XYR9HLAoBtLBgBmJvwipMY4pIPqRH0BRAtzzKhsTNkG+29Mo4ifhZorXim+W6WVbH
	 qZC64ka8TiMF1y4JExLbCkA3VVq9t442AqDjB+ZEvfsoRXuwEWukE0AKsFr+yVzni+02N
	 r9R0zjqO9jkuEe6DaMgOjNxk6UgrNZ4is7+gTANxrKukkBg8duuss9ChEHWM6eJLP+tBE
	 06aXLWPVBLdctF8ThXL3+KBaCiPwJ8+Lbbqp76sqG31y5f7Szez4CtBZCcFmNu/xH8AWS
	 6d6rlOmy5DQXawNxkFRWxEMkOJXfYzzOWOUyF9D9BpEZg17WnGdEvtFmHAYkzMjkC1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=HTq6J8Yn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC4606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAC4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=HTq6J8Yn
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6798af41644so477483d50.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368534; cv=none;
        d=google.com; s=arc-20260327;
        b=i4igC5kZK+mnopg4h92YF9ZXgbe/lSi5PHrbxNYE5+XPkRfEqG7l0Ekze7nFVbvEuF
         M2+ZvKvjNjjNlAKXPjlWAW+aK1D64IujUGnWBXzDjpeLhO+aSeLZsgj3c4vx3/6IoELP
         OqQh36wJqNmHIWKgu59Q6MHTwZqxKI2y8SQdKavRyVu1prJCbAyG0tYton70v9UNzzl4
         WO8jTdNnis4Dskkb4+0ELTcJVWreaPq9UYY2TrkYcNDhQPTJ1Q/PZq+heg1ROW85D46u
         vB1OueYQ/50Nmu6qGh7rnEwdJeBRfol3VJ+h1gclkohL7BNpYOU6M8YQFrJKWJa0q/H2
         ycbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dtvSC+Ou86by9mEh2D4NPgVOHJN4VrQWEhxe1Vpo7Eo=;
        fh=FKbDloh1FpqJgf04cnqpWwEgVeuGxzoYZccNiarWZJw=;
        b=NjjfhV03/ngt8aIGs/IOnQ5HUtLZYse/R/W3KQjINxVNwpO0IWPTBRZlAPeBa7vBEI
         Ylf6oJtsgS7pT46QxahKcjOSR2jpJvFAns6urTI8Z4ZEfcFrsm4XmxJsLTj2pKQhBRoW
         6YGb2deEy2Cq8hPQnjd2QB4gC6evGxs+Cqp1m5nZx3LrWyVQ5lQ7yBBzhLLRDITobdzD
         bFrRHGoQBDd6TD/S/K6PthkIgXUyl5Rph0HJOFr43m8nA7g6k7336PygSTExsKy/Jdrs
         dGCPufu4iLvCIDtj9Nx8l70aeV4uxTdVnYSjrpjQW89mfH4U0vu3MnPY99KF9JKPWpf0
         9aBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793368534; x=1793973334; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtvSC+Ou86by9mEh2D4NPgVOHJN4VrQWEhxe1Vpo7Eo=;
        b=HTq6J8YnXw3xvmdibnTPCJR2Q7OYBdd0aaU08pAC+fJSm6T050J1q6VthBz+ieLF8T
         wG9FAaY4x8O5ECRsM+e8ykmRqZQ+3TabAyD43C6Hc46e7O4P/s7dM4rxQfMmVFlmRSwS
         9AuYDmWe6hLCsB83P4QLBv3o8M65TGcru8Iu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368534; x=1793973334;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dtvSC+Ou86by9mEh2D4NPgVOHJN4VrQWEhxe1Vpo7Eo=;
        b=w59A+xCopzFIFQCVmnhaueEabdSgBxej0aiKYE0ga789/kuF6wHeFE1qyd82MXEN0M
         yosfYgRFZ7Wlq/DC907UyRAdXaa8ytM+Y1mCvb+Xs4IMPedW7QcFICuU1BpA+qnQtpNa
         j9bHosT6gleIq1oEPHdBZoJnkU+C9d+mvm9XuHVDPSsmROTfB1HoEz7G8nLwupyqyAGv
         1h8a92c9yROFuL086wBbQqduTI/Aygj3a3bV0CCaUkfPguDBF6ymMZZarMG1ILjmncVg
         Cp+kSK6O8OQt7otfwMKKjBlrEjgfZSbDKPxkOiYVDcDdDNCIN4N0rpB2qTHPkD7iBWYk
         Ip1A==
X-Forwarded-Encrypted: i=1; AKwUvBwi7CpqZ+0qf8Ai+voD901Bswq1G93lRgiNh3E4U/zneqA2oxXMV5mpn1cxmm4O3o8aRhAOnNC1aV51MLsjmX7d@vger.kernel.org
X-Gm-Message-State: AFq9FYLwgQgDoXLA9U3GNaZXWCdAXAkVOi4UAauyBPXkHMUemk/hIlXR
	f94dEzoehKMEkXXUTQ7LMU/sTPNCsPBiSQ+os1ZGFSd8TXJPrF7w2RDNpaPV/dLiU8C8UrM9YV0
	EJmfe4nG6I4gNpu9iHkFuzWVp8xYQLcOsVOm7sSJEag==
X-Gm-Gg: AYBFou1ZHwVqAIsUM8t8nP1E6arGLIvr+m/e7xdNKBRCXldsdwSerYhb5qkfnDj3HhY
	mQaBjWHuxxBFGxpK5ASnuds4HnFUp/3C9EAoQT/iZFAdXbc3p8RB8mRBpeYGJXrZQx2JT7bNRjj
	QrZDkku1oStYnaWtvXmLx88+JvQ061RYSunP3GcmZRZqN7On+pgUikWVMqocnD3Kr4aVtC76KWH
	0mmSWKeC/Ezyb5lQB1AWDzwPKAoUOasL+gSDO922EjDMwEn9Z5DnWeeR0Xx7q7pPNXeUIoKbhgM
	zW7gzncpRXIUZjSoLrxF057zvGjnJ3VRl+Z3AaWZ88tQ++yolKL8BUOqJUDXw9aXZlvdfHMPOVz
	fJYvLVmMazHBd163aQnK3I9saqXejcpaVBQgU+rCBuU8PJvHyCut49RHYu7L/b56Xm9peRg==
X-Received: by 2002:a05:690e:814:10b0:679:5ce3:b32 with SMTP id
 956f58d0204a3-67ba4c90a09mr1194821d50.5.1793368533419; Fri, 30 Oct 2026
 06:55:33 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-19-irogers@google.com>
In-Reply-To: <20261027231513.816148-19-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:55:16 -0700
X-Gm-Features: AclHuK9DrHFFdDSfKhPwaxq5H2pjidaEA0BUvDK6bP_W-cA5-k9M1Y8SIrY3tlY
Message-ID: <CA+w=M=Sja18zN1foZ4oP7AVyxMGjtNNaBaMOhVnT48wZofKR7Q@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] perf test symbols: Add tests for symbol
 shrinking and session alloc wrappers
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> + if (!dso__can_shrink_symbols(dso) || dso__kernel(dso))
> + return TEST_OK;

This passes without testing anything when the DSO can't be shrunk, for
example a perf binary without .symtab. TEST_SKIP would make that
visible.

No test makes an allocation fail, so the shrink-and-retry path in the
session wrappers, where 12/18 combines with the 15-17/18 plumbing,
never runs. Other gaps:

- a reload after the file is gone (15/18)
- a lookup from another thread during a reload
- kallsyms alias groups (09/18)
- the merge sort with many ties
- after a reload, only one symbol's identity is checked, not the count
or the order

Thanks,
Alireza
