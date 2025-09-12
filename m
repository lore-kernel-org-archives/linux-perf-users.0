Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4232ED38
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702187; cv=none; b=SD2QbqJxmJUlunOQZGQtE4ZLGvKooY81LXHfMq9fPi+BChBLokJDfEjsPM9h8leorok3ev1qfjg6IWwGzQ3O2nG2TAnQkbhykDTa1K30nx2wDf+EeVqnZs6f/AVHO29zVca8MDp++SXthlUELupXz9kJTy117DDC0DtAWV9SWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702187; c=relaxed/simple;
	bh=mbV8/CSyluDIVmd9Fp3yD7ojFmbhC0rw4VXzMoM47F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBUt7TWb9C1wQ1Nye6gUN9aVjXPi1rqmM3nGQmDdaS/+P/sgchFY6Br1m00S5eJMVIVMkx5RROkPGHyTjtI/uLGx+SdS93W6U+VrcVzvyr+Vr2gaIpcmNvGh/8/lwLJ7nGmgqOfFeqZcvVEBnHVbcGHpo0Gee7SIcJZMJkgXijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8Kjhfev; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8Kjhfev"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b2d018f92so22845ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757702183; x=1758306983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91506rUp766Q/Qa58PPClM2/TZMM9PQcTCACpXMSkn4=;
        b=C8KjhfevZXeBuXQHxciTau8QqK8+qg2nXqrPI6cC+PqfXNg3QHVJZXIQQv3buTKlR+
         SB21M7Xfj0E0AAkOG/WW4MAjI4Te74vE3ryrqG5pclcq8PmILHED6u6fpvyS77ryWKPf
         jsSJJiYQ/ls5fqgEgC6ZnhXUwPzhFXF42h+wMTLP1Alg7BUWdWqwLZJkwLlJJ+df1MF/
         Uy4LcnfqJKLptT64fL/zDX8092iJDdXebNPyZAUUR3trEvsq8lONSutCpNu5spxkpyYu
         yzZTn7Ksma1GdQu7IIN0JRo4ET5pEuiLphfbui0YJwPhWoGICSlVc0BvMVF8b1l2GUW1
         qAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702183; x=1758306983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91506rUp766Q/Qa58PPClM2/TZMM9PQcTCACpXMSkn4=;
        b=gota62X3XI7/lJBUJMMy7jy63IOpgB1G3XX/LmlrtNxVbJrhz/zWqd/BbLFpAG1Y/z
         Ex40WqBueVaRSeatCnapc2alIWOOWaEk/3qi/9WW3wc4EEGUgxVAhWDw/OSzEMBkyJg3
         sdS066DKxFoAVA1VrLqOhaMd2bZoeH4pOKSQRXs6ytl6KrlmjjjsLw8l5Fd5FVL+9uHD
         NH2SEaOQLyefNuJUwJ7c3vfaEnSODoJ/oRH3sbcqCGkntaXWz74X8cKzAnqHrVxLqaV2
         9TbNF5z57daJ7EtFMIebLww8p2iecejFkeWvqZPKo9aE3/6Gk5D9onIhuhW4TpFjaOlz
         NWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/IHj4dOyzh2H5C4c+FlY7o+mA3S+R+V1r2OGe1vdXLV9Y++778o9Gcv9L20gr8peyQ2XqrDQa/i3tT7bhlEoP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8Wc+kVk1H0to+pMQM+TR2ILXNpsRz890P6hSv6br7wIk0PIe
	OcplnPPliq5qVSmzSQlpgWEoPPTPFz+9pYo8F8xQBwdq+Vd4sm1EmLE1Tb0WF/aTrt+4UULTOJ8
	2NvED/2WqZRBYCuJXF4GfQeGwNGdV3B6r9IG0gfyp
