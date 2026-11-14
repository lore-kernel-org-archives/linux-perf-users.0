Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794633954;
	b=sEQMEdUhxdkgh9bzRRBx6F5A9UvJ1nxCZioo6CaSwJnkc+flH7N3dXVLJJx4hUtw2zIu
	 NCgcY2NiJU5uzL9NDbd7DziOOM+T/NNq7jUPvnFpUaxLNRqCHxJj2PmiBLcTsKO+PkmDf
	 sTsFX1D3cNZXMPgCbhiqQ1ACwGOVZk1p5wr6uzYMMt9G3+kLS1T7Bhb+X9nQHbDdiiz0t
	 jY4Ct3JEXu4DedTAQXDpzYcc3SsJ64h9/rBVvJeJGJpLsXhaWeXQJBaj854QmQ5O/YPfc
	 TiZmXr4RXMLBMUKBJeWMtqtFwuBozbJX4UNhQDQo4B3WjmivFvfFL7GWSkFgNihe+mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oLPN0CJ8BvFmHWFTOBHnK/cJFGHdPvZYXnS75mvoNZg=;
	b=POpxA7/auFjJIw2RvUtll9wpBucMStZkOVS5kuwTE2h/v9yFBUITFADhGRpEIvUGUzLX
	 q3z8uuOHcZG539OU6fA+2NCmTfygMVojREKKlMG/Eaj93qyhDd8c0Gmp94YYdHgwVa+dp
	 253mV+se29TKydza+ZDCCZukG5xeyG6LXYRqD/BuQ9ceYyhKNvAYk8SGJKLd3gra4i0UY
	 v2M5ZKE4aNluyq/Nm9MKMvBJicKZQY9+2T8kEZV7cRrs3ejY16XRbwwOQrbz3Tr3Fu1Yr
	 XimLPBQEO7nd0cKDR0+ObmjNNRcz41K24TQ/IEop7nx6lexuvEviV6FKogCO76mbxfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=SBYJeOet;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5313606A32D
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 05:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5313606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=SBYJeOet
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso20854557b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794633953; cv=none;
        d=google.com; s=arc-20260327;
        b=NyQlY8GMy/A2jNhhK/Te9/GjYV6N8vvSWuqu3ItG8mASmcl+n9TxZB8asB1sFRR557
         esCiR2zyTB/AQjYoQZgiWSwRj+M+GMojquAyKKYX/vsxxwYwFlHKs4PhYVsRayajqfsp
         7sjDmBIyqGGDon2LgveOC7BYNkF3lTKenzdm+SdX0qr+1VSmyRI3RdhNMQxIoPjVfJ3E
         IyYZgju3NKUEQ0BUPgGGVmRlz5SO1c89nEjQxQ7ONfO/z9U3usl6wJjUelMAIrgT5x/X
         S9AuYNNDjm5/5oyf9QFbIOmjMzr0ku4+AGYhJeQuO87i0BCSQMCuUFBaMxv8D9Mr/qH7
         mppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oLPN0CJ8BvFmHWFTOBHnK/cJFGHdPvZYXnS75mvoNZg=;
        fh=3VIhTK4R7xD0GL/7oPYiIHq71pfaYe0F9738LCetKIE=;
        b=NTrBJvpe04Yqp2IDva01n9JKwWoYyHA1PDTiHOm5d2Hc/rKUfmaBUuhy1psQjGPK9L
         wDSeviHWWvR0q40UM/SuxUS6+iiNb4t24SBNNu6KvVZsmC2uj0NWih1z+TAOOov63bqb
         YUmH78MqlkddDeAGR+GRwdufa7vAGF24fbOrNwWqIEom/0Kfo9K9YBu7VrdUk2rEK2F0
         lnMORoIKdEn+fE5uXCjBGRWQ2+2AfZEJn4sRurGCeNV+l2CMYm6BbPyP8FIfhfl2WjYP
         5k9x2gmeWKCBzwXw2HoXDrEH8XDi+RGeOlRxwZ6huI+9wq9GeFI4hlkdlZjY/R3dnThY
         RE5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1794633953; x=1795238753; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLPN0CJ8BvFmHWFTOBHnK/cJFGHdPvZYXnS75mvoNZg=;
        b=SBYJeOetIb25zgwsmryUxtWfvuRl5/0eqvRzZu9ei9ShexP9T9ws+QhqO5Ee6/UFdw
         RE986ufkKxzoAFtvzyk8wXqR/bPVwhSqLQ9q/hbhjqXCP13lpPIKsu0dnfWOZg+dTyS8
         +dZYI8nkUdNVvWyvqRWHWBNgWZ335v6Lw0Evo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633953; x=1795238753;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oLPN0CJ8BvFmHWFTOBHnK/cJFGHdPvZYXnS75mvoNZg=;
        b=WNQHK98fSFu1KGTsdjHSsF8zE9vYyBFNDOuOCClodvVyY/gXHYXVjmlAdhBI+gYPna
         N1igjSXml2tcKuhhBKmCqVSwSA+R/QJEKl4xdB0Ge/jTQMi5Jo0WpEr+OdlsMydD4IiM
         ItwM0mtea24VoDcFqbPwtgDJ7h7Bm/OticVVGbEfAAExvM/1lhV+e2iScVypp8vtV5YS
         mp0ErvoNqAfAIpS9gVCsYabmZXIrGaWNLyTX8NKHpmu5ck9VBRbOXByRdImkY23jdrLH
         K9txw4ibaWOYhn0kl4Q2lmXvkzLCT7VcntDrRs5BUUTzwB0Pl390gYmEw+gYVZ0dcnYZ
         IF4w==
