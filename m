Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DD30C35F
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144044; cv=pass; b=k8qgljmYjg6yw4dlOFp5ntSAMmXcMxnveG+IToQM1J8a3Lbf1DR7O8w6Q2sl33sHkOKZFuPHSfKI7lBx2Jhx+k9zIPty11e/j4GlRz/IKjj0QN3wE9osvWE4zdMbBw4Tbdnz7/Ai0T3p7sLttdKJyFUG4njwPhL/VGdouGYdHPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144044; c=relaxed/simple;
	bh=QsVI/gsv8ufD9g/OK2Gg+dFq6hitUns33WyqXk2RqcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIXgsNret+Z1ad0cF+WM4/YjnWsO9+pu8XRjwalLAA73DIm1W8sgOeFMnpNluVzgzuu6FW4OJLd6AwlFeJrSaIiBRhlSv4TeBkIaco2NHcXf4KVfjDpt6FNoDwhOJhzqAkkxlbxs2iTR55YJejcsKGeAXpCdw3tzquyIlyJUQVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdgtC71u; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdgtC71u"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b243198058so69715ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 08:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775144042; cv=none;
        d=google.com; s=arc-20240605;
        b=gRCWydlBOMAVOqjZ+o3lhjDCgcjOEHP5SKjrbOhB7OIfM0NeCktLtIc5+Z/nWEdBj8
         B3ympv8XgJmCh1EaOxFSd/AwDNc3g1cUFQCC473hC+e7vi3P+5/b8mPkpfZSS2uXfs0Q
         aWrnUTrA59tzKqcqaiHf/hM1dAG8MU3v124yaw2EUr5J+COZSkB4+sQlHM8xQTTkOz+L
         6Z+lU69sDtRDjz1CvzaXp8+chHJC5O0xE+w9D2W/LxEyJ2kOr6QLh8SeJoH5iZVSE4Pu
         JoGPfewdCBoDhP7XetKJT3I4X/pNm50t7Jbzq1GVjO96zJ82imfXqazGfWog2bVS/sbE
         i8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ExeRyThJfOiH/5CZ20hx8q6xpO7P/GWMpyW50SEXpo=;
        fh=CLSgseJU8bi586JBn0umNTg/4seL7ela6qL2SxS231E=;
        b=GukEyLc9ZbPX9rgkVgKyf7YBIsE/oTLKXvNESutxiSzrvBBvIO0Yk2wI2EZ9JbcNXh
         oT+u5itx+CAgVi0sCnqs1PdMbLjRcuKkbv4JefulhW/Ci18YxdoTJutUj6ErPSMBkfGj
         j7MwMVhXikQLbpLcfK0s1Bk2u04M6cgkrh2WXH1xr7F3ytruR2FwtaKgoF5EbiFs6fND
         QCKMycE629gJethhGzaFxaDTV9UcOaX8XKwYa3AIOjRBxOHYataNK51ZOa3/aqowFzJU
         V56Ya0j+fvIxz+O6OdRyl+aSuVDRoj+WrAVrFCvQDpL/MoiuyNm0bv4FeCSQsyvwobsb
         5frg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775144042; x=1775748842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ExeRyThJfOiH/5CZ20hx8q6xpO7P/GWMpyW50SEXpo=;
        b=TdgtC71u4ztalk9ROhzPGcvD9J1O/9ezJRSVusCeNF35hO7BLvFkq1dtmWMyAsfLsc
         mFxYj9rGJKLLtZNuGPZZLHVC5O98vMkAr8Ia8VRK9PtzLevzXWtiLeJKA5BuGHXF+JyK
         d93WBxVK/i4E5MhStDozQJf6MIFo4y80jfj1Xgp/0pdqUQ+2iHw5NhO3e5eVpcgLESo+
         RIlpjceZ7UvAldEjiv/CvRnp13NS4Ad4gHCf454uvEH8ma4E3lsNIeNH8EciiPBvfObc
         B/7QMdRm2iDWJx0XTGhii6FoUq4H6ii1m0yXo6spy7Z5tyXqQeiyyx9gfy1XfA/0rR00
         pAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144042; x=1775748842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ExeRyThJfOiH/5CZ20hx8q6xpO7P/GWMpyW50SEXpo=;
        b=hV36ONLBUG5Sk/KDSH+8afSygMy7D16rKref7Auwuym0smVGkvfAiXeDCo3S905yuj
         EezggrWHrUke+0MbyQlYe1znsFf2vxSP5AtLfWH4rNFXPF9i+azHpagMApm9z7M8QqbP
         BbOi+VyM69A2SnWnYdCLltGnmO9ouDzMhNSr/0l08h+LBerodkM70RmLMOQdKFWH65KH
         tyehBi/T42CoEqgHhSgVRmNGiSS/Uf5XzBoL0CkRsngA/xGYW4LDvGgwEzI9vh5+2ns4
         7dubtojbAYWPeLvPo6hYmf++woBrXAUbJmdkBUSREDryNmsKdyMxvwo361h5blAMT/j5
         nKfA==