X-Gm-Gg: ASbGncuyl86Dw0VkTOJHQhZFpbVctcKPUrMtWPbHmeIzMf38exns4zAKYv2+uHDv0N7
	GOdJjiS2On0XMEac2Xc5wPAY3i69oHJGbmX3Eu33LsvbS7KOTPVD0gAc+8ceYFxOTZpugm5MJyM
	zLWzKv2W55RDWVixW6FB2rQVwfTXigSD4ACp03oXm6t5xxDiCRq1saeHEAsnNT9/ZnCTUH03rJP
	iwSCnuoPTBwY8o=
X-Google-Smtp-Source: AGHT+IEDodyVIzvqOJc5pD//hC9aUKE/67rehiUCcL/W/WQc3DlEvKsmkQ6ZEaNZCx8GBJsoKZO78db29kyCmvIYios=
X-Received: by 2002:a17:902:cf09:b0:249:2f1e:5d0c with SMTP id
 d9443c01a7336-260a3dd2d0bmr130665ad.7.1757702183169; Fri, 12 Sep 2025
 11:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMACaOmneDrG8_pQ@gentoo.org> <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
 <aMAtqNq55TZEuaKn@gentoo.org> <CAP-5=fX-GG_pUH+1Eak8dsoTdNh=vRU+00scBxbRt7EhXZosiw@mail.gmail.com>
 <aMQIydhceXVRORNp@gentoo.org>
In-Reply-To: <aMQIydhceXVRORNp@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Sep 2025 11:36:11 -0700
X-Gm-Features: Ac12FXzFUKG-Mn718UYlwHIDfiriBz0T3mQH5BYTMqTV6wRjSbTe6P3skF9nMyI
Message-ID: <CAP-5=fXwUzjALPpstNgBRo-vV3WG=z5SHeyGTcTAtwcythDTjw@mail.gmail.com>
Subject: Re: Problem with perf report --gtk
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:49=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> On Wed, Sep 10, 2025 at 09:45:35AM -0700, Ian Rogers wrote:
> > On Tue, Sep 9, 2025 at 6:37=E2=80=AFAM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 06:04:42AM -0700, Ian Rogers wrote:
> > > > On Tue, Sep 9, 2025 at 3:33=E2=80=AFAM Guilherme Amadio <amadio@gen=
too.org> wrote:
> > > > >
> > > > > Hi Arnaldo, Namhyung,
> > > > >
> > > > > Since sometime we have a bug in Gentoo's bugzilla about perf repo=
rt --gtk not
> > > > > working=C2=B9: https://bugs.gentoo.org/937869
> > > > >
> > > > > I know this feature is not used very much, but I thought I'd repo=
rt in
> > > > > any case. The problem is easily reproducible as shown below:
> > > > >
> > > > >
> > > > > $ perf record -a -g -- sleep 1
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 1.818 MB perf.data (6648 sample=
s) ]
> > > > > $ LD_DEBUG=3Dsymbols perf report --gtk 2>&1 | grep '(fatal)'
> > > > >     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: sym=
bol lookup error: undefined symbol: hashmap_find (fatal)
> > > > > $ perf report --gtk
> > > > > GTK browser requested but could not find libperf-gtk.so
> > > > >
> > > > > I tried this with perf 6.16, but this bug seems to have been ther=
e since
> > > > > at least 6.12.
> > > > >
> > > > > Please let me know if it's better to file problems at https://bug=
zilla.kernel.org/.
> > > >
> > > > Thanks for letting us know Guilherme! I suspect I broke things when
> > > > trying to fix python things. The code linking libperf-gtk.so is:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n809
> > > > The hashmap symbols are part of the perf-util library:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/perf/util/Build?h=3Dperf-tools-next#n197
> > > > So maybe there needs to be a libbpf -lbpf for your case? Alternativ=
ely
> > > > we may need to reorder the libraries here:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n464
> > > > like:
> > > > PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBP=
ERF_UTIL)
> > > > becomes:
> > > > PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LI=
BPERF_UI)
> > >
> > > Thank you for the suggestion, but just changing the order of linking =
or
> > > linking libbpf doesn't seem to fix the issue. I still see:
> > >
> > > $ nm -D libperf-gtk.so | grep hashmap
> > >                  U hashmap_find
> > >
> > > at the end of the build. The function is in util/hashmap.c, so the
> > > problem might be more involved than just the linking order.
> >
> > Thanks Guilherme! I was able to reproduce the "nm -D" output. Adding
> > "-z defs" to the "$(OUTPUT)libperf-gtk.so" also fails for that symbol,
> > it fails for many more. Even though the symbol is undefined "perf
> > reprt --gtk" works for me. Attaching gdb I see that the symbol is in
> > the perf executable itself. I tried the following change:
> > ```
> >  $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
> > -       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(=
GTK_LIBS)
> > +       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^)
> > $(filter %libperf-util.a,$^) $(GTK_LIBS)
> > ```
> > or
> > ```
> >  $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
> > -       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(=
GTK_LIBS)
> > +       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter
> > %libperf-util.a,$^) $(filter %.o,$^) $(GTK_LIBS)
> > ```
> > but the nm output shows either the same or more undefined symbols, not =
less.
> >
> > I'm wondering if perhaps the hashmap_find symbol is being stripped
> > from the perf executable. Maybe it is an LTO or stripping related
> > thing?
>
> Dear Ian,
>
> I don't see any hashmap symbol as part of my own perf executable:
>
> perf $ pwd && ./perf version
> /home/amadio/src/linux/tools/perf
> perf version 6.16.6.g1037d3a33ba6
> perf $ nm -D ./perf | grep hashmap
> perf $
> I compiled perf with:
>
> $ make -B -j16 V=3D1 WERROR=3D0 NO_SHELLCHECK=3D1 GTK2=3D1

