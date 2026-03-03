Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F6224B04
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577198; cv=pass; b=bHqfNA0KePR7LG/mvposyIjDRduTNmJZWC4TSeQFMSlDwlO1SRcGyLwX67XLCiJO82cSbgqlYV34wcyuxtJYbId+u7g6SuYYL2FZPtiDAzXTpM6aToa5abrNd+Ir27Kqug2Sbq5z8p7NPsSGHRcvZofdjpkVx5jQCzwqvu06OLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577198; c=relaxed/simple;
	bh=RgpCOXau/MVz6hrYsZejrmK5Ie38uFxJFTDTgu1AX1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3r5eh70ynRxbmteamf9gfUwS8GGNabaFfCHpU5TsVJhSFcA/FqDp3JU83Z4gUwnB2jCvfaEdc3uAMR5bQ9g0S+4KFfNfSVsm6tiVm185tVIdLwuMyBta08ntjoOf9hCrf7DJAsmuxDEvtfEM9iwnyj2URhqyTcLumQUe/tyWF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlDWMOAn; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlDWMOAn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae523d54d2so121765ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 14:33:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772577196; cv=none;
        d=google.com; s=arc-20240605;
        b=hVC7AhdmjYkjTXOm0lewysJcBLgYj8BE5AP7bzoxZxL2K5aS338hlsFdJptPU3vOx6
         u4tX5cUg+K0++pDX97pZhu4hAJAi1CMSWJs/wSsWVqwpZsRrLrmLg+Myr4m5aFqY6IZH
         IXCNlawAS69vWVbjsDhEvMplq4lLVU7ck9XSTn6KyoyM3cyoeywwjeH4wasuhRJHAWXb
         iM6ZDD7maKUOPnsUz+UATTv75ZPNtiA1bK6lq4YYx25FkedKw2oK606nZP9Ohi8NlwCj
         ETL9W4rkFWw4ezFRgI4S4Ksti0xnLsTl/XzpL9kglF0trmtGw40MTK+by9M3s6C53imE
         HCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rNimveAMcGaS3Ehf55J2DhAD0Eib8I30EJF4BTmDkPQ=;
        fh=rewXjbjGvse9vJGT0QX/GzHc8oClLMgqvXUrR+Qr67E=;
        b=RXCOmlKf6yKIbAwpaULkFwMb+0dHLc8D8QWewuxhgudguwcWTrj6PoQdokPZJAq+k/
         JYaHpl/rmhpaGWgqKTjn6ATzM/cHG9b7Fb9gZZBhFzoDnAa/un2QVmWEjvu/8AWUJeqw
         TvPNYMBbCbvqbhwXlGOPbCWazUxm8Ya+R5bp6KC9tCzc9wA5mMJ77lO7o4EJjybj7zp/
         O3VZDGFIjXzyJAcqohEdMCnzXqQqalWuvNfXypaaXZN9R0Lc/tVYkiwILRCoL3hdtJ1R
         ItSuUO+D981ZZFA36oeJ9VbUmeZY5kuGxwyZqCMI/xfTWlLZRQIWXgCdNxTDBVcxhULp
         bMEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772577196; x=1773181996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNimveAMcGaS3Ehf55J2DhAD0Eib8I30EJF4BTmDkPQ=;
        b=GlDWMOAnVpYgTB/fHVkR6TNyUKNtmoKZI5Bmho0is4gxUEOiYt5oortUfwN5o4rxy0
         qtryQwL3OZPyM3u3JP1XRKju3R0NC/C1uI5Ng71JqhOL/GxFEyRf00YK1PVsGB4/UAjI
         u5kpZL2ZK/TpkYrriH1r9urT1xR95DTgqPSQ34P78Zf/Uw8SWJkpV9w09tXOM00VbKRS
         YlJjK/0Vizi+yx3Ijwr4D+beVAX9shr6nKJbG1ypkWkEmfjOFcZVDLz1aR9CeMidzVFJ
         4UmQ5VTq9aWezL57/XE+Q+9Hr4A3POwmYTDJqi3sTzASxRZP0fYcCG8OpfTv5EoUGXLh
         OUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577196; x=1773181996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNimveAMcGaS3Ehf55J2DhAD0Eib8I30EJF4BTmDkPQ=;
        b=W3nbSY3be6aq9W8t4JFlDprx/6iUxUp8Swc1FxJ9lXjWZ4fsowst+l3mOheKuP7LUx
         M+Fproap6or+4VoZWCpAOn61WpMf5HZd/XxxCA7EAJEn2OHl08vJKtNF46c7ySl5Bmsf
         BNzWpSUj/o7TGmXmv2OmkieGPomjZUSD6bPgPGXGD+dVW1djf4flnnbNDK1iZ/jbvruQ
         FIt2RvBva/OcvsHJYsBrGjk3hMzRKu6LH81Cxf323V5s4s1WL8GJ3SaM4P7oSrUH3v0E
         OEA9GnedsYpN5fHxKl/4QPziGdK4bwazEVGweE956ovp9It/PItij5udC3ce4UGAYupr
         PpLg==
