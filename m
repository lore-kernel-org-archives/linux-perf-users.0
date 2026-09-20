Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802642E405
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789912165; cv=pass; b=gKm8RXoQnfWdjnawIC7YgAq4O59YiKjru5Vyj7hPbe4o5fAjvoNVd9o0Fa8le9XJco+3bjp5FUBn7TXLbYlWXbOlwFQn/dv/1R46CIRjDOzHJuRN3TXoeO3/t/m6M7S+n0CsazqnDPggDxsPjWS8WAnGK0Usqpzzx309LAMbeMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789912165; c=relaxed/simple;
	bh=s3lTFp6lURx7MrRYn18AT3Pe7UpgcN21QfCy8Gku6t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYpaAe27OHfaEBuMVdWI7/2+9wrk7EboYBitmDg+rHIuP4lSKzwYB2FvSWoRMHvssaBCB6Ql5it8Es2NQxyazmQZ0YhZYgN6M6D7/lXEtrpitEJWvRmp3RXHzzdfsfOi7d9/8CJkTxJ5C80JsB0tYiWM+qMUeSOTu77ouA11xVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=KZtIPNYP; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="KZtIPNYP"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201f9so1754183d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 06:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789912162; cv=none;
        d=google.com; s=arc-20260327;
        b=FM/SultAvixAB4gEWdSxUoE/w0ZtHX6Ok8QATSLjAqe8j2WfSCbeEt/OUIu20/pEYR
         UzOiJuhCNENfHLj0CTcE2302nF9GBwVzH931qZGD3IuLpZaf3/TQ//BOKOSFrgzWaayJ
         W02RluYGNakSfG+RpRTlaF8LTvXrb3auUAP8qB6QzrCzpw6bnrxplto7Ywz1fJ1n58sj
         PPQNx3w89OxwldPZxY75OzD6qUg5ho64vOGC4i16MeUOi3PodfoXGSaNI8guHrqmBpOI
         GERXVb0q4cLlfHv2cpNJIpIWbJ2l21LEOiMUj+nkjwta9HfSBMRuszhrYibKv/hexIhU
         DhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3lTFp6lURx7MrRYn18AT3Pe7UpgcN21QfCy8Gku6t4=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=FZzW2fYVA3ZK6N9D9I8L0Nkg+rtpd8thW/XukxOebWi/Q79jPDndMrwI3L7C6Cw0pl
         d8pTejSWSbm6o8DXTPgZvq3jzmTYbWD71QbU5a5zrA8izMoWEyPVFxPJvAlxsDkupNz3
         cmSka6XK6usoS1a4ULqwAuDvvRw027JADQczJw7nGTHaUo9yRWIyrjmOZm3WHUFXJeg8
         yGBMyJoEOHd1sUExz9hMBaqslInHOZ6rbZUZ05vekX1H9EF3bIiwU68CusDC+rTPgtS2
         q5zJo/vmIPDxG8gUxQd2bCC3GO3kc5F9Oc2VqSO7DSULp/hiMb4zcOuabYaJ5tIpHa5P
         BPPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789912162; x=1790516962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3lTFp6lURx7MrRYn18AT3Pe7UpgcN21QfCy8Gku6t4=;
        b=KZtIPNYP4WD9/vOOiJY3aLDwAPoMO0haticfyN6DM+BcxiNy/4E290MCSqCx6j7ZN7
         dG0pVhPq9vEMUXTg0zCzE8cMii9e45ENz0obdlqOFZOoJAv/D4fTVXKBeWa3cppV+AK1
         8TRyiefsD3mgBNZxojQxdAJ6DFlcpA7ShBzew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789912162; x=1790516962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3lTFp6lURx7MrRYn18AT3Pe7UpgcN21QfCy8Gku6t4=;
        b=BoQS6+E4VEsdJvLnV+F1ssFqBmXv0vSTpRu75BxWpgE51zwOchQoal+P9bSC87WfLc
         qi2UgvSV/mLoZ8xC7E6d4TAhhcn35TdxtTrgqPoyHTPEEFiDyTvpZuzQxjf4FL+hNCDc
         /8OYW2+HMo6KRvDk5fcejg2v6n/Lfp67HHi2AiaVOjJd1/ErAu+4VVtlAynCfP/fmcWA
         Jb+Kgw0WswVLEhdWKKutLPtIiU1PztWt89RcFNdZcgWCkVLEU9l50youBGfC3iilsAn5
         RtQUpI1ps66m+Mp22ocxE7/Fxlh1KslVaqqjwkMwscJG0H2/npMBhdmt6B8hHzcrTry1
         m6ug==
