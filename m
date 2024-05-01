Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E21635CA
	for <linux-perf-users@vger.kernel.org>; Wed,  1 May 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594905; cv=none; b=TlK83BA5XE3bCZuxi76Vv4Zmozl20NMfQ5mqYEcF5DFe0wSZhOXR4Jr8CIKLqVKGou8uzjHApSmsnmMErMEw8M6SIH/r409m6dK/EEGZcOgN/2UoaYTKw6KUQULk2Ab1h5dC0q3+mmFFg6/5VXhrbBplVaOW6V7iBq+mX2W/B/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594905; c=relaxed/simple;
	bh=nPUrAToma1+IWJyW4NorUHWTJxgN7XpkT+ZRrxLkDoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaTUsDoITPL/rRo1ZgSxdqRnrW+Wc4BGzR1A1w7kB2NTrcdOq0+bg8w3zojGy2l0KTArDkoSIqb8avVdNfAKbAeFivP7MF1lYIihjqP4wo6pWdNJVbAwnymLp30KKvqIwcZjb/P0MCHsP+SuNyD4soxCYaeGa6oerBvPvVs7TLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R6lC+wyy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R6lC+wyy"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so6609580b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594903; x=1715199703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9pWF4P+vg6CtGHnRoqbJlxCPNRuZaXK34HOYWDy6qo=;
        b=R6lC+wyyKGv555bfAgjGaVAhVKeXMz7DYH5NnAacO7JbE3z4cYvgn7VrA7W78G9SBC
         S7iBlI75R5bcbxhAp/NRCcdjk5sPlNqJlXepxjuhYdqashwgMIqfeWXynm6eKpV590fm
         yZNlK1OerSDiXNTARj6eGB6JQvl7NcJ1kAGF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594903; x=1715199703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9pWF4P+vg6CtGHnRoqbJlxCPNRuZaXK34HOYWDy6qo=;
        b=TNrMWrO8+WG/2kPnfrbI+TZj3rdnauUDSgb8sLIevghXSAEznqEdUcMmLtWLQreVOu
         vZjh0vM6XA6WO+T0P5rtYxWdE4gmE3xB1bBQlNrGvUX10ymqJkbWwdzY4c0xbbnkEuQV
         +q8HpFWYviohbqossBSDApXktj3lMQ35yl1z6XEELeHKEPFP932Jm8mp+VZ7ARl+DHzW
         p+RfwNshDB927PA3gN6GgghvFsQMbMtX25fFzSDpUsDFIz1CsFXGlb/sJvu4l+JJouQx
         UuzNliQ9DdTV6pAQinQIOXxDe0NSfkeaapRs0x3NqCsD7dBR0sHWESAA2119o3BKGHE9
         AS0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7OFkUomjYNGhEwoeKatjQBE9AG6xNCg5kugzHKZEKv6AOpMSdOZo1eoj0ym9bzKzddW5vxgSc31V47YmyYwiPdhs2pkNF5gktTwDQAwJ0OA==
X-Gm-Message-State: AOJu0YxJhjEl7Unn5EqkZW7w0hMjIN5KCoK7coRg2VJIm+lUbs3oEDmc
	yqf6PCvJxGAW/m+fASxZhtwmQgJW9VuHOW1bUs7GPjMGUAj0IOGaBJp/HrDJGw==
X-Google-Smtp-Source: AGHT+IGyvJ8Fbk39B3YR+oN/YqBuq3FvOn0WZU33SvV3xChl0KcHhy12+GnrIWpDME/qQK5QKb0o9w==
X-Received: by 2002:a05:6a20:9f88:b0:1aa:5b05:7926 with SMTP id mm8-20020a056a209f8800b001aa5b057926mr4987182pzb.39.1714594903411;
        Wed, 01 May 2024 13:21:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006ed045af796sm22947779pfq.88.2024.05.01.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:21:43 -0700 (PDT)
Date: Wed, 1 May 2024 13:21:42 -0700
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
Message-ID: <202405011317.AF41B94B@keescook>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091504.GC40213@noisy.programming.kicks-ass.net>

On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> 
> So personally I detest struct_size() because I can never remember wtf it
> does, whereas the code it replaces is simple and straight forward :/

Sure, new APIs can involved a learning curve. If we can all handle
container_of(), we can deal with struct_size(). :)

-- 
Kees Cook
