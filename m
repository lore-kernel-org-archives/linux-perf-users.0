Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE023603CA
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201337; cv=none; b=KgpJQFXvqOaQiYXPIlxD3/NeUgcMlnmYql0IXbUPevFn/xq7VnrfPblvKd2UNwd5ZdUaX59OmU9aJWUAfAWzihfMKGZQwGW1wC5Xy/pvC0I+94u4xjec/r0zz9mSf4zW0ceLgXKX3aorMXVcfYD5PiLn3rTLUWYw3dvzP5/KuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201337; c=relaxed/simple;
	bh=U9LYC2ekeVA1ilUjog60/xFnxRaYy7JDW/8QBZKQLBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCV9Bu+Gp8GG2jGhW3Z6byLnZUr4KPbi7tnqYiUI9EvA3EBV3MkgIC2/qlewC/VPl06FIxoco2h7IPm5V194rF81kGr6A4dhkhT5b4Eh9hyNAXIoIPmWEHJ6twrdzpD1oa5Ql3YcIQn9ngfe3pNJZ5yeO7RVRhR1rwOmIJX5JsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E02wMJy8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E02wMJy8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so74671495e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776201335; x=1776806135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08SQJ/vGtL3UyQHWMHb9Cd/PD5t9iklvt968lKhjhaY=;
        b=E02wMJy881lqQlL9mwcZb52TH7AeAnO9+9hM1kRCUdgZAW6bYqiCsbBvHmklwK3DEA
         eiiWnic11Va9Yuq7y7QPgqNLgXXYJerxjlzIIWmaSLroDeTZdgh0or4muz9JYnjbvn9Q
         xfmOqPAfK+ZH7W+6Tzvz+JYUF/LorgDiOJtWScNiqXWFUAsQJ27i8wLuKcu3h5ZDNslc
         Wmvwi+CPb8TYc8bcpb3/xJaIZM8zNBB4gU6oHdlbnX2Oaceuc3zRslIvJKhG2YlnawzQ
         nZv/hLt9owou1Eq3QAg/WH2csl5usoI13WkmomUmlexyCl8sBdaT61s/71yYa+db5L1o
         fzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776201335; x=1776806135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08SQJ/vGtL3UyQHWMHb9Cd/PD5t9iklvt968lKhjhaY=;
        b=W72rLjYWmkfiScORvGcqREjjEWeDBfuM2lol14cHZSFFfuEi26vfeiUV6RyFb8ZzvT
         /fzNP4hhszO94d+Nl3iVOYDOkKotytX/Z4JSry4prDiAyW5bHzXVgXabGIBQMknLbjL4
         q9V/W1v2oESp3y96TV006GnIhwj4tYkimsOvHEtdt4RSae8YysWJfBYhnPbLJ4TI/9ut
         8OcOlFdKyMfjOy2Kgciy85YjJUMtSG5Db2lNOyTl9gJQRFHJ9S+GpPKIUHNnZHQE9r5/
         dZxdBi1Jhg6+ThOE3hy5EBGFD24LN3IUqEYbdcbwtAvWSig0QLRS+6In+hdEIjBTppU6
         7HBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/beY87vurBs2+j7GKOjsBQ/NeOXFhDagRrLW4HPwZWX1PfA/6G7mp/Pujc+UUJHJlms6Z3p5pJ2KdY62K0NBEL@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMWS0tNqGOvupwA8u/ttGFBRAfpG2gACCwaMR8miTN9i7iAuB
	rlWOElPjeJezTtSlbSHPln/H9D5WQZvTNxh0jphIm8XMr/i7MsjyFhdB
X-Gm-Gg: AeBDiet48rpGo5SPP1rGgzXkSclCu2aE/j154FRxIX3TMHjqz7rlEThdKe0F+cR2Owi
	bo4dqpJSL5mpQdOrrbDIfOW08k9o9RxBC6VQdXbTJlpo1+2+9NphKUpQPcCTf7bHv/Fhy/3ll7E
	fVzozC7lMvgtLv33UiLMpcQtSmqUZTn1UNYZy1hV7JbpdGh795g7dfqI5Q19zje2ktw/xUbAVNZ
	CFt36on7ii4RV2hnWUXgm575AEJqe5xQRQWz0+cmzOxKXqYWOul92ufQjHnCIv5x2X180MEMTke
	ClT4eM2KX0dP8nEveQWBw7vWJ3dP+JCaiRww1uc7kH5k8nCTzrbJMBXXc+6R/e71M7gz2WcJRF7
	bWWbqrbmEBdKAGGaWaDHlN1dVo28u3MMZ5FmWiMZjaupHv5xtmNLt9Vi6estQ1dbgujK36EyubB
	62XezMElQ/u5VWrGpupc7QHaaQ1Hu6bZWx1i7+Z569m48y2wjWynnwRH5kZ3wvAwo7
X-Received: by 2002:a05:600c:8594:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-488d67f9a73mr185836585e9.13.1776201334404;
        Tue, 14 Apr 2026 14:15:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0943698sm4244985e9.4.2026.04.14.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:15:34 -0700 (PDT)
Date: Tue, 14 Apr 2026 22:15:32 +0100
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
Message-ID: <20260414221532.17623227@pumpkin>
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

Would be a lot simpler to malloc(len + 1) and set buf[len] = 0.

	david

>  	}
>  
>  	free(buf);

