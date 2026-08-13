Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED813B71AE
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612129; cv=pass; b=MlLbiZt20R5B728LLHZ18TICA0u1GpUUNNX/DATAvh4JVgkGKclmOkvgcZHoCkSceIDWhuU65tB9D8bKWjWD4Z2pEnoA96SLHv8TQ/0gkNze2w2bPWQ0hFyahl8HQqLvi+CHpb8ISgwtWsq19Py/VbQE8m8SwGHkfIUO9uGDtRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612129; c=relaxed/simple;
	bh=4KO0NUFOW6hutGwnzAVn7ya4TyZ82iwbITVwQMJFOlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF8AUCbQxFIzAdIUPvfTSyrpCct+e0MqBUP0lpsYfNCGawPbvDorZ377f9SyCETrV/0xI+QUPkaFKWOUDtCdqVebqOUpem8J8pJH7l/MN0niAD4iJtvl1+4AOgfSIi8TxyhMNAuEB8bH7NSKIrB8x8kQZMnQwvT+7BKOcWUZOO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpW9JP5Z; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpW9JP5Z"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8edda5d56a5so4811246d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 02:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786612127; cv=none;
        d=google.com; s=arc-20260327;
        b=jj1dgF56xCFlelSaiZjrFP99vMGn8yrBzwY/ta/TD9s8rnWj6fgnZ8nECRIO3TpSBi
         PLYGAQlZox88X3lSKNIHeuQAHFDaf0MiHe68c9Mx5RnZXdbpHeHCs3BgejoJq2Grv1BT
         Ca6WGQx+dZUeKsUO6dOZeW/7wrNhCV5m3Ylsq5Mn8LNSUZhM0V1tEbgvKjI5Pxn7vC1O
         R0tHjoLx9psF7/H2/c8k5DM1XpIP8lPxrLXcFAK89lDNbW74WvsV1MW5KgdRHWqVJegV
         KWapCmxsWWy2OjqjT//VkVoV1lh6AZ7q0AQF9uBSSvkUL8MZ5hVc5UBaS6DXXckURJqr
         r81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4KO0NUFOW6hutGwnzAVn7ya4TyZ82iwbITVwQMJFOlU=;
        fh=DXoq+FmkEVO6X/raUtohDzwndiB3te2zg9KH4zdK920=;
        b=eHfcimQgM5MB6fgTHyMkeNe0fs9NzcjWqBRtN83+VJDhIwhcHBwvxUa6Y5xtmgAIYg
         5iSitURW8Uq6EeHk4v4Ke1/P8TTrr40ijJdc+5AOn7KRMkhU9v6Ryrd+4O2t4eHt2+g+
         T/DjnLs5f0EbRfBs9/+PVGhOwh2MfbEkpgmmw96OVLIgAR1ZGmOGhda+Rb34WLcY6YuE
         KxbyjjL5lOCx1R++7ZO8vy8SZ4fZQazztQEcl1GQtycVK+qnCWEC3BD6s39FAehOpc/e
         qX1TM6egec6lfAcUI6XJGAvGYtd1whKNIeXnKZh9LbD+3hTzUL4yLO0X+psxY1qiibHH
         lmKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786612127; x=1787216927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KO0NUFOW6hutGwnzAVn7ya4TyZ82iwbITVwQMJFOlU=;
        b=mpW9JP5Z+CYziUO9YI4OAiSzYK/wZVOit8vOfN86hmc9XX9DBlJgZIHeEAUs+hip7V
         L8VH9OFbzS+Ocg2wnxjBPjGsyYo/CAv1vSYdb/NnaC2uYJ9O91O+6zXntVqXxBghEEuX
         zLNrL7e4Bm59gdudHBSHIMUmVXmeyu4Wz+1OmhamLfOnr6+W4VhNn/qFU0lNLj9JuaoE
         KDPbrDWgwyY2geDjfxGFo/juIdB0k3uRjnlGZMzhXqe5Qe58r3Z2yENt5V9g5cXEE/lI
         9zbhbVebxCZ4eHLZOTxbMai3pLeH7XrEk4k0sOYZ3+oDwEfjx/VwxTpBrnt5AqxrnWwU
         7tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786612127; x=1787216927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4KO0NUFOW6hutGwnzAVn7ya4TyZ82iwbITVwQMJFOlU=;
        b=aSnwaT8S/nmeFQb6TZvHL7nkae/f9N/kSuzxw3JQjo1QkZa9U4pXBHe339Wr9NOjuh
         DKEZSwEas6d5v16JTE7o/F5JUjPIU8Em70nVj9IF3g6C8U/e+gDoiLekZsxXNq/vM1AN
         NU2hg/VJKUp5l8V3aOKItXzES1GzLChUZdLH22+IgjYfQgT8lq1bLsIWyRRGHIotE3bj
         DHp7uPM09HZC8y05rrYQVNWzpROec6oVutWv85m00OHtEpEpJJUT/3JHMw+v7RuGJOD9
         NggOZn4skt5vWTwM+p7ULnD0oxkMpNGvEm8ESMHDLaUlUsEW2TR53DSiwDO/2b+IXhf9
         gjXw==