Thanks Guilherme, no good clue why that is different for me. I came up
with this patch to try to include all the symbols from the static
libraries with --whole-archive:
```
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e2150acc2c13..56127c073f47 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -807,7 +807,9 @@ $(GTK_IN): FORCE prepare
       $(Q)$(MAKE) $(build)=3Dgtk

$(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_=
LIBS)
+       $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) \
+               -Wl,--whole-archive $(filter %.a,$^) -Wl,--no-whole-archive=
 \
+               $(filter %.o,$^) $(GTK_LIBS)

$(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt

diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index eef708c502f4..f106d5c884ab 100644
--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -7,8 +7,3 @@ gtk-y +=3D util.o
gtk-y +=3D helpline.o
gtk-y +=3D progress.o
gtk-y +=3D annotate.o
-gtk-y +=3D zalloc.o
-
-$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
-       $(call rule_mkdir)
-       $(call if_changed_dep,cc_o_c)
```
I needed to remove zalloc.o to avoid duplicate symbols. With this
patch I no longer see any hashmap undefined symbols:
```
$ nm /tmp/perf/libperf-gtk.so |grep hashmap
00000000000cc2ca t hashmap_add_entry
00000000000cc4e7 t hashmap__capacity
00000000000cc3dc t hashmap__clear
00000000000cc2f3 t hashmap_del_entry
00000000000cc9fd t hashmap_delete
00000000000cc966 t hashmap_find
00000000000cc6aa t hashmap_find_entry
00000000000cc49c t hashmap__free
00000000000cc54c t hashmap_grow
00000000000cc31d t hashmap__init
00000000000cc773 t hashmap_insert
00000000000cc4f9 t hashmap_needs_to_grow
00000000000cc387 t hashmap__new
00000000000cc4d5 t hashmap__size
00000000001e42b0 t hwmon_pmu__event_hashmap_equal
00000000001e4280 t hwmon_pmu__event_hashmap_hash
$ nm -D /tmp/perf/libperf-gtk.so |grep hashmap
$
```
I briefly tested `perf report --gtk` and under gdb I see the symbol
twice, once in perf and once in libperf-gtk.so. I think this should
resolve your issue, wdyt?

Thanks,
Ian
