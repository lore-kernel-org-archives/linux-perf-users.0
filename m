Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10831A81C
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084228; cv=pass; b=ilaIk0vv2NXjaIT1UDPDXPWCAvVegrhns7vZr/cmQBdM3INusFTDy+GVRvgaqEvlsgNWOYUqLtPOM8uwWkRtPm2Bwt+Ui2AW0WNpZ0vR6McWnhY4zgojQkaNdv0q4nwkKunTZDwfL09j/d/fZNi2KJB4207RMHHKU0uttVi5Ac8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084228; c=relaxed/simple;
	bh=5hhuX9pDn7u2BnZZ1CwG89QMSBA82MbIbw8gCXICsj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/GtoVFvNENxC4keLelpVzow15F/mThp8rwuhXfOdQwBrlJhshNtDSyI423LWtwKoT0nn2ITBlpRoe2CoCCXu8Gt15SP3k9T5AHIXVTVBRTMQm7VHBVwubrrefh01A+us1R3Jg/vq3ln4SMxiw3DtZ0iEOryYFbwVuTNOSMPgVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTiAltTN; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTiAltTN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so105755ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 09:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778084219; cv=none;
        d=google.com; s=arc-20240605;
        b=AmxG8lb/lpMCysmTux72/lULZwOTki05boLjsmWuQsYte5jm6gRg2A0DLI3e2PJbso
         kazSEEg/XDoe2jJkkP2T/ty6lr6uFJioxuBAm3saLNO5eWNY6DUi7h91jLbwa4ESlg8L
         UwAeuOMIBgzSw0cGSYjtepZ+WjVS7DckCWAK6jlkyWrbZTHALWEMXxS2NH/wuxHs7F9/
         Dh2re+X5uqDucdFApYTodhXgYE1SzCzlKFcXSRs8uVRiuGUKK43h6TCOoW0xcdzlBv/q
         fT2NwyautE67gO+LmtFXJ7KfCCIXnylAKGeRknN0Hj3PyK6OxMIluYBs8I5Zz85guLV9
         0JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nITa0oyX/YI//ATItHp5GhcOWg+ADJpIpLv2fDvbK3c=;
        fh=++27hDVorPC0AN2VhpG0lRa2E9EkgMKQsulpPz+2OCU=;
        b=fk/Y9+2j0AU6hpbrlMjyRJ7o9izrX2XJyRKnyiXnjUJ7+VkMU9VtNDbAsuFKje4hDY
         c1Nvae0J2X/729wPNFli2WDOV297G3jTETvBsn2msY6y22fKpKYHstMGBaJVhJGwcJbz
         wzqEQo8Muh34gbBtxEhQd53RjTdoz+qNSe5KBT+xNEA94R/oGkZO9B//D94RgudLMpw9
         C8eMLHS7dFXYKwYZuZA10PN05Oi/hMu6ezAB9IAOVEjqh1XCdPi0vG549lLtesAhds5b
         hmKjbCSyoPvV8yLB9N9Wl/jrEPTaSEulCvO7FGuwNLskPi9RHfpLUlYvoiIG5+NQo4cw
         PRNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778084219; x=1778689019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nITa0oyX/YI//ATItHp5GhcOWg+ADJpIpLv2fDvbK3c=;
        b=jTiAltTNq1pk31Rml+/SABs8pPxhxNBCQZQHTQp6+MPYLgCs31U+eoaHBECTyfRM4W
         7rovIsS1KaoZUiCRFHmqasvLbz9wWyf5rwQWsfdJSnrtUOIbGgn48NYUDF/wkXp14l31
         UnO+k014N8EwVoubW0GDdKR9MqFLKVsW2JfI1SREq5Y7b33SoZqZCKAlOfOyq4tHOQjK
         r/a41bjkAG5D/bQMeMztUsPQDlGs6RHAxH0YzJwWnoeHp7v5sC2xSAoySNP4WP+kjI2z
         +v/rTRqjuO5QAKwXC4wprjvlZNEPt1gTDvPpp7khfYHoxQnS0KBxOA8D0SIOI8uNySWG
         uxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084219; x=1778689019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nITa0oyX/YI//ATItHp5GhcOWg+ADJpIpLv2fDvbK3c=;
        b=oNdezQ5lGvdYKsfZo/51k000+WWbmA2q/GwVA+V7R21wSosU/5gijDkVoNm3lSmUou
         FUUuUAutIdz5cMDzcie2+TZ35DPWNIaWisMsIdx241cdL9/HbRQKnABiLAQ8SzF/eXCS
         30LZODiqdGgIXtlUMqza9i5cC2bYCC9E+vWmO/6Ua7sWmlOUMknMfp2B60eJfQtRRaBp
         hjEV8LPv8Hcaf9QBi/cw9Wv3GgFjf1ljofoN0WCsEevmLjvqkRTp8Yg+ZyilR5Gkp+OT
         JHaeef/W+7EWKTe5Bz/hSCWNysNjEWlfJF01sUM8CvN6ZYxXBl+04boI3clBbtSUKO00
         IV1g==