X-Gm-Message-State: AFuF++mxz0Rlig+RccUh7lRd9NkYf7N/y0Md040VE4XqZv7baQcTeDMc
	Tk4BV4koT+zCc9IAX86zXJfLKk6+Y6L0kgv+i2e7RkodHNbICi/JThMKJY/Gw2w6boHdWnh7M1C
	gXP+45maovsRlK5OuxuCOEKRDitrHb8XvjiX5nwsjiA6e6OiOqe8+0SnwOw==
X-Gm-Gg: AYBFou1DYCH2hdoSURZqYJgc7nUvhINzJdOaXtZowk5JPUNRNxomsHNyosOHCzuQzug
	OrrsoPfJyxyJXlhoo9XoCORH0Jby/2A3tqVuJUyboJPeLT3oZHgtUz8QWZ3lTKfiHa6Qkqwdnki
	Ddc2IBdXHgvKMhsloBlPX2DZW9vuWKEWa2Y1yJpl2jI6E2Uxf+QtSd0Zkis9aIjEO9EYExfarKM
	IUly2ZNU8VHkyfMfD+BviytTgl0r7TJ8Fv4tiZ278+JtQG8FYV4lPiaEbvliIQn6k3b5HTB55aj
	tu8J156WhgMktZiV7T2ySqAYwr7+wgodl0Nft5Kcftsc7eBtgnYtTBAUT8sbmzOutWdXKZzRJZv
	RqodW/jH1AKrK
X-Received: by 2002:a05:690e:4393:b0:672:99e1:11f8 with SMTP id
 956f58d0204a3-67299e1175emr912062d50.149.1789912161654; Sun, 20 Sep 2026
 06:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-3-495b8f00ad7c@uber.com> <20260920024557.B51D81F000FF@smtp.kernel.org>
In-Reply-To: <20260920024557.B51D81F000FF@smtp.kernel.org>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sun, 20 Sep 2026 06:49:05 -0700
X-Gm-Features: AcwNN1WGKpnrwDy-gIU_CCYFGPc2CgcA7grptGAj7xrJsG06HBe7wQg-Gy4arJc
Message-ID: <CA+w=M=Qu-R22O3J1_g9HO-f6dv4Uey_vLZZJgNsH8mK53k2K5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf script: Add --lazy-load-symbols for lazy
 symbol loading
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> [Severity: High]
> Can this zfree() lead to a use-after-free during concurrent lookups?
>
> If dso__materialize_symbols_ondemand() returns early due to max-symbol-by=
tes
> budget limits during a concurrent lookup by name in map__find_symbol_by_n=
ame_idx(),
> the dso__ondemand pointer is left non-NULL. The thread then calls dso__so=
rt_by_name(),
> constructing the dso->symbol_names array, and begins a lockless binary se=
arch on it.
>
> Concurrently, a lookup by address in another thread evaluates dso__ondema=
nd,
> takes the lock, calls dso__find_symbol_ondemand(), and successfully mater=
ializes
> a different symbol. This triggers dso__reset_symbol_names(), which immedi=
ately frees
> dso->symbol_names via zfree() while the first thread is actively reading =
it.
>

This is a valid bug. The budget-truncated path can leave the lazy
index active while a later address lookup invalidates symbol_names
during a lockless name lookup.
I=E2=80=99ll synchronize name lookup with lazy materialization and add cove=
rage in v3.

>
> [Severity: Medium]
> Does this missing release barrier risk exposing partially written rbtree =
nodes?
>
> A thread evaluating dso__ondemand locklessly in map__find_symbol() could
> read the state as NULL, bypassing the dso__lock acquisition, and proceed =
to
> traverse the rbtree. Another thread executing dso__free_ondemand() stores=
 NULL
> into dso->ondemand as a plain write.
>
> Without smp_store_release() on the writer and smp_load_acquire() on the
> reader, a weakly-ordered CPU can reorder the reader's loads such that it
> reads the rbtree nodes before ondemand is loaded, observing stale memory.
>

I agree. The lockless `dso__ondemand()` test does not provide a
happens-before relation for lazy rbtree updates.
I=E2=80=99ll remove this split synchronization path and make lazy-state
transitions and symbol lookup use the DSO lock consistently in v3.

>
> [Severity: Medium]
> This is the lockless read mentioned above. Is an smp_load_acquire() neede=
d
> here to pair with a release barrier in dso__free_ondemand()?
>

I agree. above solution would fix it.

>
> [Severity: High]
> This is the call to dso__reset_symbol_names() that triggers the use-after=
-free
> if a concurrent thread is searching the array locklessly in
> map__find_symbol_by_name_idx().
>

I agree. This is on invalidation side of the same race. I=E2=80=99ll
synchronize `symbol_names` invalidation with name lookup and lazy
materialization in v3.
