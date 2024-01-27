Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D33134A8
	for <linux-perf-users@vger.kernel.org>; Sat, 27 Jan 2024 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706330757; cv=none; b=IgflzlAgPyuX0iF1hD2rwGOzd2uw6ptsDdrbF2PUeO2EeHkGvbWw3W2fjtKibqcCxecgdgHn2x3GbOIJhwm9d6iI48py1SqCv3DWap9+OrDBFZ8RKtqlQswLco1eyPNFXslK1cxolkAiw3FvZkvOUYGn5vOCvr7WiGpHnUmInxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706330757; c=relaxed/simple;
	bh=V/NOwST42Jbm8oopgISrDQoI6wbLk6HT+/BOxPJdjFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UV5IiYRlhK0Osg5XVKCfN/eFcIsM0BJeKXa7ucw3R7Pouz0eY3SUw2sFqE9Kd3WAXn6EdxkOD1+c1vSsJQNvEZltkvilx+i2WID8Ma3CzoQV87x7iRNSNsCKWmV9I4JcmZpq/mpPxikhJHJ8SrUDXxWLbvzl/+EdRa5oW3EUwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJxfGwe0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJxfGwe0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d89f0ab02bso35145ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jan 2024 20:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706330754; x=1706935554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/NOwST42Jbm8oopgISrDQoI6wbLk6HT+/BOxPJdjFs=;
        b=IJxfGwe07HUv0t+/5Q+0XzkaCFvfhD1SH76mvI7x+3s2hhVcKzeiRWiSybreblJRC3
         4I7CwCkbcBJnbDqnwiX978lEqn5EoyZCDNTp4VJV4w6S5us0taYGoqztKAnwFSdynFgo
         7NwbSKJkz/KeA48CafuCQltRf8gGG9y2PGFAQsrMudnrPXbIb4khRhl+tctpOeK+A9Ny
         Q8wodwOw0uS3wmhoUU4o+3aczD6mz2UTIS7o+MPAQPm/mE4Uk1jSvvNs1GlbrjGpTB03
         T25U3OFATEcw97lY9JRx923TpSiJPPv6sX4dz7Dl8qYkpsCsExth9NRAA9qcJrv3y4mP
         kS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706330754; x=1706935554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/NOwST42Jbm8oopgISrDQoI6wbLk6HT+/BOxPJdjFs=;
        b=vBx6DfdWnVAhFH4GR0l9q5ilveoP54scJugpoxwAYbYD2e/UlCJ/YQZ4SRNftUjhMF
         11e5UbzSfojctSXEBZZh3WYHOndRMhfBj1jojxhBX5xlam85/k6QNv4YxE+a/ueePz0Q
         1HZf7K/93BSu+oYvkPukq2GOs7crD6oaqt+G69HQQ+YVNaFKcnInbcuXogyH/gLlEJVA
         c+mewhBRtWSjpcpwCuEfKRHFqos7RuQdPuBEwlELgL9+6eFKqWywZV+1KH02tL6VyceZ
         6IbJ7sDi2DUUR2tfCBzVZ8WWUYKzUVl/B7Q0HAUl4TkAtbJSDmK+Jd5KeCE7zPx1np3Q
         XG4Q==
X-Gm-Message-State: AOJu0YwNrDpan5wUqZRy/2EIv5V364xBpLf7YgBTsbHyZtro9eeO6gai
	yVlHmPxrGYY9GD+Mti5RCXsSwlpRjv8Uov+bXyG1vBWf2mu/4pAQaqlqKehbet6eh3Q0mCfuxLf
	6GJI+nZQCH+9LWxLWf1vITh2wYSOSHYCgFyQID+qbbjNzlOSfGwhW
X-Google-Smtp-Source: AGHT+IHVc0d8RC8/2wTXxlYYW8JNKDWGOHCUaK7EIPlANHI9tnbz5U6dw1KFZGzncnNcVLYDOLaefR4xpMsEt37gzYY=
X-Received: by 2002:a17:902:c403:b0:1d4:55b3:45d9 with SMTP id
 k3-20020a170902c40300b001d455b345d9mr362931plk.6.1706330753913; Fri, 26 Jan
 2024 20:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127025756.4041808-1-yangjihong1@huawei.com>
In-Reply-To: <20240127025756.4041808-1-yangjihong1@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jan 2024 20:45:41 -0800
Message-ID: <CAP-5=fWDbxO83ajAAL6hwL8=eXA6GJAQcJS7sorF2kd7gW+nvw@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 7:02=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> data->id has been initialized at line 2362, remove duplicate initializati=
on.
>
> Fixes: 3ad31d8a0df2 ("perf evsel: Centralize perf_sample initialization")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
