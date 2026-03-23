Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FE3B0AC7
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275371; cv=pass; b=t43jPHaV81PdwN9UWuNl41R4n+Jd7d1vXH1Wdd8rntJKbkQ0E/xGN5drR31O8oKhuViReZyZMh5oW+gZ0wFIkC0unSR3ekS4UdaZ5TtODgrzw2tqfATV86tsCvpxvvGWMc/P8J3ItPjoDEzaxaojlXcqfjX/8cj6m7YCpSg7fqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275371; c=relaxed/simple;
	bh=1nIqdRIK+bdOJEY5Yuv7/zhGEajgtRCx1Do8WfIUy7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9mnRcSWTf9fZNe38YtEEcLzF21N9JIEClSHbqQRkMQTAc1Z4cTkjWXsCSY9X2fxpFLNTz5iwiYo18vYNAYvrp9tgFG/XbfOWVeSDKo5MeX3b0bgCk4ZQaaW9HG797iOdAc1btX0bsUWRnOJ3eNz71tKfZug6C5N5xan/ftDAVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQGwWlgB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7T8VkK/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQGwWlgB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7T8VkK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774275369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imgXWCiXPKFseEHXN+izA67gyX9JBIBpeFg/nk4xdSA=;
	b=hQGwWlgB/pBaZBibC2M4WJA5AyGwm8m7eODETmCOjDl926/HzRDL0Dkt3SZ2Y1I6V8VmNr
	ailu2UhZ/fjgpmpU0BwV+rNOB7lVGej7Az1SKAH2cVNKKkwncvZxYYzYW6OzfaDE/0Teek
	YNCBP7i2AMK+QLqCFoiJ5g18nf5mAzU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-6v9TK0E8PmqnY70vNF4YSA-1; Mon, 23 Mar 2026 10:16:08 -0400
X-MC-Unique: 6v9TK0E8PmqnY70vNF4YSA-1
X-Mimecast-MFC-AGG-ID: 6v9TK0E8PmqnY70vNF4YSA_1774275367
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b940da8ec09so27422466b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 07:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774275366; cv=none;
        d=google.com; s=arc-20240605;
        b=DQGFr0O7urUZHfGjuCs3Mw/tNxWuwmgXQEyl1rUp3qxEvWQvgzHAv2H6wNKjSb1cAT
         +muX8NyPfwm+pnDCWHXyGSydYIF5aXjQP5uo/0Q9MwBOLsiftBZYEEkuz+DjNnOzjOOH
         XvMDIlPalFngO8Rx9oflcD33fkoLzibZPEQXo5MHhWVIaij1ajuYOpTWLAzYpt7sNzhq
         eC381pKTEiVMGbmpmhayzCXtFKextFEOlaDHYZsZXvBm/f3q1/6TgnJBapwAOKSacqH3
         Q2IyfOHIw4nQ95rOnIVK0MdZDUDT88TnCv2oPBFbV7u0p++586pZTgXfQoHH+tWHHFWM
         XCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=imgXWCiXPKFseEHXN+izA67gyX9JBIBpeFg/nk4xdSA=;
        fh=AysCU0GoPfLOtBi/gIM9JvcJ2byKjpA6Q85uQm1vGio=;
        b=Cl0H/8xSUZrGKrAxHZ+8r1GwdWbgEDlbPw1BrAc54l/Kk+W/sb4L7CXRHtFRex16aJ
         /LIQ0xgYF7cyRZpR1QC8QipibqB1hfTnas70g5Moz3awEz2zjKzs9DDnA7iOR28wrYGT
         p7JxgWGvc91xuI/Mw6+JhCNoouG7BXfbFe/NPvQpxAbGDogEs3GWL4cgv8s88yQK7Vwc
         1yUlTPlvPTvwYaJNpLPD2J2Q80QrkztgSA+0LkpfG3PUOLzxz5DYU6/bfuTOnF1cNiHb
         i9x2I/H5DW5DPJJBfNaaRhtEKOyC6Z9DcAPMj/FDr7lYk8toHMdpaOB0FhOeY8KXdyLu
         OM1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774275366; x=1774880166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imgXWCiXPKFseEHXN+izA67gyX9JBIBpeFg/nk4xdSA=;
        b=g7T8VkK/RJ4ORRgvlght4itJJgup/BLu+Jsxy5DAA1QmM9Ra6fwSseiddsraZtDMhX
         9gGLOWaMNH7rshK2k1/OCJcAXvi5zz79rNktTwEdRpdMWoubz1qJB8SI8CIqg4iHQTZT
         SoF4wVNVqEwuio8L/OLBu3/oTv1AZv10vd6d4+Uix67IG7NGVPW58/vuQYqqIGqAAapD
         4xJq5ceaJBSjOVbGI4Jkv6/Lt5v4iEhu07sirl7D9JD69RrJDbqpFGTZlStosenJzbLL
         vUjdQ983DuE53EQTbizKwyaOEERgiAzWWXt+ZOGFs1LEOi9Phe1Wzv1+jeL91/TTtVz5
         FwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275366; x=1774880166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imgXWCiXPKFseEHXN+izA67gyX9JBIBpeFg/nk4xdSA=;
        b=lnEymBG0LuYJpo3eFh3x25wSkmywLvoPlTXrzocdfih0mKftqNPDZOkcAXSZRzxE4I
         LypS7TTS2ET6LHBMtB1bsOk3Aqt6oXcr6MvkRCLJlU8m7dbVxKG/jSnVp5r97TDzhWdO
         uT+czhz53wllupnQ/04resLXLTZDkbGRqFfraNjQhJ4CGRI1LCWnRveh4DpCWFH/HwdY
         JwzW/wFByRa7UFlkSU5ywkAm1KCarYZNrctJw1nCvKCVRPWafxYjjB2eSLgPRDGaDsRs
         +z/vkVDJ62BwuSwePgvq1vi85QKeXZcXAg1jOTRPQe7gSBCGbEDOtWTDmRiKgyJnU+0a
         43Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW+SRl7PHgIEHbd0TsUbVj7+x09Dithl0Xmp57iDHSVXre2hWb7IaRAScoazjHHygchgHj+bR5KaUqK1Np7sRSj@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZsp3yAghkmFEqCJgsz1vOFsRVH0WrlbLHEioxl7GhGE5USNL
	WkdYvXZ5b8KvxNjkEtMTgVJmhsOog8A9kWFj5BTcR+M2MZr04veM8r5/nbX4aL05tYixV2ttwYx
	XUkVjaofL/KRc0iLGOAygdi9OQDTAinqfqtDcfpSJMsJDYH+0BgnRSDwodOdurxMP/QoSMF57dl
	HweWL8unp/6TKxBVkdxbBf6Y8JdaUgzsrQHdLWtIp1XcpJ53D7cclwxg==
