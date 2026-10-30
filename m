Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366554;
	b=ADuy6nFxcIhr5+e2W97syq7lpSEvIdZTFvp1W/ZcPeN5HLqtjjAv6zXhpI64b6oEO7z1
	 9LipUci3iUrWCEstObsUlNBvKHzUCqk+KC9Hj5rKNtWHVtI0V+FeKBnWcv6WzNrGpfcZI
	 Mw1+W6JyvX3yc2ShZksj/4EG4q+eWqLVXvl3bQLdYdySlW7LyGbOX8DW+A9EmGtfOS3E9
	 IUq+B7yQYorXoC0zmwsiXTaYsCyDJj4qJyvyoxF8JggnCv+0BOnOn7FyUUq4j9GBKy10W
	 tORbBJYEcFghdiAdHCuDgDDKNLv90sxGNGjWqchyI4WP38AgmALOPckvBaMakAIqpow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wDbS/KENWLlu9JTjg4GkcGMa8Vz0Lw2ntMasExna5uQ=;
	b=jbzjaXnI5gobCahuPXcz17WrBkFsCMmtqcPtguPpHFPaWf/v7QO8iFtF30t4NhPYAZrK
	 HOGMbIS4DIU3oVusYETAxgroDCB5H8a0jJ2+mKrmn1h1gTEBfH6yhWu8bmbUqHSkhLPc7
	 vd/uR7oGQIDUKFlvSNuwdouKG2U68QWQlvqe5cvyKVhHp6peL2T2v65HxCIOqy0Zm5H2j
	 4pR3itN0+BfXLlXXmKodYGhW1LoVHGEh7LiAmCaGhsA/HztLMYpw9ECBBP/w3/BlL80yz
	 6++Ooh6l6oVQ0vHBXP1u2GhMTlLpLP9E5AefzV2uN8FFm/vEOPFdxTrZEkCEmHNU1AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=PFFHII5B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AD606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=PFFHII5B
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-676858d42f8so578372d50.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793366548; cv=none;
        d=google.com; s=arc-20260327;
        b=alrpSz3To4ciy7pnFgaCnkGOXd13s1B9IGXKywutAsUKeL5NCFdz6vy4VoggAXjmUH
         pHtXiapFyT/7uxz+547GGTK+so1rp3oXX14VXOoxAkkXnLTBVjTn5e1HcZZ2lYQjnSdY
         Z0yoHu8odcWlRuZmNa+2JpMM6n2eZD3QQPyRplOhJC/y8JPovbaYNE+JRZGYLlIyQeeN
         zZqAFIVsz5EfNy1jzqrtsn8TotGao9UyQErHog7rZCKnefDVrCsb8UcxddPHDXmHogks
         ZPrbVPJzv4fpGCgxoKzdH5YwVzyhGwZWsFh2bnVFbp5aCJ8FSZ8wp7cBELGTNIw7h4kO
         ts6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wDbS/KENWLlu9JTjg4GkcGMa8Vz0Lw2ntMasExna5uQ=;
        fh=cUpbhQsduZ+XxwbpFg2aKG/cTTCj3sjY78kLXsnfsiU=;
        b=Abs2CB4oXbeSNJPO60tr+67nGDW4NfVMMmQ7Wc65dPdFqm6XBWf1H7PA+4JImf6Kzg
         AyRgn+FLq0ZdDwKZzVoP5ltxxxUbYaLVtsucCdvsefkpU0Vhp0GDrKNl9uoXNMHR6nih
         6r0TAtHvpGW3yE8nwXgqkeq3UbBxkY0B9eCqnf9vG/RQOob1bTLa8UPeJDmS019RwNOU
         lYfs2fVnsgFZHmtTkHZqG+J03wEaj5SkPVlQhPvLFy11/LWzyQ2BjII9l2Jh7ZmK/eyD
         Q+doieUMvEHL+enfdlz4WKfUGUBMB9ziD5NDH+A5Q84Wa7OECKLWM2dARRXrY/TfHVPg
         bpkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793366548; x=1793971348; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDbS/KENWLlu9JTjg4GkcGMa8Vz0Lw2ntMasExna5uQ=;
        b=PFFHII5BxiVSfubs582dOHaqArRLaVXV1GGLOaYmarCMKjAY3gqXC8mHth9zsDBRQb
         ZWCLEjMZbY4pSyXaaGyJCs2ty3rjSa6hkzw8rwXyWNSxywTsyzH0sniGu52dtSD4k0m4
         uiezpq6AAwU4VMPjytD1nY49bybrnYMvBVjew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366548; x=1793971348;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wDbS/KENWLlu9JTjg4GkcGMa8Vz0Lw2ntMasExna5uQ=;
        b=K/5TIymM7Py2b7H5UIYBk1XRrjELvFb25qvuKQ4L1NqXCSQNH0LDQJ0t9IPCca6GSh
         LftsufZek+xrIZlD/+yNjIhyP7r2eXOD3xFDd5AgjLvO3szDpbo6D/mhotPngiH75MCP
         BjAZFQGARlL2V8A36+dQcFRgGsDtbM/NbLh1Tq6HUWbSF9r4e78Apkv1PjsdXxrY1mXt
         8Vh6KwH3jVoYZpIR/UeT6QOYFfiktl5/XiwnAIzdftiZNKiN3F/WCx11Ml6hzHiWeEW2
         4WP/kuqRNbX8fdn2BdId8FwHeX0Vc0RLJiOLNjOjjpOuYRMHbKxkgY/oCJqJ6DuptgM3
         8vFw==
