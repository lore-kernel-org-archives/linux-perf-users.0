Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D336BCC9
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807470; cv=none; b=SOgjh7E+A2gt0oHlCVmil/Njq2XQSzZvyh1oFAhEOg/PDgGfJBBgjIij/agekKHSY+Vrf1D9G3Rn4m7Br15ryiAKIDTCHy20pakKu02N8nOl09haMOc6voUbxiYuvWP3912BFfD69nfHMCK7kJOECJJhsVtOVoqzV9P+bEJ7w+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807470; c=relaxed/simple;
	bh=DAjhfkqLaPEqPW3hbP1w2267sQzvp4ocO7opOaTvG70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSg8T9cCSdrw+8stmcX2zBRwOC5GXNcfATkKFE+3dzdLlDB+ipB1ljri3G2z7dYU56vi50H1ZzCCxnV58d778nV43vYRnXZ9luceQJEWwh8B26oqQTC+y+4kJywiGrDqa36iSgVQnmljOqIFpJV2XirYd0bMk2wWOOUfomRwCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa26KSnc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa26KSnc"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b88593aa4dcso907073566b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 02:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770807468; x=1771412268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkRPDajcyvvrx6SNpkt2bpLqSarE1C9b9sZiA9ajbeE=;
        b=Sa26KSncVXGIjDqt8nSCwrLtrbVX1NCha0pkHIcb1elKE63KLYW8xxAmqYogI9CIXe
         uv7OangJfhdFcdDscnjQUP8qqhqWE8xLPb00OF+Amv866xDx/70oiohqwf6uIjr/KDFS
         0NHl8XFLOMjpF5uYbP1gTEft1df1LdsC6s999STJIKTCpwDqrqdxo1XPYthfGaWcRxv+
         bFTOt0MV6f6SehGm/VLyUJ6bcP7ThQc7r/mpNILhzrQMv26aDjmiYcl2HgEpxCLyLqNq
         VEalZfM25YzDAGQ7hEDrw97MPgbNBiqnakgnhceis3WYFif8MZzWA3HLjJ+90fuCsfqk
         zoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807468; x=1771412268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkRPDajcyvvrx6SNpkt2bpLqSarE1C9b9sZiA9ajbeE=;
        b=Pw2CQFR2fLamL7I3/x//n9KX7AOom8EtuMcqMUZ0iHHoOYaDV+oVczuEaeZz+dtaOU
         meHXJgYFJkKqmAyK/XkWSX9oImHA2qcC2TaQb9nUsgLqtddEUhPtitK9K/69E7DijqkR
         Xlm/B+p121BRcnYhNjRgxF3e3x/DV/XBUyV5ZEMx8JaUcTW8xQWtQEsHgbBOroBOygI5
         0YfjGwzAnLrCU0lL2NkSJ9FDEIvTdPCOs7AU93ZdG0yExJjeUgv9v+y0x/gtsNziNwCJ
         +yWeCYUqaF06qgR8hiyYhRYNurqnoPY7DVAmClhs5ZXYRS7Tc23qK+44t7ET0THlLWeI
         yvqg==
X-Gm-Message-State: AOJu0Yzvl7e6x6V8NO96Yl3kLKlAHHtFyDJj8qKQeqdEKq1aQt9YdTBa
	PUN7s7mMZHlnOlKKMJG4YGpoRgtxMQR5dZQUKEpvKO4U4PADFv+5V3ovS2LJoQ==
X-Gm-Gg: AZuq6aJEgsnOmpJqhWKO7y7FxSQPLyaGT8eKGwKogzj7+jFhXGDJKg5xhS92pNOsEzt
	bQTy0cvLZoq/6Le2E5FjrXDldRMsjrjzuqewCS21/Z/QwGEdFoKkMTMHkucBtGUsgrjXIFTt0K9
	az3wcHNWkd7w7TUdZeFsyL/SovKiFzANz/xeyawOXjkJb1jXkwtFkEfLwxNiEvcmhERIMUWqbXp
	LivQQmdTcJ5ZGrd9Q4+KyBaUt2BXVTzGw6DJi/hyqn2Sy5tIQ4peweCbKEE51pKz37FO1CE9h2a
	RyWxfq8MYviC6+aQJjrIDL1TsrTIa4RzCYws6sbJw2mtsZ9nS2qK8xuRogsH3fhY7SEhcgTO4Ce
	KWojzJDveE6M+04/YvsRSH2HoqP0quWRi55KhfxU088SVikOjhhX0nXS0QxzYSUHVB6dvDT9OhA
	/viyfuPlDvjwJNAykzOGTC7sewGkpr9Ng6WB1kxaC+qYW+Er7aQ0XQ2CbGHPRzg40bfzfGo86Al
	4FBbC35Ez/GjVRs8eWQpJTzxaKZkb/BGb6+
X-Received: by 2002:a17:907:2da8:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8f5438dd35mr334547466b.12.1770807467779;
        Wed, 11 Feb 2026 02:57:47 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f708e25dasm43503166b.4.2026.02.11.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 02:57:47 -0800 (PST)
Date: Wed, 11 Feb 2026 11:57:45 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH v2 2/4] perf test workload: Add code_with_type test
 workload
Message-ID: <btd2b5dqebgxnqh25fvh4i5dzl47lscfgv4x5k6h3hgx3hsp6j@u7hlt6n4cfyy>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
 <20260208122227.3524-3-9erthalion6@gmail.com>
 <CAP-5=fXYKSfefdZ6SdjcDmw8bjobGenR9U7ePPx10a0rGpx2KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXYKSfefdZ6SdjcDmw8bjobGenR9U7ePPx10a0rGpx2KQ@mail.gmail.com>

> On Mon, Feb 09, 2026 at 09:29:49AM -0800, Ian Rogers wrote:
>
> > +rust_common_cmd = \
> > +       $(RUSTC) $(rust_flags) \
> > +       --crate-type staticlib -L $(objtree)/rust/ \
> > +       --emit=dep-info=$(depfile),link
> 
> Does this need to be cross compilation aware? I worry that we can
> detect local Rust support but not have cross compilation support and
> then perf tool cross compilation builds are broken.

Good point. It's supposed to be cross compilation aware, because
rust_flags must contain the --target argument. But after checking it
out, looks like this variable is not passed from Makefile.perf . I'll
need to fix it, it should be handled similarly to CFLAGS/CXXFLAGS.
