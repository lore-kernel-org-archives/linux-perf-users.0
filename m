Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD519E992
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774109328; cv=pass; b=qkHu8f94IaS8/tZ8CHHiO6pwx1ph23426ZSAOuX049UtwdsJUf6Ai+VPDNA8jua82RzXtp8yulspGiDMxqpc8J59mb/ZBtFPKLFJaP9cnNI94cLJfSKxnaDvv3/th+cql+isJND4lgUXl1+xlqDEnhuyGhPPNWpJN/2TjFaVP1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774109328; c=relaxed/simple;
	bh=iG7fQBUq6AV5Pl+IRaBFIukp4ILZYZNf0kT6rUelntE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZiHWuPO3TrZ++qgmecZpwPY7+AJqPckde5fLX76MGCW7Nxgce0K+08ApMWOa7GMeYl0UML+9wBL/OPz3icn8Ny3AczThTBi+zVuKozLxQXBfFimEVWibl7MF2yoFz5vIoc/TfdqDjEtc4po9bs6vKhHayFkrxF8UO7EaFzEyRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tif755z2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kjebZwnz; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tif755z2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kjebZwnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774109326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5Gn2W2nUjRCGyIbKZ4RgXOOpfdeMeWuqEVTqDlQkd4=;
	b=Tif755z2H8/psNjhsIcEwvTVnu7Xa/TJ5ZZkS7K335ERZIZcckUQ6J5svB5zepIzCIwnSN
	cWsqKv+iqpgFpp1L3+1V0f561bhnVJWHYRJTxilGrl68bgyMGwtm4TFdOZOFmPlXcQ899t
	8Ep7mM+RcXhrInCepq9sly3QNQCATdE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-m1rX7oKJO7Ko8DSRTEQ8Uw-1; Sat, 21 Mar 2026 12:08:45 -0400
X-MC-Unique: m1rX7oKJO7Ko8DSRTEQ8Uw-1
X-Mimecast-MFC-AGG-ID: m1rX7oKJO7Ko8DSRTEQ8Uw_1774109324
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6679523f510so3018175a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 09:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774109324; cv=none;
        d=google.com; s=arc-20240605;
        b=MK4Foh+B3t+gmew+3pxj1gbFTKVbfvLsthvSGE50p4lICQ01dDVYJvy9DzA5QD5dZF
         RXUu7j8gywzk72qUYSHPJCrZ5ThNf+gK7EMjR0FeBNWlhMHzyMZClHwdHjKKXuCMC3f/
         U8xqmLelteSC/RRBEJoB4JjxSrOgOf6rACKUh9q9kRXOb34NmWI8Gq8X85Z2sz4iQ/aT
         /1JYSuIOSGoFFsN51IS7ivWsQoKSa+doVpJxfazcv+bSAGIzWnEWkhvYQZt05S+7H3RP
         +gUQfHBkQ2CorrbBISJfLGph0R/HWwKH6BsPH6IE0MUY0ag+BaxbmEkvdNvG63vSquSA
         zO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m5Gn2W2nUjRCGyIbKZ4RgXOOpfdeMeWuqEVTqDlQkd4=;
        fh=bu2ojpYFBA21z8S7ARse3hmbg6nD1JGgNghkZ5fCaHI=;
        b=TTAVIpY6DC6hUCmRpFauCMaj2Z+1aI4WTbMygg1t70BYfC3e3dHvx0PtlpgM79W/Vf
         BNnnexnAhweChanM/hsSDAs55V1RHODKsqS1geLkFov+svNG84p8NxhH6VzbFIPJ2vH5
         SENp5dHL4h/124iFyWZGyPLLQplx/bavEGx8ZdmZ2go3DjgQhdISvhL+EDQk5dtP+rLc
         UeqE53Y0UmKeUwxaeRkRKUXbqItKtmS6O5w1NRV9plUSpOidjjtadHIi0cJMqC2sMsc5
         eC9rgGXvvUezMW2nBjq9WZEifHI7YJkEf0Hi/IfoZs0qOdcJtSf/3/FGFZPjsYJ9MEkr
         JjJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774109324; x=1774714124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Gn2W2nUjRCGyIbKZ4RgXOOpfdeMeWuqEVTqDlQkd4=;
        b=kjebZwnzGVCnlwch0IGhzJ32lQW6IPJT2nYHb+sfmrXSJfgJnIMjpFpW+Q24SbrJzD
         1W26bU3/KhyRpwd8AL1Lf6lFI+ln9odwKRC1JPS63aAd/N4uzrsc3n/4IjUvY2h3EDF4
         yIaQLeRB5wNUXVQLCx0yMmR6DXs8qrcqEual9vIFM44BDKCBwo/m1Vcj/PsJb3RVSkSh
         nODV+/RJzwWCt7kzvJ7a8HyfQ//VMZVhroGJ2QyisZFxLJien+pb1+LPVt3dqqrhyNRP
         3R5sUD/7MyrajlksQRNRhcy3Xf2kf14LwDq5IwM9Ovj4rcly4uR0d79RMW4ZWq7g1S5o
         CaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774109324; x=1774714124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Gn2W2nUjRCGyIbKZ4RgXOOpfdeMeWuqEVTqDlQkd4=;
        b=Akkh6loNrr/5iGZfJLHisgOL90LG23NQfgRGFUaGhc50j0XDq/yyjmqb8E+LG9cvNK
         BK4zvghsU7yr4T9CNU2xv75V+adg6wwHhfOJkqK3oU1akcCjyV3i4MJwsbTvliQcGLmd
         H+8tu/iQQXc2UEwDNxNqwrVgBvi0D7ezpp4T3yiDk6NRKOkosW/JIPtPSUqyYDyWxGVL
         LwpCQOc/OEbFfeu1emHsQDGPwkrAHrs9/vtkroQcyK2IjPVmo58s+U4OXeb41d4XPKGe
         kvOONXqVJNAj+V1hiQAMgVEBwfVdsnTM2AUPLC1XLOcdTa02aU6OOrxxN9ecQ8TXDNhS
         t4kw==
