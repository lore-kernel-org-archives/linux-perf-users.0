Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5D410D0E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479649; cv=pass; b=ncYsiEri7rp0jD5yTDprZdC8Z4vEQ2DRW28ZQOfUETSAh5Ic8S/TpIi0fGN5K8BoNowRvoJSrKZn9Krq7GElBCtjgo+K9u7Euz+QZKpxoTN/ESt7xJhATekBwE3EkX+TRmmkIV0nlKdlZm/H4Rzn5c+9GBXxlMaiMKE0M0jjwhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479649; c=relaxed/simple;
	bh=wrzVk6KDEhkzV2OIsbZnVBgAejpxRr/AIqMl8GsU8kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajpRhEcVi2uuxf+ZtwuPEwAKvA9ZM4UOnQhwHcBh15cdrGbzzFUvSVwpduehmCrhPQanyBiMRC5p9QG5ASBeb9d1jSl9mefrsLrhIQbBXRIk6n8nTTFSuQTuODe5fgGkLwni+uk6RuM3EPSBIXmecCFl74/ohUY9tZ5JjbFSS04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ojcy/n0Z; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ojcy/n0Z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso106145ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479642; cv=none;
        d=google.com; s=arc-20240605;
        b=ed1G3F7GAYQ1URLX/w68D3u/VJd0fJgPwwKSHAWtN8EACCGCt/jiuCxPcPpdDPOp6+
         e18GdBg4WIItdAIaqzd5P8wD5Zz7NLN9GKj9Sxm1j4BljzDYwTKkYsdKX9JWPDF0NPYX
         weEz+Rm4qaJOEwNsuv0MdXWzK23uP3e8qLH3SFXPgb3GIbRRx3qQv/wjF6xLCjQwURFK
         dku01mCHnKby3WkgIxbpatU1gWZPjY/yL/uDq7Ye/gtRkQiWeAsLwNvQR+fBcZoB1HCO
         v47MpbGG1GsFPyukhXkY1ecFTfVtrmARncgvfa8iVabH8lOLatygqDTjjK2MyrkAVJcS
         41Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9aQ2HY3ym/1MPGFPjep0gj0W84Gq0f3CZ/BSTdc5PC4=;
        fh=vPpVMD2Z6j6vvch7oxJw18L8ooQWktMS0P/3NMpr478=;
        b=M/Hqeulv2T7A5N2c0wR/PcOyD2c/fRQLlUw/K8BaG78nTjJMWh8/+SZ7H55PmgctSU
         i8R/VUlTK9tZ3EyR9jxhMe1UMtNpPUOy/lWdQk1LvUOKh2+TPRLnkJKBl16iijnFj64e
         rdL1+br9UqL40c6yqGG5+dftyErx4VmtFqFuzoDFLMgAZI2bLCIU86o5jcLK+NLFfY/9
         hbXDHytZhvRRA4eatY3LMUGhQ121TO94TSNlb8y+KD+4/7lHNZn8bP46TqjCY1k3qtVC
         nUXUJrQthy22kDRFqn+G0gbauObVJ2nyUMwDX8b7EZ/dvpbRLosFXDPymcfQ1PJcE/lA
         aE3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777479642; x=1778084442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aQ2HY3ym/1MPGFPjep0gj0W84Gq0f3CZ/BSTdc5PC4=;
        b=Ojcy/n0ZvYdYx7fb005Rewg5TsKSf9D6+ILEtk4PkCiVWTINXrNbx/3Hd30JJQ2Ilh
         BjKPciU7pZgIw8HpU7Pecl+vOcqYUFbCbNz+DyftZCBD4lw0Of6PkdWYWhQfj3uo0oP3
         GHdyLSsQAR7m3gJgd/XOo5qIxAVWZBWpIgniJrCWjp6kh1cOegO7iEQ2H2GdJd0VLNk5
         Jo8Sl6mZRDOnbqgCkFzsEYPJMhoxv1ZQsnvlcTdlSLq1mN9Kfw9y3JHf/ibmwhD/mljY
         yVilp50f1BY6EpIUXmeeKciwIjRENAdUh1THu5oLcOc5LvPwSkqgQesDWhqtoH0g4+2u
         zNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479642; x=1778084442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9aQ2HY3ym/1MPGFPjep0gj0W84Gq0f3CZ/BSTdc5PC4=;
        b=HnALdd3pV0Xid+FMBSXL1HCgOXULpnsuvojHmqJpmq6+wJvFFti0zqjp+s5uLSjLHX
         zclTEYzQX8kGVASw2gW95pgG9nS3tL8qa5+GcqCEPm7p2+caun2LI9BBJa6lw4UB1IyU
         eJbEf1OkRlGmdB7J5HXpcctejqZDciZxh/o7uqZJ0oIiw6slUQ5vLOnHK+bqziRDwnZX
         hmf1E7+Gq01oWNIqeTbIg6dQdkqFS0DQll77i43dFg/Fo26kOGmyuvOnhv8OtHwBBFEx
         m2IshSkzao7nuwEacyVzvByC8gpd8u/YKT1ighVpmMp14aD2meHn/6e/FSvCtbWgyDIK
         qlBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FzuB76tr6QrrEL3fQfDYQDjXxbFqS8qEUENICE9/wDU9vLYNcOrk6clnjoVh7cyGQt6uSY5B5cjermMNKfbWm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0Wc5lfZJSMZrQjEDew2/ypFDquHWq4r9SLVgLIV4okwa07gb
	Bg73R7eIkMOBut0Zdoj+rtDMjMf4wQQ0NYvKCAZ8/dLPlU+1ggpBlQ+kSALbbI3sgYdjOTAaV5k
	mfqxftjfe9qP2Khh5lOWBmuLB6a+JBQNbJ2uN/Wmp
