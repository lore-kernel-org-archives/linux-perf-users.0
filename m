Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496025A33A
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265200; cv=none; b=VmwdUQT4QrFSoYsa99dkZQzScmf/C8iZrEX3ax3yNnmT44LmZqwV6pBSo9f92ANCEkJVtjp4BVrmsHgdg+5D3fvREdqeMM6JSHD628dsfP8MN/5JIOfUrptHyolAS6Puf8/OuLH73/MDDGIYu1SVLjQ8+8LWxcEIcux3xKbVmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265200; c=relaxed/simple;
	bh=92VyL1l/CCW1RzuyUm3CyqNURYeJmbDXunIJF9vmd2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiQg0lz5LJ016fynjaYGbfflj6GKc5CvIxh1DOWajEhRFpSBoJYbpMRhF1wSKpj9kSFQgA+apR5hxPYQyZqt34uhYxg77+aEphk2Kbu5qZCWbitRdoEW3Vr5dGyadlNjTE15ICGG09X4BcDpLqcDDcR0RRnFIztHnf04i6avCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e2c52703bso178038285a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 23:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265197; x=1758869997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkV81nju0TPvNncudyLCXK6ByPHFzfyoX04Ft1zWdlI=;
        b=mbH/TOoVP8Qok9InFa73Y2yYzNI/ytfyFRATsjl+upnWubZNvI9vBzzpamQQ7IFF4z
         hfWUCRtKoeCWyHkN2gQ0ntl7jLozBjAqpmZjI1C26rfSBkXUAECkG5gx1/WdOvSPtLH6
         MqRzXQ7W2kzX1lXu7iKsHiqetUgpl8QSrUlSVswWTbRkwKic03nyi2bkw+YLG37tfCpH
         8e80Mu9knPDUpTLQ17cBhO+OcTqmDXfhr3XXSFcByuViTIklYoeCyCyWFvBdQUwo3P0u
         iC2MRFgvXMckDQwqvBVgiDocJdPn/YSXZKiQz+aL+VWvsmVTogfU26XQf7QA2tvZgJWf
         WBYg==
X-Forwarded-Encrypted: i=1; AJvYcCWK7DN1RP6Dt8BJu7WHvbfccNvbvr03zH0Sy4GeWe9JkAjWG8piHvlLcsymHiCuOW8kwVdT2lwQMs+zb51HbncS@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjFmN8hRCBYmJ4zrvgUh+RlY8R9EGxxkxrQom03N1ng7lhe1q
	oweZKN8TIKPgjXR1w2Z0eqoJyWGsxiPJNaHqf5NRU0pa+Os4guBEHV5EMcEPlDv6
X-Gm-Gg: ASbGncsOq6Qyne2+oyEvM7K/32vdTdiBh21s6x0Y1o5ansPAoZkCnWFSLUD2RNpB/px
	XBb8VAihRMas5HIQrliu1LS+384Kje4iZg6mcj6jD9kPRYi5QEdGxI1fJZaYgeD4A2xjP/kPOjV
	NROhNCqlU9ult055qI2/ViIufKfzlj/d+6VPr6yV7QC/vAd27I//hu+w2iRgsAl7Hvai4Wrktjd
	XbWLXKV/Wmwtj797LAWQ/8hjsR1LNQ29wIKYW2h2NpcPzKZZ96uE0RzENdYs+DRJBl/eb5c6h7w
	pMMgo1NtkRmziFP/BN74gtTdFob7TfM7JaPQvgkxoI//b/2+WkQhNieT26znDXLL6inb0I7oVg+
	FT4V0nwnCCA5qXmJ8rwyDzB6UpiByhMy5Z+TyebspLIuBNHmT+302mSue3qJY
X-Google-Smtp-Source: AGHT+IG6eifJD+SNNql+3FbQXPXmwQg8R1VFpo8paHp2nC0L3gaAES0Xh9v7yQjWJl61j/mnliRdmQ==
X-Received: by 2002:a05:620a:60e3:b0:828:769f:b155 with SMTP id af79cd13be357-83babfe7eb3mr197824685a.57.1758265197425;
        Thu, 18 Sep 2025 23:59:57 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836262b5612sm297824585a.3.2025.09.18.23.59.57
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 23:59:57 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78ea15d3489so17539816d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 23:59:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQVrS9mvHHupjjAtfN95A/vAqjCi7GuXQVJlcY2wZwK2nags70fffpiQfQzBy3ka8Aw68iq8l02eibA/ekzjba@vger.kernel.org
X-Received: by 2002:a05:6102:cd4:b0:519:534a:6c24 with SMTP id
 ada2fe7eead31-588f87db47cmr602651137.34.1758264769029; Thu, 18 Sep 2025
 23:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ms6snut0.wl-kuninori.morimoto.gx@renesas.com>
 <87ecs4nult.wl-kuninori.morimoto.gx@renesas.com> <86ikhg13m1.wl-maz@kernel.org>
In-Reply-To: <86ikhg13m1.wl-maz@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Sep 2025 08:52:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVezqWxbFp9dd0WPJnNM+MvmQ9F0UA2Ru_BSV6-6VgOyA@mail.gmail.com>
X-Gm-Features: AS18NWD_Pkgqx7xjtQzxa7XmXgry72f3hJO1WXd7ew0O-6Nznr1kYzKT4iwfWdQ
Message-ID: <CAMuHMdVezqWxbFp9dd0WPJnNM+MvmQ9F0UA2Ru_BSV6-6VgOyA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] arm64: dts: renesas: Add R8A78000 X5H DTs
To: Marc Zyngier <maz@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ian Rogers <irogers@google.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Leo Yan <leo.yan@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Namhyung Kim <namhyung@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Thu, 18 Sept 2025 at 12:01, Marc Zyngier <maz@kernel.org> wrote:
> On Thu, 18 Sep 2025 07:27:26 +0100,
> Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:
> > +             /*
> > +              * The ARM GIC-720AE - View 1
> > +              *
> > +              * see
> > +              *      r19uh0244ej0052-r-carx5h.pdf
> > +              *      - attachments: 002_R-CarX5H_Address_Map_r0p51.xlsx
> > +              *       - sheet [RT]
> > +              *        - line 619
> > +              */
> > +             gic: interrupt-controller@39000000 {
> > +                     compatible = "arm,gic-v3";
> > +                     #interrupt-cells = <3>;
> > +                     #address-cells = <0>;
> > +                     interrupt-controller;
> > +                     reg = <0 0x39000000 0 0x20000>,
> > +                           <0 0x39080000 0 0x800000>;
> > +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
>
> I already asked for:
>
> - this comment to be dropped, as it serves zero purpose to the common
>   mortal

What about using a different comment instead?

    /* Linux must use I/F Region 1 */

I.e. replace "View 1" by the above.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