X-Forwarded-Encrypted: i=1; AJvYcCWfOiRousjU6Ueq5SU3OjY0viD5VlOrxAQObw28SvT4S56luGQU1KHyZvc0r4f0YOHt9wgjwah/CKANFRTsUc1A@vger.kernel.org
X-Gm-Message-State: AOJu0YxswOTn+5irPLboym+aMzPEdIwCpjV39PtAroLMHXd0pET8rMKc
	rsEKkQMuO/XjOfN8wd9/mnEbWPXiqhcxzOt72xiu6x6y2XB+RHrFozDAzhOpCsTXZNHv52e41cp
	K2bQL9AiPZMnP7aEhLpxh/q0Mqh8kmc1vgKpJUs+6
X-Gm-Gg: ATEYQzxDjyebQIh188fRAfQdQyx5K0QwB2gpZ+xfVT6cgBg1MghBGApCOUAd3LNomDw
	UJCFuZiI8N0+UeBKzfk+f/r2AdMhu0XpVmAozWBCA7tZOrnz7hbddDQh+YSNNFk6oJSvL5xRH97
	kQpLTYTHe6yGB0KmgycgQ5FY7PBRY6ztxxY0e3vjocYrwcQtYecdkx8bSsYTZy0iwrlCKif8rJW
	p5g4TU2v1TrY5IL3cYw0ut0oJUg9GbH8mnjvSCfdC9KmW9mmK3Hf1tOhA6jgK+FP2vFwP71QF6R
	XfIcTiFfUungjAgZAqB+A2wdUSHgZpCM09Esh5R+W6oO2JPS
X-Received: by 2002:a17:902:8696:b0:2ae:45cc:aeb6 with SMTP id
 d9443c01a7336-2ae45ccb0d5mr4641985ad.6.1772577196035; Tue, 03 Mar 2026
 14:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728093153.2330009-1-changqing.li@windriver.com>
 <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
 <ef286bfd-0703-4393-87eb-4b0a85084767@windriver.com> <00dac1a5-16b0-4b54-8525-c0c706f08626@windriver.com>
In-Reply-To: <00dac1a5-16b0-4b54-8525-c0c706f08626@windriver.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Mar 2026 14:33:04 -0800
X-Gm-Features: AaiRm51zmhPEWdH0Q2V4_MdQSD1yHF2zZ5z18XY7PXc5Q-Ms6JbGRzToAELB5Mc
Message-ID: <CAP-5=fUCyYVg-h=YuLy9HRDWzvc7Jm3a9tZM29Bez4R-eTBSOQ@mail.gmail.com>
Subject: Re: [PATCH] tools/build: make in-target rule robust against too long
 argument error
To: Changqing Li <changqing.li@windriver.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@google.com>
Cc: namhyung@kernel.org, james.clark@linaro.org, charlie@rivosinc.com, 
	linux-kernel@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:16=E2=80=AFPM Changqing Li <changqing.li@windrive=
r.com> wrote:
>
> Hi, Ian
>
> Kindly ping.  Could you reproduce it?  Any comments?

Sorry Changqing,

I was reminded by:
https://lore.kernel.org/lkml/20260303211503.165337-1-mmayer@broadcom.com/
that "argument list too long" is a problem for others.

I tried reproducing it, but I think it doesn't fail for me, possibly
because MAX_ARGS is larger on my system:
```
$ xargs --show-limits
Your environment variables take up 6133 bytes
POSIX upper limit on argument length (this system): 2088971
POSIX smallest allowable upper limit on argument length (all systems): 4096
Maximum length of command we could actually use: 2082838
Size of command buffer we are actually using: 131072
Maximum parallelism (--max-procs must be no greater): 2147483647
```

