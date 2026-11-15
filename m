Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794718355;
	b=NZCys0YNywg6Di766Nd/RYGOHvtLXOM2VTrhRgbIbb356Uc6AkBJGOTy/yn9Qvsapfr9
	 w/E6xCHVnegh93P3Idpfvn8/zYwhfrJcLHV4WTKQTbYD3xwIZP7EJ0MqWDvZYOjQy3fEL
	 wgRpkLzPtrRAqHt1FYskiKFFk9nniq4hA6wUFWBGGoGAW1TBzHdo1u+s87BtBgPNbL+3X
	 BVpoBn7b6fJMyHqchP4Eyh+IseuMAwym/MTq/3bHzAZWr+f132/XKNUn/TQnmMG8/IDb4
	 7lEE6QTa97iwGFWKRbvFc1Vmogu65I4dSEuc9gMHp4Op2BYvQ5jus0UZF3EI6MQ3b4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794718355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=H4OYy3kGcHQe3q8wy+eXpmSYEjj417UWrJWf6YCRFCQ=;
	b=bG5aRl7PwBczdM1PnYZnjmfXUWNRAF9NMgNrjyd0Qy65kw/RVFHh4x0vFVWDxgGqtJc/
	 tqaRYWMAZGnJiD+94IOTODZv5dg/pUuS2jIjve5PsgbLu+/Rnv/vO+LMxJJlGJ7M5I18i
	 wiSKJWYp86PbVA7JDDhh9JEZcz384iuW3X/5MVpmjlqJWh84nLPtogO1l4iy/ox64HeDY
	 kMRgQQRpEagZZzydwZTM7x0DQLm+LWrtRiBCg1m+YTYaux3EBnlwNHaeT/NS419+WoEWM
	 yK7Kf22k7nTgwDC29U2/5DNs2nUKrD6DM7SeIRYRaTVJ+hI77CTcU8bQOOXwg/nvtPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=N5ZoctSu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9A606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 04:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94A9A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=N5ZoctSu
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6798af41644so1658120d50.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 20:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794718353; cv=none;
        d=google.com; s=arc-20260327;
        b=Yyw5fQh9xl0s4c8mo7iQ4nYN3/POcVvvRnD/bLmK4b0L67myJteh5vKhWnHnCGTF+6
         FSDGIyjO8XjyfS1WvbHBKhkeeLexsHWvWO0OhIOyoVE3w/hpINCv57/omTheUfO5iV9J
         /lnn2a0haYVZPoghsdKvGxd3FzofDNpIfPCvZxxk319F7mE2kaNXV769a0k1SyVXSNL/
         SBuI6dfmurnkb7+rVwnCV0xE6sunC9Lv0M9WErNwHm7vYRHGNfnc+Z0DX96WsgHEiCT4
         niqTsfgdkKVUQlJmZTCEjyObfnzt8MEho4i41RYhRXlaq5tB28oPZyvCOkE8LQkGGQ3O
         JuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H4OYy3kGcHQe3q8wy+eXpmSYEjj417UWrJWf6YCRFCQ=;
        fh=lt6Kuamu/0jCk74aqG4wkajJ9Z/Y+z/bVuYHxLCCyn4=;
        b=IGFSSXep/ByEh4nYq7T15pJzaQ9ekFgJO6SIDLvC1+ikN+Lqnsty9yD3ADZvS79Utf
         o7cSWigV06EM6zdylPPPMBHcY8q+FzgHqmmDDJDC1UUetWdg5faQzpqRNiADowGcC7GO
         2M27PnIPHTv5pSHXzUR3I+V1VVvvZSVBm7v6lYwcY+nZTdv+9f43nblDFe0I0LmOP2Pc
         orRQkL1fsDeOxSHHHgq66rIv5cAJ8hZja2IJXE/8fUFHIfq2SSP+Rb8s5XlFK8xxmJBW
         OIQ9Ttk3sXQU+qbNwxSZNKHD8RXyhxGtYaEdP55edCl80QDMqv1cpXhYhAlRoh6Ecja2
         2Ybw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1794718353; x=1795323153; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4OYy3kGcHQe3q8wy+eXpmSYEjj417UWrJWf6YCRFCQ=;
        b=N5ZoctSuX9R+wQdRPkBJLINCVEYk9LECs4v2PTcPW4KCVOAIqj/zO2cyoQtbz3ZqCk
         g4t4hXNwd2mcDU34s5C2dOEntwah15iOTRyJK+kWdtLqcQyervpAsZvnxi/7Fgnll/v/
         xIPF3jccDm+uW/F1zJMXWnJmNucRH+JT7TmP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794718353; x=1795323153;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H4OYy3kGcHQe3q8wy+eXpmSYEjj417UWrJWf6YCRFCQ=;
        b=HFVNIShlrFqSBsTAUkHtDPSbJ7axPwY2ZDZlgof36SJCTb4ZO9kIMoTd446HNSzNBu
         2rNYmjkuI89JSAusk9MlZ2UsKQjYvW/Ww1qFHBzbBmduCVhq4UjfbpLAgEXMWvmSp0B8
         l2lifLIU2h4/wY7/RH8vXi2q/7IXH/yVwqs1z+bfAaURJeFBu65gYrs62anCIQfEPspr
         jgjGKO8Gr7KLtUol85P42Euvl+kx4BxPdhsGwZPDDyWBTPO99f12usqMc9A9jVZ48dWW
         O6Wtut3gefwpDDmZl8le+nWM6ullrsNS/22PK2dF8Ty0I+yLEJHaLAD3qvh6DJbzpJv1
         DfEg==
