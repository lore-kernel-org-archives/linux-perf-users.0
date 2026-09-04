Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361F3B71A6
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536865; cv=pass; b=Ssd1yjq4M6Gwd6TQMw2NK99+MLnPK2w2rHZPLnM90QxX3iyfYnqg6SR26DOBkCsbY/SjIzGV4xtCj477bdA56PYooALNacB2qbd2JS9nuMCrr7I+rh6eVHJVkjzxPshEZA7/gkQns+1Y4gq94hX5bJ8Nuof53UzMYPkWcJfw9gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536865; c=relaxed/simple;
	bh=p+zh2bzF68CPu34Qj0MIgenIKNyb+Zlsh4hE21X56RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UStR1MiCDFGBNXWSDVuXyAZwdV/lckWw2wiSzoANQMIK1IEUuyktvXb6jEMBvit4Q68CwMPSkkpfMFSdljlEYrretEwrFH2d6Zx7cq23ho/AaNF2IwHU5Fx5cN/wTbAeX3hoQBqU+edudo7yNrM53YMtpw2hPJkygxz7MopOZzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eL+Jzm4L; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eL+Jzm4L"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so247061cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 08:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536863; cv=none;
        d=google.com; s=arc-20260327;
        b=KrHc58/sw/eytw5ijtt9sQMrMhN8/ypWORxFP8kh8mIFMdVRdX1N8OkuK2T2W1Cc5y
         0rOmXbunLNdJL5PWFu688G0GCtqBiDxG/UeR0sqHgulPAJEFVo7My+SgZSivz3EUgOg9
         XH12ivq8R7MrMbeFjzWWlLkiT5TO911Z0FP7raLIZ0X0T9mg5vYeTkBEupW2y4n8Xoe/
         64YlhJnsZiWne2iE156ujc9EWLbfbADMS5Q/fpfsciw0Fo2PPH5x/89Ygt2Xl9DqyEEj
         /ogD1V1O+Kd+pDZKtWW8ATa5UE7ZeTz8s5I4tvCf2zeInX/NDRjWAObjqyCF+KyGvSaJ
         uoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IPT68QRfKVLmVSBV+Z0zwKsA2eXY2NxVNEpWEIXhKXk=;
        fh=LuIiKaPdWTIXCK+lkOL9CWWwPDvTPBxGmFPl2+ytupE=;
        b=SS/d+cHfrfCbRCypBAb1JEj/YBMc7Cz3H7gBvSAsjTsPdCtgp8l9m7GhunecvT9Wqr
         6+rL4tn6cM0w9wTgifTIXWAHjsoLrRyS8zeOK+DgKdUD5VkhnhYLDzh5n/R4o+VQycog
         qOd17AeiTJWO3ZeKQjf6Wm8ErubWQfu6YGYN4+e64ihuSbsfxRZhsAmvGJZePsyJV5Ou
         5xnHRuBe6Bm8bGTlm51C0BfhlRiMBF8IOxGkCu0XKn3fbmdfAOJHqG3I5kLtOqVxKbT1
         rtnfUTDgNsC7o0eXrabG1N6HdTOxTBUN3m6m0nG3mxXtzWAdbQZ5EZ8mcxjR5uVrSSmL
         kxLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788536863; x=1789141663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IPT68QRfKVLmVSBV+Z0zwKsA2eXY2NxVNEpWEIXhKXk=;
        b=eL+Jzm4L80uAqJ/l+5uRrLZV1QZAXxrGuraxN5pVLCp4uCn7U8eXJYjb85Xd6joI6A
         NXx/nbRuFggJA/gU2w7TA5lnRTww54JUSrzd1B29nAl/VUiv5IAKOxIPUr/DuKekwgTg
         kfzhctwNpuT0uR7qx1SMYIYYuQPeM0PvKc3K3VTKgYO+Et/xMsIwea7VHzLrh+qlLwjl
         +YE8jHGjShC+rZqcfudCfNdwa5twbTIzBB9cuBZMt/f6X3PEzdWdS7RVls1jX7rewBHb
         r34eVKr3Z4w5L5MY+sm+DxalqxHY4GHa7sOVc6p5VwxL6ZTWZb/QUJkZCQgqgsQqnIHB
         XCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536863; x=1789141663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPT68QRfKVLmVSBV+Z0zwKsA2eXY2NxVNEpWEIXhKXk=;
        b=hcZ/46fKCZCS3GRBygH6TqiUlXxxuQ9CcF/fQmBHrOGNagEf2AB4CZ9/B7g8USI9AZ
         WMOBHEu4KEEzRqU6TyOqpjBJbn1/HJ0hhvs4twwt69Mx9K6RUaBUKpZ1Bc52OqacLgjL
         Kck6fD8tQSUGuAu6mLd3EkD3f2AeNUwUMtb55Ike/QpBeqlHzQXzIcSYM5XlmDU9Ho43
         Rd0hADBXBmUGmzycNGzjelDU/c1SQBc+NHm9UUpMS6VKMnFfdwFp0zLfVJ+67C2uaYRS
         FENjThZF69+D4LBo51NTggjGqhaXM9jWYvrm4ByGTwjW4BIHOYpAsgMh956RLZ8HV9sX
         NNCQ==