X-Forwarded-Encrypted: i=1; AJvYcCUelZFBT+ObqNCQbpgyLXSo+AIvU1ocXvggpzGKidOYJuUD24olsD7v81AW5SZi4Q4J5q7+DPfP50RaXuT907d5@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPkq4z7FyATlL4vW6MKhc68j0NbPG9xgqEjHyMOHDNgC/XZkO
	2er8/8tsssUW9/TH9mrB9yFushp8ZqtvZ180MaK0W438JDed6WqR8Y4PV9+wAcbWKpxaxJrWC0g
	Kd2ANBTRlWZsp11CK7NPshLsiYN2HuWdWRIm2V6LT4Vovn4n5fMaUZ+3kDzGpnkdOK0w4V/fjJ/
	T372TjKyqMYw6/sHwj2wdNqg4RxWr2jsoiBpaxquKIeMSWOA==
X-Gm-Gg: ATEYQzzsrBRYVxmnlboGXnTWzxiIcFdu2TIBfWTq2PlhflnFCkP1xIfGZz73kspM9Js
	NWWhzE4SwmqkWlckSlHIBEnEd5g2FLDFKFc2aVsa/7l9SdGMWy700MUC6OyWfboBofFqLIin5y6
	yoV22PAXUwXdJRv9hns+TDWfT2G7rKQ12zUmjAeLE2JFkhbNc6seGZsGYZGLQ/x3LPB2pX8F8cC
	fd2GytqIKJ3vPhcVugCPwOzor/DdZiducOT++k=
X-Received: by 2002:a05:6402:5050:b0:664:bc6:69a9 with SMTP id 4fb4d7f45d1cf-668c97208femr4586778a12.17.1774109323818;
        Sat, 21 Mar 2026 09:08:43 -0700 (PDT)
X-Received: by 2002:a05:6402:5050:b0:664:bc6:69a9 with SMTP id
 4fb4d7f45d1cf-668c97208femr4586766a12.17.1774109323433; Sat, 21 Mar 2026
 09:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
In-Reply-To: <20260320150651.51057-4-tglozar@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Sat, 21 Mar 2026 18:08:06 +0200
X-Gm-Features: AaiRm531oz0EqyoXJ7hHAU-cWOd72s4QUjMps8WXa2sE_1NLdGfDFvTSqoaWsac
Message-ID: <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 17:07, Tomas Glozar <tglozar@redhat.com> wrote:
>> +#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
> +       "display data in nanoseconds", \
> +       opt_nano_cb)

-n/--nano requires value incorrectly

 File: src/cli.c:463
 Cause: TIMERLAT_OPT_NANO used OPT_CALLBACK which expects an argument,
but -n is a flag.
 Fix: Changed to OPT_CALLBACK_NOOPT:

> +               HIST_OPT_NO_IRQ,
--no-irq clashes with auto-negation of --irq

 File: src/cli.c:1042
 Cause: libsubcmd auto-generates --no-X negations for every option.
--no-irq (histogram boolean) collides with the auto-negation of --irq
(stop threshold). The first match wins, so --irq was matched first and
its negation intercepted the call.
 Fix: Moved HIST_OPT_NO_IRQ before RTLA_OPT_STOP('i', "irq", ...) in
the options array so the explicit --no-irq boolean is found first.

> +               HIST_OPT_NO_THREAD,
--no-thread - same issue

 Cause: Same collision between --no-thread boolean and auto-negation
of --thread.
 Fix: Same reordering approach.

Costa and Claude

diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
index d029a698e8a7..c6b9ed920539 100644
--- a/tools/tracing/rtla/src/cli.c
+++ b/tools/tracing/rtla/src/cli.c
@@ -460,7 +460,7 @@ static int opt_osnoise_on_end_cb(const struct
option *opt, const char *arg, int
  "save the stack trace at the IRQ if a thread latency is higher than
the argument in us", \
  opt_llong_callback)

-#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
+#define TIMERLAT_OPT_NANO OPT_CALLBACK_NOOPT('n', "nano", params, NULL, \
  "display data in nanoseconds", \
  opt_nano_cb)

@@ -1011,6 +1011,12 @@ struct common_params
*timerlat_hist_parse_args(int argc, char **argv)
  cb_data.trace_output = NULL;

  const struct option timerlat_hist_options[] = {
+ OPT_GROUP("Histogram Options:"),
+ HIST_OPT_NO_IRQ,
+ HIST_OPT_NO_THREAD,
+ HIST_OPT_BUCKET_SIZE,
+ HIST_OPT_ENTRIES,
+
  OPT_GROUP("Tracing Options:"),
  TIMERLAT_OPT_PERIOD,
  RTLA_OPT_STOP('i', "irq", "irq latency"),
@@ -1034,11 +1040,7 @@ struct common_params
*timerlat_hist_parse_args(int argc, char **argv)
  RTLA_OPT_KERNEL_THREADS,
  RTLA_OPT_USER_LOAD,

- OPT_GROUP("Histogram Options:"),
- HIST_OPT_BUCKET_SIZE,
- HIST_OPT_ENTRIES,
- HIST_OPT_NO_IRQ,
- HIST_OPT_NO_THREAD,
+ OPT_GROUP(""),
  HIST_OPT_NO_HEADER,
  HIST_OPT_NO_SUMMARY,
 HIST_OPT_NO_INDEX,