X-Forwarded-Encrypted: i=1; AL+hErHV102MOK9FF1sFIqRe2H8xrHx+6d1DcdkjctjAzMGpsRSqf0DPrV4OYQmV03RlzIpZCJ7cTfuxHy/+knUr9iW/@vger.kernel.org
X-Gm-Message-State: APuU4Z/H5jlIZUgjjh/tvH90N0O8sz2R1RnRw2YW2bw2XZ10UY/76W4H
	68zygXtme+lxVyTG1gXWo2aoIsqbhGCUvS2oEz6ktUlgs95infEf8DW52DUIUd/X4lO5h5IUjbg
	Wep8koT/Ude/cVrXb6m5pkNOdCxJ4BseiT04+bvB9Lw==
X-Gm-Gg: AYBFou2/MCeXgsWQSd0Y0Obn0aOFyZMYExW3zCmFVrxg8EuiRueyeoZRMqdbIbwwCcS
	12t0k3ayhMmqUPnj/KwO3UyRMT7or/MVO4SwIvw4l+e1A1byI4RTEu41/yM304XsTa2p+PlRtUA
	jebbpEBFz0qWqea8Ws9LE8LJb5i3J24pIMV4rV+ja0iNOgyMrlvksRsGSI0WIjQhb1hQldRD1jf
	MARF8I/APyTKHi66dTnFTXefGLBl3ObZxYXtT8QV82jpk3rngq5TwQhM10ufbML9FtSq4WIkoG/
	tR1mmPSOZW8lz2iGADEFjrJIG5K2coLbDVWDfM2ae/HSjKqnQd9l6DXqI/3SI+VqwZUza6VMF61
	5/43clmHpCEyso832CvuGJt6/t9uLbBv6MI5H30BTph0ojQXxecAAXhYM8MaqlFfPzjyL5g==
X-Received: by 2002:a05:690c:f03:b0:8b1:60a1:cd3c with SMTP id
 00721157ae682-8b4aa2a7bfbmr33554237b3.41.1794633952373; Fri, 13 Nov 2026
 21:25:52 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 13 Nov 2026 21:25:34 -0800
X-Gm-Features: AclHuK-aRGtejtjQzTD9T388HsZw1Y1VUwJ_eg0M38a3xXK3Tk0yjsKw_HGzd1Q
Message-ID: <CA+w=M=SnFtEHA9NhSM8gyCGuA19Oazpx6X7yYTtgatsi3rKfCg@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2026 at 9:17 AM Ian Rogers <irogers@google.com> wrote:
>
> When profiling large binaries or long-running workloads with many DSOs and
> threads, symbol and DSO tables frequently dominate perf's memory footprint
> and startup latency.
[...]

Hi Ian,

Thanks for v4, and for pulling the three fixes out; they are in
perf-tools-next now. I posted v7 of the lazy loading series on current
perf-tools-next. I apologize for the late turnover.

Lazy loading stays opt-in there for now (just don't have confidence
yet to make it default, see
my reply on v6 4/5). From reading v4, the two series overlap in three places:

- Both use bit 14 of the symbol flags: SYMBOL_FLAG_ANNOTATED in 11/23
  and SYMBOL_FLAG_LAZY_NAME in v7 3/4. Bit 15 is the last free one.
- 18/23 replaces the rb-tree. v7 3/4 walks it in two places during
  loading: the alias name loading before symbols__fixup_duplicate(),
  and the check that skips a .dynsym entry copying a lazy .symtab
  symbol. Both would become walks over the sorted array.
- 15/23 defers elf_sym__name() in dso__load_sym_internal(), the loop
  where v7 records the name offset instead of the name. Both want the
  name as late as possible, so this looks mechanical.

Namhyung, which order do you prefer? lazy loading v7 is four patches;
if Ian's v4 goes
first, I'll rebase v7 on it.

Thanks,
Alireza
