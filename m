Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC03A1A33
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994742; cv=none; b=sEFutwuwIe2UFXxl6HrfnU61Au0plqB81lsH+Fq8Zs2DwMaD2swJG59Y5XpcftOEzKEX33fP0DtJwLwgHwfqRbcMBmJ5dLTtuYYjNbo87Rcznbqnw5XBvk/XU23dLbKvUTx/vU0aTrtrdkrHPxguGKD4BmH4PV/zPQ4BuUdJzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994742; c=relaxed/simple;
	bh=tLVK4di/mJbG0rt4yh7jUH9/iQkvUkcnYMDVn7GHvlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja4TKe0rSq2pyCtiBREQm2CJlr9q2qZVrxDWCkzhjRLOF2IonTAJdNPk6hP3pAlZQL7R9t45kB8LJmm9tNaFO/1K2w+CLX9Vwrisx0vV0eVC7pniF7daFKPerWNL99V7qLfiLZ8jL3jU5PoM7wk4vhU3WKFhcVXb4QPvHmN3bBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYjpmF21; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYjpmF21"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so61765085e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 03:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768994739; x=1769599539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZcOCzMzN58rEfAspc9Xym1mOpiIyhkHUUmjF6zLfds=;
        b=jYjpmF21ZgPC68mllLn6NN+0HwPhfN2yjPwnUMuC0tyY1COskOVP2FshosEsqP2tA1
         QOOGG29PxHFNcXaGhVQ2XeBGtkOKAYNdm6kzaNcqnZrCUx2TFpfRxYUFiOtUntG/ej93
         JfvKAvGWBG1toM7d6oNo1MlhKqY6JJ6+R71BnPx1Y6V9nOrkcxvAy3CdTj++0v6dX3Qf
         CFYKCHlgbGXzIBFle7QZyWKVpcoeTkpTl8MxZ73h9o/hyk+ZqmmIJ8mk0UZwyCmnVxRD
         OMDxyEjG+8ydGXqMEiKL9vGae2oDBgIt5BIFTHIL7s8eW8V9aSTcNrk5/ZFP9CS8jDUH
         VTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768994739; x=1769599539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZcOCzMzN58rEfAspc9Xym1mOpiIyhkHUUmjF6zLfds=;
        b=vDAH96SkjtzVQn8r9faC1IZhLLyXNCbIWU8HfjdKhye+XppRL2CPLCcyrFYrra9OAX
         zENm8DCbPy9pVkcUEjaqS9VbH8QMd5KTaaSQKbwWb7woFEs1QOuEJm6atBdxr5t6jVRN
         pZnaj2GXbDlE5lU5jiEh+Oi3gTAZ6h13qbQ8WX+z/1gZmK0bfAVjFGAozuq1+chqgpkd
         mBjrojkErCSsah1ZlBmSB2PosvqarhaUzRkbUY/Sx73GJDGhP/JLtNjc6sbImZRd1mbT
         PKKEj6VLk9/MGYWXOVVQctj3afBUY1Tl2Ofmv/4cIOHwINPGFyY+HeOn1s1dmubRZ9S8
         b2yg==
X-Forwarded-Encrypted: i=1; AJvYcCUjoYVEldBO0tsApAiUcrfZMBo6Lov0sGRb+xY4krRJ/LvVjwRHYnCJldL75OQoA4hibD7PlTo0cn9ol6BlzMUV@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWcCWResc4QE9Lt0Zv/X5fX0Z990zt+jPf2HDX91RAad16X8c
	N6z/jspij2EBGbl17HHwSKL/rQ5NI/XyhZaYB/H9IM3+UxCMVs5/n2FD
X-Gm-Gg: AZuq6aLjsZG6itn+4VorxADP6trqSOguEfonz362KH/YFLhr9JWA7IVj/rEG3aK0IZN
	ND2mIjN4ops/41PiE+3BRzGrfirVfQ0Onb7T7lR6vxFkl6U8dw516cK5NGvLBQoleVhNfpPDHvJ
	4faP7valB5eW9xiui+34KM+eNQ/Y37cKj8iFiNV3LepZcNhiwbppia2iFAAMtRDnUYOxoH0zHd6
	o3L0ZTJddu05IngzgiN4Z+3UT+2tHX7aTj/DCiLfu6Vf+G4Lzn3uTfx7w9aU6b8zvKyg2cXX+ju
	hJyYg74ToxrTJF1yj21CInhz7bR8Ds0bpdmyTjCs29nxGMU1qsB2tyN+AwDKSDrHi5NBQiIWcrX
	iJytPzjJdSdvby8ygRaUM55OEgqMO37gnd6jcsweDTMWFhG41Ndk+kM+YniPDzYgJ01RvV23lhx
	WhUqrvFcvXP16VsDSH9xCE4DHHTiiwYINty5GEHwZ4HXNR2RH+/qVy
X-Received: by 2002:a05:600c:3f0f:b0:47e:e076:c7a2 with SMTP id 5b1f17b1804b1-4803e7a2d74mr79194685e9.15.1768994738668;
        Wed, 21 Jan 2026 03:25:38 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm306901805e9.1.2026.01.21.03.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:25:38 -0800 (PST)
Date: Wed, 21 Jan 2026 11:25:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>
Subject: Re: [PATCH 3/4] perf list: Don't write to const memory
Message-ID: <20260121112536.27fd5d11@pumpkin>
In-Reply-To: <20260120220900.366451-4-acme@kernel.org>
References: <20260120220900.366451-1-acme@kernel.org>
	<20260120220900.366451-4-acme@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 19:08:59 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Something now detected on fedora 44, where strchr() returns const if it
> is passed a const pointer:
> 
>   util/print-events.c: In function 'print_sdt_events':
>   util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>      89 |                 char *bid = strchr(sdt_name->s, '@');
>         |                             ^~~~~~
> 
> Fix it by using strnchr() if strchr finds the separator instead of
> temporarily scrubbing it with '\0'.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/print-events.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 8f3ed83853a9e468..898cf426509790cd 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
>  		} else {
>  			next_sdt_name = strlist__next(sdt_name);
>  			if (next_sdt_name) {
> -				char *bid2 = strchr(next_sdt_name->s, '@');
> -
> -				if (bid2)
> -					*bid2 = '\0';
> -				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
> -					show_detail = true;
> -				if (bid2)
> -					*bid2 = '@';
> +				const char *bid2 = strchr(next_sdt_name->s, '@');
> +
> +				show_detail = bid2 ?
> +						strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0 :
> +						strcmp(sdt_name->s, next_sdt_name->s) == 0;

You could use:
	show_detail = strncmp(sdt_name->s, next_sdt_name->s, strcspn(sdt_name->s, "@"));
strcspn() will be slower, but it is succinct.
I'm sure there is a function like strchr() that returns a pointer to the '\0'
when the character isn't found - but I can't remember what it is called :-(

	David

>  			}
>  		}
>  		last_sdt_name = sdt_name->s;