X-Forwarded-Encrypted: i=1; AHgh+RrJfXcs9Hnbj25/eCnCwql0NPYMzcyJEWvUa2h1zLz8RQ1G1t7c5jPTyuCNM4QMObASp5DmGTz6fzUQOa3sUO4s@vger.kernel.org
X-Gm-Message-State: AOJu0Ywft4O1zxTjSvWQaFNSUkjDZoHXAm1GjDK5vsT5ErtVbmPeeB+a
	5cK9TmCrfQkTvrsZmY6AXyeUjPuU8v0yrI1cQmVGgf482NlUrcqlXeOW72At2zX6MQPY3YDsYaV
	sncvU1MubYHbZk4acfuJ1vUGcPYF57WA=
X-Gm-Gg: AR+sD114t7F3/M8sVg7alVuMd3Kh8IQLcBWTKkUp+u5X//ICyu18utPVQa5QiNz3Fcu
	Ea5qX1+FWbbboKXTdZ8aPqyC+AE1O2CP5e1+qG0+QEGRlNxzaLPKMPePXdCtg9YiISMufiMY3i5
	ppbdAn7rKEe19bUIhkgg6JND5AJPUdr+zBGG5X/cnPu0iZhSPplAnaKi7SIFux0NjPLDed/P6X2
	6yeKCQvxP5F0buBEWP18LPpnjta0iE75rqaBb3W319uJI3SENvqoPBMQ0CbJ8nnMX678wi5XgBx
	m7ICuh87wsV7MF6hOibYdwTP1gXPmUV43cVfLktEkA9/wB9a4J5Luvpn3jqVN99WyalDEdZmjOW
	qWVST8851dO5od4qw0HREtT7N1VTdm7rFeztP2zNpXh90iuwFoOLc5p+I/Cu8URjmfN/8rTAHYF
	NsD8PwUMjrVDg6nrCo19rXP+0Tq50t8A0WtcllkRI=
X-Received: by 2002:a05:6214:27c3:b0:907:88ec:6002 with SMTP id
 6a1803df08f44-90a80b5d571mr35846786d6.12.1786612127007; Thu, 13 Aug 2026
 02:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com> <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck>
In-Reply-To: <anwuYYxLFbtDmmHx@willie-the-truck>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 13 Aug 2026 10:08:33 +0100
X-Gm-Features: AUfX_mzk7-Fr80oSZcS7JCXx3W7IuSj6GBQng9PwetDjVwwKleRLeaF00AEqVZw
Message-ID: <CALeDE9P1xZonVnZDExR_hMafd4mxahkjBVTDLJenQ6DKW5MSHA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: Will Deacon <will@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	u.kleine-koenig@baylibre.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 at 09:28, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Aug 11, 2026 at 10:24:15PM -0700, Ian Rogers wrote:
> > This patch series adds an uncore Performance Monitoring Unit (PMU) driver
> > for Broadcom AXI system and VideoCore VPU performance monitors found on
> > Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).
>
> Why are you sending four versions of this patch series, at -rc7, each in
> reply to the previous one? Nobody is going to review that.

I'm also wondering why this is called rpi_axi_pmu where it very much
looks like Broadcom IP, and is possibly used in other Broadcom SoCs,
Florian can you confirm what this driver should be called?

Peter
