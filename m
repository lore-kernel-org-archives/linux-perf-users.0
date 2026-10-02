Received: from mail-yx2-f37.google.com (mail-yx2-f37.google.com [74.125.224.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D443C3BFE
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983735; cv=pass; b=S+1ryvNGiF1jOe749E8Jr7W4njn1qM/nhAA/VfNSDKpZYkIYiaZFcwsrjVliPpd+UtL3THoyki/ll5W8/YcAvbdKgItc4ewLKF01A0Vmdy9VfwJWwOvcOFMFpli48jACueixD5Kp4qPCKklpwnER707rMGrKg0DbaUHUniN4O5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983735; c=relaxed/simple;
	bh=rOs5frUl7ApBA1qQpObFxVYYelIhp/dTTYYpB+JInF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4AkzFqkv+WTqZyAt1wtZAjDLyB6o0G1htROpaiSAtCj4vGhX0IRkjgKicHdY+hJQasqkN8YKeA49x2LiM85PeFCemi3i3IRGAdtsIOtsr0Ash82rDi+ykM2lcLSzOI5syddEbOFlJ0BN9KPP5kdtnb7Jc5ZhwlszhvbRpcfjyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=uH+dAZW4; arc=pass smtp.client-ip=74.125.224.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="uH+dAZW4"
Received: by mail-yx2-f37.google.com with SMTP id 956f58d0204a3-677baaef644so35683d50.3
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 16:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790983733; cv=none;
        d=google.com; s=arc-20260327;
        b=Zfgoz+grIh2i/gWVlJ3SLNRcyZmeeDapAavgkKw0pTAo8gQstRVwYAI9Cd8FY88+El
         ictHYO7XvUXdrk/2D8vrWVCkolCPrKTfsuZBBfV7H7kMK3cNuhGTpOV1nJLDE9qiGQhx
         d98UHio5VK8A2TOUCoLqE0seIa4b7GIFAZMTanczUgXRLAdFMMoCMRxunaNrZQKIj6po
         ftCJG32Jk63utRHBuiA2/Lehk7cZjNfLWVckB/gOkowRefxYjSZTlZalK0WduloIwxVV
         wwTaxAfjIqHQ2gFkLFFBQG76Dntm/0Os/z5z0/rcCL3SqeB5jT0Ef0bZKfHw1yEnb5MX
         VtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOs5frUl7ApBA1qQpObFxVYYelIhp/dTTYYpB+JInF4=;
        fh=Tb1g8OgVtFTDtDh4ABhFz5Gy5IYreiBgnae7sAXQQuM=;
        b=n7lzUyjDR7A5BXB0ctdbG8LzzSnjiHfpDGZkaEUOhZAA7ZOK0qEbwaJmzE+BUOWl1x
         4PU9yjpTMV9CBFMlxzE98m/mtBBa7DnDXf89PfLM3hnBdbMA989+NAuUF5YZtrXlXM+W
         LMvdccV2swN0MjTQP+ggpooYKvXu/npSaO9YRIAJogR2RZw6hcza8bZGNYuK7hvmcHB6
         gL0aURUVLTm1dr7DfvtPDdHFgvqfjfyEvDMe+cATWEBpE8jRyptCI/DjDWibFqwnqVx6
         /bwEYGONWJQwMV8WdEDXQJbE0H6Bsatvp11iJbu8Wzie4auyqk/DKLD3xIqdtXzC2fAS
         vmbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790983733; x=1791588533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOs5frUl7ApBA1qQpObFxVYYelIhp/dTTYYpB+JInF4=;
        b=uH+dAZW4JR9oY/1sYMJGNbEfqp8zPsDMJMGETPWhwWnJX7FXpbBujnuUlNkoZNGY83
         +iO9SOE0BKdFf5NnQ71MWZ2w9iZbgc11tObQGDsLxg9ayf3cGd+WoA9qWRpx6TsC28aQ
         065DQyEoPRNO4tTDB5umP8V78HwGbLutIOi6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983733; x=1791588533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOs5frUl7ApBA1qQpObFxVYYelIhp/dTTYYpB+JInF4=;
        b=vOYO8Too49bgAmvNQw9snIrAQaVmE8VdaGyqDZyxga2tANiBCxzIAQrosTG+cC8dvV
         2JJM9coOjU1k2rWslBd7t2Mh2C7bavPbe5z7JeQR1at1w6iRCw0QPu5GI8blKovpzWJ0
         80cOrIb31i+u35tq+3WcP/JBOWtmbd/zs5rEX81adNjDLZmXY5P92/6NEvBdy558rfHX
         VHoQmm6RJrX6iBC7AAL2oR5E9t8rBQy2gX/wMGNbigfX6TUIcwbUNlTPEnr8mpUp6tOs
         vmTiW3OhJHec5wxKIyLNxOCFpQ4pJHPwNDe0uNLFn7+zYpMh+13RwVq25EjhmxttKRGk
         pLUA==
X-Forwarded-Encrypted: i=1; AKwUvByR9BYtn/fPRJ2zmTio9NzlQg8zARjL90hGpEheoaHxsf1bkHyEbISf5Al/0IH7qf7w08RUmDDr9+odgl52n5Uw@vger.kernel.org
X-Gm-Message-State: AFq9FYLeHNPq7OaWHh3rkVnwSNcZCw7nVcvU6WjrXFFN70S31d6RqW77
	VDYyisdrjIJeGHqxKol/wBoatRY6eG5ZiATx6Issax0sQ9SY0IOrBs0w2Ok9mBoYIXrG3p/sE6M
	u4mw3gj4Op4ILo5lTnyNp412AvocmgtVvbE0MPT/Lpw==
X-Gm-Gg: AYBFou2Sx5BG6Z+MoYdZafc/fKFGiSxjsxYht83Q+iERxLS7jYsHfyj5gWWv7h7vZNF
	Ymwp2zzOX74h3bGtoluV7Tp7HVPSN1UYTyt/QRqBcr4nrEYvmUriICM7sz2ua5ESoKf0Ru1g2Yu
	UXCTTP2vcbdNRoOMXtGL5ZzpwUkuvyCD1qTHe2tB08XJUguMcXJ1lQ39jf+O40tWBsr591+/TEO
	uF2Ks+2F8Ws8BDSYNFrmBTAyYFKgoGLg8hSMqCArJ6hKq0+sLcfHXw4Febq2O1ilruuC47OuHH9
	D5WuiKBybsg/Z2odL3M8yr6Zx7udLuz24aQ7m7blkK/z2ltNyBCWLTPDKz+VLfMITzJzpeItIL4
	0kpaGwjzcc8eQ4ArYoSiHAw==
X-Received: by 2002:a05:690e:d59:b0:677:aa00:24dd with SMTP id
 956f58d0204a3-677abf9d5a7mr1984885d50.22.1790983732433; Fri, 02 Oct 2026
 16:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-3-0a592bb2539e@uber.com> <CAP-5=fW_gTX3oXi5_tzsFo2VYxhcsuuoTBxFAzkP-yPsroAoOw@mail.gmail.com>
In-Reply-To: <CAP-5=fW_gTX3oXi5_tzsFo2VYxhcsuuoTBxFAzkP-yPsroAoOw@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 2 Oct 2026 16:28:36 -0700
X-Gm-Features: AclHuK_XNZXq0VLPIzQnZJ8iQoLi5tbRYCcG5bg7Q-IHQTqgF8BemgGQiDZtpSs
Message-ID: <CA+w=M=T1arGfG8NhhuL9WEBf5myoJ8S8MqqJ2MG=TkMhRwn1Dg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf symbols: Factor out duplicate symbol selection
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Oct 2, 2026 at 11:46=E2=80=AFAM Alireza Haghdoost via B4 Relay
> <devnull+haghdoost.uber.com@kernel.org> wrote:
> >
> > From: Alireza Haghdoost <haghdoost@uber.com>
> >
> > symbols__fixup_duplicate() chooses between symbols with the same start
> > address through choose_best_symbol(), which needs fully constructed
> > struct symbol objects. The lazy symbol loader added later in this serie=
s
> > selects among aliases from its index entries, before any struct symbol
> > exists, so it cannot use it.
> >
> > This patch moves the policy into symbol__choose_best(), which compares
> > the size, name, type and binding of two candidates described by struct
> > symbol_candidate, and passes the same description to the
> > arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
> > that describes two struct symbols. No functional change intended.
> >
> > symbol__choose_best() is not static so that the lazy loader can call it=
.
> > struct symbol_candidate stays in symbol.h because powerpc overrides the
> > weak arch__choose_best_symbol(), which takes it.
>
> Could we have symbol__choose_best() that takes struct symbol
> arguments? The struct symbol_candidate doesn't appear to add anything
> other than a cache of symbol values, and these could be as well cached
> in local variables.
>
> Thanks,
> Ian
>

The lazy caller is the reason it cannot take struct symbol. In patch 4/5,
sym_idx__dedup_aliases() (tools/perf/util/symbol-elf.c:1765-1808) selects
aliases while building the compact index, before any struct symbol exists.
Creating temporary symbols would require allocations and name copies becaus=
e
struct symbol embeds its name.

struct symbol_candidate is a non-owning view of the four attributes shared
by the eager struct-symbol path and the lazy index path, including the
powerpc hook. Without it, the common helper would need eight scalar
arguments. Would a different name for the helper or struct make that intent
clearer?

Thanks,
Alireza
