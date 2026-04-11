Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DE23EAA3
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775869690; cv=pass; b=WXqCCTcmnGdq84FHHnPA0HNooRpYRsMzkV+zIBU/l4eQ2/h6DhWotXCgJLGiSddnq8t6JwNmKCowUu14umLG6Iczo+Xs6t5aqTFhL97pHPuUbZSof6/jLr4Sw34irOGrFcjF8xOSyuz5FCiPQ80Pcw33sfKEOoFBffqwLeLEQRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775869690; c=relaxed/simple;
	bh=YUochixg03ZpaljTd2VaOQwB3t10UK6Ps+BhZKinKJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAyx61LsePVTwu06ChLa6motAAzQEJ/7rqod0QAvewxybWxtLDBetqlxRsuYx8eUI5cVYRJiWluWd4q2YmzDaaI305r731Ptuqk5sgXJk4FCqDBhcejIlGk0zvceNDUJVyWFHGQ5LEKkj3kz3LSo3k+e3oKH5FZyJ1jK7jbXneY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bORUgYbG; arc=pass smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bORUgYbG"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7dbca22dbfeso1351299a34.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 18:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775869688; x=1776474488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy269hkpy9ldixEQtvCjWW2eQxQx0iXY3CiT1WCgut4=;
        b=dgqATU9ewuM0Vrm9TPDNgQrjhfubxHruWe8DFQzLHYEHZb1pF+ReISG4+4OTIKiYpv
         lkj11tdxdOFy65c3lWX9KpxSYAqPLkLqrY59SsTF9vc0SMCeOffb7oa1GILdrnHREEqm
         AtWr7ETW6ERFJu4LbPEijSa9SpxdGtvfBcNGpP24HttW149fpdH9N/B4C8Z7L+k+8gQN
         0IngCB7SGIv1pOcGzLZlhgGR4YkhZNVwaU+qyEM6qwzZ+zwYjNomHvb99eRBFBjjpm/P
         A9dvkUJ4ZU7gbkoy0zq0fB5cj+Fvi/qcyQYMF5KqcIcN5YrNgJdos/i4wicFxsoNMS1g
         H3jA==
X-Gm-Message-State: AOJu0Yx6yzPyOjj3/SvbaqL52m8iqbjFe+uwYWgfx4mcR5+EOQ+Mb/cB
	qdCV+duKSwVtu0F4IA/fh/EwdswusIVesqdYtt9rGotaNOdOEqOXzoSZFTGzEEKGoLVZjjNMjFj
	4nSBgWoAFKjmjsMleqbVB649cYlhpPZxpIH6YlE0k7xuq/KbN0A4bVDKa3T3lMNCKmKwIjYDEA7
	sUsTWCJJBobVqktjRSWUlmWDrWypDcGiQ3ThBn66CMYNrR6CUv9CW4yRqD//5gBKNRPt07kkPYj
	odLz6jeBA8ef+uLJKIVxJAUkL4=
X-Gm-Gg: AeBDievm6i3hNphBmh0P29VVNPObz/1Aesqm0DnXzNDsfoJL4kISe0iOYW4JAe4Y9fI
	TGo5uanxR0ssK5AQysz6iCfC/YWAmQhlH5Kap3N1PbUr7H2uhIa7lu34C1wA3Z22TivVzrQhPG4
	ivWyfbBMTwKOqgN9MiyhGl3AjA7sm0UU6L2yWZ4D1NKgiPUiJR0MAu+wp5wfbXJVKhMzQk76PFn
	CgfmSOwtCzdi+MF6BwG5M+7GTBc01zsCv4pQtEwCB+r7DR3HTy//9YQPn/Nq5qh6jaM283FCko9
	8QVawAZW90GWljeDxld5RaJ/P2q2c+fhNX+3rPJnpNnnR7D+T7zIrc0kwYCwkoysuEbKky7iYEP
	CwLQdwJO0qlk/uGnkKBBP8dK4tk9XsPbEPy/LuvV5SMHzBd5866gx6VvksbOMU6S+5RCY/8QEB6
	pprbQRSnHY2zPw7ZCccCDENHmfJafKRlEFjzztBZ2QHy6NVPjLpU5jrG5o
