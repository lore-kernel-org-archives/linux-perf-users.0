Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A42E370E
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272274; cv=none; b=WdFCsws7Y+jyuc9qFV1cMPd9iVcYkTpw5mHuejncnn2SM2lUR0/SwYiiCZBeRsctzomhvoL/ciMPmoZB0qI9FdE2WHpMPf+/ZE/AsBYUo+L9lXxfdwO1GX8IfN+HSS/Q1V1h68amITv9N4CY5SHXviueNktt2XutFYxAVH8c7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272274; c=relaxed/simple;
	bh=cQsbTTP0VoK4R1L4J+A3IZgU787+pdz4knMRsMv1nqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqbbF8Z7Mm1OGHxuob472EsOPXuyNB6L5pYRXRyVFMSrntfSYHj7qexwrXtzPaiFmS8ze+s00xVSpeuTeLJ5dcP3mqCkudGgd695OMBTq1UMk0Aj95AXG5MivXnnfK6UGDrmGx9zAgjEGq5xmNJsqQK1Jh053RibGmyp1bFyRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPiZiyt1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPiZiyt1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2959197b68eso205515ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762272270; x=1762877070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/PHhKT2Znwu9HseVZHKFx2b7TcR0iwcE4g9dNET83U=;
        b=hPiZiyt1s9tRZjOYlp4tqKdlrosKDIsM5kDLnM7JIq9JnttynUVT8wiqqEJDUhIN3E
         vdA/oqGhZe4EvyeSfMUKA56SjuNKYxnvTPn+whcDFaEEVsIt6qjXV3ZKiQ3n/2Vlm0Hi
         8I6o4GfXG+fR8tKlTfqPxEORut0kKXHOEtvgsWo/v1Dc6VoiNEjj63RLUr6SOlSbWzXa
         KMpwAFYXrXLskQBjhKEIkPYyewV5vMyY5E1KCxj3Ei6wtewPwu+otab92YyDMz7FNJsi
         XfwjuT1o1CzN7P7l3daY8E6flFDyMZCAjwRvikIi3rcwU0EGCysDTm7kn4v5oplcuro9
         LrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272270; x=1762877070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/PHhKT2Znwu9HseVZHKFx2b7TcR0iwcE4g9dNET83U=;
        b=Z4PORHBy/8+emBCbsp34bIX21egrLbTDOMbUKHfgLHX1C0ig4XZU/6MpfBuaQTb0S8
         dP+APW50ABH1OD91GJxl54ePKkLq7CSxYxiwr61FacLZWx5BlgkI3nZuuJUjtAAhWAo3
         ScnaPaFuqbTDsiRmJ3yIjcCZXXCYx2grGCQmF7dII4Gu9aIOSjK1QO8q694pYrO8lrKz
         GuMgOwVavEmAM5n1XPQch6YTRNbgjeMVCCarzQjvSq3+miJjBFMgNl44YPp1ObAncWJT
         iGMWXxb7xVGIgtrCpIftoC71f4SFBTUeE/RChmd46r7lTJ06j3D6pXI/AvJkZ8WF3fql
         Hxgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4zfAXClISouX9TA883iPuMVdpYGJ2lQ5DOUNjdNJbjDqTtbX2ABC9FryHAv/e0rr/sNHgXpHejL17hAG7lUWD@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeHGLjEpbKKbraTSSkkAjBtARnDlI52YVz2ejHAcxQlqr1oZd
	8nIbLjRFlUE7ypJFL3QstIQNCSGzBFNUz3HywCvFo++SsR2Cs99cuxvf3DslIHcTU+IxRQ3fBej
	JKhLRDd3D5V7I+WVne5dq+W70TFu9lB0FDbtF9P8H
X-Gm-Gg: ASbGncsQDTwnMWt86wE/SXSr88c37h6hPSQ4QraKjtcZcNBYEQxLZrL+uzX5s48+07Y
	zRRSNK+c3/tFam+gkVw8GmjBLLqjNCDZkzzIruUjL5MaGSXdki3MhCFb2gxYJ1xvpStR8MdeXUb
	paiBTFpE78Jus96DsbXrwrmxZBzIcgkqOif5wSfVvZearTgGnyB/YfPAvlLVbr4zRGrBmqy3z6t
	S8fs966yxRk++/uKQCzPnVt3a8PzESKuZeLSOyNkzucjmxgpuz4tGfzuelDgkZaGRIDTxClJTv+
	1wxdYdbEtPmF42Um4jsJppp5EA==
X-Google-Smtp-Source: AGHT+IGjXe6tai+L3bmj9S0kG8kMQn4+Mnswy5DvtApEzkYyuOlzI93nG7iDt8pZcCkMsglV8Abhd8Un3qRdwGulsuU=
X-Received: by 2002:a17:902:e747:b0:294:faad:8cb4 with SMTP id
 d9443c01a7336-295fd8dc897mr4890515ad.8.1762272270004; Tue, 04 Nov 2025
 08:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104092740.108928-3-jingxian.li@shopee.com>
In-Reply-To: <20251104092740.108928-3-jingxian.li@shopee.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Nov 2025 08:04:17 -0800
X-Gm-Features: AWmQ_bmkiyFkm8Ccoecp58xI6r2HcrYx5G7YNLVKN7p6ZhL_b0r46BqKLgo_c3U
Message-ID: <CAP-5=fWvawhzhXx72L4iEPpNqeNW+oHQOTkAOy53z0r8UXnMSA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "perf dso: Add missed dso__put to dso__load_kcore"
To: "jingxian.li" <jingxian.li@shopee.com>
Cc: stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	sashal@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:38=E2=80=AFAM jingxian.li <jingxian.li@shopee.com>=
 wrote:
>
> This reverts commit e5de9ea7796e79f3cd082624f788cc3442bff2a8.
>
> The patch introduced `map__zput(new_node->map)` in the kcore load
> path, causing a segmentation fault when running `perf c2c report`.
>
> The issue arises because `maps__merge_in` directly modifies and
> inserts the caller's `new_map`, causing it to be freed prematurely
> while still referenced by kmaps.
>
> Later branchs (6.12, 6.15, 6.16) are not affected because they use
> a different merge approach with a lazily sorted array, which avoids
> modifying the original `new_map`.
>
> Fixes: e5de9ea7796e ("perf dso: Add missed dso__put to dso__load_kcore")
>
> Signed-off-by: jingxian.li <jingxian.li@shopee.com>

Thanks for triaging this and the backport fix!

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/symbol.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4f0bbebcb6d6..ea24f21aafc3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1366,7 +1366,6 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>                                 goto out_err;
>                         }
>                 }
> -               map__zput(new_node->map);
>                 free(new_node);
>         }
>
> --
> 2.43.0
>
>