X-Forwarded-Encrypted: i=1; AKwUvBznsEOtueq4g5twgJAeCGTVJWZ2XlBexpXpHEloQwG5a3cwfVSE18E+zJgM5wL6Kh1WuwHJb/niq6hoPHnJfUdk@vger.kernel.org
X-Gm-Message-State: AFq9FYKKH2JU+bQ9Px67iynVOH4alxG+I9RHUs2n4R7iG9ZGeY7NVzOm
	t5fcBf5DJMzYaUjQlprAV7grkrSpn3VRxU4oT4HgQxd1bbxtraQcsNETEAPRJ2RIb5L5JG8cHmC
	GdT/mvpTNwCLdPjr1gkPoundpgQw26YCv3UQxm1T83A==
X-Gm-Gg: AYBFou3h5TlXSTmG8o5zkFPfqDgGXfg42MDKrr8l8jmHgBMgzIctwsNr6iWIBP2zfy3
	TwaX+qob6mLy4aSduCf2H09TI5Gt4IgHLGrLh55JHvDaV45kKUmT9SnzDwiiv0T6psp/v4B7yGC
	KkTroYImwKXV1qVzfP6lHE1oh8BTJwSLFy3G69eeLixEnj2et1/w8y2XqgetrQ47BmqYdRI7h/V
	D/NRbijXCK3ACidUMiawPGXsl9wtMhr6dQaTEy46d904aRt+X1O7TBZ8YhCA0coK0DTBHRp8M1d
	n+HJHG2JpqdTUIL53xYrP1tirJOt89bugGG6cgh8zPlxtFMi6QIPXkrcdnoWTqHS6QclclZ4UbS
	IZBs5/LRUlU+PvyBACBcNAKnyUdWryT2a84XiUFcL14cTITxke55LX2kOVuhoC0gZWOPAyg==
X-Received: by 2002:a05:690e:d8c:b0:679:91be:2aa7 with SMTP id
 956f58d0204a3-67ba4f54999mr1158346d50.76.1793366547261; Fri, 30 Oct 2026
 06:22:27 -0700 (PDT)
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
 <20261027231513.816148-9-irogers@google.com>
In-Reply-To: <20261027231513.816148-9-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:22:11 -0700
X-Gm-Features: AclHuK-iiL-Ld_wXLssW-sUHXFNxuacVIP9_dp_rieEmV-QPdsLDk7h2zP4f03o
Message-ID: <CA+w=M=QyQLD72nrdHMoq+FOkbhkJ7c_5xjm3j0NEbEq0XJRUNA@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> struct map_symbol ms = {
> .thread = thread__get(list->ms.thread),
> .map = map__get(list->ms.map),
> + .sym = symbol__get(list->ms.sym),
> };

This fixes a real bug and worth it's own patch ahead of the
conversion series so it can go to the LTS independently imo.

Since commit bffb5b0c0976a ("perf map/maps/thread:
Changes to reference counting") the temporary map_symbol in
merge_chain_branch() has had no .sym, so callchains merged during
collapse lose their symbol. With this line, the default
'perf report --children' output changes on recordings with inlined
frames: a line like "|--35.41%--0x55566d988a0f" becomes
"bench_sched_messaging" / "group (inlined)", with different
percentages.

> - frame->sym = NULL;
> - frame->sym_name = pos->sym ? strdup(symbol__name(pos->sym)) : NULL;
> + frame->sym = symbol__get(pos->sym);
[...]
> - if (frame->map)
> - frame->sym = pos->sym;

Before this patch, frame->sym was only set when thread__find_map()
found a map. call_path__init() stores ip = 0 whenever the call path
has a symbol, so for those frames no map is found, and sym_offset now
returns 0 - symbol__start(sym) instead of None. Returning None from
pyrf_callchain_node__get_sym_offset() when there is no map would keep
the old behaviour.

Smaller things related to this patch:
- call__parse() no longer records a call to the same function, so
Enter on a recursive call in TUI annotate says "The called function
was not found".

- builtin-annotate.c now takes a symbol reference for each block_range
entry, but the process-global block_ranges tree has no teardown.
Patch 15/18 retains symbols with a refcount greater than one, so any
symbol still referenced by this tree is permanently ineligible for
shrinking. Could block_range get a cleanup path that puts the symbol
references and frees the tree?

Thanks,
Alireza