X-Forwarded-Encrypted: i=1; AL+hErGHEWoZVuR4bnTma0ENOGl2ZVuwNmaXPLdEoVCxVaflrbXS8URCDslV3yKKaLyXTluAKTAfj5fBv23A625zV4fs@vger.kernel.org
X-Gm-Message-State: APuU4Z8TKyVOXIcLoUHsZS1vvYgJj+9m8aWCQ90FdorRH+wUnA5dsCgz
	fDd0s6LXGDshGlPTEc24o4kgCuvPWNBi4Wo8e7hpd04+Rx4dnDcTybTOzXtS7tSIR++Rgc7peC6
	PMTrXufmaPB75v23bXMBDjfK24TvR30L0gRWFII55XA==
X-Gm-Gg: AYBFou2a7QOupW77KyqwixVOzIliXUcW8vuhVHjRBo6Pnz9n+V884k8SY85OUqVjW8g
	pz5mrMpLgssmtNYxQKUhHqzZuU+CjdGtPaSJqYdLhF2tObKxc1AsOmToBsq0A4HSsnW2oLzVDxp
	fRQ3+lPFpbNTORoBTmnKIh3Pq3VYRgP5hBa8B8Rh8kCtQ9ykHixYlJRlFtUg4e5Z8xIPM4yCRsa
	GPyiC/RkaQXOqJmcxPvjLlE2Lz/nvKTLcw2UNAjzmN+Xno1HXUoOxtvVUVL7bzQAUEfz1rvKz2O
	wQNOAtfY9fLT8bNorIEtgJvfsKWrvcuZ9QN26Nr5xMp9kV+2A+HDXuVOsoCJzRvBKl01jWt4mb6
	Kk5MxcsPRqet/IsdygA7s5G0eM3JOvOA5jiFgRl/mKY7gE+ns3rnPJ7DG3zwmf09sfU1ajw==
X-Received: by 2002:a05:690c:6b12:b0:8b4:d1d3:3729 with SMTP id
 00721157ae682-8b4d1d34297mr3204737b3.59.1794718353336; Sat, 14 Nov 2026
 20:52:33 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-4-7e90415f0101@uber.com>
 <CAP-5=fU9Du9cCge2aTm10ejtwBKX1THQpm=h7EMR=WVQLww6DA@mail.gmail.com>
 <auacxQZKtlFa9Pc3@z2> <CA+w=M=S-H4d_-KCZJqdPoUCyfYtNDsKLd8t37kT134bwpKD7qw@mail.gmail.com>
 <avkrTBAE08wB5Qy1@z2>
In-Reply-To: <avkrTBAE08wB5Qy1@z2>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sat, 14 Nov 2026 20:52:15 -0800
X-Gm-Features: Aa3M54rO03zK-6zPMH9aB-pRaLogW0cwWWxarWSNqRtSpROzp42K86ZauPMHxmo
Message-ID: <CA+w=M=Qxu_-kKkax5HkJoJXnivNTHqfpNt7qT9UKUATsCFLK+w@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] perf script: Add --lazy-load-symbols to load
 symbol names lazily
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 14, 2026 at 7:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> We have struct dso_id to identify the binary.  The build-ID is the
> preferred method to check it.

Good point, I'll use the build-ID from dso_id for this check in v8.


Thanks,
Alireza