X-Forwarded-Encrypted: i=1; AKwUvByTgbzGFIaoSEB5uO+NDlC1x4gMnf9ex4uSW1eInyqZ1+4iBC0cXIfLq5X76efO/dFkh51u/mjG5v7Q4Q8ozzQ4@vger.kernel.org
X-Gm-Message-State: AFuF++k8eukQ0U9za99LW34qFe7+RoZMLTWIHz0Jn3ab9aH07sATbG+8
	irNJayuygoWDH8GmD/bhJGRAzawnCyYpeeb4ncnI58OgRese9YbbmT9YY5b84jto+etRsEVZEmv
	V7khRXg+OJ6bjKmDWPQhN2sCx1AkqyQqaESZl36at
X-Gm-Gg: AYBFou3BbUl++zR4nkrGsn7dX4Y6epkvemtnNDeJApM0TEJNpAdWFNI7h/O8kgG/SAY
	rMTUs3D5kpSYBewtBxF7STcMFXHnuWfq7cDHvurpei1f3raL9chNGf+zPqDtw94a0IXQAY8qu81
	1NBKfabq6GlXyXJbreybYTlp8BG9aPw4DQL4Ui44gIDMG8ejQRWX0rh7MTemjDWHJz4OVoVQbg4
	wKGrr4Bc2kvWxX5kZSR3D5m7tbz/D70KSGcD/FKl2HH9XeH+RJNBsDWgx7lWNKuc4JlxpB5KKxp
	R30w8F+vHaBP1C4nryUq11SzUjqoVL5hihbxTtOWmDbmQVL1h+uz2bv9vKyjrYXzpGRiVSx+KjY
	=
X-Received: by 2002:ac8:5885:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-530559ca407mr14443271cf.10.1788536861883; Fri, 04 Sep 2026
 08:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904141659.224248-2-blum@kernel.org>
In-Reply-To: <20260904141659.224248-2-blum@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Sep 2026 08:47:30 -0700
X-Gm-Features: AcwNN1VSiKV_AEbMzp_nMXjvTTquw6BllzUYWamLFbu4C-WtIUHXX0dMd892YtI
Message-ID: <CAP-5=fWj0YAUimSwGLrZpikH4dHkWSsupyE+esbNg6rM-m1sUg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Annotate x86_pmu::hybrid_pmu with __counted_by_ptr
To: Thorsten Blum <blum@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:17=E2=80=AFAM Thorsten Blum <blum@kernel.org> wrot=
e:
>
> Add __counted_by_ptr() to x86_pmu::hybrid_pmu to improve access bounds
> checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  arch/x86/events/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 71ed5b2acea2..b66691a4fc31 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1050,7 +1050,7 @@ struct x86_pmu {
>          * unique capabilities.
>          */
>         int                             num_hybrid_pmus;
> -       struct x86_hybrid_pmu           *hybrid_pmu;
> +       struct x86_hybrid_pmu           *hybrid_pmu __counted_by_ptr(num_=
hybrid_pmus);

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>         enum intel_cpu_type (*get_hybrid_cpu_type)      (void);
>  };
>