X-Forwarded-Encrypted: i=1; AJvYcCWd6Cy6b3qkGMoFyBVZgI1rO22e4OjLF7rX1QsGlm3bLgiypFEMWLwuug5tSFwmBOqUChmPQNbCjd/+oVvZEW85@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3XDOZC2vEPbhfrwH0/qaIVG1gTAZhOHC4mfNS0/6o51pHa7b
	uN7/0pnAZHWqRu5mMPw8Km78MVKVN/azKKD8+BG2FX4V3ylJuexrkNmAK/thHxKtmf/THxudcZ9
	Qgknsz2aZHs4OqIQFVET+EtUx+M02HoKKwwgGjr3k
X-Gm-Gg: AeBDiev1DdmqactcfzaVRj8P1yJv23k3UvMlJEWytod5u9Dlbmf7ZiVVynaxuXxhzyk
	CQp32arAxCt+Q1az9QRc3gF+tR2z+IplKSzt7BCn2JHEHUy/ev90EEIAnyrcKpadfyjRnMCFFLC
	zF2wNfkWudhZGPLLMWCyQMiMzAIGqk6FS+axMxHOvrxDk3yBrhHZ+hlbohgkIk5U5C7XAg3FBJl
	id980hoC2iCyibD86hu1YG4k66PSnELVdPZBTlS+TI7nYXMIyLRrUsuEkMm85wscPl3qBxLhu8w
	uQ12WMxDbCdizomWq620HNGZtEd+MDZqMkHJ
X-Received: by 2002:a17:902:d2cd:b0:2b2:5931:5950 with SMTP id
 d9443c01a7336-2b2785591e5mr2238815ad.16.1775144041938; Thu, 02 Apr 2026
 08:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401215310.348463-1-suunj1331@gmail.com> <CAP-5=fXbicqGBLjJqYjUvqdmVo2SsLWYgtaQbp=QCPt3uRgsMA@mail.gmail.com>
In-Reply-To: <CAP-5=fXbicqGBLjJqYjUvqdmVo2SsLWYgtaQbp=QCPt3uRgsMA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Apr 2026 08:33:50 -0700
X-Gm-Features: AQROBzBV2RooA0UyzRzMQaBCwcQLVedgsBph0yfPVg9BHLyjBqeLrBsiI2xiAVg
Message-ID: <CAP-5=fXovuB6ghVei27MOJmn4S538fWcWv-=ZS_qsE4duneppg@mail.gmail.com>
Subject: Re: [PATCH v2] perf header: Validate build_id filename length to
 prevent buffer overflow
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, brcampbell@google.com, 
	shuah@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 3:12=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Apr 1, 2026 at 2:53=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com=
> wrote:
> >
> > The build_id parsing functions calculate a filename length from the
> > event header size and read directly into a stack buffer of PATH_MAX
> > bytes without bounds checking. A malformed perf.data file with a
> > crafted header.size can cause the length to be negative or exceed
> > PATH_MAX, resulting in a stack buffer overflow.
> >
> > Add bounds checking for the filename length in both
> > perf_header__read_build_ids() and the ABI quirk variant. Print a
> > warning message when invalid length is detected.
> >
> > Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Sashiko spotted some additional nits:
https://sashiko.dev/#/patchset/20260401215310.348463-1-suunj1331%40gmail.co=
m
printf flags, potential for no '\0' termination and reads of
uninitialized memory.

Thanks,
Ian

> Thanks,
> Ian
>
> > ---
> > v2:
> >  - Add warning message when invalid filename length detected
> > ---
> >  tools/perf/util/header.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 9142a8ba4019..132d360d716a 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2545,6 +2545,11 @@ static int perf_header__read_build_ids_abi_quirk=
(struct perf_header *header,
> >                         perf_event_header__bswap(&old_bev.header);
> >
> >                 len =3D old_bev.header.size - sizeof(old_bev);
> > +               if (len < 0 || len >=3D PATH_MAX) {
> > +                       pr_warning("invalid build_id filename length %d=
\n", len);
> > +                       return -1;
> > +               }
> > +
> >                 if (readn(input, filename, len) !=3D len)
> >                         return -1;
> >
> > @@ -2587,6 +2592,11 @@ static int perf_header__read_build_ids(struct pe=
rf_header *header,
> >                         perf_event_header__bswap(&bev.header);
> >
> >                 len =3D bev.header.size - sizeof(bev);
> > +               if (len < 0 || len >=3D PATH_MAX) {
> > +                       pr_warning("invalid build_id filename length %d=
\n", len);
> > +                       goto out;
> > +               }
> > +
> >                 if (readn(input, filename, len) !=3D len)
> >                         goto out;
> >                 /*
> > --
> > 2.52.0
> >
