Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB121E51D
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843556; cv=none; b=YquFtg30b+M9afKqpEC3rmuVLigzQTDbmm8HmANQWLlsA3uFSG2Bg1ySpx/G6ChANNdeMviIDNIfG3DunMw4dqMEEGbcMz0vJXDHZGnn88xL52ylwDvy4CCGRyf76nM2keVvrU9jiNJZpqzg3ex7hz9Mebkda+Obml+OVoIdERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843556; c=relaxed/simple;
	bh=oU9JFIpnW9IiwP/zLLrdn3UtCIAWt6eXdWUgszQQbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnvroDpHPciIraXgN9Im15RKf1mCX6x2Y+TeXjdfw9S1fUmARN9nt5YJoDkTavEU75mT7m8FhpE0IuyX9ieXGi5cO6v3PXN0LQKRA661evbNngF3QH+/cUga6SjuLSob8VmlAzCDlrTL0Jg5KUngZNaWyxgdAWUMlJr94fgyd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLmTt+7g; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLmTt+7g"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1209716b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752843555; x=1753448355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PYpcavPW85ROVk3E1axG+f3muOD/wyEeug4NFZEIWg8=;
        b=JLmTt+7gCJpleS4ivc4h024LObg32opRMy26LFXe26hl3fMoiPHJCc74Ai7EJv7kGt
         csXdNVH2EXZEpV/XR5D3rb3AKllyulCywgF2ifdCEZwQ0cE+m+GFROjQjIUzqsIzMDQL
         rOvB1LsN5/FwZW0JVYMsIySdmQievYyWwCT3WKe2RLmnRVUQH9KMHerj1G/b+wbnUd0x
         D5re06Dt3H+ajHWIqwZIA+aAaztsJbe12HFLC20oBPt8puVpyjPQY6OviP978ZtpX8/q
         tuYUDjHvKfW9Nnt3g9t6T8J9xWtlSKT7zeNlyDzQdA9yANNLPFecrRQA1AIfJMcyJwSl
         6Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843555; x=1753448355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYpcavPW85ROVk3E1axG+f3muOD/wyEeug4NFZEIWg8=;
        b=uwjYIz0/1DHH32x3Kk7vvqCwB1rrILR+oBEwb7OwoJdGTXhQaSq09vMqW7l4oohurW
         17iLajkd/lZTAAblWgH7/Pf550msLl/KFnXJ4gFj3mB16+b94r3uSS3pmdn1wbpI90w3
         MOsNFGEd2ttXpVtrfEiq+YBYrNz8/gEpO6RBBsj0jdCIaMM7ZI+zHNZysSZaGy3B3Qis
         zCPVI9XGCcnVA9tNfYZeA9+M7JdiKNcrynFSQhuLl4D74Hflan/dkwz/WLm3da05jW34
         JEgAGBnmRDBfWImT1V+0wD9J1a7qIdhEqbYA9+SrUcdoU+qtQl44M1rikEATWgTg0o5W
         4WYA==
X-Forwarded-Encrypted: i=1; AJvYcCUYD7kd6pYyuAelc1GtpCFcrrLJQJy3Yxw6PxNVeeoXOWHMnDqoUlcrCLMV3yP3u8aJm2WDPGuCakCZblOCUQr1@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgZw0L732i3pnIyeQE6rZdsx0YNrSbVDhEHypMMN5lELaizU5
	shHNxBUFOYZy3MY2fboecvLA/N1lewasubBkqKOmJB9Ut1xKUuNYWOr9NwQaIwOzj/SA1mqplLB
	9M39N60AD7YspgtNeC5Ys0mH8SX96uWr0Aajy3oGOYQ==
X-Gm-Gg: ASbGncuRi6QPm5QsIt6/6yrG3JUD+0D5LT5z0R9qJuG2PWbBFiN5PePkNLlW9LLQGHz
	BS8HYHJZUXwMaDYFtaXcYtj4wfjKkC9G6C2HXzO0ORiy9thlRBRpxiUafgsN7Z75qxdyEcxvjc1
	bUOw71hp0xN5GgPK+hgDRxlihy58VbazRaR1cmQDonY1hBs/7jNEIWSZVim6eey3LrrolND3kw0
	utb5PmtVuaJnBZyJag=
X-Google-Smtp-Source: AGHT+IHDAc74U25eHKTb9aulfz0KG+bpqSbOJrJeexu2ZAbE44hVvJk6HDFdKtlGLhZcV0OjSUhQj942abhhql0IydM=
X-Received: by 2002:a05:6a00:bd84:b0:748:f74f:6d27 with SMTP id
 d2e1a72fcca58-75725480a1bmr16226717b3a.24.1752843554551; Fri, 18 Jul 2025
 05:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718094848.587-1-alireza.sanaee@huawei.com> <20250718094848.587-6-alireza.sanaee@huawei.com>
In-Reply-To: <20250718094848.587-6-alireza.sanaee@huawei.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 18 Jul 2025 13:59:03 +0100
X-Gm-Features: Ac12FXxq5RyQqwd6GSdHy6cONAY5fWKaaHEWBZ5tvug2yoehd6FJ-cPiMbA37wc
Message-ID: <CAJ9a7VjdF0a_5gswt5j+LX9_pxK40ODNpYiYUSmYfsWZYA+Wjg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] coresight: Use of_cpu_phandle_to_id for grabbing
 CPU ID
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jonathan.cameron@huawei.com, coresight@lists.linaro.org, 
	dianders@chromium.org, james.clark@linaro.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linuxarm@huawei.com, mark.rutland@arm.com, robh@kernel.org, 
	ruanjinjie@huawei.com, saravanak@google.com, 
	shameerali.kolothum.thodi@huawei.com, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 10:51, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
>
> Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 0db64c5f4995..95d46ea08936 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -167,20 +167,7 @@ of_coresight_get_output_ports_node(const struct device_node *node)
>
>  static int of_coresight_get_cpu(struct device *dev)
>  {
> -       int cpu;
> -       struct device_node *dn;
> -
> -       if (!dev->of_node)
> -               return -ENODEV;
> -
> -       dn = of_parse_phandle(dev->of_node, "cpu", 0);
> -       if (!dn)
> -               return -ENODEV;
> -
> -       cpu = of_cpu_node_to_id(dn);
> -       of_node_put(dn);
> -
> -       return cpu;
> +       return of_cpu_phandle_to_id(dev->of_node, NULL, 0);
>  }
>
>  /*
> --
> 2.43.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
