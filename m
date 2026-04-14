Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035E3D6495
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176218; cv=none; b=B70dW3a5L49QaRVAovdK/lnlukKriz8L8cqloPYTUyN+h1iZrCoEBGpVis2/PwRFzlAEf7/lCasKSYABHLXhp/L5lE0zRzUJJuzVMdjVIfHBP61BRh60bhl7me9/yH8VWiZnuEh15+7iEXjt2/0TcQDr2v+MxhOQq7JVg6mYHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176218; c=relaxed/simple;
	bh=HK0VkgrMjT9M+SKZuCcEdJVW/09Re+Jky0jpwkhuOFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6GnmDZZZvBKE9p91syp2M1oDY3/ILdMg8jzj8hj+kpala/4qFRag5asJJtkkh3zJPjkF73ughDz3fgRlWFl4MonPSmyta8A47yyJovaArXjVhho9cULwOuJ3LGoBBjFZW8iclRQKMspMSI45P5h+VijeV8rz2UOlxR/ghRpUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh1Qe33k; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh1Qe33k"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66f8f556f39so7607262a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176215; x=1776781015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTGo+ZcE+Hh2IH1ZVYC1AB7M8Q8skYrTWtzq6eChQ9c=;
        b=Kh1Qe33kstikxHnWiUBLBZTOmvQrj5C8Mc0ELhL07iufKdSE2vsrLNjcaqi7PSpOmj
         rNE23LVfVMFbtyR+fi6NR8dMcczP7jMCu5nlOGUttImoaYl6grumgWoTMfo/ahA/SEZJ
         sL02qGjnQiBrwRaHsnHGYPT+V+8ACDVPF7+k9M+FrF0XwJ8I6TaXjxjURmG6ll/w0mIV
         7/3EcoCfcYMBAesIEU9UK9MGVkSjHHO3Db9qUz9A/0T+DJdBVnBq4o5y/0qI5eWeqjNK
         8V1OWU9LoYNUVRs/jFkXcGl6uaTvy1sTQjnjblIF/TzhXmbEFpOaVg3o5pJuNtuAYpfV
         4f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176215; x=1776781015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTGo+ZcE+Hh2IH1ZVYC1AB7M8Q8skYrTWtzq6eChQ9c=;
        b=K7p+vGbjTh05tjioIcicyJUbCOah6pwJk3TkmVw9+VuRlVROrXo9S0JraDgVfk2U/3
         bsr1DcG2ZLMrpgVKW07s3BmW0C+JyX6W7q2NV74ho5s1abG5Mp3SVLDO+u5visAOIHpw
         Sq3Dhb+RekZqYDoYiLbIZBA4/3Z5xKgt8ia0ovj+IT+S5qxFBMg4penYe/h4if9m9NG6
         yEgO0ijoP7ZSsoEiqltGvEVpWmbLJYS0BbUF+NL5dsGLNNjZJ6chDs7tUEIqnclXOppy
         Oim1/LhUyu/6u2vVYpB7uk0UwZU4GIMfP1ww9bpakcpHFoBB2xyGbxxFujMkhmv92Ycy
         oOWw==
X-Forwarded-Encrypted: i=1; AFNElJ97hm/doMIMbb2tdEx4rN05JJfYSuv4ehIe2vTVRu40Erl43CvSUVkankkFbRClNsD7bIJIR5UaDvHoI2WM14V4@vger.kernel.org
X-Gm-Message-State: AOJu0YxjK+HhoZtjBm91dQRCS1HqBB/dm20PgnKIBgmlh12CPiImXHvX
	7/zCehrsXFRmOGslpw9mhH5YC/RhT54xDMsPBQRkr4qngTQp4bzhxtp0
X-Gm-Gg: AeBDiesgpja+6QWkA6X/0OJnVKuhdZlZzq9dwSPn6lnq+Qt06g26+nQAMnqb/5jqhjb
	YYxjXpJkgsenXhfETXbJ7RC6JHuIjM6eMaukjQEQB7Dtoe1cO8en6c9V6+X6d77gmVMD7pW9+k0
	FAF9bujby7fqxC+TKWp8D47Mc1SPkfiTdwsgaeL8yGPYsaQ+2Wznl02K0pSkITwY8yCsJpv2MIT
	ZMPz+I4FEVlubpXz0g9n2a+e0U3zqn73yppzDGbtN/9WaEKX5BxgETcLKvB+1/LY7YCz3VnPKaE
	KgIWhYD5quSdssoUP0Co9z4+sizpab5caKtTLm331r+LAqiFV5JPdTX+2d1h6RF8gx69Fu26vLm
	xia2Uo9g94o0M2kkgf0aBRaJcWLAqoozJI1bMZM57zSNf+gVY8SfrCJuo1yRTp9kYxZj0iBdNTT
	DyGg5YSfCfmBrKsFHtNHGX312lS2LacDuLabsZjePAT3PhHVX2F3RTKEsnDVKPWq02W1HSfUAeD
	FgLKx3tQYwduXAGtuo2q9/gpNwgJTRk2aBftKff/swdoOxG
X-Received: by 2002:a17:907:8b8b:b0:b9c:9594:e00 with SMTP id a640c23a62f3a-b9d7277caebmr981980566b.1.1776176214831;
        Tue, 14 Apr 2026 07:16:54 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-084-056-106-044.084.056.pools.vodafone-ip.de. [84.56.106.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8492sm409080366b.47.2026.04.14.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:16:53 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:16:51 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, miguel.ojeda.sandonis@gmail.com, 
	a.hindborg@kernel.org, acme@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <i5kj32dvbvubv4ozn2gzbzo55o6sm753l34psc7j6fraa3g4g6@r5lcpwdgkgr3>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
 <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa>
 <acts0fXgsuirBp9G@google.com>
 <wqmqx6rnqrociriliyojihkxi3llractltkfcwznzu2g5gbieb@y7eaaiee5x2o>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wqmqx6rnqrociriliyojihkxi3llractltkfcwznzu2g5gbieb@y7eaaiee5x2o>

> On Tue, Mar 31, 2026 at 09:22:31PM +0200, Dmitry Dolgov wrote:
> > On Mon, Mar 30, 2026 at 11:42:25PM -0700, Namhyung Kim wrote:
> >
> > We have this:
> > 
> >   Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
> >   {
> >       do {
> >           vr_die = __die_get_real_type(vr_die, die_mem);
> >       } while (vr_die && dwarf_tag(vr_die) == DW_TAG_typedef);
> >  
> >       return vr_die;
> >   }
> 
> Indeed, I didn't finish the analysis, fooled that the diff was solving
> the issue. Adding DW_TAG_typedef into __die_get_real_type still fixes
> the problem, but due to different reasons:
> 
> * check_variable calls __die_get_real_type directly at the beginning and
>   stores the result in type_die, which is the result of the function.
> 
> * if it doesn't resolve DW_TAG_typedef, the flow goes into the
>   die_get_real_type, which stores the result in the local variable
>   sized_type. But it never copied into the type_die, and never returned
>   as a result of the check_variable.
> 
> Hence we either need to add DW_TAG_typedef into __die_get_real_type, or
> copy sized_type into type_die. After some testing both seems to be
> achieving the goal.

Any thoughts on this ^ ?
