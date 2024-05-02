Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0857C87
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690539; cv=none; b=iyYr5P20ojEseM4oeYkSU5OdW/ZJ0dJ8oEcIFkr+YnkDZfvW/qkWmg9ZPb7s8GqDS/ubTKcD+KaAavvHpadudAkQOcW9lY3ApUVkqSxhMmkD/yWhqbhsIxX0yx9CXHqeHEQsCyJ5q1S/EdY9q7T956q/r+1Xk9PKU+OmYmsjQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690539; c=relaxed/simple;
	bh=jdAiCkqZVm00u5Mpkujq7LizhSxkgvjQSLxjSmd+0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNk98A+vgfFcde99wJo/bX3QsIE5Vgjxhekpcp3xa2dAyMlCfixmCQ5mB41fXGhnQ+vTg++rAJi4QXrMeKW+h+YDo819nG7xfO0bBdVs+NzrqZIR/aUoGEM86q4gbLscBqFmxzfZbECzGo47lgcwsaGcwM2xFJK29pzgcoXYA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lbq9Zoo5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lbq9Zoo5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f43015b763so894163b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690537; x=1715295337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVZTpe/CdBBd4zno1lRIevv+TY5Lijp2ynWtx6BFty4=;
        b=Lbq9Zoo5ADuUvFCZS6aZyFRnbZNe/xhaxiwCetCzf+SPd6d0pcGtz3C5AdBpBU500c
         zYVHM3DDMHk/OzmdJrYJ3hGkN02AzUwbE1v/2qiR9ynwW1HbxohOZuyC+0TsERKI1Eb1
         Bz1xkH9ygggoGOh6zCdmBFE4zpmB5vZ31od50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690537; x=1715295337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVZTpe/CdBBd4zno1lRIevv+TY5Lijp2ynWtx6BFty4=;
        b=sQAZh4xG9fsPZE9IWxF3jER92GPnnH0qp3YuE0d0HTeWp6iYZ0NnqFfb1L+nJQu5ot
         lQM9bt5gf/MDb/nZVI7tGiN8tfiPXQkuyPAPphCjW+f3oFcvM5nZLOm7T8eNGuWiyqZK
         J0YEBvjt9w9Uyz7xkHZArJEmqD2lcvmRNvJIhUdC4ODFGeJMaeQm9cguLmpaAnKy5g1+
         9Rm4D2jvIXFk8Y/9ssakM32ZAZfEy6giUQiEXsGr6kb6IDkPDXyMRctOl+m8wPcIGx3U
         2GTAjb44FrGOCGbxqpDoMmGYhLRKjNcwswv2p7S+vhnSDF14xFgiB5eEArsIelW9HGv/
         1SRA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7W6BI+j0mfxAOyhR4r+JIW5V8Fjj1bxsxYmVsEfiwheh26poC+Fmp78IpMxjX/QAFMKnmdPZGxzYM8uBJfzK9L2O8UH/rfjgBKznIWkmsQ==
X-Gm-Message-State: AOJu0YwczcTrwk7yar+U+0Qu8mW/Mbv6uR0OE5mSeEv28cOIr3uePLnD
	1OabbkxNF29yohgfBmmYfXljKmBlS6kxRiy89QQiSyuZJ4CeJeivr7gzFaeoHA==
X-Google-Smtp-Source: AGHT+IE3eOeOzKAoJovEuP0RnaA3tq2hqa/aT1L12pQ6aR7WKuRKsLt1bl+kuCC94IGtD86XBl1D8w==
X-Received: by 2002:a17:902:fd50:b0:1e0:c0b9:589e with SMTP id mq16-20020a170902fd5000b001e0c0b9589emr4838945plb.25.1714690537346;
        Thu, 02 May 2024 15:55:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001ecb2179da6sm1877090plg.56.2024.05.02.15.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:55:37 -0700 (PDT)
Date: Thu, 2 May 2024 15:55:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <202405021552.5C000EA@keescook>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
 <202405011317.AF41B94B@keescook>
 <20240502091837.GA30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091837.GA30852@noisy.programming.kicks-ass.net>

On Thu, May 02, 2024 at 11:18:37AM +0200, Peter Zijlstra wrote:
> On Wed, May 01, 2024 at 01:21:42PM -0700, Kees Cook wrote:
> > On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > > > This is an effort to get rid of all multiplications from allocation
> > > > functions in order to prevent integer overflows [1][2].
> > > 
> > > So personally I detest struct_size() because I can never remember wtf it
> > > does, whereas the code it replaces is simple and straight forward :/
> > 
> > Sure, new APIs can involved a learning curve. If we can all handle
> > container_of(), we can deal with struct_size(). :)
> 
> containre_of() is actually *much* shorter than typing it all out. Which
> is a benefit.
> 
> struct_size() not so much. That's just obfuscation for obfuscation's
> sake.

It's really not -- it's making sure that the calculation is semantically
sane: all the right things are being used for the struct size calculation
and things can't "drift", if types change, flex array changes, etc. It's
both a code robustness improvement and a wrap-around stopping improvement.

-- 
Kees Cook
