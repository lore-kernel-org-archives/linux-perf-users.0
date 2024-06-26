Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883AEEDD
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395449; cv=none; b=p3EIRAZai85DUkqerHsnGFYmmQM9V9p7XSHra2RFePIdxmlNrprzyiOY7pfD8GcIz2cy/0qkGoEjSa/EP3odnFFf6IjQoyEo6jAXHS6U7VKVZDT8GbyjshIycsE05qz6byP458xPs2NYMIRsgQUJNjPC1fZeWCK82WYhvELXfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395449; c=relaxed/simple;
	bh=B8XMw0Lq/znZjV0KsDQqRopt02tCEu5Vs8kv9SLuKd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYjH3ypuLw97fqUDVDXS76nnp/Z4czZbQkSbR5KYoB9FvlRxR5t0sgjmUpz5Ae2ep2I/NeY7xR5+Ihcsl9kV6/vxcebRwZN8YAt/+LNXV/Z2HuCH8hk8CCjHfytMSuuiM5L63bG4Zmom76y2rbq+rMShGQCoBosdaxjysWS4HNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UM3sUncr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM3sUncr"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso3788677e87.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719395445; x=1720000245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8XMw0Lq/znZjV0KsDQqRopt02tCEu5Vs8kv9SLuKd8=;
        b=UM3sUncrWN6zhe36o3vEJ8ZFcJtCBJHXNPzWKNx3PUGfSw7V/Od8UOK1OMQUbe7Wg9
         ssEEA+cP+Adjz9O5fTGUcn0CaGYVV/NC8suICwgGQdfgbTpZuW6Juw7VzLuQQ6TcqWfd
         EYcfjHFs7c1P1BV9CtTy6FtWwOExlVUSR/sLTWme32MWq+6MsZBhieavMNmMV4IUKEGk
         3IfjT796ajjL+W1xxOm7d3vr0+vTGz5TpxR7Z736KjeAFqGCmCNKezmCbpb6OG7KaHet
         vNTc2xrqygHMhPWnrcI2Kc6pIChdnHXSlrwZRkqCgWgJtu2LWEUjKA1BJMU/EbJoZIkN
         DtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395445; x=1720000245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8XMw0Lq/znZjV0KsDQqRopt02tCEu5Vs8kv9SLuKd8=;
        b=Ra6+jeCY7uO6fmKTSSwKCkHbauK3HcKsGuFO87Ukw+CNBVQbAxiGoMMkiyBL/hfTPE
         N7WEnTs/u6/RLZH8HdtdK6rqqxddJydOKPd/aRY/ouFXc9P/iZ0MIFEkMI6oG3qPVh+b
         z2MDSoyzgy+YucsGiALTUQcknPc6BDYBRvMqGSSM9zLHuJo7Ca/HBi+KDAWv8NGMDKTy
         eTA4QqLcEPGy+xbMQOOjCv3GqKcCs21lXtIbZcZkxVFPKYHUrNzX4lLziVUdaFyixkFZ
         NNjozIXvleDisB/KUmfO67RcgyLEzxbx1DF1LhTLpuw2TxNJMFcDaDmQ35n03UaMC3kS
         65qg==
X-Forwarded-Encrypted: i=1; AJvYcCXR8P+frJGMtdTr1mF24S42ppX+qF4+wRk/fjJAYd4TAD5akqfde62LPBTYpJ/BDLvmhcLo5nvTFhYkTTF1GIsPrzC5lQGY5I2ujSakFpCG2Q==
X-Gm-Message-State: AOJu0YzTC8cznD0nk4g3GKE9yNA8aeJnAUczPWCW/zdoeWZ06nTXjINj
	Sj89lGEwISxdIpUExaAHsrM9o29HN2ppQcafYJKauQ5N+ngCxLvhJKRiAadJmBCsWz5vsGeJBRh
	6aPU5OwwQfexFv2CwP2o7cLgbJCOL2wwJAslteg==
X-Google-Smtp-Source: AGHT+IGSObvqboJ4ZZ6yoQ1c/G7L7JssRKsKX/b79P3e90H6Lvbk2DOvVW3Js3s99JnAusteMlXmpMMT3T35ygpYy94=
X-Received: by 2002:a05:6512:3449:b0:52c:dbf9:7e54 with SMTP id
 2adb3069b0e04-52ce1836330mr6750930e87.41.1719395445554; Wed, 26 Jun 2024
 02:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618032620.2445395-1-ruanjinjie@huawei.com> <20240618032620.2445395-2-ruanjinjie@huawei.com>
In-Reply-To: <20240618032620.2445395-2-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 11:50:33 +0200
Message-ID: <CACRpkdYAjKMSGmR4pc+LEfZ4NQArvgCEwy=ujzjOQus0K9j40w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: 9258/1: Fix callchain_trace() return value
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, will@kernel.org, mark.rutland@arm.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk, 
	eric.devolder@oracle.com, robh@kernel.org, ardb@kernel.org, 
	broonie@kernel.org, lihuafei1@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:23=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> perf_callchain_store() return 0 on success, -1 otherwise, fix
> callchain_trace() to return correct bool value. So walk_stackframe() can
> have a chance to stop walking the stack ahead.
>
> Fixes: 70ccc7c0667b ("ARM: 9258/1: stacktrace: Make stack walk callback c=
onsistent with generic code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker.

Yours,
Linus Walleij