X-Gm-Gg: ATEYQzzQ88iQ0MfWDy5YzVZ8yp8odud115vI0mwmBbLCH2D8A/wrp2Mc2VndySxqjet
	+06V+oJU0YCd/Nu+BJ4XbKBHOvCQossWNe5z7F+0I29IZswUocep7Dv5ZPCVBqt72MDyzqAv81c
	GzvPsEpyZHwjBiWWFK4GRYCxXa80EtY5vcy2Eow3smdscI5opi6WD5Z1xa5J5LoefAm5Az9R/ri
	EDbBQ==
X-Received: by 2002:a17:906:e94a:b0:b98:1b:5157 with SMTP id a640c23a62f3a-b982f28b1aemr705654066b.23.1774275366361;
        Mon, 23 Mar 2026 07:16:06 -0700 (PDT)
X-Received: by 2002:a17:906:e94a:b0:b98:1b:5157 with SMTP id
 a640c23a62f3a-b982f28b1aemr705652166b.23.1774275365877; Mon, 23 Mar 2026
 07:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
 <ab2D0a32yuwYTO1K@192.168.0.121>
In-Reply-To: <ab2D0a32yuwYTO1K@192.168.0.121>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 23 Mar 2026 15:15:54 +0100
X-Gm-Features: AaiRm51OaCr12M7bKmgPO5zKGS_Ot5Z_5dmTG4KQ7CY2nbc36ZRPKUfpZq_CCcY
Message-ID: <CAP4=nvSqarP3JtCqkvMeH3wmM08pTWADBSJR0RVN8b7FXYXZeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 20. 3. 2026 v 18:32 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> [snip]
>
> > -int getopt_auto(int argc, char **argv, const struct option *long_opts)=
;
> >  int common_parse_options(int argc, char **argv, struct common_params *=
common);
>
>
> The function common_parse_options() body was removed, but the declaration=
 remains.
>
> >  int common_apply_config(struct osnoise_tool *tool, struct common_param=
s *params);
>
> [snip]
>

Thanks for noticing that, I will fix that in v2 that will be needed either =
way.

Tomas