Anyway, the change makes sense to me.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Regards
>
> Changqing
>
> On 8/19/25 11:01, Changqing Li wrote:
> >
> > On 8/19/25 04:38, Ian Rogers wrote:
> >> CAUTION: This email comes from a non Wind River email account!
> >> Do not click links or open attachments unless you recognize the
> >> sender and know the content is safe.
> >>
> >> On Mon, Jul 28, 2025 at 2:31=E2=80=AFAM <changqing.li@windriver.com> w=
rote:
> >>> From: Changqing Li <changqing.li@windriver.com>
> >>>
> >>> The command length of in-target scales with the depth of the director=
y
> >>> times the number of objects in the Makefile. When there are many
> >>> objects, and O=3D[absolute_path] is set, and the absolute_path is
> >>> relatively long. It is possile that this line "$(call
> >>> if_changed,$(host)ld_multi)" will report error:
> >>> "make[4]: /bin/sh: Argument list too long"
> >>>
> >>> For example, build perf tools with O=3D/long/output/path
> >>>
> >>> Like built-in.a and *.mod rules in scripts/Makefile.build, add
> >>> $(objpredix)/ by the shell command instead of by Make's builtin
> >>> function.
> >>>
> >>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> >> Thanks Changqing, the change makes sense to me. The printf is pushing
> >> the values into xargs rather than using $^ with ld. I've tried
> >> reproducing the error to test your fix by creating long directory
> >> names in /tmp and then passing them to O=3D. I've not been able to do
> >> this. Could you send a reproduction for me to test?
> >>
> >> Thanks,
> >> Ian
> >
> > Hi, Ian
> >
> > Thanks. Here is my steps:
> >
> > 1. git clone https://github.com/torvalds/linux.git
> >
> > 2. cd linux/tools/perf/
> >
> > 3. mkdir
> > /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123=
456789012345678901234567890123456789/012345678901234567890123456789/0123456=
7890123456789/012345678901234567890123456789/01234567890123456789012345678/=
9012345678901234567890123456789/012345678901234567890123456789/012345678901=
234567890123456789/01234567890123456789012345678901234567890123456789012345=
678901234567890123/perf-1.0
> >
> > 4.  make NO_LIBTRACEEVENT=3D1
> > O=3D/tmp/01234567890123456789/0123456789012345678901234567890123456789/=
0123456789012345678901234567890123456789/012345678901234567890123456789/012=
34567890123456789/012345678901234567890123456789/01234567890123456789012345=
678/9012345678901234567890123456789/012345678901234567890123456789/01234567=
8901234567890123456789/0123456789012345678901234567890123456789012345678901=
2345678901234567890123/perf-1.0
> >
> >
> > 5. Above step failed with error:
> >
> > make[4]: /bin/sh: Argument list too long
> >
> > make[4]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build
> > <https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7=
zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD6=
88quA73jNugR6IZRxy09Eig$>:148:
> > /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123=
456789012345678901234567890123456789/012345678901234567890123456789/0123456=
7890123456789/012345678901234567890123456789/01234567890123456789012345678/=
9012345678901234567890123456789/012345678901234567890123456789/012345678901=
234567890123456789/01234567890123456789012345678901234567890123456789012345=
678901234567890123/perf-1.0/util/perf-util-in.o]
> > Error 127
> >
> > make[3]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build
> > <https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7=
zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD6=
88quA73jNugR6IZRxy09Eig$>:142:
> > util] Error 2
> >
> > make[2]: *** [Makefile.perf:797:
> > /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123=
456789012345678901234567890123456789/012345678901234567890123456789/0123456=
7890123456789/012345678901234567890123456789/01234567890123456789012345678/=
9012345678901234567890123456789/012345678901234567890123456789/012345678901=
234567890123456789/01234567890123456789012345678901234567890123456789012345=
678901234567890123/perf-1.0/perf-util-in.o]
> > Error 2
> >
> >
> > Regards
> >
> > Changqing
> >>> ---
> >>>   tools/build/Makefile.build | 6 ++++--
> >>>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> >>> index 3584ff308607..39066a3ef2fc 100644
> >>> --- a/tools/build/Makefile.build
> >>> +++ b/tools/build/Makefile.build
> >>> @@ -70,11 +70,13 @@ quiet_cmd_gen =3D GEN     $@
> >>>   # If there's nothing to link, create empty $@ object.
> >>>   quiet_cmd_ld_multi =3D LD      $@
> >>>         cmd_ld_multi =3D $(if $(strip $(obj-y)),\
> >>> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f
> >>> $@; $(AR) rcs $@)
> >>> +                     printf "$(objprefix)%s " $(patsubst
> >>> $(objprefix)%,%,$(filter $(obj-y),$^)) | \
> >>> +                     xargs $(LD) -r -o $@,rm -f $@; $(AR) rcs $@)
> >>>
> >>>   quiet_cmd_host_ld_multi =3D HOSTLD  $@
> >>>         cmd_host_ld_multi =3D $(if $(strip $(obj-y)),\
> >>> -                          $(HOSTLD) -r -o $@  $(filter
> >>> $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
> >>> +                          printf "$(objprefix)%s " $(patsubst
> >>> $(objprefix)%,%,$(filter $(obj-y),$^)) | \
> >>> +                          xargs $(HOSTLD) -r -o $@,rm -f $@;
> >>> $(HOSTAR) rcs $@)
> >>>
> >>>   ifneq ($(filter $(obj),$(hostprogs)),)
> >>>     host =3D host_
> >>> --
> >>> 2.34.1
> >>>