X-Gm-Gg: AeBDies8UQvw5gjusyu+wOD/6Ss8VY/WtEGue0ZtYkJTZ4wGrOLhBpCcwiWefzDxBIg
	b4p6WH8adFnM2UH+ojpIGmeSdEyu3kqRZ1EbFcFczGSUTh+rkt3AWEdzJo1/YnKs7O5zki6jsFv
	7imwc6bug4cqEF9m5lGdcFg0msMfsPnZ1Q6p1udqA6f71bzlXDbwvjD5IUG/m/xJBaKfBV15NeG
	W6kDOd6JUHuarjuGGyp+b0u24NWHNaeijM3BtFb9q8v4IhADVW31DdKsVHq6G6ALikjn4mO1NBQ
	+Rh2pSw95bzaX1oUGyVUhDxAPiB46yNG7jiyTXl8SQ+Av1qU6p/TzYac5Bo=
X-Received: by 2002:a17:903:1ab0:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-2b988bb154fmr4565995ad.3.1777479641919; Wed, 29 Apr 2026
 09:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
 <20260428071903.1886173-11-irogers@google.com> <afG0WoBnoxC8VJNx@z2>
In-Reply-To: <afG0WoBnoxC8VJNx@z2>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Apr 2026 09:20:30 -0700
X-Gm-Features: AVHnY4K_MpCLxPNE4F3zPBfyInZmI9YnYHCk3xieug18H5aS76QsDZrAHMiQaQQ
Message-ID: <CAP-5=fXVvg3=aDDeAHwaH=qVX9zCCi8+PzmvUCS9K75meb0fXw@mail.gmail.com>
Subject: Re: [PATCH v8 10/58] perf evsel: Add reference count
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 12:33=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Apr 28, 2026 at 12:18:15AM -0700, Ian Rogers wrote:
> > As with evlist this a no-op for most of the perf tool. The reference
> > count is set to 1 at allocation, the put will see the 1, decrement it
> > and perform the delete. The purpose for adding the reference count is
> > for the python code. Prior to this change the python code would clone
> > evsels, but this has issues if events are opened, etc. leading to
> > assertion failures. With a reference count the same evsel can be used
> > and the reference count incremented for the python usage.  To not
> > change the python evsel API getset functions are added for the evsel
> > members, no set function is provided for size as it doesn't make sense
> > to alter this.
>
> Can we make the reference counting model simpler by just using evlist's
> refcount?  Assuming python code generates no evsel from the shared
> evlist, can we just think evsels belong to an evlist and manage their
> lifetime together?
>
> Maybe I talked it to you already.. but I forgot the details. :-p

I agree that would make the lifetime management easier, but we already
exposed evsels as Python objects and the existing cloning approach
makes the code base more complex and divergent.

Thanks,
Ian

> Thanks,
> Namhyung