X-Received: by 2002:a05:6830:a90:b0:7d9:9e43:b8c2 with SMTP id 46e09a7af769-7dc27e1ca61mr3901337a34.22.1775869687965;
        Fri, 10 Apr 2026 18:08:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7dc26553248sm431941a34.2.2026.04.10.18.08.07
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 18:08:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9ca1ef3403so41957266b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 18:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775869686; cv=none;
        d=google.com; s=arc-20240605;
        b=bXpxc+n9CRSPjTLA5kDJx0kDbhqiy4xReQ3j2dkuy54fofThJfZIV3vBCL6Oe6JLaw
         JbvrBAjuKLE81KQHVmMRqCpsJvt0DaIdE//p/hw6QG3b7xttm69wZXfzUkYwVdCugPgE
         bCvTTi4W3yjo63pJ/Gde9KjFZEfxlltodVLip3IMPFCwFWmCy5h+x9rboHfXP0mhc/+0
         QcfKpu3cDYBfroSV38XqFwpKxzELfpH2YEr55TLNmda4HXzdGH1S4wmMR07+VMMwfb8Z
         qx0rnQzUFEBOIjXdKzBHEqfBvCKJoeEmR4CDtdEG4dU8Xvik5/rGfLL8WQ3wLQK7LY9a
         zNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zy269hkpy9ldixEQtvCjWW2eQxQx0iXY3CiT1WCgut4=;
        fh=M7dgFERw4uesn/FOjiIgJErd4Vliz8jZjoPDQSzHYQA=;
        b=h38DUsQF8tx6jUVRAHb8BUYsEQo4OpJZ/w5gioogBUOq9dXFseQeA/UaSCecBjnDt9
         gsMzZkxVz+u5cU5DkegGHk3gnLbNmpRa2sX1zlpmLWC999u8uyTWsfAMyTxN3ZukOf1m
         +RYo31jE70pBx4inQs6+vvNiikE42lpTHYOlvbY59n2KgatFiSJH8y+dOocMcacRo13Z
         kaQg7tKX+Ou0G/s/KDZY66vRC4j4Ohv8QyYwZb1t9a+erTMqF+T9hgY8FG7sAT0URfF2
         eJ/RRL0zSH5QGcp3CPxk4bNZAfiI+dentu6YUtG0UZiWfwVxES9emN2Etnke9urUdQYs
         aH2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775869686; x=1776474486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zy269hkpy9ldixEQtvCjWW2eQxQx0iXY3CiT1WCgut4=;
        b=bORUgYbGt0jWA0ajXgTBZ/dJ44Nrm2TWgKuY/q49ScPxbdCVKHRWebQIaN6r+5V0HM
         3WqGux8d2FKSg0IUbcKXnpV84rR4AweS5JsIm2I/lHI278WejNHcVhstjUajOUW8fl1j
         INLYBSckalC3ugpUmuHfo9rLtQW3xCARymV7Y=
X-Received: by 2002:a17:907:c928:b0:b98:4e9b:7e49 with SMTP id a640c23a62f3a-b9d7279a9f6mr206150266b.33.1775869686138;
        Fri, 10 Apr 2026 18:08:06 -0700 (PDT)
X-Received: by 2002:a17:907:c928:b0:b98:4e9b:7e49 with SMTP id
 a640c23a62f3a-b9d7279a9f6mr206149666b.33.1775869685658; Fri, 10 Apr 2026
 18:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409221418.185343-1-mmayer@broadcom.com> <20260409221418.185343-2-mmayer@broadcom.com>
 <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org>
In-Reply-To: <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org>
From: Markus Mayer <mmayer@broadcom.com>
Date: Fri, 10 Apr 2026 18:07:53 -0700
X-Gm-Features: AQROBzAYSokXcqqrKEmR7lCSbnOtx3T-x4KIsExDNwUPzwQKU-L5dwSH7ZTFMOQ
Message-ID: <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second location
To: James Clark <james.clark@linaro.org>
Cc: Perf Mailing List <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 10 Apr 2026 at 02:25, James Clark <james.clark@linaro.org> wrote:
>
> On 09/04/2026 11:14 pm, Markus Mayer wrote:
> > Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
> > shell and cause it to display "argument list too long".
> >
> > Trying to quote $^ doesn't help.
> >
> > In the end, *not* displaying the (potentially long) list of files is
> > probably the right thing to do for a "quiet" message, anyway. Instead,
> > let's display a count of how many files were removed. There is always
> > V=1 if more detail is required.
> >
> >    TEST    linux/tools/perf/pmu-events/metric_test.log
> >    RM      ...634 orphan file(s)...
> >    LD      linux/tools/perf/util/perf-util-in.o
> >
> > Also move the comment regarding xargs before the rule, so it doesn't
> > show up in the build output.
> >
>
> I'm assuming this is just a cosmetic issue so it doesn't need a fixes
> tag? And "upsetting the shell" doesn't cause a build failure?

No. It's not just cosmetic. It absolutely DOES cause a build failure.

From the cover letter in this thread:

  GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
  TEST    linux/tools/perf/pmu-events/metric_test.log
make[5]: /bin/sh: Argument list too long
make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127

> Otherwise looks good to me.
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks!

Regards,
-Markus

> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > ---
> >   tools/perf/pmu-events/Build | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index dc5f94862a3b..dc1df2d57ddc 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
> >
> >   # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
> >   # of a build step.
> > -quiet_cmd_rm  = RM      $^
> > +quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
> >
> > +# The list of files can be long. Use xargs to prevent issues.
> >   prune_orphans: $(ORPHAN_FILES)
> > -     # The list of files can be long. Use xargs to prevent issues.
> >       $(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
> >
> >   JEVENTS_DEPS += prune_orphans
>
