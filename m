Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9753E7155
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175421; cv=none; b=Q8POt6uD/uTP5trwWy0KZS1zew59/+QIri2GEk37J3bAp5nAlokCs+vC7/pJ5g3+j3a/ChqzTZoM4QspgyZ8vfJQ9kxkTkUzUO5fjN5IWKxXGr4BSSf10McF+gAn3KJZVPOVK5ois+zwdulpk+K9eLux1tDRkUjg71Cce/oEpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175421; c=relaxed/simple;
	bh=dn7cwF6qtgGFLiqp0cvEjfsbZaGhIy7LmJ2lctcWX4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9OcDgaseO/e9CiLa7NZFMWR6dD25zGdSJ23ML8An54z7SrkgAgMf7jaXFQ+fC4IDDKN9S+D8RGF3R526bgJFziUknndhHNDxrDPPG4bqbsLGWvrX8ZLKSdWGtx/I/zt0ff998G6vzQgkt6/XmC3W2Pvo4KM4RNmTuebqIh97yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCNzCa1G; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCNzCa1G"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c04152730so846228166b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175418; x=1776780218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAO2a8iejOd3UMUmzAscWYPPXFzcVg9pYpLVhKBtzBc=;
        b=FCNzCa1GvUqMYBjcL1/1RMrQ3YUDQrVQ3gYQW5lDIvS3p3WzIYjgmQG5c4bBSi8/5a
         YmuLNfT5/vvDjZpvhA2uLQq46Ry5zYKPnKtsXzXAEMwCC/u3xKay+W6OzQaIbvK7QwuG
         Ws8aT2stAs6UzfwZImKA79UC3rE8xZd/07pAO1fRJGCe0u5blzOFSlV/TF/mCy7170sJ
         ksvfZj8uQlZdcJ/CHyf6LYrbBAvv75Z37S18Zq1V8QZ+1WXPWCuiIq6G879QGp5YbIeJ
         AaDo9NIc5DErWi0TIs6EcQ2Ng/rv4zewrRLD8tllbNbZI1Yjw/iRAGOYQrldLVGMbb3O
         EHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175418; x=1776780218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAO2a8iejOd3UMUmzAscWYPPXFzcVg9pYpLVhKBtzBc=;
        b=YSyzORT2LmRud4JyB+UpGQ6heNs2SV8mDo5+JelLIqCMKPE324Ix0XDR/RN3+vMyBa
         4SwQC22QvRAgU6Lrbr7BQu9bqiytou0Ne8p4pP6R/k9l+T4w2NURjOO+SxC/fPvCDMS0
         jjwX7p8YSOjIKny9nSNMQNE2Zs6cHzjPxJEkP+8NXdk+g+GZNtWlJxVZrrFqDPLeuiwI
         tSyXuKlVyPRdveIzHo2ciBdQtj2ixzU2wCdGVSs9uZGW3v8DnWE2wuN034rTDZnbofpg
         V5dDgVQbjVp/zOdcW2NllUzeMg6UZMogcniKotbH8kPWIs8s4D7MCi9wkwpWPyEE+a5a
         Kgfg==
X-Forwarded-Encrypted: i=1; AFNElJ/WdaCQ6QoAYS4WmpoilZ0MyWjPrzLhYSOsjvYYxV+wrHNGruqRFDu12AlZqG4SLZ4Q10E8A+p6jvpS7gRL2NDn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvr7lzblP2kukOtrMLdsbbTBCJQ/uPt50TCtSPAxUkI3CWzzdd
	rjTuStMwhaUCqfGJR3wt4DwiFwWm/4R7ztjtZqvBHA+eLO2yT94Roju2
X-Gm-Gg: AeBDietSWJjvE5+XeyhPej1niXGLB50irlxHKAuQ1Et33F0sCAZ5b593sRjR9v8cQ2U
	+5zJOvIylXA7y9t8kF4OyRE+2p3+Rd0ouM2SdzLcAh6L8PLidFHqUwqN/qTmStiTpr/UK+riAp9
	XHMZvBltp0UpFVwY7pplvtBOKlgPr/fPU78WfLjIzhFtHwQVfTV/tLSdWrHqcljbK1+wWUUfhIz
	m+6WYew28nGWraGCSStjG6g0qBl6wJSy6g/8sDH/uOb5ylTxwXxl0cgEFAqEZQIo9FfxX0LvsMC
	mXZGWBvJIN5mqeBM/znIIP145F6OgZZjTn08Ii0LQyBIGnOmz1i9XQlTQoh6jQKdHMt76iSIGEz
	B18NaPkEQuJSQY6CyqUi2xZwz2f136XipQalPKJwrrERPuaOu/SNT4IjWWoxGnUQs/n7k+1evqK
	hNXYOPVdH5E9GYSUsHSSOnBgGZFgJp+1I8pfGyfsUnaFvlzLIUmY4JW44ZsIJhuZeauJhU4bHHp
	9dXjabx9TrvUf9NElGbd+QXariM4opwGDlq8g8gQKE6LC/J8x1r+Njop5A=
X-Received: by 2002:a17:907:1ca5:b0:b9c:b3b5:bbf0 with SMTP id a640c23a62f3a-b9d724995a8mr1009594866b.6.1776175417496;
        Tue, 14 Apr 2026 07:03:37 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-084-056-106-044.084.056.pools.vodafone-ip.de. [84.56.106.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dffcd7bsm384122866b.27.2026.04.14.07.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:03:36 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:03:32 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: WANG Rui <r@hev.cc>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, loongarch@lists.linux.dev, 
	Haiyong Sun <sunhaiyong@loongson.cn>
Subject: Re: [PATCH] perf build: Add clang and rust target flags for loongarch
Message-ID: <63jg2bzhv3udm6meehux5ssxcd5gfdksamuzhjw6cnxptztbph@wtwbe56az2vi>
References: <20260414080500.320095-1-r@hev.cc>
 <CANiq72=c2wniA2piByZNUVzSUA2YPhRPKBq7e_bBP-69Lo+wCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=c2wniA2piByZNUVzSUA2YPhRPKBq7e_bBP-69Lo+wCw@mail.gmail.com>

> On Tue, Apr 14, 2026 at 12:03:31PM +0200, Miguel Ojeda wrote:
> 
> FWIW, sounds good. I guess the commit that added the list should have
> had it to begin with? Cc Dmitrii.

Yep, it should have -- as far as I can tell perf supports loongarch in
all the other ways. Unfortunately I based my patch on
CLANG_TARGET_FLAGS, which turned out to be missing this arch as well.

Acked-by: Dmitrii Dolgov <9erthalion6@gmail.com>
