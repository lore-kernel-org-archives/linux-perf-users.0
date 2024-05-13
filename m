Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0448208CE;
	Mon, 13 May 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620088; cv=none; b=uCovNo5hq5ShyRPd0sufTh7Az1iG/Bg6QLvg31Q8QRBKUgJTGm9PDLiAHwZleI7nLTKD1FGH9AnVywQgt02fd76gSTlV0yI7AeMEM7Lx7AfhKBzyZq3AWIvgGSw+wcDxAZTyLj/Wf9PMkHnXMvDj2ZAqu1h0d1Xg8nhYTh7CcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620088; c=relaxed/simple;
	bh=5w3t18fUZhPXGU1DdXrP+hf6z7XV9qftCg2rlMTls7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS1j3GOQt1Kw1TedZeT7MnczSS9TErNwpknGEuUL5RzUPW8pMK72MkYQXjZ069W1fvUOo/p1Z7gYxwMlcynABDnikeUAObI4NUI630SxV8emRno+XrRI3k2c3FMQlp4LonFD6nWBOxAS5XPnoVBvVsuuj8YtB+OhakTkP4YpGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so4138944b3a.2;
        Mon, 13 May 2024 10:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620086; x=1716224886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19v2OFHX5HNykaPKmmf/pQJmN9oKb4YnIwFLKnn8zuI=;
        b=AhTGaLLNJwzO9CMgPhiGp9Z1XRlktWriL8Si4/NrENx0FH/q9M+B69XS6ryt8MDwk7
         YLfunXfJ9/xkBO5dajqcF/WKhXkpH857njuUZbD+IuuN+sk68K1rsIWYZn69ThiANSF3
         7GD53BlfQlWqyBu8lxBaLlIy/GRgOYTnZMqBqePnZn3TOjI0XiqJKVRTHc1K2HkAPHE2
         GNy+yh8BwJ+tubv2UlLCDhn8IczuiEeBQIsqwxu7gFn0GObN6m7v7hPi8FX/pgwxzoVZ
         A+ovHPzyxrpO4Hbs9094D3P4uayQ2zCOY9cU/tfsbCREzUIJp9NMZjd/tRzQNWjJJrAe
         oVgg==
X-Forwarded-Encrypted: i=1; AJvYcCV1XRAfuz3s6Z5vmGIcuKd8pIXpLaGRrnqOn/cBPeGhDlkzhNsYbzM2fQUrNaekYFAALEmpwJqn2hb/MVR6WS0dnrj/1gGNirQMyKQAnJC+4Tnzrm7PJcMC7lMlJBO2zRkExRyU25qxD1GlxuYQFg==
X-Gm-Message-State: AOJu0Ywxl352AnAi0N3IOhoXUVR2gW0DjTB7HrZGkqKtgeo/i4GDRIws
	ysJBPdxFh00gLlIA8l4POEsbooSN/CS9TPosAms68r1dI7gmeeCL
X-Google-Smtp-Source: AGHT+IFOofykO0WDr7isCvnHZmiW0wlTi8yaXitAeudIwuTRvMIKsCaIwDJM0r82yYawc5TXbxPvpw==
X-Received: by 2002:a05:6a20:9c8e:b0:1af:d15a:6b60 with SMTP id adf61e73a8af0-1afde11bbafmr10903762637.28.1715620085968;
        Mon, 13 May 2024 10:08:05 -0700 (PDT)
Received: from gmail.com ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b767e59sm8002536a12.21.2024.05.13.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:08:05 -0700 (PDT)
Date: Mon, 13 May 2024 18:07:53 +0100
From: Breno Leitao <leitao@debian.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
Message-ID: <ZkJI6Q6KVKlzDgSQ@gmail.com>
References: <20240508133518.3204221-1-leitao@debian.org>
 <Zj-WE1aG7ihtevG3@x1>
 <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>
 <Zj-qIbUN2XFBnvP8@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj-qIbUN2XFBnvP8@x1>

On Sat, May 11, 2024 at 02:25:53PM -0300, Arnaldo Carvalho de Melo wrote:
> With Breno's patch the default doesn't change, --no-desc gets fixed but
> --long-desc is broken:
> 
> perf list --long-desc
> <SNIP>
> cache:
>   longest_lat_cache.miss
>        [Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis. Unit: cpu_atom]
>        [Counts the number of cacheable memory requests that miss in the Last Level Cache (LLC). Requests include demand loads,reads for ownership (RFO),instruction fetches and L1 HW
>         prefetches. If the platform has an L3 cache,the LLC is the L3 cache,otherwise it is the L2 cache. Counts on a per core basis]
> <SNIP>

Oh, both descriptions (long and "short") are being displayed. 

> Thanks for asking the question, I'm dropping the patch, Breno, can you
> try again?

Sure, let me think about it and send a v2.

Thanks!