X-Forwarded-Encrypted: i=1; AFNElJ+PjLXVTyBGhNR8mLLyEJwqxt7ydNhK11qv5dNSagrx+9H9+GxkGsuKBEY7lHZMgMTnuNIPtnfURd15yk+4ZNDL@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxaIPk40QO4EiuilOYvJwX2ZpYYk2yoSF5UlIQgC41e0E+AtM
	GK+Pm6mY1Q8KlP8N5/09FHX/Qnf/YDYtXuPagCIOu1AW+WkEF3enANHRDpNNQago44ms1nd7C3s
	N8FFeSXz1Yp6AD3h8CU1E47lA4zihhpzyX4r01UnO
X-Gm-Gg: AeBDiesYLYxepVfqt0UzTVXdL7IDgri4GOJIz0XZ6aRjV3cHBOo5lLfROGAGXkrhqRd
	eew2pHkPxRT6pb5xOoNVHaq4wd1ySFaYR8Wl8CXnziwc09pV2GxVWlB8S4jHCwjSa3rhw0PzlcW
	gnzo6wkNzsv0+WKsUQF/yfoC2Dy9Oh11juakOpWOx0w0d3CFGktnB9tvJHckL4weGahC89yhKuF
	MD0oNRtoPAwPkT70PdyK+3Df/QrnENsoyWr8mlu+XwifHCsCMgvQ+mGtfVUM0eEQv5CykmIid9t
	uwc6WWPXfpUtxrBEvGhQq0CauWUumw==
X-Received: by 2002:a17:903:1b48:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2ba7cef9053mr3209025ad.13.1778084218038; Wed, 06 May 2026
 09:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504072937.2103453-1-irogers@google.com> <20260506004546.3140141-1-irogers@google.com>
 <20260506004546.3140141-2-irogers@google.com> <aftAgoXnB6xuYGAt@x1>
In-Reply-To: <aftAgoXnB6xuYGAt@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 May 2026 09:16:45 -0700
X-Gm-Features: AVHnY4KOlQYrQDIXGNZ2F44WcCmg5u9v4h8JeCxT7eA2BfdXFOFFLcaOBULeJ4c
Message-ID: <CAP-5=fUBBUcoPaXP7OB=1pw=8f9Fb2KrZ=2G+F2FRr8wXbzXTA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] perf sched: Add missing mmap2 handler in timehist
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: gmx@google.com, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 6:22=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, May 05, 2026 at 05:45:42PM -0700, Ian Rogers wrote:
> > perf_sched__timehist() registers event handlers for options using the
> > sched->tool struct. It registers handlers for MMAP, COMM, EXIT, FORK, e=
tc.
> > but completely omits registering a handler for MMAP2 events.
> >
> > Failing to register both MMAP and MMAP2 handlers causes modern systems
> > (which primarily output MMAP2 records) to silently drop VMA map mapping=
s.
> > This results in uninitialized machine/thread mapping structures, making=
 it
> > impossible to resolve shared library instruction pointers (IPs) to dyna=
mic
> > symbols/DSOs during timehist callchain analysis.
> >
> > Fix this by correctly registering perf_event__process_mmap2 in
> > sched->tool inside perf_sched__timehist().
> >
> > Assisted-by: Gemini-CLI:Google Gemini 3
> > Fixes: 5bbfec0ad93c ("perf sched: Implement timehist option")
>
> I'm picking patches 1 and 2 as they're simple and passed sashiko review,
> but:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$ git show 5bbfec0ad93c
> fatal: ambiguous argument '5bbfec0ad93c': unknown revision or path not in=
 the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$
>
> The right one is:
>
> Fixes: 49394a2a24c78ce0 ("perf sched timehist: Introduce timehist command=
")
>
> I checked and at the time, mmap2 was already present and it missed
> adding this handler.
>
> I fixed it, in case I'm missing something, lemme know,

Sounds good. I reworked patch3 because the remove/insert pattern was
potentially racy. Now, with the write lock held it mutates the map
entry in place and then marks the backing maps as being unsorted.
Sashiko reviews made me aware of about four instances of this
potential bug. I've also tweaked the ASLR code to make it more robust
against colliding host/guest VM PIDs. I'm running sashiko locally and
will post the next version when satisfied. For some reason the
external Sashiko seems to be catching different issues :-/

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-sched.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 555247568e7a..241c2f808f7b 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -3299,6 +3299,7 @@ static int perf_sched__timehist(struct perf_sched=
 *sched)
> >        */
> >       sched->tool.sample       =3D perf_timehist__process_sample;
> >       sched->tool.mmap         =3D perf_event__process_mmap;
> > +     sched->tool.mmap2        =3D perf_event__process_mmap2;
> >       sched->tool.comm         =3D perf_event__process_comm;
> >       sched->tool.exit         =3D perf_event__process_exit;
> >       sched->tool.fork         =3D perf_event__process_fork;
> > --
> > 2.54.0.545.g6539524ca2-goog
