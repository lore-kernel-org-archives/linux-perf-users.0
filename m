Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921073845B0
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201706; cv=none; b=JAmc6DFjP3HHkWp5LPvlM7cRvt7jYB8xQTFTWK45gUT6wfiVsBOTIYnJBV1YNeNPZT9pfqETSD6cFOTWSW1BXv+eT5LIuecaEWJ9Og12NEIL0x7AvyVKs2enUnbipsogl6QPUQMdB7A0Qj1FlbHnGhYG7UpGxpyKxhE6kxih4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201706; c=relaxed/simple;
	bh=wuAEnKKJTwUfAlU0Ey6cCScDDJKhL+c1QL6KEVKuXXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj3Yz1fw63Am3oeaLzBtgnItcYO+cbcoGJid+Xmx836HLEvq5pplaekGWcA1hyU4mYwOhfm0ka39egzgZ+X4aEvdrzEOXMLcasOamD608OHIYqqGAyPTwIYoaTC14e6sUyVY+gtOWvp6WjEFhXXgR5RTl4DGUGKrPITD5olqFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmP+Q2ve; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmP+Q2ve"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so80045085e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776201702; x=1776806502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGEMxnrfL1fBp0DuNJTVhthMPiZzYFbcoG57oqu7KwQ=;
        b=gmP+Q2vef/4U8XCtVs82i6L/r/z4EWv0baauZlQGAQQa1jepFm2zP+BBuO8B88+sOx
         OP2dJnGedzPg82bMM82oFCKBJRgI/Je/oWWe6UmUoUg/mH/C0lJ8sdnZ5BA5SE4lpoQN
         a6oCQpMa4rx11IKH0XcRfX7CNmwNe2i+D4JSO9IyuVyMMR9M9ZbjGc6DfjJVMtS2xAUD
         SG3tjsVAeKC9aGD0zU6OYA7J/YYNWSwXSya2CJ59UcZ1JVsaNr4gNdAfmcVdnI7GURK8
         r3rMn38lCasBIVfBurPqB60G9xLGlNejKW1Jshp+xEYy2MMJ0EZ7LkzvMoUEFjmq8E4Q
         gRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776201702; x=1776806502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGEMxnrfL1fBp0DuNJTVhthMPiZzYFbcoG57oqu7KwQ=;
        b=FzmXhmh98MQunpJTI/qXS2MNFkvafJmUIyEGRRh90KfCENTh8s5hb+yyxiAwLWZZY9
         0/hrvxwQ/nUS/d3dxcHQMCLzmoy73oK5cfO6VyDhLgqVWnZrcTXVvxrgNB/IT161TXju
         pM8b3UATCHZrB30qbcKstpINgsJyvN/UHoCQnfOJme0/dBv8w6bvwUuDQ8pCXgS49SK7
         3veedp92EfxvzoAQchr0GjDV5bfn2sP+DymHBWAo+qUUG3ND8GOxNr4E5guGd533kVAH
         sZw6ii1m+fSIr7ocrcETaqU+F7sJNsnEY0u780EUMdpPJBEPgkDAoHuOvmzsKHcjbOhY
         RDmw==
X-Forwarded-Encrypted: i=1; AFNElJ8thdmc6ed3ux1yd7Xl40l7qD/k1Z03az3eOQ4nemPhW6NgfN8zw7aeCISa6+j+ZIC6jxLJjSloMB8DQ2h4qV8X@vger.kernel.org
X-Gm-Message-State: AOJu0YymF/kA5CpXFyi0W2mFP+F9pR7SQc/CPiYi+ZHynsVdKokR/NSq
	w1amAZ+cyKm5DMu9mSCiYK5uTKK3O0lbq84KRksplQggS1OgR8U6uZjL
X-Gm-Gg: AeBDievwy3m86eNIuJWENbYGRqY80lyJCbJ3SnH4McP3T+j2GzSl45+CC4bGIC4grrT
	jtRElJaffjtbr88TJ4TJ29ICuRsUwLM5sAF0F95BKHBTMhAoGFbPr/aOIFYK1+SP6iOqjP1CquH
	NDbznOOLz5eXj7YYIrhEsKnoJPgD4bqkrjra1aVbO80dGiypswXYU0k0W3RCqbNeYMnqIgvJj36
	7yZi1lkz0n5NShEeVJg3G/XcwmMFC1BMWTl/wIUmgKdAsQP+ZgboVqZHsTtFNaJavlSPTaQ97zH
	K3u1017bciAaXCYRqsodDhAZDKXByfrtEFK60ddU0EoA1GEmINZY2WDNioID/nu8i69QZZ1QvMU
	9gbRfaSEJtKhTyGI7/5VRKe71dtRw7QHk6fPU62WNUx32JQ2mpORDmVw60CzENsKWZPFRdDmVv2
	dDbUJP2Y4DZs531njI2zzzE17jv12RGVOSpi+K1H8VB621FWchLtC+dNqIgDzfiGWB
X-Received: by 2002:a05:600c:8904:b0:488:c257:a73b with SMTP id 5b1f17b1804b1-488d67effd0mr178298195e9.9.1776201701817;
        Tue, 14 Apr 2026 14:21:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e217sm132187635e9.5.2026.04.14.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:21:41 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:21:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim
 <namhyung@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat
 <ashelat@redhat.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf header: Ensure read strings are '\0' terminated
Message-ID: <20260414222140.2c9b8cee@pumpkin>
In-Reply-To: <20260414205725.2211169-1-irogers@google.com>
References: <20260414205725.2211169-1-irogers@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 13:57:25 -0700
Ian Rogers <irogers@google.com> wrote:

> Sashiko reviews were complaining do_read_string didn't necessarily
> ensure strings were correctly terminated. Add checking for this and if
> a string isn't correctly terminated return NULL.

Actually I'd be just as worried about corrupt data giving insane lengths
(eg if it processes some ascii text).
For that you want a better error than just 'return NULL'.

	David

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc3..fa4f6d773874 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -269,6 +269,9 @@ static char *do_read_string(struct feat_fd *ff)
>  	if (do_read_u32(ff, &len))
>  		return NULL;
>  
> +	if (len == 0)
> +		return NULL;
> +
>  	buf = malloc(len);
>  	if (!buf)
>  		return NULL;
> @@ -279,7 +282,10 @@ static char *do_read_string(struct feat_fd *ff)
>  		 * thus the actual strlen of buf
>  		 * may be less than len
>  		 */
> -		return buf;
> +		for (int i = (int)len - 1; i >= 0; i--) {
> +			if (buf[i] == '\0')
> +				return buf;
> +		}
>  	}
>  
>  	free(buf);

